Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80704DE976
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240827AbiCSRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiCSRMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:12:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55427DEA4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647709888; x=1679245888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7YWYQ92H8E3XOIXKDJ6l3wVP2tj4eZmeeIFODHVxvUU=;
  b=knovwtSe6tGmhKegePrSUO73Huv2oPKIiHHKXJbnv8NCsGubV2G07yE4
   ERH5hBrrW02H3Kad8Unn41/UTFZNKzSZG/6BxHcjEazewl6mAki/cUirA
   jiUZM+XKAl8onnNYopr9sgXoERBZOwz25Z0zbCN//Y/QTXgTu3u68UCr8
   Mxu6VVLSMx8zPUq4RCvRLfMliabuc2mLCxLVCqJUiLsqMK4i5373WeoNi
   vki5GmhrLNHTpZw/NzuB6AOAMpmK/kZ3I2XQEkKx+vBovBlAGG7VE/jm6
   zKg3eFk5d2Bs7/oDwYQTPMV4ybzmlUJXY3yaySagdGJqyUpqwNJ9poaOX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237258495"
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="237258495"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 10:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,194,1643702400"; 
   d="scan'208";a="499634006"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2022 10:11:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVcbu-000G9G-6X; Sat, 19 Mar 2022 17:11:26 +0000
Date:   Sun, 20 Mar 2022 01:11:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:atc-WIP 186/186] drivers/phy/apple/./trace.h:101:23:
 warning: format '%ld' expects argument of type 'long int', but argument 4
 has type 'size_t' {aka 'unsigned int'}
Message-ID: <202203200113.CEPlMn2K-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux atc-WIP
head:   edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
commit: edd8b87e1973b03d2a8ae654018e6a01cd1cc03e [186/186] WIP: atcphy
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20220320/202203200113.CEPlMn2K-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux atc-WIP
        git checkout edd8b87e1973b03d2a8ae654018e6a01cd1cc03e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/phy/apple/trace.h:128,
                    from drivers/phy/apple/trace.c:3:
   drivers/phy/apple/./trace.h: In function 'trace_raw_output_atcphy_parsed_tunable':
>> drivers/phy/apple/./trace.h:101:23: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
     101 |             TP_printk("%s with %ld entries", __entry->name,
         |                       ^~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:464:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     464 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:80:30: note: in expansion of macro 'PARAMS'
      80 |                              PARAMS(print));                   \
         |                              ^~~~~~
   drivers/phy/apple/./trace.h:92:1: note: in expansion of macro 'TRACE_EVENT'
      92 | TRACE_EVENT(atcphy_parsed_tunable,
         | ^~~~~~~~~~~
   drivers/phy/apple/./trace.h:101:13: note: in expansion of macro 'TP_printk'
     101 |             TP_printk("%s with %ld entries", __entry->name,
         |             ^~~~~~~~~
   In file included from include/trace/trace_events.h:498,
                    from include/trace/define_trace.h:102,
                    from drivers/phy/apple/trace.h:128,
                    from drivers/phy/apple/trace.c:3:
   drivers/phy/apple/./trace.h:101:34: note: format string is defined here
     101 |             TP_printk("%s with %ld entries", __entry->name,
         |                                ~~^
         |                                  |
         |                                  long int
         |                                %d


vim +101 drivers/phy/apple/./trace.h

    18	
    19	#define show_sw_orientation(orientation)                                  \
    20		__print_symbolic(orientation, { TYPEC_ORIENTATION_NONE, "none" }, \
    21				 { TYPEC_ORIENTATION_NORMAL, "normal" },          \
    22				 { TYPEC_ORIENTATION_REVERSE, "reverse" })
    23	
    24	TRACE_EVENT(atcphy_sw_set, TP_PROTO(enum typec_orientation orientation),
    25		    TP_ARGS(orientation),
    26	
    27		    TP_STRUCT__entry(__field(enum typec_orientation, orientation)),
    28	
    29		    TP_fast_assign(__entry->orientation = orientation;),
    30	
    31		    TP_printk("orientation: %s",
    32			      show_sw_orientation(__entry->orientation)));
    33	
    34	#define show_mux_state(state)                                                 \
    35		__print_symbolic(state->mode, { TYPEC_STATE_SAFE, "USB Safe State" }, \
    36				 { TYPEC_STATE_USB, "USB" })
    37	
    38	#define show_atcphy_mode(mode)                                      \
    39		__print_symbolic(mode, { APPLE_ATCPHY_MODE_OFF, "off" },    \
    40				 { APPLE_ATCPHY_MODE_USB2, "USB2" },        \
    41				 { APPLE_ATCPHY_MODE_USB3, "USB3" },        \
    42				 { APPLE_ATCPHY_MODE_USB3_DP, "DP + USB" }, \
    43				 { APPLE_ATCPHY_MODE_USB4, "USB4" },        \
    44				 { APPLE_ATCPHY_MODE_DP, "DP-only" })
    45	
    46	TRACE_EVENT(atcphy_usb3_set_mode,
    47		    TP_PROTO(struct apple_atcphy *atcphy, enum phy_mode mode,
    48			     int submode),
    49		    TP_ARGS(atcphy, mode, submode),
    50	
    51		    TP_STRUCT__entry(__field(enum atcphy_mode, mode)
    52					     __field(enum atcphy_mode, target_mode)
    53						     __field(enum phy_mode, phy_mode)
    54							     __field(int, submode)),
    55	
    56		    TP_fast_assign(__entry->mode = atcphy->mode;
    57				   __entry->target_mode = atcphy->target_mode;
    58				   __entry->phy_mode = mode;
    59				   __entry->submode = submode;),
    60	
    61		    TP_printk("mode: %s, target_mode: %s, phy_mode: %d, submode: %d",
    62			      show_atcphy_mode(__entry->mode),
    63			      show_atcphy_mode(__entry->target_mode), __entry->phy_mode,
    64			      __entry->submode));
    65	
    66	TRACE_EVENT(
    67		atcphy_configure_lanes,
    68		TP_PROTO(enum atcphy_mode mode,
    69			 const struct atcphy_mode_configuration *cfg),
    70		TP_ARGS(mode, cfg),
    71	
    72		TP_STRUCT__entry(__field(enum atcphy_mode, mode) __field(
    73			const struct atcphy_mode_configuration *, cfg)),
    74	
    75		TP_fast_assign(__entry->mode = mode; __entry->cfg = cfg;),
    76	
    77		TP_printk(
    78			"mode: %s, crossbar: 0x%02x, lanes: {0x%02x, 0x%02x}, swap: %d",
    79			show_atcphy_mode(__entry->mode), __entry->cfg->crossbar,
    80			__entry->cfg->lane_mode[0], __entry->cfg->lane_mode[1],
    81			__entry->cfg->set_swap));
    82	
    83	TRACE_EVENT(atcphy_mux_set, TP_PROTO(struct typec_mux_state *state),
    84		    TP_ARGS(state),
    85	
    86		    TP_STRUCT__entry(__field(struct typec_mux_state *, state)),
    87	
    88		    TP_fast_assign(__entry->state = state;),
    89	
    90		    TP_printk("state: %s", show_mux_state(__entry->state)));
    91	
    92	TRACE_EVENT(atcphy_parsed_tunable,
    93		    TP_PROTO(const char *name, struct atcphy_tunable *tunable),
    94		    TP_ARGS(name, tunable),
    95	
    96		    TP_STRUCT__entry(__field(const char *, name)
    97					     __field(struct atcphy_tunable *, tunable)),
    98	
    99		    TP_fast_assign(__entry->name = name; __entry->tunable = tunable;),
   100	
 > 101		    TP_printk("%s with %ld entries", __entry->name,
   102			      __entry->tunable->sz));
   103	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
