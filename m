Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525884ED82C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbiCaLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbiCaLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:08:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F71F42DF;
        Thu, 31 Mar 2022 04:06:53 -0700 (PDT)
Received: from mail-lf1-f54.google.com ([209.85.167.54]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M8ysi-1ndkWg0Zle-0065B1; Thu, 31 Mar 2022 13:06:52 +0200
Received: by mail-lf1-f54.google.com with SMTP id 5so40832298lfp.1;
        Thu, 31 Mar 2022 04:06:51 -0700 (PDT)
X-Gm-Message-State: AOAM533bTn7O7a11LnD4LBzLwpr8imLMTdfFqwRtGO9j/dD6jGxgn29N
        Bk7dTw89SdYYprRoFXYSxHk4FidIZHqvl2i5TfY=
X-Google-Smtp-Source: ABdhPJwGAKwpvIMNsQM9nFO11Su4f6CfBdGu0DMcmygJKo9OCuKECCNyCiW9rLz7dH/8XUmg1E8wSHe238gGnDMMuwI=
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id
 x5-20020a5d6505000000b002059a98e184mr3173055wru.317.1648717802947; Thu, 31
 Mar 2022 02:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648714851.git.qinjian@cqplus1.com> <84a0839e7724fa39dd07fef491cf6bb357db2e7d.1648714851.git.qinjian@cqplus1.com>
In-Reply-To: <84a0839e7724fa39dd07fef491cf6bb357db2e7d.1648714851.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 11:09:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2SQCj8pqyJvS+TpgqQu51+YyB4SOi2cd_WU9ObgAjZOw@mail.gmail.com>
Message-ID: <CAK8P3a2SQCj8pqyJvS+TpgqQu51+YyB4SOi2cd_WU9ObgAjZOw@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:z/4tzUqmZYGQZ24spxksEyOysVr2PtahhN9T25NYZZ8BcxpPVMr
 7f0+JFCQTAp6cESgArBXyjsnxp2HR+EBu8UPfgzj4IXgFZlfvqB7RfFHhSU91nDYWmAMn0s
 UgOI3VfA50GGzeQd4uK/Ykpco/lJvUf8beq/MtMtFGXrfaPljzWiiqrOGNQZ8/gMr4pDlw2
 S5kaIkofDm98f5Tq87h4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xVcAQc2Awu4=:hwb6QFIeCg4f7N1+6qDCFw
 II8nUS/pwqqjYfLzOCKul2jVXf2QzxTig08IcFquWGBR5HMPS9SFSEA6AtPMBqTTR/2hLPJrd
 6/FoYlkTXX1+dOkb9KMfMMg/XwSPDU2KJCKKbc2RqYnCDs2JvzyDWcZZYCoD9qn1+EDhmnS4z
 ed5qC2Llc6tJSy6dWc6lEwzTqR2wDsi6dSYmAlR830wmow02+MG8XhHAHY2xUmc79Bf1vqvDX
 O5EWgV3F73maFjP0Yde9mnNn//yZpZCzdXIhW2rtYTys4lTHSwOKJfRuo+bcrMBpKfVd2Ho+H
 d5x5ndkG3kuacL9RcY2BQzq7NK+7lhTMHZ7MUBCYdqKxo6x9QNYUJHq5SlK39uOhzleDT2bRk
 uoSq/Aged+O8whfZaYRC/9LC3lDdbvLDofCf0MpDrGQwTCzL7MZVaA8RtEaF4P1oOIgmtqXNE
 mqqj+G+T65Y4jC/zmtd841dhs6VXofcOdrUhNqvWTAPLn6zna9zljK9pq/b4q2Ht6ka2sr7QI
 qRp6UJKXw/wVsQQidaGMkZQpKgAQc0cYVUgS6o8NpJt1a5fj/Eh15JOkx+dmCwSLOn/iOrSI0
 vG14Me2fh/r5vzAcygtG2/+OhZbM9+Rj4MUFnPw/VGOix4/ciTO21LUQJoKIIsA9rJ5+/PXfG
 qy7onI0hMRPB1Wb6xn6Ldj/zBzRLAAsKLs2d0SVkgIMSZNlE61UXGtfs+W7riRvGrj0gjjHn9
 tMhcU21Scw1rF9VzJpaYlmsIa62QynohvBW70av2ECfozL+0ua5Ck34D/C3zastqXYUp1mWe9
 y15D7q9t6U/Mii0uBCLTq5Dvu+JUspoUuV7VPg7hbu1sMEailI9iVB444iauZ2aMgfccLtL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:29 AM Qin Jian <qinjian@cqplus1.com> wrote:
> Add generic Sunplus SP7021 based board defconfig

Here, you should explain why you need a custom defconfig for this SoC, as
most platforms are fine just using the generic one. Are you too memory
constrained,
or are there other problems?

> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 8863fa969..a3bd9dbd8 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -86,6 +86,7 @@ CONFIG_MACH_SPEAR1310=y
>  CONFIG_MACH_SPEAR1340=y
>  CONFIG_ARCH_STI=y
>  CONFIG_ARCH_STM32=y
> +CONFIG_ARCH_SUNPLUS=y
>  CONFIG_ARCH_SUNXI=y
>  CONFIG_ARCH_TEGRA=y
>  CONFIG_ARCH_UNIPHIER=y

Don't you need any drivers here?

> diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
> new file mode 100644
> index 000000000..cda16d33a
> --- /dev/null
> +++ b/arch/arm/configs/sp7021_defconfig
...
> +CONFIG_HAVE_ARM_ARCH_TIMER=y

I checked this one again, as most others don't enable it in the defconfig.

I don't remember if I recommended removing the 'select' from Kconfig
in a previous round, but as that is where other platforms have it, I'd add
it there as well.

> +CONFIG_STAGING=y

Do you actually enable any staging drivers here? If not, I'd drop that bit.

          Arnd
