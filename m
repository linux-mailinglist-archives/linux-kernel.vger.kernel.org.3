Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6945A93A3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 11:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiIAJxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 05:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiIAJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 05:53:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5426135D0D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:53:27 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx38so17285075ljb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4r4jcY50iFaUT9RBdRXiNz4TmfPE3AoPP1YIZbbSRwY=;
        b=xXxlPOclhQHDe+QRrQ2CH9Wfz0YXOogVoveY0kLAeFlMC8t2g7NHdTunW2M1v3JfA7
         uO6qb1zHXlzZeYBKo7+yNsI1cNgwzdv2VGOS+ZZVxpi+Y3ygI4BACPBBUmmWHBr4/TO5
         8hyakRLXzV7vco3D9YByiWAG4jkieJOPQ2rqjO38G8GVdOoIbapooOvro2IFepcuSsAM
         PBeBXjx1DUetx9aePRPbg+QkEZjpmf/21k/1XGqr39epX0rPj3QMTGezJ5/W8asqV/H/
         1zU15n42j6GHMy0rK9YYSet/t9Igg4L5Ff5H5H16i7XpvXHsVd55fInpOa1RmRcWd5gB
         vlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4r4jcY50iFaUT9RBdRXiNz4TmfPE3AoPP1YIZbbSRwY=;
        b=2ggqUxZcyg19AANoGfnZXGb3JX5T8Dny3/4aMj1C/uFY9ftweQ/lQgMkSEO7lPpIzf
         CCK/k9CMf26PfR9WcKK0o9gsiL+tyTt9HuT5+2/IFfYnmBQZ/Z3vx7yJ6l5PrunO+guP
         6C1EDvukTkPfXNHIVJyk1sIZQ/3kU6ktDfcvheEKFAFUKULp/xJ6OKUgQqpJImw+0/HW
         0N4ESBhcRVFKJhTrYiFgVGvCwJsCzPMVSHz/JvPiYpc3ul7pNVQPpSiGqgKXijkbC73p
         ZY/MzeHAonlBzBnCb9Q9YyxI2LuPp1AAw/TgkxvmliXHlWAgajuLQ3paY0NW+YsfVz6D
         cn1Q==
X-Gm-Message-State: ACgBeo1R4txMMljCGmF8zFN7ZamiLfAgpr/2kgI2yk/8Karj93JPxuny
        7IGrhM60q+AlAc7FNDp5/0FS8LS9GmuH2H0I
X-Google-Smtp-Source: AA6agR5Eb8s1x3phyz5Qn5DADQgnHl1AR5td8Dv/q+qy2hmGVDNAvHL5N3+p5XsYXZndp7HJ8kyxTA==
X-Received: by 2002:a05:651c:110b:b0:268:9f54:a86d with SMTP id e11-20020a05651c110b00b002689f54a86dmr1490011ljo.493.1662026006068;
        Thu, 01 Sep 2022 02:53:26 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id b18-20020a056512061200b0048a8586293asm1764545lfe.48.2022.09.01.02.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 02:53:25 -0700 (PDT)
Message-ID: <039bf8da-5f20-4395-eb37-d60d4a358b0a@linaro.org>
Date:   Thu, 1 Sep 2022 12:53:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [broonie-sound:for-6.1 66/75] ERROR: modpost:
 "slim_stream_prepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202209011500.c78NSKsw-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <202209011500.c78NSKsw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 11:02, kernel test robot wrote:
> Hi Krzysztof,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.1
> head:   447d63a2cd89d3a74e1214067f4c564735ea0272
> commit: 5b7f4e5de61ba8c44317718936864da29eeba62a [66/75] ASoC: codecs: allow compile testing without MFD drivers
> config: riscv-randconfig-c032-20220831
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=5b7f4e5de61ba8c44317718936864da29eeba62a
>         git remote add broonie-sound https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>         git fetch --no-tags broonie-sound for-6.1
>         git checkout 5b7f4e5de61ba8c44317718936864da29eeba62a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> ERROR: modpost: "slim_stream_prepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "slim_stream_unprepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "slim_stream_disable" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "slim_stream_enable" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "__regmap_init_slimbus" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "slim_stream_allocate" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "slim_get_logical_addr" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!
>>> ERROR: modpost: "of_slim_get_device" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

I guess Mark that finally proves your point that these devices are too
coupled for compile test.

I can fix it up... or maybe just drop these two commits?

Best regards,
Krzysztof
