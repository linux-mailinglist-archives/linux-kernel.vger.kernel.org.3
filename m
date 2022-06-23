Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF995577B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiFWKRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiFWKRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:17:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976749FAB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655979453; x=1687515453;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TYV97gHZA5yGEmcvgVZDsIZeLNy29ZJBZ8fG5o69Izc=;
  b=KybHuiVMDin0el/dO4MHkb41IXih1ggPPHMpQB+KWrZWvLHb0HKc+eMa
   XeX1yF+ErmjPKPrafCKkjoDRfD+FdCXcJC5/WqJmglDz5aFaK41umXnjt
   Hapo+sEBPB6WiL4WTRw2TLGsZ9uPEvfLTFvsMv2wIspM1QrEWxVm8brz/
   oio2sz6R/TWX5lTTMMNt1mpqPKnoKF9e09+aw05ECZ9TDIS9zjCgs6YtM
   lUqJul4PoG/SkiJTLm+hfFaHhOdCfPF3lNB6WD5OQaXeeklqx0V+h5N+x
   O9PF7Nn1gxWfChYYYPCofeIPbQCteoFe7Ukd6tZFoQ7QrUYqRD2YKxUBi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="269405561"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="269405561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 03:17:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644669560"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jun 2022 03:17:31 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4Jty-00016d-O0;
        Thu, 23 Jun 2022 10:17:30 +0000
Date:   Thu, 23 Jun 2022 18:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:block-bitwise-opf 11/50] fs/ntfs3/attrib.c:1292:57:
 sparse: sparse: incorrect type in argument 7 (different base types)
Message-ID: <202206231852.vDdFxMC4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux block-bitwise-opf
head:   cdae45bfee03111b49b421b4c01dcddb643f64a2
commit: 389f5e4037ed787995e6d3753e502cf1a7c5a9f5 [11/50] block: Introduce the type blk_opf_t
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220623/202206231852.vDdFxMC4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/bvanassche/linux/commit/389f5e4037ed787995e6d3753e502cf1a7c5a9f5
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche block-bitwise-opf
        git checkout 389f5e4037ed787995e6d3753e502cf1a7c5a9f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/ntfs3/attrib.c:1292:57: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned int [usertype] op @@     got restricted blk_opf_t @@
   fs/ntfs3/attrib.c:1292:57: sparse:     expected unsigned int [usertype] op
   fs/ntfs3/attrib.c:1292:57: sparse:     got restricted blk_opf_t
--
>> fs/ntfs3/frecord.c:2194:46: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned int [usertype] op @@     got restricted blk_opf_t @@
   fs/ntfs3/frecord.c:2194:46: sparse:     expected unsigned int [usertype] op
   fs/ntfs3/frecord.c:2194:46: sparse:     got restricted blk_opf_t
   fs/ntfs3/frecord.c:2561:46: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned int [usertype] op @@     got restricted blk_opf_t @@
   fs/ntfs3/frecord.c:2561:46: sparse:     expected unsigned int [usertype] op
   fs/ntfs3/frecord.c:2561:46: sparse:     got restricted blk_opf_t
   fs/ntfs3/frecord.c:2593:43: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned int [usertype] op @@     got restricted blk_opf_t @@
   fs/ntfs3/frecord.c:2593:43: sparse:     expected unsigned int [usertype] op
   fs/ntfs3/frecord.c:2593:43: sparse:     got restricted blk_opf_t
   fs/ntfs3/frecord.c:2805:30: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected unsigned int [usertype] op @@     got restricted blk_opf_t @@
   fs/ntfs3/frecord.c:2805:30: sparse:     expected unsigned int [usertype] op
   fs/ntfs3/frecord.c:2805:30: sparse:     got restricted blk_opf_t

vim +1292 fs/ntfs3/attrib.c

be71b5cba2e648 Konstantin Komarov 2021-08-13  1193  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1194  #ifdef CONFIG_NTFS3_LZX_XPRESS
be71b5cba2e648 Konstantin Komarov 2021-08-13  1195  /*
be71b5cba2e648 Konstantin Komarov 2021-08-13  1196   * attr_wof_frame_info
be71b5cba2e648 Konstantin Komarov 2021-08-13  1197   *
e8b8e97f91b80f Kari Argillander   2021-08-03  1198   * Read header of Xpress/LZX file to get info about frame.
be71b5cba2e648 Konstantin Komarov 2021-08-13  1199   */
be71b5cba2e648 Konstantin Komarov 2021-08-13  1200  int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
be71b5cba2e648 Konstantin Komarov 2021-08-13  1201  			struct runs_tree *run, u64 frame, u64 frames,
be71b5cba2e648 Konstantin Komarov 2021-08-13  1202  			u8 frame_bits, u32 *ondisk_size, u64 *vbo_data)
be71b5cba2e648 Konstantin Komarov 2021-08-13  1203  {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1204  	struct ntfs_sb_info *sbi = ni->mi.sbi;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1205  	u64 vbo[2], off[2], wof_size;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1206  	u32 voff;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1207  	u8 bytes_per_off;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1208  	char *addr;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1209  	struct page *page;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1210  	int i, err;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1211  	__le32 *off32;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1212  	__le64 *off64;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1213  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1214  	if (ni->vfs_inode.i_size < 0x100000000ull) {
e8b8e97f91b80f Kari Argillander   2021-08-03  1215  		/* File starts with array of 32 bit offsets. */
be71b5cba2e648 Konstantin Komarov 2021-08-13  1216  		bytes_per_off = sizeof(__le32);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1217  		vbo[1] = frame << 2;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1218  		*vbo_data = frames << 2;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1219  	} else {
e8b8e97f91b80f Kari Argillander   2021-08-03  1220  		/* File starts with array of 64 bit offsets. */
be71b5cba2e648 Konstantin Komarov 2021-08-13  1221  		bytes_per_off = sizeof(__le64);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1222  		vbo[1] = frame << 3;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1223  		*vbo_data = frames << 3;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1224  	}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1225  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1226  	/*
e8b8e97f91b80f Kari Argillander   2021-08-03  1227  	 * Read 4/8 bytes at [vbo - 4(8)] == offset where compressed frame starts.
e8b8e97f91b80f Kari Argillander   2021-08-03  1228  	 * Read 4/8 bytes at [vbo] == offset where compressed frame ends.
be71b5cba2e648 Konstantin Komarov 2021-08-13  1229  	 */
be71b5cba2e648 Konstantin Komarov 2021-08-13  1230  	if (!attr->non_res) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1231  		if (vbo[1] + bytes_per_off > le32_to_cpu(attr->res.data_size)) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1232  			ntfs_inode_err(&ni->vfs_inode, "is corrupted");
be71b5cba2e648 Konstantin Komarov 2021-08-13  1233  			return -EINVAL;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1234  		}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1235  		addr = resident_data(attr);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1236  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1237  		if (bytes_per_off == sizeof(__le32)) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1238  			off32 = Add2Ptr(addr, vbo[1]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1239  			off[0] = vbo[1] ? le32_to_cpu(off32[-1]) : 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1240  			off[1] = le32_to_cpu(off32[0]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1241  		} else {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1242  			off64 = Add2Ptr(addr, vbo[1]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1243  			off[0] = vbo[1] ? le64_to_cpu(off64[-1]) : 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1244  			off[1] = le64_to_cpu(off64[0]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1245  		}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1246  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1247  		*vbo_data += off[0];
be71b5cba2e648 Konstantin Komarov 2021-08-13  1248  		*ondisk_size = off[1] - off[0];
be71b5cba2e648 Konstantin Komarov 2021-08-13  1249  		return 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1250  	}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1251  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1252  	wof_size = le64_to_cpu(attr->nres.data_size);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1253  	down_write(&ni->file.run_lock);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1254  	page = ni->file.offs_page;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1255  	if (!page) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1256  		page = alloc_page(GFP_KERNEL);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1257  		if (!page) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1258  			err = -ENOMEM;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1259  			goto out;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1260  		}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1261  		page->index = -1;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1262  		ni->file.offs_page = page;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1263  	}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1264  	lock_page(page);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1265  	addr = page_address(page);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1266  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1267  	if (vbo[1]) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1268  		voff = vbo[1] & (PAGE_SIZE - 1);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1269  		vbo[0] = vbo[1] - bytes_per_off;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1270  		i = 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1271  	} else {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1272  		voff = 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1273  		vbo[0] = 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1274  		off[0] = 0;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1275  		i = 1;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1276  	}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1277  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1278  	do {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1279  		pgoff_t index = vbo[i] >> PAGE_SHIFT;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1280  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1281  		if (index != page->index) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1282  			u64 from = vbo[i] & ~(u64)(PAGE_SIZE - 1);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1283  			u64 to = min(from + PAGE_SIZE, wof_size);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1284  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1285  			err = attr_load_runs_range(ni, ATTR_DATA, WOF_NAME,
be71b5cba2e648 Konstantin Komarov 2021-08-13  1286  						   ARRAY_SIZE(WOF_NAME), run,
be71b5cba2e648 Konstantin Komarov 2021-08-13  1287  						   from, to);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1288  			if (err)
be71b5cba2e648 Konstantin Komarov 2021-08-13  1289  				goto out1;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1290  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1291  			err = ntfs_bio_pages(sbi, run, &page, 1, from,
be71b5cba2e648 Konstantin Komarov 2021-08-13 @1292  					     to - from, REQ_OP_READ);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1293  			if (err) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1294  				page->index = -1;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1295  				goto out1;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1296  			}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1297  			page->index = index;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1298  		}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1299  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1300  		if (i) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1301  			if (bytes_per_off == sizeof(__le32)) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1302  				off32 = Add2Ptr(addr, voff);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1303  				off[1] = le32_to_cpu(*off32);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1304  			} else {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1305  				off64 = Add2Ptr(addr, voff);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1306  				off[1] = le64_to_cpu(*off64);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1307  			}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1308  		} else if (!voff) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1309  			if (bytes_per_off == sizeof(__le32)) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1310  				off32 = Add2Ptr(addr, PAGE_SIZE - sizeof(u32));
be71b5cba2e648 Konstantin Komarov 2021-08-13  1311  				off[0] = le32_to_cpu(*off32);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1312  			} else {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1313  				off64 = Add2Ptr(addr, PAGE_SIZE - sizeof(u64));
be71b5cba2e648 Konstantin Komarov 2021-08-13  1314  				off[0] = le64_to_cpu(*off64);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1315  			}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1316  		} else {
e8b8e97f91b80f Kari Argillander   2021-08-03  1317  			/* Two values in one page. */
be71b5cba2e648 Konstantin Komarov 2021-08-13  1318  			if (bytes_per_off == sizeof(__le32)) {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1319  				off32 = Add2Ptr(addr, voff);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1320  				off[0] = le32_to_cpu(off32[-1]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1321  				off[1] = le32_to_cpu(off32[0]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1322  			} else {
be71b5cba2e648 Konstantin Komarov 2021-08-13  1323  				off64 = Add2Ptr(addr, voff);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1324  				off[0] = le64_to_cpu(off64[-1]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1325  				off[1] = le64_to_cpu(off64[0]);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1326  			}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1327  			break;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1328  		}
be71b5cba2e648 Konstantin Komarov 2021-08-13  1329  	} while (++i < 2);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1330  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1331  	*vbo_data += off[0];
be71b5cba2e648 Konstantin Komarov 2021-08-13  1332  	*ondisk_size = off[1] - off[0];
be71b5cba2e648 Konstantin Komarov 2021-08-13  1333  
be71b5cba2e648 Konstantin Komarov 2021-08-13  1334  out1:
be71b5cba2e648 Konstantin Komarov 2021-08-13  1335  	unlock_page(page);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1336  out:
be71b5cba2e648 Konstantin Komarov 2021-08-13  1337  	up_write(&ni->file.run_lock);
be71b5cba2e648 Konstantin Komarov 2021-08-13  1338  	return err;
be71b5cba2e648 Konstantin Komarov 2021-08-13  1339  }
be71b5cba2e648 Konstantin Komarov 2021-08-13  1340  #endif
be71b5cba2e648 Konstantin Komarov 2021-08-13  1341  

:::::: The code at line 1292 was first introduced by commit
:::::: be71b5cba2e6485e8959da7a9f9a44461a1bb074 fs/ntfs3: Add attrib operations

:::::: TO: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
:::::: CC: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
