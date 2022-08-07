Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA52E58B916
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHGDkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 23:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:40:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B290BBC86
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659843620; x=1691379620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jANGn6OnsR+H4e78eLTxbCS4JpAcCY2bilmWpSMtsDg=;
  b=J0O67/vz+XRtZliAh4guCaMoNT1r7tBAVPyigQqED0Iwf6Eb5sgoI/OG
   XrgL1jwUGFBb/anFzEXr3YY5i7Tnk3vmas9Wm4dxIVlVLpcsu0SIhKs7P
   Y0VrNsL4KBd649luTiT1zJ+YK1pI14GOQZgWDUVVUQ0QHJ8KuTczxwlzG
   TccpvcplTFjSCXTuiLssHRS5Ha0/EvB7h8/+4WPFeVNbv/zciJHxLTm4+
   KEXRXCgHMCBhwiSMRp9/pf/tzuCKBobBCRXS5DIpSWj8I6J5RSwQeS4Ig
   488jYmwzMJfcsWc4k7o4pbwZNX08yoXYdDpHm0p+YoAVPtHQq+5t08IZv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352133156"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="352133156"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 20:40:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="636908980"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Aug 2022 20:40:18 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKX9G-000Kvj-0V;
        Sun, 07 Aug 2022 03:40:18 +0000
Date:   Sun, 7 Aug 2022 11:40:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_devlink_locking 27/32] csky-linux-ld:
 dev.c:undefined reference to `devlink_port_type_clear'
Message-ID: <202208071124.wMUnjLOt-lkp@intel.com>
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
config: csky-buildonly-randconfig-r005-20220805 (https://download.01.org/0day-ci/archive/20220807/202208071124.wMUnjLOt-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/55707d417479fd2114328559a30128d4ef56d6fe
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_devlink_locking
        git checkout 55707d417479fd2114328559a30128d4ef56d6fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: net/core/dev.o: in function `unregister_netdevice_many':
   dev.c:(.text+0xd824): undefined reference to `devlink_port_type_clear'
>> csky-linux-ld: dev.c:(.text+0xda94): undefined reference to `devlink_port_type_clear'
   csky-linux-ld: net/core/dev.o: in function `register_netdevice':
   dev.c:(.text+0xfe00): undefined reference to `devlink_port_type_eth_set'
   csky-linux-ld: net/core/dev.o: in function `register_netdev':
   dev.c:(.text+0xfe9c): undefined reference to `devlink_port_type_eth_set'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
