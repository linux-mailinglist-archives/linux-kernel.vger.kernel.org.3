Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E988F5786EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiGRQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:04:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499A0DE85;
        Mon, 18 Jul 2022 09:04:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a5so17716640wrx.12;
        Mon, 18 Jul 2022 09:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DQCf01R8FDGSi3ujxTj9GGbfmIZAuUcf4db7o6FQwNs=;
        b=lK8n/Z7kwUd8iVx3jExD8J3JH9ui1a0qLDRuUSwgT79sJHtXpllECNqoyPiue8mBAK
         h5H48oY1A/CgoSjIOm3K0kDCxNvdQCR3H3SzKfcmBGPssYZU9EGPyeMmMyGqkjY60YQu
         /ZIMGEZxAFdLHJENR56VZJfrpC28i2dnF2YkdZ7utsOaCFHb+xTnWBP1XZaZctbW5oJj
         lTqTiFhxgbg0QuUhcUz5/z5TRKqFG43AnRrYvnESgzGeDpBete2+DZ+TnfuaeAv+GJNv
         u/rjoEBtOvmWNWDE2HYQSwhslK+YK37BSj00GnHVegxPsFPxI2zWqtHHGyPyJAx6OTuI
         Ebkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DQCf01R8FDGSi3ujxTj9GGbfmIZAuUcf4db7o6FQwNs=;
        b=K2UeVyZJ6X1bvlLi+Nai/7xWaubVxyJtZNV/0v5bFUx0yEmaYY8aUpD8O4gFxTuqS/
         ltoT+IofLKuprZjHz8UgAWwPaomRQ9ihkFIE28KvOBP2ozfKpk7U7Vy3MjBAQldvu84k
         2Bec8ml8sBCKiAPMXPDoE2SoVDbjgGBxUc/1wEYz74CGimCWs9iOg53lR4XBSETxOZdf
         Rm1ZpgPC10fliYuFZ8jYXU5pJBabp4yX9+KqCJ7dDg8K8Be8v2BAbHI3P9dZs+3PnzPI
         xYRAV1f5L0bjVTGEbiPPgRpTFJ71Kc/kSA1B68Jjt5Eg9odur7vPo0cNcu7rnMAzO8gg
         Go1A==
X-Gm-Message-State: AJIora8eD03VbU921L4SDN+66lRz6C+uhozE/mYmrMwSvTlC7yEo6u9I
        JOkqaVzRvjADN2tdBxZSo1U=
X-Google-Smtp-Source: AGRyM1uGmhdJOb6JH9Z96ICgqDkOVFee8KCCyYuj0S2hemKTbLOSjnvczlEZxSE1rDCAU4uWzvZ4+A==
X-Received: by 2002:a5d:584b:0:b0:21d:bd2e:42a7 with SMTP id i11-20020a5d584b000000b0021dbd2e42a7mr22311759wrf.192.1658160267673;
        Mon, 18 Jul 2022 09:04:27 -0700 (PDT)
Received: from [192.168.0.14] ([37.223.147.254])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a2d0f0ccaesm20527536wmq.34.2022.07.18.09.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:04:26 -0700 (PDT)
Message-ID: <4fcc64d9-060e-6568-6eb7-d74c520593b0@gmail.com>
Date:   Mon, 18 Jul 2022 18:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: watchdog: mediatek: Convert binding
 to YAML
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220714125044.20403-1-allen-kh.cheng@mediatek.com>
 <20220714125044.20403-2-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220714125044.20403-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2022 14:50, Allen-KH Cheng wrote:
> Convert Mediatek watchdog devicetree binding to YAML.
> 

You are also fixing the fallback compatible here.

> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   .../bindings/watchdog/mediatek,wdt.yaml       | 64 +++++++++++++++++++
>   .../devicetree/bindings/watchdog/mtk-wdt.txt  | 42 ------------
>   2 files changed, 64 insertions(+), 42 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
> new file mode 100644
> index 000000000000..cb90d89b9f5d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,wdt.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/mediatek,wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediatTek SoCs Watchdog timer
> +
> +maintainers:
> +  - Runyang Chen <runyang.chen@mediatek.com>
> +
> +allOf:
> +  - $ref: "watchdog.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - mediatek,mt2712-wdt
> +          - mediatek,mt6589-wdt
> +          - mediatek,mt7986-wdt
> +          - mediatek,mt8183-wdt
> +          - mediatek,mt8186-wdt
> +          - mediatek,mt8192-wdt
> +          - mediatek,mt8195-wdt
> +      - items:
> +          - enum:
> +              - mediatek,mt2701-wdt

missing mt6582-wdt, mediatek,mt7623-wdt and more.
I'd advise split this up in two patches. One fixing the fallback compatible and 
the second one converting to yaml (or the other way round). In any case make 
sure you have all compatibles in the end.

Regards,
Matthias

> +              - mediatek,mt6797-wdt
> +              - mediatek,mt7622-wdt
> +              - mediatek,mt8516-wdt
> +              - mediatek,mt8173-wdt
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
> +  mediatek,disable-extrst:
> +    type: boolean
> +    description: disable send output reset signal
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    watchdog@10007000 {
> +        compatible = "mediatek,mt8186-wdt";
> +        reg = <0x10007000 0x100>;
> +        mediatek,disable-extrst;
> +        #reset-cells = <1>;
> +    };
> +
> +...
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
