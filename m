Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C549D57793D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 03:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiGRBYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 21:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiGRBYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 21:24:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7730565FD;
        Sun, 17 Jul 2022 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658107469; x=1689643469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2EKYGRxFwOowb+2/VvkXh77NNCMzCGVW6f9edVohmqU=;
  b=nWRymceehoIfS+fxc+k2dI1UQ+h654LpPDxZxEABr7rCHt2Qs2wNDjAB
   VPXBxGtqJtC5go2YJWRTQ3jm7Ux173upVpu4aIgFxD4evxYqntHtztOss
   3fZupdfP2WH5sNphfsBhbCCAKCzfS6NOOj3Wr8FYu2gFBe86TDYIkYvFL
   yym0oHLJnCnxH/DMzC2JcTlpI5GbhNEZBRw9t4oX0j6c0/tUDkn/VMaeq
   ShWQtQd2RbvssIa4a6+ku383CMDM3nnhmcdGALPizUmdIX5vApTLX9aU1
   VNIwumFLa3dqTwQLHPoOFpDXvkpKJIkV+A5HUeJbMHu7FLEHcrNhvGknl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="286128173"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="286128173"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 18:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="843105175"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2022 18:24:25 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDFUm-0003rU-Q9;
        Mon, 18 Jul 2022 01:24:24 +0000
Date:   Mon, 18 Jul 2022 09:24:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, j.neuschaefer@gmx.net,
        zhengbin13@huawei.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO
 driver
Message-ID: <202207180959.yy7mZtRy-lkp@intel.com>
References: <20220714122322.63663-3-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714122322.63663-3-tmaimon77@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomer,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linus/master v5.19-rc7 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tomer-Maimon/pinctrl-nuvoton-add-pinmux-and-GPIO-driver-for-NPCM8XX/20220714-202424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220718/202207180959.yy7mZtRy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 07022e6cf9b5b3baa642be53d0b3c3f1c403dbfd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0a5f158322b21ab2b71cc606adc2ee7573d8be0d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tomer-Maimon/pinctrl-nuvoton-add-pinmux-and-GPIO-driver-for-NPCM8XX/20220714-202424
        git checkout 0a5f158322b21ab2b71cc606adc2ee7573d8be0d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/media/i2c/ drivers/net/pcs/ drivers/pinctrl/nuvoton/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c:481:18: warning: unused variable 'smb14b_pins' [-Wunused-const-variable]
   static const int smb14b_pins[] = { 32, 187 };
                    ^
   1 warning generated.


vim +/smb14b_pins +481 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c

   439	
   440	static const int smb0_pins[]  = { 115, 114 };
   441	static const int smb0b_pins[] = { 195, 194 };
   442	static const int smb0c_pins[] = { 202, 196 };
   443	static const int smb0d_pins[] = { 198, 199 };
   444	static const int smb0den_pins[] = { 197 };
   445	static const int smb1_pins[]  = { 117, 116 };
   446	static const int smb1b_pins[] = { 126, 127 };
   447	static const int smb1c_pins[] = { 124, 125 };
   448	static const int smb1d_pins[] = { 4, 5 };
   449	static const int smb2_pins[]  = { 119, 118 };
   450	static const int smb2b_pins[] = { 122, 123 };
   451	static const int smb2c_pins[] = { 120, 121 };
   452	static const int smb2d_pins[] = { 6, 7 };
   453	static const int smb3_pins[]  = { 30, 31 };
   454	static const int smb3b_pins[] = { 39, 40 };
   455	static const int smb3c_pins[] = { 37, 38 };
   456	static const int smb3d_pins[] = { 59, 60 };
   457	static const int smb4_pins[]  = { 28, 29 };
   458	static const int smb4b_pins[] = { 18, 19 };
   459	static const int smb4c_pins[] = { 20, 21 };
   460	static const int smb4d_pins[] = { 22, 23 };
   461	static const int smb4den_pins[] = { 17 };
   462	static const int smb5_pins[]  = { 26, 27 };
   463	static const int smb5b_pins[] = { 13, 12 };
   464	static const int smb5c_pins[] = { 15, 14 };
   465	static const int smb5d_pins[] = { 94, 93 };
   466	static const int smb6_pins[]  = { 172, 171 };
   467	static const int smb6b_pins[] = { 2, 3 };
   468	static const int smb6c_pins[]  = { 0, 1 };
   469	static const int smb6d_pins[]  = { 10, 11 };
   470	static const int smb7_pins[]  = { 174, 173 };
   471	static const int smb7b_pins[]  = { 16, 141 };
   472	static const int smb7c_pins[]  = { 24, 25 };
   473	static const int smb7d_pins[]  = { 142, 143 };
   474	static const int smb8_pins[]  = { 129, 128 };
   475	static const int smb9_pins[]  = { 131, 130 };
   476	static const int smb10_pins[] = { 133, 132 };
   477	static const int smb11_pins[] = { 135, 134 };
   478	static const int smb12_pins[] = { 221, 220 };
   479	static const int smb13_pins[] = { 223, 222 };
   480	static const int smb14_pins[] = { 22, 23 };
 > 481	static const int smb14b_pins[] = { 32, 187 };
   482	static const int smb15_pins[] = { 20, 21 };
   483	static const int smb15b_pins[] = { 192, 191 };
   484	static const int smb16_pins[] = { 10, 11 };
   485	static const int smb16b_pins[] = { 218, 219 };
   486	static const int smb17_pins[] = { 3, 2 };
   487	static const int smb18_pins[] = { 0, 1 };
   488	static const int smb19_pins[] = { 60, 59 };
   489	static const int smb20_pins[] = { 234, 235 };
   490	static const int smb21_pins[] = { 169, 170 };
   491	static const int smb22_pins[] = { 40, 39 };
   492	static const int smb23_pins[] = { 38, 37 };
   493	static const int smb23b_pins[] = { 134, 134 };
   494	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
