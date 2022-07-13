Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF60573A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiGMP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbiGMP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:27:44 -0400
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCFE34D15F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=T5vw+
        UNQnzw+ElA+/Jw4T4rklXt+3JjPCKZccbq6kcQ=; b=RgRPsyDuTtVXZR8GWUKC/
        6QQNhrLXERFBiRWoPBu0Z6+RYgBWkxwt0zrNmUsvrPlN0Np77nKa3pAxVBDITEaP
        gmSoBGcEh3zkwXuAUg3oq8fF/S0JOKDaV496Ow7htL6H5pLNsfUNtxFvJJDbuZsW
        T+VUlomGzCAAJgH3wdPvA4=
Received: from localhost.localdomain (unknown [113.246.106.84])
        by smtp14 (Coremail) with SMTP id EsCowADXfQY15M5infQKMw--.22051S2;
        Wed, 13 Jul 2022 23:26:46 +0800 (CST)
From:   iamwjia@163.com
To:     dushistov@mail.ru, linux-kernel@vger.kernel.org
Cc:     Wang Jia <iamwjia@163.com>, Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH -next] ufs: Delete extra space or tab indent
Date:   Wed, 13 Jul 2022 23:26:43 +0800
Message-Id: <20220713152643.51605-1-iamwjia@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADXfQY15M5infQKMw--.22051S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfCFy8KF48GrW5tw17tFW7XFb_yoW5GrWxGo
        WxJan7Ww48Wr15Ga98C348G34DZ3yYkF4rJ34rCr98uw1DKw47u34Sgw1UZa4rurWFgF9x
        C3sFqa95XFWvvw4kn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRr-BHUUUUU
X-Originating-IP: [113.246.106.84]
X-CM-SenderInfo: pldp4ylld6il2tof0z/1tbiFRc94F5mLxRhqwAAsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Jia <iamwjia@163.com>

Delete extra space or tab indent in {.c} file.
This warnings are reported and fixed by a tool named "Hacash Robot".

Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: Wang Jia <iamwjia@163.com>
---
 fs/ufs/balloc.c   | 90 +++++++++++++++++++++++------------------------
 fs/ufs/cylinder.c | 14 ++++----
 fs/ufs/dir.c      |  2 +-
 fs/ufs/file.c     |  2 +-
 fs/ufs/ialloc.c   | 16 ++++-----
 fs/ufs/namei.c    |  4 +--
 fs/ufs/super.c    | 70 ++++++++++++++++++------------------
 fs/ufs/util.c     | 12 +++----
 8 files changed, 105 insertions(+), 105 deletions(-)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 075d3d9114c8..f95ca3e054eb 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -44,27 +44,27 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, bit, end_bit, bbase, blkmap, i;
 	u64 blkno;
-	
+
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	
+
 	UFSD("ENTER, fragment %llu, count %u\n",
 	     (unsigned long long)fragment, count);
-	
+
 	if (ufs_fragnum(fragment) + count > uspi->s_fpg)
 		ufs_error (sb, "ufs_free_fragments", "internal error");
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-	
+
 	cgno = ufs_dtog(uspi, fragment);
 	bit = ufs_dtogd(uspi, fragment);
 	if (cgno >= uspi->s_ncg) {
 		ufs_panic (sb, "ufs_free_fragments", "freeing blocks are outside device");
 		goto failed;
 	}
-		
+
 	ucpi = ufs_load_cylinder (sb, cgno);
-	if (!ucpi) 
+	if (!ucpi)
 		goto failed;
 	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
@@ -79,7 +79,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 	for (i = bit; i < end_bit; i++) {
 		if (ubh_isclr (UCPI_UBH(ucpi), ucpi->c_freeoff, i))
 			ubh_setbit (UCPI_UBH(ucpi), ucpi->c_freeoff, i);
-		else 
+		else
 			ufs_error (sb, "ufs_free_fragments",
 				   "bit already cleared for fragment %u", i);
 	}
@@ -112,7 +112,7 @@ void ufs_free_fragments(struct inode *inode, u64 fragment, unsigned count)
 			fs32_add(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 		}
 	}
-	
+
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & SB_SYNCHRONOUS)
@@ -140,13 +140,13 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	struct ufs_cylinder_group * ucg;
 	unsigned overflow, cgno, bit, end_bit, i;
 	u64 blkno;
-	
+
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 
 	UFSD("ENTER, fragment %llu, count %u\n",
 	     (unsigned long long)fragment, count);
-	
+
 	if ((fragment & uspi->s_fpbmask) || (count & uspi->s_fpbmask)) {
 		ufs_error (sb, "ufs_free_blocks", "internal error, "
 			   "fragment %llu, count %u\n",
@@ -155,7 +155,7 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	}
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-	
+
 do_more:
 	overflow = 0;
 	cgno = ufs_dtog(uspi, fragment);
@@ -172,7 +172,7 @@ void ufs_free_blocks(struct inode *inode, u64 fragment, unsigned count)
 	}
 
 	ucpi = ufs_load_cylinder (sb, cgno);
-	if (!ucpi) 
+	if (!ucpi)
 		goto failed_unlock;
 	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
 	if (!ufs_cg_chkmagic(sb, ucg)) {
@@ -350,11 +350,11 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	struct ufs_super_block_first * usb1;
 	unsigned cgno, oldcount, newcount;
 	u64 tmp, request, result;
-	
+
 	UFSD("ENTER, ino %lu, fragment %llu, goal %llu, count %u\n",
 	     inode->i_ino, (unsigned long long)fragment,
 	     (unsigned long long)goal, count);
-	
+
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
@@ -367,7 +367,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		ufs_warning(sb, "ufs_new_fragments", "internal warning"
 			    " fragment %llu, count %u",
 			    (unsigned long long)fragment, count);
-		count = uspi->s_fpb - ufs_fragnum(fragment); 
+		count = uspi->s_fpb - ufs_fragnum(fragment);
 	}
 	oldcount = ufs_fragnum (fragment);
 	newcount = oldcount + count;
@@ -409,13 +409,13 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 		}
 	}
 
-	if (goal >= uspi->s_size) 
+	if (goal >= uspi->s_size)
 		goal = 0;
-	if (goal == 0) 
+	if (goal == 0)
 		cgno = ufs_inotocg (inode->i_ino);
 	else
 		cgno = ufs_dtog(uspi, goal);
-	 
+
 	/*
 	 * allocate new fragment
 	 */
@@ -489,7 +489,7 @@ u64 ufs_new_fragments(struct inode *inode, void *p, u64 fragment,
 	mutex_unlock(&UFS_SB(sb)->s_lock);
 	UFSD("EXIT (FAILED)\n");
 	return 0;
-}		
+}
 
 static bool try_add_frags(struct inode *inode, unsigned frags)
 {
@@ -513,14 +513,14 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned cgno, fragno, fragoff, count, fragsize, i;
-	
+
 	UFSD("ENTER, fragment %llu, oldcount %u, newcount %u\n",
 	     (unsigned long long)fragment, oldcount, newcount);
-	
+
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 	count = newcount - oldcount;
-	
+
 	cgno = ufs_dtog(uspi, fragment);
 	if (fs32_to_cpu(sb, UFS_SB(sb)->fs_cs(cgno).cs_nffree) < count)
 		return 0;
@@ -564,7 +564,7 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
 	uspi->cs_total.cs_nffree -= count;
-	
+
 	ubh_mark_buffer_dirty (USPI_UBH(uspi));
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & SB_SYNCHRONOUS)
@@ -572,7 +572,7 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 	ufs_mark_sb_dirty(sb);
 
 	UFSD("EXIT, fragment %llu\n", (unsigned long long)fragment);
-	
+
 	return fragment;
 }
 
@@ -582,7 +582,7 @@ static u64 ufs_add_fragments(struct inode *inode, u64 fragment,
 		goto cg_found; \
 	for (k = count; k < uspi->s_fpb; k++) \
 		if (fs32_to_cpu(sb, ucg->cg_frsum[k])) \
-			goto cg_found; 
+			goto cg_found;
 
 static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 			       u64 goal, unsigned count, int *err)
@@ -593,14 +593,14 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	struct ufs_cylinder_group * ucg;
 	unsigned oldcg, i, j, k, allocsize;
 	u64 result;
-	
+
 	UFSD("ENTER, ino %lu, cgno %u, goal %llu, count %u\n",
 	     inode->i_ino, cgno, (unsigned long long)goal, count);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
 	oldcg = cgno;
-	
+
 	/*
 	 * 1. searching on preferred cylinder group
 	 */
@@ -611,7 +611,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	 */
 	for (j = 1; j < uspi->s_ncg; j *= 2) {
 		cgno += j;
-		if (cgno >= uspi->s_ncg) 
+		if (cgno >= uspi->s_ncg)
 			cgno -= uspi->s_ncg;
 		UFS_TEST_FREE_SPACE_CG
 	}
@@ -627,7 +627,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 			cgno = 0;
 		UFS_TEST_FREE_SPACE_CG
 	}
-	
+
 	UFSD("EXIT (FAILED)\n");
 	return 0;
 
@@ -636,7 +636,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	if (!ucpi)
 		return 0;
 	ucg = ubh_get_ucg (UCPI_UBH(ucpi));
-	if (!ufs_cg_chkmagic(sb, ucg)) 
+	if (!ufs_cg_chkmagic(sb, ucg))
 		ufs_panic (sb, "ufs_alloc_fragments",
 			"internal error, bad magic number on cg %u", cgno);
 	ucg->cg_time = ufs_get_seconds(sb);
@@ -651,7 +651,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 	for (allocsize = count; allocsize < uspi->s_fpb; allocsize++)
 		if (fs32_to_cpu(sb, ucg->cg_frsum[allocsize]) != 0)
 			break;
-	
+
 	if (allocsize == uspi->s_fpb) {
 		result = ufs_alloccg_block (inode, ucpi, goal, err);
 		if (result == INVBLOCK)
@@ -676,7 +676,7 @@ static u64 ufs_alloc_fragments(struct inode *inode, unsigned cgno,
 		return 0;
 	for (i = 0; i < count; i++)
 		ubh_clrbit (UCPI_UBH(ucpi), ucpi->c_freeoff, result + i);
-	
+
 	fs32_sub(sb, &ucg->cg_cs.cs_nffree, count);
 	uspi->cs_total.cs_nffree -= count;
 	fs32_sub(sb, &UFS_SB(sb)->fs_cs(cgno).cs_nffree, count);
@@ -718,7 +718,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 	}
 	goal = ufs_blknum (goal);
 	goal = ufs_dtogd(uspi, goal);
-	
+
 	/*
 	 * If the requested block is available, use it.
 	 */
@@ -726,8 +726,8 @@ static u64 ufs_alloccg_block(struct inode *inode,
 		result = goal;
 		goto gotit;
 	}
-	
-norot:	
+
+norot:
 	result = ufs_bitmap_search (sb, ucpi, goal, uspi->s_fpb);
 	if (result == INVBLOCK)
 		return INVBLOCK;
@@ -751,7 +751,7 @@ static u64 ufs_alloccg_block(struct inode *inode,
 					  ufs_cbtorpos((unsigned)result)), 1);
 		fs32_sub(sb, &ubh_cg_blktot(ucpi, cylno), 1);
 	}
-	
+
 	UFSD("EXIT, result %llu\n", (unsigned long long)result);
 
 	return result;
@@ -764,7 +764,7 @@ static unsigned ubh_scanc(struct ufs_sb_private_info *uspi,
 {
 	unsigned rest, offset;
 	unsigned char *cp;
-	
+
 
 	offset = begin & ~uspi->s_fmask;
 	begin >>= uspi->s_fshift;
@@ -818,11 +818,11 @@ static u64 ufs_bitmap_search(struct super_block *sb,
 		start = ufs_dtogd(uspi, goal) >> 3;
 	else
 		start = ucpi->c_frotor >> 3;
-		
+
 	length = ((uspi->s_fpg + 7) >> 3) - start;
 	loc = ubh_scanc(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff + start, length,
 		(uspi->s_fpb == 8) ? ufs_fragtable_8fpb : ufs_fragtable_other,
-		1 << (count - 1 + (uspi->s_fpb & 7))); 
+		1 << (count - 1 + (uspi->s_fpb & 7)));
 	if (loc == 0) {
 		length = start + 1;
 		loc = ubh_scanc(uspi, UCPI_UBH(ucpi), ucpi->c_freeoff, length,
@@ -873,7 +873,7 @@ static void ufs_clusteracct(struct super_block * sb,
 {
 	struct ufs_sb_private_info * uspi;
 	int i, start, end, forw, back;
-	
+
 	uspi = UFS_SB(sb)->s_uspi;
 	if (uspi->s_contigsumsize <= 0)
 		return;
@@ -894,19 +894,19 @@ static void ufs_clusteracct(struct super_block * sb,
 	if (i > end)
 		i = end;
 	forw = i - start;
-	
+
 	/*
 	 * Find the size of the cluster going backward.
 	 */
 	start = blkno - 1;
 	end = start - uspi->s_contigsumsize;
-	if (end < 0 ) 
+	if (end < 0 )
 		end = -1;
 	i = ubh_find_last_zero_bit (UCPI_UBH(ucpi), ucpi->c_clusteroff, start, end);
-	if ( i < end) 
+	if ( i < end)
 		i = end;
 	back = start - i;
-	
+
 	/*
 	 * Account for old cluster and the possibly new forward and
 	 * back clusters.
@@ -927,7 +927,7 @@ static unsigned char ufs_fragtable_8fpb[] = {
 	0x01, 0x01, 0x01, 0x03, 0x01, 0x01, 0x03, 0x05, 0x02, 0x03, 0x03, 0x02, 0x04, 0x05, 0x08, 0x10,
 	0x01, 0x01, 0x01, 0x03, 0x01, 0x01, 0x03, 0x05, 0x01, 0x01, 0x01, 0x03, 0x03, 0x03, 0x05, 0x09,
 	0x02, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02, 0x06, 0x04, 0x05, 0x05, 0x06, 0x08, 0x09, 0x10, 0x20,
-	0x01, 0x01, 0x01, 0x03, 0x01, 0x01, 0x03, 0x05, 0x01, 0x01, 0x01, 0x03, 0x03, 0x03, 0x05, 0x09,	
+	0x01, 0x01, 0x01, 0x03, 0x01, 0x01, 0x03, 0x05, 0x01, 0x01, 0x01, 0x03, 0x03, 0x03, 0x05, 0x09,
 	0x01, 0x01, 0x01, 0x03, 0x01, 0x01, 0x03, 0x05, 0x03, 0x03, 0x03, 0x03, 0x05, 0x05, 0x09, 0x11,
 	0x02, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02, 0x06, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03, 0x06, 0x0A,
 	0x04, 0x05, 0x05, 0x06, 0x05, 0x05, 0x06, 0x04, 0x08, 0x09, 0x09, 0x0A, 0x10, 0x11, 0x20, 0x40,
diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index 1abe5454de47..b7fda3272ffe 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -50,7 +50,7 @@ static void ufs_read_cylinder (struct super_block * sb,
 		if (!(UCPI_UBH(ucpi)->bh[i] = sb_bread(sb, UCPI_UBH(ucpi)->fragment + i)))
 			goto failed;
 	sbi->s_cgno[bitmap_nr] = cgno;
-			
+
 	ucpi->c_cgx	= fs32_to_cpu(sb, ucg->cg_cgx);
 	ucpi->c_ncyl	= fs16_to_cpu(sb, ucg->cg_ncyl);
 	ucpi->c_niblk	= fs16_to_cpu(sb, ucg->cg_niblk);
@@ -67,8 +67,8 @@ static void ufs_read_cylinder (struct super_block * sb,
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
 	UFSD("EXIT\n");
-	return;	
-	
+	return;
+
 failed:
 	for (j = 1; j < i; j++)
 		brelse (sbi->s_ucg[j]);
@@ -83,7 +83,7 @@ static void ufs_read_cylinder (struct super_block * sb,
 void ufs_put_cylinder (struct super_block * sb, unsigned bitmap_nr)
 {
 	struct ufs_sb_info * sbi = UFS_SB(sb);
-	struct ufs_sb_private_info * uspi; 
+	struct ufs_sb_private_info * uspi;
 	struct ufs_cg_private_info * ucpi;
 	struct ufs_cylinder_group * ucg;
 	unsigned i;
@@ -103,7 +103,7 @@ void ufs_put_cylinder (struct super_block * sb, unsigned bitmap_nr)
 		return;
 	}
 	/*
-	 * rotor is not so important data, so we put it to disk 
+	 * rotor is not so important data, so we put it to disk
 	 * at the end of working with cylinder
 	 */
 	ucg->cg_rotor = cpu_to_fs32(sb, ucpi->c_rotor);
@@ -122,7 +122,7 @@ void ufs_put_cylinder (struct super_block * sb, unsigned bitmap_nr)
  * Find cylinder group in cache and return it as pointer.
  * If cylinder group is not in cache, we will load it from disk.
  *
- * The cache is managed by LRU algorithm. 
+ * The cache is managed by LRU algorithm.
  */
 struct ufs_cg_private_info * ufs_load_cylinder (
 	struct super_block * sb, unsigned cgno)
@@ -167,7 +167,7 @@ struct ufs_cg_private_info * ufs_load_cylinder (
 		}
 	}
 	/*
-	 * Cylinder group number cg is in cache but it was not last used, 
+	 * Cylinder group number cg is in cache but it was not last used,
 	 * we will move to the first position
 	 */
 	for (i = 0; i < sbi->s_cg_loaded && sbi->s_cgno[i] != cgno; i++);
diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index b721d0bda5e5..38e7a5367e55 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -72,7 +72,7 @@ ino_t ufs_inode_by_name(struct inode *dir, const struct qstr *qstr)
 	ino_t res = 0;
 	struct ufs_dir_entry *de;
 	struct page *page;
-	
+
 	de = ufs_find_entry(dir, qstr, &page);
 	if (de) {
 		res = fs32_to_cpu(dir->i_sb, de->d_ino);
diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index 7e087581be7e..d0e4a166b643 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -33,7 +33,7 @@
  * We have mostly NULL's here: the current defaults are ok for
  * the ufs filesystem.
  */
- 
+
 const struct file_operations ufs_file_operations = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
diff --git a/fs/ufs/ialloc.c b/fs/ufs/ialloc.c
index 7e3e08c0166f..cd790be9cdda 100644
--- a/fs/ufs/ialloc.c
+++ b/fs/ufs/ialloc.c
@@ -15,7 +15,7 @@
  * Laboratoire MASI - Institut Blaise Pascal
  * Universite Pierre et Marie Curie (Paris VI)
  *
- *  BSD ufs-inspired inode and directory allocation by 
+ *  BSD ufs-inspired inode and directory allocation by
  *  Stephen Tweedie (sct@dcs.ed.ac.uk), 1993
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
@@ -62,12 +62,12 @@ void ufs_free_inode (struct inode * inode)
 	struct ufs_cylinder_group * ucg;
 	int is_directory;
 	unsigned ino, cg, bit;
-	
+
 	UFSD("ENTER, ino %lu\n", inode->i_ino);
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	
+
 	ino = inode->i_ino;
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
@@ -77,7 +77,7 @@ void ufs_free_inode (struct inode * inode)
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		return;
 	}
-	
+
 	cg = ufs_inotocg (ino);
 	bit = ufs_inotocgoff (ino);
 	ucpi = ufs_load_cylinder (sb, cg);
@@ -114,7 +114,7 @@ void ufs_free_inode (struct inode * inode)
 	ubh_mark_buffer_dirty (UCPI_UBH(ucpi));
 	if (sb->s_flags & SB_SYNCHRONOUS)
 		ubh_sync_block(UCPI_UBH(ucpi));
-	
+
 	ufs_mark_sb_dirty(sb);
 	mutex_unlock(&UFS_SB(sb)->s_lock);
 	UFSD("EXIT\n");
@@ -183,7 +183,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	int err = -ENOSPC;
 
 	UFSD("ENTER\n");
-	
+
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
 		return ERR_PTR(-EPERM);
@@ -242,7 +242,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 		goto failed;
 	}
 	ucg = ubh_get_ucg(UCPI_UBH(ucpi));
-	if (!ufs_cg_chkmagic(sb, ucg)) 
+	if (!ufs_cg_chkmagic(sb, ucg))
 		ufs_panic (sb, "ufs_new_inode", "internal error, bad cg magic number");
 
 	start = ucpi->c_irotor;
@@ -276,7 +276,7 @@ struct inode *ufs_new_inode(struct inode *dir, umode_t mode)
 	fs32_sub(sb, &ucg->cg_cs.cs_nifree, 1);
 	uspi->cs_total.cs_nifree--;
 	fs32_sub(sb, &sbi->fs_cs(cg).cs_nifree, 1);
-	
+
 	if (S_ISDIR(mode)) {
 		fs32_add(sb, &ucg->cg_cs.cs_ndir, 1);
 		uspi->cs_total.cs_ndir++;
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 29d5a0e0c8f0..2ad07c3088f8 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -51,7 +51,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
 {
 	struct inode * inode = NULL;
 	ino_t ino;
-	
+
 	if (dentry->d_name.len > UFS_MAXNAMLEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
@@ -67,7 +67,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct dentry *dentry, unsi
  * is so far negative - it has no inode.
  *
  * If the create succeeds, we fill in the inode information
- * with d_instantiate(). 
+ * with d_instantiate().
  */
 static int ufs_create (struct user_namespace * mnt_userns,
 		struct inode * dir, struct dentry * dentry, umode_t mode,
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..090c9ee7d416 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -25,7 +25,7 @@
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
  */
- 
+
 /*
  * Inspired by
  *
@@ -55,7 +55,7 @@
  * Niels Kristian Bech Jensen <nkbj@image.dk>.
  *
  * write support Daniel Pirkl <daniel.pirkl@email.cz> 1998
- * 
+ *
  * HP/UX hfs filesystem support added by
  * Martin K. Petersen <mkp@mkp.net>, August 1999
  *
@@ -278,7 +278,7 @@ void ufs_error (struct super_block * sb, const char * function,
 
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
-	
+
 	if (!sb_rdonly(sb)) {
 		usb1->fs_clean = UFS_FSBAD;
 		ubh_mark_buffer_dirty(USPI_UBH(uspi));
@@ -309,10 +309,10 @@ void ufs_panic (struct super_block * sb, const char * function,
 	struct ufs_super_block_first * usb1;
 	struct va_format vaf;
 	va_list args;
-	
+
 	uspi = UFS_SB(sb)->s_uspi;
 	usb1 = ubh_get_usb_first(uspi);
-	
+
 	if (!sb_rdonly(sb)) {
 		usb1->fs_clean = UFS_FSBAD;
 		ubh_mark_buffer_dirty(USPI_UBH(uspi));
@@ -382,9 +382,9 @@ static const match_table_t tokens = {
 static int ufs_parse_options (char * options, unsigned * mount_options)
 {
 	char * p;
-	
+
 	UFSD("ENTER\n");
-	
+
 	if (!options)
 		return 1;
 
@@ -512,13 +512,13 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 
 	/*
 	 * Read cs structures from (usually) first data block
-	 * on the device. 
+	 * on the device.
 	 */
 	size = uspi->s_cssize;
 	blks = (size + uspi->s_fsize - 1) >> uspi->s_fshift;
 	base = space = kmalloc(size, GFP_NOFS);
 	if (!base)
-		goto failed; 
+		goto failed;
 	sbi->s_csp = (struct ufs_csum *)space;
 	for (i = 0; i < blks; i += uspi->s_fpb) {
 		size = uspi->s_bsize;
@@ -526,7 +526,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 			size = (blks - i) * uspi->s_fsize;
 
 		ubh = ubh_bread(sb, uspi->s_csaddr + i, size);
-		
+
 		if (!ubh)
 			goto failed;
 
@@ -545,7 +545,7 @@ static int ufs_read_cylinder_structures(struct super_block *sb)
 				   GFP_NOFS);
 	if (!sbi->s_ucg)
 		goto failed;
-	for (i = 0; i < uspi->s_ncg; i++) 
+	for (i = 0; i < uspi->s_ncg; i++)
 		sbi->s_ucg[i] = NULL;
 	for (i = 0; i < UFS_MAX_GROUP_LOADED; i++) {
 		sbi->s_ucpi[i] = NULL;
@@ -648,7 +648,7 @@ static void ufs_put_super_internal(struct super_block *sb)
 	unsigned char * base, * space;
 	unsigned blks, size, i;
 
-	
+
 	UFSD("ENTER\n");
 
 	ufs_put_cstotal(sb);
@@ -672,9 +672,9 @@ static void ufs_put_super_internal(struct super_block *sb)
 		ufs_put_cylinder (sb, i);
 		kfree (sbi->s_ucpi[i]);
 	}
-	for (; i < UFS_MAX_GROUP_LOADED; i++) 
+	for (; i < UFS_MAX_GROUP_LOADED; i++)
 		kfree (sbi->s_ucpi[i]);
-	for (i = 0; i < uspi->s_ncg; i++) 
+	for (i = 0; i < uspi->s_ncg; i++)
 		brelse (sbi->s_ucg[i]);
 	kfree (sbi->s_ucg);
 	kfree (base);
@@ -781,7 +781,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	struct ufs_super_block_first * usb1;
 	struct ufs_super_block_second * usb2;
 	struct ufs_super_block_third * usb3;
-	struct ufs_buffer_head * ubh;	
+	struct ufs_buffer_head * ubh;
 	struct inode *inode;
 	unsigned block_size, super_block_size;
 	unsigned flags;
@@ -792,7 +792,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	uspi = NULL;
 	ubh = NULL;
 	flags = 0;
-	
+
 	UFSD("ENTER\n");
 
 #ifndef CONFIG_UFS_FS_WRITE
@@ -801,7 +801,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 		return -EROFS;
 	}
 #endif
-		
+
 	sbi = kzalloc(sizeof(struct ufs_sb_info), GFP_KERNEL);
 	if (!sbi)
 		goto failed_nomem;
@@ -809,7 +809,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->sb = sb;
 
 	UFSD("flag %u\n", (int)(sb_rdonly(sb)));
-	
+
 	mutex_init(&sbi->s_lock);
 	spin_lock_init(&sbi->work_lock);
 	INIT_DELAYED_WORK(&sbi->sync_work, delayed_sync_fs);
@@ -869,7 +869,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 		sb->s_time_max = S64_MAX;
 		flags |= UFS_TYPE_UFS2 | UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
 		break;
-		
+
 	case UFS_MOUNT_UFSTYPE_SUN:
 		UFSD("ufstype=sun\n");
 		uspi->s_fsize = block_size = 1024;
@@ -918,7 +918,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			sb->s_flags |= SB_RDONLY;
 		}
 		break;
-	
+
 	case UFS_MOUNT_UFSTYPE_NEXTSTEP:
 		UFSD("ufstype=nextstep\n");
 		uspi->s_fsize = block_size = 1024;
@@ -934,7 +934,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			sb->s_flags |= SB_RDONLY;
 		}
 		break;
-	
+
 	case UFS_MOUNT_UFSTYPE_NEXTSTEP_CD:
 		UFSD("ufstype=nextstep-cd\n");
 		uspi->s_fsize = block_size = 2048;
@@ -950,7 +950,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			sb->s_flags |= SB_RDONLY;
 		}
 		break;
-	
+
 	case UFS_MOUNT_UFSTYPE_OPENSTEP:
 		UFSD("ufstype=openstep\n");
 		uspi->s_fsize = block_size = 1024;
@@ -966,7 +966,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			sb->s_flags |= SB_RDONLY;
 		}
 		break;
-	
+
 	case UFS_MOUNT_UFSTYPE_HP:
 		UFSD("ufstype=hp\n");
 		uspi->s_fsize = block_size = 1024;
@@ -986,8 +986,8 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			pr_err("unknown ufstype\n");
 		goto failed;
 	}
-	
-again:	
+
+again:
 	if (!sb_set_blocksize(sb, block_size)) {
 		pr_err("failed to set blocksize\n");
 		goto failed;
@@ -998,8 +998,8 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 
 	ubh = ubh_bread_uspi(uspi, sb, uspi->s_sbbase + super_block_offset/block_size, super_block_size);
-	
-	if (!ubh) 
+
+	if (!ubh)
             goto failed;
 
 	usb1 = ubh_get_usb_first(uspi);
@@ -1045,9 +1045,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 			goto magic_found;
 	}
 
-	if ((((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP) 
-	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP_CD) 
-	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_OPENSTEP)) 
+	if ((((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP)
+	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_NEXTSTEP_CD)
+	  || ((sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) == UFS_MOUNT_UFSTYPE_OPENSTEP))
 	  && uspi->s_sbbase < 256) {
 		ubh_brelse_uspi(uspi);
 		ubh = NULL;
@@ -1318,7 +1318,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 	flags = UFS_SB(sb)->s_flags;
 	usb1 = ubh_get_usb_first(uspi);
 	usb3 = ubh_get_usb_third(uspi);
-	
+
 	/*
 	 * Allow the "check" option to be passed as a remount option.
 	 * It is not possible to change ufstype option during remount
@@ -1343,7 +1343,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		return 0;
 	}
-	
+
 	/*
 	 * fs was mouted as rw, remounting ro
 	 */
@@ -1352,7 +1352,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 		usb1->fs_time = ufs_get_seconds(sb);
 		if ((flags & UFS_ST_MASK) == UFS_ST_SUN
 		  || (flags & UFS_ST_MASK) == UFS_ST_SUNOS
-		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86) 
+		  || (flags & UFS_ST_MASK) == UFS_ST_SUNx86)
 			ufs_set_fs_state(sb, usb1, usb3,
 				UFS_FSOK - fs32_to_cpu(sb, usb1->fs_time));
 		ubh_mark_buffer_dirty (USPI_UBH(uspi));
@@ -1366,7 +1366,7 @@ static int ufs_remount (struct super_block *sb, int *mount_flags, char *data)
 		mutex_unlock(&UFS_SB(sb)->s_lock);
 		return -EINVAL;
 #else
-		if (ufstype != UFS_MOUNT_UFSTYPE_SUN && 
+		if (ufstype != UFS_MOUNT_UFSTYPE_SUN &&
 		    ufstype != UFS_MOUNT_UFSTYPE_SUNOS &&
 		    ufstype != UFS_MOUNT_UFSTYPE_44BSD &&
 		    ufstype != UFS_MOUNT_UFSTYPE_SUNx86 &&
@@ -1416,7 +1416,7 @@ static int ufs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
 
 	mutex_lock(&UFS_SB(sb)->s_lock);
-	
+
 	if ((flags & UFS_TYPE_MASK) == UFS_TYPE_UFS2)
 		buf->f_type = UFS2_MAGIC;
 	else
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 4fa633f84274..b84109cef8c2 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -6,7 +6,7 @@
  * Daniel Pirkl <daniel.pirkl@email.cz>
  * Charles University, Faculty of Mathematics and Physics
  */
- 
+
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
@@ -129,12 +129,12 @@ void ubh_sync_block(struct ufs_buffer_head *ubh)
 void ubh_bforget (struct ufs_buffer_head * ubh)
 {
 	unsigned i;
-	if (!ubh) 
+	if (!ubh)
 		return;
-	for ( i = 0; i < ubh->count; i++ ) if ( ubh->bh[i] ) 
+	for ( i = 0; i < ubh->count; i++ ) if ( ubh->bh[i] )
 		bforget (ubh->bh[i]);
 }
- 
+
 int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
 {
 	unsigned i;
@@ -146,7 +146,7 @@ int ubh_buffer_dirty (struct ufs_buffer_head * ubh)
 	return result;
 }
 
-void _ubh_ubhcpymem_(struct ufs_sb_private_info * uspi, 
+void _ubh_ubhcpymem_(struct ufs_sb_private_info * uspi,
 	unsigned char * mem, struct ufs_buffer_head * ubh, unsigned size)
 {
 	unsigned len, bhno;
@@ -162,7 +162,7 @@ void _ubh_ubhcpymem_(struct ufs_sb_private_info * uspi,
 	}
 }
 
-void _ubh_memcpyubh_(struct ufs_sb_private_info * uspi, 
+void _ubh_memcpyubh_(struct ufs_sb_private_info * uspi,
 	struct ufs_buffer_head * ubh, unsigned char * mem, unsigned size)
 {
 	unsigned len, bhno;
-- 
2.25.1

