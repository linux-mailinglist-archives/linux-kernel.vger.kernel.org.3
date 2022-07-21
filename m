Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC8857C757
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiGUJQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiGUJQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:16:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA000735A2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:16:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r9so1775548lfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NX01PXec4oCp0RNFOcGC2D4osWkcf/OjSXNrxmif0H4=;
        b=m5R8uFVK4YrCrVYE4rVc+jXXO2vKg46lp/urdVrQ8f2wGi+2ZdgHF6TxAk+Z1H1NL5
         s5eRagjcZrTKUvY8orKP+y3wIkuE/LB4brKZg2bUltf6tKqn942slGDC+InNt0FGfGdi
         +ObIujImekzOuhEK9oi8ajmUpgs8Yhlu93R3fluCYHIDeOy06dXMo8VhUh15wpjHymNc
         1avfgz0EYxZZGdYrIx1yMHVfpMar52gvGJN17PkyjYwqOoteMsff2wOlNGidyR8TReIB
         1QBrFPPJ8i7TxaXZlOuOuK9m2555n+BWH/vjXDNV6vNdhPpnqAqGFqpslYgyQHxrosGW
         JM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NX01PXec4oCp0RNFOcGC2D4osWkcf/OjSXNrxmif0H4=;
        b=JsZ2WNRE1JQFHA7UCiZg3MRg/vGWg88uDo6aUU0yN7+Lb4WizHdADvGZgwqU1kQvAc
         Z8iVpYDyUrwnH4zMRrR+iJYXtoOc8Cwf+kWo9YZOfOkcHjZjqdfLbbdPhGfysO4uDYEl
         Raz8ibz9ZUpXCPrsCcwQVQRxj9rKWTWQqDVXW/eZaUeRX36dGQTyi3sH8Dvs5m3JR1B1
         fzyWIoSFuxGCQWxReJ//XVeSNeuD2jCaN/56SBCmWnQYnahxEAQq1vo4lHId14LAGhhd
         5fojaLNfAz51zZ+IXjfl7tvpZdAAUQZMrPA0kzXTjNdYLQfunR16co/togFpRVMdZTEC
         Z+Ow==
X-Gm-Message-State: AJIora8TIUfCkI5URFqHcRZXPgh9bQUU6n3s6hANW3lrSjq4oDz7+roO
        WOByU9i2gfT+z9BP1QVJjdFZ1Q==
X-Google-Smtp-Source: AGRyM1tZG8v/X5Cvk5Swz75Z3HdFevHIeUTVvTwWLJIDvqUWpXwC4324umZdPzad973iHEQ3WAhL+w==
X-Received: by 2002:a05:6512:3c9f:b0:48a:2c32:e22c with SMTP id h31-20020a0565123c9f00b0048a2c32e22cmr14987643lfv.356.1658394968135;
        Thu, 21 Jul 2022 02:16:08 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s1-20020a056512202100b0047fac0f34absm318272lfs.196.2022.07.21.02.16.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:16:06 -0700 (PDT)
Message-ID: <734ed3cf-1461-6067-e718-663ca4be47a6@linaro.org>
Date:   Thu, 21 Jul 2022 11:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/6] dt-bindings: mediatek,mt6779-keypad: use
 unevaluatedProperties
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
References: <20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com>
 <20220720-mt8183-keypad-v1-2-ef9fc29dbff4@baylibre.com>
 <e1ec8511-d1dd-faa5-031f-50c4e55062cd@linaro.org>
 <874jzaj0m5.fsf@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <874jzaj0m5.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 11:06, Mattijs Korpershoek wrote:
> On Wed, Jul 20, 2022 at 19:14, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 20/07/2022 16:48, Mattijs Korpershoek wrote:
>>> writing-bindings.rst states:
>>>> - If schema includes other schema (e.g. /schemas/i2c/i2c-controller.yaml) use
>>>>   "unevaluatedProperties:false". In other cases, usually use
>>>>   "additionalProperties:false".
>>>
>>> mt6779-keypad includes matrix-keymap.yaml so replace additionalProperties:false
>>> by unevaluatedProperties:false.
>>
>> This is not sufficient explanation. You now allow all properties from
>> matrix-keymap.yaml, which might be desired or might be not (e.g. they
>> are not valid for this device). Please investigate it and mention the
>> outcome.
> 
> Hi Krzysztof,
> 
> Thank you for your prompt review.
> 
> In mt6779_keypad_pdrv_probe(), we call
> * matrix_keypad_parse_properties() which requires keypad,num-rows and keypad,num-cols.
> * matrix_keypad_build_keymap() which uses linux,keymap
> 
> Therefore, all properties from matrix-keymap.yaml are
> required by the mt6779-keypad 
Better to mention the device, not driver.

> 
> In v2, I will add the above justification and also add all 3 properties
> in the "required" list.
> 
> Initially, I did not do this because from a dts/code perspective it seemed
> interesting to split out SoC specific keyboard node vs board specific key configuration:
> * [PATCH v1 5/6] arm64: dts: mediatek: mt8183: add keyboard node # SoC specific
> * [PATCH v1 6/6] arm64: dts: mediatek: mt8183-pumpkin: add keypad support # board specific
> 
> What would be the recommend approach for above?
> I see at least 2:
> * "move the whole keyboard node into the board file (mt8183-pumpkin.dts)" even if it generates
>   duplication between boards using the same SoC.
> * "add a "dummy keymap,row,cols" properties in the soc node which can be overriden in board file.
>   For example, use rows and cols = 0 which would have the driver early exit.
> 
SoC DTSI should have only SoC properties. The keyboard module is part of
SoC. The keys and how it is wired to them - not.

Best regards,
Krzysztof
