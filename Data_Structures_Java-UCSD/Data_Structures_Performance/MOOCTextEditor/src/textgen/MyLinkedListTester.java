/**
 * 
 */
package textgen;

import static org.junit.Assert.*;

import java.util.LinkedList;

import org.junit.Before;
import org.junit.Test;

/**
 * @author UC San Diego MOOC team
 *
 */
public class MyLinkedListTester {

	private static final int LONG_LIST_LENGTH =10; 

	MyLinkedList<String> shortList;
	MyLinkedList<Integer> emptyList;
	MyLinkedList<Integer> longerList;
	MyLinkedList<Integer> list1;
	
	/**
	 * @throws java.lang.Exception
	 */
	@Before
	public void setUp() throws Exception {
		// Feel free to use these lists, or add your own
	    shortList = new MyLinkedList<String>();
		shortList.add("A");
		shortList.add("B");
		emptyList = new MyLinkedList<Integer>();
		longerList = new MyLinkedList<Integer>();
		for (int i = 0; i < LONG_LIST_LENGTH; i++)
		{
			longerList.add(i);
		}
		list1 = new MyLinkedList<Integer>();
		list1.add(65);
		list1.add(21);
		list1.add(42);
		
	}

	
	/** Test if the get method is working correctly.
	 */
	/*You should not need to add much to this method.
	 * We provide it as an example of a thorough test. */
	@Test
	public void testGet()
	{
		//test empty list, get should throw an exception
		try {
			emptyList.get(0);
			fail("Check out of bounds");
		}
		catch (IndexOutOfBoundsException e) {
			
		}
		
		// test short list, first contents, then out of bounds
		assertEquals("Check first", "A", shortList.get(0));
		assertEquals("Check second", "B", shortList.get(1));
		
		try {
			shortList.get(-1);
			fail("Check out of bounds");
		}
		catch (IndexOutOfBoundsException e) {
		
		}
		try {
			shortList.get(2);
			fail("Check out of bounds");
		}
		catch (IndexOutOfBoundsException e) {
		
		}
		// test longer list contents
		for(int i = 0; i<LONG_LIST_LENGTH; i++ ) {
			assertEquals("Check "+i+ " element", (Integer)i, longerList.get(i));
		}
		
		// test off the end of the longer array
		try {
			longerList.get(-1);
			fail("Check out of bounds");
		}
		catch (IndexOutOfBoundsException e) {
		
		}
		try {
			longerList.get(LONG_LIST_LENGTH);
			fail("Check out of bounds");
		}
		catch (IndexOutOfBoundsException e) {
		}
		
	}
	
	
	/** Test removing an element from the list.
	 * We've included the example from the concept challenge.
	 * You will want to add more tests.  */
	@Test
	public void testRemove()
	{
		// TODO: Add more tests here
		int a = list1.remove(0);
		assertEquals("Remove: check a is correct ", 65, a);
		assertEquals("Remove: check element 0 is correct ", (Integer)21, list1.get(0));
		assertEquals("Remove: check size is correct ", 2, list1.size());
		
		try {
			list1.remove(-2);
			fail("Index too low");
		} catch (IndexOutOfBoundsException e) {}
		
		try {
			list1.remove(100);
			fail("Index too high");
		} catch (IndexOutOfBoundsException e) {}
		
		
		
	}
	
	/** Test adding an element into the end of the list, specifically
	 *  public boolean add(E element)
	 * */
	@Test
	public void testAddEnd()
	{
        // TODO: implement this test
		int prev_size = list1.size();
		list1.add(3);
		assertEquals("AddEnd: check last element is correct ", (Integer)3, list1.get(prev_size));
		assertEquals("AddEnd: check size is correct ", prev_size + (Integer)1, list1.size());
		
	}

	
	/** Test the size of the list */
	@Test
	public void testSize()
	{
		// TODO: implement this test
		int size = list1.size();
		list1.add(34);
		assertEquals("Size: is bigger after adding at end", size + (Integer)1, list1.size());
		size = list1.size();
		list1.add(2,5);
		assertEquals("Size: is bigger after adding at index", size + (Integer)1, list1.size());
		size = list1.size();
		list1.remove(2);
		assertEquals("Size: is lower after removing", size - (Integer)1, list1.size());
	}

	
	
	/** Test adding an element into the list at a specified index,
	 * specifically:
	 * public void add(int index, E element)
	 * */
	@Test
	public void testAddAtIndex()
	{
        // TODO: implement this test
		int prev_size = list1.size();
		list1.add(1, 21);
		assertEquals("AddAtIndex: check element is added in correct index ", (Integer)21, list1.get(1));
		assertEquals("AddAtIndex: check size is correct ", prev_size + (Integer)1, list1.size());
		
		try {
			list1.add(-2, 0);
			fail("Index too low");
		} catch (IndexOutOfBoundsException e) {}
		
		try {
			list1.add(100, 0);
			fail("Index too high");
		} catch (IndexOutOfBoundsException e) {}
		
		try {
			list1.add(0, null);
			fail("Object cannot be null");
		} catch (NullPointerException e) {}
		
		
	}
	
	/** Test setting an element in the list */
	@Test
	public void testSet()
	{
	    // TODO: implement this test
		int prev_size = list1.size();
		list1.set(1, 31);
		assertEquals("Set: check element is added in correct index ", (Integer)31, list1.get(1));
		assertEquals("Set: check size does not change ", prev_size, list1.size());
		
		try {
			list1.set(-2, 0);
			fail("Index too low");
		} catch (IndexOutOfBoundsException e) {}
		
		try {
			list1.set(100, 0);
			fail("Index too high");
		} catch (IndexOutOfBoundsException e) {}
		
		try {
			list1.set(0, null);
			fail("Object cannot be null");
		} catch (NullPointerException e) {}
	    
	}
	
	
	// TODO: Optionally add more test methods.
	
}
