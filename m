Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6B155D63A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbiF1EdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 00:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbiF1EdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 00:33:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF0F219F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 21:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656390787; x=1687926787;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CjqY2Cc7+eTSR4WL/XgNqZOEMefA0A+cGH8m69MBpq8=;
  b=elOzhybFWPftrDgp8KHslySkk1J49xO1OPEupYXtl+rQqc0z6DfK6s2Q
   Lf7Nqq7Xn2y09Lnf6EOBuZIu8JIXvH4BcZ7OWJOQq4x7rbust5kTBgGYV
   HwhOW2TSe1XvDjkuD+4n4R/IzvOITkTa7V/bX4Kd9xdbmiZba/0+SR6km
   6GSLCYVT8ibESFe02xtJtUXQp6H+Eu52oGu/1Xjs1shtJMQyuqYRckOPa
   HNs4qT+T8RI1ytQEQxOC4O1KUrwTwrGheka0eJkI3EQXQBfY8C+pGKpmy
   gIb79kZ8oF5CWaq8EtM9yEIe7AqzHZh6oDnc4LTa9A7a/AYhN3TEKYLHG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343319285"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343319285"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="917009607"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jun 2022 21:33:05 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o62uO-0009VY-PG;
        Tue, 28 Jun 2022 04:33:04 +0000
Date:   Tue, 28 Jun 2022 12:32:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: fs/btrfs/extent_io.c:5966:7: warning: Local variable 'ret' shadows
 outer variable [shadowVariable]
Message-ID: <202206281220.35xiz7jb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   941e3e7912696b9fbe3586083a7c2e102cee7a87
commit: dd137dd1f2d719682b522d4eabe6dec461b7d6fa btrfs: factor out allocating an array of pages
date:   6 weeks ago
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
        # apt-get install cppcheck
        git checkout dd137dd1f2d719682b522d4eabe6dec461b7d6fa
        cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> fs/ext4/resize.c:383:7: warning: Local variable 'i' shadows outer variable [shadowVariable]
     int i;
         ^
   fs/ext4/resize.c:299:6: note: Shadowed declaration
    int i;
        ^
   fs/ext4/resize.c:383:7: note: Shadow variable
     int i;
         ^
>> fs/btrfs/extent_io.c:5966:7: warning: Local variable 'ret' shadows outer variable [shadowVariable]
     int ret;
         ^
   fs/btrfs/extent_io.c:5945:6: note: Shadowed declaration
    int ret;
        ^
   fs/btrfs/extent_io.c:5966:7: note: Shadow variable
     int ret;
         ^
>> fs/btrfs/inode.c:1004:13: warning: Local variable 'start' shadows outer variable [shadowVariable]
     const u64 start = async_extent->start;
               ^
   fs/btrfs/inode.c:926:6: note: Shadowed declaration
    u64 start = async_extent->start;
        ^
   fs/btrfs/inode.c:1004:13: note: Shadow variable
     const u64 start = async_extent->start;
               ^
>> fs/btrfs/inode.c:1005:13: warning: Local variable 'end' shadows outer variable [shadowVariable]
     const u64 end = start + async_extent->ram_size - 1;
               ^
   fs/btrfs/inode.c:927:6: note: Shadowed declaration
    u64 end = async_extent->start + async_extent->ram_size - 1;
        ^
   fs/btrfs/inode.c:1005:13: note: Shadow variable
     const u64 end = start + async_extent->ram_size - 1;
               ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> fs/exfat/namei.c:225:6: warning: Using argument hint_femp that points at uninitialized variable hint_femp [ctuuninitvar]
    if (hint_femp->eidx != EXFAT_HINT_NONE) {
        ^
   fs/exfat/namei.c:334:42: note: Calling function exfat_search_empty_slot, 2nd argument is uninitialized
    while ((dentry = exfat_search_empty_slot(sb, &hint_femp, p_dir,
                                            ^
   fs/exfat/namei.c:225:6: note: Using argument hint_femp
    if (hint_femp->eidx != EXFAT_HINT_NONE) {
        ^
--
>> fs/ext4/resize.c:677:46: warning: The address of local variable 'block_bitmap' might be accessed at non-zero index. [objectIndex]
      if (block == (&group_data[i].block_bitmap)[j]) {
                                                ^
   fs/ext4/resize.c:677:18: note: Address of variable taken here.
      if (block == (&group_data[i].block_bitmap)[j]) {
                    ^
   fs/ext4/resize.c:677:46: note: The address of local variable 'block_bitmap' might be accessed at non-zero index.
      if (block == (&group_data[i].block_bitmap)[j]) {
                                                ^
   fs/ext4/resize.c:690:41: warning: The address of local variable 'block_bitmap' might be accessed at non-zero index. [objectIndex]
      start = (&group_data[i].block_bitmap)[j];
                                           ^
   fs/ext4/resize.c:690:13: note: Address of variable taken here.
      start = (&group_data[i].block_bitmap)[j];
               ^
   fs/ext4/resize.c:690:41: note: The address of local variable 'block_bitmap' might be accessed at non-zero index.
      start = (&group_data[i].block_bitmap)[j];
                                           ^
>> fs/ext4/resize.c:515:6: warning: Variable 'group_table_count' can be declared with const [constVariable]
    int group_table_count[] = {1, 1, EXT4_SB(sb)->s_itb_per_group};
        ^
>> fs/ext4/ext4.h:593:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4.h:593:2: warning: Signed integer overflow for expression '1<<EXT4_INODE_RESERVED'. [integerOverflow]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4_jbd2.h:402:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
    return ext4_journal_ensure_credits_fn(handle, credits, credits,
           ^
>> fs/ext4/resize.c:427:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
    return ext4_journal_ensure_credits_fn(handle, credits,
           ^
>> fs/ext4/resize.c:929:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(sb, err);
     ^
   fs/ext4/resize.c:928:6: note: outer condition: err
    if (err)
        ^
   fs/ext4/resize.c:929:3: note: identical inner condition: err
     ext4_std_error(sb, err);
     ^
   fs/ext4/resize.c:1342:4: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
      ext4_std_error(sb, err);
      ^
   fs/ext4/resize.c:1341:7: note: outer condition: err
     if (err) {
         ^
   fs/ext4/resize.c:1342:4: note: identical inner condition: err
      ext4_std_error(sb, err);
      ^
   fs/ext4/resize.c:1921:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(sb, err);
     ^
   fs/ext4/resize.c:1920:6: note: outer condition: err
    if (err) {
        ^
   fs/ext4/resize.c:1921:3: note: identical inner condition: err
     ext4_std_error(sb, err);
     ^
   fs/ext4/resize.c:1935:4: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
      ext4_std_error(sb, err);
      ^
   fs/ext4/resize.c:1934:7: note: outer condition: err
     if (err)
         ^
   fs/ext4/resize.c:1935:4: note: identical inner condition: err
      ext4_std_error(sb, err);
      ^
>> fs/ext4/xattr.c:180:35: warning: Either the condition 'name_index>0' is redundant or the array 'ext4_xattr_handler_map[11]' is accessed at index 11, which is out of bounds. [arrayIndexOutOfBoundsCond]
     handler = ext4_xattr_handler_map[name_index];
                                     ^
   fs/ext4/xattr.c:179:17: note: Assuming that condition 'name_index>0' is not redundant
    if (name_index > 0 && name_index < ARRAY_SIZE(ext4_xattr_handler_map))
                   ^
   fs/ext4/xattr.c:180:35: note: Array index out of bounds
     handler = ext4_xattr_handler_map[name_index];
                                     ^
>> fs/ext4/xattr.h:156:70: warning: Parameter 'save' can be declared with const [constParameter]
   static inline void ext4_write_unlock_xattr(struct inode *inode, int *save)
                                                                        ^
>> fs/ext4/xattr.c:185:64: warning: Parameter 'end' can be declared with const [constParameter]
   ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
                                                                  ^
   fs/ext4/xattr.c:284:10: warning: Parameter 'end' can be declared with const [constParameter]
      void *end, int name_index, const char *name, int sorted)
            ^
>> fs/ext4/xattr.c:1313:33: warning: Parameter 'base' can be declared with const [constParameter]
           size_t *min_offs, void *base, int *total)
                                   ^
>> fs/ext4/ext4.h:593:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4.h:593:2: warning: Signed integer overflow for expression '1<<EXT4_INODE_RESERVED'. [integerOverflow]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4_jbd2.h:402:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
    return ext4_journal_ensure_credits_fn(handle, credits, credits,
           ^
>> fs/ext4/xattr.c:1163:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
     err = ext4_journal_ensure_credits_fn(handle, credits, credits,
           ^
>> fs/ext4/xattr.h:156:70: warning: Parameter 'save' can be declared with const [constParameter]
   static inline void ext4_write_unlock_xattr(struct inode *inode, int *save)
                                                                        ^
>> fs/ext4/namei.c:1253:51: warning: Parameter 'hinfo' can be declared with const [constParameter]
            unsigned blocksize, struct dx_hash_info *hinfo,
                                                     ^
>> fs/ext4/namei.c:3564:67: warning: Parameter 'ent' can be declared with const [constParameter]
   static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
                                                                     ^
>> fs/ext4/ext4.h:593:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4.h:593:2: warning: Signed integer overflow for expression '1<<EXT4_INODE_RESERVED'. [integerOverflow]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4_jbd2.h:402:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
    return ext4_journal_ensure_credits_fn(handle, credits, credits,
           ^
>> fs/ext4/namei.c:77:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(inode->i_sb, err);
     ^
   fs/ext4/namei.c:75:6: note: outer condition: err
    if (err) {
        ^
   fs/ext4/namei.c:77:3: note: identical inner condition: err
     ext4_std_error(inode->i_sb, err);
     ^
   fs/ext4/namei.c:2118:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(dir->i_sb, err);
     ^
   fs/ext4/namei.c:2117:6: note: outer condition: err
    if (err) {
        ^
   fs/ext4/namei.c:2118:3: note: identical inner condition: err
     ext4_std_error(dir->i_sb, err);
     ^
   fs/ext4/namei.c:2143:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(dir->i_sb, err);
     ^
   fs/ext4/namei.c:2142:6: note: outer condition: err
    if (err)
        ^
   fs/ext4/namei.c:2143:3: note: identical inner condition: err
     ext4_std_error(dir->i_sb, err);
     ^
   fs/ext4/namei.c:2177:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(dir->i_sb, retval);
     ^
   fs/ext4/namei.c:2176:6: note: outer condition: retval
    if (retval) {
        ^
   fs/ext4/namei.c:2177:3: note: identical inner condition: retval
     ext4_std_error(dir->i_sb, retval);
     ^
   fs/ext4/namei.c:3530:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(ent->dir->i_sb, retval);
     ^
   fs/ext4/namei.c:3529:6: note: outer condition: retval
    if (retval) {
        ^
   fs/ext4/namei.c:3530:3: note: identical inner condition: retval
     ext4_std_error(ent->dir->i_sb, retval);
     ^
   fs/ext4/namei.c:3581:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(old.dir->i_sb, retval);
     ^
   fs/ext4/namei.c:3580:6: note: outer condition: retval
    if (retval) {
        ^
   fs/ext4/namei.c:3581:3: note: identical inner condition: retval
     ext4_std_error(old.dir->i_sb, retval);
     ^
>> fs/ext4/namei.c:747:28: warning: Parameter 'target' can be declared with const [constParameter]
             struct dx_entry *target,
                              ^
   fs/ext4/namei.c:623:26: warning: Parameter 'hinfo' can be declared with const [constParameter]
       struct dx_hash_info *hinfo,
                            ^
>> fs/btrfs/file.c:443:64: warning: Parameter 'pages' can be declared with const [constParameter]
   int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
                                                                  ^
>> fs/btrfs/tree-log.h:52:28: warning: Uninitialized variables: ordered.file_offset, ordered.num_bytes, ordered.ram_bytes, ordered.disk_bytenr, ordered.disk_num_bytes, ordered.offset, ordered.bytes_left, ordered.outstanding_isize, ordered.truncated_len, ordered.flags, ordered.compress_type, ordered.qgroup_rsv, ordered.refs, ordered.inode, ordered.list, ordered.wait, ordered.rb_node, ordered.root_extent_list, ordered.work, ordered.completion, ordered.flush_work, ordered.work_list, ordered.physical, ordered.bdev [uninitvar]
     btrfs_put_ordered_extent(ordered);
                              ^
>> fs/btrfs/file.c:66:6: warning: Using argument defrag1 that points at uninitialized variable tmp [ctuuninitvar]
    if (defrag1->root > defrag2->root)
        ^
   fs/btrfs/file.c:216:38: note: Calling function __compare_inode_defrag, 1st argument is uninitialized
    if (parent && __compare_inode_defrag(&tmp, entry) > 0) {
                                        ^
   fs/btrfs/file.c:66:6: note: Using argument defrag1
    if (defrag1->root > defrag2->root)
        ^
>> fs/ext4/xattr.h:156:70: warning: Parameter 'save' can be declared with const [constParameter]
   static inline void ext4_write_unlock_xattr(struct inode *inode, int *save)
                                                                        ^
>> fs/ext4/ext4.h:593:2: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4.h:593:2: warning: Signed integer overflow for expression '1<<EXT4_INODE_RESERVED'. [integerOverflow]
    CHECK_FLAG_VALUE(RESERVED);
    ^
>> fs/ext4/ext4_jbd2.h:402:9: warning: Variable '__ensure_end' is not assigned a value. [unassignedVariable]
    return ext4_journal_ensure_credits_fn(handle, credits, credits,
           ^
>> fs/ext4/inode.c:5530:3: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     ext4_std_error(inode->i_sb, error);
     ^
   fs/ext4/inode.c:5529:7: note: outer condition: error
    if  (error)
         ^
   fs/ext4/inode.c:5530:3: note: identical inner condition: error
     ext4_std_error(inode->i_sb, error);
     ^
>> fs/btrfs/extent_io.c:369:26: warning: Parameter 'p_in' can be declared with const [constParameter]
          struct rb_node ***p_in,
                            ^
>> fs/btrfs/extent_io.c:370:25: warning: Parameter 'parent_in' can be declared with const [constParameter]
          struct rb_node **parent_in)
                           ^
>> fs/btrfs/extent_io.c:1823:30: warning: Parameter 'mapping' can be declared with const [constParameter]
          struct address_space *mapping,
                                ^
>> fs/btrfs/extent_io.c:1824:40: warning: Parameter 'locked_page' can be declared with const [constParameter]
          struct page *page, struct page *locked_page,
                                          ^
>> fs/btrfs/extent_io.c:6066:16: warning: Parameter 'accessed' can be declared with const [constParameter]
     struct page *accessed)
                  ^
>> fs/btrfs/inode.c:2188:21: warning: Parameter 'bits' can be declared with const [constParameter]
             unsigned *bits)
                       ^
   fs/btrfs/inode.c:2239:44: warning: Parameter 'bits' can be declared with const [constParameter]
        struct extent_state *state, unsigned *bits)
                                              ^
>> fs/btrfs/inode.c:256:19: warning: Parameter 'compressed_pages' can be declared with const [constParameter]
       struct page **compressed_pages,
                     ^
>> fs/btrfs/inode.c:5944:70: warning: Parameter 'now' can be declared with const [constParameter]
   static int btrfs_update_time(struct inode *inode, struct timespec64 *now,
                                                                        ^
>> fs/btrfs/tree-log.h:52:28: warning: Uninitialized variables: ordered.file_offset, ordered.num_bytes, ordered.ram_bytes, ordered.disk_bytenr, ordered.disk_num_bytes, ordered.offset, ordered.bytes_left, ordered.outstanding_isize, ordered.truncated_len, ordered.flags, ordered.compress_type, ordered.qgroup_rsv, ordered.refs, ordered.inode, ordered.list, ordered.wait, ordered.rb_node, ordered.root_extent_list, ordered.work, ordered.completion, ordered.flush_work, ordered.work_list, ordered.physical, ordered.bdev [uninitvar]
     btrfs_put_ordered_extent(ordered);
                              ^
>> fs/btrfs/inode.c:2605:16: warning: Uninitialized variable: sum->bytenr [uninitvar]
             sum->bytenr);
                  ^

vim +/ret +5966 fs/btrfs/extent_io.c

  5939	
  5940	struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
  5941	{
  5942		int i;
  5943		struct extent_buffer *new;
  5944		int num_pages = num_extent_pages(src);
  5945		int ret;
  5946	
  5947		new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
  5948		if (new == NULL)
  5949			return NULL;
  5950	
  5951		/*
  5952		 * Set UNMAPPED before calling btrfs_release_extent_buffer(), as
  5953		 * btrfs_release_extent_buffer() have different behavior for
  5954		 * UNMAPPED subpage extent buffer.
  5955		 */
  5956		set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
  5957	
  5958		memset(new->pages, 0, sizeof(*new->pages) * num_pages);
  5959		ret = btrfs_alloc_page_array(num_pages, new->pages);
  5960		if (ret) {
  5961			btrfs_release_extent_buffer(new);
  5962			return NULL;
  5963		}
  5964	
  5965		for (i = 0; i < num_pages; i++) {
> 5966			int ret;
  5967			struct page *p = new->pages[i];
  5968	
  5969			ret = attach_extent_buffer_page(new, p, NULL);
  5970			if (ret < 0) {
  5971				btrfs_release_extent_buffer(new);
  5972				return NULL;
  5973			}
  5974			WARN_ON(PageDirty(p));
  5975			copy_page(page_address(p), page_address(src->pages[i]));
  5976		}
  5977		set_extent_buffer_uptodate(new);
  5978	
  5979		return new;
  5980	}
  5981	
  5982	struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
  5983							  u64 start, unsigned long len)
  5984	{
  5985		struct extent_buffer *eb;
  5986		int num_pages;
  5987		int i;
  5988		int ret;
  5989	
  5990		eb = __alloc_extent_buffer(fs_info, start, len);
  5991		if (!eb)
  5992			return NULL;
  5993	
  5994		num_pages = num_extent_pages(eb);
  5995		ret = btrfs_alloc_page_array(num_pages, eb->pages);
  5996		if (ret)
  5997			goto err;
  5998	
  5999		for (i = 0; i < num_pages; i++) {
  6000			struct page *p = eb->pages[i];
  6001	
  6002			ret = attach_extent_buffer_page(eb, p, NULL);
  6003			if (ret < 0)
  6004				goto err;
  6005		}
  6006	
  6007		set_extent_buffer_uptodate(eb);
  6008		btrfs_set_header_nritems(eb, 0);
  6009		set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
  6010	
  6011		return eb;
  6012	err:
  6013		for (i = 0; i < num_pages; i++) {
  6014			if (eb->pages[i]) {
  6015				detach_extent_buffer_page(eb, eb->pages[i]);
  6016				__free_page(eb->pages[i]);
  6017			}
  6018		}
  6019		__free_extent_buffer(eb);
  6020		return NULL;
  6021	}
  6022	
  6023	struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
  6024							u64 start)
  6025	{
  6026		return __alloc_dummy_extent_buffer(fs_info, start, fs_info->nodesize);
  6027	}
  6028	
  6029	static void check_buffer_tree_ref(struct extent_buffer *eb)
  6030	{
  6031		int refs;
  6032		/*
  6033		 * The TREE_REF bit is first set when the extent_buffer is added
  6034		 * to the radix tree. It is also reset, if unset, when a new reference
  6035		 * is created by find_extent_buffer.
  6036		 *
  6037		 * It is only cleared in two cases: freeing the last non-tree
  6038		 * reference to the extent_buffer when its STALE bit is set or
  6039		 * calling releasepage when the tree reference is the only reference.
  6040		 *
  6041		 * In both cases, care is taken to ensure that the extent_buffer's
  6042		 * pages are not under io. However, releasepage can be concurrently
  6043		 * called with creating new references, which is prone to race
  6044		 * conditions between the calls to check_buffer_tree_ref in those
  6045		 * codepaths and clearing TREE_REF in try_release_extent_buffer.
  6046		 *
  6047		 * The actual lifetime of the extent_buffer in the radix tree is
  6048		 * adequately protected by the refcount, but the TREE_REF bit and
  6049		 * its corresponding reference are not. To protect against this
  6050		 * class of races, we call check_buffer_tree_ref from the codepaths
  6051		 * which trigger io after they set eb->io_pages. Note that once io is
  6052		 * initiated, TREE_REF can no longer be cleared, so that is the
  6053		 * moment at which any such race is best fixed.
  6054		 */
  6055		refs = atomic_read(&eb->refs);
  6056		if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
  6057			return;
  6058	
  6059		spin_lock(&eb->refs_lock);
  6060		if (!test_and_set_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
  6061			atomic_inc(&eb->refs);
  6062		spin_unlock(&eb->refs_lock);
  6063	}
  6064	
  6065	static void mark_extent_buffer_accessed(struct extent_buffer *eb,
> 6066			struct page *accessed)
  6067	{
  6068		int num_pages, i;
  6069	
  6070		check_buffer_tree_ref(eb);
  6071	
  6072		num_pages = num_extent_pages(eb);
  6073		for (i = 0; i < num_pages; i++) {
  6074			struct page *p = eb->pages[i];
  6075	
  6076			if (p != accessed)
  6077				mark_page_accessed(p);
  6078		}
  6079	}
  6080	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
