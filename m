Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF5951DBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442789AbiEFPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiEFPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:15:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426952F03F;
        Fri,  6 May 2022 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651849883; x=1683385883;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yHfDzCayxw0smKFpxdbArsN9Ikdnfmg63XFLoA4TdjE=;
  b=XzWyh365VREPgkfAPJzAQ5UaqEJ06mra9APv5zcu6yR20+vM7kf31nyb
   5CKTEfzWBmedirYIcciJMAT5NO7zsKoAQ4Xfr1f+jlv5AEKKX3uKmcS1G
   G09eRwPbXL68+L31MJKch7ODSLBOI8FHQmxCyEL7obx2x57Fm7/zJfmI+
   NcA5xiPFZxZrgqNBT8cqD6qGU8RxOA15q98M0qvV6MSVI4xxGwc628CFh
   o06ky60+Q7fZCuY52hf+cZBTLzMQGcJmKiofBuEQSSh5BMf9aw/NjjYQY
   JymSb4KNU3GGR647ujwhgag1c4cklK9NoP4R3IvbxiYyNPYOnFf4lN9kf
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268096065"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268096065"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="632969449"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 May 2022 08:11:15 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nmzbu-000Dai-VH;
        Fri, 06 May 2022 15:11:14 +0000
Date:   Fri, 6 May 2022 23:10:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974-hammerhead: Add notification LED
Message-ID: <202205062319.gc3Q6aGA-lkp@intel.com>
References: <20220505164336.13210-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505164336.13210-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220505]
[cannot apply to robh/for-next v5.18-rc5 v5.18-rc4 v5.18-rc3 v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Luca-Weiss/ARM-dts-qcom-msm8974-hammerhead-Add-notification-LED/20220506-004626
base:    632a8c88e339fe86ae6e420a24dfc641d4dd0ab5
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220506/202205062319.gc3Q6aGA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/982ec92f3741358d8ce62dd43841b550a6ab6a22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Luca-Weiss/ARM-dts-qcom-msm8974-hammerhead-Add-notification-LED/20220506-004626
        git checkout 982ec92f3741358d8ce62dd43841b550a6ab6a22
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts:317.1-12 Label or path pm8941_lpg not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
