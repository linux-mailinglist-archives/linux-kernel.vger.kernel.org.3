Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3644564AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbiGDAjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiGDAjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:39:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1975FE9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 17:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656895185; x=1688431185;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SeQeHBZF9N5V3ysNHfbIx5+1pTdws2ML2v1HTAWJcWE=;
  b=bP3neXiTxrFZ/X+vGtX4/y3dB8oOhfzZdP36vqjeD9YZy2/nknoit5x+
   KVPDa2ZjzFclfqDw8FfZaGngC9ASI3KO+CLzyQfakKpVTBalDXesgJg7a
   mlsrOnxqmj5T7qplsKDiBrW8YjaUXZXPwErop/kjXm1m/bImLUrlEWf1N
   Hgafp7/flJCxUwWzJjsU3llaadwV5Q0b64t+T0rSiA/Y4dm7j/xeqiSez
   ZWrs9LcQI+UfFWgeW+rOxh/jjbJnFxVbXTDeduOt3xwaxw+XJh/DZdTMj
   0naL6NQszTsb6X47ogOg3eS5YOIHeiNxm9xwNVhpSb/AK6RK+RcE3XnOu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="283730104"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283730104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 17:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660014136"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2022 17:39:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8A7q-000HDz-Ok;
        Mon, 04 Jul 2022 00:39:42 +0000
Date:   Mon, 4 Jul 2022 08:39:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: [xiang:erofs/folios 1/11] fs/erofs/zdata.c:1475:5: error: too many
 arguments to function call, expected 3, have 4
Message-ID: <202207040836.wG8VwKFj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/folios
head:   c94ebb8be9f7900ed0aa53a0638d119c4121ed1f
commit: af9c47cccaca8f1f3eb1de21328804b391edaaca [1/11] erofs: get rid of unneeded `inode', `map' and `sb'
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220704/202207040836.wG8VwKFj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5d787689b14574fe58ba9798563f4a6df6059fbf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=af9c47cccaca8f1f3eb1de21328804b391edaaca
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/folios
        git checkout af9c47cccaca8f1f3eb1de21328804b391edaaca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/erofs/zdata.c:1475:5: error: too many arguments to function call, expected 3, have 4
                            z_erofs_get_sync_decompress_policy(sbi, 0));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/erofs/zdata.c:1369:13: note: 'z_erofs_runqueue' declared here
   static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
               ^
   1 error generated.


vim +1475 fs/erofs/zdata.c

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
40452ffca3c1a0 fs/erofs/zdata.c                  Huang Jianan            2021-12-06  1474  	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
40452ffca3c1a0 fs/erofs/zdata.c                  Huang Jianan            2021-12-06 @1475  			 z_erofs_get_sync_decompress_policy(sbi, 0));
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1476  
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1477  	if (err)
4f761fa253b49f fs/erofs/zdata.c                  Gao Xiang               2019-09-04  1478  		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1479  
09c543798c3cde fs/erofs/zdata.c                  Gao Xiang               2022-01-02  1480  	erofs_put_metabuf(&f.map.buf);
eaa9172ad988b3 fs/erofs/zdata.c                  Gao Xiang               2021-10-22  1481  	erofs_release_pages(&pagepool);
ee45197c807895 drivers/staging/erofs/zdata.c     Gao Xiang               2019-08-19  1482  	return err;
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1483  }
3883a79abd0227 drivers/staging/erofs/unzip_vle.c Gao Xiang               2018-07-26  1484  

:::::: The code at line 1475 was first introduced by commit
:::::: 40452ffca3c1a0f2994e826f9fa213b107f1a2d4 erofs: add sysfs node to control sync decompression strategy

:::::: TO: Huang Jianan <huangjianan@oppo.com>
:::::: CC: Gao Xiang <hsiangkao@linux.alibaba.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
