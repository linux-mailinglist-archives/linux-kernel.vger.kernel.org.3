Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A04F0695
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 00:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiDBWcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 18:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDBWcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 18:32:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBBF102;
        Sat,  2 Apr 2022 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648938609; x=1680474609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wSti71aWkOb2v8VteWSnKapOKuwvs3NnbTj6GfMJf68=;
  b=YVz85yYx9AWQ5wORbJGjVm5F9/ig+zFVdPSRAJFct/M7vYn+AAU6WFE+
   vd2zamMOsoP2HMdxuatnrO785CgyIIzGWGTZq8ou6Wj1eLqkNCYCHT4SQ
   nQJWqMX2k6t6kDeBhUE3HalpjFcN6qNdewDhzPD3x/wlS6XqYRT35wi2D
   aFNfv8Oh3AYXMM+HneqTSUMvb+pN1GZz/rlXXr9a2PJd8f/WWyLez+za+
   o9AXGf97PfCyCQ97KnvkGYpEQ81SJTa5yqtoP1XNn4iX7AzcBklRITs5m
   09e0dl8GeFlSXgkxHYI5EqiHjA84/OZ5Du1dZvzVW670M0My+Q5h8fyGv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10305"; a="259169271"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="259169271"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2022 15:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="721256778"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Apr 2022 15:30:07 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1namFy-0000U3-F0;
        Sat, 02 Apr 2022 22:30:06 +0000
Date:   Sun, 3 Apr 2022 06:29:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:15:9:
 warning: 'RST' macro redefined
Message-ID: <202204030631.cIrcwimr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   be2d3ecedd9911fbfd7e55cc9ceac5f8b79ae4cf
commit: 2023a99811110aebba9eee4aa09ef7bd21a8a249 media: platform: rename mediatek/mtk-jpeg/ to mediatek/jpeg/
date:   2 weeks ago
config: mips-randconfig-r001-20220403 (https://download.01.org/0day-ci/archive/20220403/202204030631.cIrcwimr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2023a99811110aebba9eee4aa09ef7bd21a8a249
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2023a99811110aebba9eee4aa09ef7bd21a8a249
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/media/platform/mediatek/jpeg/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c:15:9: warning: 'RST' macro redefined [-Wmacro-redefined]
   #define RST     0xd0
           ^
   arch/mips/include/asm/mach-rc32434/rb.h:13:9: note: previous definition is here
   #define RST             (1 << 15)
           ^
   1 warning generated.


vim +/RST +15 drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_parse.c

b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  12  
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  13  #define TEM	0x01
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  14  #define SOF0	0xc0
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14 @15  #define RST	0xd0
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  16  #define SOI	0xd8
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  17  #define EOI	0xd9
b2f0d2724ba477 drivers/media/platform/mtk-jpeg/mtk_jpeg_parse.c Rick Chang 2016-12-14  18  

:::::: The code at line 15 was first introduced by commit
:::::: b2f0d2724ba477d326e9d654d4db1c93e98f8b93 [media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver

:::::: TO: Rick Chang <rick.chang@mediatek.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@s-opensource.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
