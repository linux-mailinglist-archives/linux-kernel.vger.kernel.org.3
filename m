Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944B257F202
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 01:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiGWXCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 19:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGWXB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 19:01:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597FD1A062
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658617317; x=1690153317;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=G+vz1+5hIfV13aTIc3keuA9U09XAPZFH0NH9VZw29vY=;
  b=e1P3oHpYO2vXT4G2VQMKTG9vJly+IfA4MK1eKk4Pgn5R3PsdBN0KFEp8
   quVcY3+qW0prs6aO2iUS9Yhcs5E2C1fJoEM7NULEgcDU3v6VamH+nm7AB
   EN5oTPBr15kE2cN3RwZPpUpzo1MlT/zEXvjdCkcnsjZvZTAHyTxsROewm
   5X6148wGcwcfTUOPWrpRQkYA8V4S3QAgv4NiFpPZGJDYCWGI/eZDdNmV2
   L+l+Gapnj7UqI7XYgNu0DIRCWElheS/R8y1BMusZAilBmbpabEf+D/dVu
   ICoKO14muhn1tnXk3DZsrrXpDAadH5Q3ihG+lTpHam5Vuy8WpY5HvKTlX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="267891313"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="267891313"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 16:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="702061265"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2022 16:01:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFO8B-0003CZ-0N;
        Sat, 23 Jul 2022 23:01:55 +0000
Date:   Sun, 24 Jul 2022 07:01:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: arch/arm64/kernel/proton-pack.c:775:14: warning: no previous
 prototype for 'spectre_bhb_patch_loop_mitigation_enable'
Message-ID: <202207240659.cxSiTCFF-lkp@intel.com>
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

Hi James,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   515f71412bb73ebd7f41f90e1684fc80b8730789
commit: ba2689234be92024e5635d30fe744f4853ad97db arm64: entry: Add vectors that have the bhb mitigation sequences
date:   5 months ago
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20220724/202207240659.cxSiTCFF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba2689234be92024e5635d30fe744f4853ad97db
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ba2689234be92024e5635d30fe744f4853ad97db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm64/kernel/proton-pack.c:537:13: warning: no previous prototype for 'spectre_v4_patch_fw_mitigation_enable' [-Wmissing-prototypes]
     537 | void __init spectre_v4_patch_fw_mitigation_enable(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/proton-pack.c:557:13: warning: no previous prototype for 'smccc_patch_fw_mitigation_conduit' [-Wmissing-prototypes]
     557 | void __init smccc_patch_fw_mitigation_conduit(struct alt_instr *alt,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:775:14: warning: no previous prototype for 'spectre_bhb_patch_loop_mitigation_enable' [-Wmissing-prototypes]
     775 | void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/proton-pack.c:783:14: warning: no previous prototype for 'spectre_bhb_patch_fw_mitigation_enabled' [-Wmissing-prototypes]
     783 | void noinstr spectre_bhb_patch_fw_mitigation_enabled(struct alt_instr *alt,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/spectre_bhb_patch_loop_mitigation_enable +775 arch/arm64/kernel/proton-pack.c

   773	
   774	/* Patched to NOP when enabled */
 > 775	void noinstr spectre_bhb_patch_loop_mitigation_enable(struct alt_instr *alt,
   776							     __le32 *origptr,
   777							      __le32 *updptr, int nr_inst)
   778	{
   779		BUG_ON(nr_inst != 1);
   780	}
   781	
   782	/* Patched to NOP when enabled */
 > 783	void noinstr spectre_bhb_patch_fw_mitigation_enabled(struct alt_instr *alt,

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
