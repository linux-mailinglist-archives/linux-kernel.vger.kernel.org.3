Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3024151EAC2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 03:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbiEHBOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 21:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiEHBOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 21:14:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0025DD
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 18:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651972223; x=1683508223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I4sgZ3rk271002EtG5hhv8/P6VSLFH+GlUxAs9JYF+0=;
  b=WrHiw4mQVxDuO2VsQctnFlQzIqWt/xAnsimDVdJKbnCy3E26PYuCkLuc
   Bib8QYByH48vsAVQAjNzhm48vzMOeLWM3zdEe69HcBFXMmKznzsGDwOcH
   t0rxv24WsNogcN2GOrHRttfKhekGRaldXgl6xLRP7h4Arl+01GWtnu22L
   OYLvsNFQUlzWduS87WR4o8vcx9FL98fLt3hGGvO/4WMfwR7rlCUS367y+
   FEmeFvOSmx25ZN+BjD8W49kwN3r9OJj8M7Cwjwu9u8SOY7+I0myzzr6Zx
   FUb35yyX+CPXZ5yCgmPpCYdbMQLa43qG0NjdmIr6OW1dbr+oNvBhoOU4a
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10340"; a="267612265"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267612265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 18:10:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="892429278"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 May 2022 18:10:20 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnVRE-000F6l-9r;
        Sun, 08 May 2022 01:10:20 +0000
Date:   Sun, 8 May 2022 09:09:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xtensa-linux-ld: section .Level2InterruptVector.text VMA
 [0000000000000180,0000000000000193] overlaps section .data VMA
 [0000000000000000,000000000017a61f]
Message-ID: <202205080830.NLUegPEY-lkp@intel.com>
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

Hi Max,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30c8e80f79329617012f07b09b70114592092ea4
commit: c20e1117d9aa22c558646a1060ddd1dd042fb107 xtensa: add kernel ABI selection to Kconfig
date:   8 weeks ago
config: xtensa-randconfig-r014-20220508 (https://download.01.org/0day-ci/archive/20220508/202205080830.NLUegPEY-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c20e1117d9aa22c558646a1060ddd1dd042fb107
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c20e1117d9aa22c558646a1060ddd1dd042fb107
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> xtensa-linux-ld: section .Level2InterruptVector.text VMA [0000000000000180,0000000000000193] overlaps section .data VMA [0000000000000000,000000000017a61f]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
