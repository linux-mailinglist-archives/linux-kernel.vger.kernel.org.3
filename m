Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE9B57F1FD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 00:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiGWWwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 18:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238926AbiGWWwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 18:52:02 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D4FD3E;
        Sat, 23 Jul 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658616718; x=1690152718;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CcMzN1ngFwzFBUCgmHF+q1Wx9bfh8y0odjoQnUGTIPc=;
  b=byQdz5q/AVrrjxq7aXukk1rLCxi2RS+2PCKeH9cGRBeBY7NmMPOH6dHS
   JbSWqh8dv3dOYq7XxmldT85mQvt9+SsMRw/LMUreFkSQAcSeSz38vtBIZ
   Y3lJqNGDT1VvZWcAV/aywuOwh5QHVMl4k0YvJLQADVTSnd8CdedvQLjb6
   syyti7IRfDPfCGSIn0khv1Ubqtc2g2hT0gqDzGBeG0T9hiCBIMC3kOO3S
   HiS5VP90OzSuP0cBsIL300niB0L0hWhS1u6lFkWBCJYLGslIFeYiMqskj
   pdDlhyYfW4j/jbUW1zaawy2ZLPyiuvLyrO5ZRoiLAz+l9SRQDk0VkxwtW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="313237254"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="313237254"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 15:51:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="688648014"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jul 2022 15:51:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFNyU-0003C5-1x;
        Sat, 23 Jul 2022 22:51:54 +0000
Date:   Sun, 24 Jul 2022 06:50:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>, linux-iio@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <202207240654.c7cPESiE-lkp@intel.com>
References: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50841287411a4e459487cc94a05bc6de66be4acf.1658597501.git.ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on 180c6cb6b9b79c55b79e8414f4c0208f2463af7d]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220724-014146
base:   180c6cb6b9b79c55b79e8414f4c0208f2463af7d
config: arm-buildonly-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220724/202207240654.c7cPESiE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/eb385b5ff634acc29a3d9f20847e62ec73484fcb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/Add-support-for-pressure-sensor-Bosch-BMP380/20220724-014146
        git checkout eb385b5ff634acc29a3d9f20847e62ec73484fcb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __aeabi_ldivmod
   >>> referenced by bmp280-core.c:887 (drivers/iio/pressure/bmp280-core.c:887)
   >>> iio/pressure/bmp280-core.o:(bmp380_read_press) in archive drivers/built-in.a
   >>> did you mean: __aeabi_idivmod
   >>> defined in: arch/arm/lib/lib.a(lib1funcs.o)
   pahole: .tmp_vmlinux.btf: No such file or directory
   ld.lld: error: .btf.vmlinux.bin.o: unknown file type

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
