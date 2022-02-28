Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C644C6238
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 05:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232716AbiB1Emj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 23:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiB1Emd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 23:42:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7692C58801;
        Sun, 27 Feb 2022 20:41:54 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id f18so7981308qtb.3;
        Sun, 27 Feb 2022 20:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P3YQddDa/LvQxVyrELwfNNEASM6E4Y8TZv1yTZElHfI=;
        b=e1cM93JQAGQu841Hbs10AZNWTT43C4eR0zGOLFim6TatSoJP9NJbfyuJYCHcZ2ALJ/
         Q/tOcLg5AdIPeA880Qj2EfNraRATLv/wuaAEaQM6+Q5G+LxRhl/avq5WT27Fv1dV1L7z
         rvxX/ZsnIqQaUwL9BOCwGF8Me23BrpMKYg9bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P3YQddDa/LvQxVyrELwfNNEASM6E4Y8TZv1yTZElHfI=;
        b=PlRjgOX4raHg+aYX9TP68R+ONG6I3JA98OVjlAdq+wEO8QijsOuDd3+asoRER0Dl6W
         baKhWT3e9/Gpp+Wi15oyYbbsYeVR/LSnBahawIwemprC6W/t/bvnUqNq67+LvL8Bwe8w
         UQPiSexI6gjfT5i4SbmRqLkb0860ffbSON1sYApPB2NtKOHoG2bu5ZYfmwyDvNB/zaad
         8YWwOIGOCI0TQK7YEcGjnxJSCr04uLt7VnCUtbrk4TsMrewcpXdDc9R+yylmeUUEFMbV
         kky4aeII9ElbNgK1AgMymyUaoaLjY1qEo2FAFebqXnqoyQfrmg7W9RbDyxo9axETKgQE
         OPxg==
X-Gm-Message-State: AOAM530FFQej/apuP6D+xf0ZK1V5EEe6+fVreSOSpDCqMw0TzBrySb8F
        GC8vtXiGpgRMfF5PIiD7gRvd6A0ZLwn7GKxJ7MM=
X-Google-Smtp-Source: ABdhPJw9W62PBVxiF7YQmP0ugKlSmw5PTfK/yC0NE4ior6kafg6RyFO7xyOEQDs5yVz9yewdZMufvHUbbpTB2/FoHiQ=
X-Received: by 2002:ac8:5d89:0:b0:2df:f357:c681 with SMTP id
 d9-20020ac85d89000000b002dff357c681mr8514608qtx.475.1646023313326; Sun, 27
 Feb 2022 20:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20220124080711.22797-1-Bob_King@wistron.com>
In-Reply-To: <20220124080711.22797-1-Bob_King@wistron.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 28 Feb 2022 04:41:40 +0000
Message-ID: <CACPK8XcuFFKpmPNVc-kLiOhWv9eHBhvkn=oLLWGQoHvW0pt6CA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Adding Wistron Lannister BMC
To:     Bob King <Bob_King@wistron.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bob,

On Mon, 24 Jan 2022 at 08:07, Bob King <Bob_King@wistron.com> wrote:
>
> Initial introduction of Wistron Lannister equipped with
> Aspeed 2600 BMC SoC.

I missed this one.

Can you get a colleague to review it also?

>
> Signed-off-by: Bob King <Bob_King@wistron.com>
> ---
>  arch/arm/boot/dts/Makefile                         |    3 +-
>  arch/arm/boot/dts/aspeed-bmc-wistron-lannister.dts | 1007 ++++++++++++++++++++
>  2 files changed, 1009 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-wistron-lannister.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 235ad55..7d37aab 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1548,4 +1548,5 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
>         aspeed-bmc-tyan-s8036.dtb \
>         aspeed-bmc-vegman-n110.dtb \
>         aspeed-bmc-vegman-rx20.dtb \
> -       aspeed-bmc-vegman-sx20.dtb
> +       aspeed-bmc-vegman-sx20.dtb \
> +       aspeed-bmc-wistron-lannister.dtb
> diff --git a/arch/arm/boot/dts/aspeed-bmc-wistron-lannister.dts b/arch/arm/boot/dts/aspeed-bmc-wistron-lannister.dts
> new file mode 100644
> index 0000000..e8e4f9d
> --- /dev/null
> +++ b/arch/arm/boot/dts/aspeed-bmc-wistron-lannister.dts
> @@ -0,0 +1,1007 @@
> +// SPDX-License-Identifier: GPL-2.0+

Should have a copyright line.

> +/dts-v1/;
> +
> +#include "aspeed-g6.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>
> +#include <dt-bindings/i2c/i2c.h>
> +
> +/ {
> +       model = "Lannister BMC";
> +       compatible = "aspeed,ast2600";
> +
> +       chosen {
> +               stdout-path = &uart5;
> +               bootargs = "console=ttyS4,115200n8 root=/dev/ram rw init=/linuxrc";

This looks like it's taken from the ASPEED SDK. Do you really use this
command line?

> +       };
> +
> +       memory@80000000 {
> +               device_type = "memory";
> +               reg = <0x80000000 0x40000000>;
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               gfx_memory: framebuffer {
> +                       size = <0x01000000>;
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +
> +               video_engine_memory: jpegbuffer {
> +                       size = <0x02000000>;    /* 32M */
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       reusable;
> +               };
> +       };
> +
> +       reserved-memory {
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +               video_memory: video {
> +                       size = <0x04000000>;
> +                       alignment = <0x01000000>;
> +                       compatible = "shared-dma-pool";
> +                       no-map;
> +               };
> +       };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               identify {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               status_amber {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(G, 3) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               status_green {
> +                       default-state = "keep";
> +                       gpios = <&gpio0 ASPEED_GPIO(G, 2) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               bmc-heart-beat {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               power-ok {
> +                       default-state = "keep";
> +                       gpios = <&gpio0 ASPEED_GPIO(R, 6) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               global-error {
> +                       default-state = "off";
> +                       gpios = <&gpio0 ASPEED_GPIO(R, 7) GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err1 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err2 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err3 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err4 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err5 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err6 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err7 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err8 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err9 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 8 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err10 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err11 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err12 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err13 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err14 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 13 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err15 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err16 {
> +                       default-state = "off";
> +                       gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err17 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err18 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err19 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err20 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err21 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 4 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err22 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err23 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err24 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 7 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err25 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err26 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 9 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err27 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 10 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err28 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err29 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 12 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err30 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err31 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 14 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               dimm-err32 {
> +                       default-state = "off";
> +                       gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan1-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 1 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan2-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan3-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 3 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan4-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 4 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan5-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               fan6-fault {
> +                       default-state = "off";
> +                       gpios = <&gpio4 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cpu1 {
> +                       default-state = "off";
> +                       gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               cpu2 {
> +                       default-state = "off";
> +                       gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser1-s1 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser1-s2 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser1-s3 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser2-s1 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser2-s2 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 4 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser2-s3 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 5 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser3-s1 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 6 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               riser3-s2 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               m2-1 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               m2-2 {
> +                       default-state = "off";
> +                       gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
> +               };
> +
> +               bat {
> +                       default-state = "off";
> +                       gpios = <&gpio5 15 GPIO_ACTIVE_LOW>;
> +               };
> +       };
> +
> +       gpio-keys-polled {
> +               compatible = "gpio-keys-polled";
> +               poll-interval = <1000>;
> +
> +               fan0-presence {
> +                       /* GPIO18C2 */
> +                       label = "fan0-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 2) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 2)>;
> +               };
> +
> +               fan1-presence {
> +                       /* GPIO18C3 */
> +                       label = "fan1-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 3) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 3)>;
> +               };
> +
> +               fan2-presence {
> +                       /* GPIO18C7 */
> +                       label = "fan2-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 7) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 7)>;
> +               };
> +
> +               fan3-presence {
> +                       /* GPIO18C6 */
> +                       label = "fan3-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 6) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 6)>;
> +               };
> +
> +               fan4-presence {
> +                       /* GPIO18C5 */
> +                       label = "fan4-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 5) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 5)>;
> +               };
> +
> +               fan5-presence {
> +                       /* GPIO18C4 */
> +                       label = "fan5-presence";
> +                       gpios = <&gpio1 ASPEED_GPIO(C, 4) GPIO_ACTIVE_LOW>;
> +                       linux,code = <ASPEED_GPIO(C, 4)>;
> +               };
> +       };
> +};
> +
> +&fmc {
> +       status = "okay";
> +       flash@0 {
> +               status = "okay";
> +               spi-max-frequency = <50000000>;
> +               spi-tx-bus-width = <4>;
> +               m25p,fast-read;
> +#include "openbmc-flash-layout-64.dtsi"
> +       };
> +};
> +&syscon {
> +       uart-clock-high-speed;
> +       status = "okay";
> +
> +       misc_control {
> +               compatible = "aspeed,bmc-misc";
> +               chip_id {
> +                       offset = <0x5b0>;
> +                       bit-mask = <0xffffffff 0xffffffff>;
> +                       bit-shift = <0>;
> +                       read-only;
> +                       reg-width = <64>;
> +                       hash-data = "d44f9b804976fa23c2e25d62f16154d26520a7e24c5555095fd1b55c027804f1570dcd16189739c640cd7d9a6ce14944a2c4eaf1dc429eed6940e8a83498a474";
> +               };

This doesn't look like anything we have bindings or code for.

> +       };
> +};
> +
> +#if 0
> + GPIO Alias: (runtime alias -> schematic name)
> +       ID_BUTTON -> FP_ID_BTN_N
> +       CPU_CATERR -> FM_PLT_BMC_THERMTRIP_N
> +       PCH_BMC_THERMTRIP -> FM_PLT_BMC_THERMTRIP_N
> +       RESET_BUTTON -> FP_BMC_RST_BTN_N
> +       RESET_OUT -> RST_BMC_RSTBTN_OUT_R_N
> +       POWER_BUTTON -> FP_BMC_PWR_BTN_R_N
> +       POWER_OUT -> FM_BMC_PWR_BTN_N
> +       PREQ_N -> DBP_ASD_BMC_PREQ_R_N
> +       POST_COMPLETE -> FM_BIOS_POST_CMPLT_BMC_N
> +       CPU_ERR0 -> FM_CPU_ERR0_LVT3_N
> +       CPU_ERR1 -> FM_CPU_ERR1_LVT3_N
> +       CPU_ERR2 -> FM_CPU_ERR2_LVT3_N
> +       DEBUG_EN_N -> FM_JTAG_TCK_MUX_SEL_R
> +       NMI_OUT -> IRQ_BMC_CPU_NMI_R
> +       PLTRST_N -> RST_PLTRST_BMC_N
> +       PRDY_N -> DBP_ASD_BMC_PRDY_R_N
> +       PWR_DEBUG_N ->
> +       XDP_PRST_N ->
> +       SYSPWROK ->
> +       RSMRST_N ->
> +       SIO_S3 -> FM_SLPS3_R_N
> +       SIO_S5 -> FM_SLPS4_R_N
> +       SIO_ONCONTROL -> FM_BMC_ONCTL_R_N
> +       SIO_POWER_GOOD -> PWRGD_CPU0_LVC3_R
> +       PS_PWROK -> PWRGD_BMC_PS_PWROK_R
> +       P3VBAT_BRIDGE_EN ->
> +       TCK_MUX_SEL ->
> +       SMI -> IRQ_SMI_ACTIVE_BMC_N
> +       NMI_BUTTON -> FP_NMI_BTN_N
> +#endif

Put this in a comment instead of an ifdef, if you want it included in
the device tree.

> +
> +&gpio0 {
> +       status = "okay";
> +       /* pinctrl-names = "pass-through";
> +       pinctrl-0 = <&pinctrl_thru0_default
> +                       &pinctrl_thru1_default>; */

Either remove this or un-comment it.

> +       gpio-line-names =
> +       /*A0-A7*/       "SMB_BMC0_MUX01_CLK_H","SMB_BMC0_MUX01_DAT_H","RST_BTN_IRMC_N","BTN_PWR_BMC_N","SMB_CPU_PIROM_SCL","SMB_CPU_PIROM_SDA","I2C_BMC_SCL14","I2C_BMC_SDA14",
> +       /*B0-B7*/       "FM_SEL_BMC_USB_HOST_N","NMI_OUT","IRQ_SMB3_M2_ALERT_N","SMB_BMC_2_PMBUS_ALERT_N","RST_BMC_PCIE_MUX_N","FM_BMC_EUP_LOT6_N","FM_BMC_BMCINIT_R","FP_ID_LED_N",
> +       /*C0-C7*/       "FM_FORCE_BMC_UPDATE_N","RST_RGMII_PHYRST_N","FM_TPM_EN_PULSE","FM_BMC_CRASHLOG_TRIG_N","IRQ_BMC_PCH_NMI_R","FM_CPU1_DISABLE_COD_N","SMB_BMCLC1_CLK_R_H","SMB_BMCLC1_DAT_R_H",
> +       /*D0-D7*/       "CPU_ERR0","CPU_ERR1","CPU_ERR2","PRDY_N","FM_SPD_SWITCH_CTRL_N","FM_RISER3_BMC_ID_0","FAN_PRSNT_LC2","FAN_PRSNT_LC1",
> +       /*E0-E7*/       "FM_RISER2_RBP_ID_R_0","LED_CSS_R_N","CLK_50M_CKMNG_BMCB","FM_BMC_BOARD_REV_ID2_N","FM_RISER2_ID_0","FM_RISER2_ID_1","SMB_BMCLC2_DAT_R_H","SMB_BMCLC2_CLK_R_H",
> +       /*F0-F7*/       "FM_BMC_BOARD_SKU_ID0_N","FM_BMC_BOARD_SKU_ID1_N","FM_BMC_BOARD_SKU_ID2_N","FM_BMC_BOARD_SKU_ID3_N","FM_BMC_BOARD_SKU_ID4_N ","FM_BMC_BOARD_SKU_ID5_N","PRSNT_MONITOR_FP_L","PS_PWROK",
> +       /*G0-G7*/       "FM_SMB_BMC_NVME_LVC3_ALERT_N","RST_BMC_I2C_M2_R_N","FP_LED_STATUS_GREEN_N","FP_LED_STATUS_AMBER_N","FM_BMC_BOARD_REV_ID0_N","FM_BMC_BOARD_REV_ID1_N","FM_BMC_CPU_FBRK_OUT_R_N","DBP_PRESENT_IN_R2_N",
> +       /*H0-H7*/       "SGPIO_BMC_CLK_R","SGPIO_BMC_LD_R_N","SGPIO_BMC_DOUT_R","SGPIO_BMC_DIN","PLTRST_N","CPU_CATERR","SMB_TEMPSENSOR_STBY_LVC3_R_SCL","SMB_TEMPSENSOR_STBY_LVC3_R_SDA",
> +       /*I0-I7*/       "JTAG_ASD_NTRST_R_N","JTAG_ASD_TDI_R","JTAG_ASD_TCK_R","JTAG_ASD_TMS_R","JTAG_ASD_TDO","FM_BMC_PWRBTN_OUT_R_N","","TP_FM_BMC_PCH_SCI_LPC_R_N",
> +       /*J0-J7*/       "I2C_BMC_RISER1_SCL1","I2C_BMC_RISER1_SDA1","I2C_BMC_PSU_SCL2","I2C_BMC_PSU_SDA2","I2C_BMC_PWR_SCL3","I2C_BMC_PWR_SDA3","I2C_BMC_SCL4","I2C_BMC_SDA4",
> +       /*K0-K7*/       "SMB_HSBP_STBY_LVC3_R_SCL","SMB_HSBP_STBY_LVC3_R_SDA","SMB_SMLINK0_STBY_LVC3_R2_SCL","SMB_SMLINK0_STBY_LVC3_R2_SDA","I2C_BMC_RISER2_SCL7","I2C_BMC_RISER2_SDA7","SMB_PMBUS_SML1_STBY_LVC3_R_SCL","SMB_PMBUS_SML1_STBY_LVC3_R_SDA",
> +       /*L0-L7*/       "SMB_PCIE_STBY_LVC3_R_SCL","SMB_PCIE_STBY_LVC3_R_SDA","SMB_HOST_STBY_BMC_LVC3_R_SCL","SMB_HOST_STBY_BMC_LVC3_R_SDA","PREQ_N","TCK_MUX_SEL","V_BMC_GFX_HSYNC_R","V_BMC_GFX_VSYNC_R",
> +       /*M0-M7*/       "SPA_CTS_N ","SPA_DCD_N","SPA_DSR_N","PU_SPA_RI_N","SPA_DTR_N","SPA_RTS_N","SPA_SOUT","SPA_SIN",
> +       /*N0-N7*/       "SPB_CTS_N","SPB_DCD_N","SPB_DSR_N","PU_SPB_RI_N","SPB_DTR_N","SPB_RTS_N","SPB_SOUT","SPB_SIN",
> +       /*O0-O7*/       "FAN_PWM_BMC_1_H","FAN_PWM_BMC_2_H","FAN_PWM_BMC_3_H","FAN_PWM_BMC_4_H","FAN_PWM_BMC_5_H","FAN_PWM_BMC_6_H","NMI_BUTTON","FM_RECOVER_BIOS_R_N",
> +       /*P0-P7*/       "RESET_BUTTON","RESET_OUT","POWER_BUTTON","POWER_OUT","FM_RISER3_BMC_ID_1","FM_RISER2_BMC_ID_2","RST_BMC_I2C_R_8","LED_BMC_HEARTBEAT_R_N",
> +       /*Q0-Q7*/       "FAN_TACH_BMC_0_N_BUF","FAN_TACH_BMC_1_N_BUF","FAN_TACH_BMC_2_N_BUF","FAN_TACH_BMC_3_N_BUF","FAN_TACH_BMC_4_N_BUF","FAN_TACH_BMC_5_N_BUF","FAN_TACH_BMC_6_N_BUF","FAN_TACH_BMC_7_N_BUF",
> +       /*R0-R7*/       "FAN_TACH_BMC_8_N_BUF","FAN_TACH_BMC_9_N_BUF","FAN_TACH_BMC_10_N_BUF","FAN_TACH_BMC_11_N_BUF","FAN_TACH_BMC_LC1_N_BUF","FAN_TACH_BMC_LC2_N_BUF","LED_PWROK_BMC_N","LED_GERR_IRMC_N",
> +       /*S0-S7*/       "RGMII_BMC_RMM4_LVC3_R_MDC","RGMII_BMC_RMM4_LVC3_R_MDIO","ID_BUTTON","PCH_BMC_THERMTRIP","TP_LED_BMC_HEARTBEAT_N","A_P3V_BAT_SCALED_EN","FM_ASD_EN_DET_R","FM_PCHHOT_N",
> +       /*T0-T7*/       "","","","","","","","",
> +       /*U0-U7*/       "","","","","","","","",
> +       /*V0-V7*/       "SIO_S3","SIO_S5","TP_BMC_SIO_PWREQ_N","SIO_ONCONTROL","SIO_POWER_GOOD","LED_BMC_HB_LED_N","FM_BMC_SUSACK_N","TP_IRQ_BMC_PCH_SMI_LPC_N_R",
> +       /*W0-W7*/       "LPC_LAD0_ESPI_R_IO0","LPC_LAD1_ESPI_R_IO1","LPC_LAD2_ESPI_R_IO2","LPC_LAD3_ESPI_R_IO3","CLK_24M_66M_LPC0_ESPI_BMC","LFRAME_N_ESPI_CS0_BMC_N","IRQ_LPC_SERIRQ_ESPI_ALERT_N","RST_LPC_LRST_ESPI_RST_BMC_R_N",
> +       /*X0-X7*/       "ERR_FAT_VRM_N","SMI","POST_COMPLETE","FM_CLR_LDL_H","PU_SPB_FORCEOFF_N","PU_SPA_FORCEOFF_N","FM_RISER1_RBP_ID_0","FM_OCP1_PRSNTB3_N",
> +       /*Y0-Y7*/       "FM_M2_PRSTN_BMC_N","IRQ_SML0_ALERT_BMC_R2_N","I2C_BUS8_INT_N","IRQ_SML1_PMBUS_BMC_ALERT_N","SPI_BMC_BOOT_R_IO2","SPI_BMC_BOOT_R_IO3","PU_SPI_BMC_BOOT_ABR","PU_SPI_BMC_BOOT_WP_N",
> +       /*Z0-Z7*/       "PWRGD_P3V3_RISER1","PWRGD_P3V3_RISER2","PRSNT_USB3_FP_X_L","PU_GPIOZ3","PU_GPIOZ4","PU_GPIOZ5","PU_GPIOZ6","PU_GPIOZ7";
> +};
> +
> +&gpio1 {
> +       status = "disabled";
> +       gpio-line-names = /* GPIO18 A-E */
> +       /*A0-A7*/       "RGMII_BMC_RMM4_TX_R_CLK","RGMII_BMC_RMM4_TX_R_CTRL","RGMII_BMC_RMM4_R_TXD0","RGMII_BMC_RMM4_R_TXD1","RGMII_BMC_RMM4_R_TXD2","RGMII_BMC_RMM4_R_TXD3","RGMII_BMC_RMM4_RX_CLK","RGMII_BMC_RMM4_RX_CTRL",
> +       /*B0-B7*/       "RGMII_BMC_RMM4_RXD0","RGMII_BMC_RMM4_RXD1","RGMII_BMC_RMM4_RXD2","RGMII_BMC_RMM4_RXD3","FAN_PWM_BMC_LC2_H","FAN_PWM_BMC_LC1_H ","RST_EMMC_BMC_R_N","FM_RISER1_BMC_ID_2",
> +       /*C0-C7*/       "FM_RISER1_BMC_ID_1","FM_RISER1_BMC_ID_0","FAN_PRSNT1_N","FAN_PRSNT2_N","FAN_PRSNT6_N","FAN_PRSNT5_N","FAN_PRSNT4_N","FAN_PRSNT3_N",
> +       /*D0-D7*/       "EMMC_BMC_R_CLK","EMMC_BMC_R_CMD","EMMC_BMC_R_DATA0","EMMC_BMC_R_DATA1","EMMC_BMC_R_DATA2","EMMC_BMC_R_DATA3","EMMC_BMC_CD_N","EMMC_BMC_WP_N",
> +       /*E0-E3*/       "EMMC_BMC_R_DATA4","EMMC_BMC_R_DATA5","EMMC_BMC_R_DATA6","EMMC_BMC_R_DATA7";
> +};
> +
> +&sgpiom0 {
> +       status = "okay";
> +};
> +
> +&kcs3 {
> +       kcs_addr = <0xCA2>;
> +       status = "okay";
> +};
> +
> +&kcs4 {
> +       kcs_addr = <0xCA4>;
> +       status = "okay";
> +};
> +
> +&lpc_snoop {
> +       snoop-ports = <0x80>;
> +       status = "okay";
> +};
> +
> +&mdio0 {
> +       status = "okay";
> +
> +       ethphy1: ethernet-phy@0 {
> +               compatible = "ethernet-phy-ieee802.3-c22";
> +               reg = <0>;
> +       };
> +};
> +
> +&mac0 {
> +       status = "okay";
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_rgmii1_default>;
> +       clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>,
> +                <&syscon ASPEED_CLK_MAC1RCLK>;
> +       clock-names = "MACCLK", "RCLK";
> +       phy-mode = "rgmii";
> +       phy-handle = <&ethphy1>;
> +};
> +
> +&adc0 {
> +       status = "okay";
> +};
> +
> +&adc1 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_txd1_default
> +                        &pinctrl_rxd1_default
> +                        &pinctrl_nrts1_default
> +                        &pinctrl_ndtr1_default
> +                        &pinctrl_ndsr1_default
> +                        &pinctrl_ncts1_default
> +                        &pinctrl_ndcd1_default
> +                        &pinctrl_nri1_default>;
> +};
> +
> +&uart2 {
> +       status = "okay";
> +       pinctrl-0 = <&pinctrl_txd2_default
> +                        &pinctrl_rxd2_default
> +                        &pinctrl_nrts2_default
> +                        &pinctrl_ndtr2_default
> +                        &pinctrl_ndsr2_default
> +                        &pinctrl_ncts2_default
> +                        &pinctrl_ndcd2_default
> +                        &pinctrl_nri2_default>;
> +};
> +
> +&uart3 {
> +       status = "okay";
> +       pinctrl-0 = <>;
> +};
> +
> +&uart4 {
> +       status = "okay";
> +       pinctrl-0 = <>;
> +};
> +
> +&uart5 {
> +       status = "okay";
> +};
> +
> +&uart_routing {
> +       status = "okay";
> +};
> +
> +&i2c0 {
> +       /* I2C_BMC_RISER1 */
> +       multi-master;
> +       status = "okay";
> +
> +       pca9545@70 {
> +               compatible = "nxp,pca9545";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +       };
> +};
> +
> +&i2c1 {
> +       /* I2C_BMC_PSU */
> +       multi-master;
> +       status = "okay";
> +
> +       psu1-eeprom@50 {
> +               compatible = "atmel,24c02";
> +               reg = <0x50>;
> +       };
> +
> +       psu2-eeprom@51 {
> +               compatible = "atmel,24c02";
> +               reg = <0x51>;
> +       };
> +
> +       pmbus@58 {
> +               compatible = "pmbus,sgd009";
> +               reg = <0x58>;
> +       };
> +
> +       pmbus@59 {
> +               compatible = "pmbus,sgd009";
> +               reg = <0x59>;
> +       };
> +};
> +
> +&i2c2 {
> +       /* I2C_BMC_PWR */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c3 {
> +       multi-master;
> +       status = "okay";
> +
> +       gpio2: pca9539@74{
> +               compatible = "nxp,pca9539";
> +               reg = <0x74>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio@0 {
> +                       reg = <0>;
> +               };
> +
> +               gpio@1 {
> +                       reg = <1>;
> +               };
> +
> +               gpio@2 {
> +                       reg = <2>;
> +               };
> +
> +               gpio@3 {
> +                       reg = <3>;
> +               };
> +
> +               gpio@4 {
> +                       reg = <4>;
> +               };
> +
> +               gpio@5 {
> +                       reg = <5>;
> +               };
> +
> +               gpio@6 {
> +                       reg = <6>;
> +               };
> +
> +               gpio@7 {
> +                       reg = <7>;
> +               };
> +
> +               gpio@8 {
> +                       reg = <8>;
> +               };
> +
> +               gpio@9 {
> +                       reg = <9>;
> +               };
> +
> +               gpio@10 {
> +                       reg = <10>;
> +               };
> +
> +               gpio@11 {
> +                       reg = <11>;
> +               };
> +
> +               gpio@12 {
> +                       reg = <12>;
> +               };
> +
> +               gpio@13 {
> +                       reg = <13>;
> +               };
> +
> +               gpio@14 {
> +                       reg = <14>;
> +               };
> +
> +               gpio@15 {
> +                       reg = <15>;
> +               };

We have a patch pending that exposes all of the pins as GPIOs, so you
don't need all of these nodes.

That said, the patch hasn't been merged upstream yet, so if you want
to keep these that's ok.

> +       };
> +
> +       gpio3: pca9539@75{
> +               compatible = "nxp,pca9539";
> +               reg = <0x75>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio@0 {
> +                       reg = <0>;
> +               };
> +
> +               gpio@1 {
> +                       reg = <1>;
> +               };
> +
> +               gpio@2 {
> +                       reg = <2>;
> +               };
> +
> +               gpio@3 {
> +                       reg = <3>;
> +               };
> +
> +               gpio@4 {
> +                       reg = <4>;
> +               };
> +
> +               gpio@5 {
> +                       reg = <5>;
> +               };
> +
> +               gpio@6 {
> +                       reg = <6>;
> +               };
> +
> +               gpio@7 {
> +                       reg = <7>;
> +               };
> +
> +               gpio@8 {
> +                       reg = <8>;
> +               };
> +
> +               gpio@9 {
> +                       reg = <9>;
> +               };
> +
> +               gpio@10 {
> +                       reg = <10>;
> +               };
> +
> +               gpio@11 {
> +                       reg = <11>;
> +               };
> +
> +               gpio@12 {
> +                       reg = <12>;
> +               };
> +
> +               gpio@13 {
> +                       reg = <13>;
> +               };
> +
> +               gpio@14 {
> +                       reg = <14>;
> +               };
> +
> +               gpio@15 {
> +                       reg = <15>;
> +               };
> +       };
> +
> +       gpio4: pca9539@76{
> +               compatible = "nxp,pca9539";
> +               reg = <0x76>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio@0 {
> +                       reg = <0>;
> +               };
> +
> +               gpio@1 {
> +                       reg = <1>;
> +               };
> +
> +               gpio@2 {
> +                       reg = <2>;
> +               };
> +
> +               gpio@3 {
> +                       reg = <3>;
> +               };
> +
> +               gpio@4 {
> +                       reg = <4>;
> +               };
> +
> +               gpio@5 {
> +                       reg = <5>;
> +               };
> +
> +               gpio@6 {
> +                       reg = <6>;
> +               };
> +
> +               gpio@7 {
> +                       reg = <7>;
> +               };
> +
> +               gpio@8 {
> +                       reg = <8>;
> +               };
> +
> +               gpio@9 {
> +                       reg = <9>;
> +               };
> +
> +               gpio@10 {
> +                       reg = <10>;
> +               };
> +
> +               gpio@11 {
> +                       reg = <11>;
> +               };
> +
> +               gpio@12 {
> +                       reg = <12>;
> +               };
> +
> +               gpio@13 {
> +                       reg = <13>;
> +               };
> +
> +               gpio@14 {
> +                       reg = <14>;
> +               };
> +
> +               gpio@15 {
> +                       reg = <15>;
> +               };
> +       };
> +
> +       gpio5: pca9539@77{
> +               compatible = "nxp,pca9539";
> +               reg = <0x77>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +
> +               gpio@0 {
> +                       reg = <0>;
> +               };
> +
> +               gpio@1 {
> +                       reg = <1>;
> +               };
> +
> +               gpio@2 {
> +                       reg = <2>;
> +               };
> +
> +               gpio@3 {
> +                       reg = <3>;
> +               };
> +
> +               gpio@4 {
> +                       reg = <4>;
> +               };
> +
> +               gpio@5 {
> +                       reg = <5>;
> +               };
> +
> +               gpio@6 {
> +                       reg = <6>;
> +               };
> +
> +               gpio@7 {
> +                       reg = <7>;
> +               };
> +
> +               gpio@8 {
> +                       reg = <8>;
> +               };
> +
> +               gpio@9 {
> +                       reg = <9>;
> +               };
> +
> +               gpio@10 {
> +                       reg = <10>;
> +               };
> +
> +               gpio@11 {
> +                       reg = <11>;
> +               };
> +
> +               gpio@12 {
> +                       reg = <12>;
> +               };
> +
> +               gpio@13 {
> +                       reg = <13>;
> +               };
> +
> +               gpio@14 {
> +                       reg = <14>;
> +               };
> +
> +               gpio@15 {
> +                       reg = <15>;
> +               };
> +       };
> +};
> +
> +&i2c4 {
> +       /* SMB_HSBP_STBY_LVC3_R */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c5 {
> +       /* SMB_SMLINK0_STBY_LVC3_R2 */
> +       bus-frequency = <1000000>;
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c6 {
> +       /* I2C_BMC_RISER2 */
> +       multi-master;
> +       status = "okay";
> +
> +       pca9543@70 {
> +               compatible = "nxp,pca9543";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x70>;
> +       };
> +
> +       pca9545@72 {
> +               compatible = "nxp,pca9545";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               reg = <0x72>;
> +       };
> +};
> +
> +&i2c7 {
> +       /* SMB_PMBUS_SML1_STBY_LVC3_R */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c8 {
> +       /* SMB_PCIE_STBY_LVC3_R */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c9 {
> +       /* SMB_HOST_STBY_BMC_LVC3_R */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c10 {
> +       /* SMB_BMC0_MUX01 */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c12 {
> +       /* SMB_CPU_PIROM */
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c13 {
> +       multi-master;
> +       status = "okay";
> +};
> +
> +&i2c15 {
> +       /* SMB_TEMPSENSOR_STBY_LVC3_R */
> +       multi-master;
> +       status = "okay";
> +
> +       tmp75@48 {
> +               compatible = "ti,tmp75";
> +               reg = <0x48>;
> +       };
> +};
> +
> +&vhub {
> +       status = "okay";
> +};
> --
> 2.7.4
>
>
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient.
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
>
