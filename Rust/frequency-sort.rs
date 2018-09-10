use std::io::{self, BufRead};

/// Custom sort an array of <i32>
///
/// 1) Create a <HashMap> to count the frequencies of each element
/// 2) Create a <BTreeMap> to collect elements of the same frequency. <BTreeMap> is used because
/// order matters when building the result
/// 3) Sort the elements of each frequency, because order matters within each frequency group
/// 4) Create a <Vec> to collect each ordered group of ordered nums ordered by frequency count
fn custom_sort(arr: Vec<i32>) -> Vec<i32> {
    use std::collections::{BTreeMap, HashMap};

    let mut frequencies: HashMap<i32, u32> = HashMap::new();
    let mut groups: BTreeMap<u32, Vec<i32>> = BTreeMap::new();
    let mut result: Vec<i32> = Vec::with_capacity(arr.len());

    // Calculate the frequency of each `num` in `arr`
    for num in arr {
        let frequency = frequencies.entry(num).or_insert(0);
        *frequency += 1
    }

    // Group `num`s by their frequency
    for (num, freq) in frequencies.drain() {
        let group = groups.entry(freq).or_insert(vec![]);
        group.push(num)
    }

    // Sort each `group` of frequencies
    for nums in groups.values_mut() {
        nums.sort()
    }

    // Build custom sorted <Vec> by iterating over each `num` in each `group` of frequencies,
    // `push()`ing `freq` `num`s onto `result`
    for (freq, nums) in groups.iter() {
        for num in nums {
            for _ in 0..*freq {
                result.push(*num)
            }
        }
    }

    result
}

fn main() {
    let stdin = io::stdin();

    let mut arr = vec![];
    let mut cap = 0;
    for (idx, line) in stdin.lock().lines().enumerate() {
        if idx == 0 {
            cap = line.unwrap().parse::<usize>().unwrap();
            arr.reserve_exact(cap);
        } else {
            let num = line.unwrap().parse::<i32>().unwrap();
            arr.push(num);
        }
    }
    arr.resize(cap, Default::default());

    for num in custom_sort(arr) {
        println!("{}", num);
    }
}

#[cfg(test)]
mod tests {
    use super::custom_sort;

    #[test]
    fn test_1() {
        assert_eq!(custom_sort(vec![3, 1, 2, 2, 4]), vec![1, 3, 4, 2, 2])
    }

    #[test]
    fn test_2() {
        assert_eq!(
            custom_sort(vec![8, 5, 5, 5, 5, 1, 1, 1, 4, 4]),
            vec![8, 4, 4, 1, 1, 1, 5, 5, 5, 5]
        )
    }
}
