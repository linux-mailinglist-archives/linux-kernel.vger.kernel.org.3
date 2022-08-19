Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15659599667
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347185AbiHSHpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347179AbiHSHpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:45:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CE1D7410
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:45:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d23so738233lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=k40pphVIrC/hl+UDDLkChunxQ9ZlZaN2DrnGqw37Mvk=;
        b=N9Knrx+42jWeUME9NcD+zlrLps7kMirxyTjjQEPCAcMxsf6xXhWMXMhKCyNxjn3tzV
         sCbJI1JsFJNCicWLBBPI0FmmURF82PtrsgaRDp0il/4Vrn+4czCgRCKSRorL6b0TbifY
         RgL45iDzsXHqexI4kBf9V7IMkITginkVPUgzisN3f9iIvdzCSrGxN+CiRnpbcDNVTmUc
         ooiMp6j+lBkcWpF9Mljcej6hS1DQXle3mvDnH6HqaZcHmz5GDiJV4/co96B0ZisyYPln
         f1kg3L5cGfjYbFJl3Uqoi8nRc1aGxqLGp/JEx3VWm5jexM41akqYVJDxHiSHSMCNLm7m
         TJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=k40pphVIrC/hl+UDDLkChunxQ9ZlZaN2DrnGqw37Mvk=;
        b=wzJNjt68/GYQkEfssDpsjr5J7NdxDVhcihU2oQoaotmzro+bvaM+uXWERh3DQVJTCz
         +ssNiUa1R1n1P4EGh/27q/wAg3zVkvkQjpEV4fFy5GSlZOSdPvDYeL6sfr/AQQAmKjqd
         eQcHu8FpwgfgqdjM+QogS8xfRjseqMTaFoJRfj74Dep60pcRC69fzUx5dJhnUFRnptJd
         wxOl+rjqx0HtGjEoyqUlPgAQ6vFZAWz2VlcQLGGDzEG3/n7lhU4uZPOYCZEeBhi92dMq
         O4ocyHSjajRyKWAXTttH5oVNOfnwTj7mmsUzYCsYmowf5HKX8YWnDy3SHVIiAhRp1Jsu
         hArQ==
X-Gm-Message-State: ACgBeo2DhGGnEwRtwMNez2bOcOFO6Zr1EcLcIYF4NC7i1sRLVV8jxAaG
        HsKsn8lbnSqo+WkG9I/MPBBXWg==
X-Google-Smtp-Source: AA6agR41HCrlCqiow9W/ymyV0hONqo9ynnSbihel/Naj2ZMyCS9ei/QVtV+1MhVqLBVMhHsFvbZJfQ==
X-Received: by 2002:a19:a415:0:b0:48d:13c2:1f4c with SMTP id q21-20020a19a415000000b0048d13c21f4cmr2206968lfc.166.1660895140289;
        Fri, 19 Aug 2022 00:45:40 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id h12-20020a19700c000000b0048aef1abb08sm530046lfc.297.2022.08.19.00.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 00:45:39 -0700 (PDT)
Message-ID: <f2440a64-f40d-7923-1c7b-1430ab557e59@linaro.org>
Date:   Fri, 19 Aug 2022 10:45:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] ARM: remove obsolete Makefile.boot infrastructure
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ard Biesheuvel <ardb@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20220818145616.3156379-1-arnd@kernel.org>
 <20220818145616.3156379-2-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818145616.3156379-2-arnd@kernel.org>
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

On 18/08/2022 17:56, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are a number of old Makefile.boot files that remain from the
> multiplatform conversion, and three that are still in use.
> 
> These provide the "ZRELADDR", "PARAMS_PHYS" and "INITRD_PHYS" values
> that are platform specific. It turns out that we can generally just
> derive this from information that is available elsewhere:
> 
> - ZRELADDR is normally detected at runtime with the
>   CONFIG_AUTO_ZRELADDR flag, but also needed to be passed to
>   for 'make uImage'. In a multiplatform kernel, one always has
>   to pass this as the $(LOADADDR) variable, but in the StrongARM
>   kernels we can derive it from the sum of $(CONFIG_PHYS_OFFSET)
>   and $(TEXT_OFFSET) that are already known.
> 
> - PARAMS_PHYS and INITRD_PHYS are only used for bootpImage, which
>   in turn is only used for the pre-ATAGS 'param_struct' based boot
>   interface on StrongARM based machines with old boot loaders.
>   They can both be derived from CONFIG_PHYS_OFFSET and a machine
>   specific offset for the initrd, so all of the logic for these
>   can be part of arch/arm/boot/bootp/Makefile.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                       |  2 +-
>  arch/arm/Makefile                      |  4 +--
>  arch/arm/boot/Makefile                 | 27 ++++++--------------
>  arch/arm/boot/bootp/Makefile           | 35 ++++++++++++++++++++++++--
>  arch/arm/mach-at91/Makefile.boot       |  4 ---
>  arch/arm/mach-davinci/Makefile.boot    |  8 ------
>  arch/arm/mach-dove/Makefile.boot       |  4 ---
>  arch/arm/mach-ep93xx/Makefile.boot     |  2 --
>  arch/arm/mach-footbridge/Makefile.boot |  5 ----
>  arch/arm/mach-imx/Makefile.boot        |  0
>  arch/arm/mach-iop32x/Makefile.boot     |  4 ---
>  arch/arm/mach-lpc18xx/Makefile.boot    |  4 ---
>  arch/arm/mach-lpc32xx/Makefile.boot    |  4 ---
>  arch/arm/mach-omap1/Makefile.boot      |  4 ---
>  arch/arm/mach-rpc/Makefile.boot        |  5 ----
>  arch/arm/mach-s3c/Makefile.boot        |  9 -------


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> # s3c

Best regards,
Krzysztof
