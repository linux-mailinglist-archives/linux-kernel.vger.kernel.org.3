Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F7559CD51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 02:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiHWAqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 20:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHWAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 20:46:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F88D4B4BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 17:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661215579; x=1692751579;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vCuwi4E3/VijJAQtdQKEGEat8cdI8wbHNyOYjg5hlts=;
  b=MecgIKY8obd64Nv1tkm23FqtSmUq4+dYvMJnVI7TaRLXeIqaSdg2Ktmo
   5ogTtflUyN5u+gfxJHWb8bRooGrN8V9nvR/ur2l2R9bebSGrCEt1RE7YZ
   0hKfwhsqL9aV70W8vIE3Zo/DctLR2j/m2qmyKsq19DPuqRpKdL/mZv8XW
   dGjllGiORRGVGGA2tVrKIxV6M1sxe2IuEdT1Xc1fLEiYtW4KXuf0dMqLn
   mG8xcKfJ/RNXRzEmRDAdEa6kVLvBAqBHjk/UpsnQrsfb94OXAh7Z7/8iU
   dwzbRjTqgPCFAL7cDwoZOphKkI5MGbNdIrWvAYNuq/mDWq95kqSzXEZCK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="357538083"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="357538083"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 17:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="751491575"
Received: from lkp-server01.sh.intel.com (HELO dd9b29378baa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 17:46:18 -0700
Received: from kbuild by dd9b29378baa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQI3d-0000vF-16;
        Tue, 23 Aug 2022 00:46:17 +0000
Date:   Tue, 23 Aug 2022 08:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:arm64/alternatives/rework 10/12]
 arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for
 'patch_apply_nops'
Message-ID: <202208230839.mq5IC59A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/alternatives/rework
head:   c6f1e900bb0e1c5932f9995feaf4acb70cf6f62e
commit: f1665fd81160e18d4c71f4edcfd25c41e248fb67 [10/12] HACK: nops
config: arm64-randconfig-r034-20220821 (https://download.01.org/0day-ci/archive/20220823/202208230839.mq5IC59A-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=f1665fd81160e18d4c71f4edcfd25c41e248fb67
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/alternatives/rework
        git checkout f1665fd81160e18d4c71f4edcfd25c41e248fb67
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ drivers/firmware/efi/libstub/ drivers/net/ethernet/realtek/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/alternative.c:269:14: warning: no previous prototype for 'patch_apply_nops' [-Wmissing-prototypes]
     269 | noinstr void patch_apply_nops(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~


vim +/patch_apply_nops +269 arch/arm64/kernel/alternative.c

   268	
 > 269	noinstr void patch_apply_nops(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
