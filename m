Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128BA52E20B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344526AbiETBe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiETBez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:34:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9AB9B190;
        Thu, 19 May 2022 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653010494; x=1684546494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PD0LUvvtmIb9K8Grpc51OrTQynCSoemBKxewL9TVZA=;
  b=edYL3pYTqZAuOX7FA7LjxKZh+aKG98S9RXOlCsoLl8SBoDsioiHBOU9t
   RzDeCNht9Qu2Edrl0TF15In9LaEQYjziVZsEInjgcN3ZadUUJNWebZjUE
   20kgD/rjNlp3fzjt6e3FsALs2mDWzabfjjdZGtZOREqAFI+zoaLLHXS43
   Svg/RLYxPT0sR3IZxFEV0mQHrJ1t2vqupyBwTC9clOz43tSoPUMwUDs9j
   5l5lB8ErRBTCgdKMZnnMYi2Ba0w4reRHbdyXqPFAoWIrTVPe8LK7WNIi4
   eQQCp0V0Gs7CwjZsgzLRC9HUHfZm8glBzVAr1eAnS31zbR40M25Enkjqy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="297754779"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="297754779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 18:34:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="743240182"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2022 18:34:51 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrrXW-000488-OU;
        Fri, 20 May 2022 01:34:50 +0000
Date:   Fri, 20 May 2022 09:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alec Su <ae40515@yahoo.com.tw>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@codeaurora.org
Cc:     kbuild-all@lists.01.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        y.oudjana@protonmail.com, Alec Su <ae40515@yahoo.com.tw>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: msm8996-xiaomi-natrium: Add
 support for Xiaomi Mi 5s Plus
Message-ID: <202205200926.TE2gqa0N-lkp@intel.com>
References: <20220519074112.25600-2-ae40515@yahoo.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519074112.25600-2-ae40515@yahoo.com.tw>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alec,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Alec-Su/arm64-dts-qcom-msm8996-xiaomi-natrium-Add-support-for-Xiaomi-Mi-5s-Plus/20220519-164217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-randconfig-r022-20220518 (https://download.01.org/0day-ci/archive/20220520/202205200926.TE2gqa0N-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b35e1afb49b50a1d68a67f66a3eb6c4259f329fb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alec-Su/arm64-dts-qcom-msm8996-xiaomi-natrium-Add-support-for-Xiaomi-Mi-5s-Plus/20220519-164217
        git checkout b35e1afb49b50a1d68a67f66a3eb6c4259f329fb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts:79.1-9 Label or path mss_pil not found
>> Error: arch/arm64/boot/dts/qcom/msm8996-xiaomi-natrium.dts:106.1-10 Label or path slpi_pil not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
