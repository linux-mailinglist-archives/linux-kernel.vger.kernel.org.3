Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320B54CAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344768AbiFOOBM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Jun 2022 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355739AbiFOOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:00:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83F63B55D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:00:38 -0700 (PDT)
Received: from mail-yb1-f178.google.com ([209.85.219.178]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mgek8-1nVSkC40iK-00h6a3 for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022
 16:00:37 +0200
Received: by mail-yb1-f178.google.com with SMTP id p13so20711423ybm.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:00:36 -0700 (PDT)
X-Gm-Message-State: AJIora/M/QXDx9UTWXjiZt9jzbVKlBoLoqCgUJdUDqfJoMRfCbPGQYS5
        3/3qh/H8ltkQYBXcwZtL+lM11Hk0NzZG7FP84/M=
X-Google-Smtp-Source: AGRyM1sINeeo5NBylnIfasp1Y9wsPFbqUeZD8UXabqa7f4PzXfDr9oZ7lyvv0su285MeiZU99bjHFPOmGTkdMoexbAs=
X-Received: by 2002:a05:6902:1023:b0:665:12c1:b44d with SMTP id
 x3-20020a056902102300b0066512c1b44dmr10832736ybt.472.1655301635807; Wed, 15
 Jun 2022 07:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220609213513.88479-1-j.neuschaefer@gmx.net>
In-Reply-To: <20220609213513.88479-1-j.neuschaefer@gmx.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jun 2022 16:00:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-m1iQ2bP+dsoGTPZGMNBKqB5a6315jdgaT3tuR4WfTw@mail.gmail.com>
Message-ID: <CAK8P3a0-m1iQ2bP+dsoGTPZGMNBKqB5a6315jdgaT3tuR4WfTw@mail.gmail.com>
Subject: Re: [PATCH v4] soc: nuvoton: Add SoC info driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>, Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Hector Martin <marcan@marcan.st>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:eVeUddn3qrj58vVVQpfHBEPB0TkLImubtyQYkOo32Bpa9NStdu0
 JDhP7JQL2sj0/8c5e6ET/IbknOtYBVaTpR9i7sfL2GgMyWpbjmIb7E0FOU6BF9C42NgYEpt
 7KIzLt6fiTUVgheZBXE+V5pjm1P0v4UqWoosMRyQxOs8WuJNMJIq3/CP5B9zrlZDuD/+zTW
 UtVQF/wuhXrqv8yTob4Cg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ICJXeX0NwPE=:yrJHPX4CQgY7N0JJ7paEfi
 BLpKPykzgdz8iR6AXjq+s0b4hzDRLqgFoGI3UYp5qt2ju2pHudXQ6n9eHk3TSGiHybisa4TOi
 PE7jY73nHjVYz3osx1vETNjX1+IvDqqA5TyrnRUt9yfreGelZlvGu1XkLEH8hwMIgc2XAvy4h
 8dfDXGndN3L6pVOGdFfultwg9q6HzNqUaWemiTeqESHeLT9hM2pqUxT62B+8s1zkxxLdKeUkx
 THLxeCKV4lZTmdLSKm9aC7piMh3J1HmXTWXy3LZsKBgpVQd0hB3SaSdRHyJEYaicnAIRixmk0
 3tUzgsSOlNfX2sll+WuQzfNuGrL4x+pxFwRGm7H17pgajneWDBPw36wW9F2af4MDT1GUOQ6eU
 1Uw071tHSS/SyThB1CsqIjQrlP8h2Tfp25HaorV8RScwTp9z6mN1gisfngQIs0ln6dtsNaj83
 o2oV1fCM2GTiV5S7B0P7IOn3tBI6Tx3xGQbekegITvNJi9AG0GlcZQJo8tTMLfJPOcseVwkqp
 vmwQrHZHGh1jGAa1SYyT0cnJ/J1Cg6e655KrZcgqx7hrSR4GoQmTKRGCB1S39/mgGbgfPDULl
 P1DZLCAc0oUHcx/kppRBX52vUk5v9cEQWMcCuQqJOTJOVsB4TCQqeSbVtNhNepxzJ+3AYyiku
 n5WwubPCMOlQLk+4/ZSx6U+ZLSMzpKItesxpguk+3lyB0OQP/bxMGpCZDOkZvvi+ZNilWIEzv
 9Gk7sPTj21js/CnboUJLQ9/oJe4ajEJWsHYb/A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 11:35 PM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
>
> Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> information such as the SoC revision.
>
> Usage example:
>
>   # grep . /sys/devices/soc0/*
>   /sys/devices/soc0/family:Nuvoton NPCM
>   /sys/devices/soc0/revision:A3
>   /sys/devices/soc0/soc_id:WPCM450
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Looks good overall.

> +menuconfig WPCM450_SOC
> +       bool "Nuvoton WPCM450 SoC driver"
> +       default y if ARCH_WPCM450

It would be nice to make this a tristate option, as we generally
like to keep optional drivers out of the allmodconfig vmlinux file,
even if this is a tiny one.

Just add the trivial cleanup function and MODULE_LICENSE() etc tags.

        Arnd
