Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951BE52CA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiESEC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbiESECu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:02:50 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B2395A28
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:02:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a3so6963196ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ec1W6nT2Fa0Ou0/ZDO4jx+xuJASI/q5lYcBKqBKZFFc=;
        b=ptUY8/FL0dNiJSXrRbb1niFvaooiWC5HVZgQ492tk4DZGbdk5+Eon1PX6k92UOOjd8
         ZZYKmB+Kd89mRKsU60F9xLi0m3Kf+XaBm/7PcKK+z/XizR/LUKW60Hnc39zgzyWkl5YR
         dZBXtAYJOvkpsmbIM6/iRMdnmkoZWrj3yuMd/KVGXsrU3AV87YoFnmlGuOa6h0NnRVBf
         onjuk2aF3H/NS6p3sc5a/yi/BKhWD+zuS76T7N3UrH0X97ukmDKuHT2Co/mUuoPAdnyd
         zWRnbIWbU0D7ONWi319Jg7Pb2Rm0ZzaEmy3dI5aGLxFBTF987ZQuJWb1s/TnI/bTdkZT
         uNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec1W6nT2Fa0Ou0/ZDO4jx+xuJASI/q5lYcBKqBKZFFc=;
        b=7iadK29L8n5dUnAK0fAb3vRtWEtfpEj7Mzxrk2BERDWzN2Hce3d+HFgZqc14WLMdJA
         rJQ+kFb02p0GMURasMzIDdrULCpG5diL7KgwXBhhPLR6MFvJz/L4UZMVyC0haUAIPuL2
         UIX7hqh8sW6+U8ggI4VPrEmPgVgLheb4O6y0szgOHzpCPbroYU5gI7DYa4bIz4Gen1tK
         aKY1qtaS26GynMq+VT59Y+UEoISYkJ3LMQ/uYhomUVwAjWJ20+F5dAEO2g1OEdx3cSJ7
         cvAXPvDHesBCU7TN0LfImviN+D+muS2l+b9DsbAghcAdJWzJIkD2sVHWHfb4lhWrXXoG
         e/bg==
X-Gm-Message-State: AOAM530K+OwPOjysJOnMPS5BK6D7tEkVK6sgKhk0UCn0nX4knls2BE2a
        xdNSxg452AuHlqf00eHasyhuXq/+MwWcS/0jhZEBMg==
X-Google-Smtp-Source: ABdhPJyen02pvKrp9A+FmGz7ZmDAC41QA4mTPwgy5BNSRvkF27t+LvWmKvWhi+BnytTXaDoZmpSMf+coQYGwONrhUE0=
X-Received: by 2002:a25:da12:0:b0:64b:aca4:f5b3 with SMTP id
 n18-20020a25da12000000b0064baca4f5b3mr2783110ybf.494.1652932967980; Wed, 18
 May 2022 21:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuCzU5VZ_nc+6NEdBXJdVCH=J2SB1Na1G_NS_0BNdGYtg@mail.gmail.com>
In-Reply-To: <CA+G9fYuCzU5VZ_nc+6NEdBXJdVCH=J2SB1Na1G_NS_0BNdGYtg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 19 May 2022 09:32:36 +0530
Message-ID: <CA+G9fYu_p0OjaeTjHN6MEnxeRgwZM5TPNsfvxa3P0RCPD7o=JQ@mail.gmail.com>
Subject: Re: net/ethernet/dec/tulip/eeprom.c:120:40: error: 'struct pci_dev'
 has no member named 'pdev'; did you mean 'dev'?
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rolf Eike Beer,

On Wed, 18 May 2022 at 19:19, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The Linux next-20220517 and next-20220518 arch parisc builds failed.
>
> Regressions found on parisc:
>  - gcc-8-defconfig
>  - gcc-9-defconfig
>  - gcc-11-defconfig
>  - gcc-10-defconfig
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=parisc
> CROSS_COMPILE=hppa-linux-gnu- 'CC=sccache hppa-linux-gnu-gcc'
> 'HOSTCC=sccache gcc'
> arch/parisc/kernel/vdso32/Makefile:30: FORCE prerequisite is missing
> drivers/net/ethernet/dec/tulip/eeprom.c: In function
> 'tulip_build_fake_mediatable':
> drivers/net/ethernet/dec/tulip/eeprom.c:120:40: error: 'struct
> pci_dev' has no member named 'pdev'; did you mean 'dev'?
>   120 |   tp->mtable = devm_kmalloc(&tp->pdev->pdev, sizeof(struct mediatable) +
>       |                                        ^~~~
>       |                                        dev
> make[6]: *** [scripts/Makefile.build:295:
> drivers/net/ethernet/dec/tulip/eeprom.o] Error 1

The bisection pointed to

first bad commit: [3daebfbeb4555cb0c113aeb88aa469192ee41d89]
   net: tulip: convert to devres

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

steps to reproduce:

# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake

tuxmake --runtime podman --target-arch parisc --toolchain gcc-10
--kconfig defconfig

> Build log link,
> https://builds.tuxbuild.com/29HszOsHU1On0kNlZbdJBfNWstp/
>
> --
> Linaro LKFT
> https://lkft.linaro.org
