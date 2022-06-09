Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66112544304
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiFIFPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiFIFPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:15:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636AC1D0E1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654751733; x=1686287733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ot3PEfo7yyy5OJqEizBbkNDrvykYq8p2uLb7rV8yXO0=;
  b=cQdUnTtc44OqUzuZqq4E0bBREO4iTNNMuslCzaPVXMqjdIKTk8y4YH3b
   CobKQ54lhn/RU7gvPlvQfp2l1uq7ZX1nA1qIxbeIHeUrVa4CbqcbMiBNF
   4EiIsSaIYFs/GI2xrZZCZKOPWSpXdKU43LeuKatv/IFb8YgYvJIILOrDM
   OcPxkS7bhee+v77v7S27KAHEiemRed3D/1AojFKkDiW1p+31MfCjsAxpe
   dlisLlCyb3Z7gxAnYhr8iNz6q7LFrqhvQXgTvESbiQNE7y2sQKNjsskmD
   SmUpFkI/EQPyyyrPl048yfaNprIZOD+eR2nUAmTf/rTpSDqT+5XSlsNPY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="256978832"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="256978832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 22:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="585301157"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 22:15:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzAVp-000FXB-FW;
        Thu, 09 Jun 2022 05:15:17 +0000
Date:   Thu, 9 Jun 2022 13:14:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: usb.c:undefined reference to `qe_immr'
Message-ID: <202206091324.PckrHK3W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
date:   2 weeks ago
config: powerpc-randconfig-r006-20220607 (https://download.01.org/0day-ci/archive/20220609/202206091324.PckrHK3W-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7b4537199a4a8480b8c3ba37a2d44765ce76cd9b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   powerpc-linux-ld: drivers/soc/fsl/qe/usb.o: in function `qe_usb_clock_set':
>> usb.c:(.text+0xe): undefined reference to `qe_immr'
>> powerpc-linux-ld: usb.c:(.text+0x1a): undefined reference to `qe_immr'
   powerpc-linux-ld: usb.c:(.text+0x52): undefined reference to `qe_immr'
>> powerpc-linux-ld: usb.c:(.text+0xf0): undefined reference to `qe_setbrg'
>> powerpc-linux-ld: usb.c:(.text+0xf6): undefined reference to `cmxgcr_lock'
   powerpc-linux-ld: usb.c:(.text+0xfa): undefined reference to `cmxgcr_lock'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
