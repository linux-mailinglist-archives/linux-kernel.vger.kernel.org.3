Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AC57478E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbiGNIuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiGNIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:50:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA11C93A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657788609; x=1689324609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9YLyw3a9ws0g5Y/zxv66yB33PVyxoOytrXNruWQ7tPA=;
  b=mXjtwRcxMx1jcP7FJyjENhcBgftSBWWjdFH3R2MkKonT8h7/Wo1r3ADZ
   iJLI0Mhesoo7YQqYm7jENMQ4L+bFGgQNmhamsSTOgHsBnxZ7hpiM0VL+W
   I+wqgQgxntlRX61o47S5k6pEzITaPHnrxqCAIPHZx6zO93azgPW/I1YTd
   bG8U2BkjMW/Jk0CnPTK3lCBDK9BLzW4eF7N2UIyFAzqIjZlT92mzWowCb
   AbVxCSvvxkyrFJ2d6P2fjiV6xXvFM/2T63zDXD8T6XdcDLhXAx+lpFSne
   81zm3vGx53/ykReT9EWC+LPtBok1Cta5NHdoCMX+YpbpNP7ob5DmUP1MY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="347137555"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="347137555"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 01:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="663708019"
Received: from lkp-server01.sh.intel.com (HELO fd2c14d642b4) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 14 Jul 2022 01:50:05 -0700
Received: from kbuild by fd2c14d642b4 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBuXs-0000MG-Ct;
        Thu, 14 Jul 2022 08:50:04 +0000
Date:   Thu, 14 Jul 2022 16:49:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Xiang Gao <xiang@kernel.org>, linux-kernel@vger.kernel.org
Subject: [xiang:erofs/advancedpcl 16/16] fs/erofs/zdata.c:896:12: warning:
 variable 'len' is uninitialized when used here
Message-ID: <202207141642.UPeaIPx7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/advancedpcl
head:   0889e3f1d4cc1d9cb08d961107c5e810c47ecfd0
commit: 0889e3f1d4cc1d9cb08d961107c5e810c47ecfd0 [16/16] erofs: introduce multi-reference pclusters (fully-referenced)
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220714/202207141642.UPeaIPx7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e61b9c556267086ef9b743a0b57df302eef831b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=0889e3f1d4cc1d9cb08d961107c5e810c47ecfd0
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/advancedpcl
        git checkout 0889e3f1d4cc1d9cb08d961107c5e810c47ecfd0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/erofs/zdata.c:896:12: warning: variable 'len' is uninitialized when used here [-Wuninitialized]
                                   cur += len;
                                          ^~~
   fs/erofs/zdata.c:887:32: note: initialize the variable 'len' to silence this warning
                           unsigned int pgnr, scur, len;
                                                       ^
                                                        = 0
   1 warning generated.


vim +/len +896 fs/erofs/zdata.c

   869	
   870	static void z_erofs_fill_other_copies(struct z_erofs_decompress_backend *be,
   871					      int err)
   872	{
   873		unsigned int off0 = be->pcl->pageofs_out;
   874		struct list_head *p, *n;
   875	
   876		list_for_each_safe(p, n, &be->decompressed_secondary_bvecs) {
   877			struct z_erofs_bvec_item *bvi;
   878			unsigned int end, cur;
   879			void *dst, *src;
   880	
   881			bvi = container_of(p, struct z_erofs_bvec_item, list);
   882			cur = bvi->bvec.offset < 0 ? -bvi->bvec.offset : 0;
   883			end = min_t(unsigned int, be->pcl->length - bvi->bvec.offset,
   884				    bvi->bvec.end);
   885			dst = kmap_local_page(bvi->bvec.page);
   886			while (cur < end) {
   887				unsigned int pgnr, scur, len;
   888	
   889				pgnr = (bvi->bvec.offset + cur + off0) >> PAGE_SHIFT;
   890				DBG_BUGON(pgnr >= be->nr_pages);
   891	
   892				scur = bvi->bvec.offset + cur -
   893						((pgnr << PAGE_SHIFT) - off0);
   894				if (!be->decompressed_pages[pgnr]) {
   895					err = -EFSCORRUPTED;
 > 896					cur += len;
   897					continue;
   898				}
   899				src = kmap_local_page(be->decompressed_pages[pgnr]);
   900				len = min_t(unsigned int, end - cur, PAGE_SIZE - scur);
   901				memcpy(dst + cur, src + scur, len);
   902				kunmap_local(src);
   903				cur += len;
   904			}
   905			kunmap_local(dst);
   906			if (err)
   907				z_erofs_page_mark_eio(bvi->bvec.page);
   908			z_erofs_onlinepage_endio(bvi->bvec.page);
   909			list_del(p);
   910			kfree(bvi);
   911		}
   912	}
   913	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
