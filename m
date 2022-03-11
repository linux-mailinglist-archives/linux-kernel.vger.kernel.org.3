Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19224D5DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiCKIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241050AbiCKIrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:47:49 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794561BA92C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646988407; x=1678524407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HHtqczBMuBwrNgtwksjNxVlbSq+mu9MDf5OZWoseuIM=;
  b=MrSdGe8OFk8ZJKGaPCf1Day5pi/QK7KUJyVffau7mzjuLo6pfSq0mmWH
   PQGKGdcM5vn4I8geWGcBQqnSzQqVDdlWKRE0zdWqkL0MENwuElDQEYb98
   dOKvYgduJMGhGcq6lDHJ70Lwt9s8g1832wl+xAYHF/nWCY2pv7occcsEj
   O98wNa3OmWAJ8rge+n0NrGXHcu76PmUCH17kGPBgffWpD0J+cqk0sbbqC
   aUxpRNqrzDwOrXfDKJ71Vky8GlhM4AFfGVd0uR+xVG/OEYGgnKXaekiRP
   cBTOGSiiTf/xDLDg+e5qtYFtYl2gII5u5AS5vTQTzthWhpmgyB2RD78Ol
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="316252237"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="316252237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 00:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="514433431"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 11 Mar 2022 00:46:39 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSav0-00067y-V4; Fri, 11 Mar 2022 08:46:38 +0000
Date:   Fri, 11 Mar 2022 16:46:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [kbingham-rcar:kbingham/drm-misc/next/sn65dsi86/hpd 11/15] ERROR:
 modpost: "drm_atomic_helper_bridge_dsi_input_bus_fmt"
 [drivers/gpu/drm/bridge/parade-ps8640.ko] undefined!
Message-ID: <202203111635.N1MPOboS-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/drm-misc/next/sn65dsi86/hpd
head:   94aa000441bc3f2b262da3580845e490e1c31017
commit: d7e45a09dc884537c84843120b2fa90e76495a82 [11/15] drm/bridge: ps8640: plug atomic_get_input_bus_fmts
config: hexagon-randconfig-r045-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111635.N1MPOboS-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=d7e45a09dc884537c84843120b2fa90e76495a82
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/drm-misc/next/sn65dsi86/hpd
        git checkout d7e45a09dc884537c84843120b2fa90e76495a82
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "drm_atomic_helper_bridge_dsi_input_bus_fmt" [drivers/gpu/drm/bridge/parade-ps8640.ko] undefined!

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
