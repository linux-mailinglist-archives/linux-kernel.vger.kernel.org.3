Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FC95A7E88
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiHaNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiHaNTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:19:19 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EEAA6C6F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:19:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id by6so14587197ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VOBNvNEcm28X62PTg/CF9pJa/z/E16cJ/tuYHCwsVHw=;
        b=pT6AhCh6n6Xasz7vNDLotXEmBAw+oJ1CKmdfgDQm9ZBlGtrqQXx9gLVewYah9Pmxmp
         tV6T+Ovd6bLnlw1EJpvcbzKptfROsBkreCrkpa3WVblUQQpps0JETL8htw9wLkKUpc7i
         /Oqh2nm5OmACAeJJw1obIXHz5UYJsqCMAXa+XLNo/fbuO85WxVsoVxzkz6UV2UkSwdpa
         wPe6VODcoWSxI/jvnzJ6wVImXeQeNhtPUYK1q/g07o0kpX/VclDUnAzc5hatZ0ER1tBi
         xIu+AQIn1JmBfd3Rwl3AIbYOXRaEV9Xh2+WnMJnJFnAHTa2Ip4eIsaV3KMUwUp75SSKB
         ZMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VOBNvNEcm28X62PTg/CF9pJa/z/E16cJ/tuYHCwsVHw=;
        b=jNnx7SScRnxnJMv+jEVbi7sV84skkUOS13xvAgHEHaSUwI/Bq59Ku60hru4qFB7WsB
         GqVu8WHynEK/vLn0yQg/pTo8INjbO7if08SlN+SBTAlkINzcJuS6EKdufWiE3He9qoCf
         bNK9+Jr+7YBO/Gztf1fwmPRYDJ52XV1xabk6zeQOucdKS2luzJ0bEda0QNy3Q8b5oHMr
         Pz5VO9KScG+SdjaV14CgvygHPpOqD+KUFXIKjQORx+q63K5Nh7qOzZhnbV6e+5YJBWzf
         q5ybExHJFW/hJeHsefeekIELDJadBYXe3TzKnfjIFT7hO4MLjYCpaOaIewahKk91YVe4
         gdRg==
X-Gm-Message-State: ACgBeo1FA3uVxIIQx0FsWYI0URSYzsh7Y/rYGUwh50FXmLmFda780HXP
        nbtqsayU7F95WMAPvHbVQNxPTQ==
X-Google-Smtp-Source: AA6agR4WYZ7pd70NhqYxjDkiGW0SaDYDy7UCUvcZ3XGyB7sTVm98QlYdsBvghW9mhMi/tJN3OLaYZA==
X-Received: by 2002:a05:651c:179c:b0:261:8fbe:b729 with SMTP id bn28-20020a05651c179c00b002618fbeb729mr8540389ljb.114.1661951955793;
        Wed, 31 Aug 2022 06:19:15 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id y9-20020a196409000000b0048af749c060sm1985847lfb.157.2022.08.31.06.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:19:15 -0700 (PDT)
Message-ID: <b1296c37-5283-81f7-1939-7ea20e1f4d0d@linaro.org>
Date:   Wed, 31 Aug 2022 16:19:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
 <20220831124850.7748-3-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831124850.7748-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 15:48, Johnson Wang wrote:
> Add the new binding documentation for MediaTek frequency hopping
> and spread spectrum clocking control.
> 
> Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,fhctl.yaml | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> new file mode 100644
> index 000000000000..c5d76410538b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,fhctl.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,fhctl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek frequency hopping and spread spectrum clocking control
> +
> +maintainers:
> +  - Edward-JW Yang <edward-jw.yang@mediatek.com>
> +
> +description: |
> +  Frequency hopping control (FHCTL) is a piece of hardware that control
> +  some PLLs to adopt "hopping" mechanism to adjust their frequency.
> +  Spread spectrum clocking (SSC) is another function provided by this hardware.
> +
> +properties:
> +  compatible:
> +    const: mediatek,fhctl

You need SoC/device specific compatibles. Preferably only SoC specific,
without generic fallback, unless you can guarantee (while representing
MediaTek), that generic fallback will cover all of their SoCs?

> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,hopping-ssc-percents:
> +    description: |
> +      Determine the enablement of frequency hopping feature and the percentage
> +      of spread spectrum clocking for PLLs.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description: PLL id that is expected to enable frequency hopping.

So the clocks are indices from some specific, yet unnamed
clock-controller? This feels hacky. You should rather take here clock
phandles (1) or integrate it into specific clock controller (2). The
reason is that either your device does something on top of existing
clocks (option 1, thus it takes clock as inputs) or it modifies existing
clocks (option 2, thus it is integral part of clock-controller).


Best regards,
Krzysztof
