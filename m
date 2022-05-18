Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8678152BDF0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbiEROwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiEROwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:52:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91341A0ADC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:52:45 -0700 (PDT)
Received: from mail-yb1-f175.google.com ([209.85.219.175]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MhUHt-1nMyQp14y3-00ebQO for <linux-kernel@vger.kernel.org>; Wed, 18 May
 2022 16:52:44 +0200
Received: by mail-yb1-f175.google.com with SMTP id j2so4180564ybu.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 07:52:44 -0700 (PDT)
X-Gm-Message-State: AOAM533inz20813j880Djc67thqjrow53+SAa45KblNlUWlePAYzm37q
        HnocaLMlffT9Iqe6Q6mpQPdFr0Wf/lBJbtj669c=
X-Google-Smtp-Source: ABdhPJxP7e/nEbt8Sasz1ATmrn7JsoRoyZGZHFy6NnNuI493m7yBWtmmAYkI1h0VyER/USaUS+yft+DAg0EBkOlvd/U=
X-Received: by 2002:a25:5e09:0:b0:64d:8543:627d with SMTP id
 s9-20020a255e09000000b0064d8543627dmr8502ybb.394.1652885563133; Wed, 18 May
 2022 07:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220518141542.531148-1-michael@walle.cc>
In-Reply-To: <20220518141542.531148-1-michael@walle.cc>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 18 May 2022 15:52:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a01B2uEP7=AkVBG5FYdfMHyReFP=120Ay3+s2EV9kO5Uw@mail.gmail.com>
Message-ID: <CAK8P3a01B2uEP7=AkVBG5FYdfMHyReFP=120Ay3+s2EV9kO5Uw@mail.gmail.com>
Subject: Re: [PATCH] ARM: configs: enable support for Kontron KSwitch D10
To:     Michael Walle <michael@walle.cc>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:dceuxfYyY9PQqDjF9QmMXOADxfpUfVnyFLJfdznjrzCAVwFbYtz
 xLZe0YGkNWIWMuDk1mQ9+utMcJd5HhHUOXpa8qzw90313XynDqCGfMcrWyWqVRus6oIojzH
 R3N9PKpkto7vzDu7mZxKgUCAKnXi2r4GE/P8hsJgjk+uiAvG1Ci0+WQpfFgDVxYbbQ6P1zP
 bbq/tHnMHQwUVgm1VQ70A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xJ1UTy5eGkA=:raNrygb62t0iILrZHp7fS6
 G8ujiYzGB07LCPvfp3mFJ6Q5qpD90TCfnLsNYq7iSEbqa50Ed0phZs2beQ/5iPWl4GFJ5sMnG
 N21DLC41hXTCB7NAljM2xV1hsrqVKjSnUfW0tNSQ6FJxp2HhJkGOp7pxQIsGXaXfBLP3QzlBi
 VlM65fCZyvU21E/fZ5yPJS9Bcv1Xd+87/QE8FVFSx4TEJLX5/XXeYMMqGmvMI9KkpZxRzw38z
 6wMWfVcGHeolu2O35+KlfbIffJKuEzd4NDxEj3kZs00k2oNP/v8vZwk3aUcoIXdIx1wSwzU9h
 J9e5Ov+Lu10E2XfttykCpjYUeI/UiOWXFCvFHgBm0LK8YqDTMRASJ43YPuMOmUoczopQp3aoJ
 HOvZtuNfa+DbibQoGt9DONe65ysefuVAUHnyGr1K1wJMovWd5e0LY5xECZiPCxEx1rFCv2wo+
 aERxWZTRLBMsPgbCVOk5F2WenDmnWZY1yET83uPJhXewIHvoPXJltUsse/cjLPea/1uKUe/wx
 cTSoTDGA1ybQI4TEllwxUDfV//PS98ya74/S14BN4taEBtt0MRFGZ4ncZno7/3yOtIBwO31BP
 0yfgY4ZsmoJ4qJA8WzHnqtOo7+jN2BY57Uas/7FhgUAaKLanYDsSTpH4rKottHFjhxil94tjJ
 hfxEGQZ19phl7am07c/ShTckVKrwc6N7fcdnbwDbvEI6B/Lu8F/L+ZHLR9wlPdDzztkvfSLYk
 IlKgGfOMgHskyL29aBvSpQMTH7bWo43+OXTn0DSdIb8H4QUAUcfMgY/wRVYLkgFwSUGcRwfXK
 YY1jq4pDHa7d9cM/QQf7LPsjZSlTshzfDPohKy7EmM5l/goaej5zldKJqfG9pmc7UDA4SsSa6
 EdRSYFQe3zy1THuV6Jhr0/W3O6AVp9c1Nk2F+pp8Y=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 3:15 PM Michael Walle <michael@walle.cc> wrote:
>
> The Kontron KSwitch D10 is based on a Microchip LAN9668 SoC. It is a
> managed ethernet network switch with either 8 copper ports or 6 copper
> ports and 2 SFP cages.
>
> Enable all required kconfig symbols, either as module where possible or
> compiled-in where it is not possible.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> FWIW, there will be a board in our lab in KernelCI using this config.

The patch looks ok to me, but normally I'd expect it to go through the
platform maintainer tree unless there is a reason not to. Adding the at91
maintainers to Cc here.

It's also a bit late for 5.19, but if everyone agrees, I can add the patch
to the arm/late branch.

       Arnd
