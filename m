Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E38564B2C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiGDBau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGDBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:30:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070B6341
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656898248; x=1688434248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SxOkaiVR113I3kaHAk+FLPQGbeY0mVV8OggNceEYZ5s=;
  b=bRGu2i/wFaGM3EReZG4f+LGAU14LlmRJNKd3A5fZwIxEVHb0wosnH9HF
   lwjuulwz5kI+4YW/kGm98bzwhTiydNmSaH1Q/bjjoqeoaJ67t+8O5Zy3g
   I28FfcAzxph9DLUbMy7x+02HRiCI5DtDAAk0y7PYonWCSbuMRjwyOTFxw
   Mo2LgtOHt+R9UOhJSTE+609f8B9XBd3oLxSGOB/PE4PBg39sg+e/LryRL
   OozTeHbaerqDmWeSZ49F1mJ5qxpEypqx0eJq3XFCyuhDCpLSAr2ryjW7R
   JtTU7Wyafaehe+vwS8l5b5cMDKNgnDul/ArrZ3tFGPQsYKZvmFRsvxKKh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="280560922"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="280560922"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 18:30:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="919135882"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jul 2022 18:30:47 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8AvG-000HIh-ME;
        Mon, 04 Jul 2022 01:30:46 +0000
Date:   Mon, 4 Jul 2022 09:30:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [xiang:erofs/folios 1/11] fs/erofs/zdata.c:1474:31: error: passing
 argument 1 of 'z_erofs_runqueue' from incompatible pointer type
Message-ID: <202207040951.6cBsFapw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/folios
head:   c94ebb8be9f7900ed0aa53a0638d119c4121ed1f
commit: af9c47cccaca8f1f3eb1de21328804b391edaaca [1/11] erofs: get rid of unneeded `inode', `map' and `sb'
config: x86_64-randconfig-a011 (https://download.01.org/0day-ci/archive/20220704/202207040951.6cBsFapw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=af9c47cccaca8f1f3eb1de21328804b391edaaca
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/folios
        git checkout af9c47cccaca8f1f3eb1de21328804b391edaaca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/erofs/zdata.c: In function 'z_erofs_read_folio':
>> fs/erofs/zdata.c:1474:31: error: passing argument 1 of 'z_erofs_runqueue' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1474 |         z_erofs_runqueue(inode->i_sb, &f, &pagepool,
         |                          ~~~~~^~~~~~
         |                               |
         |                               struct super_block *
   fs/erofs/zdata.c:1369:66: note: expected 'struct z_erofs_decompress_frontend *' but argument is of type 'struct super_block *'
    1369 | static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
         |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   fs/erofs/zdata.c:1474:39: error: passing argument 2 of 'z_erofs_runqueue' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1474 |         z_erofs_runqueue(inode->i_sb, &f, &pagepool,
         |                                       ^~
         |                                       |
         |                                       struct z_erofs_decompress_frontend *
   fs/erofs/zdata.c:1370:44: note: expected 'struct page **' but argument is of type 'struct z_erofs_decompress_frontend *'
    1370 |                              struct page **pagepool, bool force_fg)
         |                              ~~~~~~~~~~~~~~^~~~~~~~
   fs/erofs/zdata.c:1475:26: warning: the address of 'pagepool' will always evaluate as 'true' [-Waddress]
    1475 |                          z_erofs_get_sync_decompress_policy(sbi, 0));
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> fs/erofs/zdata.c:1474:9: error: too many arguments to function 'z_erofs_runqueue'
    1474 |         z_erofs_runqueue(inode->i_sb, &f, &pagepool,
         |         ^~~~~~~~~~~~~~~~
   fs/erofs/zdata.c:1369:13: note: declared here
    1369 | static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
         |             ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/z_erofs_runqueue +1474 fs/erofs/zdata.c

386292919c255d fs/erofs/zdata.c                  Gao Xiang               2021-10-09  1453  
a2e20a25a1470e fs/erofs/zdata.c                  Matthew Wilcox (Oracle  2022-04-29  1454) static int z_erofs_read_folio(struct file *file, struct folio *folio)
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1455  {
a2e20a25a1470e fs/erofs/zdata.c                  Matthew Wilcox (Oracle  2022-04-29  1456) 	struct page *page = &folio->page;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1457  	struct inode *const inode = page->mapping->host;
40452ffca3c1a0 fs/erofs/zdata.c                  Huang Jianan            2021-12-06  1458  	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
97e86a858bc360 drivers/staging/erofs/zdata.c     Gao Xiang               2019-07-31  1459  	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
eaa9172ad988b3 fs/erofs/zdata.c                  Gao Xiang               2021-10-22  1460  	struct page *pagepool = NULL;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1461  	int err;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1462  
ba9ce771b018c5 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-11-23  1463  	trace_erofs_readpage(page, false);
f0c519fc2679ca drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-11-23  1464  	f.headoffset = (erofs_off_t)page->index << PAGE_SHIFT;
f0c519fc2679ca drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-11-23  1465  
386292919c255d fs/erofs/zdata.c                  Gao Xiang               2021-10-09  1466  	z_erofs_pcluster_readmore(&f, NULL, f.headoffset + PAGE_SIZE - 1,
386292919c255d fs/erofs/zdata.c                  Gao Xiang               2021-10-09  1467  				  &pagepool, true);
1825c8d7ce93c4 fs/erofs/zdata.c                  Gao Xiang               2020-12-09  1468  	err = z_erofs_do_read_page(&f, page, &pagepool);
386292919c255d fs/erofs/zdata.c                  Gao Xiang               2021-10-09  1469  	z_erofs_pcluster_readmore(&f, NULL, 0, &pagepool, false);
386292919c255d fs/erofs/zdata.c                  Gao Xiang               2021-10-09  1470  
5c6dcc57e2e505 fs/erofs/zdata.c                  Gao Xiang               2022-03-02  1471  	(void)z_erofs_collector_end(&f);
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1472  
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1473  	/* if some compressed cluster ready, need submit them anyway */
40452ffca3c1a0 fs/erofs/zdata.c                  Huang Jianan            2021-12-06 @1474  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
40452ffca3c1a0 fs/erofs/zdata.c                  Huang Jianan            2021-12-06  1475  			 z_erofs_get_sync_decompress_policy(sbi, 0));
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1476  
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1477  	if (err)
4f761fa253b49f fs/erofs/zdata.c                  Gao Xiang               2019-09-04  1478  		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1479  
09c543798c3cde fs/erofs/zdata.c                  Gao Xiang               2022-01-02  1480  	erofs_put_metabuf(&f.map.buf);
eaa9172ad988b3 fs/erofs/zdata.c                  Gao Xiang               2021-10-22  1481  	erofs_release_pages(&pagepool);
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1482  	return err;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1483  }
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1484  

:::::: The code at line 1474 was first introduced by commit
:::::: 40452ffca3c1a0f2994e826f9fa213b107f1a2d4 erofs: add sysfs node to control sync decompression strategy

:::::: TO: Huang Jianan <huangjianan@oppo.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
