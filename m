Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790914E45C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbiCVSPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiCVSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:15:39 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C544193C1;
        Tue, 22 Mar 2022 11:14:12 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id w4so22680361edc.7;
        Tue, 22 Mar 2022 11:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YSNtfm2I+E7ZPtbQKZG0Nrw6hi+P+RYiX3Pd+JP3Ab4=;
        b=lU2Ya6Ec2j4EQTNwBZDB1kO0YT3zjgAbZVU2jIOh9B2ONxJKVuHBCbkSiPldvIJ/cg
         dsddPzrLVmPXdpaWEccSQk7vAJKWh/egYVeLAJQP+65vsBfq+W3i/1MK5L8QMwLD2fJm
         BUTfrJl9XJ74gnxXFEZ4jEILy+2T7858DYG/JLjMFlxdRR++gaybucA04gn7snSowYRk
         gFnzF2c5c4joyNsuiOh8RDft+o75zissG7GfiIIVeA4ImJBxBqX8w6numCc9f3RMAJsJ
         zNm69p/rsB9XBJmkdE7C6wZk3FCeaWYpxrPcjJ4n1zoXeLPT1ws9D3lmydHGPFw7bP0j
         7Txw==
X-Gm-Message-State: AOAM530UQqkCIMM7sfr0DxoADfMBZ3oKbpgE2Ph6nWcS5mgHe8HYLpXw
        6LA+Ce4pY94NHGtk1pCIdXrfTmnBZcA/Vg==
X-Google-Smtp-Source: ABdhPJwdUri/i8z1B7zh8yu0O1Iy/wywZGubvdSv0lI+ID/JVL2IS4yIxLLkfnX8yWWh3ln4JtofCQ==
X-Received: by 2002:a50:c00a:0:b0:418:f10f:b27c with SMTP id r10-20020a50c00a000000b00418f10fb27cmr29450490edb.204.1647972850517;
        Tue, 22 Mar 2022 11:14:10 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id n24-20020a17090673d800b006df8ec24712sm7481201ejl.215.2022.03.22.11.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:14:09 -0700 (PDT)
Message-ID: <55e161d1-face-6958-1d86-8a85b82e8485@kernel.org>
Date:   Tue, 22 Mar 2022 19:14:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] arm64: dts: ti: introduce a minimal am642 device tree
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220321155417.13267-1-bb@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321155417.13267-1-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 16:54, Bryan Brattlof wrote:
> Texas Instrument's am642 is one of many k3 based, low cost, low power,
> chips designed to work in a wide range of applications spanning an even
> wider range of industries that TI is actively developing
> 
> With its pin-mux and peripheral rich designs, these chips will likely
> have a multitude of custom device trees that range wildly from one
> another and (hopefully) guarantee an influx of variants into the kernel
> in the coming years
> 
> With overlays no longer a thing, I wanted to ask for opinions on how
> we can best help integrate these dt files as they begin to be developed
> 
> I also wanted to introduce a skeletonized (nothing but uart) device tree
> to give others a good starting point while developing their projects.

Real hardware as DTS please. There is no need to add some skeleton for
specific SoC. What if every SoC goes that way?

Feel free to create re-usable components in DTSI ways, still reflecting
some hardware parts.

> 
> Let me know what you think :)
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  .../devicetree/bindings/arm/ti/k3.yaml        |   1 +
>  arch/arm64/boot/dts/ti/Makefile               |   1 +
>  arch/arm64/boot/dts/ti/k3-am642-skeleton.dts  | 335 ++++++++++++++++++
>  3 files changed, 337 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index 61c6ab4f52e26..e65053d6465bd 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -55,6 +55,7 @@ properties:
>        - description: K3 AM642 SoC
>          items:
>            - enum:
> +              - ti,am642-generic

Real hardware is needed.

>                - ti,am642-evm
>                - ti,am642-sk
>            - const: ti,am642
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 02e5d80344d00..df7bdf087558c 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>  
>  dtb-$(CONFIG_ARCH_K3) += k3-j721s2-common-proc-board.dtb
>  
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-skeleton.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>  dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
> new file mode 100644
> index 0000000000000..2b789c9c25ced
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-skeleton.dts
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The absolute minimum DTS file needed for an AM642
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/k3.h>
> +#include "k3-am642.dtsi"
> +
> +/ {
> +	compatible = "ti,am642-generic", "ti,am642";
> +	model = "Texas Instruments AM642 Generic";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";


No development bootargs.

> +	};
> +
> +	cpus {
> +		/delete-node/ cpu@1;

A bit weird... especially without any comment.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000 0x00000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>; /* for OP-TEE */
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +/* reserved for mcu firmware */
> +&mcu_gpio0 {
> +	status = "reserved";
> +};
> +
> +&mcu_i2c0 {
> +	status = "disabled";
> +};
> +

Judging by this file - several disabled or reserved blocks - this does
not look at all usable. What's the point? How does it even help anyone?


Best regards,
Krzysztof
