Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE5B58E3E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHIXwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiHIXwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:52:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1FE56B91
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660089125; x=1691625125;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6PeZcZl8ncclrU5N8wDsFeDmo6sYSQctn4kR7UXIroE=;
  b=YrvW4PapTBbxcwp8ShXnI/VRhmFlsYHT9ieNOtGvg2TaTx6r/KhM5xGG
   ry42JvwKwpIUWM2Zo8afSIpdsW4Ysb6yMbJY2YrmNlASc0YF8qthQLus1
   Dhv5D9nHcqucMNRJz6vrX+Og5z9L1rJAodMhcynO3TC2v50ekfMFn/99B
   o8WoBsTairPiyQ5/S8ab/cOB326otDUVSVcaC8vstVXKJvDamJGgPuPCc
   J44sSqRU6YMmSTr24ITYIvRZyW5qNkVd4dq+aKSWlrUYdsBP+vzeBenlT
   +y7vPS73LhCovcdbNYMMSZwO5df+V2IsbIRrzO2pvRLivNJU67Rec31AG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="352690637"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="352690637"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:52:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="673082939"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2022 16:52:03 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLZ10-000NMD-2J;
        Tue, 09 Aug 2022 23:52:02 +0000
Date:   Wed, 10 Aug 2022 07:52:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/090-spi-hid 16/22] dockchannel.c:undefined
 reference to `of_platform_device_destroy'
Message-ID: <202208100711.oItJpGY7-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/090-spi-hid
head:   cc847c79fbb5106249dcfd91aa041cce0116c897
commit: ffeb65333caa066616ee70e0257035fe99cf4205 [16/22] soc: apple: Add DockChannel driver
config: ia64-randconfig-r013-20220810 (https://download.01.org/0day-ci/archive/20220810/202208100711.oItJpGY7-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/ffeb65333caa066616ee70e0257035fe99cf4205
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/090-spi-hid
        git checkout ffeb65333caa066616ee70e0257035fe99cf4205
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ia64-linux-ld: drivers/soc/apple/dockchannel.o: in function `dockchannel_remove':
>> dockchannel.c:(.text+0x881): undefined reference to `of_platform_device_destroy'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
