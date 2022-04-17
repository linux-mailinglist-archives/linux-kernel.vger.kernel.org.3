Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF680504996
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 23:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiDQVKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiDQVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 17:10:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6E1140BD
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=yWikpt6ZaDbOTYkBAxtE+6/i5DElWQGx+qhwMCDAFvE=; b=k7bsbBaeJz7I2FVS7ok9ve6DGW
        hAK4xQQ02ENXSkW4qX44qqvr1mNfCZIWrI6v5UYMhwY19ffyc94p3cLRVCKx1ZuplauitDksLpCAA
        KqXfG5z2G8Puchq0GAttV5L9bGKCkBs6EOO7aE+O5bJWmnE7AS3cIGw71s/3zdCPu+SmO1daN3a+c
        gW29X3sku3I9AqZReTitSP7+Hfl3IYfyzZbrygBPM7OQCQTDDwA81NT3afNI3V2hZfd/C/AkD/T71
        boYwkIaX22Qv1tmtLkvNNPtu4JOFjYX1xL+rsZchAURHhrQ2bQGhkHG7OpjB0eVnWJUY5KAtHkAjc
        iQrRfEVA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngC6G-001afi-3A; Sun, 17 Apr 2022 21:06:28 +0000
Message-ID: <05df5b18-3cae-9f43-4209-81264c0225af@infradead.org>
Date:   Sun, 17 Apr 2022 14:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: sound/soc/codecs/tlv320adc3xxx.c:1209:28: error: implicit
 declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ricard Wanderlof <ricardw@axis.com>
References: <202204180359.PbjuGlvd-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204180359.PbjuGlvd-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/22 12:53, kernel test robot wrote:
> Hi Mark,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a2c29ccd9477861b16ddc02c411a6c9665250558
> commit: 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f ASoC: simple-amplifier: Remove spurious gpiolib select
> date:   10 weeks ago
> config: m68k-randconfig-c023-20220418 (https://download.01.org/0day-ci/archive/20220418/202204180359.PbjuGlvd-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 44bd27c42a1c9a00f1fbcb58301a7f3e6f5cdd0f
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash sound/soc/codecs/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc/codecs/tlv320adc3xxx.c: In function 'adc3xxx_i2c_probe':
>>> sound/soc/codecs/tlv320adc3xxx.c:1209:28: error: implicit declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'? [-Werror=implicit-function-declaration]
>     1209 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>          |                            ^~~~~~~~~~~~~~
>          |                            devm_gpio_free
>>> sound/soc/codecs/tlv320adc3xxx.c:1209:57: error: 'GPIOD_OUT_LOW' undeclared (first use in this function); did you mean 'GPIOF_INIT_LOW'?
>     1209 |         adc3xxx->rst_pin = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>          |                                                         ^~~~~~~~~~~~~
>          |                                                         GPIOF_INIT_LOW
>    sound/soc/codecs/tlv320adc3xxx.c:1209:57: note: each undeclared identifier is reported only once for each function it appears in
>>> sound/soc/codecs/tlv320adc3xxx.c:1257:9: error: implicit declaration of function 'gpiod_set_value_cansleep'; did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]
>     1257 |         gpiod_set_value_cansleep(adc3xxx->rst_pin, 1);
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~
>          |         gpio_set_value_cansleep
>    cc1: some warnings being treated as errors
> 

Fix is here:

https://lore.kernel.org/lkml/20220409052120.3780-1-rdunlap@infradead.org/

-- 
~Randy
