Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71930547A39
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236900AbiFLNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFLNAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:00:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0107764DE
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655038810; x=1686574810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C5kz6PMMsK7C2v+MMx0p/CSSFeeqJZxQtJ7Djop6b5o=;
  b=MqIqS+9A9+967IzyXDIIiDHlHjA1Pt9/tHzDJ6I0n94St0WivySQ2MAn
   iVUwuk8DYHxATn/I4p2i2uUoE6uPa8MEed7kMV0137TZQFJowZbKSwM4+
   Z6YnuVcmTHXz+fqPTuaAVyg27smxV1o932ydiIFvK3SQCw/SmnNiS/+KR
   AbROrXzL9dM6CYbJRyKjazjRbOOJ+4H5CXYE1vzvmMp+BVQsiOWeuspqO
   VXAYUlRwwLo8WqKNslxPxQS/IJKwIX3Ar/q5/oYy+128kRAhu9G25d1Sf
   lfmFdw1NW31xaCeU2ubf0mPbNU6e2Jm0MTJ5Gm1kHlwHQnbiWsBOjIQny
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="266755104"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="266755104"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 06:00:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="639177475"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2022 06:00:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0NCJ-000Jvh-AG;
        Sun, 12 Jun 2022 13:00:07 +0000
Date:   Sun, 12 Jun 2022 20:59:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [broonie-ci:v3_20220523_angelogioacchino_delregno_mediatek_helio_x10_mt6795_mt6331_6332_regulators
 1/4] drivers/regulator/mt6331-regulator.c:15:10: fatal error:
 linux/mfd/mt6331/registers.h: No such file or directory
Message-ID: <202206122043.tlKYtim4-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git v3_20220523_angelogioacchino_delregno_mediatek_helio_x10_mt6795_mt6331_6332_regulators
head:   eaff71a5b4e846b2370bbe92e4c433d014ae461c
commit: 94d5539dd3df7b7f8f4587da0e5b6a46e41f88a4 [1/4] regulator: Add driver for MT6331 PMIC regulators
config: parisc64-allyesconfig (https://download.01.org/0day-ci/archive/20220612/202206122043.tlKYtim4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?id=94d5539dd3df7b7f8f4587da0e5b6a46e41f88a4
        git remote add broonie-ci https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git
        git fetch --no-tags broonie-ci v3_20220523_angelogioacchino_delregno_mediatek_helio_x10_mt6795_mt6331_6332_regulators
        git checkout 94d5539dd3df7b7f8f4587da0e5b6a46e41f88a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/regulator/mt6331-regulator.c:15:10: fatal error: linux/mfd/mt6331/registers.h: No such file or directory
      15 | #include <linux/mfd/mt6331/registers.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +15 drivers/regulator/mt6331-regulator.c

     9	
    10	#include <linux/module.h>
    11	#include <linux/of.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/regmap.h>
    14	#include <linux/mfd/mt6397/core.h>
  > 15	#include <linux/mfd/mt6331/registers.h>
    16	#include <linux/regulator/driver.h>
    17	#include <linux/regulator/machine.h>
    18	#include <linux/regulator/mt6331-regulator.h>
    19	#include <linux/regulator/of_regulator.h>
    20	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
