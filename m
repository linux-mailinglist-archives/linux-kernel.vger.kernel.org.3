Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18646C42A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241067AbhLGUJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:09:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:47493 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhLGUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:09:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="323930250"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="323930250"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 12:06:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="542936151"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2021 12:06:12 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mugj6-000Mv7-1p; Tue, 07 Dec 2021 20:06:12 +0000
Date:   Wed, 8 Dec 2021 04:05:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tommy Haung <tommy_huang@aspeedtech.com>, joel@jms.id.au,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        andrew@aj.id.au, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH v4 6/6] arm:boot:dts:aspeed-g6 Add more gfx reset control
Message-ID: <202112080327.zlIz9vRq-lkp@intel.com>
References: <20211207102749.18118-8-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207102749.18118-8-tommy_huang@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[also build test ERROR on next-20211207]
[cannot apply to joel-aspeed/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tommy-Haung/Add-Aspeed-AST2600-soc-display-support/20211207-183100
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211208/202112080327.zlIz9vRq-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1f021d3aa80957f6bd0434bf4b5d66898b8d2e9c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tommy-Haung/Add-Aspeed-AST2600-soc-display-support/20211207-183100
        git checkout 1f021d3aa80957f6bd0434bf4b5d66898b8d2e9c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/aspeed-g6.dtsi:359.23-24 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
