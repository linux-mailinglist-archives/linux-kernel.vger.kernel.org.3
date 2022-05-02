Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0C4517590
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386590AbiEBRQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbiEBRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80B4627B;
        Mon,  2 May 2022 10:12:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6419661307;
        Mon,  2 May 2022 17:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC0C385AC;
        Mon,  2 May 2022 17:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651511565;
        bh=F4A/7EYGFEZrN9M1/Wu0JMGDPGLaRN8iNpkNaFcYLn4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HVQdD5ETXp+x2uaRabpPzAVsPDBGswx4EsgZzOWr4HhCJrQvl8HQHpHNXZZIqdfgF
         GCRatzouZgTdWnuiDMBWeTP8+VnaxQvvXbJHIrFo6XOBDkWpScEi/0yM/5kwSOkiDD
         UBejt4S3hXRhz4SUzDimE6aFOqd/uTaxgyMt1GuTAUAsODI3v3wDbyRhOv6TaiMOYL
         g04/9otO0978IaAHmLG/zNSHukXV4ojB35fvPsOOl21gBrBp02FeIiUzmUX9qZMWgR
         eaj3Sf7+U1ztyPWJiStP8I+u0OpMsZ3ijPHnmCwhIq1y8fEv7pQPPV8m5l8MbLtcZZ
         tqHsO8rGG9fFw==
Received: by mail-pg1-f172.google.com with SMTP id q76so9085676pgq.10;
        Mon, 02 May 2022 10:12:45 -0700 (PDT)
X-Gm-Message-State: AOAM533tj8Eh9RKSo5wSNZOALq9AkdQmV9lz+Z0OfnylWBmmfXpbIph6
        Ec1SsORtMw97UKD5xysQ8Cb4/iPSjqXNOXNCgQ==
X-Google-Smtp-Source: ABdhPJzl9m0fFoAHvEl1DDBVONz2rISSslZowrjuzounK+sTYQiF+nbi0wBRKNwITCH0g2lI5Eh9KosK3zmFFUU25sA=
X-Received: by 2002:a05:6a00:10d0:b0:4f7:5af4:47b6 with SMTP id
 d16-20020a056a0010d000b004f75af447b6mr12481460pfu.6.1651511565254; Mon, 02
 May 2022 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
In-Reply-To: <20220502165818.4002157-1-matthew.gerlach@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 2 May 2022 12:12:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKwr7Je51X=OVd5Mfxe=Ztvp7jY2WcTu+treB3x7QBxfA@mail.gmail.com>
Message-ID: <CAL_JsqKwr7Je51X=OVd5Mfxe=Ztvp7jY2WcTu+treB3x7QBxfA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: intel: add device tree for n6000
To:     matthew.gerlach@linux.intel.com
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, dinguyen@vger.kernel.org,
        robh+dt@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 11:58 AM <matthew.gerlach@linux.intel.com> wrote:
>
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Add a device tree for the n6000 instantiation of Agilex
> Hard Processor System (HPS).
>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  arch/arm64/boot/dts/intel/Makefile            |  1 +
>  .../boot/dts/intel/socfpga_agilex_n6000.dts   | 77 +++++++++++++++++++
>  2 files changed, 78 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
>
> diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
> index 0b5477442263..1425853877cc 100644
> --- a/arch/arm64/boot/dts/intel/Makefile
> +++ b/arch/arm64/boot/dts/intel/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += socfpga_agilex_socdk.dtb \
>                                 socfpga_agilex_socdk_nand.dtb \
> +                               socfpga_agilex_n6000.dtb \

Alphabetical order.

>                                 socfpga_n5x_socdk.dtb
>  dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> new file mode 100644
> index 000000000000..07f5a5983e5c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex_n6000.dts
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier:     GPL-2.0
> +/*
> + * Copyright (C) 2021-2022, Intel Corporation
> + */
> +#include "socfpga_agilex.dtsi"
> +
> +/ {
> +       model = "SoCFPGA Agilex n6000";
> +
> +       aliases {
> +               serial0 = &uart1;
> +               serial1 = &uart0;
> +               ethernet0 = &gmac0;
> +               ethernet1 = &gmac1;
> +               ethernet2 = &gmac2;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +
> +       memory {
> +               device_type = "memory";
> +               /* We expect the bootloader to fill in the reg */
> +               reg = <0 0 0 0>;
> +       };
> +
> +       soc {
> +               clocks {
> +                       osc1 {
> +                               clock-frequency = <25000000>;
> +                       };
> +               };
> +               agilex_hps_bridges: bridge@80000000 {
> +                       compatible = "simple-bus";
> +                       reg = <0x80000000 0x60000000>,
> +                               <0xf9000000 0x00100000>;
> +                       reg-names = "axi_h2f", "axi_h2f_lw";
> +                       #address-cells = <0x2>;
> +                       #size-cells = <0x1>;
> +                       ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
> +
> +                       uio_cp_eng@0xf9000000 {

Unit addresses shouldn't have '0x' and the address is wrong as it
should match the child address (0). dtc will tell you this though you
need 'W=1'. Run this and schema checks and don't add new warnings.

> +                               compatible = "generic-uio";

NAK. Not documented and that's because this is not a h/w device.

> +                               reg = <0x00000000 0x00000000 0x00001000>;
> +                               status = "okay";

That's the default.

> +                       };
> +               };
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&spi0 {
> +       status = "okay";
> +
> +       spidev: spidev@0 {
> +               status = "okay";
> +               compatible = "linux,spidev";
> +               spi-max-frequency = <25000000>;
> +               reg = <0>;
> +       };
> +};
> +
> +&watchdog0 {
> +       status = "okay";
> +};
> +
> +&fpga_mgr {
> +       status = "disabled";
> +};
> --
> 2.25.1
>
