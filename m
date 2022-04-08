Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA64F9DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiDHTwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 15:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbiDHTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:52:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB82CE7;
        Fri,  8 Apr 2022 12:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649447409; x=1680983409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFsxnCy8jPc0T8qrhjEMXjZ/Yl35VCVnze/5CyH4DhI=;
  b=eAp+xma37z+Q90McpeCvtk05+uxrQhk/YUfTYBZuqwPRLWInwmLkRRVE
   tGaMMUTqg7gpCCAe/FUMc8U1ZOP7ZwlhR1QUJoXRoqu1iaYqJJJp0/Fs+
   0PU9crgLQ68sOiIK8QNf7ucLMwxSC2ji99S/le3iSqYO79kktypmQTcLy
   +/19acWkD/godtNk9aAtcXCCARz3+q0AN15eDSI00wQnMondHb0N25fLy
   5M3Aku2Pzbw7RHGZrhArSQBpubcXnGEE7y+jWiJHwTDNQuBizq/4LmchN
   zFM1NOfpGBB00/fX763o+G9cnGsy5JWLJrjsgjJBuNzD4r1+2T6oDr45M
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260515949"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="260515949"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="524897967"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Apr 2022 12:50:05 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncucO-0000aT-JY;
        Fri, 08 Apr 2022 19:50:04 +0000
Date:   Sat, 9 Apr 2022 03:49:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm7225-fairphone-fp4: Add AW8695
 haptics
Message-ID: <202204090333.QZXMI2tu-lkp@intel.com>
References: <20220408115311.237039-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408115311.237039-3-luca.weiss@fairphone.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on dtor-input/next]
[also build test ERROR on hid/for-next robh/for-next v5.18-rc1 next-20220408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Weiss/dt-bindings-input-Add-bindings-for-Awinic-AW8695-haptics/20220408-195432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: arm64-randconfig-r015-20220408 (https://download.01.org/0day-ci/archive/20220409/202204090333.QZXMI2tu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3f233916afe417b8d4b9100f560892dff2c93f0c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luca-Weiss/dt-bindings-input-Add-bindings-for-Awinic-AW8695-haptics/20220408-195432
        git checkout 3f233916afe417b8d4b9100f560892dff2c93f0c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts:298.1-7 Label or path i2c10 not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
