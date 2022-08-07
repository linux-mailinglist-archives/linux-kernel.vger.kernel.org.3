Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AA258B913
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 05:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiHGDa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:30:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4190D2615
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659843021; x=1691379021;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2LCYOkYtfHQG0nS+xMf7u5aOmP1SGgbzvD7ghCox/0=;
  b=aDw+A8HL0dGTYCxtr5a7aAgTySJ8Q73OX9/DyhDrbxApeLW3mhV30yMM
   8vIN1FYvxeQosKc+bX4cjr/FFLUrQOYHvZD9V9qwbcalcb9rMHoIpzPOk
   gzkXY3L++nsvyFSZUfte3aHxPJkXMk/hlAXCrmq55ph1unP47H558CsNS
   n91Il0f6ZWv7CVo5daHVjbcAU5gK9CaIBm7YF+e70L5KIqnNElY/MKWdA
   tW107SL9rjeuFheQfb0Hq/TYd/Gqs29xM29cye7PUL87/PhIGQfzjvDzq
   uaHHatgkySim1mZlCmr0CgeW2Rat9caTXVcVrxGLUUJMHFx5ctqwlB7wi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="354407317"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="354407317"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 20:30:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="849720720"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2022 20:30:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKWzZ-000KvF-38;
        Sun, 07 Aug 2022 03:30:17 +0000
Date:   Sun, 7 Aug 2022 11:29:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 27/32] arc-elf-ld:
 dev.c:undefined reference to `devlink_port_type_clear'
Message-ID: <202208071108.o0uvW2kW-lkp@intel.com>
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

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_devlink_locking
head:   f5ed8076238d620b1c6b4fd87fef0c8fececdc5e
commit: 55707d417479fd2114328559a30128d4ef56d6fe [27/32] net: devlink: use SET_NETDEV_DEVLINK_PORT to set devlink_port link to netdev
config: arc-axs103_smp_defconfig (https://download.01.org/0day-ci/archive/20220807/202208071108.o0uvW2kW-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/55707d417479fd2114328559a30128d4ef56d6fe
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 55707d417479fd2114328559a30128d4ef56d6fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: net/core/dev.o: in function `unregister_netdevice_many':
   dev.c:(.text+0x6468): undefined reference to `devlink_port_type_clear'
>> arc-elf-ld: dev.c:(.text+0x6468): undefined reference to `devlink_port_type_clear'
   arc-elf-ld: net/core/dev.o: in function `register_netdevice':
   dev.c:(.text+0xd00c): undefined reference to `devlink_port_type_eth_set'
>> arc-elf-ld: dev.c:(.text+0xd00c): undefined reference to `devlink_port_type_eth_set'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
