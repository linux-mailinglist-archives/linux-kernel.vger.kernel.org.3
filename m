Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66802519047
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243013AbiECV2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiECV2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:28:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD7424B1;
        Tue,  3 May 2022 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651613073; x=1683149073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VquISUrDva1ii+/TThhn+PnxLPxmCUEioQRKIcqao2w=;
  b=To/CT909OFhDgWjFBuFNxp158SY9LsEy6ufrES/EN6CLAg9YpSLdrbj1
   7NowfGCsR9nZgXtQCLg7vGxUTws/CMExWrey+MXYcRwLziYqABHOyTbhb
   triLxlTd5EJlA/dx1ortCI1wIJjuA7nul/KeKIhtB5rMVw4siAFOZ5mLU
   XKt2pKtcNn+fhEB4gS96d8HHNRKT2oqukQIcBRRvisA28z1JKihfATX5V
   SNSaoFAPm0PvIJz8FP3Fa2pXwL/biRpwniD35VBLAgst1agxQbMUH/Zd7
   o1QSkfoIpMYsb9viux3eDMlHJB0jSGiEVD8vh1yWjwbVJLGA0XEVpiiRp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255056712"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="255056712"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 14:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="889153341"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 May 2022 14:24:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm00Q-000Ao1-CT;
        Tue, 03 May 2022 21:24:26 +0000
Date:   Wed, 4 May 2022 05:23:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, shawnx.tu@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 2/3] media: ov5675: add device-tree support
Message-ID: <202205040514.C0uKmI1p-lkp@intel.com>
References: <20220503154259.1166203-2-foss+kernel@0leil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503154259.1166203-2-foss+kernel@0leil.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Quentin-Schulz/media-dt-bindings-ov5675-document-YAML-binding/20220503-234500
base:   git://linuxtv.org/media_tree.git master
config: x86_64-randconfig-a011-20220502 (https://download.01.org/0day-ci/archive/20220504/202205040514.C0uKmI1p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1623110421bc0b9cec990a62a40655076de1e71c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Quentin-Schulz/media-dt-bindings-ov5675-document-YAML-binding/20220503-234500
        git checkout 1623110421bc0b9cec990a62a40655076de1e71c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpio/ drivers/leds/ drivers/media/i2c/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/ov5675.c:1383:34: warning: unused variable 'ov5675_of_match' [-Wunused-const-variable]
   static const struct of_device_id ov5675_of_match[] = {
                                    ^
   1 warning generated.


vim +/ov5675_of_match +1383 drivers/media/i2c/ov5675.c

  1382	
> 1383	static const struct of_device_id ov5675_of_match[] = {
  1384		{ .compatible = "ovti,ov5675", },
  1385		{ /* sentinel */ },
  1386	};
  1387	MODULE_DEVICE_TABLE(of, ov5675_of_match);
  1388	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
