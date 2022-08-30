Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF78B5A6B23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3Rrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiH3RrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:47:17 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111FD2BB06
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:43:32 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w19so9167460ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LNOYEau6NCyMFt2UF/kOrdVjy55MOyCZeOBAl0rr6hw=;
        b=JD7T2lrVvZF5GuK6KGickAQthyTSo1wl9nmJAy/h3ZXsePGnpeOzxDZhY5lljse7bg
         06oxnhr/vVv/IfWFBXuv+pBCkF3YH9FQJ93IRcWSueYyfagxPFrKrWLTQxMNB3nqcwyZ
         Bg6PD0m0ckgnKVzvYMVvoSEWBteYmvIL0HupVOodxYjnE2DSrTZEIJQeOAmMni9X7Ec7
         KkzX7xrNAE6S/SzVhw9jmyEfEpMKzuul+iCIXLBk0BlkjYcJhUXi/HbUF/KEFVxpBD+g
         Q0iM1Enws7ViTWcia6GQH7FGqeOnB43qwPl54FvzOZ1pDPd4ffTsY+n4atQQILBSYknj
         C5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LNOYEau6NCyMFt2UF/kOrdVjy55MOyCZeOBAl0rr6hw=;
        b=nsNIvIBndnE8tEPwb9Kh/RfekBHZcAQ0Ga0zB3x0Ql3iUkkCwxiWUpm/SS2U+ICI+e
         +VsqHP6Xe92FgFzA/rwIRuoqGNb8ABzy//EcinA5yK9QTK4iVXQbH3rqgVHdoxUt9y+v
         E44Yjo1qEifw7vWfToeASDHHXtcy4uaISQWKOWd7PPuyln3PX05EZMHUHrzYF9pD9YU4
         8vDCZ1szLptowxoCyQuYF91temih20OpwPBCbJgKKN/FHLSviXRTOapmSbxRw/uGpl98
         ia/WhtzCf6ia/PF18jEtZqLgeF9ggAFQqscPX8WoU1DedEgKcxWS1gFBRlD2VDIUR04+
         /meQ==
X-Gm-Message-State: ACgBeo2cxSonGGyYlMY67VxWuWdRFmQ6CekxR4Sih0y9wjz+MYm4JkTD
        EK/Lpn7axFdfd2pPZ2EGhz3EMA==
X-Google-Smtp-Source: AA6agR4+iZSFr53G4vs26EmPBaP0Tw6RUL9/GjW9nDcQMmgpq7SSZtskFMm/hYnqoKkDPU6gjFG6NA==
X-Received: by 2002:a2e:a403:0:b0:267:7e5:a5ef with SMTP id p3-20020a2ea403000000b0026707e5a5efmr1555985ljn.93.1661881092264;
        Tue, 30 Aug 2022 10:38:12 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id e15-20020a05651c038f00b00264bb2351e8sm446663ljp.7.2022.08.30.10.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 10:38:11 -0700 (PDT)
Message-ID: <d1f49935-b465-7495-d345-f35bf4dea9f9@linaro.org>
Date:   Tue, 30 Aug 2022 20:38:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/7] dt-bindings: phy: mediatek,tphy: add property to
 set pre-emphasis
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220829080830.5378-1-chunfeng.yun@mediatek.com>
 <20220829080830.5378-2-chunfeng.yun@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829080830.5378-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2022 11:08, Chunfeng Yun wrote:
> Add a property to set usb2 phy's pre-emphasis, which used to widen eye
> opening and boost eye swing.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: Add more description suggested by Krzysztof
> ---
>  .../devicetree/bindings/phy/mediatek,tphy.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index 848edfb1f677..e0754fb44451 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -219,6 +219,16 @@ patternProperties:
>          minimum: 1
>          maximum: 15
>  
> +      mediatek,pre-emphasis:
> +        description:
> +          The level of pre-emphasis which used to widen the eye opening and
> +          boost eye swing, the unit step is about 4.16% increment; e.g. the
> +          level 1 means amplitude increases about 4.16%, the level 2 is about
> +          8.3% etc. (U2 phy)
> +        $ref: /schemas/types.yaml#/definitions/uint32

As I proposed - use instead common units. Since only three values are
allowed - make it an enum. These bindings are expected to be
usable/applicable on several devices, so units, not register values
which can change between devices, are the proper and reliable way to
describe a feature.


Best regards,
Krzysztof
