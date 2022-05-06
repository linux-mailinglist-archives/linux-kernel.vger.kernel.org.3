Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A512951D3BC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 10:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390342AbiEFIyd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 04:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390277AbiEFIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 04:53:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5F5AA50;
        Fri,  6 May 2022 01:49:59 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N1x2P-1nxwFw25zV-012FBZ; Fri, 06 May 2022 10:49:57 +0200
Received: by mail-wr1-f49.google.com with SMTP id i5so9082442wrc.13;
        Fri, 06 May 2022 01:49:57 -0700 (PDT)
X-Gm-Message-State: AOAM532ENFL60AnGg6ALGvJQxD72rHDz4RrVSaZfcsnn2yyzJt9EYWKf
        OPsAv+NXmsRC4o9VGx52UelcAOyQV25+pSK3XFE=
X-Google-Smtp-Source: ABdhPJzpDzWUR0ajOoJu/waDnEPgpgtwfKqxU+fZU0c2d1qiVZ6MUUFlP18HOFAXL2PSxQdq5IIn6MuGWVWpQTx6a4c=
X-Received: by 2002:a05:6000:707:b0:20c:4fd8:1d61 with SMTP id
 bs7-20020a056000070700b0020c4fd81d61mr1821972wrb.407.1651826997102; Fri, 06
 May 2022 01:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651805790.git.qinjian@cqplus1.com> <CAK8P3a0W4wpVwDmCXDkm_u9W=JozrnCnxW7zK3h2XD8f_ODy6w@mail.gmail.com>
 <23e22e4e8b9e4d7ab02caaa1c3f7b599@cqplus1.com>
In-Reply-To: <23e22e4e8b9e4d7ab02caaa1c3f7b599@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 May 2022 10:49:41 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2C1Vbccs6uWGdmWdwNqZomz6L_gA3Wiymn_AR3gsr3gw@mail.gmail.com>
Message-ID: <CAK8P3a2C1Vbccs6uWGdmWdwNqZomz6L_gA3Wiymn_AR3gsr3gw@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] Add Sunplus SP7021 SoC Support
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:RWCVYHsawE9YsuOlW9itUpthwfK1vZe6EQwDQy7Hnn1IwGEQHHb
 1H78mVLck4X+5GnMbjMW+uaCXZOpQaWps/plV4nqqizmbGYZ9zQBs/HiN6Gw3QyPpAhqR6d
 7oVcxzhjyRPmkGVmBnqFAeyAFk87WFF6BHH0kYmAtX9Ad/wvnMnODrd/MddNAXo/ps6atnQ
 4iGDRP9vRBiVI/VTiU3vQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9Cw64gLQqV8=:ExDjxqW51xrMTmbo/XpbZk
 sKZmpqSh+utWVMZ973Jjp7hjvE+wXaQIXn0cIaQHGwvf9P9QTExbMfpihxsNPcxUEBOSzV1tk
 McDgPPdpAr5phwCFn8eHzEtQqrpO7t9J0vs6QC7bbef7f/rs+aQq5PPCCjS3o89fMdyoWnKTE
 nA3xUmYp9xwia0MKyaEZPO+pa4ny8TEa5fVCTk2bPhXRBAe5G7Hatc0RA43kiEmur71rP/QhL
 NAWk62wBvJrUYHRCrmvzUU6llJ/HGQsNiY7i4CpFNcZifQ3+AJfkYSJfj9vOpsi4P0h52+0Sz
 Dogj1FtZ0ayfOQISDueifSQefJJHr5tCNSgVFUij54vDfeLUMqqU4klq4ls0MqhoPPVDCZ238
 GP8+yCIwe+vr6j9jR7jy5gv6YdcjO5gdHPl/aasg7un6HCy31ooxA/l7O98P/zINCmu3l/GCl
 VM8TV+0Q96RVK38LeyECy5Pg8xq1nqAMGRuIf+GeVcRQ/ck1uYZqvXBEvWNd4KZEk1Mjgy3Wa
 iUfRE2xKUwQxcmV5ldBq9rBP5VuRjWe7RkxHSFDogFFcaJ3Iz2cIyIc/nCK/wsZ9OH5S2zHM2
 ZtuN2BpIDIB16Ir5kIWFJUBa5naFN1kMf4LXr3miamTqO5yEToXa83pzEyuWUCJZ7ZJpteB+J
 1VW4pN0NWyJEylNXy6UmaE/Vq52ORvcLFzXNxh7lL4odFUArMec836tlrktQfs9WwlndMt0Js
 S70qWdDGqFQp0NDE/vNzAtB8MbXJs/Nw9gvYUZ3WDwj1NVB0OIsb9mnGhkULA3XfgioSflGJF
 JbOrT+eooourTm1JZTnL6CxlSA2fPX/EqaIHbw+8N/IwNc9Exc=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 6, 2022 at 10:34 AM qinjian[覃健] <qinjian@cqplus1.com> wrote:
> > On Fri, May 6, 2022 at 5:23 AM Qin Jian <qinjian@cqplus1.com> wrote:
> > >
> > > This patch series add Sunplus SP7021 SoC support.
> > >
> > > Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> > > peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> > > single chip. It is designed for industrial control.
> > >
> > > SP7021 consists of two chips (dies) in a package. One is called C-chip
> > > (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> > > process (22 nm) for high performance computing. The other is called P-
> > > chip (peripheral chip). It has many peripherals and an ARM A926 added
> > > especially for real-time control. P-chip is made for customers. It adopts
> > > low-level process (ex: 0.11 um) to reduce cost.
> >
> > Just an update from my side about merging the platform code: the
> > submission looks mostly sensible to me, but as long as the clk and irqchip
> > drivers have not finished the review, I cannot take this through the soc
> > tree. We could consider merging the platform code without those two
> > drivers, but that seems pointless because it will not boot.
> >
>
> The reviewers no reply, I don’t know why.

They may have missed the emails because they were part of a separate
patch series. It may help to post them separately just to the respective
subsystem list and maintainers, with me on Cc.

        Arnd
