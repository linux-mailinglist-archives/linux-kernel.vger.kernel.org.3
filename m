Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD5564AA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiGCXtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGCXtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:49:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2361CB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656892182; x=1688428182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OMN9Nc/QY/A1NRfM+uJAbDJgCjz3/KhD2m+na2lC5Q8=;
  b=gtXgte5heAKZn0mZzpexHnKeMdZ4AfJ5gNVId9MM2BgybL6VD+g6As5Q
   CXyQTRg8spUCf0bUAFCZR3YqmYbvVW8nezoCXRpGs/q3SUy9CcY4GFmBn
   9pNfnw7qCLmG5PEzY74rQUkW0oH4oyVnqG/xgORjNVO2/OPeEGjB9i2HU
   E1kCyOnWkptmSADIIVjPwozmmDR9wtYYTBYWzLbg8X/9i0DdZkg8VclUz
   sJPMTl1n/W3bNUBxcS+7vwWaFeGg/vq9jOTwndsHyqqfx1A2UGUm+/aRB
   FmvQ9EW/sUt9r2MYUF+H8ZptISc5WJ+CpRyzRe4/3NMqWZbfl+zdJ5EBO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281755075"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281755075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 16:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="660004684"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Jul 2022 16:49:40 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o89LP-000HAn-Rn;
        Sun, 03 Jul 2022 23:49:39 +0000
Date:   Mon, 4 Jul 2022 07:48:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: [xiang:erofs/advancedpcl 15/15] fs/erofs/zdata.c:920:15: warning:
 variable 'mappednr' is uninitialized when used here
Message-ID: <202207040759.hbbBfdAF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/advancedpcl
head:   cf39c4e41414797419bd1d6b45bcdc365904ad68
commit: cf39c4e41414797419bd1d6b45bcdc365904ad68 [15/15] erofs: introduce multi-reference pclusters
config: i386-randconfig-a015 (https://download.01.org/0day-ci/archive/20220704/202207040759.hbbBfdAF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5d787689b14574fe58ba9798563f4a6df6059fbf)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=cf39c4e41414797419bd1d6b45bcdc365904ad68
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/advancedpcl
        git checkout cf39c4e41414797419bd1d6b45bcdc365904ad68
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/zdata.c:920:15: warning: variable 'mappednr' is uninitialized when used here [-Wuninitialized]
                           if (src && mappednr != pgnr) {
                                      ^~~~~~~~
   fs/erofs/zdata.c:899:23: note: initialize the variable 'mappednr' to silence this warning
           unsigned int mappednr;
                                ^
                                 = 0
   fs/erofs/zdata.c:1608:5: error: too many arguments to function call, expected 3, have 4
                            z_erofs_get_sync_decompress_policy(sbi, 0));
                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/erofs/zdata.c:1502:13: note: 'z_erofs_runqueue' declared here
   static void z_erofs_runqueue(struct z_erofs_decompress_frontend *f,
               ^
   1 warning and 1 error generated.


vim +/mappednr +920 fs/erofs/zdata.c

   895	
   896	static void z_erofs_fill_duplicated_copy(struct z_erofs_decompress_backend *be)
   897	{
   898		unsigned char *src = NULL;
   899		unsigned int mappednr;
   900		struct list_head *p, *n;
   901	
   902		list_for_each_safe(p, n, &be->decompressed_secondary_bvecs) {
   903			struct z_erofs_bvec_item *bvi;
   904			unsigned int end, cur = 0;
   905			int off0;
   906			void *dst;
   907	
   908			bvi = container_of(p, struct z_erofs_bvec_item, list);
   909			dst = kmap_local_page(bvi->bvec.page);
   910	
   911			if (bvi->bvec.offset < 0)
   912				cur = -bvi->bvec.offset;
   913			off0 = bvi->bvec.offset + (bvi->bvec.offset & ~PAGE_MASK);
   914			end = min_t(unsigned int, be->outputsize - off0, PAGE_SIZE);
   915			off0 -= be->pcl->pageofs_out;
   916			while (cur < end) {
   917				unsigned int pgnr, scur;
   918	
   919				pgnr = (off0 + cur + PAGE_SIZE - 1) >> PAGE_SHIFT;
 > 920				if (src && mappednr != pgnr) {
   921					kunmap_local(src);
   922					src = NULL;
   923				}
   924				scur = (pgnr << PAGE_SHIFT) - (off0 + cur);
   925	
   926				if (!src)
   927					src = kmap_local_page(
   928							be->decompressed_pages[pgnr]);
   929				memcpy(dst + cur, src + scur, end - max(cur, scur));
   930			}
   931			kunmap_local(dst);
   932			z_erofs_onlinepage_endio(bvi->bvec.page);
   933		}
   934	
   935		if (src)
   936			kunmap_local(src);
   937	}
   938	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
