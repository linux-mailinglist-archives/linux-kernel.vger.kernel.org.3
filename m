Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37895943D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351810AbiHOWtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351953AbiHOWr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:47:26 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DCB7CA80;
        Mon, 15 Aug 2022 12:53:07 -0700 (PDT)
Received: from mail-ej1-f49.google.com ([209.85.218.49]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHX3R-1oAjqK2fAn-00DUqU; Mon, 15 Aug 2022 21:53:05 +0200
Received: by mail-ej1-f49.google.com with SMTP id fy5so15281306ejc.3;
        Mon, 15 Aug 2022 12:53:05 -0700 (PDT)
X-Gm-Message-State: ACgBeo3FDZbrwxr+P6RTQR7oI6Eu8fyBLfefJFRHtGsq02+vND0bY1z1
        MXl7QtLKOjLFU8VHqwImuUN9gp/eO0NXuU2XXy8=
X-Google-Smtp-Source: AA6agR6WukBGcfTJVUl5CIbKuxExURcZy41XrLH6cR4WZu9dKLWxqz0LIbjhFDRnvnzwIquLGWfm92gIJBXogAGXdQo=
X-Received: by 2002:a17:907:7609:b0:730:d70a:1efc with SMTP id
 jx9-20020a170907760900b00730d70a1efcmr11372637ejc.766.1660593185195; Mon, 15
 Aug 2022 12:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220712164235.40293-1-f.fainelli@gmail.com> <CAK8P3a2QrYbWOqV+CG-W0ZkzW6ORgw8R6Dv-L3o2ZAtJs-B3Kw@mail.gmail.com>
 <0131e1d6-09c0-31a4-5b9d-0e2fc49d61ac@linaro.org> <CAMuHMdWDDY_72y3WYt401hG122xg1s7_VRCG9Vyhhkzco-nBYw@mail.gmail.com>
 <fb4f4444-20c2-0e35-bb83-79a419ec87a7@gmail.com> <f4adf05b-d3da-a692-3bd8-0b4d705e0dc2@gmail.com>
In-Reply-To: <f4adf05b-d3da-a692-3bd8-0b4d705e0dc2@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 15 Aug 2022 21:52:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0R7tL0+saXK-+pHUfT=ZsmOVr6LEecn40e+OSUtZAWLw@mail.gmail.com>
Message-ID: <CAK8P3a0R7tL0+saXK-+pHUfT=ZsmOVr6LEecn40e+OSUtZAWLw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Kconfig.platforms: Re-organized Broadcom menu
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        william.zhang@broadcom.com, anand.gore@broadcom.com,
        Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ugSImgNDs+bBr8tqtz1zw5ugu6oS3SbtUVHJtkpFXarEZWB2esW
 MLW3S/IX0RMFzdnEzo5IFGD2uAp20mssNXfWrjAgrGWeZNyG0Hvkhe0g4Tm6GNe6waNf25b
 wD4eMsoGrun+Ljtt2TKmVKCe640FIHLHD6uOjVgdpP5SG7pXHoJfefygORUGIHS29PYWFri
 cuOrlR4aeHlDmJfyq5L5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KNUfWNSn3cs=:Rj6+A1Mw0k58kVlqW1V8YX
 Efvk/6+MkQk3dD45yZ+X0SvFYjJqrd4tqTVDje0vLj2CjdYzAPFjEUoU2CE9D635uHgaBjpyx
 dYwHJjE9s+nb/aHovb7vUNXeHHDgizeTvlqFFjRW9oRmPskOXUjMwHc5c+bU1dncXL0hg+ozz
 unHTwt+PazFk907xeWZ6/LvpOWE08xBSaPLpLqVLZYzvBvF67pAFhYAM5MMtRGvnwR/yUSDfB
 c9fnSQ7oMj+tfe4p5wrsvqRCYlhMhbpC7ADX21/CZXdONfgCyb7TpzR7+GUGsaLTSv5H/iq7S
 zau7ljmb3itZN5M/Qj8xfQ27QQNefGOBEME6L7BL4rnH8dtdRa37OgPj4fGzyIkyio1s/z3gB
 Siv7Bbwbwen9SPexFKcjY4E3soGq4nnthM0YpZrlx7hyG9gz8kBKtgXvPKk6t/a4+fJsIF6hv
 dEXFdq1NdGSbXjiDIZgLRaEEt/sO3KCJ8mW5ODdyDjyUFkqArBjmFNJ4A+U8HJdFJmaXMgIp2
 4IaP3eO+ed6w7mwvWZWoi7y/oz1Oxq5yAquTKpDmH6qVcI6J8Yg8H2La11BTiyVXrFu86CVtx
 LyGCUHEFtfcLsJIaUgeJ9Q3aiZkJdviA2Bj73BurlQ3w5MOiXEItoYUMY/NkG+VifrM3OyX2X
 cmh1FGUtMJSDnoaoU7QjRwRd5+9zWBF5xSVl4xb2R28O5ikCXjTqovsy5Ood63UpxH/DqZtFu
 Um6QisCdpyYLVjJe/mmUU0w7wNwiSRFAYqOctwref8srZAAvHs6M51kenxruLhLxkYAM/6ywb
 oaWh3vQMiNxvCTsNIHNZOHViaIxdlxKO8n6KquRFmHXc2/Pk/933pSrOoR/ppIiWp5HuSWyBv
 tdI+Uw0ZI2uhYCIyVoeA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 7:15 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 7/13/22 15:05, Florian Fainelli wrote:
> > On 7/13/22 02:17, Geert Uytterhoeven wrote:
> >
> > The itch that I wanted to calm was that ARCH_BRCMSTB was after the other
> > Broadcom platforms separated by ARCH_BERLIN. if you prefer a pair of
> > KConfig comments to delineate them and flatten the platform selection,
> > that works for me, too.
>
> There are 2 Marvell-based platforms (Berlin and mvebu) as well as two
> NXP-based platforms (MXC and S32), would it be better to also group them
> under an ARCH_MARVELL and ARCH_NXP menuconfig symbol the same way this
> patch does it for Broadcom-based SoCs?

Berlin is now Synaptics after Marvell sold them the business unit, so that one
should probably stay separate. For NXP, there is also Layerscape. I
agree it would
be nice to group the three NXP together.

        Arnd
