Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4836251FD68
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiEIMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiEIMwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:52:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001FE1A9ACD
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 05:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652100528; x=1683636528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ALg/xWRxsXDbHFICzwU0J9vs+kGdb1yVHzNMxIPBbMU=;
  b=CeDsAAW1oMwDswcsy3mKclUd2chhA3AF/jG+mmObv3r2kghoz2R5BQ88
   y9fqO0MIw7FsmpkO6y6fbrGt3/yxE00mRUznuVbnLQQnTbOhVjuEAiO4e
   h0VA121RYnXY+7NfoNcw2b0W4p7DF3t7QBCHiAEkn0XU19NBALrzQlGhS
   OgSRNRhoGRGaByaaB16DAvSI+m03Pmw7p0m3OqiWSvZ0NiSCJPSzusCgv
   2kaHKq2uXeL4yzv2o3y4psK9HTlYg57qhaRAxuFXq4Cif4IKCWRfUAzs4
   jHlleY5p2qWFyN8/DblDEw8mbsW6CCjeb+K3FDHdpse8S27/l75xZ1aVv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="329631644"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="329631644"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 05:48:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="710510466"
Received: from rli9-dbox.sh.intel.com (HELO rli9-dbox) ([10.239.159.142])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 05:48:46 -0700
Date:   Mon, 9 May 2022 20:46:59 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [ammarfaizi2-block:crng/random/master 29/29] WARNING: modpost:
 vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the
 variable .L0 to the variable .debug_str:.LASF1747
Message-ID: <YnkNQ51hnNsgH2hT@rli9-dbox>
References: <202205091658.vQtGGjeg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205091658.vQtGGjeg-lkp@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 04:33:29PM +0800, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
> head:   26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
> commit: 26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2 [29/29] random: use symbolic constants for crng_init states
> config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091658.vQtGGjeg-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 11.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block crng/random/master
>         git checkout 26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
>         # save the config file
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):

Sorry, kindly ignore this report, which is a false positive.

> 
> >> WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1747
> FATAL: modpost: extable_entry size hasn't been discovered!
> 
> Note: the below error/warnings can be found in parent commit:
> << WARNING: modpost: vmlinux.o(.text+0xa76b86): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xbacbf2): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1744
> << WARNING: modpost: vmlinux.o(.text+0xae24ec): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2b2e): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2c8c): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xae2cb0): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb1f67e): Section mismatch in reference from the function thermal_zone_device_enable() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb1f688): Section mismatch in reference from the function thermal_zone_device_disable() to the variable .init.text:.L0
> << WARNING: modpost: vmlinux.o(.text+0xb201d8): Section mismatch in reference from the function thermal_of_cooling_device_register() to the variable .init.text:.L0
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
