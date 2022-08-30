Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C215A6047
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiH3KHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiH3KGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:06:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF87F2C83
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:03:33 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MH2tV5nWJz6842y;
        Tue, 30 Aug 2022 18:02:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 12:03:30 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 11:03:30 +0100
Date:   Tue, 30 Aug 2022 11:03:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Dmitry Rokosov <DDRokosov@sberdevices.ru>, <llvm@lists.linux.dev>,
        <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [jic23-iio:testing 124/129] drivers/iio/accel/msa311.c:993:24:
 warning: format specifies type 'unsigned char' but the argument has type
 'unsigned int'
Message-ID: <20220830110329.00000d18@huawei.com>
In-Reply-To: <202208290618.wU7mHfOp-lkp@intel.com>
References: <202208290618.wU7mHfOp-lkp@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 06:25:53 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   fc32c348a52157665cd8f3f060669ef4e8a03cd4
> commit: 1a622d75985c5950a470edc50c7ad7c10e79a1d3 [124/129] iio: add MEMSensing MSA311 3-axis accelerometer driver
> config: powerpc-randconfig-r024-20220829 (https://download.01.org/0day-ci/archive/20220829/202208290618.wU7mHfOp-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project a2100daf12fb980a29fd1a9c85ccf8eaaaf79730)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=1a622d75985c5950a470edc50c7ad7c10e79a1d3
>         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>         git fetch --no-tags jic23-iio testing
>         git checkout 1a622d75985c5950a470edc50c7ad7c10e79a1d3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iio/accel/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/iio/accel/msa311.c:993:24: warning: format specifies type 'unsigned char' but the argument has type 'unsigned int' [-Wformat]  
>                                               "msa311-%hhx", partid);
>                                                       ~~~~   ^~~~~~
>                                                       %x
>    1 warning generated.
> 
> 
> vim +993 drivers/iio/accel/msa311.c
> 
>    977	
>    978	static int msa311_check_partid(struct msa311_priv *msa311)
>    979	{
>    980		struct device *dev = msa311->dev;
>    981		unsigned int partid;
>    982		int err;
>    983	
>    984		err = regmap_read(msa311->regs, MSA311_PARTID_REG, &partid);
>    985		if (err)
>    986			return dev_err_probe(dev, err, "failed to read partid\n");
>    987	
>    988		if (partid != MSA311_WHO_AM_I)
>    989			dev_warn(dev, "invalid partid (%#x), expected (%#x)\n",
>    990				 partid, MSA311_WHO_AM_I);
>    991	
>    992		msa311->chip_name = devm_kasprintf(dev, GFP_KERNEL,
>  > 993						   "msa311-%hhx", partid);  

Dmitry,

I'm thinking intent here was to limit range of what was printed. Maybe better to use
local u8 variable or cast?

I can fix it up if that's fine with you - or even better send me a patch that fixes
it however you prefer!

Jonathan


>    994		if (!msa311->chip_name)
>    995			return dev_err_probe(dev, -ENOMEM, "can't alloc chip name\n");
>    996	
>    997		return 0;
>    998	}
>    999	
> 

