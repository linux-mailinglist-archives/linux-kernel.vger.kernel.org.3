Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8973591EA6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 08:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiHNGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 02:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiHNGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 02:14:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF1F1EAEC
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 23:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660457686; x=1691993686;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jx5m+lVqw0BujgEk7WOIWjq/1ekdEkrnHOw19yWknNY=;
  b=FBmVhyIxI/LXgZVGQ+Zre7bM1qyT958BQQ3wyiYmFG71r24B07Zbyd8v
   lwdNkR86i3BxiniQKqdRtWnv4MM7YqEp3NcRNw37ne24J2UyBeDXksnyO
   DsConwUWRh+9OigT8ImVNDgsX+sZhFB24ckfTYhEXWnK7fvdHD+LS8gp8
   6wkkkg8bKSlB0XuXx6d3toh6jj4tVEZlTmUIOTW2XtZIq3MQZo0Bg3Ji3
   b9t3NH0vCVCHmfvPtSgf6YXLAwvj4OPnu6rwgXq/4CNoIpLSfRol41CGX
   mp8JoHhkwvVMEMGiGnjWgHdrAGcm3Z5lRFstRfpgb4OFMROPgsO/ijYX6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="278756923"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="278756923"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 23:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="606322899"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Aug 2022 23:14:44 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN6tY-0002Z1-0o;
        Sun, 14 Aug 2022 06:14:44 +0000
Date:   Sun, 14 Aug 2022 14:14:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mnyman-xhci:fix_port_disable_s4 1/1] ERROR: modpost:
 "xhci_port_state_to_neutral" [drivers/usb/host/xhci-pci.ko] undefined!
Message-ID: <202208141453.XhiYcx2P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git fix_port_disable_s4
head:   a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
commit: a41d3a635cb80d88f6d5fa958ebce3d81abd5c73 [1/1] xhci: pci: disable all xhci ports in hibernate poweroff_late stage,
config: i386-randconfig-a001-20220808 (https://download.01.org/0day-ci/archive/20220814/202208141453.XhiYcx2P-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?id=a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        git remote add mnyman-xhci https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git
        git fetch --no-tags mnyman-xhci fix_port_disable_s4
        git checkout a41d3a635cb80d88f6d5fa958ebce3d81abd5c73
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xhci_port_state_to_neutral" [drivers/usb/host/xhci-pci.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
