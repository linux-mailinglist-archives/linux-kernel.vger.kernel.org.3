Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAF156CD9F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 09:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGJH3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGJH3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 03:29:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B527665
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657438143; x=1688974143;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9O+OkUENgcO6cLKaK50p6DsbXWBCFxpFd1+tPMFEj6E=;
  b=YGBmxz2v0z060bJxiVvtpnxr+WgYz743t6jJIn1Q2idnW7R5cC9NCwl9
   RQK7UpOkqyxBChxw3gHzAzn2ZiSPJA/jE3krepcv0+XkKNqV2CdSA9eNg
   9MjnjOe0BZHzavQZQ9AuyQVfWxyQDG50gZO52RUdELbk6wWDGdU7xhBZq
   +gLxgl5N/RYNkhTner7oBcaNuj77FbjAH8AsmFR22OQZ8VFhfQUZqg3fg
   P8DtkBLCPZgR/I71ph5MlP55sbvDpA5h11BXXJllHAApXFUVzmIf6PakH
   RKL29Ed2RIGjUCnxdpK/PGFXnrQokyRbNUSGl7MWNGlMC7iR+nMqlhQl0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="282040326"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="282040326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 00:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="569410432"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2022 00:29:01 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oARNF-000PZ2-5W;
        Sun, 10 Jul 2022 07:29:01 +0000
Date:   Sun, 10 Jul 2022 15:28:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-next 4/10] WARNING: modpost:
 vmlinux.o(___ksymtab_gpl+acpi_tbl_allow_setup+0x0): Section mismatch in
 reference from the variable __ksymtab_acpi_tbl_allow_setup to the function
 .init.text:acpi_tbl_allow_setup()
Message-ID: <202207101514.rmPlHWht-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-next
head:   d43700a128bf0d6e35dea23d9abf8d20e13151b2
commit: 721cbb4948e37c53cacbaa5925b2b65714dae1fa [4/10] Merge remote-tracking branch 'origin/guest-filter' into guest-5.19
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220710/202207101514.rmPlHWht-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/721cbb4948e37c53cacbaa5925b2b65714dae1fa
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-next
        git checkout 721cbb4948e37c53cacbaa5925b2b65714dae1fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(___ksymtab_gpl+acpi_tbl_allow_setup+0x0): Section mismatch in reference from the variable __ksymtab_acpi_tbl_allow_setup to the function .init.text:acpi_tbl_allow_setup()
The symbol acpi_tbl_allow_setup is exported and annotated __init
Fix this by removing the __init annotation of acpi_tbl_allow_setup or drop the export.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
