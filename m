Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52215777C8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiGQSgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiGQSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 14:36:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC212752
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658082961; x=1689618961;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mj0DK8nSoDg1DlxnyHy7eNjSESKokHmaS/AVgZwHn5U=;
  b=I3G8d/N+Aads7u+PgQ+oFJn0FZ9GAapXYo4p15rc/QH7KBkQF0ZDkh+a
   jqaX57beJTGgBEBJWxj9zu6PR7x9ekdWlXBZ4InP0bapqloI9sMVZyuCY
   2k+ygQmhFBWi1pZL0p8XIVZgUH1sxDB7omCWKlVDmM0kJXyUCv1rsdrE5
   RCuMt+8/EO2JaBnDwjzZ/ttai0ZDchntogxIk51cUNGZq0wD64NxEvhom
   KY1nNcs3d5JzZbhVInsoVvA924q4utu74fyTAp9pVsA2wq9jMK/V6aj3I
   CqVykpUyPRiz3qNqXSFPnuxNaB5bjzyHiR58QeSwfcK0Ztz0Hvy5I+sGP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="269105360"
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="269105360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 11:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,279,1650956400"; 
   d="scan'208";a="624457674"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Jul 2022 11:35:59 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oD97W-0003ZW-SY;
        Sun, 17 Jul 2022 18:35:58 +0000
Date:   Mon, 18 Jul 2022 02:35:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [stffrdhrn:or1k-virt-3 4/6] WARNING: modpost:
 drivers/net/ethernet/qlogic/qed/qed.o(.data+0x34f8): Section mismatch in
 reference from the variable qed_mfw_ext_maps to the variable
 .init.rodata:qed_mfw_ext_1g
Message-ID: <202207180220.1WmjPVqM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/stffrdhrn/linux.git or1k-virt-3
head:   4b1ece79cac02d6d81af76e47f8e7d493dcd50a0
commit: 49a31c9ed530b7df3ec171a7f8f88d06ce720b0a [4/6] openrisc: Add pci bus support
config: openrisc-randconfig-c033-20220717 (https://download.01.org/0day-ci/archive/20220718/202207180220.1WmjPVqM-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/stffrdhrn/linux/commit/49a31c9ed530b7df3ec171a7f8f88d06ce720b0a
        git remote add stffrdhrn https://github.com/stffrdhrn/linux.git
        git fetch --no-tags stffrdhrn or1k-virt-3
        git checkout 49a31c9ed530b7df3ec171a7f8f88d06ce720b0a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x34f8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_ext_1g
The variable qed_mfw_ext_maps references
the variable __initconst qed_mfw_ext_1g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3510): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_ext_10g
The variable qed_mfw_ext_maps references
the variable __initconst qed_mfw_ext_10g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x35e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_20g
The variable qed_mfw_legacy_maps references
the variable __initconst qed_mfw_legacy_20g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3600): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_25g
The variable qed_mfw_legacy_maps references
the variable __initconst qed_mfw_legacy_25g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3618): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_40g
The variable qed_mfw_legacy_maps references
the variable __initconst qed_mfw_legacy_40g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x3630): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_50g
The variable qed_mfw_legacy_maps references
the variable __initconst qed_mfw_legacy_50g
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0xe0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_1000
The variable qede_forced_speed_maps references
the variable __initconst qede_forced_speed_1000
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0xf8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_10000
The variable qede_forced_speed_maps references
the variable __initconst qede_forced_speed_10000
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x110): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_20000
The variable qede_forced_speed_maps references
the variable __initconst qede_forced_speed_20000
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x128): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_25000
The variable qede_forced_speed_maps references
the variable __initconst qede_forced_speed_25000
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x140): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_40000
The variable qede_forced_speed_maps references
the variable __initconst qede_forced_speed_40000
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

..

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
