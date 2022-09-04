Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7623A5AC512
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbiIDPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIDPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:43:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00392E9F9;
        Sun,  4 Sep 2022 08:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D0C960FB2;
        Sun,  4 Sep 2022 15:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A9C433C1;
        Sun,  4 Sep 2022 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662306178;
        bh=NM+SzPbOtMpkvbk6twCAFTrJ5rbvFfL1WeUFuXU8Y7Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YTgso/jIdnzQNtQ3dgOGnNUpObkWej2Ho5P3z3QsEBBGzDINx6lmjY0pzBoPgU0FJ
         AwFXudWTRRY8CNXcoo3STqaDVzIM6cZL7zs7xs43KKDmVa0MacbWctzjvSc2jsuyXQ
         J8MzF25q6zLA76UP6Sgs1SfInsYcJb41jy1a/FI9OEUNCALXDbyWdf38dGSpubHxBQ
         M3RmIKVfktvyfXIxKAN5PHyz4HXLYqKgGxwH4raGX9T5inpVDGG426XjvUsiqwRAKs
         cKvNtY9utdUvVCw8AJs5TJ1cfqD9il9T1oCa3nAq9D/zwDiCrKvKAyej4gYfxcgkKm
         o6YrPZeeRswQg==
Date:   Sun, 4 Sep 2022 16:08:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ciprian Regus <ciprian.regus@analog.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v2 4/5] drivers: iio: adc: LTC2499 support
Message-ID: <20220904160850.77ad99e9@jic23-huawei>
In-Reply-To: <202209020359.vCYzjn4X-lkp@intel.com>
References: <20220901121700.1325733-4-ciprian.regus@analog.com>
        <202209020359.vCYzjn4X-lkp@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Sep 2022 04:00:05 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Ciprian,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on jic23-iio/togreg]
> [also build test ERROR on robh/for-next linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: hexagon-randconfig-r003-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020359.vCYzjn4X-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/08ff9ae09bfde86fc512e13a4ea2af894e4aa442
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Ciprian-Regus/dt-bindings-iio-adc-Add-docs-for-LTC2499/20220901-202115
>         git checkout 08ff9ae09bfde86fc512e13a4ea2af894e4aa442
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/adc/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/adc/ltc2497.c:60:12: error: call to undeclared function 'get_unaligned_be24'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]  
>                            *val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)
>                                    ^
>    drivers/iio/adc/ltc2497.c:122:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
>                    .name = NULL,
>                     ^
>    drivers/iio/adc/ltc2497.c:126:4: error: field designator 'name' does not refer to any field in type 'const struct ltc2497_chip_info'
>                    .name = "ltc2499",
>                     ^
>    3 errors generated.
> 
Ah. The power of automation proves itself again.  I missed that you'd
not added 

#include <asm/unaligned.h>
and that the .name field is introduced in a later patch.

Jonathan

> 
> vim +/get_unaligned_be24 +60 drivers/iio/adc/ltc2497.c
> 
>     34	
>     35	static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>     36					      u8 address, int *val)
>     37	{
>     38		struct ltc2497_driverdata *st =
>     39			container_of(ddata, struct ltc2497_driverdata, common_ddata);
>     40		int ret;
>     41	
>     42		if (val) {
>     43			if (st->recv_size == 3)
>     44				ret = i2c_master_recv(st->client, (char *)&st->data.d8, st->recv_size);
>     45			else
>     46				ret = i2c_master_recv(st->client, (char *)&st->data.d32, st->recv_size);
>     47	
>     48			if (ret < 0) {
>     49				dev_err(&st->client->dev, "i2c_master_recv failed\n");
>     50				return ret;
>     51			}
>     52	
>     53			/*
>     54			 * The data format is 16/24 bit 2s complement, but with an upper sign bit on the
>     55			 * resolution + 1 position, which is set for positive values only. Given this
>     56			 * bit's value, subtracting BIT(resolution + 1) from the ADC's result is
>     57			 * equivalent to a sign extension.
>     58			 */
>     59			if (st->recv_size == 3) {
>   > 60				*val = (get_unaligned_be24(st->data.d8) >> st->sub_lsb)  
>     61					- BIT(ddata->chip_info->resolution + 1);
>     62			} else {
>     63				*val = (be32_to_cpu(st->data.d32) >> st->sub_lsb)
>     64					- BIT(ddata->chip_info->resolution + 1);
>     65			}
>     66		}
>     67	
>     68		ret = i2c_smbus_write_byte(st->client,
>     69					   LTC2497_ENABLE | address);
>     70		if (ret)
>     71			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
>     72				ERR_PTR(ret));
>     73		return ret;
>     74	}
>     75	
> 

