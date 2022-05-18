Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5500052B9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbiERMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbiERMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:13:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F7C16647C;
        Wed, 18 May 2022 05:13:06 -0700 (PDT)
Received: from mail-yw1-f171.google.com ([209.85.128.171]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3K9E-1ninzO3Mm2-010NS2; Wed, 18 May 2022 14:13:05 +0200
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-2ef5380669cso21757527b3.9;
        Wed, 18 May 2022 05:13:04 -0700 (PDT)
X-Gm-Message-State: AOAM533WFZbmctZ48/8LoVTYNDrYAjdAD6HJ5kGa+eFx3AMaBuc1umGx
        7jIb8a6u6GRTGg8EF51d7NA9eD5doXqswrJsI2k=
X-Google-Smtp-Source: ABdhPJww4o6KC19Bdx3y+Y9+BEECGSt26A7Urzyyba0OuquV/hIeym4xoshJpgwWoBBDawOH5VaMVVqfZTQGwVugx8c=
X-Received: by 2002:a81:456:0:b0:2fe:dee5:fbbc with SMTP id
 83-20020a810456000000b002fedee5fbbcmr20604776ywe.249.1652875983425; Wed, 18
 May 2022 05:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220516163310.44842-1-nick.hawkins@hpe.com>
In-Reply-To: <20220516163310.44842-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 13:13:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0914=TM9f1CNcg_PXfHvt6nHDPyrvLp=0KO4hZM2GT5w@mail.gmail.com>
Message-ID: <CAK8P3a0914=TM9f1CNcg_PXfHvt6nHDPyrvLp=0KO4hZM2GT5w@mail.gmail.com>
Subject: Re: [PATCH v8 0/8] Introduce HPE GXP Architecture
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:bydMuVtSfsxmxw1dETS7deuD573u5VRVlreV62FDWZCuxVkVs5m
 m/BlQ3z2fTcGSokvu/fL0b1hNvD/SKEjP5bVC2+KL5NTMFY4074kJfHxr0cazzqfKlzLlnX
 7deLur69HKUxusSC/uH3fjS1aWnTy9r87dAWEM1GJfDJvz9ZiaCnAAvnrMvZFAQUApy+b5G
 I8DdgtpQv3ZEinOXv/qNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bUur6YHxCdI=:t+hhY/5KzTjCZpCa+RWXg1
 A1+xKDu9yxP7y185JnFxMHYj9CUQHAbxi51w60/V2b3I47x12bIIPxeRFGet7qCN3QXVzfZhb
 zim6r8NSFZ4ol7kIR+kd172yZiUFcXkrJVnZ7sAFegmiXDTXNPX09dyD9HJllOvN2N7eQuLa1
 PbF7SQ7jlfkvHseJLc3YtKZHN6/WpyvCf/a1uwRgR0I1TQYtraIg+1l+ZTkVsslxMmNecQKqe
 nu1wFsGrUACHZjBC1eIXAY1PNaf2B7lHz1003x9qxnLi43W5TmJLfwQofYceXv8Rn7eL2aMAm
 PWJbvrQX3LPue04TZKETnSoXR5D4ET4ptuRwWPAtjWYZEYTONa+aeFKcPKkQi11luGfXEUsQ9
 /N6KAdL2XZo7R+BC4RkUmEm7M0T14wZyqv/6gMKcEwLsZUXwFqpxz4G91CvKpz3GVLJMW1ftZ
 WflWCX9/faS5Jwxfe+FPQc58Fb8xYIv0a3WyiXI0n+Ltw18ifk1xTX4e0e8cyOJyQ1YvVvlPU
 1rATssIj1Qb/Kfnt1pvmOQ9VyT/Ts7AQHHDxCqpfvAwZVpTBNVdc+Bo7UDYOKP0IeJag4BfEV
 Sae8fnGIWpCkZkbnaPKx/hr5CMfmRpECLXqG0ZVwJOcJPJTPnORAxxpLgaEiWKG2y40HDHTWt
 KpzOTG2/EVJj+c5nniiAlQ+QFWvZ8wD87+KjQCf+JLYXIYBDptl1ILZ8rzjkxBi0jBMY9xScl
 UclB3I4NSBH61t3wL8FXJ+hiSPB8KmPASnUSxnLCcWaPBGUyA6gC9hDMGqOKa+f1Yw1J8XGNV
 1F8WeBawLkS9o2dVpRII7H/FKZMJYeQP2vkYhq21cyTV0cUKZLAZeVlPI3mgNfpshkCk9l4x6
 GKz2dvsxt8saw2CmZGB14mm/+FtvSX4L1+h0BmrM8=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 5:33 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Changes since v7:
>  *Fixed comment format in watchdog driver
>  *Added the Acked-by tag to the device tree patch.
>  *Resubmitted the dt-bindings patches hpe,gxp and hpe,gxp-timer with
>   Reviewed-by tags from previous patch in descriptions to keep patchset
>   continuity for v8.

Hi Nick,

I have preliminarily applied this version into a the arm/late branch,
but since I'm
travelling at the moment, I cannot actually push that branch out for linux-next
before the coming merge window.

My feeling is that this should just wait until 5.20 now, but if you
and others others
feel strongly about it, I could send it during the second half of the
merge window.

It still needs to pass all the CI build tests, but at least it's
unlikely that there
are any runtime regressions for other platforms.

         Arnd
