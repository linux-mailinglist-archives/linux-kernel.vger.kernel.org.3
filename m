Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA819562247
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiF3SoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbiF3SoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:44:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26722CDDD;
        Thu, 30 Jun 2022 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656614648; x=1688150648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dYv/UTYgVlfEsqp2DTCmC737DJrOyfrarI+FKWvwhMA=;
  b=PiDkqQrt3SwX1E2SIQMaVwaPc49yekcfqAPCuF7aCdNtGjX/lpy9VMBx
   fbtjtcPwlNYgqwfgXqQgerXvMFnVwT5T4eMUS2X9T5zKE1Hhwpd/iETg8
   6W34fwASbbc3lgrrXbwPB2JKljFXHpA+g2KxPE3nuzhPT/Bi/lPjyo/Yo
   +IIS4Lw9WEqgkHqGVO3pTU0IlqEZTqP1uTp4jUBaDThnB+uRA1b4Bdz3B
   AhUxqLQVKt3jsI3MfFS+v+anYJb0UkvsO9m2TUKJKbGLePDHzjk47bOon
   cZUVxf4dEwjbolX9k4gSuspMaCUZyMDZv3c0W2GVGjYgk27/++JIXlhEB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="283534633"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="283534633"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 11:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="595917126"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jun 2022 11:44:06 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o6z93-000D50-By;
        Thu, 30 Jun 2022 18:44:05 +0000
Date:   Fri, 1 Jul 2022 02:44:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Taniya Das <quic_tdas@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Message-ID: <202207010242.gFemy13K-lkp@intel.com>
References: <20220614161118.12458-1-quic_tdas@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614161118.12458-1-quic_tdas@quicinc.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v5.19-rc4 next-20220630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Taniya-Das/arm64-dts-qcom-sc7280-Update-lpassaudio-clock-controller-for-resets/20220615-001326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220701/202207010242.gFemy13K-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3156737d3479e335c9ffd0d65e51b1ae6b6d1ec5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Taniya-Das/arm64-dts-qcom-sc7280-Update-lpassaudio-clock-controller-for-resets/20220615-001326
        git checkout 3156737d3479e335c9ffd0d65e51b1ae6b6d1ec5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ERROR: Input tree has errors, aborting (use -f to force output)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
