Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B57D56510F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbiGDJkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiGDJkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 05:40:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03544218B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 02:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656927605; x=1688463605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zVQ8WfK/RXaoVKUt8vTtloD+RdGUIXxUnwk1SSBmXUo=;
  b=FFg70YaiiVqVjkPjPsGMK6sj85923tS947BDnDJ4W516i/68Pje2W7ft
   WhcLZ9LUUA1qGlpu40LMoU1AyS0sPBwDcKk+xKNKDSI0+/t+/PoKobQPt
   jqo620EQr0gkmyPlx8SILq6xFolWzhSAOnmPaN7UnvLVYMc9+ZpuZP1YK
   Mu2q1/3GkazT4igkfA54eR7mLYLHrjM+wUK9aDL/7PYTEhB/03MSseEPC
   7VfcT+/ZTeDzMGpst/XLKVxI08+5xy2CmjzRoVBSNoQJ9SrD/77Th+WxP
   SslVb5a9fuYFJibR1G9Z9D/AH6pOF/VNrRqOJOC6zik3NhxExw220x8wN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="284194307"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="284194307"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 02:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="619212563"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 04 Jul 2022 02:40:02 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8IYk-000HlT-AJ;
        Mon, 04 Jul 2022 09:40:02 +0000
Date:   Mon, 4 Jul 2022 17:39:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianpeng Ma <jianpeng.ma@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Coly Li <colyli@suse.de>, Qiaowei Ren <qiaowei.ren@intel.com>
Subject: [colyli-bcache:nvdimm-meta 2/13]
 drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic'
 defined but not used
Message-ID: <202207041709.LF2RG54z-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   3c4203ddfa7a07f447f3b497d1ed41cbfce79d8a
commit: 6594f1f01b84315bed570f483e004e5827cb3f92 [2/13] bcache: initialize the nvm pages allocator
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220704/202207041709.LF2RG54z-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?id=6594f1f01b84315bed570f483e004e5827cb3f92
        git remote add colyli-bcache https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git
        git fetch --no-tags colyli-bcache nvdimm-meta
        git checkout 6594f1f01b84315bed570f483e004e5827cb3f92
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/md/bcache/nvmpg.h:8,
                    from drivers/md/bcache/super.c:17:
>> drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic' defined but not used [-Wunused-const-variable=]
     132 | static const __u8 bch_nvmpg_recs_magic[] = {
         |                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/md/bcache/nvmpg_format.h:129:19: warning: 'bch_nvmpg_magic' defined but not used [-Wunused-const-variable=]
     129 | static const __u8 bch_nvmpg_magic[] = {
         |                   ^~~~~~~~~~~~~~~


vim +/bch_nvmpg_recs_magic +132 drivers/md/bcache/nvmpg_format.h

17acc4fd6eeb31 Coly Li 2021-07-26  128  
17acc4fd6eeb31 Coly Li 2021-07-26 @129  static const __u8 bch_nvmpg_magic[] = {
17acc4fd6eeb31 Coly Li 2021-07-26  130  	0x17, 0xbd, 0x53, 0x7f, 0x1b, 0x23, 0xd6, 0x83,
17acc4fd6eeb31 Coly Li 2021-07-26  131  	0x46, 0xa4, 0xf8, 0x28, 0x17, 0xda, 0xec, 0xa9 };
17acc4fd6eeb31 Coly Li 2021-07-26 @132  static const __u8 bch_nvmpg_recs_magic[] = {
17acc4fd6eeb31 Coly Li 2021-07-26  133  	0x39, 0x25, 0x3f, 0xf7, 0x27, 0x17, 0xd0, 0xb9,
17acc4fd6eeb31 Coly Li 2021-07-26  134  	0x10, 0xe6, 0xd2, 0xda, 0x38, 0x68, 0x26, 0xae };
17acc4fd6eeb31 Coly Li 2021-07-26  135  

:::::: The code at line 132 was first introduced by commit
:::::: 17acc4fd6eeb31ad4fd73c11e2ef083889030226 bcache: add initial data structures for nvm pages

:::::: TO: Coly Li <colyli@suse.de>
:::::: CC: Coly Li <colyli@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
