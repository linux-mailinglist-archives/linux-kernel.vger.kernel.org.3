Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C470247D528
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343837AbhLVQe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:34:58 -0500
Received: from mga18.intel.com ([134.134.136.126]:54602 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhLVQe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640190897; x=1671726897;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bzbzVVX8tg2Y4b4tVr/4zhMKBYqSwMRw/845717HuNo=;
  b=C4z7hs9xp8X7vuRlkYMnCtq8HjT2YSCcBxDFfzsnDr5n2cLbAhB7R97P
   MFHHMOsU7gP4fBSvPtG5+RF05SpfbcqRXUF7K1fabDi20+jHkWpKkk/Zy
   Mt0oG3LpA351bz94oFXkLc9S+OUgJrPPVr25f/6gdRLzLK3u8JV2hLKxf
   rGySqjdY8uFLWrH0ehE03GrhZbVqT3PTSknT0ZF29QrIc1QvuNJfHV+jK
   Va01Vx5IN4mgtAeTVvt0aDpOZR3aLMvpClU5mt95iMZttJLTMd0jxkKzq
   nmSgtKtMW8HlAiVE1+1I9GI6PYKghcDyPnSesIbsgU+oWcgT/3gIo5W1B
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="227503664"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="227503664"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 08:34:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="466716755"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Dec 2021 08:34:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n04Zq-0000l6-TE; Wed, 22 Dec 2021 16:34:54 +0000
Date:   Thu, 23 Dec 2021 00:34:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: panel-edp.c:undefined reference to `drm_panel_dp_aux_backlight'
Message-ID: <202112230025.jXiCKbua-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
commit: 9d6366e743f37d36ef69347924ead7bcc596076e drm: fb_helper: improve CONFIG_FB dependency
date:   7 weeks ago
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20211223/202112230025.jXiCKbua-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d6366e743f37d36ef69347924ead7bcc596076e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9d6366e743f37d36ef69347924ead7bcc596076e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
>> panel-edp.c:(.text+0xf38): undefined reference to `drm_panel_dp_aux_backlight'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
