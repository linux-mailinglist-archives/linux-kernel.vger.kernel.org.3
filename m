Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483934E6F06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354282AbiCYHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbiCYHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:38:33 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68162C74BD;
        Fri, 25 Mar 2022 00:37:00 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id lr4so5222563ejb.11;
        Fri, 25 Mar 2022 00:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6VyB3UYxWMO3tIrgEiCLozgnlezY4UO/iQgH0TlS3Ek=;
        b=yzyXbWvoIiH8l/fYEhge/3jnKDAcFirGlnc1sw5Ey4Rwf1Z8YU6/xPqsE/6ebCyLG7
         2wluVKZDjiUgoulA1WilrCsiQclcAai0VWwyTUcwcbf43SJql2A471UhSS4WCXX+wRkC
         gFo4xYnnoLMYABEk2eKgH5zhbQapqDU9YV5Wyvpumi054ekA+fttCohkMhsFUMtM3zK8
         3mNbXVHxV7WwognPui2p1noM/T7FB31bmbH8tV6wwmRwhxiZFW4r2yb3uWIdUH0WWdRZ
         38taMU6na5HXmbB0erFH1gA5FG9EqwbkJA7azHWvLDGsgt6Q+89IVr54fnMsAFQnBT3E
         Y9Xg==
X-Gm-Message-State: AOAM530ALXDYvD3hfAgPp+9oEUoR68/bWYGHr7W8hVufhIe3wpLVvEB1
        Z31M5ApfyQJMcfQUAOIK+TmlC06fgNQ=
X-Google-Smtp-Source: ABdhPJye6CqOTuW/WLwG8QnXQHalgAOvoPopU/9m5KwtnnA+wXTM9UKgjiBBnOU8B4FUrtXiZR/+LQ==
X-Received: by 2002:a17:906:1804:b0:6d6:dc46:d9ed with SMTP id v4-20020a170906180400b006d6dc46d9edmr9903089eje.288.1648193818924;
        Fri, 25 Mar 2022 00:36:58 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id q16-20020a170906145000b006bdaf981589sm2011246ejc.81.2022.03.25.00.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 00:36:58 -0700 (PDT)
Message-ID: <9fc72d19-1827-7681-4eb7-ba7c67f325fa@kernel.org>
Date:   Fri, 25 Mar 2022 08:36:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1] dt-bindings: clock: convert rockchip,rk3188-cru.txt to
 YAML
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220324133229.24035-1-jbx6244@gmail.com>
 <f7493d93-6c8a-efa9-1f2c-a0003a6d43b2@kernel.org>
 <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <bf62ad40-6bcf-62ae-f56a-cdc8d17456ec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 20:51, Johan Jonker wrote:
> Hi Heiko, Krzysztof,
> 
> Question for the Rockchip clock maintainer:
> What clock should be used here and other SoCs with several clock parents
> in the tree?
> 
> The clock.yaml produces a lot off notifications like:
> 
> /arch/arm/boot/dts/rk3036-evb.dtb: clock-controller@20000000: 'clocks'
> is a dependency of 'assigned-clocks'
> 
> Same for power-controller:
> 
> /arch/arm/boot/dts/rk3288-evb-rk808.dtb: power-controller: 'clocks' is a
> dependency of 'assigned-clocks'
> 
> Just followed rk3399.yaml that got approved recent.
> The current CRU nodes are in use for a long time this way.
> Converting a simple .txt comes with a lot of extra work each time. :\
> Please advise.

Same for me, same for me...

I replied to this part to Stephen's email. Here I'll reply to other parts:

(...)

>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - rockchip,rk3066a-cru
>>> +      - rockchip,rk3188-cru
>>> +      - rockchip,rk3188a-cru
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  "#clock-cells":
>>> +    const: 1
>>> +
>>> +  "#reset-cells":
>>> +    const: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>
> 
>> You need maxItems. Would be also nice to describe what should be here as
>> input
> 
> Just followed rockchip,rk3399-cru.yaml that got rob+dt's ack.
> 
> Is this dependency only for simple clock consumers suitable for complex
> clock trees with pll's, mux, etc? Shouldn't that be relaxed a bit?

minItems means that your clock controller can take any number of other
clock inputs. This is not true, for sure. Your device probably has fixed
number of external clocks (usually provided on the board if this is main
SoC clock controller).

> 
>>
>>
>>> +
>>> +  assigned-clock-rates:
>>> +    minItems: 1
>>> +    maxItems: 64
>>> +
>>> +  assigned-clocks:
>>> +    minItems: 1
>>> +    maxItems: 64
>>
>> Both assigned-xxx should not be necessary. Did you try validate the dtbs
>> without these?
> 
> That's how it's currently done for Rockchip cru's.

I understand, but if you remove assigned-xxx from schema what happens?

> 
> 
> ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- make dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3188-cru.yaml

There is no such file in my tree...

> 
>>
>> I guess you added "clocks" above because of these, so you need to
>> correct the DTS because asigned-xxx depend on clocks property.
> 
> See comment above.
> 
>>
>>> +
>>> +  rockchip,grf:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Phandle to the syscon managing the "general register files" (GRF),
>>> +      if missing pll rates are not changeable, due to the missing pll lock status.
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - "#clock-cells"
>>> +  - "#reset-cells"
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    cru: cru@20000000 {
>>
>> Node name: clock-controller
> 
> Which schema?

Devicetree specification (see chapter for node naming). Nodes should
have generic name. There is also list of example names to use.


Best regards,
Krzysztof
