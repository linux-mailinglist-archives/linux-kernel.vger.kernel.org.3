Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFCD4A9A3B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiBDNp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:45:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:15149 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbiBDNpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643982325; x=1675518325;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0GNxd+aWevic6DCv1GwvokygLoFuRmdCOGbVHk+i758=;
  b=S4C4TRQa0hcSsS05kv6F/9KE5ibyfhF8aBcS8yuF//O7LcoWX6fHRv8V
   nRRaUmOmHq5pzQXHvddmF+tB+9acxXW2Pd2vNc1kd8v3SCqP5fNPhC2KH
   H1MUtOTA5rZkKo9Mw16KlbhTXWezEEvBl4HaLQAD4n5bdIcAA/uHSuzql
   +dfynwKdO8dNmyRirB+JJJosSop1ALBau1EAS4EeS7hAUMHSI/X+dYKQf
   eyL58QOQkNlugcAIHs8S4h9CD1Wb1jmsOXG1bF5TmOav5ySqVAvQe50n2
   EpTUgcokZ3DQI1BfpI3CPWsjZ0BjDbsZPEtVbOgFc+N74RMzSZklMbEgU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309113570"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="309113570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 05:45:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="699676751"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Feb 2022 05:45:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFytu-000Xff-Pg; Fri, 04 Feb 2022 13:45:22 +0000
Date:   Fri, 4 Feb 2022 21:44:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: panel-edp.c:undefined reference to `drm_panel_dp_aux_backlight'
Message-ID: <202202042130.9OxdKaGE-lkp@intel.com>
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
head:   dcb85f85fa6f142aae1fe86f399d4503d49f2b60
commit: 9d6366e743f37d36ef69347924ead7bcc596076e drm: fb_helper: improve CONFIG_FB dependency
date:   3 months ago
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20220204/202202042130.9OxdKaGE-lkp@intel.com/config)
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
