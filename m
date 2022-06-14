Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C1454AEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355948AbiFNKmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355855AbiFNKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:42:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B861EAE;
        Tue, 14 Jun 2022 03:42:20 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MuDoR-1niiMo0ijt-00uXdY; Tue, 14 Jun 2022 12:42:19 +0200
Received: by mail-yb1-f179.google.com with SMTP id x38so14421240ybd.9;
        Tue, 14 Jun 2022 03:42:18 -0700 (PDT)
X-Gm-Message-State: AJIora8re/FrlikpDt370Goy4QV8Z7b2DkAY74vkH8CxaNMHl7zapDA0
        bd7b+l85xDG8FV7Rje/+vOidX3enChRydW9Im28=
X-Google-Smtp-Source: AGRyM1u6BlNZePQaiEYdbfT4gFiK0Xn992NOenYqFrbDIeUHsQsd0C4/8zDUMmJUO2awoVTP7FmYkvrgx8xfclApE7Q=
X-Received: by 2002:a25:69c4:0:b0:65c:ed2b:9106 with SMTP id
 e187-20020a2569c4000000b0065ced2b9106mr4223896ybc.394.1655203337779; Tue, 14
 Jun 2022 03:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1655194858.git.qinjian@cqplus1.com> <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
In-Reply-To: <0574ed0ad1e9ec4c12645fe2d2dde8f701d285e5.1655194858.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jun 2022 12:42:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0XgDS-iJEfOrTjTRGODosxj0gc748PAH_hc534DkyswQ@mail.gmail.com>
Message-ID: <CAK8P3a0XgDS-iJEfOrTjTRGODosxj0gc748PAH_hc534DkyswQ@mail.gmail.com>
Subject: Re: [PATCH v18 10/10] ARM: dts: Add Sunplus SP7021-Demo-V3 board
 device tree
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xPtpOpauGmwccM9RruS3e6Fd9pdl+xGLPXirghaSnNcDK5RwwvY
 ag8Xry7Id2nfnu8O6+AzsIlXHfWwe38hdO2eq2l7LTJL1RNQhUfBhIdomYdQqmK3Ppm6vAp
 LtYNeVMCjCnZqTbOmRWIb2+8QR5rfTfihjSfU2Gw8kvWmg1ucK6pi3a6pQpRBhROzKD5Pw0
 zbsvhlPQ6CcfYKlrpneYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BVGO3whnGok=:4JXmS7J51MsbvjTA1x/DDX
 wGJ15qMV9EwBZXNsU/ejxe+u27G4x5exYdoSQ/roZ8AiaNXmoy98XNj2TqTEb6+IKN2wLm2ZT
 SsD4eIQUa26cQomzNq5B44IELRsD0fYmWX8/XViqhreE1UIgWkvlxYPa9YcIAwc6ttQMSYgOm
 GzEkiuRsCdca+hfNwhZ4S7tM2a670ZyDseOEoHeWJSqG/9RpHVvqzMx4tYIrgiLrByaUVq+n6
 kGN7DczCLkbDuB/ZbEK2NLFqvITkIg2DcdxDOAhaCYP8PDJa+V145/gDNqnBJ9laOL9/DRXU/
 dl8It1oxxEXAaBxfc71CDlZKdZuTNNmIWR5lKvdZZmeKBHhXPPCoJzIIzGDSmZJZrP2qclOIb
 2cKY2ah9r9yQKK3FO3Yk0kCogMWUqw56JqtaxvErB8YDLsOOOgMc662abg6wVzZutcUA1mGDL
 LwN45qz/O36DVktIEq2ToOYNijED0Rer5P746N9Mna0kJdzQbXMVfydzOxpxNQB23caBCM64N
 eHst7yaMRT7t4/S9kentb5HP7KRHvqfRmjgUbIJBt90jDiZYhCQsQtIUv4k3YuD7xbQCTxhnN
 Wae4RbY1sJB98XhBYoUz1DrdY73eNFdXZvzGWaXMbPLEKm+Km8FrxQsAJ1sBR4jHKfeISDR+5
 a0qWnEUAaadjziCQsdrpdKFV/4cMG+pxxERlA+8+9zSIc6xG3wH21UtER1gWaNpT02QeH0YXy
 h+Lx0ynQ0J3gGG5nGeiqMp0Ye7vsDa+dbU1CQ7Rms8aVseCFtTbaGjB8zW/hqpTRGkU1RLZX9
 toACVMLXst10FTK6uN8H17U2yyo6Gc4UM1YMbyLzWa4HXf04QI++Z/pCt5LT5uxgHvXIr7fRv
 U0jv7+q6CmrPu4ZRD2lQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 beOn Tue, Jun 14, 2022 at 10:31 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> Add the basic support for Sunplus SP7021-Demo-V3 board.
>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Fix the comments from Krzysztof.

I'll wait for a final Ack from Krzysztof before applying this.


A few more details I noticed:


> +/ {
> +       compatible = "sunplus,sp7021";
> +       model = "Sunplus SP7021";
> +
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;
> +       };

Some of these are disabled, presumably because they are not
actually connected on all boards. Better move the aliases to the .dts file
and only list the ports that are in fact used, using the numbering that
matches the labels on the board, not the numbers inside of the SoC

> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               interrupt-parent = <&intc>;
> +
> +               intc: interrupt-controller@9c000780 {
> +                       compatible = "sunplus,sp7021-intc";
> +                       reg = <0x9c000780 0x80>, <0x9c000a80 0x80>;
> +                       interrupt-controller;
> +                       #interrupt-cells = <2>;
> +               };

All child nodes below /soc have registers in the 0x9c000000 range. I would
suggest you use a matching 'ranges' property to translate these into a
zero-based
address like

/soc {
       ranges = <0 0x9c000000 0x10000>;

      interrupt-controller@780 {
             reg = <0x780 0x80>, <0xa80 0x80>;
             ...
      };
};

> +               clkc: clock-controller@9c000004 {
> +                       compatible = "sunplus,sp7021-clkc";
> +                       reg = <0x9c000004 0x28>,
> +                             <0x9c000200 0x44>,
> +                             <0x9c000268 0x04>;
> +                       clocks = <&extclk>;
> +                       #clock-cells = <1>;
> +               };
> +
> +               rstc: reset@9c000054 {
> +                       compatible = "sunplus,sp7021-reset";
> +                       reg = <0x9c000054 0x28>;
> +                       #reset-cells = <1>;
> +               };


Maybe sort the nodes by address, or possibly by name.

       Arnd
