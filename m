Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199885703BA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiGKNBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGKNBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:01:34 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68CA301
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657544492; x=1689080492;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PrVmYeCmbTkAjP1yiVX7XN2Kn0xfGm7eXMW+G51ItXQ=;
  b=EML7G+D2q4NLpmBhBQHE2LQD2y1eyBJ+mi1dxlG8jcKzJXUXwqkj8ncq
   QRierpBv/Y1qtDwkg4QEBoVBvR3Sk6j4EDJnmm00pIVFCrWvFX/8nhuM3
   dzavPgIPfjV/IBZaYk9HKIiZjD2eibWzr0d8gE65Y5vsb0KVhOLLI0Fs7
   fjvRf/78cJYJ6/Q/drsSyhWt0vSWUwiCIXLQGOR45h3Rbhoc8llFPZaFt
   wXVEzNSuectdLJKNlz5vSaBQdTyomkBKtEBfjXy5S9NdQBaD+GLAwPsS3
   k3lX7yYXqItNRSBLI4JhEe+bMPvLhX4KMvAJxKGSWmMNrTPKiW0ZaeCWy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264431826"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="264431826"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 06:01:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="921771631"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jul 2022 06:01:28 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAt2V-0000pZ-VJ;
        Mon, 11 Jul 2022 13:01:27 +0000
Date:   Mon, 11 Jul 2022 21:01:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, Xiang Gao <xiang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [xiang:erofs/advancedpcl 16/16] fs/erofs/zdata.c:901:36: error:
 'mappednr' undeclared
Message-ID: <202207112048.J46LPGXw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git erofs/advancedpcl
head:   2c199ac6fc3c0d5499babde5b7586d99e4bc7aae
commit: 2c199ac6fc3c0d5499babde5b7586d99e4bc7aae [16/16] erofs: introduce multi-reference pclusters
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220711/202207112048.J46LPGXw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git/commit/?id=2c199ac6fc3c0d5499babde5b7586d99e4bc7aae
        git remote add xiang https://git.kernel.org/pub/scm/linux/kernel/git/xiang/linux.git
        git fetch --no-tags xiang erofs/advancedpcl
        git checkout 2c199ac6fc3c0d5499babde5b7586d99e4bc7aae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash fs/erofs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/erofs/zdata.c: In function 'z_erofs_fill_duplicated_copy':
>> fs/erofs/zdata.c:901:36: error: 'mappednr' undeclared (first use in this function)
     901 |                         if (src && mappednr != pgnr) {
         |                                    ^~~~~~~~
   fs/erofs/zdata.c:901:36: note: each undeclared identifier is reported only once for each function it appears in


vim +/mappednr +901 fs/erofs/zdata.c

   877	
   878	static void z_erofs_fill_duplicated_copy(struct z_erofs_decompress_backend *be)
   879	{
   880		unsigned char *src = NULL;
   881		struct list_head *p, *n;
   882	
   883		list_for_each_safe(p, n, &be->decompressed_secondary_bvecs) {
   884			struct z_erofs_bvec_item *bvi;
   885			unsigned int end, cur = 0;
   886			int off0;
   887			void *dst;
   888	
   889			bvi = container_of(p, struct z_erofs_bvec_item, list);
   890			dst = kmap_local_page(bvi->bvec.page);
   891	
   892			if (bvi->bvec.offset < 0)
   893				cur = -bvi->bvec.offset;
   894			off0 = bvi->bvec.offset + (bvi->bvec.offset & ~PAGE_MASK);
   895			end = min_t(unsigned int, be->pcl->length - off0, PAGE_SIZE);
   896			off0 -= be->pcl->pageofs_out;
   897			while (cur < end) {
   898				unsigned int pgnr, scur;
   899	
   900				pgnr = (off0 + cur + PAGE_SIZE - 1) >> PAGE_SHIFT;
 > 901				if (src && mappednr != pgnr) {
   902					kunmap_local(src);
   903					src = NULL;
   904				}
   905				scur = (pgnr << PAGE_SHIFT) - (off0 + cur);
   906	
   907				if (!src)
   908					src = kmap_local_page(
   909							be->decompressed_pages[pgnr]);
   910				memcpy(dst + cur, src + scur, end - max(cur, scur));
   911			}
   912			kunmap_local(dst);
   913			z_erofs_onlinepage_endio(bvi->bvec.page);
   914		}
   915	
   916		if (src)
   917			kunmap_local(src);
   918	}
   919	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
