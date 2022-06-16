Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352E754DE34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiFPJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFPJcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:32:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A842EC4;
        Thu, 16 Jun 2022 02:32:23 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYeV1-1oEZuf1cSR-00VfYY; Thu, 16 Jun 2022 11:32:22 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-317710edb9dso8697797b3.0;
        Thu, 16 Jun 2022 02:32:22 -0700 (PDT)
X-Gm-Message-State: AJIora9fqVp6myYkknHgftjL964lrmkv/lKiXLoAjp3evAoYyLHU9hq0
        eTTPWSC98AydyDEFFAiXZALuJInud+XElSQ8NCg=
X-Google-Smtp-Source: AGRyM1t+rYnU932lj7/HU4JR5qprU0KY/GlreHVE4NEXsPnhXVcmmLzoRwx6r2PEJHNrBFACi7+BZtuG+yVk/Tf6waU=
X-Received: by 2002:a81:b03:0:b0:310:1375:fca9 with SMTP id
 3-20020a810b03000000b003101375fca9mr4498663ywl.135.1655371940823; Thu, 16 Jun
 2022 02:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220616085254.2275372-1-arnd@kernel.org>
In-Reply-To: <20220616085254.2275372-1-arnd@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jun 2022 11:32:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3O1CEuahB+VeKfFe3iycTwG=1RH2hq2eMn6rGwGA0p=g@mail.gmail.com>
Message-ID: <CAK8P3a3O1CEuahB+VeKfFe3iycTwG=1RH2hq2eMn6rGwGA0p=g@mail.gmail.com>
Subject: Re: [PATCH] media: sta2x11: remove VIRT_TO_BUS dependency
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Federico Vaga <federico.vaga@gmail.com>,
        Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:CxMGqzE8sYNlG8QV17Ax+1sud7lh5ZtVu0WiatXtMIRRbPipUX+
 yxBURv+LAJI3HtE278zy+FY3XRRcWf+m6H8XmI45IbOYZqyhtgbnC7Wz3WEdusHhlaDjr1R
 NoSL2K4yuUX+lGJ+9Pz4q9aY4fpN/dc//coqbiMJcpuKTiJh5eDl+rtcFRk5luxPed++2lM
 2Nd/QrgleizmaBojtjCgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WFbAiaI9JLc=:ozkD7jpCS7i54g1bBChE4n
 9rRXSjFAG2oXV87BCd5KSD4ahij2HChGDvPdeWqOuwpSpS/eRBD3rqd51DBsTad6iu7zuCTYZ
 3hrHfE/mlQero1o8Ij+1Kf80PDRmkfICauP301iN4YF5PJUnE5St/XagUIBe28UfPP75S5XNO
 V5cURvMjjodHqnGtnD/TZ/8Sec2JXpoXmG+wZTA2rPZo2lwYoC3ziU3NcEk/MlnJZ8xDE+3mR
 +D43GU4GNuiIDwu66kL7ZEuO6Fzq6kpv2Cdz+NpvasRYDZy8lMiw8Rk4y87vkNjpfMicWpmAc
 htGczDsJbv11EtY65IM3SKmelL6VMfM2H/MWEq5rn04CWQDE3LfPvplIQslo2yMsbWW8wIGfy
 VOquQzKbyG1TE11qgFN9DoGPv3ZEvtd4Fh/HvKot6LTG9sbKEImW4okUDOl6WSqOh/9uZZdjc
 L2u9FfVeDTTB51l/e6iFjD/VvgABmkuXrb7LV9FOuy+lGrK00+E6auHLF57w+KWTC+0r4hb/Y
 kVkPFGwpunth9e7b+bJm97NAPMMx1Up545jlRqGVcPzGM/RtcF5alQHXXXx6pRles424275dQ
 hggIn9+dccpKHXe7/9ye6julSye2X4t8I0p9Gta35ufPGkw1xlUj26M62Ja1EdG83gA84hpXH
 TT2JVAVTXoa1fxAUChIT1/+MMspWo5imIGHRRXg5RtHayDUkE6UH0ljVKqOSisBQOMSiqmSE+
 xnESNtoOS9C1fiI0iKDFQCXKQK49NBpB71KBauIQluV7jRmXS4fg02BMDtyufpTVdubKbdBnR
 q3ghD56rJlGdcRrcZzV7wy0Uuc/lHtkhNTAkUa4n882HE+zgA+wxjsmUUoxCSuCYJQ4I3OArZ
 TX8iardBExSiLdKKuZpA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 10:52 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
> index a96e170ab04e..118b922c08c3 100644
> --- a/drivers/media/pci/sta2x11/Kconfig
> +++ b/drivers/media/pci/sta2x11/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config STA2X11_VIP
>         tristate "STA2X11 VIP Video For Linux"
> -       depends on PCI && VIDEO_DEV && VIRT_TO_BUS && I2C
> +       depends on PCI && VIDEO_DEV && I2C
>         depends on STA2X11 || COMPILE_TEST

As I resent this one out of series, I guess I should clarify: I would
like to merge the patch to remove VIRT_TO_BUS through the
asm-generic tree for 5.20, which would make STA2X11_VIP
impossible to select, unless this patch gets applied as well.

I can take the patch through the asm-generic tree as well if anyone
cares about bisectibility here.

         Arnd
