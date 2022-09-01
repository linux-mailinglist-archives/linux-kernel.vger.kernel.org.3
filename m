Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6455AA094
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiIAUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiIAUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:01:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE82B63F;
        Thu,  1 Sep 2022 13:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662062457; x=1693598457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9CNCdh37HQpXfoKag83bABbqLmKvR1bu2wVfZ/FQCA=;
  b=MBnfZO9fxP3jF/h+wNKfg9L5y0TvynxebcEuYGCKVv2kzZsxdqFQFfa2
   XyH+FR0Ny0PMKMLzF0nZ8PpMoH0RFal0nyvNfLWK/MaV0DF5ezIpUQR3C
   fKXfn/ldjiWz7NfH80TnRDr+oBnixyGzIVnRC3mA3YDZOUHocnKWAa2NJ
   U6s8DwxY9ZJZwxbG33V6M390E6yMPFubyJ39bePj5J/sQyD1dgLrsDd5H
   7j61DKQqaXB9pCtZEbNduV6+C/24tYZbMmrslu7+Ykk8czfm9HBk9BlH0
   SsKtVpBMAxN3DTG/fmbkEiakVZM+JrfL2hMD7yiqWq3ucNwa+PmPXzIV4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297099502"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="297099502"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 13:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="681002984"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 01 Sep 2022 13:00:54 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTqMv-0000ig-1a;
        Thu, 01 Sep 2022 20:00:53 +0000
Date:   Fri, 2 Sep 2022 04:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ciprian Regus <ciprian.regus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <202209020359.vCYzjn4X-lkp@intel.com>
References: <20220901121700.1325733-4-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901121700.1325733-4-ciprian.regus@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ciprian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r003-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020359.vCYzjn4X-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/08ff9ae09bfde86fc512e13a4ea2af894e4aa442
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
        git checkout 08ff9ae09bfde86fc512e13a4ea2af894e4aa442
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/adc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ltc2497.c:60:12: error: call to undeclared function 'get_unaligned_be24'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           *val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
                                   ^
   drivers/iio/adc/ltc2497.c:122:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
                   .name = NULL,
                    ^
   drivers/iio/adc/ltc2497.c:126:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
                   .name = "ltc2499",
                    ^
   3 errors generated.


vim +/get_unaligned_be24 +60 drivers/iio/adc/ltc2497.c

    34	
    35	static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
    36					      u8 address, int *val)
    37	{
    38		struct ltc2497_driverdata *st =
    39			container_of(ddata, struct ltc2497_driverdata, common_ddata);
    40		int ret;
    41	
    42		if (val) {
    43			if (st->recv_size == 3)
    44				ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
    45			else
    46				ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
    47	
    48			if (ret < 0) {
    49				dev_err(&st->client->dev, "i2c_master_recv failed\n");
    50				return ret;
    51			}
    52	
    53			/*
    54			 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
    55			 * resolution + 1 position, which is set for positive values only. Given this
    56			 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
    57			 * equivalent to a sign extension.
    58			 */
    59			if (st->recv_size == 3) {
  > 60				*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
    61					- BIT(ddata->chip_info->resolution + 1);
    62			} else {
    63				*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
    64					- BIT(ddata->chip_info->resolution + 1);
    65			}
    66		}
    67	
    68		ret = i2c_smbus_write_byte(st->client,
    69					   LTC2497_ENABLE | address);
    70		if (ret)
    71			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
    72				ERR_PTR(ret));
    73		return ret;
    74	}
    75	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
