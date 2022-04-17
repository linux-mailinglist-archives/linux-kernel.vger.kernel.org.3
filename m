Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8015048E2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 20:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiDQS0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiDQS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 14:26:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAFE03D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0rCece5Zi0kVB8NQ4umr5QXBugEtNp6vklpk2kdKUYs=; b=bJL4Q7yMwJLAg7oTxX9taJEKI+
        kBHBAyeaS5p3p3KcV8MiKc13XJDfucGvXsACJC9LWkeUNGQIAl0u8+8V9YP6Nkv+AcN9ClF8rJ3Sz
        mKAGPA6u2Rwnv85RaEWGkBJMFmJ6nzk2n+IWvv6t0sxrGJCcL5ajbXBPJJ0gDCbZz6WKXaEvms47Z
        /UuhlP2Z2V51aKaGziSklDL5x/ehFqw+a70C4bT+dDfA8bJpBTg4kBgLwFtuL5bVObF8U93HEkFnj
        HKG4lOLyiQcapXCUfCp/qe7wu4NrE2gSjHILZ7RADNq7vVGdGLHtF2923qn3E3WDbTI6Ik6ax+Kh0
        60Y4Qvrg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ng9Yj-001W3O-Lj; Sun, 17 Apr 2022 18:23:41 +0000
Message-ID: <e8c4d0ca-e770-662b-6f2b-7469232536fa@infradead.org>
Date:   Sun, 17 Apr 2022 11:23:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: sound/soc/codecs/tlv320adc3xxx.c:1209:28: error: implicit
 declaration of function 'devm_gpiod_get'; did you mean 'devm_gpio_free'?
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202204171002.8cMn0vn6-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202204171002.8cMn0vn6-lkp@intel.com>
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



On 4/16/22 19:19, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   a2c29ccd9477861b16ddc02c411a6c9665250558
> commit: 8e70aaae32b72d3088d18a3447b67112b3f5979a ASoC: zl38060: Remove spurious gpiolib select
> date:   10 weeks ago
> config: s390-randconfig-r026-20220417 (https://download.01.org/0day-ci/archive/20220417/202204171002.8cMn0vn6-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e70aaae32b72d3088d18a3447b67112b3f5979a
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 8e70aaae32b72d3088d18a3447b67112b3f5979a
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash sound/soc/codecs/
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

Patch is here:
  https://lore.kernel.org/lkml/20220409052120.3780-1-rdunlap@infradead.org/


-- 
~Randy
