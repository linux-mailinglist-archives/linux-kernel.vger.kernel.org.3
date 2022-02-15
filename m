Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6B4B6E56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbiBOOIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:08:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbiBOOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:08:10 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D602B183;
        Tue, 15 Feb 2022 06:08:00 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id p9so21609129ejd.6;
        Tue, 15 Feb 2022 06:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zmquzx9EapngFWMHIp0jkJJUKf49k1ySJIytgsbiDMo=;
        b=q5hOnTKxHz2Lgke9Dh6gQ8k+XtsQYjpJLbfMyIXCNNiQjgcWspm2ivLfaFoQboKCmL
         kIFtAxdWV0zlTViMZaevkU8BFMpxMAT/gmtuwAEhy5ximXIrPYmL0cvDROYJu2YZ0h8B
         84PcNlGN4iaLbuXfc2MnYp+9C0V6XTOAD9QDF9vPcTLKH8Ja+vwMzMeo2/A24BgLCQ65
         FWwjkA70roE2cVt+Svkdcin0OAAr5QZVjV/ktJtQmrcpbwyxvmGQZYgmnCGFrPt7rqDG
         jTGU39gAhK4b/dDfk23gdzLtxzL9fDCTG0jf9tns3+T88n4cluXP1ePH5444Q6kO4bvU
         OThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zmquzx9EapngFWMHIp0jkJJUKf49k1ySJIytgsbiDMo=;
        b=SHba1F4nSmkztivo/2WpNJjjhd0Zc35ezRXeNWm35ubQmbMFD4DriYvjgDHgQRrW4d
         ZleJFrXdVNbJJseeHSuaOIdMl/DyR4YF2WKjcJAnwzsIGtNGMcXiGpfmxiFm5IVXKIS6
         FnXw+d2XUFeeJgNK+OvaJPdhEZYVs14U+cKp7Fjjsj0slFvZszNZXIoc+g/3N0wlT9vj
         jH+XZet0komnuEL0j9dQv/NHKsL0ydwri2BYmZTCFFkn09anK7OIGC9ouhWxqpaoq5Do
         pqmsDopzdXHXeswjlWkavPdMRgONL7NDfniz6Y+CqGPOUkNdq5BVWfohertoEGBauIYX
         cHvg==
X-Gm-Message-State: AOAM5331WLQsaNksPNzeSnk1VHJRsjVgBwrR5bHvIpHgaRAH56JGaWrL
        K1DWBPxiy79VqChAxEtpQDc=
X-Google-Smtp-Source: ABdhPJzckbVd+co0pA67kLhgpBPhf0j7lFh/fc87+g4chr5B1zfWnh5zkP9ShOS5kWyeS9wJCkv+Cg==
X-Received: by 2002:a17:907:869e:: with SMTP id qa30mr3057627ejc.483.1644934078691;
        Tue, 15 Feb 2022 06:07:58 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z8sm11665580ejc.151.2022.02.15.06.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:07:58 -0800 (PST)
Message-ID: <f078ac6f-5605-7b86-5734-cbbf7dc52c71@gmail.com>
Date:   Tue, 15 Feb 2022 15:07:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: crypto: convert rockchip-crypto to yaml
Content-Language: en-US
To:     heiko@sntech.de, Corentin Labbe <clabbe@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
References: <20220211115925.3382735-1-clabbe@baylibre.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220211115925.3382735-1-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2/11/22 12:59, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - fixed example
> - renamed to a new name
> - fixed some maxItems
> 
> Change since v2:
> - Fixed maintainers section
> 
>  .../crypto/rockchip,rk3288-crypto.yaml        | 66 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 --------
>  2 files changed, 66 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml

rockchip,crypto.yaml

>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> new file mode 100644
> index 000000000000..2e1e9fa711c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#

rockchip,crypto.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Electronics And Security Accelerator
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:

    oneOf:
      - const: rockchip,rk3288-crypto
      - items:
          - enum:
              - rockchip,rk3228-crypto
              - rockchip,rk3328-crypto
              - rockchip,rk3368-crypto
              - rockchip,rk3399-crypto
          - const: rockchip,rk3288-crypto

rk3288 was the first in line that had support, so we use that as fall
back string.

> +    const: rockchip,rk3288-crypto
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock data
> +      - description: clock data
> +      - description: clock crypto accelerator

> +      - description: clock dma

remove ???

> +
> +  clock-names:
> +    items:
> +      - const: aclk
> +      - const: hclk
> +      - const: sclk

> +      - const: apb_pclk

remove ???

Similar to the rk3568 pclk_xpcs discussion ACLK_DMAC1 belongs to the
dmac_bus_s node and should have been enabled by the DMA driver I think.
Could you advise if this is correct or should we remove parsing/enabling
ACLK_DMAC1 in rk3288_crypto.c in order to it easier
porting/adding/syncing nodes for other SoC types?

Johan

===

From rk3288.dtsi:

	dmac_bus_s: dma-controller@ffb20000 {
		compatible = "arm,pl330", "arm,primecell";
		reg = <0x0 0xffb20000 0x0 0x4000>;
		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
			     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
		#dma-cells = <1>;
		arm,pl330-broken-no-flushp;
		arm,pl330-periph-burst;

		clocks = <&cru ACLK_DMAC1>;

		clock-names = "apb_pclk";
	};

	crypto: cypto@ff8a0000 {
		compatible = "rockchip,rk3288-crypto";
		reg = <0x0 0xff8a0000 0x0 0x4000>;
		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,

			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;

		clock-names = "aclk", "hclk", "sclk", "apb_pclk";

		resets = <&cru SRST_CRYPTO>;
		reset-names = "crypto-rst";
	};
===

https://github.com/rockchip-linux/u-boot/blob/next-dev/drivers/crypto/rockchip/crypto_v1.c

U-boot currently only looks for a SCLK_CRYPTO array and sets the
SCLK_CRYPTO frequency.

TODO:
Make it work/portable for all Rockchip SoC types in both Linux and
U-boot with variable number of clocks and resets.


rk322x.dtsi:

	crypto: crypto@100a0000 {
		compatible = "rockchip,rk3228-crypto", "rockchip,rk3288-crypto";
		reg = <0x100a0000 0x10000>;
		clocks = <&cru SCLK_CRYPTO>;
		clock-names = "sclk_crypto";
	};


#define SRST_CRYPTO		53
#define HCLK_M_CRYPTO		476
#define HCLK_S_CRYPTO		477

#define SRST_CRYPTO		53

===
rk3328.dtsi:

	crypto: crypto@ff060000 {
		compatible = "rockchip,rk3328-crypto", "rockchip,rk3288-crypto";
		reg = <0x0 0xff060000 0x0 0x10000>;
		clocks = <&cru SCLK_CRYPTO>;
		clock-names = "sclk_crypto";
	};

#define SRST_CRYPTO		68
#define HCLK_CRYPTO_MST		336
#define HCLK_CRYPTO_SLV		337

#define SRST_CRYPTO		68

===
rk3368.dtsi:

	crypto: crypto@ff8a0000 {
		compatible = "rockchip,rk3368-crypto", "rockchip,rk3288-crypto";
		reg = <0x0 0xff8a0000 0x0 0x10000>;
		clocks = <&cru SCLK_CRYPTO>;
		clock-names = "sclk_crypto";
	};

#define SCLK_CRYPTO		130  ??? missing in rk3368-cru.h
#define MCLK_CRYPTO		191
#define HCLK_CRYPTO		461

#define SRST_CRYPTO		174

===
rk3399.dtsi:

	crypto: crypto@ff8b0000 {
		compatible = "rockchip,rk3399-crypto", "rockchip,rk3288-crypto";
		reg = <0x0 0xff8b0000 0x0 0x10000>;
		clocks = <&cru SCLK_CRYPTO0>, <&cru SCLK_CRYPTO1>;
		clock-names = "sclk_crypto0", "sclk_crypto1";
	};


#define SCLK_CRYPTO0			133
#define SCLK_CRYPTO1			134
#define HCLK_M_CRYPTO0			464
#define HCLK_M_CRYPTO1			465
#define HCLK_S_CRYPTO0			466
#define HCLK_S_CRYPTO1			467

#define SRST_CRYPTO_S			174
#define SRST_CRYPTO_M			175
#define SRST_CRYPTO			181
#define SRST_CRYPTO1_S			184
#define SRST_CRYPTO1_M			185
#define SRST_CRYPTO1			186

> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: crypto-rst
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/rk3288-cru.h>
> +    crypto@ff8a0000 {
> +      compatible = "rockchip,rk3288-crypto";
> +      reg = <0xff8a0000 0x4000>;
> +      interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> +               <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> +      clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> +      resets = <&cru SRST_CRYPTO>;
> +      reset-names = "crypto-rst";
> +    };
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt b/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> deleted file mode 100644
> index 5e2ba385b8c9..000000000000
> --- a/Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Rockchip Electronics And Security Accelerator
> -
> -Required properties:
> -- compatible: Should be "rockchip,rk3288-crypto"
> -- reg: Base physical address of the engine and length of memory mapped
> -       region
> -- interrupts: Interrupt number
> -- clocks: Reference to the clocks about crypto
> -- clock-names: "aclk" used to clock data
> -	       "hclk" used to clock data
> -	       "sclk" used to clock crypto accelerator
> -	       "apb_pclk" used to clock dma
> -- resets: Must contain an entry for each entry in reset-names.
> -	  See ../reset/reset.txt for details.
> -- reset-names: Must include the name "crypto-rst".
> -
> -Examples:
> -
> -	crypto: cypto-controller@ff8a0000 {
> -		compatible = "rockchip,rk3288-crypto";
> -		reg = <0xff8a0000 0x4000>;
> -		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&cru ACLK_CRYPTO>, <&cru HCLK_CRYPTO>,
> -			 <&cru SCLK_CRYPTO>, <&cru ACLK_DMAC1>;
> -		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
> -		resets = <&cru SRST_CRYPTO>;
> -		reset-names = "crypto-rst";
> -	};
