Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940F350BBFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449251AbiDVPsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449378AbiDVPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:47:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE625EBDB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:44:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so17196771ejd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 08:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JemFIsNtCjKL4LPEQBY/hGFmz6ljVMLTFme29Py2nSY=;
        b=kE/4yTd0BeJARbm77TZxpuVTgL9v+x0jEMOVZU0iv8mB4Q/g9GO6hh5+am0qj/rd/t
         u+A52haGAJ/7nt9iC+R4z2XOc/1dpqW3HlNeU65zPR8tscx47q6/cYR3Z/1HkOljee9v
         DCSYOZ88FcIQlkkqV84NK7eQuH9+MiiPF9mlTLCHzkOe5LU8efKWDR9PmW71uAyKYS5R
         EZLNGpjRSttXrn5kv6lyCkk/2jGGYWvN5oqmjFSnZv3JRmbnx692DdN2oUN7TWo2g/Op
         IaUxLeYJ3/Yx1wZ104lFif6x6UO2fQ9tXUQ3C6xP3XuBabvHOw+S7xI3FQ4SWLmPnrdP
         oYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JemFIsNtCjKL4LPEQBY/hGFmz6ljVMLTFme29Py2nSY=;
        b=14SXwo6yLbWz7kwBY7sYp+V5uf4/IvCRxQmCYaBinqNYP4k1z6UvBTeIZbgIk47INN
         vzu5iWhBUElVv8EaVkakAirSG9Z7+BObNHeqjOV6vj8pyj+w5JscLCsJWkTmcPsZ2bvW
         CxSemSR5tXA6aVBenIgZmUmOsea+hSD22vp+fwNniloO9SkEkHMw5H2eGCbeTJw2T6XL
         nChT4qh4MVFRYwKP985GLXgD1hWxrdILwI/slvHZ8YOj5VjfyRcbQ15jBLgE7sYJ7ThN
         GwMraTbvJ3e3+Mi8vOUmDJU72On0j73jln7kb8qdRdi/0+AZ2iPJJjeH3YOiQKMD3YZ4
         oODQ==
X-Gm-Message-State: AOAM531UBVq70w9dCVLn/A/TMD9JrF1SSB0IRPkGrZo95fW7X4zyCm8c
        vi6UtdyJrc/G5MvBcQNgKpfPvQ==
X-Google-Smtp-Source: ABdhPJxuA+3Y8AE3ukYq9N7qqdw5yx7eXG2giExj/lpkeyAWZqsokfAbfxqRUhRzv4xOHYacE1Cwuw==
X-Received: by 2002:a17:907:3f9e:b0:6f2:b3d8:63c0 with SMTP id hr30-20020a1709073f9e00b006f2b3d863c0mr2938068ejc.86.1650642263097;
        Fri, 22 Apr 2022 08:44:23 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s2-20020a1709066c8200b006e4e1b1f875sm866663ejr.199.2022.04.22.08.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:44:22 -0700 (PDT)
Message-ID: <e2e4ead0-d8eb-1302-93e9-f330807d811e@linaro.org>
Date:   Fri, 22 Apr 2022 17:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: mediatek: Convert binding to
 YAML
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com, Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
References: <20220422121017.23920-1-allen-kh.cheng@mediatek.com>
 <20220422121017.23920-3-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422121017.23920-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 14:10, Allen-KH Cheng wrote:
> Convert Mediatek watchdog devicetree binding to YAML.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ----------
>  .../devicetree/bindings/watchdog/mtk-wdt.yaml | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> deleted file mode 100644
> index 762c62e428ef..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Mediatek SoCs Watchdog timer
> -
> -The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
> -before the expiry.
> -
> -Required properties:
> -
> -- compatible should contain:
> -	"mediatek,mt2701-wdt", "mediatek,mt6589-wdt": for MT2701
> -	"mediatek,mt2712-wdt": for MT2712
> -	"mediatek,mt6582-wdt", "mediatek,mt6589-wdt": for MT6582
> -	"mediatek,mt6589-wdt": for MT6589
> -	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
> -	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> -	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> -	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> -	"mediatek,mt7986-wdt", "mediatek,mt6589-wdt": for MT7986
> -	"mediatek,mt8183-wdt": for MT8183
> -	"mediatek,mt8186-wdt", "mediatek,mt6589-wdt": for MT8186
> -	"mediatek,mt8516-wdt", "mediatek,mt6589-wdt": for MT8516
> -	"mediatek,mt8192-wdt": for MT8192
> -	"mediatek,mt8195-wdt", "mediatek,mt6589-wdt": for MT8195
> -
> -- reg : Specifies base physical address and size of the registers.
> -
> -Optional properties:
> -- mediatek,disable-extrst: disable send output reset signal
> -- interrupts: Watchdog pre-timeout (bark) interrupt.
> -- timeout-sec: contains the watchdog timeout in seconds.
> -- #reset-cells: Should be 1.
> -
> -Example:
> -
> -watchdog: watchdog@10007000 {
> -	compatible = "mediatek,mt8183-wdt",
> -		     "mediatek,mt6589-wdt";
> -	mediatek,disable-extrst;
> -	reg = <0 0x10007000 0 0x100>;
> -	interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;
> -	timeout-sec = <10>;
> -	#reset-cells = <1>;
> -};
> diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> new file mode 100644
> index 000000000000..5788617027c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/mtk-wdt.yaml#

File name: mtk,wdt.yaml

I assume all future MediaTek watchdogs (even these unpublished and
developed in some years) will fit into this schema. :) If not, then
maybe better to name the file by the compatible... but it's not a must.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek SoCs Watchdog timer
> +
> +maintainers:
> +  - Runyang Chen <runyang.chen@mediatek.com>
> +  - Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> +
> +description: |+
> +  The watchdog supports a pre-timeout interrupt that fires timeout-sec/2
> +  before the expiry.
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: mediatek,mt2712-wdt
> +      - const: mediatek,mt6589-wdt
> +      - const: mediatek,mt8183-wdt
> +      - const: mediatek,mt8192-wdt

All these four entries should be an enum.

> +
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-wdt
> +              - mediatek,mt6582-wdt
> +              - mediatek,mt6797-wdt
> +              - mediatek,mt7622-wdt
> +              - mediatek,mt7623-wdt
> +              - mediatek,mt7629-wdt
> +              - mediatek,mt7986-wdt
> +              - mediatek,mt8173-wdt
> +              - mediatek,mt8183-wdt
> +              - mediatek,mt8186-wdt
> +              - mediatek,mt8192-wdt
> +              - mediatek,mt8195-wdt
> +              - mediatek,mt8516-wdt
> +          - const: mediatek,mt6589-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  timeout-sec: true

You do not need this, it's coming from watchdog schema.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    watchdog@10007000 {
> +        compatible = "mediatek,mt8183-wdt",
> +                     "mediatek,mt6589-wdt";
> +        mediatek,disable-extrst;

Did you test your bindings? Does not look like. Please run
dt_binding_check (see writing-schema for instructions).

> +        reg = <0x10007000 0x100>;
> +        interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>;

Wrong interrupt flag.

> +        timeout-sec = <10>;
> +        #reset-cells = <1>;
> +    };
> +
> +...


Best regards,
Krzysztof
