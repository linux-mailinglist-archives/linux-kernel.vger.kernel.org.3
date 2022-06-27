Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A955D608
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbiF0Sjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbiF0Si3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:38:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D9AF6F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656355066; x=1687891066;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T4uuBvNFjKg6EDQsHBWofjo+hbh+hcjj0XNxkBhknC4=;
  b=f9cMTRGU9KIMPaG4EKhTmkh5TibjS3BibQwzEl/Reve7s/b+mR7YqZdk
   pg516EjwnMrnZrc3iYCDFFK7FDBQd7qMwymjQIn5rZpWwpwmZm1wSVsx8
   DZYMH1NY41vDqRiyv54mdKyPHwORSgcFFX88pOfo7cFKdBS5rpZsUoMzY
   4stE6Ucnixklt+TFQ5FeppT/YHeuo+mWRLCsBv+X1rfQhZ/Y+9IkCgV09
   HWX13YyhodwGI0hoEMukMZmZsGQPQXzgGMYvxJR1bz3qzHZoeyGB6wMoH
   u/DjnkwjfijH/boxiju01rY6bQww5F+3CTWNoryIiXLUug8Rx9hkwvgB7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345532082"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345532082"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 11:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="692738465"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2022 11:37:44 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5tcF-0008s0-Fz;
        Mon, 27 Jun 2022 18:37:43 +0000
Date:   Tue, 28 Jun 2022 02:36:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next 6/8] pci-epf-vntb.c:undefined reference to
 `ntb_db_event'
Message-ID: <202206280254.MJOpIIDp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jonmason/ntb ntb-next
head:   0c4b285d9636cc850f55151fa6a250dd131e5192
commit: ff32fac00d97661c715ee47bbfd867cae1f3aaf8 [6/8] NTB: EPF: support NTB transfer between PCI RC and EP connection
config: arm64-randconfig-s031-20220627 (https://download.01.org/0day-ci/archive/20220628/202206280254.MJOpIIDp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://github.com/jonmason/ntb/commit/ff32fac00d97661c715ee47bbfd867cae1f3aaf8
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next
        git checkout ff32fac00d97661c715ee47bbfd867cae1f3aaf8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: ID map text too big or misaligned
   aarch64-linux-ld: drivers/pci/endpoint/functions/pci-epf-vntb.o: in function `epf_ntb_cmd_handler':
>> pci-epf-vntb.c:(.text+0x3b8): undefined reference to `ntb_db_event'
>> aarch64-linux-ld: pci-epf-vntb.c:(.text+0x464): undefined reference to `ntb_link_event'
   aarch64-linux-ld: pci-epf-vntb.c:(.text+0x4cc): undefined reference to `ntb_link_event'
   aarch64-linux-ld: drivers/pci/endpoint/functions/pci-epf-vntb.o: in function `pci_vntb_probe':
>> pci-epf-vntb.c:(.text+0xf80): undefined reference to `ntb_register_device'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
