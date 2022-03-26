Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946154E813D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 14:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiCZOAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbiCZN7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 09:59:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5326FC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648303099; x=1679839099;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qFiYEHnnDLkVTdCkYQf7DsZUgmu5gysW9RRE3CX95+Q=;
  b=gvNeDdS1vJ4XX5FbrIXnXePDS22eUMzQC9ImCtOjIpgLW3zigWPIeMsN
   o0pHvyZucP4IUlwxuJJpOT4j+ksqIBG0J/fa+UFOo0kQM6BtJ+E3WyFTr
   LeAW0Bnb9tCBdr8ySvS4gy4B55S/eTj/DrkmBf0JTlvxWmGfcGDX4ZdYc
   R+JQX27BUBIi2XsfF6tDD2ZbL5+fJmMV0AvnO3SViW5vsrrGLaNwsmAXz
   ym1oGnJZMOrUPV3h/T8rBIAN8XmQoODwH9DmR6Zpr7UNlCxrL1pWD8t6C
   BDIA2mpfo9nNO3Dj8LlyXgbZHZbu3Sb4nlW6jC/DFvXj1y0bPBTkZCD2e
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258500369"
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="258500369"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 06:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,213,1643702400"; 
   d="scan'208";a="520497973"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 26 Mar 2022 06:58:17 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY6vo-000NQR-UW; Sat, 26 Mar 2022 13:58:16 +0000
Date:   Sat, 26 Mar 2022 21:57:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sparx5_ptp.c:undefined reference to `ptp_clock_register'
Message-ID: <202203262159.99fOYx0b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   52d543b5497cf31d6baeb0bcfe5a5474c3238578
commit: 0933bd04047c3b96ba49545a8f91e7e6f8f666ff net: sparx5: Add support for ptp clocks
date:   3 weeks ago
config: arc-randconfig-r013-20220324 (https://download.01.org/0day-ci/archive/20220326/202203262159.99fOYx0b-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0933bd04047c3b96ba49545a8f91e7e6f8f666ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 0933bd04047c3b96ba49545a8f91e7e6f8f666ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o: in function `sparx5_ptp_init':
>> sparx5_ptp.c:(.text+0x758): undefined reference to `ptp_clock_register'
>> arc-elf-ld: sparx5_ptp.c:(.text+0x758): undefined reference to `ptp_clock_register'
   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o: in function `sparx5_ptp_deinit':
>> sparx5_ptp.c:(.text+0x8b2): undefined reference to `ptp_clock_unregister'
>> arc-elf-ld: sparx5_ptp.c:(.text+0x8b2): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0x8ba): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0x8ba): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: sparx5_ptp.c:(.text+0x8c6): undefined reference to `ptp_clock_unregister'
   arc-elf-ld: drivers/net/ethernet/microchip/sparx5/sparx5_ptp.o:sparx5_ptp.c:(.text+0x8c6): more undefined references to `ptp_clock_unregister' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
