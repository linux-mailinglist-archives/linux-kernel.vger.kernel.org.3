Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3507D4ED38F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiCaFzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCaFzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:55:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922761C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:53:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so45763066ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zzs+ZHibEnw+t1g8tg6/Dygsvg8Tq1tVYNwyuhr7FfU=;
        b=PwtYT3853d0ybAZujxH83isegbuSphn/uUyIcg2L7F8ik2CoDddiJAd4vFrj01oQpq
         ngjYoJpJK7Te6ACIQyLLz2gXfiDBfsTaTwdTJQXJKz5j61MhVeBWpOMbsbFL56Ywv/9u
         n0jJe68RTMVvvXWVBxqWA45gJvDLJBtz0NTR7cQr8sBRzJhKn7uWcv5VEDTS4zQuPObK
         kyrxW31am0Ly4RAI2Bes34LDjLEv5GZKbBVXtVkQQS3bxBUYI9urwL6yH1T5NrTmn/I/
         eEte9nspD5UqCe5MGEOeuw1Wj9Xbux232G5ltRocxRiHoAhFHnkCgFw7WQMEKKrHNHc0
         vwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zzs+ZHibEnw+t1g8tg6/Dygsvg8Tq1tVYNwyuhr7FfU=;
        b=ae/bEljH+oEfCzAoBB2H4GyDAGpLuaLOFWdm5Ecf17hgQm9/3Zoh/rQ/lM0wsGRrpd
         fcqVCBAOVVQW0eRnVjgq/hfV26lV/c1x6S+2+75zFmLjeQZfiZP993z5jNobkTJz1eOr
         w+m7GfzumSIAu6ZRyTP+63SvB/o3FYBREVEPHtoNsTdQGUVN7OGtGwNCIrKDADD41lRC
         a2dSuckPBA3Lm6Mxgg/6zvLayaASw5cERdNXCmPhvMND2sIGbjXcKa4QaKdEapl9mgwJ
         /lX762b7ORzeJth7CX3r2FlahpY4hqoy6FdmMy06FF+yLmkO9ihvTp+7fFV4uSrG+ihf
         cjhw==
X-Gm-Message-State: AOAM531/awhpuL+m9HvH1BHw7dTLXE3xa7NoZvFKhQ65DykvEow1htJz
        69lI3SkQQCsn+INIWFV4gi52HtA59Q2VfaTF
X-Google-Smtp-Source: ABdhPJzkI8vj+Jq5KZdLH/R9bIGRMouax/d6lriJQXZwTgo7uUVSkqmvjIQT+GOZLxcFLw6ItXtNcQ==
X-Received: by 2002:a17:907:608c:b0:6e0:5204:7454 with SMTP id ht12-20020a170907608c00b006e052047454mr3425777ejc.225.1648706032108;
        Wed, 30 Mar 2022 22:53:52 -0700 (PDT)
Received: from [192.168.0.164] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id dm11-20020a170907948b00b006cf488e72e3sm9041961ejc.25.2022.03.30.22.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 22:53:51 -0700 (PDT)
Message-ID: <5fa843d2-f07c-3bc0-22f1-8a2ae234e9aa@linaro.org>
Date:   Thu, 31 Mar 2022 07:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 5/5] dt-bindings: phy: uniphier: Clean up clocks,
 resets, and their names using compatible string
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1648637715-19262-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1648637715-19262-6-git-send-email-hayashi.kunihiko@socionext.com>
 <a784ed61-965a-5c68-c2dd-3340cf18c7b5@linaro.org>
 <d32191fc-1302-89e4-8b24-40fe33867b98@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d32191fc-1302-89e4-8b24-40fe33867b98@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 02:50, Kunihiko Hayashi wrote:
> Hi Krzysztof,
> 
> On 2022/03/31 2:40, Krzysztof Kozlowski wrote:
>> On 30/03/2022 12:55, Kunihiko Hayashi wrote:
>>> Instead of "oneOf:" choices, use "allOf:" and "if:" to define clocks,
>>> clock-names, resets, and reset-names that can be taken by the compatible
>>> string.
>>>
>>> The order of clock-names and reset-names doesn't change here.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   .../phy/socionext,uniphier-ahci-phy.yaml      | 90 +++++++++++++-----
>>>   .../phy/socionext,uniphier-pcie-phy.yaml      | 47 ++++++---
>>>   .../phy/socionext,uniphier-usb3hs-phy.yaml    | 93 ++++++++++++++----
>>>   .../phy/socionext,uniphier-usb3ss-phy.yaml    | 95 +++++++++++++++----
>>>   4 files changed, 251 insertions(+), 74 deletions(-)
>>>
>>
>> (...)
>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>>> index 1bbd164f2527..21e4414eea60 100644
>>> ---
>>> a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>>> +++
>>> b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
>>> @@ -34,30 +34,12 @@ properties:
>>>       minItems: 2
>>>       maxItems: 3
>>>
>>> -  clock-names:
>>> -    oneOf:
>>> -      - items:               # for Pro5
>>> -          - const: gio
>>> -          - const: link
>>> -      - items:               # for PXs3 with phy-ext
>>> -          - const: link
>>> -          - const: phy
>>> -          - const: phy-ext
>>> -      - items:               # for others
>>> -          - const: link
>>> -          - const: phy
>>> +  clock-names: true
>>>
>>>     resets:
>>>       maxItems: 2
>>>
>>> -  reset-names:
>>> -    oneOf:
>>> -      - items:               # for Pro5
>>> -          - const: gio
>>> -          - const: link
>>> -      - items:               # for others
>>> -          - const: link
>>> -          - const: phy
>>> +  reset-names: true
>>>
>>>     vbus-supply:
>>>       description: A phandle to the regulator for USB VBUS
>>> @@ -80,6 +62,77 @@ properties:
>>>         required for each port, if any one is omitted, the trimming data
>>>         of the port will not be set at all.
>>>
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            const: socionext,uniphier-pro5-usb3-hsphy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        clock-names:
>>> +          items:
>>> +            - const: gio
>>> +            - const: link
>>> +        resets:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        reset-names:
>>> +          items:
>>> +            - const: gio
>>> +            - const: link
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - socionext,uniphier-pxs2-usb3-hsphy
>>> +              - socionext,uniphier-ld20-usb3-hsphy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        clock-names:
>>> +          items:
>>> +            - const: link
>>> +            - const: phy
>>> +        resets:
>>> +          minItems: 2
>>> +          maxItems: 2
>>> +        reset-names:
>>> +          items:
>>> +            - const: link
>>> +            - const: phy
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - socionext,uniphier-pxs3-usb3-hsphy
>>> +              - socionext,uniphier-nx1-usb3-hsphy
>>> +    then:
>>> +      properties:
>>> +        clocks:
>>> +          minItems: 2
>>
>> Why minItems:2? Is the last phy-ext clock optional?
> 
> In an SoC with two controllers, there is a controller that requires extra
> clock and a controller that does not. For example, PXs3 USB3 controller 1
> needs "phy-ext" clock, but the controller 0 doesn't.
> 
> This difference is related to the phy configuration, where the controller 1
> requires more clocks because it shares the phy with other subsystems.
> 
> So I think the last phy-ext clock should be optional.
> 

OK, thanks for explanation. I assume we talk about the hardware, not
about Linux driver needs. :)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
