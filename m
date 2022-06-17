Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46EFF54F000
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 06:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379868AbiFQEMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 00:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379867AbiFQEMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:12:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2051325
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655439149; x=1686975149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YvdWTFUk63l31qGeLrbQlCsXOPg6/TSiY97UBVlYBnM=;
  b=DaKj/NQW9d97ElbslXBPdf/IOdgAzo4VNelBNOxy8Pw69GYHqYrnkcU5
   tX0wPb3l1ecYwEj49d1+k0XOj1BIrugS+S4oMvuSp1XvX6Cva+Jh26tq7
   p0meJ5HKXc9DabKWQzWrJpgnN+3Uok3TJiO8EtkFOzFuvZo0qWVDKUJdc
   XK7gqzbFUOG9FfhfpwT1GZrzmk/NjXWjKV9om/K/gbViPQSEGQYNQ9opq
   h5FyTWlqoPqJHMyGYpBh52522WO+3+BuzVke7tDM8VqEIMBXonenLnw/Z
   5ePGbGcNJaGnCm1Qmc5Y04ZMOceUuZdJ3dv7ezzepEDIUicViuHHTpEDJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276988437"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276988437"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 21:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619133541"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 21:12:26 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o23LO-000P3N-1H;
        Fri, 17 Jun 2022 04:12:26 +0000
Date:   Fri, 17 Jun 2022 12:12:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Judy Hsiao <judyhsiao@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [v1] arm64: dts: rk3399: i2s: switch BCLK to GPIO
Message-ID: <202206171259.Mm7iOW4r-lkp@intel.com>
References: <20220615045146.3134420-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615045146.3134420-1-judyhsiao@chromium.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v5.19-rc2 next-20220616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Judy-Hsiao/arm64-dts-rk3399-i2s-switch-BCLK-to-GPIO/20220615-125441
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220617/202206171259.Mm7iOW4r-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1fba583f1d6efea74ff18356d44566c17fbdc4a1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Judy-Hsiao/arm64-dts-rk3399-i2s-switch-BCLK-to-GPIO/20220615-125441
        git checkout 1fba583f1d6efea74ff18356d44566c17fbdc4a1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi:6.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm64/boot/dts/rockchip/rk3399-evb.dts:10.1-2 syntax error
   FATAL ERROR: Unable to parse input tree
--
>> Error: arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi:6.1-2 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
