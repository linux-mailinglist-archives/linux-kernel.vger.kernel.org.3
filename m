Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43B55B02CA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGLWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 07:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIGLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:22:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEB887690
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 04:22:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so21939796lfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 04:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yRRtL38N5+qXoPQJV1tceH/F3ymH5RFQOvhRaXKU9Q4=;
        b=fBxz5+FsmoEc+e3Wrxc0gozQf5x8PNS0LCxC9SNAOJjZL6UKUYUlxXzoIsCp7AAdoP
         Bh/a5nQxeKi83JSZidxMYC4Koi1BeHKJbm78Fry4QIWsSX43I/NZMEeKlRH5CtK1o56a
         Rq6XBAvbEjV/ItaotW/4qgPugyY6T8XFa5PNna3MuM/+LU+XeoqdEPwNNErkf1EcQgYy
         9obQSqc99VJxl5BSqjBmU3UKrCb9yHLcs3Hflj/nfn4v5Infg9X5FJzZpNY8ABNVTP/T
         K21C8fVVJBIsi30esVAQJvoseZQVUGTtjq82GTkxY8Kcqcgil3nibH7cyK6Dyv36WQZQ
         r+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yRRtL38N5+qXoPQJV1tceH/F3ymH5RFQOvhRaXKU9Q4=;
        b=dBzCW9BiiIZyqFzM3wd539I/I2//kYkP3TAd+9pSuYpR7dItuXOn1JIuOIcljHpRzE
         lgyeOQTwialVoqtGwwNMwIBRfiBKEwcU2dcCyST2KlU1INioMMBSzXpcETnDMm+krCzI
         2P1OrTVz3J1LS3BG1Cm3/v2KbqVplupoCpwsJIBrl55XtCtGV6/e4k5MYZYHsVMUtEZF
         wyydhfU14caNLXb5fZLJQT9F3LphkBkf6Kbf3WxPnDWvvCsHWFOXmag5d/hGZEUuAGS/
         PrbRVUqPnwH4bdkUl3+p8GmxakUgmfsadw2JXywwEEXM76QW8Llkw+RYJIglKQugqoqF
         2PqQ==
X-Gm-Message-State: ACgBeo3OK+wbsbJ1LYMIX3vqPsgwSzQdPwhHL80kiJAbclt7JosfL84N
        acY91o9ACAW//9KT40YIcpzdZQ==
X-Google-Smtp-Source: AA6agR7kleToy+ElPZYDp7n8AM+3DYvAIzbgBSDg+WJxW/jDUgqoajBREIA4VZs6svpaU9a74lvqKw==
X-Received: by 2002:a05:6512:3fa2:b0:48a:16df:266f with SMTP id x34-20020a0565123fa200b0048a16df266fmr937065lfa.414.1662549726109;
        Wed, 07 Sep 2022 04:22:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k22-20020a05651210d600b00497ac35ae1esm74618lfg.85.2022.09.07.04.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 04:22:05 -0700 (PDT)
Message-ID: <08168057-853c-5b17-7d88-dc6c30e82f14@linaro.org>
Date:   Wed, 7 Sep 2022 13:22:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [Patch v2 01/15] dt-bindings: media: s5p-mfc: Add new DT schema
 for MFC
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, aakarsh.jain@samsung.com
References: <20220907064715.55778-1-smitha.t@samsung.com>
 <CGME20220907063313epcas5p114f793010fd0f2797e93bd83ed18a1d7@epcas5p1.samsung.com>
 <20220907064715.55778-2-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907064715.55778-2-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 08:47, Smitha T Murthy wrote:
> Adds DT schema for s5p-mfc in yaml format

s/Adds/Convert/
(as convert to DT schema)

Please mention here changes to original binding (I see at least adding
iommus and dropping some properties).

> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     |  77 +------------
>  .../bindings/media/samsung,s5p-mfc.yaml       | 109 ++++++++++++++++++
>  2 files changed, 110 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..0b7c4dd40095 100644
> --- a/Documentation/devicetree/bindings/media/s5p-mfc.txt
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> @@ -1,76 +1 @@
> -* Samsung Multi Format Codec (MFC)
> -
> -Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> -supports high resolution decoding and encoding functionalities.
> -The MFC device driver is a v4l2 driver which can encode/decode
> -video raw/elementary streams and has support for all popular
> -video codecs.
> -
> -Required properties:
> -  - compatible : value should be either one among the following
> -	(a) "samsung,mfc-v5" for MFC v5 present in Exynos4 SoCs
> -	(b) "samsung,mfc-v6" for MFC v6 present in Exynos5 SoCs
> -	(c) "samsung,mfc-v7" for MFC v7 present in Exynos5420 SoC
> -	(d) "samsung,mfc-v8" for MFC v8 present in Exynos5800 SoC
> -	(e) "samsung,exynos5433-mfc" for MFC v8 present in Exynos5433 SoC
> -	(f) "samsung,mfc-v10" for MFC v10 present in Exynos7880 SoC
> -
> -  - reg : Physical base address of the IP registers and length of memory
> -	  mapped region.
> -
> -  - interrupts : MFC interrupt number to the CPU.
> -  - clocks : from common clock binding: handle to mfc clock.
> -  - clock-names : from common clock binding: must contain "mfc",
> -		  corresponding to entry in the clocks property.
> -
> -Optional properties:
> -  - power-domains : power-domain property defined with a phandle
> -			   to respective power domain.
> -  - memory-region : from reserved memory binding: phandles to two reserved
> -	memory regions, first is for "left" mfc memory bus interfaces,
> -	second if for the "right" mfc memory bus, used when no SYSMMU
> -	support is available; used only by MFC v5 present in Exynos4 SoCs
> -
> -Obsolete properties:
> -  - samsung,mfc-r, samsung,mfc-l : support removed, please use memory-region
> -	property instead

When did they become obsolete? Is it enough of time to remove them?
> -
> -
> -Example:
> -SoC specific DT entry:
> -
> -mfc: codec@13400000 {
> -	compatible = "samsung,mfc-v5";
> -	reg = <0x13400000 0x10000>;
> -	interrupts = <0 94 0>;
> -	power-domains = <&pd_mfc>;
> -	clocks = <&clock 273>;
> -	clock-names = "mfc";
> -};
> -
> -Reserved memory specific DT entry for given board (see reserved memory binding
> -for more information):
> -
> -reserved-memory {
> -	#address-cells = <1>;
> -	#size-cells = <1>;
> -	ranges;
> -
> -	mfc_left: region@51000000 {
> -		compatible = "shared-dma-pool";
> -		no-map;
> -		reg = <0x51000000 0x800000>;
> -	};
> -
> -	mfc_right: region@43000000 {
> -		compatible = "shared-dma-pool";
> -		no-map;
> -		reg = <0x43000000 0x800000>;
> -	};
> -};
> -
> -Board specific DT entry:
> -
> -codec@13400000 {
> -	memory-region = <&mfc_left>, <&mfc_right>;
> -};
> +This file has moved to samsung,s5p-mfc.yaml

Just drop the TXT completely. Nothing references it.

> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> new file mode 100644
> index 000000000000..7cd26d4acbe4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/samsung,s5p-mfc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Multi Format Codec (MFC)
> +
> +maintainers:
> +  - Marek Szyprowski <m.szyprowski@samsung.com>
> +  - Aakarsh Jain <aakarsh.jain@samsung.com>

and maybe you as well?

> +
> +description:
> +  Multi Format Codec (MFC) is the IP present in Samsung SoCs which
> +  supports high resolution decoding and encoding functionalities.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - samsung,mfc-v5                  # Exynos4
> +      - samsung,mfc-v6                  # Exynos5
> +      - samsung,mfc-v7                  # Exynos5420
> +      - samsung,mfc-v8                  # Exynos5800
> +      - samsung,exynos5433-mfc          # Exynos5433
> +      - samsung,mfc-v10                 # Exynos7880
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 3

You need to list the items. If this varies per compatible, do it in AllOf.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 2
> +
> +  iommu-names:
> +    maxItems: 2

You need to list the items.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  memory-region:
> +    maxItems: 1

This misses the description and old binding allowed it only for MFCv5,
not for others, right?

> +
> +allOf:
> +  - if:

allOf goes after required section.

> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - samsung,mfc-v5
> +    then:
> +      properties:
> +        memory-region:
> +          maxItems: 2

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

This won't work. Test it and you will see it.


> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    # SoC specific DT entry
> +    mfc: mfc@12880000 {
> +        compatible = "samsung,fsd-mfc";

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

> +        reg = <0x0 0x12880000 0x0 0x10000>;
> +        interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +        clock-names = "mfc";
> +        clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
> +        iommus = <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0x0>;
> +        iommu-names = "left", "right";
> +        power-domains = <&pd_mfc>;
> +        memory-region = <&mfc_left>, <&mfc_right>;
> +    };
> +
> +  - |
> +    # Reserved memory specific DT entry for given board
> +    # (see reserved memory binding for more information)
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;

Drop this example, not really related to MFC.

> +        ranges;


Best regards,
Krzysztof
