Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AC518C23
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiECSYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241275AbiECSXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:23:51 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A66FF0D;
        Tue,  3 May 2022 11:20:17 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2mWA-1ny6Ed2AJw-0138ux; Tue, 03 May 2022 20:20:15 +0200
Received: by mail-wm1-f43.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so1743521wmz.0;
        Tue, 03 May 2022 11:20:15 -0700 (PDT)
X-Gm-Message-State: AOAM530YD1h5v1azA72O6Mqa+tfzNkHhqmZ5OXPlvW5kwsjCWJc0yBTC
        rwwwuLSPN/fFv4Si/tKZG7WMLpn+fYyI3lDgT6w=
X-Google-Smtp-Source: ABdhPJzdLAi6LusGzpUmQqAEN7Ep7tmyrMxpq73q7upJ6tCWBfIvFV42Z7BCJneune7LbBwSqLK48yMk9eyVnxECpN8=
X-Received: by 2002:a05:600c:3798:b0:394:454a:df74 with SMTP id
 o24-20020a05600c379800b00394454adf74mr4515023wmr.174.1651602015176; Tue, 03
 May 2022 11:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220502204050.88316-1-nick.hawkins@hpe.com> <20220502204050.88316-7-nick.hawkins@hpe.com>
 <CAK8P3a2rzmVrpnf2r73iXB=T06OMOsgwyq1i8z7swuOW-q88eQ@mail.gmail.com> <PH0PR84MB17180215774D59A3EC277B1388C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17180215774D59A3EC277B1388C09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 May 2022 20:19:58 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1q6pJ6pdZav0rWJFR2dAWwz8mpiFRO6vc+TA+L-Sk5uQ@mail.gmail.com>
Message-ID: <CAK8P3a1q6pJ6pdZav0rWJFR2dAWwz8mpiFRO6vc+TA+L-Sk5uQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zjREcXZbYFvUQ1Kcbd5k/VaOHL6Q2KrD6PF5KfRSnLW1L2b2Fh5
 yz1+YwcGsnuBr/eXzkR0U6igH5/MgIIIETMATAzWAW3pKErbc1y9GyXMgNYy7qcDD9WaZ0f
 76z2wBb58xn9uq1yIXo0iv5vmNmvb78F7i8bAdbRBwgVp5gw6L4/+K78PxKC2/gMyU3oXAJ
 YnLlzdxjcg7HtkiEzsUig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpOT044kYBY=:EqwI11zsy6OWP5gNaK00fW
 PczSOBKHmK7isX5ou14NFqidxhe4xUIJDVm3GUILOE/zZNyfIES2CPoGTm/G0XKM0RQR8+iza
 9f2IkzA4Tdsh87yars3y1GooHHBrid5AWLXCWdyvYWqnk0XClqmYBfgf1/aYV55vGWYh/fVHS
 lPo1982p+btuo3UF785FUp+Lnh31i9XyoroXgRv2N5pCcTAEqcOXrxL5cElWuloaeg3o7nK3e
 L7rWOCx9pUEQNtC8+/+7PHtZjd5ghd1qWDh0wPwMuzt4IsI07nV0pM4PbG6hyzYSt/D5mNve/
 1/PRXnWLMIIknbJ5e7fBVHZ7fTM5Bsb3xLDF5mAXA8sJdgzNrl1fZqKUCHlBg8+vXI04qi+Gc
 y36k/UmkJSNk3+/J5LCQIn2Odgm/iaqri3CQTbLVeZgV0cZtOau3yGoeoFnLqFLXf1ZiKZET9
 t4ZGb1yqJtyvDT6PvHK7xjaYxkK85uyVJAYDxnmVldqHdhAvrx8P3IUNrkUPw8Cx4Qmj7YZem
 1L039uRgZ+JrMG+vIwIU3/yjm7bQ76Xfz1DQ/lyMIb5DiG2aAGHOXuoeyYUsDcY7E1og23bMp
 d29JAyuLRH6pebs2FbTsGl2UEhr7hJBbwIsb5GmfWnKZAcmTqcLX1zS546yucP41oLCCDGJsq
 EVP1xlUuaheVyQDZm1XIg7xCleGwEJRUdzPC/s93nyYYsaQi958fR+gE540x0LA/Nvc4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 3, 2022 at 5:07 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> On Mon, May 2, 2022 at 10:40 PM <nick.hawkins@hpe.com> wrote:
> > > +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
>
> > In the board specific file, you normally have "aliases", "chosen" and "memory"
> > nodes that define e.g. which uart is used for the console.
>
> This is what I have come up with.
>
> / {
>         #address-cells = <1>;
>         #size-cells = <1>;
>         compatible = "hpe,gxp-dl360gen10", "hpe,gxp";
>         model = "Hewlett Packard Enterprise ProLiant dl360 Gen10";
>
>         aliases {
>                 serial2 = &uartc;
>         };

It's a bit unusual to have a serial2 uart when there is no serial0 or serial1.
Most boards that only have a single uart label it either '0' or '1'.
>
>         chosen {
>                 bootargs = "console=ttyS2,115200";
>         };

Use 'stdout-path' to pick the console device here, not the argument
string.

>
>         memory@40000000 {
>                 device_type = "memory";
>                 reg = <0x40000000 0x20000000>;
>         };
> };


> > > +       memory@40000000 {
> > > +               device_type = "memory";
> > > +               reg = <0x40000000 0x20000000>;
> > > +       };
>
> > If the memory is outside of the SoC, it should not be here.
>
> It is part of the SoC. Should I put it in the axi bus instead? If so would
> I need to create an axi for the .dts as well?

That's fine then. The memory node has to be at the root of the DT, not in a
child node. It's just that most SoCs have the memory in a separate chip
on the board, rather than inside of the SoC itself, so it would be part
of the board file. If the gxp package includes the memory and it's not
an option for the board design, you can leave it in the .dtsi file.

         Arnd
