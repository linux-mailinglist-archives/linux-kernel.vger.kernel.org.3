Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E919054EC30
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378834AbiFPVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379048AbiFPVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:09:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F9E60B85
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:09:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e11so2519180pfj.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zhpZ+GjXampjNpe+tQocPabcYpHKe+t5MxtxSoAd/gk=;
        b=c/mnodrbMqdEEZtK4ydiC51al8PB7S6Cw/2mpPGAnndPSmu2+WM1Ll5DPr4l2TlOQS
         nqxcxIqTkzcsEO3ksP2QW/htFKuizhTMRc2FmleMjdWDxtyteBBiNyVAp83VADdUQn3X
         G/hCcE8fhF8THykoNLr9837Zpz64pICy6pXDGznnY2WIMG93RYJ0Cm2F5tQqmGHz/ew2
         yqiJMi3apylM6BgwpGCG/sfJ83FiC5EaO/9MBOx8Ti2RX8TKdRByxdJEyDRw3bdyXr/x
         BWCtUHy2R46F/HtRQqol9dJaSnsHI9AI05hVUXfj35TZbFtNdUodT4OBz0pviOs5GdPx
         gbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zhpZ+GjXampjNpe+tQocPabcYpHKe+t5MxtxSoAd/gk=;
        b=z6KkUO/iEr/LT3vXIDGzWcKwpchmifJ3Mk4/UEuj4x6PLIx0pdYaeEnn8CheTXwiNE
         H4tvsGo9m1nS/p0KXyaIf1Mis+O6Ud+oXmVzBR9eigtassmx664kxIxBIxU5vza57Oiu
         yBm9w5OenxYAtiZMSmkhNYdrT/Gc3iCHYg6BVYSnkmSyIxQwD8bhXqE5LQknxAuvB040
         l5zXw+4nOZ1/TYThNRXKdB0bh2IvnroyqaKfRDTM5AJj0al9XMYd6LoXQukZj1vuS2ej
         XYh2aDP7FeIqKzGg1oEgnRnWdwk7wgncGBV9/W/a5M3HZl+CQohXg7uwkmKjZ2OsmtWm
         OLPw==
X-Gm-Message-State: AJIora+A2oiEY12i0QJJhxuJrWChkjKPWSCiR5RhT8PYj2enIR9ytgmU
        Wh+JZUJZTK6uzXQPKje2JrhZ5g==
X-Google-Smtp-Source: AGRyM1tDcKhZpWC6x4Z99cOnzfLaqqe5JLXzIahj3Uu4wTqFJmQBE7GebAoPUSjcUlojxk8MyILZ2Q==
X-Received: by 2002:a63:3c3:0:b0:3fc:5864:7412 with SMTP id 186-20020a6303c3000000b003fc58647412mr6068104pgd.138.1655413763706;
        Thu, 16 Jun 2022 14:09:23 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a4bc200b001e2ebcce5d5sm1929001pjl.37.2022.06.16.14.09.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 14:09:23 -0700 (PDT)
Message-ID: <91e9e3af-8208-7535-1864-08744f934593@linaro.org>
Date:   Thu, 16 Jun 2022 14:09:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 03/15] dt-bindings: leds: mt6370: Add Mediatek mt6370
 current sink type LED indicator
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, matthias.bgg@gmail.com, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
 <20220613111146.25221-4-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220613111146.25221-4-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/2022 04:11, ChiaEn Wu wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add Mediatek mt6370 current sink type LED indicator binding documentation.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../leds/mediatek,mt6370-indicator.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> new file mode 100644
> index 000000000000..42b96c8047a3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/mediatek,mt6370-indicator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MT6370 PMIC from MediaTek Integrated.
> +
> +maintainers:
> +  - Alice Chen <alice_chen@richtek.com>
> +
> +description: |
> +  This module is part of the MT6370 MFD device.
> +  Add MT6370 LED driver include 4-channel RGB LED support Register/PWM/Breath Mode
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt6370-indicator
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^(multi-)?led@[0-3]$":

If this is multi-led, then you should reference
/schemas/leds/leds-pwm-multicolor.yaml

See other examples using it.



Best regards,
Krzysztof
