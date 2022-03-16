Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5E84DB5EA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357483AbiCPQUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiCPQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:20:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F23F6D4D5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647447523; x=1678983523;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zGzQBMOw0Qa4mcBngmsvjT7talS1qvHPfaUEu4hYxNU=;
  b=j1iOk4UM0GEjWb2NEsFOq+DhG094FS963imDKckOOsZPJXZDAFVhaxo1
   IiCfBOIRv+LrmalFx8jBR6o5An7HfHW071fSCm1+YXxAdD2mB6Hfx2Glv
   FVfZE+H0OuvVRpXfNab6R9U+38GoFVsavIu7/alsKZPtVm/ffkKJ3fqDX
   8L+GupGfnUC/hRYwm0McASubwstWRhMOSUBF8uo8+YaSe7qFXpK6A9MgB
   oV/RBwZHR8vYT7xXnwHRqMoJpcKT2zks4QtdTMFYlEL4EhUUfVcXkTBNx
   xqS5w7eNJz4Nh85rWJhpGBPwruRfRdbbrUnkEXQpa1JQbUNrqQFeZ85cs
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244102227"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="244102227"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:14:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="646721998"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 09:14:03 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUWHi-000CbO-Ak; Wed, 16 Mar 2022 16:14:02 +0000
Date:   Thu, 17 Mar 2022 00:13:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 1318/9999] undefined reference to `rtnl_is_locked'
Message-ID: <202203170015.WBOInNU6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   1acd05fd846bd82c1394cdcc20b7786d0f309a2c
commit: 36ab8cea47b0d4a3c5067577430c147a903b5261 [1318/9999] ANDROID: GKI: Kconfig.gki: Add GKI_HIDDEN_ETHERNET_CONFIGS
config: arm-buildonly-randconfig-r002-20220316 (https://download.01.org/0day-ci/archive/20220317/202203170015.WBOInNU6-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/36ab8cea47b0d4a3c5067577430c147a903b5261
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 36ab8cea47b0d4a3c5067577430c147a903b5261
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_cleanup':
   hvc_console.c:(.text+0x25c): undefined reference to `tty_port_put'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_set_winsz':
   hvc_console.c:(.text+0x2f8): undefined reference to `tty_port_tty_get'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x330): undefined reference to `tty_do_resize'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_hangup':
   hvc_console.c:(.text+0x434): undefined reference to `tty_port_tty_set'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_remove':
   (.text+0x588): undefined reference to `tty_port_tty_get'
   arm-linux-gnueabi-ld: (.text+0x5dc): undefined reference to `tty_port_put'
   arm-linux-gnueabi-ld: (.text+0x5e8): undefined reference to `tty_vhangup'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `__hvc_poll':
   hvc_console.c:(.text+0x6a8): undefined reference to `tty_port_tty_get'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x6dc): undefined reference to `tty_buffer_request_room'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x75c): undefined reference to `tty_hangup'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x784): undefined reference to `tty_wakeup'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x7ac): undefined reference to `tty_flip_buffer_push'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x8c4): undefined reference to `__tty_insert_flip_char'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_alloc':
   (.text+0xacc): undefined reference to `__tty_alloc_driver'
   arm-linux-gnueabi-ld: (.text+0xb38): undefined reference to `tty_set_operations'
   arm-linux-gnueabi-ld: (.text+0xb70): undefined reference to `tty_register_driver'
   arm-linux-gnueabi-ld: (.text+0xb90): undefined reference to `put_tty_driver'
   arm-linux-gnueabi-ld: (.text+0xbe0): undefined reference to `tty_port_init'
   arm-linux-gnueabi-ld: (.text+0xd20): undefined reference to `tty_std_termios'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_open':
   hvc_console.c:(.text+0xdf8): undefined reference to `tty_port_tty_set'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_close':
   hvc_console.c:(.text+0xe94): undefined reference to `tty_hung_up_p'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0xed4): undefined reference to `tty_port_tty_set'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0xf38): undefined reference to `tty_wait_until_sent'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_instantiate':
   (.text+0x1088): undefined reference to `tty_port_put'
   arm-linux-gnueabi-ld: drivers/tty/hvc/hvc_console.o: in function `hvc_install':
   hvc_console.c:(.text+0x10f0): undefined reference to `tty_port_install'
   arm-linux-gnueabi-ld: hvc_console.c:(.text+0x10fc): undefined reference to `tty_port_put'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_get_fixed_state':
   phylink.c:(.text+0x29c): undefined reference to `linkmode_resolve_pause'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_decode_c37_word':
   phylink.c:(.text+0x3dc): undefined reference to `linkmode_resolve_pause'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_get_pauseparam':
>> (.text+0x4fc): undefined reference to `rtnl_is_locked'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_disconnect_phy':
   (.text+0x570): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x5c8): undefined reference to `phy_disconnect'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_get_wol':
   (.text+0x5e4): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x604): undefined reference to `phy_ethtool_get_wol'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_set_wol':
   (.text+0x620): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x634): undefined reference to `phy_ethtool_set_wol'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_get_eee_err':
   (.text+0x654): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x664): undefined reference to `phy_get_eee_err'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_init_eee':
>> (.text+0x688): undefined reference to `phy_init_eee'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_get_eee':
   (.text+0x6ac): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x6c0): undefined reference to `phy_ethtool_get_eee'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_set_eee':
   (.text+0x6e4): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x6f8): undefined reference to `phy_ethtool_set_eee'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_c22_pcs_get_state':
>> (.text+0x72c): undefined reference to `mdiobus_read'
>> arm-linux-gnueabi-ld: (.text+0x740): undefined reference to `mdiobus_read'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_c22_pcs_an_restart':
   (.text+0x844): undefined reference to `mdiobus_read'
>> arm-linux-gnueabi-ld: (.text+0x868): undefined reference to `mdiobus_write'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_emul_read':
   phylink.c:(.text+0x8d8): undefined reference to `swphy_read_reg'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_major_config':
   phylink.c:(.text+0x9d4): undefined reference to `netdev_printk'
>> arm-linux-gnueabi-ld: phylink.c:(.text+0xa44): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_nway_reset':
   (.text+0xac4): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0xad0): undefined reference to `phy_restart_aneg'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_phy_change':
   phylink.c:(.text+0xcb4): undefined reference to `phy_get_pause'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_set_pauseparam':
   (.text+0xd54): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0xdec): undefined reference to `linkmode_set_pause'
>> arm-linux-gnueabi-ld: (.text+0xe54): undefined reference to `phy_set_asym_pause'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_link_down':
   phylink.c:(.text+0xe9c): undefined reference to `netif_carrier_off'
   arm-linux-gnueabi-ld: phylink.c:(.text+0xed8): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_c45_pcs_get_state':
   (.text+0xfa4): undefined reference to `mdiobus_read'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_speed_down':
   (.text+0x1010): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x1030): undefined reference to `phy_speed_down'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_speed_up':
   (.text+0x1050): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x106c): undefined reference to `phy_speed_up'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_stop':
   (.text+0x108c): undefined reference to `rtnl_is_locked'
>> arm-linux-gnueabi-ld: (.text+0x1098): undefined reference to `phy_stop'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_bringup_phy':
   phylink.c:(.text+0x1174): undefined reference to `phy_support_asym_pause'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x1218): undefined reference to `netdev_printk'
>> arm-linux-gnueabi-ld: phylink.c:(.text+0x1248): undefined reference to `phy_attached_info_irq'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x1288): undefined reference to `netdev_printk'
>> arm-linux-gnueabi-ld: phylink.c:(.text+0x1328): undefined reference to `phy_request_interrupt'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_connect_phy':
   (.text+0x13b8): undefined reference to `phy_attach_direct'
   arm-linux-gnueabi-ld: (.text+0x13dc): undefined reference to `phy_detach'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_resolve':
   phylink.c:(.text+0x1788): undefined reference to `netif_carrier_on'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x17a4): undefined reference to `phy_speed_to_str'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x17b0): undefined reference to `phy_duplex_to_str'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x17e4): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x17f8): undefined reference to `phy_speed_to_str'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x1800): undefined reference to `phy_duplex_to_str'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_ioctl':
   (.text+0x1854): undefined reference to `rtnl_is_locked'
   arm-linux-gnueabi-ld: (.text+0x18c4): undefined reference to `mdiobus_read'
   arm-linux-gnueabi-ld: (.text+0x19c4): undefined reference to `mdiobus_write'
   arm-linux-gnueabi-ld: (.text+0x1a68): undefined reference to `phy_mii_ioctl'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_parse_mode':
   phylink.c:(.text+0x1c0c): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x1ea8): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_parse_fixedlink':
   phylink.c:(.text+0x2050): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x20e8): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x2128): undefined reference to `phy_lookup_setting'
   arm-linux-gnueabi-ld: phylink.c:(.text+0x21d8): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_ksettings_get':
   (.text+0x24e0): undefined reference to `rtnl_is_locked'
   arm-linux-gnueabi-ld: (.text+0x24f8): undefined reference to `phy_ethtool_ksettings_get'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_c22_pcs_set_advertisement':
   (.text+0x25d4): undefined reference to `mdiobus_read'
   arm-linux-gnueabi-ld: (.text+0x2600): undefined reference to `mdiobus_read'
   arm-linux-gnueabi-ld: (.text+0x2624): undefined reference to `mdiobus_write'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_mii_c22_pcs_config':
   (.text+0x2684): undefined reference to `mdiobus_modify'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_start':
   (.text+0x26cc): undefined reference to `rtnl_is_locked'
   arm-linux-gnueabi-ld: (.text+0x2714): undefined reference to `netdev_printk'
   arm-linux-gnueabi-ld: (.text+0x2720): undefined reference to `netif_carrier_off'
   arm-linux-gnueabi-ld: (.text+0x2818): undefined reference to `phy_start'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_ksettings_set.part.0':
   phylink.c:(.text+0x29bc): undefined reference to `phy_lookup_setting'
   arm-linux-gnueabi-ld: drivers/net/phy/phylink.o: in function `phylink_ethtool_ksettings_set':
   (.text+0x2b7c): undefined reference to `rtnl_is_locked'
   arm-linux-gnueabi-ld: (.text+0x2b90): undefined reference to `phy_ethtool_ksettings_set'
   arm-linux-gnueabi-ld: drivers/android/debug_symbols.o:(.rodata+0x14): undefined reference to `__per_cpu_start'
   arm-linux-gnueabi-ld: drivers/android/debug_symbols.o:(.rodata+0x1c): undefined reference to `__per_cpu_end'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for USB_PHY
   Depends on USB_SUPPORT
   Selected by
   - GKI_HIDDEN_USB_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_JACK_INPUT_DEV
   Depends on SOUND && !UML && SND && SND_JACK
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_ELD
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for HVC_DRIVER
   Depends on TTY
   Selected by
   - GKI_HIDDEN_VIRTUAL_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_GEM_CMA_HELPER
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_PROC
   Depends on NET && WIRELESS && PROC_FS && WEXT_CORE
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_PRIV
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for PAGE_POOL
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for WEXT_SPY
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for PHYLINK
   Depends on NETDEVICES
   Selected by
   - GKI_HIDDEN_ETHERNET_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_MIPI_DSI
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS
   WARNING: unmet direct dependencies detected for WIRELESS_EXT
   Depends on NET && WIRELESS
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for WEXT_CORE
   Depends on NET && WIRELESS && (CFG80211_WEXT || WIRELESS_EXT
   Selected by
   - GKI_LEGACY_WEXT_ALLCONFIG
   WARNING: unmet direct dependencies detected for NET_PTP_CLASSIFY
   Depends on NET
   Selected by
   - GKI_HIDDEN_NET_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_KMS_CMA_HELPER
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS
   WARNING: unmet direct dependencies detected for SND_VMASTER
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_CONFIGS
   WARNING: unmet direct dependencies detected for SND_PCM_IEC958
   Depends on SOUND && !UML && SND
   Selected by
   - GKI_HIDDEN_SND_SOC_CONFIGS

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
