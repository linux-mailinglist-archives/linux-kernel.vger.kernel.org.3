Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E12E58B629
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiHFOkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 10:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiHFOkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 10:40:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2506EDFBE
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 07:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659796801; x=1691332801;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dCzJt5QZzd/jFmndJyLiY8m0keauWURLIPjtwMvxFu8=;
  b=bMCdwkXDO35juaLBjUfsTnkggbNgK+YcPXyUMwpR+1UZqyK8sEMe3YrB
   qJ2fyjohfPyM7sntQeUyufXipUSd+6IkX+i7XRhi49AjQZrmyERzB18lC
   SjY/HYyWxpkr1b/Ryy4TgT/15noi2JksfgkZK5d7/RnYecOst4aIT7diL
   yXdN2WQzfQ/b75b2al8PK0XF1UWHhFcbb3bbj5N8jFsxelSJs4bZsZxzf
   IeJFjSxDScQLtn6VG1LCToZIKEycYnjx4XxQ6+jsgvIeoUGyhsV3/piML
   T7fVejkhfvFhR/Noif+tk3vpPZWjr64Af5zlRaSs5V5XhCEBhNT0/Scay
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="290380103"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="290380103"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 07:40:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="636804642"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 07:39:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKKy6-000KRl-1F;
        Sat, 06 Aug 2022 14:39:58 +0000
Date:   Sat, 6 Aug 2022 22:39:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/irqchip/irq-loongson-pch-pic.c:51:5: warning: no previous
 prototype for function 'find_pch_pic'
Message-ID: <202208062228.5NkhxzNQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: bcdd75c596c89d7925a3438fde2578ca23a62b06 irqchip/loongson-pch-pic: Add ACPI init support
date:   2 weeks ago
config: mips-loongson2k_defconfig (https://download.01.org/0day-ci/archive/20220806/202208062228.5NkhxzNQ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips64el-linux-gnuabi64
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bcdd75c596c89d7925a3438fde2578ca23a62b06
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bcdd75c596c89d7925a3438fde2578ca23a62b06
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-loongson-pch-pic.c:51:5: warning: no previous prototype for function 'find_pch_pic' [-Wmissing-prototypes]
   int find_pch_pic(u32 gsi)
       ^
   drivers/irqchip/irq-loongson-pch-pic.c:51:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int find_pch_pic(u32 gsi)
   ^
   static 
   1 warning generated.


vim +/find_pch_pic +51 drivers/irqchip/irq-loongson-pch-pic.c

    50	
  > 51	int find_pch_pic(u32 gsi)
    52	{
    53		int i;
    54	
    55		/* Find the PCH_PIC that manages this GSI. */
    56		for (i = 0; i < MAX_IO_PICS; i++) {
    57			struct pch_pic *priv = pch_pic_priv[i];
    58	
    59			if (!priv)
    60				return -1;
    61	
    62			if (gsi >= priv->gsi_base && gsi < (priv->gsi_base + priv->vec_count))
    63				return i;
    64		}
    65	
    66		pr_err("ERROR: Unable to locate PCH_PIC for GSI %d\n", gsi);
    67		return -1;
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
