Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA89524D08
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353846AbiELMgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349758AbiELMgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:36:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6593AA49
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:36:18 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d6so6066811ede.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gTmt/B/w9KdHTf7QYSgx9Lzcr6J8CV4S/KB3jkF6w4w=;
        b=Asda87qLifEtE+BHYL3gQi6+Z17GE80dpOp91GVhNBBOXTsihm20fqchNSL0Y6Z1du
         qwcZq7hGb35GFlUrEMKbb7FTEt1NLj3bjKEy7c5NGxgSMIx6YzXQtYuZMbgBx7NSTX7e
         mrrfVfsXNBRVMH/yQkQL06zxGkAwaP6vri5afckZU9UCzwUT8JmrYnK0Xk+Pcz055DqN
         Ohf8ChHCwnnyokcQu1GrnnfL0LqKxxYhF9D0GaP+7Nkhx0U35ZWjTQLGgoL45y66d6lo
         MLLaon/ELqKxQBLU2X39oEj+FAsjj+tINlNgT/Zf0DV7o984uYiPktQsjqkZ0XOOeOii
         lHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gTmt/B/w9KdHTf7QYSgx9Lzcr6J8CV4S/KB3jkF6w4w=;
        b=KJihQLu8/9avy+KTe5g7Iyk79+zl/IvOZF41WKKeQaZcBDBULoUf+7cULNc1q1cAXQ
         ed6xAurDRTTws+6IPlga8X4StMx+QXzdOvfEBr4+Z8kjeLK4U+XTw4r8Lfmbu2xd5Gdy
         TCvaR/1b/3H/+6VCvnOP0skzAtI8L0wMMwlaeWy7sw3jLmKgVuGfLlYfh4zeALkP2afc
         1vXvRiTo8xwbeBYt3BEpL8ats9e50PYWsoNYIK0+ZJ1f6IoTdU1UQe2+c/sbQRQozO1+
         AhORU1h8hAwxpTSZOtJkaqkuCxq0QV4Rt+m4V/baHrc45z+/dDTiHgdgwynrNxvHU92v
         +qmA==
X-Gm-Message-State: AOAM532bSvAxm21WyBAET1zRG7dsWOezmTb+QJ9aIN3ok7AS9yTZv166
        /z9LIVRCcUqFcI6BHCSXTftRvA==
X-Google-Smtp-Source: ABdhPJzrnXfJjNzkVC6pBtLHiWz195wT5TQ3D+wYQ2m7mMwooiP7f7xIWg4AUkiO2ihMNDt9xgucMA==
X-Received: by 2002:aa7:c1d0:0:b0:428:b439:99f5 with SMTP id d16-20020aa7c1d0000000b00428b43999f5mr15515971edp.316.1652358977231;
        Thu, 12 May 2022 05:36:17 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g6-20020a50d0c6000000b0042617ba63aasm2460191edf.52.2022.05.12.05.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 05:36:16 -0700 (PDT)
Message-ID: <41cc4506-57be-a831-57d5-e539e8a95610@linaro.org>
Date:   Thu, 12 May 2022 14:36:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 02/11] dt-bindings: marvell: convert Armada 37xx
 compatibles to YAML
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Andrew Lunn <andrew@lunn.ch>,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
 <20220510124929.91000-2-robert.marko@sartura.hr>
 <0815f581-ca5b-6fb6-a59e-f5d0a3686caa@linaro.org>
 <CA+HBbNFnXoEghSdhTYoC-VvCMkiEuuee9p8SuNGubYCeLWoYfA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+HBbNFnXoEghSdhTYoC-VvCMkiEuuee9p8SuNGubYCeLWoYfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 14:26, Robert Marko wrote:
> On Wed, May 11, 2022 at 6:52 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/05/2022 14:49, Robert Marko wrote:
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> -
>>> - - compatible: must contain "cznic,turris-mox"
>>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
>>> new file mode 100644
>>> index 000000000000..3f41ef2c6f3e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
>>> @@ -0,0 +1,50 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/arm/marvell/armada-37xx.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Marvell Armada 37xx Platforms Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Robert Marko <robert.marko@sartura.hr>
>>> +
>>> +properties:
>>> +  $nodename:
>>> +    const: '/'
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: Armada 3710 SoC
>>> +        items:
>>> +          - const: marvell,armada3710
>>
>> This does not look correct. The SoC usually cannot be used by itself,
>> it's always a part of some product, SoM, board.
> 
> Hi Krzysztof,
> Currently, there are no Armada 3710 boards present in Linux, so I just
> put the SoC compatible.
> If that is not appropriate, I can drop it.

Yes, please drop it.

It seems several Marvel boards and bindings use wrong convention for
compatibles. We discussed it here:
https://lore.kernel.org/all/1ed03960-77f6-1a9e-2378-07a6c51f42f7@linaro.org/
AC5 and CN9130 have the same wrong patterns.

> 
>>
>>> +
>>> +      - description: Armada 3720 SoC
>>> +        items:
>>> +          - enum:
>>> +              - marvell,armada-3720-db
>>> +              - globalscale,espressobin
>>> +              - cznic,turris-mox
>>> +              - methode,udpu
>>
>> Order by name.
> Will fixup in v3.
> 
>>
>>> +          - const: marvell,armada3720
>>> +          - const: marvell,armada3710
>>> +
>>> +      - description: Globalscale Espressobin boards
>>> +        items:
>>> +          - enum:
>>> +              - globalscale,espressobin-emmc
>>> +              - globalscale,espressobin-ultra
>>> +              - globalscale,espressobin-v7
>>> +          - const: globalscale,espressobin
>>> +          - const: marvell,armada3720
>>> +          - const: marvell,armada3710
> Do these const compatibles also need to be in alphabetical ordering,
> cause I ported them as they are meant to be used with the board and
> then 3720 compatibles being in front of 3710 one as required by the current
> text bindings.

Entries in enum should be ordered alphabetically. Then the entire set "-
description: Globalscale Espressobin boards" should have some logical
order, not necessarily by name.

Anyway this is not a requirement but rather suggestion because having
things ordered reduces amount of conflicts when two people add new
boards (because they add it not at the end, but somewhere in the middle
following some order).


Best regards,
Krzysztof
