Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4124AA54F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 02:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378871AbiBEB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 20:28:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:52642 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349644AbiBEB2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 20:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644024487; x=1675560487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XdxtJJTIZE+WWUJgQ9TXZkuAz5xg8F2S74fBeUfPYaU=;
  b=JWdopyCFqxJ+1qPn5CP+3jkQdNBpAwJqRMyEpei/DkrT2U4nVjS/mJfT
   KKP0m4OsgYjmW0sCOa0V2wycUGtnT0RKVMi/XpWrxvDjjV0HiISTb3vjL
   70KFrSqUXcBIGFUOWQriafvOrbZRk4ktgN6NsdTD0VI9UUUOYqMHEI/NU
   bnVv0CtJ+gbH9pqPz3+Z0gtIjMeCImjbJLjkKFgHk+oHmeR9cNTOY5mt2
   DHNTqpTGnNxyxvO6ooHOOhOO0bOeP9yMFsLbE3kZsY+cY5Kk6dLiDOPcN
   WK8IFS11tvYPyx5EtMqpPaye5HlT/u0yauvX9c2OgnPVqpkYMdLEXOTbp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248234775"
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="248234775"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 17:28:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,344,1635231600"; 
   d="scan'208";a="584300475"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2022 17:28:04 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nG9rw-000YQN-9r; Sat, 05 Feb 2022 01:28:04 +0000
Date:   Sat, 5 Feb 2022 09:27:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v6 3/4] drm/bridge: anx7625: Support reading edid through
 aux channel
Message-ID: <202202050942.C6c0MD0r-lkp@intel.com>
References: <20220203141023.570180-3-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203141023.570180-3-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[cannot apply to robh/for-next drm-intel/for-linux-next v5.17-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Hsin-Yi-Wang/drm-bridge-anx7625-send-DPCD-command-to-downstream/20220203-221108
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: arm64-randconfig-c023-20220130 (https://download.01.org/0day-ci/archive/20220205/202202050942.C6c0MD0r-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/45f3728b61c8cb8d53d13d88c33c4f58630dcea6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Hsin-Yi-Wang/drm-bridge-anx7625-send-DPCD-command-to-downstream/20220203-221108
        git checkout 45f3728b61c8cb8d53d13d88c33c4f58630dcea6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: ID map text too big or misaligned
   aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/anx7625.o: in function `anx7625_bridge_detach':
>> anx7625.c:(.text+0x5e0): undefined reference to `drm_dp_aux_unregister'
   aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/anx7625.o: in function `anx7625_bridge_attach':
>> anx7625.c:(.text+0x674): undefined reference to `drm_dp_aux_register'
   aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/anx7625.o: in function `anx7625_i2c_probe':
>> anx7625.c:(.text+0x1b48): undefined reference to `drm_dp_aux_init'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
