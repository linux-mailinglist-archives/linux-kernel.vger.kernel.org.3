Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C704E1F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344188AbiCUCeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCUCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:34:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8985179430
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 19:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647829962; x=1679365962;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y/JXP4eqGN+xMuN06TQ5EwJ43DgPzy5hDfDHhKycv70=;
  b=eimzrZSf0M59dMfaT40SGyu+Tz81OQ63r8jBCGfcO9Txd8rBNIDU9fkn
   WOMa9HWsmW9fLnH8rvlIxePQX2Ld0ArcDT4DucTmz2zNU/HuZf1if4Scl
   TJylJI2rhN/2mPpg+qIuDpLvTAUuSrRhsdwZJg2xeuREpDdY58Ok4klMn
   rcB8VTkdxn3uXVwIhAYl4pIMpnYxC4IiCBNDhO1Yl/mIeDZ1WBT2BrcrO
   iiuri8oBS0CaQViw24QU6DCtCr+ORLLk2MQf8yK6X3/+odsDlrhCDqGxM
   ga23wxhLIB8FWNBAciUaLHRJoFQnhe1HIBnC22QNPBdchJ75ssAnkMyrQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282278440"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="282278440"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 19:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="636485111"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Mar 2022 19:32:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW7qa-000HOB-RX; Mon, 21 Mar 2022 02:32:40 +0000
Date:   Mon, 21 Mar 2022 10:31:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [kbingham-rcar:kbingham/drm-misc/next/sn65dsi86/hpd 11/15] ERROR:
 modpost: "drm_atomic_helper_bridge_dsi_input_bus_fmt"
 [drivers/gpu/drm/bridge/parade-ps8640.ko] undefined!
Message-ID: <202203211043.tkkRnByV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/drm-misc/next/sn65dsi86/hpd
head:   b55ca0e75f467b5c011ef8bfbcff0a2234cf9695
commit: e10c501b6016d478e18c24982e9afb0fa978e896 [11/15] drm/bridge: ps8640: plug atomic_get_input_bus_fmts
config: x86_64-randconfig-c022-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211043.tkkRnByV-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=e10c501b6016d478e18c24982e9afb0fa978e896
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/drm-misc/next/sn65dsi86/hpd
        git checkout e10c501b6016d478e18c24982e9afb0fa978e896
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_atomic_helper_bridge_dsi_input_bus_fmt" [drivers/gpu/drm/bridge/parade-ps8640.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
