Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DC14EB6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240532AbiC2XqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiC2XqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:46:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1183F10A7C9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648597475; x=1680133475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=speghwG/kDuu6gieJgV3YwbIIRKuWKtfC6MjDLbv7KI=;
  b=NrOio0ulrLagmq3TrpMYKaqMYGz0qF1zTSW7h7cymMPpYIbSdthu2bhr
   bJYK7oSR7wrYlErcIcE26AdGsCJZg4ohWaEgrH4uWfey6lXhhXmQHSleW
   tkkZKfJRk5apzC4BbUHA/pg57OJpxOB+E+k1NXoZ5o9LKZIr6ib81rRuv
   xnh+AD2xTFVbRwiHoMj8UKGKy/zypMe30evaJfDsPgeFiT9bIe+/ecZF4
   EdJepdJUMuMYxQNhGjh8yIXpgX6iOvTzkAeLWQEWuxXvlaWiPtst7qbgX
   wxH2ZrT7l21h81KeJjTaZN+LuK3tOv4wOEVVrAdlOObJisKxJniqjSCLu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258233445"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="258233445"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 16:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="585788837"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Mar 2022 16:44:32 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZLVo-0000m8-5C; Tue, 29 Mar 2022 23:44:32 +0000
Date:   Wed, 30 Mar 2022 07:43:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [ammarfaizi2-block:netdev/net/master 5/5] WARNING: modpost:
 vmlinux.o(.text+0x10fd3d4): Section mismatch in reference from the function
 dev_pm_opp_get_required_pstate() to the variable .init.text:.LVL1152
Message-ID: <202203300723.6j7VZep1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net/master
head:   ad7da1ce5749c0eb4f09dd7e5510123be56f10fb
commit: ad7da1ce5749c0eb4f09dd7e5510123be56f10fb [5/5] net: lan966x: fix kernel oops on ioctl when I/F is down
config: riscv-buildonly-randconfig-r002-20220329 (https://download.01.org/0day-ci/archive/20220330/202203300723.6j7VZep1-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ad7da1ce5749c0eb4f09dd7e5510123be56f10fb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net/master
        git checkout ad7da1ce5749c0eb4f09dd7e5510123be56f10fb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x10fd3d4): Section mismatch in reference from the function dev_pm_opp_get_required_pstate() to the variable .init.text:.LVL1152
The function dev_pm_opp_get_required_pstate() references
the variable __init .LVL1152.
This is often because dev_pm_opp_get_required_pstate lacks a __init
annotation or the annotation of .LVL1152 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x10fd708): Section mismatch in reference from the function dev_pm_opp_get_voltage() to the variable .init.text:.LBB5481
The function dev_pm_opp_get_voltage() references
the variable __init .LBB5481.
This is often because dev_pm_opp_get_voltage lacks a __init
annotation or the annotation of .LBB5481 is wrong.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF127
FATAL: modpost: extable_entry size hasn't been discovered!

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x1082068): Section mismatch in reference from the function i3c_generic_ibi_recycle_slot() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x10fd6cc): Section mismatch in reference from the function dev_pm_opp_get_voltage() to the variable .init.text:.LBB5464
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF114
<< WARNING: modpost: vmlinux.o(.text+0x10fd778): Section mismatch in reference from the function dev_pm_opp_get_level() to the variable .init.text:.LVL1150
<< WARNING: modpost: vmlinux.o(.text+0x10fd7d4): Section mismatch in reference from the function dev_pm_opp_is_turbo() to the variable .init.text:.LVL1151
<< WARNING: modpost: vmlinux.o(.text+0x12037d0): Section mismatch in reference from the function skb_send_sock_locked() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x29b9c): Section mismatch in reference from the function hwmon_device_register() to the variable .init.text:.LVL283
<< WARNING: modpost: vmlinux.o(.text+0x1082068): Section mismatch in reference from the function i3c_generic_ibi_recycle_slot() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x10fd6cc): Section mismatch in reference from the function dev_pm_opp_get_voltage() to the variable .init.text:.LBB5464
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF114
<< WARNING: modpost: vmlinux.o(.text+0x10fd778): Section mismatch in reference from the function dev_pm_opp_get_level() to the variable .init.text:.LVL1150
<< WARNING: modpost: vmlinux.o(.text+0x10fd7d4): Section mismatch in reference from the function dev_pm_opp_is_turbo() to the variable .init.text:.LVL1151
<< WARNING: modpost: vmlinux.o(.text+0x12037d0): Section mismatch in reference from the function skb_send_sock_locked() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x29b9c): Section mismatch in reference from the function hwmon_device_register() to the variable .init.text:.LVL283
<< WARNING: modpost: vmlinux.o(.text+0x1082068): Section mismatch in reference from the function i3c_generic_ibi_recycle_slot() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x10fd6cc): Section mismatch in reference from the function dev_pm_opp_get_voltage() to the variable .init.text:.LBB5464
<< WARNING: modpost: vmlinux.o(__ex_table+0x1260): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF114
<< WARNING: modpost: vmlinux.o(.text+0x10fd778): Section mismatch in reference from the function dev_pm_opp_get_level() to the variable .init.text:.LVL1150
<< WARNING: modpost: vmlinux.o(.text+0x10fd7d4): Section mismatch in reference from the function dev_pm_opp_is_turbo() to the variable .init.text:.LVL1151
<< WARNING: modpost: vmlinux.o(.text+0x12037d0): Section mismatch in reference from the function skb_send_sock_locked() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text.unlikely+0x29b9c): Section mismatch in reference from the function hwmon_device_register() to the variable .init.text:.LVL283

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
