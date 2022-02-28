Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CB14C6702
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiB1KRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiB1KRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:17:44 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BCE41314
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:17:06 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K6bsB2TTtz68021;
        Mon, 28 Feb 2022 18:17:02 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 11:17:04 +0100
Received: from localhost (10.47.74.66) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 10:17:03 +0000
Date:   Mon, 28 Feb 2022 10:17:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>
CC:     Liam Beguin <liambeguin@gmail.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Subject: Re: [jic23-iio:testing 231/235] iio-test-rescale.c:undefined
 reference to `kunit_binary_assert_format'
Message-ID: <20220228101703.00002a76@Huawei.com>
In-Reply-To: <202202280119.ftKfZpaB-lkp@intel.com>
References: <202202280119.ftKfZpaB-lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.74.66]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 01:18:31 +0800
kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git testing
> head:   95df41f4ef19f5884269e6c62dc1d128a23c94cb
> commit: 683352565c0396077086ae0bec530d03e6b3c6df [231/235] iio: test: add basic tests for the iio-rescale driver
> config: m68k-randconfig-m031-20220227 (https://download.01.org/0day-ci/archive/20220228/202202280119.ftKfZpaB-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=683352565c0396077086ae0bec530d03e6b3c6df
>         git remote add jic23-iio https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>         git fetch --no-tags jic23-iio testing
>         git checkout 683352565c0396077086ae0bec530d03e6b3c6df
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
> >> iio-test-rescale.c:(.text+0xaa): undefined reference to `kunit_binary_assert_format'
> >> m68k-linux-ld: iio-test-rescale.c:(.text+0x134): undefined reference to `kunit_binary_str_assert_format'  
>    m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
>    iio-test-rescale.c:(.text+0x35e): undefined reference to `kunit_binary_assert_format'
>    m68k-linux-ld: iio-test-rescale.c:(.text+0x4a6): undefined reference to `kunit_binary_assert_format'
>    m68k-linux-ld: iio-test-rescale.c:(.text+0x514): undefined reference to `kunit_binary_assert_format'
>    m68k-linux-ld: iio-test-rescale.c:(.text+0x600): undefined reference to `kunit_binary_assert_format'
>    m68k-linux-ld: iio-test-rescale.c:(.text+0x66e): undefined reference to `kunit_binary_assert_format'
>    m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_offset':
> >> iio-test-rescale.c:(.text+0x20): undefined reference to `kunit_kmalloc_array'  
>    m68k-linux-ld: iio-test-rescale.c:(.text+0xfa): undefined reference to `kunit_do_assertion'
>    m68k-linux-ld: drivers/iio/test/iio-test-rescale.o: in function `iio_rescale_test_scale':
>    iio-test-rescale.c:(.text+0x2e0): undefined reference to `kunit_kmalloc_array'
>    m68k-linux-ld: iio-test-rescale.c:(.text+0x3ae): undefined reference to `kunit_do_assertion'
>    m68k-linux-ld: net/core/sock.o: in function `sk_destruct':
>    (.text+0x411a): undefined reference to `__sk_defer_free_flush'

Looks like we need depends on KUNIT=y

I'll make that change an push out again.

Thanks,

Jonathan

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

