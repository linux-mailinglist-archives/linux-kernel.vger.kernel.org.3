Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66AB4EBAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243201AbiC3GNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiC3GN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:13:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D231526
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648620703; x=1680156703;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=thfGUpqhOyI6a90+qXLlcmkfmx+tYGEK4nalojXYjfM=;
  b=UJjnrgioQy0eIHu9U2fEsrKmUfCDHv6THjkV4+nKqJl86hEdF3ZHFoJ3
   ddNZP6/sWgNAi5PAS5qQXL1ooA5PCDpCjzYqix5CRQaYwjnG8G5SM8LVH
   W6YO6SgReQovhHNvvRWrwMI74iTPokn7gRCADyJ/ZxLCvRMXjWMYuIwt/
   kx85e3t1/9rurEg2gYlW7hgHbJCwVjg7EsnaLWYzK/KA8pne8pIFrAujI
   pI7lDZk0ELiT2EoMJIoQ8fcX5Bmc4x/rrQvxwJgW/G/jyDtEWnKRRFPh7
   WN8hN19iYkQ6BNacopLGnkR9GCmnIPGnwjtrqosO+toZZJR9jcrX4/jKv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="241612155"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="241612155"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 23:11:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="521764732"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2022 23:11:42 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZRYT-00012x-HW; Wed, 30 Mar 2022 06:11:41 +0000
Date:   Wed, 30 Mar 2022 14:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [saeed:mlx5-queue 3/6] WARNING: modpost: vmlinux.o(.text+0xa21500):
 Section mismatch in reference from the function r600_count_pipe_bits() to
 the variable .init.text:.L0
Message-ID: <202203301425.AwwypjwY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git mlx5-queue
head:   cfe89fdbec000e621d208449280a8b437b9798cc
commit: d91cde6ff5c7d9b9b2c2a8747e51432daa4bc293 [3/6] Revert "net: openvswitch: IPv6: Add IPv6 extension header support"
config: riscv-buildonly-randconfig-r002-20220329 (https://download.01.org/0day-ci/archive/20220330/202203301425.AwwypjwY-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=d91cde6ff5c7d9b9b2c2a8747e51432daa4bc293
        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
        git fetch --no-tags saeed mlx5-queue
        git checkout d91cde6ff5c7d9b9b2c2a8747e51432daa4bc293
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xa21500): Section mismatch in reference from the function r600_count_pipe_bits() to the variable .init.text:.L0
The function r600_count_pipe_bits() references
the variable __init .L0 .
This is often because r600_count_pipe_bits lacks a __init
annotation or the annotation of .L0 is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x1082068): Section mismatch in reference from the function i3c_generic_ibi_recycle_slot() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x10fd6cc): Section mismatch in reference from the function dev_pm_opp_get_voltage() to the variable .init.text:.LBB5464
<< WARNING: modpost: vmlinux.o(.text+0x10fd778): Section mismatch in reference from the function dev_pm_opp_get_level() to the variable .init.text:.LVL1150
<< WARNING: modpost: vmlinux.o(.text+0x10fd7d4): Section mismatch in reference from the function dev_pm_opp_is_turbo() to the variable .init.text:.LVL1151
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x29b9c): Section mismatch in reference from the function hwmon_device_register() to the variable .init.text:.LVL283
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF114

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
