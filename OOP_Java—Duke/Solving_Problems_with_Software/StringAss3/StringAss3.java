import edu.duke.*;
import java.io.File;

public class StringAss3 {
    public StorageResource findAllGenes(String dna) {
        StorageResource geneList = new StorageResource();
        int startIndex = 0;
        while (true) {
            String currGene = findGene(dna, startIndex);
            if (currGene.isEmpty()) {
                break;
            }
            geneList.add(currGene);
            startIndex = dna.indexOf(currGene, startIndex) + currGene.length();
        }
        return geneList;
    }

    public String findGene(String dna, int where) {
        int startIndex = dna.indexOf("ATG", where);
        if (startIndex == -1) {
            return "";
        }
        int taaIndex = findStopCodon(dna, "TAA", startIndex);
        int tagIndex = findStopCodon(dna, "TAG", startIndex);
        int tgaIndex = findStopCodon(dna, "TGA", startIndex);
        int minIndex = Math.min(Math.min(taaIndex, tagIndex), tgaIndex);
        if (minIndex == dna.length()) {
            return "";
        }
        else {
            return dna.substring(startIndex, minIndex + 3);
        }
    }

    public int findStopCodon(String dna, String codon, int startIndex) {
        int currIndex = dna.indexOf(codon, startIndex + 3);
        while (currIndex != -1) {
            if ((currIndex - startIndex) % 3 == 0) {
                return currIndex;
            }
            else {
                currIndex = dna.indexOf(codon, currIndex + 1);
            }
        }
        return dna.length();
    }

    public double cgRatio(String dna) {
        double count = countString(dna, "C");
        count = count + countString(dna, "G");
        double ratio = count / dna.length();
        return ratio;
    }

    public double countCTG(String dna) {
        return countString(dna, "CTG");
    }

    public double countString(String dna, String objective) {
        double counter = 0.0;
        int currIndex = dna.indexOf(objective, 0);
        if (currIndex == -1) {
            return 0.0;
        }
        while (currIndex != -1) {
            counter = counter + 1;
            currIndex = dna.indexOf(objective, currIndex + 1);
        }
        return counter;
    }

    public void processGenes(String dna) {
        StorageResource geneList = findAllGenes(dna);
        int countLonger60 = 0;
        int countCG = 0;
        int maxlength = 0;
        StorageResource rsLonger60 = new StorageResource();
        StorageResource rsCG = new StorageResource();
        for (String gene : geneList.data()) {
            if (gene.length() > 60) {
                rsLonger60.add(gene);
                countLonger60 = countLonger60 + 1;
            }
            if (cgRatio(gene) > 0.35) {
                rsCG.add(gene);
                countCG = countCG + 1;
            }
            if (gene.length() > maxlength) {
                maxlength = gene.length();
            }
        }
        System.out.println("Larger than 60");
        for (String gene1 : rsLonger60.data()) {
            System.out.println(gene1);
        }
        System.out.println("Larger than 60 " + countLonger60);
        System.out.println("CGRatio larger than 0.35");
        for (String gene2 : rsCG.data()) {
            System.out.println(gene2);
        }
        System.out.println("CGRatio larger than 0.35 " + countCG);
        System.out.println("Genes " + geneList.size());
        double CTGcount = countCTG(dna);
        System.out.println("CTGCount " + CTGcount);
        System.out.println("maxLength " + maxlength);
    }
    public void testAll() {
        System.out.println("---------------------------------");
        FileResource fr = new FileResource("brca1line.fa");
        String dna = fr.asString();
        dna = dna.toUpperCase();
        //dna = "ATGCCCCCCCCCTAAATGTAAATGAAAAAAAAATAA";
        processGenes(dna);
    }
}
