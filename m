Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29B94F89C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiDGU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiDGUzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:55:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F9F6E786;
        Thu,  7 Apr 2022 13:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8457AB82995;
        Thu,  7 Apr 2022 20:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CB0C385A9;
        Thu,  7 Apr 2022 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649364795;
        bh=hH0meYZ7KFxv8pBbd7Ld0RQ57xC725s9BToCO/hz7FY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ceU1Tao/URFDuuOZJunGv8ZJW10hHL4SFtQqZpM8Kfd3z7jx1i48ARHfVCZy1jE3F
         WLOYcQzK63738uhkbVLqfOY/UY4JOb1bv3qnys8pXWNomkfFpaqBINjHljdZ2o6kIN
         1zn2KOwRe/IgGBQX3+NYlGLL1BJZ/duHUUi1OQzSho+OSfBXBiQqgSkW8QXH8run14
         elhpLoCVCnwYwP4JnVTcmgRWwLBylflW1iPnPXyVXGf/96m7WYKGKUgxCk9t7bOS6y
         5ZRETNFtF7wok/zfav5nfofKG7ia6MpwKPYTHmr0tvGjBHY1aE5fKlL/Vy2BBO/YWE
         R9903jrFqq5aQ==
Received: by mail-io1-f46.google.com with SMTP id p135so2437484iod.2;
        Thu, 07 Apr 2022 13:53:15 -0700 (PDT)
X-Gm-Message-State: AOAM532jCau7dbc1dro1Dt10/79nSQjytJJe8DJ85/KO704cO7bQp41C
        sfHu9UUFiydVj4QaL2cks1nWFD2bBRgYdLp1vQ==
X-Google-Smtp-Source: ABdhPJwX9EOC7s4lernQaEBJdy8BtvchpcglTWArVdpbaOe2SaItODmejqV/qePgLb8HxSMQeV0F6nHDwxLGyrA/EGA=
X-Received: by 2002:a05:6638:1301:b0:323:3b47:8b3f with SMTP id
 r1-20020a056638130100b003233b478b3fmr7914802jad.291.1649364794440; Thu, 07
 Apr 2022 13:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220106112214.6987-1-xianwei.zhao@amlogic.com>
In-Reply-To: <20220106112214.6987-1-xianwei.zhao@amlogic.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Apr 2022 15:53:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJs=zLegXz_oDqYFebJReCSnbHPWcPDD6rFv9SpSMmjAQ@mail.gmail.com>
Message-ID: <CAL_JsqJs=zLegXz_oDqYFebJReCSnbHPWcPDD6rFv9SpSMmjAQ@mail.gmail.com>
Subject: Re: [PATCH V4] arm64: dts: add support for S4 based Amlogic AQ222
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 5:22 AM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>
> Add basic support for the Amlogic S4 based Amlogic AQ222 board:
> which describe components as follows: CPU, GIC, IRQ, Timer, UART.
> It's capable of booting up into the serial console.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V3 -> V4: cleaned up coding style.
> V2 -> V3: add of dts board  compatible family.
> V1 -> V2: cleaned up coding style, modify CPU affinity of timer interrups,
>           and modify GIC reg defintions.
> ---
>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>  .../dts/amlogic/meson-s4-s805x2-aq222.dts     | 30 ++++++
>  arch/arm64/boot/dts/amlogic/meson-s4.dtsi     | 99 +++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-s4.dtsi
>
> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
> index 5148cd9e5146..faea74a45994 100644
> --- a/arch/arm64/boot/dts/amlogic/Makefile
> +++ b/arch/arm64/boot/dts/amlogic/Makefile
> @@ -57,3 +57,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>  dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
> +dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> new file mode 100644
> index 000000000000..a942d7e06d6e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4-s805x2-aq222.dts
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "meson-s4.dtsi"
> +
> +/ {
> +       model = "Amlogic Meson S4 AQ222 Development Board";
> +       compatible = "amlogic,aq222", "amlogic,s4";
> +       interrupt-parent = <&gic>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +       aliases {
> +               serial0 = &uart_B;
> +       };
> +
> +       memory@00000000 {
> +               device_type = "memory";
> +               reg = <0x0 0x0 0x0 0x40000000>;
> +       };
> +
> +};
> +
> +&uart_B {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> new file mode 100644
> index 000000000000..bf9ae1e1016b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       cpus {
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               cpu0: cpu@0 {
> +                       device_type = "cpu";
> +                       compatible = "arm,cortex-a35","arm,armv8";

I see this is already applied, but 'arm,armv8' is only valid for s/w
models. Please send a fix.

Rob
