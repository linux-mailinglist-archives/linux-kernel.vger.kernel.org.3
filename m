Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF87C51FB27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiEILVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiEILVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:21:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87822248D9
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652095031; x=1683631031;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E3F9lJvCV7D52b4WS/P9PZZC1polKbLU7pVbpD/VrA8=;
  b=XD+a65VcxcQffTCGcPlxGp1GNI7gbW1uQalLIN0kbBh0DF2y/z6WtH4I
   ZagYYx0+57jfhtoqeW7d0G7Ritpi0qLWJXCNpaIMr0xoSBSjOt0IsCtMl
   0mEetmKEDCOvYOMjKT9ErTgOXttNGyxmu1VsILRtyMYf5SSf0X1nRVBEG
   uF3AoRlCTW83BDynBZMRYj6q1I5VvQfPKEo9LKKVnpg2A4VlJD3j29+YQ
   vIi+nF1pH2b+bSOYtyzu4oJvelv+9H80JuoH2BoEYVY7C4LlVV0Tf3Ty8
   rq/vf/S8Wd6Rd5ZKG+TjoSUc7hq8OmKCsNAtx3D3e8LsmOwR0HuWW+nNy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="267859996"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="267859996"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="550978639"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 04:17:07 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no1Ny-000GSQ-QU;
        Mon, 09 May 2022 11:17:06 +0000
Date:   Mon, 9 May 2022 19:16:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     kbuild-all@lists.01.org, alaa@dev.mellanox.co.il,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [alaahl:netdev-next 6/7] WARNING: modpost:
 vmlinux.o(.text+0xba9220): Section mismatch in reference from the function
 vhost_poll_init() to the variable .init.text:.L334
Message-ID: <202205091902.efRQLfpK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alaahl/linux.git netdev-next
head:   c908565eecf2d310edddaecea6166015abe9df08
commit: fe5233b0ba0d2216d549f93e4540542b99b97642 [6/7] net: dsa: delete dsa_port_walk_{fdbs,mdbs}
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091902.efRQLfpK-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alaahl/linux/commit/fe5233b0ba0d2216d549f93e4540542b99b97642
        git remote add alaahl https://github.com/alaahl/linux.git
        git fetch --no-tags alaahl netdev-next
        git checkout fe5233b0ba0d2216d549f93e4540542b99b97642
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xba9220): Section mismatch in reference from the function vhost_poll_init() to the variable .init.text:.L334
The function vhost_poll_init() references
the variable __init .L334.
This is often because vhost_poll_init lacks a __init
annotation or the annotation of .L334 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xba9942): Section mismatch in reference from the function vhost_dev_reset_owner_prepare() to the variable .init.text:.L328
The function vhost_dev_reset_owner_prepare() references
the variable __init .L328.
This is often because vhost_dev_reset_owner_prepare lacks a __init
annotation or the annotation of .L328 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0xba9d20): Section mismatch in reference from the function vhost_log_access_ok() to the variable .init.text:.L320
The function vhost_log_access_ok() references
the variable __init .L320.
This is often because vhost_log_access_ok lacks a __init
annotation or the annotation of .L320 is wrong.
--
>> WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1172
FATAL: modpost: extable_entry size hasn't been discovered!

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x20f7e): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4e838): Section mismatch in reference from the function calc_global_load_tick() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x2c801e): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2c2): Section mismatch in reference from the function bio_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2da): Section mismatch in reference from the function disk_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d4552): Section mismatch in reference from the function blk_abort_request() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d456a): Section mismatch in reference from the function blk_rq_timeout() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x7e5972): Section mismatch in reference from the function ipu_pre_update() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x846554): Section mismatch in reference from the function scsi_track_queue_full() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x9ccb28): Section mismatch in reference from the function ohci_setup() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x20f7e): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4e838): Section mismatch in reference from the function calc_global_load_tick() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x2c801e): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2c2): Section mismatch in reference from the function bio_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2da): Section mismatch in reference from the function disk_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d4552): Section mismatch in reference from the function blk_abort_request() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d456a): Section mismatch in reference from the function blk_rq_timeout() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x7e5972): Section mismatch in reference from the function ipu_pre_update() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x846554): Section mismatch in reference from the function scsi_track_queue_full() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x9ccb28): Section mismatch in reference from the function ohci_setup() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x20f7e): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4e838): Section mismatch in reference from the function calc_global_load_tick() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x2c801e): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2c2): Section mismatch in reference from the function bio_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2da): Section mismatch in reference from the function disk_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d4552): Section mismatch in reference from the function blk_abort_request() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d456a): Section mismatch in reference from the function blk_rq_timeout() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x7e5972): Section mismatch in reference from the function ipu_pre_update() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x846554): Section mismatch in reference from the function scsi_track_queue_full() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x9ccb28): Section mismatch in reference from the function ohci_setup() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x20f7e): Section mismatch in reference from the function wq_watchdog_touch() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4e838): Section mismatch in reference from the function calc_global_load_tick() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x2c801e): Section mismatch in reference from the function autofs_clean_ino() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2c2): Section mismatch in reference from the function bio_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4cf2da): Section mismatch in reference from the function disk_start_io_acct() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d4552): Section mismatch in reference from the function blk_abort_request() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x4d456a): Section mismatch in reference from the function blk_rq_timeout() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x7e5972): Section mismatch in reference from the function ipu_pre_update() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x846554): Section mismatch in reference from the function scsi_track_queue_full() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0x9ccb28): Section mismatch in reference from the function ohci_setup() to the variable .init.text:.L0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
