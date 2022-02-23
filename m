Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C604C1751
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbiBWPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242262AbiBWPnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:43:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D42D1E5;
        Wed, 23 Feb 2022 07:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645630960; x=1677166960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e4iUHA2a+l+KhADALNLZscJEFxyySLAdMRx9NxqUlUY=;
  b=GNHIh5uRR7RcnJ11FeOqgVCXkLbsF+4dd992sq4ECeK+3VqBWb3PS83T
   eSuZ5Is/xdBVdm/JNA1Cc5AiCPurRdkWlIy9SREcP78D6FHSa/J/hPsbx
   Gmz0XvvgEy1Wig14Ei9c/nPNDEzdGbjS9B+XYm01GxUmAzKb+o+YdQwxV
   ZxlgiVMW9JJJKGW5uvtKbeM/g09SZ05sUpNBHCSSSD/XpL6UzuFJLyTBY
   bbHZL/OCuqPjNt1p7fENqaNCagBGFPfmLP0BtK6mnBNzSB56Z8+idasSS
   jBPY+8O9ceNE9zpOSDukQGCHvOsxflf2sugfaDHaB1EcWY26Fff38tAvp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="235500200"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="235500200"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 07:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="591739627"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2022 07:42:36 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMtml-0001ZQ-W6; Wed, 23 Feb 2022 15:42:35 +0000
Date:   Wed, 23 Feb 2022 23:41:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Markuss Broks <markuss.broks@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Input: add Imagis touchscreen driver
Message-ID: <202202232342.Ew209GPR-lkp@intel.com>
References: <20220222203414.8656-3-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222203414.8656-3-markuss.broks@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

I love your patch! Perhaps something to improve:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on linux/master robh/for-next linus/master v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Markuss-Broks/Add-support-for-Imagis-touchscreens/20220223-043645
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
config: arm-randconfig-s031-20220223 (https://download.01.org/0day-ci/archive/20220223/202202232342.Ew209GPR-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/bc77ee5e0d7309edca7d65925c6afa05334b0b01
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Markuss-Broks/Add-support-for-Imagis-touchscreens/20220223-043645
        git checkout bc77ee5e0d7309edca7d65925c6afa05334b0b01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/input/touchscreen/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/imagis.c:65:35: sparse: sparse: cast to restricted __be32

vim +65 drivers/input/touchscreen/imagis.c

    40	
    41	static int imagis_i2c_read_reg(struct imagis_ts *ts,
    42				       unsigned int reg, unsigned int *buffer)
    43	{
    44		__be32 reg_be = cpu_to_be32(reg);
    45		struct i2c_msg msg[] = {
    46			{
    47				.addr = ts->client->addr,
    48				.flags = 0,
    49				.buf = (unsigned char *)&reg_be,
    50				.len = sizeof(reg_be),
    51			}, {
    52				.addr = ts->client->addr,
    53				.flags = I2C_M_RD,
    54				.buf = (unsigned char *)buffer,
    55				.len = sizeof(reg_be),
    56			},
    57		};
    58		int ret, error;
    59		int retry = IST3038C_I2C_RETRY_COUNT;
    60	
    61		/* Retry in case the controller fails to respond */
    62		do {
    63			ret = i2c_transfer(ts->client->adapter, msg, ARRAY_SIZE(msg));
    64			if (ret == ARRAY_SIZE(msg)) {
  > 65				*buffer = be32_to_cpu(*buffer);
    66				return 0;
    67			}
    68	
    69			error = ret < 0 ? ret : -EIO;
    70			dev_err(&ts->client->dev,
    71				"%s - i2c_transfer failed: %d (%d)\n",
    72				__func__, error, ret);
    73		} while (--retry);
    74	
    75		return error;
    76	}
    77	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
