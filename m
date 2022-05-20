Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64C552E2BA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbiETCyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbiETCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:53:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AB6B82F8;
        Thu, 19 May 2022 19:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653015237; x=1684551237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3k+B1YhQtDjjzNzSzWyBbPTZcYPfDZ9P6ZK83umeHFU=;
  b=P0Avw0cxVUh03g6Z0IfFGf6yrFt7TjYVi2Kp6v/7EJ18FQKxFuaTzHgb
   80AXbmUE6j6LwbRQfBW1IzwAUte+Pw/jppDKd/sgJPNGpPJtcumC0oJfd
   RSTphKMbcVLzUrKEQD9i/1Piqv2FKb0TH5dcyDUF2kAffMNA50DppO6I5
   GdUDaxsK74k8+/NDd2pfL7zUoXIkCCpBlQ0YMLLAsjhR93gHNoMNnBgSW
   3QE+3z/rjSPjuckYy/Otqc6jWDm5qWvqGfP2noMQelmOj2XTYHd/LVGUA
   pcP9T4S+F+lg1HQZ7BFjzI/R7mJmPeEoBepqgd1goCHkOwtm6S9tmJnsy
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333084921"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333084921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 19:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="674397628"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 May 2022 19:53:52 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrsm0-0004DS-9Y;
        Fri, 20 May 2022 02:53:52 +0000
Date:   Fri, 20 May 2022 10:53:07 +0800
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
Subject: Re: [v1 1/3] arm64: dts: qcom: sc7280: Add drive strength property
 for secondary MI2S
Message-ID: <202205201035.VNGXOfUp-lkp@intel.com>
References: <20220519084119.675990-2-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519084119.675990-2-judyhsiao@chromium.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test ERROR on v5.18-rc7]
[cannot apply to robh/for-next arm/for-next arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next keystone/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Judy-Hsiao/Add-dtsi-for-sc7280-boards-that-using-rt5682-codec/20220519-164227
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220520/202205201035.VNGXOfUp-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b59ef0e3880c11efecbe61bebfe9352c76bf96f4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Judy-Hsiao/Add-dtsi-for-sc7280-boards-that-using-rt5682-codec/20220519-164227
        git checkout b59ef0e3880c11efecbe61bebfe9352c76bf96f4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:615.1-13 Label or path mi2s1_data0 not found
>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:620.1-12 Label or path mi2s1_sclk not found
>> Error: arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi:625.1-10 Label or path mi2s1_ws not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
