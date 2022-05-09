Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63D51F76D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbiEII7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbiEIIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:38:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80FD1F35D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652085272; x=1683621272;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RHN7+I8GCJh2LKbkuT9XXuEV0EhhnlsHUw8qBztN6LM=;
  b=MpR/Z3n8CrOpgK0T/zVk10Ye8sNoFIXQ2a29aVTgffcmK8+zLaMzGh1E
   qDy3xTUmOY5OkNM/vjiQGYlhZb1tF24/eLkbTfroXopx7wfs/KnhDKMLd
   LcU3tBZC9xqvMlXNKkQ9lgV6v3gy6LVSwbjTAoHiZnpuj0HSkInT4RUCa
   CH9DFFfaKhIQ3y8ou0zUXwScKP96Oh3RmRpopW+kp5nSO3MU1GlPYlbbv
   N80uwo6rmmyV30hRKrlcIsxISBFWXH5rt5ZNHQ+88Ljqyzk8JDNrgAApA
   NcFZ7frFmwYQPLqDpPxOUXZkBLgIBzapSn3EYz+GvEHxqm11K+dHJ3Azp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="332014350"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="332014350"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 01:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="813374454"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 09 May 2022 01:33:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnypi-000GLs-8Q;
        Mon, 09 May 2022 08:33:34 +0000
Date:   Mon, 9 May 2022 16:33:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/master 29/29] WARNING: modpost:
 vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the
 variable .L0 to the variable .debug_str:.LASF1747
Message-ID: <202205091658.vQtGGjeg-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block crng/random/master
head:   26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
commit: 26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2 [29/29] random: use symbolic constants for crng_init states
config: riscv-randconfig-r042-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091658.vQtGGjeg-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/master
        git checkout 26bcbb981eb1ab60612d6cee1bb1b5f444a23ef2
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1747
FATAL: modpost: extable_entry size hasn't been discovered!

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0xa76b86): Section mismatch in reference from the function rtc_update_irq() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xbacbf2): Section mismatch in reference from the function comedi_buf_map_get() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in reference from the variable .L0 to the variable .debug_str:.LASF1744
<< WARNING: modpost: vmlinux.o(.text+0xae24ec): Section mismatch in reference from the function ir_raw_get_allowed_protocols() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2b2e): Section mismatch in reference from the function ir_raw_event_prepare() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2c8c): Section mismatch in reference from the function ir_raw_event_free() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xae2cb0): Section mismatch in reference from the function ir_raw_event_unregister() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb1f67e): Section mismatch in reference from the function thermal_zone_device_enable() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb1f688): Section mismatch in reference from the function thermal_zone_device_disable() to the variable .init.text:.L0
<< WARNING: modpost: vmlinux.o(.text+0xb201d8): Section mismatch in reference from the function thermal_of_cooling_device_register() to the variable .init.text:.L0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
