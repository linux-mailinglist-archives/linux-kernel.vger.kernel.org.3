Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9A52A3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343663AbiEQNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348003AbiEQNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:55:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BA33A25
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:55:43 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a23so13763677ljd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sxr705jZC8qwBHiwQ0dlLfdaaSWTqvjEURwffcf7Xtk=;
        b=pqjyv0Ute1e96047pfU5nKGgnaYqhyPiUOUSl3PZ561saMuArdMZd2qdK9kcOh4Mz2
         nno4wpRxxJg13GrxWLppxtngA5iFNYAmzzjDFMa6D/Pai3Z5DfILW32LD0hjhyYHHIZq
         ZHu3ps7Y355wMdJk9auRHkB/gDoSAx9nF8RQ5Og3h72QiNZk//zfCKf5v5HJmNtxjx23
         JTr+NHb723MCTXISD2ZWKgxOCos92w4Evv4L5Dzu/PCAZLnfBbz2ZToJv6Nx1W5p+55l
         ALHV0ThwaYygX152HWCGv3XtzYhtseOZSX0yu3+sINQVezPetq27rdnqT/agiyuPMhPa
         IyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sxr705jZC8qwBHiwQ0dlLfdaaSWTqvjEURwffcf7Xtk=;
        b=FBlfMpxU7VHCuaCGshy3Jz6xqRn7RAp2twC9Q+DpdB49ZduXvV93B2CJlkh9BXPKNq
         swY1vDN5WVtx6LABkmUdoakklBIGb2TFyAB8Y9jKHSDIQ45PERyJYfAjTBHgjTIGoyVf
         t/W6DbqcDVEJ4wyuyRg/K7C36JlQ6qbu/SUG0LaHGesPobCFuwTSHVltN1z1ilwM6rND
         oENzAIT7kcyu87POWDSrHgVrlZ+t6HwsHlQKLHlHDLxT+xzqteNCNdfX9aosQiN4MbJm
         kjzUY8+w9J8lW+aa/u6anWPn3Tn1oCcluKXFOApXcUZ0EnJB926GhKSGcveIoOy6qYBx
         WKKQ==
X-Gm-Message-State: AOAM533hhZalYgL/I1U1xBQ6g6mAv/dhBf7dl5MywCnpBZWSlg2VS/+Z
        lBCtOrXwhFEHKTb5uKHZ9J3uT8h/QRGFSRNW
X-Google-Smtp-Source: ABdhPJxU3rEbOrP15QmzJWshAm2FKWF9dKPOC9EJhEy/iX80uWHvbEb/N3DSQEbjIKDF9xJDNDuXgw==
X-Received: by 2002:a2e:b893:0:b0:250:6ab8:6e1a with SMTP id r19-20020a2eb893000000b002506ab86e1amr14034943ljp.193.1652795741365;
        Tue, 17 May 2022 06:55:41 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t10-20020a2e954a000000b0024b14fa6061sm1900075ljh.1.2022.05.17.06.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 06:55:40 -0700 (PDT)
Message-ID: <6c2ea5f7-3cc0-d43c-c667-18c25b64ff72@linaro.org>
Date:   Tue, 17 May 2022 15:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to
 new DT schema
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
        linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125554epcas5p4e87a71471525056281f1578f4f80f760@epcas5p4.samsung.com>
 <20220517125548.14746-3-smitha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220517125548.14746-3-smitha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2022 14:55, Smitha T Murthy wrote:
> Adds DT schema for s5p-mfc in yaml format.
> 

Thank you for your patch. There is something to discuss/improve.

> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> ---
>  .../devicetree/bindings/media/s5p-mfc.txt     | 77 +--------------
>  .../devicetree/bindings/media/s5p-mfc.yaml    | 98 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 76 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/s5p-mfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.txt b/Documentation/devicetree/bindings/media/s5p-mfc.txt
> index aa54c8159d9f..f00241ed407f 100644
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
> +This file has moved to s5p-mfc.yaml

Instead entirely remove the file.

> diff --git a/Documentation/devicetree/bindings/media/s5p-mfc.yaml b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> new file mode 100644
> index 000000000000..fff7c7e0d575
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/s5p-mfc.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/s5p-mfc.yaml#

Let's convert the name as well, so "samsung,s5p-mfc.yaml"

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Multi Format Codec (MFC)
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab@kernel.org>
> +  - Rob Herring <robh+dt@kernel.org>
> +  - Mark Rutland <mark.rutland@arm.com>
> +  - Smitha T Murthy <smitha.t@samsung.com>

Only people with access to HW, so you can put here Marek and yourself.

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

Ugh, how MFCv10 appeared here? Since 5433 we moved from versions to Soc
compatibles as recommended... eh, please follow this convention, don't
reverse it to other way.

I propose to deprecated this in next patch and instead use SoC-based
compatible.

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Phandle to MFC IP clock.

Here and other places: s/Phandle//
Instead describe what is it, e.g. "MFC IP clock"


> +    maxItems: 1
> +
> +  clock-names:
> +    description:
> +      Must contain clock name (mfc) matching phandle in clocks
> +      property.

Skip description, its obvious. Instead list the items.

> +    maxItems: 1

No need, list the items.

> +
> +  interrupts:
> +    description:
> +      MFC interrupt number to the CPU.

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  memory-region:
> +    description:
> +      From reserved memory binding phandles to two reserved
> +      memory regions, first is for "left" mfc memory bus interfaces,
> +      second if for the "right" mfc memory bus, used when no SYSMMU
> +      support is available; used only by MFC v5 present in Exynos4 SoCs.
> +    minItems: 1
> +    maxItems: 2

This needs allOf:if:then restricting two items to specific compatible.

> +
> +  iommus:
> +    description:
> +      Include the IOMMU domain MFC belong to.

Skip description, it's obvious.

> +    maxItems: 2
> +

What happened to power domains? You also removed them from the
example... Does this pass dtbs_check?

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - iommus
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        /* Reserved memory specific DT entry for given board */
> +        reserved-memory {

Wrong indentation. Four spaces. See example schema.

> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +                ranges;
> +
> +                mfc_left: region@84000000 {
> +                        compatible = "shared-dma-pool";
> +                        no-map;
> +                        reg = <0x84000000 0x800000>;
> +                };
> +
> +                mfc_right: region@A9000000 {

lower case hex addresses, everywhere.

> +                        compatible = "shared-dma-pool";
> +                        no-map;
> +                        reg = <0xA9000000 0x800000>;
> +                };
> +        };
> +
> +        mfc_0: mfc0@12880000 {

Generic node names, so mfc.

> +                compatible = "samsung,mfc-v12";

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Be sure to test your bindings before sending them.

> +                reg = <0x12880000 0x10000>;
> +                clock-names = "mfc";
> +                interrupts = <0 137 4>;

Use interrupt defines.

> +                clocks = <&clock_mfc 1>;
> +                memory-region = <&mfc_left>, <&mfc_right>;
> +                /* If IOMMU is present use below instead of memory-region property */
> +                iommus = <&smmu_isp 0x1000 0x0>, <&smmu_isp 0x1400 0x0>;
> +        };


Best regards,
Krzysztof
