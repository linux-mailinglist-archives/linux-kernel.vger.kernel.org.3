Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EC576757
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiGOTXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiGOTXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:23:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D2CAE4B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657913025; x=1689449025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h2wwdhzb3m3oSbvdmYu1UHx1t8/vBvIcrx4+mn/Oa4Q=;
  b=IvokG3Vk/woU6Hgu7ztbckgrUFd5bERUxYSSxggRIzpVDlU7SmUd7PGm
   AeecbkTdgD3Nafs/jMhlN+5AeoDVJZZXyYVlVSVzbYwakFacUarnNbGPF
   6Unh4cbZ8wRBtm7rz20FXGFkh56bNf3JxNR0WHFjPL7BivHqitVYJ40ts
   POpNLSKG4ciHdJnN4xPqQyFZwRdIXkpvsqPD/R1zbdx2i9odcKirLSl/R
   jMuycydK3i67+mEbmRYxwd/mSfJVfMADkDRv4G5tJT400GEzUopWUWY/Z
   odSy53ZjRtWsJcCRZTJGpiT16MsBZfobqd6uxQvzwoZOGNSW0k9xKtROL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="287022709"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="287022709"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 12:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="546767602"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 12:23:42 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCQuc-0000g8-94;
        Fri, 15 Jul 2022 19:23:42 +0000
Date:   Sat, 16 Jul 2022 03:22:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: <instantiation>:3:3: error: invalid instruction mnemonic
 'annotate_unret_safe'
Message-ID: <202207160308.NAwtZPxG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 9bb2ec608a209018080ca262f771e6a9ff203b6f objtool: Update Retpoline validation
date:   3 weeks ago
config: i386-randconfig-a011-20220704 (https://download.01.org/0day-ci/archive/20220716/202207160308.NAwtZPxG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 2da550140aa98cf6a3e96417c87f1e89e3a26047)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bb2ec608a209018080ca262f771e6a9ff203b6f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9bb2ec608a209018080ca262f771e6a9ff203b6f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <instantiation>:3:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:11:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:19:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:27:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:35:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:43:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:51:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:59:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:67:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:75:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:83:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:91:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:99:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:107:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:115:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:123:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)
    ^
   <instantiation>:131:3: error: invalid instruction mnemonic 'annotate_unret_safe'
     ANNOTATE_UNRET_SAFE
     ^~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/../../x86/xen/xen-head.S:26:2: note: while in macro instantiation
    .rept ((1 << 12) / 32)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
