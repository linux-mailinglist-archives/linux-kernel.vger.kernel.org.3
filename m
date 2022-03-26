Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7414E7FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 07:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiCZHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCZHAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 03:00:39 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A5731927
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648277942; x=1679813942;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AYrf/B8kMTsq/PiS31xCTD9BYAirC6JhFSYdYCzH648=;
  b=ERxpXrPkJRd7X+k8amqB8YzFCXgFYt1NJHF0pkZuL4eeGuu8PhwC/NR9
   Dfp3A5LuVyJWpmBvNYViXv6cOLPhGbC4TjN80deiPps84bhQH5aiFBL4Z
   hurmpB1s4hGHJvE+u9KkRZjjZEthctvf4V23XWQy4koXG/B3FGlJrjCt6
   fzW7AcdYR4WUF/0qjJyZVmnus+t+y+xbZgmWggcVKKVTIf7GZ78OrUTjL
   gVMHSM7l7zGkwzqXRhX40RQwbktUiqzAiYnZ35b/Ns5t3ZgNXFvGR7UMR
   7nFejCE64BDli1TUkVY6azIZCcC0/ZREwM3uOJs/71NcTZRzk9caIA4gZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="319467077"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="319467077"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 23:59:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="520440911"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2022 23:58:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY0O2-000N6A-W5; Sat, 26 Mar 2022 06:58:59 +0000
Date:   Sat, 26 Mar 2022 14:58:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: WARNING: modpost: vmlinux.o(.data+0x10816c): Section mismatch in
 reference from the variable sensor_dev_attr_fan1_min to the function
 .init.text:set_reset_devices()
Message-ID: <202203261403.MQr5HvWs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: f334f5668bedf7307f6df1d98b14f55902931926 ilog2: force inlining of __ilog2_u32() and __ilog2_u64()
date:   2 days ago
config: riscv-randconfig-r031-20220325 (https://download.01.org/0day-ci/archive/20220326/202203261403.MQr5HvWs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f334f5668bedf7307f6df1d98b14f55902931926
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f334f5668bedf7307f6df1d98b14f55902931926
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x10816c): Section mismatch in reference from the variable sensor_dev_attr_fan1_min to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_fan1_min references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10820c): Section mismatch in reference from the variable sensor_dev_attr_fan2_div to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_fan2_div references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x106cf0): Section mismatch in reference from the variable sensor_dev_attr_in2_min to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in2_min references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10da34): Section mismatch in reference from the variable sensor_dev_attr_in2_input to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in2_input references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10e468): Section mismatch in reference from the variable sensor_dev_attr_temp1_alarm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_temp1_alarm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10e488): Section mismatch in reference from the variable sensor_dev_attr_temp2_alarm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_temp2_alarm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10e4a8): Section mismatch in reference from the variable sensor_dev_attr_temp3_alarm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_temp3_alarm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x101ed0): Section mismatch in reference from the variable dev_attr_w1_seq to the function .init.text:set_reset_devices()
The variable dev_attr_w1_seq references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10e528): Section mismatch in reference from the variable sensor_dev_attr_in3_max to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in3_max references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10e5a8): Section mismatch in reference from the variable sensor_dev_attr_in7_max to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in7_max references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x10eb88): Section mismatch in reference from the variable sensor_dev_attr_in2_alarm to the function .init.text:set_reset_devices()
The variable sensor_dev_attr_in2_alarm references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0xff0ac): Section mismatch in reference from the variable af9033_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x104ff0): Section mismatch in reference from the variable twl4030_bci_driver to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108408): Section mismatch in reference from the variable sensor_dev_attr_fan5_min to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108428): Section mismatch in reference from the variable sensor_dev_attr_fan5_div to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108448): Section mismatch in reference from the variable sensor_dev_attr_fan5_alarm to the variable .init.text:.LBB58_27
<< WARNING: modpost: vmlinux.o(.data+0x108488): Section mismatch in reference from the variable sensor_dev_attr_pwm5_mode to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084a8): Section mismatch in reference from the variable sensor_dev_attr_fan6_input to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x1084c8): Section mismatch in reference from the variable sensor_dev_attr_fan6_min to the variable .init.text:.LBB58_28
<< WARNING: modpost: vmlinux.o(.data+0x108508): Section mismatch in reference from the variable sensor_dev_attr_fan6_alarm to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.data+0x108528): Section mismatch in reference from the variable sensor_dev_attr_pwm6 to the function .init.text:set_reset_devices()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
