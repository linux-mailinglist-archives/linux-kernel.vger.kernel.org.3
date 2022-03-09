Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A604D2EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiCIMTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiCIMTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:19:08 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0E2EAC5D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646828289; x=1678364289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7QsU93+Hmc3TWJrVTMFYY0/oZ8urJfIJRWeYfj9wL+Y=;
  b=nbNpCn3Kd8rKpiVdDonVzlb7qPu1hagE3H5citerTXot2XQutBcKjxAv
   82PIX6rWGGL021EBYcQ+1wmHQn5ox6fH+M/FJlG+dyLlzpyuoiGJ8INR6
   FaBEjQLD7S6DS/iqCC3qDFiaVuiCoTtNi5j8Lt6hHZ+bHIr9h0jlppQBQ
   A7ETfn2Snt0KuZtVSPNFp1TBkx+kQMYl1q8g0gnqdzDPuBonz4WikMHG9
   QAEpkCKfFJYvf2gEFwYH2gh/GwiwIPF+r+7CID1X/1s0wXGTBE88V2yJa
   Ez/I9jPTe9Ppy+eXIgZjhhLBIU0tjQ0YBoiWW6bpFHK068bKwCL98vvY2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235568748"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="235568748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 04:18:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="547605939"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2022 04:18:07 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRvGY-0003Dc-Px; Wed, 09 Mar 2022 12:18:06 +0000
Date:   Wed, 9 Mar 2022 20:17:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Janne Grunau <j@jannau.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/090-spi-hid 11/12] WARNING: modpost:
 vmlinux.o(.text+0xd102d6): Section mismatch in reference from the function
 __of_remove_property_sysfs() to the variable .init.text:.L0
Message-ID: <202203092049.VcyMVRt9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   5e8dcc1ce6c0e41770619875b11fd66e26bc7bc7
commit: b3a105362f319c01ed074b19345679271bb364f8 [11/12] HID: magicmouse: add support for Macbook trackpads
config: riscv-randconfig-r042-20220308 (https://download.01.org/0day-ci/archive/20220309/202203092049.VcyMVRt9-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/b3a105362f319c01ed074b19345679271bb364f8
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout b3a105362f319c01ed074b19345679271bb364f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xd102d6): Section mismatch in reference from the function __of_remove_property_sysfs() to the variable .init.text:.L0
The function __of_remove_property_sysfs() references
the variable __init .L0 .
This is often because __of_remove_property_sysfs lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xd10312): Section mismatch in reference from the function __of_update_property_sysfs() to the variable .init.text:.L0
The function __of_update_property_sysfs() references
the variable __init .L0 .
This is often because __of_update_property_sysfs lacks a __init
annotation or the annotation of .L0 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xdc7e28): Section mismatch in reference from the function mcb_bus_put() to the variable .exit.text:.L0
The function mcb_bus_put() references a variable in an exit section.
Often the variable .L0 has valid usage outside the exit section
and the fix is to remove the __exit annotation of .L0 .

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xd75d34): Section mismatch in reference from the function devm_iio_kfifo_buffer_setup_ext() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xf2e068): Section mismatch in reference from the function vcc_ioctl() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x12b4): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF741
<< WARNING: modpost: vmlinux.o(.text+0xd75d34): Section mismatch in reference from the function devm_iio_kfifo_buffer_setup_ext() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xf2e068): Section mismatch in reference from the function vcc_ioctl() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x12b4): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF741
<< WARNING: modpost: vmlinux.o(.text+0xd75d34): Section mismatch in reference from the function devm_iio_kfifo_buffer_setup_ext() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xf2e068): Section mismatch in reference from the function vcc_ioctl() to the variable .exit.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x12b4): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF741

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
