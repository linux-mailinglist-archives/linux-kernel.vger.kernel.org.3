Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D645154AD6C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiFNJc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiFNJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:32:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B594965A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655199145; x=1686735145;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=U6mkYQXYPpI8IEu2W57zWGbzpdSdA7n5h8qOkdFmXtc=;
  b=VJHAeiWpF3UeKffN2xMKRn/804O/ho9X5FYmdDJLRvwykjQEH49x5MsJ
   pvYm3QTO45F+2/QLTDeBfHdq1dYz6FKoCn//8v1SnTeTcycy1QBTXyTu4
   lAUk7tbFzqvwmekbJFUZeFABPEeguLamy02Ngovdr6Iyty+GPYGvlhX/q
   e4NBEzu0ZC7GalqrPZ94nq5R71HOh4zv2fizFRAEGIKHcGb0AqF/xeUlk
   05ZoMIp6mhdp2tYWUwR4PLDwuaLiqlN+gc279Qc/isw+5DVos7mOSfc9l
   +is3p+9nVJ42OjOOXa9Dc41EpBSUqTanutOFL8Bj3Rt6R6nZn9m481b0m
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="267251262"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="267251262"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 02:32:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="588350359"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 02:32:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o12uN-000LjN-Bi;
        Tue, 14 Jun 2022 09:32:23 +0000
Date:   Tue, 14 Jun 2022 17:32:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [broadcom-stblinux:devicetree/next 15/23] make[2]: *** No rule to
 make target 'arch/arm/boot/dts/bcm96855.dtb', needed by '__build'.
Message-ID: <202206141752.IB5xCdXS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/Broadcom/stblinux devicetree/next
head:   edb052f67bb9f245f9717b3c11b21022a02fae87
commit: d2d847e696389916239c5521ca533261d0c0026f [15/23] ARM: dts: Add DTS files for bcmbca SoC BCM6855
config: arm-randconfig-r035-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141752.IB5xCdXS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/Broadcom/stblinux/commit/d2d847e696389916239c5521ca533261d0c0026f
        git remote add broadcom-stblinux https://github.com/Broadcom/stblinux
        git fetch --no-tags broadcom-stblinux devicetree/next
        git checkout d2d847e696389916239c5521ca533261d0c0026f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'arch/arm/boot/dts/bcm96855.dtb', needed by '__build'.
   make[2]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
