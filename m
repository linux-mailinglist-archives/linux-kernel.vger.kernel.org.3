Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C380A5777EA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiGQTRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiGQTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:17:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50488DF1F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658085423; x=1689621423;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=7mf8+oh7Z5RFCHtFw7Hki9y+PXrX8mHg2vyaWdEeFco=;
  b=R03VwzexXCMnl9RelINPRU4KWafR55xa6jur4UmU6rZj31okMjp9JbfL
   g/r7NdBTx834a10S4jzNvb0J122R7p+Xh7BawTh6KhPjSkf2P3wdsFgCP
   IGjbpIscX6vHwVEtoejaA4ypLI3ZbQePv2+MuczIS+WGhQXGb97Z5XWMh
   1RNOdIQ16K44GOf235uNxvtCe4A3CbCegMcFKuaFuYdQr/CKsFOUK7tdE
   GuLM2JMcmbAH33/VukBnFV/hHRHSNCy+GqJEP1OzZ1BWKWYRaGD6gsjFo
   Lxrov6Vj5p4sLgwP0PjcLbM1AEnY8ngQBxmcju3Ry9wK9qyB+fr78ef3i
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286822584"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="286822584"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 12:17:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="597029265"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2022 12:17:01 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD9lE-0003by-TU;
        Sun, 17 Jul 2022 19:17:00 +0000
Date:   Mon, 18 Jul 2022 03:16:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:kvm_perf_rfc_buildtest 15/24] WARNING: modpost:
 vmlinux.o(.text+0xa708): Section mismatch in reference from the function
 early_memremap_prot() to the function .init.text:early_ioremap()
Message-ID: <202207180359.UjMwipSN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux kvm_perf_rfc_buildtest
head:   ff2f56ec4ff4f67ae3da3936939b1dcf53099a6e
commit: 5faed77192c5455fe17fb4e6aea87e5bcc48a13d [15/24] COVER
config: loongarch-randconfig-c004-20220717 (https://download.01.org/0day-ci=
/archive/20220718/202207180359.UjMwipSN-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=3D1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/=
make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/5faed77192c5455fe17fb4e6=
aea87e5bcc48a13d
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 kvm_perf_rfc_buildtest
        git checkout 5faed77192c5455fe17fb4e6aea87e5bcc48a13d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0 make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Dloongarch SHELL=3D/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa708): Section mismatch in reference=
 from the function early_memremap_prot() to the function .init.text:early_i=
oremap()
The function early_memremap_prot() references
the function __init early_ioremap().
This is often because early_memremap_prot lacks a __init
annotation or the annotation of early_ioremap is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x15e40): Section mismatch in=
 reference from the variable L0=01 to the function .init.text:early_ioremap=
()

--=20
0-DAY CI Kernel Test Service
https://01.org/lkp
