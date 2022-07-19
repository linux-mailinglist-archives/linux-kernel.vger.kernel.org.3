Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFC1579115
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiGSDBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGSDBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:01:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C092724BE2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658199658; x=1689735658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M30xnMZIUZ+grVd2QiyDZCSR9tCPx6LXy2c0Zus6hVo=;
  b=Yhwq/mcHVYVUv9ubbZvREyXhn5Nnx1FCXhRPVMo1hh4iDqYhPZsBEC4H
   suv4RHWqD6FFB0fiEr3bdtqm0Uozs0WHI9RIYkMxGgwQJ8NcGqGydelTl
   HY4PSHv3FByQWDSy+3FlV1z0HXvHfvl+sCBPW+04YyBBmgRqRUbN3/vh/
   RRgXUkf4r4QTjswJ6jLHZOW48A9J2bhmK9/Ndku0HXLu0lIxkTVXSVdkk
   Q/FM/vBXazsEBO0R6Yz+iuqQzMpuJZiHMGz5qIZQij0iRSNfe0GK5IC8r
   h0yrzFhH8vPydpLbNHG0fftcQZ4sQ1yQgbeFh1ycWAC2hxaR6klagE+yE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="350336397"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="350336397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 20:00:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="739695182"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jul 2022 20:00:56 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDdTk-0005D1-5M;
        Tue, 19 Jul 2022 03:00:56 +0000
Date:   Tue, 19 Jul 2022 11:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc 15/24] WARNING: modpost:
 vmlinux.o(.text+0xb924): Section mismatch in reference from the function
 early_memremap_ro() to the function .init.text:early_ioremap()
Message-ID: <202207191043.dhBIpLaO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc
head:   f7c410879b9a723ff8fbc32e4acb668b7fee423a
commit: 20c5f15d297fb5a842bb1488be2781826b65a1dd [15/24] COVER
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20220719/202207191043.dhBIpLaO-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/20c5f15d297fb5a842bb1488be2781826b65a1dd
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc
        git checkout 20c5f15d297fb5a842bb1488be2781826b65a1dd
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xb924): Section mismatch in reference from the function early_memremap_ro() to the function .init.text:early_ioremap()
The function early_memremap_ro() references
the function __init early_ioremap().
This is often because early_memremap_ro lacks a __init
annotation or the annotation of early_ioremap is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x9abab0): Section mismatch in reference from the function __calc_tpm2_event_size() to the function .init.text:early_ioremap()
The function __calc_tpm2_event_size() references
the function __init early_ioremap().
This is often because __calc_tpm2_event_size lacks a __init
annotation or the annotation of early_ioremap is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
