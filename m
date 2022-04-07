Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE43E4F77DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbiDGHmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241992AbiDGHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:42:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BA93C734;
        Thu,  7 Apr 2022 00:40:20 -0700 (PDT)
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mr8SG-1oMzVE30Jq-00oFUf; Thu, 07 Apr 2022 09:40:18 +0200
Received: by mail-wr1-f45.google.com with SMTP id m30so6563832wrb.1;
        Thu, 07 Apr 2022 00:40:18 -0700 (PDT)
X-Gm-Message-State: AOAM530BES5OuM3KjCLrK3fVK7jiE8C3m5Ieq6mc1S3IKrfevhxuFLDC
        P9RzLTop26a8DxRsmSjqUen0UpxscFaczXcj3N8=
X-Google-Smtp-Source: ABdhPJwQaMXR4hEgDadKcEPnGvv0CtA9y/3CdA6x65M2N0RVjV5eAMECbKu5Ycw7OXAjX0lZWRQeJETM26C6EL4Wlc8=
X-Received: by 2002:adf:cd02:0:b0:206:ff2:236 with SMTP id w2-20020adfcd02000000b002060ff20236mr9785565wrm.192.1649317218318;
 Thu, 07 Apr 2022 00:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407072319.75614-1-krzysztof.kozlowski@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Apr 2022 09:40:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07vWeYcVdzNjv4HgP_qhU9rQBkcKKmxoy8Uc9gg_0VUQ@mail.gmail.com>
Message-ID: <CAK8P3a07vWeYcVdzNjv4HgP_qhU9rQBkcKKmxoy8Uc9gg_0VUQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: s3c: mark as deprecated and schedule removal
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:eRgpEhRrZSfs4zeyJyyPv+2a1fVuIoAw2xn8GeYkzsFjSiZs7+x
 IXxmeLG55NNJR+kEmFJSTmO3MsQt8xRov5DG2QesDgnWXLbGczRER66eLAzySuO1Vlm4GNV
 nwYC7qUtbrdHc6cl7TyIG8Ji9/6Axtwcm1egKPpOWiOqQAlZEDu4TxULSNL/PqEMVi0v8Bx
 ajl7tpUQwa/0RZS0DkkwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bb4tTj7z6XU=:ZNJrEo51Kr4AR2YqxTv+d4
 6wPQ32L+M8GPAPvkgku4zEZofeuGPLro5F2Y0QmAlRm/BNiDj/aalL1gywUVTGYqK6vz+4MoB
 JtMjSv62JiDnFOZWjU+HpJCplAvhwaBTLQw+Cu29LfbWf4tGAFPMxuR9BMUDUNCeJOtJHyop2
 kdGBAa8DTHRxKZb04Q6G9CpdEesHzRbngU/NvDbpZ4UB+m/paD+UwzymdV6woYmkL88R9WlTL
 gWGxlHGuFoTJQNjhCDcM4V3dYu1Tyjrp0Ps4lXVpQ8JrKfNdv61J6Bn1efOGe/OGwOz1HzRhl
 kTJ4mhlzbRFrmwLZvub9g17yh8A6/wrqJJadl2LZjgkv6BaEDUqiyGPOrkI0gOecGh1k/gv90
 iJoR7CPI5TSvqLyzQszHcvmcmOqGiOBwaYbEkSScK9kx3Rm1Zky8WUOKXDPQNzw1waVhuLhwy
 zASmbNyELGNzEP+6JiMz5cl1Qb0cdpKI5Xt4ACXLYPVvbl4taF7L2TynyQmG4GYcksFzyqyKc
 iFYXVeLhF1Chnhij7V9tipCsDb50rVcoepv+oZbKlNyn2reumZztpqHARtTEG+8JKDf+uuDMA
 JgUBBxcTLZA36TSureVIq1HJ3mamyavTWepqlN4w4aC8KRl0dYj+/YIaMM0D6isfYUdTgItpJ
 jejPSyEOWGTUhz82VSl67ImI6s0hgZhKfxpU14Ugfg65c8Cd8eB0xk13cYbEQAEbptRqgjsc6
 Qr5ow4UA0rDRdZw5hSwinv3VcuITkS5JAVwqHszQTmZBiE33qW9yil2FR/I3Ws+0b6zTiUbyM
 pfIIJHPQrP9VSMy2uD1M4l4wAhnZbhYKB72pMElwmKfT4danmQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 9:23 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Samsung S3C24xx and S3C64xx platforms are very old designs. S3C2416
> was introduced in 2008 and S3C6410 in 2009/2010.  They are not widely
> available anymore - out-of-stock on FriendlyArm (one of manufacturers of
> boards) and only few specialist stores still offer them for quite a high
> price.
>
> The community around these platforms was not very active, so I suspect
> no one really uses them anymore. Maintenance takes precious time so
> there is little sense in keeping them alive if there are no real users.
>
> Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
> possible removal in after 2022 for the first and 2024 for the lattere.
> The deprecation message will be as text in Kconfig, build message (not a
> warning though) and runtime print error.
>
> If there are any users, they might respond and postpone the removal.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Should I pick it up through the fixes branch for 5.18 if there are no
immediate objections, or do you prefer to just do it as part of your
normal samsung patches for 5.19?

If you have nothing else planned for mach-s3c, I can also add it
to the multiplatform branch that already touches the platform.

        Arnd
