Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6766D4C0C90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 07:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238352AbiBWGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 01:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235483AbiBWGcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 01:32:51 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1F3267D;
        Tue, 22 Feb 2022 22:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645597943; x=1677133943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t+EWHkxVYiuPqz5bFdNUluXRx58UgyPApSK+jiVbtZw=;
  b=GkquXK1GV0bmr2G7x1ZI00ZmiCjATypWitLLqUNrh1NVapuDBqaw0iZb
   66SVLnPMwpGSsRSET2OxCNow9v0G0ip0paJsQUk+8vcv1Mj0cqDPi6BIS
   Hge1OP/x/V0E7DWPeZrG6i/Hz1tsMeVLRUoAaxRAUPYPgpNfqE0+9aZ0X
   wBOLEK03GgQjI55XmcYrE2AyuSeK93CSSXsDrA6DoIOdEU50HLvzNLwB6
   kKOLoEIZpdO9l9CZ5rqoxA4xOoc0SZ7qhzE0FfO1bHopuvXhGarlmgRjd
   AfI2x0mHw3D4UOmj0GpmGk5MmiQAMqaKue9ve5EWxU943a13Sy+RzTt7D
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251815156"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251815156"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 22:32:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="637304237"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Feb 2022 22:32:18 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMlCD-00014Q-Qt; Wed, 23 Feb 2022 06:32:17 +0000
Date:   Wed, 23 Feb 2022 14:31:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 5/5] clk: imx: add i.MX93 clk
Message-ID: <202202231413.DjpCSE8G-lkp@intel.com>
References: <20220223011606.3282165-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223011606.3282165-6-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220217]
[cannot apply to shawnguo/for-next robh/for-next clk/clk-next v5.17-rc5 v5.17-rc4 v5.17-rc3 v5.17-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220223-091628
base:    3c30cf91b5ecc7272b3d2942ae0505dd8320b81c
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220223/202202231413.DjpCSE8G-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6af055ecd8262a7ba5aa17d0bde604f63fae465c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220223-091628
        git checkout 6af055ecd8262a7ba5aa17d0bde604f63fae465c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/imx/clk-imx93.c:17:10: fatal error: soc/imx/soc.h: No such file or directory
      17 | #include <soc/imx/soc.h>
         |          ^~~~~~~~~~~~~~~
   compilation terminated.


vim +17 drivers/clk/imx/clk-imx93.c

  > 17	#include <soc/imx/soc.h>
    18	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
