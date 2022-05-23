Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E567B530711
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiEWBTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiEWBTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:19:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D758B63;
        Sun, 22 May 2022 18:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653268774; x=1684804774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78kjYs7ZIDlhmHigjs7ovuAb6IYSuJcnZJtEKzQWmnM=;
  b=JRCQU8GmuT/NtDyYCOZ7SvKDvVXxZd0bFI+v2jHCXSPLsLnNhkUi2HNq
   MfOAbaVvjiijfLQvOAojxGavIhwMSsYzDjwWxSCqWU1ZtHKcp9kV6RMMl
   nYFdxT1jp8swi4/tdnxGpdCiKijkHmWAQpwE8HG401gP5Zn9+dQsfA17A
   CtcPBuewDglqQlpLcPW9m5pk1DPiULubyL3M1Or5FfyLuT9TT/K1UIEKu
   Bm9OBkjSXgOWS7Fecm6l76hH3UhQkX+fYrTawhTLUJUKQEzvG+i7a/jJp
   cZsstbpncPwIUBEre1HvnGTlozwB1j1APVuOzrsNYoaTO1FHFjorZOCzg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="336126828"
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="336126828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 18:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,245,1647327600"; 
   d="scan'208";a="629101669"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2022 18:19:28 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nswjH-0000ms-Oz;
        Mon, 23 May 2022 01:19:27 +0000
Date:   Mon, 23 May 2022 09:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Judy Hsiao <judyhsiao@chromium.org>, Andy Gross <agross@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, tzungbi@chromium.org, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: Re: [v1 3/3] arm64: dts: qcom: sc7280: include
 sc7280-herobrine-audio-rt5682.dtsi in villager and herobrine-r1
Message-ID: <202205230902.SjYN7dSW-lkp@intel.com>
References: <20220519084119.675990-4-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519084119.675990-4-judyhsiao@chromium.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Judy,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[cannot apply to robh/for-next arm/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next keystone/next v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Judy-Hsiao/Add-dtsi-for-sc7280-boards-that-using-rt5682-codec/20220519-164227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220523/202205230902.SjYN7dSW-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7d7f6f8d1383ed458da5ba18090dd7ce30e1c96b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Judy-Hsiao/Add-dtsi-for-sc7280-boards-that-using-rt5682-codec/20220519-164227
        git checkout 7d7f6f8d1383ed458da5ba18090dd7ce30e1c96b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:615.1-13 Label or path mi2s1_data0 not found
   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:620.1-12 Label or path mi2s1_sclk not found
   Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:625.1-10 Label or path mi2s1_ws not found
>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi:29.29-30 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
