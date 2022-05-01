Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0025164E8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347956AbiEAPNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiEAPNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 11:13:07 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1A913E2B
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651417781; x=1682953781;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XApqdVjLrSyDBkC4GgjXFsw15+qgiShtJKE+fmcCyZc=;
  b=FF6t1Heg/lWnMDD7EYkiqS6reD3/naAJV5A93itZGFdTCRdWArdhgyQe
   9rItvea4Py+wXIhJedUF7Nl+5NcmeAiBxDzPND3A6WVfSHmWYvI8w9+2K
   ah53c31t/Wi+udrv/x353HcymQg0Jh1xSa0mmzGeHK8gHoCPGDu+fJHkn
   sAaGgjqLJJE/OnxDwWhjJ8hJc7MzuIH8mfVJwMStiXIZ25w3hn6wiF4SX
   +gfxEJ+YaYFMhyU86I0RJmrRu2sbNyAxdnq3ARjDBv2/rm2W+3W/uSrmK
   6XsvGoFzkMyk/EUvo2sXdlmSw9aoIoGX6qix4SxjxAT5EPlLZw6aHAbnh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="266884434"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="266884434"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 08:09:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="707260336"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2022 08:09:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlBCd-0008qP-IP;
        Sun, 01 May 2022 15:09:39 +0000
Date:   Sun, 1 May 2022 23:09:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [matthias-bgg:v5.18-next/dts64 30/37]
 arch/arm/boot/dts/en7523.dtsi:6:10: fatal error:
 dt-bindings/clock/en7523-clk.h: No such file or directory
Message-ID: <202205012301.HhfNwf1X-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git v5.18-next/dts64
head:   7d3c600448a7233976dfd6f1bcf00bb0daa31109
commit: 09f4afc44ba9ebd33d389af345cff4d7668437ae [30/37] ARM: dts: add clock support for Airoha EN7523
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220501/202205012301.HhfNwf1X-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?id=09f4afc44ba9ebd33d389af345cff4d7668437ae
        git remote add matthias-bgg https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git
        git fetch --no-tags matthias-bgg v5.18-next/dts64
        git checkout 09f4afc44ba9ebd33d389af345cff4d7668437ae
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/en7523-evb.dts:7:
>> arch/arm/boot/dts/en7523.dtsi:6:10: fatal error: dt-bindings/clock/en7523-clk.h: No such file or directory
       6 | #include <dt-bindings/clock/en7523-clk.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +6 arch/arm/boot/dts/en7523.dtsi

     2	
     3	#include <dt-bindings/interrupt-controller/irq.h>
     4	#include <dt-bindings/interrupt-controller/arm-gic.h>
     5	#include <dt-bindings/gpio/gpio.h>
   > 6	#include <dt-bindings/clock/en7523-clk.h>
     7	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
