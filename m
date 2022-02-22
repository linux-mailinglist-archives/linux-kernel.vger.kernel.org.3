Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20FB4BEF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238996AbiBVCQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:16:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBVCQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:16:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0C25589;
        Mon, 21 Feb 2022 18:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645496151; x=1677032151;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/DzTfGp3/ss+OtkjPmEsFuhrYjk447cfjdaz6luL3Po=;
  b=gIyJTdwa7a9CKYJgGT7PQKu8ZshUQP8RyNmphqYH/n0whSvzyZW/C6Bf
   LBYtc7IHkymoscIVaOMTsqa3zyHHnPm1Eqoq+ivxRB2GOFhjghZI92GB5
   1nCzgv8vBg3wF5puxpk97zuPrRQlq9qCgYKCj4d4soXqmitYlk0yOCLSP
   Lh/2i8mcYg13TXMGC0hGd6uyZlopEeoEqsDpeIy0XsfPipv/YGS+zKoVo
   Q+zNr5SS9KkS47iRygmkkbY+Y7y9T+NlONzOg1GrBn+qQcvgpKt/dAc3Q
   T1eLfBY8EVnCuSNkR9jq/fxPxsTGim6fY9wh2GcYcLC9Gq4rJ/1WpYf1s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232214598"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="232214598"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 18:15:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="591136330"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 18:15:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMKiS-0002EA-86; Tue, 22 Feb 2022 02:15:48 +0000
Date:   Tue, 22 Feb 2022 10:15:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 2/8] iio: accel: adxl345: Set driver_data for OF
 enumeration
Message-ID: <202202221020.VX0nc5j6-lkp@intel.com>
References: <20220221233235.86893-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233235.86893-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r036-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221020.VX0nc5j6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2d02dfc34a92b731790a911491fbb13cf2e6e882
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
        git checkout 2d02dfc34a92b731790a911491fbb13cf2e6e882
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_spi.c:48:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl345", ADXL345 },
                                          ^~~~~~~
   drivers/iio/accel/adxl345_spi.c:49:33: warning: incompatible integer to pointer conversion initializing 'const void *' with an expression of type 'int' [-Wint-conversion]
           { .compatible = "adi,adxl375", ADXL375 },
                                          ^~~~~~~
   2 warnings generated.


vim +48 drivers/iio/accel/adxl345_spi.c

    46	
    47	static const struct of_device_id adxl345_of_match[] = {
  > 48		{ .compatible = "adi,adxl345", ADXL345 },
    49		{ .compatible = "adi,adxl375", ADXL375 },
    50		{ },
    51	};
    52	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
