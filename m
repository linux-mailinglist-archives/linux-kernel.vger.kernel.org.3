Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245614EE943
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343982AbiDAHva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242163AbiDAHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:51:28 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDF818D9BA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:49:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so4108189ejd.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yUuXc/3RjtWm/4ApHN92lrKX7Ow6h3wcH9Gg1mgZ/sU=;
        b=yv0eYYULooqaOzk9E5QMDT1KImV9iXTaJ0S6E5D0/VwCCWlQcnD/8Vo57GAY9CLsBr
         1nUvrXJgH8hskmfzs8B1WyI67oxhUkfpyAhvFPHS38X3ezba7h21EN/sU6KQ4MX2yX/T
         AQV2ANLKaqQX/LJdhgxvVTaF4AGfXB4tk0lp1deT67HaoHUuzC/i1QFCgnNjWs1p+Q5e
         LnUIXO3ZLWFb6zGCORhnvTD+0tmneBjctYAZ0xINkiurjUp6B3EGf70XotcFxdfmTRUE
         jU++QBNXVMZCtJbs5WP+/Hyk4CQCFndE/5+ETcvV+82ChGRSHK2w8gvBM0QyUp0hjsEw
         o0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yUuXc/3RjtWm/4ApHN92lrKX7Ow6h3wcH9Gg1mgZ/sU=;
        b=CWpX+S6AhLPGhzVhZogSTPuSvJ8fnXUh8bw0i/3djds801exlysOzx2EFVLi0U957f
         LGi/T+x8Ax8zM2MJ6ixaAxDZAqastF6rBuoPald46VygEnkZko19u0kDbiMijyawFAdm
         izjOk6DhjXfHYMI1TS9XSFmh9VqLotdeEQ23ejEoT71tVBck6RVXFUStbpYKxx0feRNq
         ekzsLxx5klSttmMSqYCWzjqjJ++34r3NXPqNsaaA0FFolZyGD6EbjBeezdgTmhTmL9Iz
         r+VwP8jHmtt3C5T/5ZNuHe9fPFlwNZfzJnkTHYX2/fqLh8JXQJtBkq0d2v1dfnI0PPJM
         XUbg==
X-Gm-Message-State: AOAM532WLCkT26BQSN2/aOINjgMS1RQBsVQo4mtrB42Hc75y+lFk3Njv
        QqLDfo9iif+McLMNeaK7vSECLw==
X-Google-Smtp-Source: ABdhPJyUD8xHV+dYdxVDPmeyfD7e9/7Ow8NmRo8ewNb1JPfZUTssEF49fghDYUNPD1QxZoGs7J5WXw==
X-Received: by 2002:a17:907:6282:b0:6e0:c64a:60a7 with SMTP id nd2-20020a170907628200b006e0c64a60a7mr8187192ejc.349.1648799378077;
        Fri, 01 Apr 2022 00:49:38 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g23-20020a17090670d700b006ccfd4163f7sm703883ejk.206.2022.04.01.00.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 00:49:37 -0700 (PDT)
Message-ID: <5139bdb8-11ee-6efe-6c42-acf2f96d9153@linaro.org>
Date:   Fri, 1 Apr 2022 09:49:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220324073425.18607-1-a-govindraju@ti.com>
 <20220324073425.18607-2-a-govindraju@ti.com>
 <93fe6a41-3b59-2fbc-6f95-833f337815ee@kernel.org>
 <41f79aa5-1e04-53f8-ab21-85fe6039e24e@ti.com>
 <2b33798e-23c2-d4a5-171a-55c28bc40c40@kernel.org>
 <YkZFV4h/vvmKg6iw@robh.at.kernel.org>
 <1fcac9c3-4b84-6572-ebc6-4d6a50f0132a@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1fcac9c3-4b84-6572-ebc6-4d6a50f0132a@ti.com>
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

On 01/04/2022 07:04, Aswath Govindraju wrote:
> Hi Rob,
> 
> On 01/04/22 05:50, Rob Herring wrote:
>> On Thu, Mar 24, 2022 at 12:53:08PM +0100, Krzysztof Kozlowski wrote:
>>> On 24/03/2022 12:40, Aswath Govindraju wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 24/03/22 16:37, Krzysztof Kozlowski wrote:
>>>>> On 24/03/2022 08:34, Aswath Govindraju wrote:
>>>>>> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
>>>>>> controller.
>>>>>>
>>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>>> ---
>>>>>>
>>>>>> Changes since v1:
>>>>>> - made correction in grammer of clocks property description
>>>>>>   and added maxItems in the interrupts property based on comments
>>>>>>   received from Roger
>>>>>> - corrected the title, fixed the description of
>>>>>>   ti,syscon-phy-pll-refclk, added pattern properties and child node
>>>>>>   in the example based on the comments from Krzysztof.
>>>>>>
>>>>>>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
>>>>>>  1 file changed, 117 insertions(+)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..452bfdc6fb09
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>>>> @@ -0,0 +1,117 @@
>>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Aswath Govindraju <a-govindraju@ti.com>
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    const: ti,am62-usb
>>>>>> +
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  ranges: true
>>>>>> +
>>>>>> +  power-domains:
>>>>>> +    description:
>>>>>> +      PM domain provider node and an args specifier containing
>>>>>> +      the USB ISO device id value. See,
>>>>>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  clocks:
>>>>>> +    description: Clock phandle to usb2_refclk
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    items:
>>>>>> +      - const: ref
>>>>>> +
>>>>>> +  id-gpio:
>>>>>> +    description:
>>>>>> +      GPIO to be used as ID pin
>>>>>> +    maxItems: 1
>>>>>
>>>>> I have doubts about this. If you USB controller handles the ID pin, then
>>>>> probably this should be moved to usb-connector.yaml. I did not see
>>>>> id-gpio in any other USB controller blocks.
>>>>>
>>>>
>>>> Yes, the USB wrapper handles the ID pin operation only. It also reads
>>>> the status of VBUS by reading a register from its MMR and not using a
>>>> gpio. After evaluating the role the based on the states if id pin and
>>>> VBUS, this role is communicated to the dwc3 core driver using extcon.
>>>> There is no way for the dwc3 driver to detect the role on its own.
>>>>
>>>>
>>>> The usb-connector(drivers/usb/common/usb-conn-gpio.c) driver, seems to
>>>> be implemented for driving the VBUS, based on ID and VBUS pin status.
>>>> However, in case of the above implementation we need to communicate the
>>>> detected role to the dwc3 core driver. Also, the wrapper does not
>>>> control VBUS but it is the dwc3 core driver that drives the VBUS.
>>>> Therefore, I think the usb-connector implementation cannot be used here.
>>>
>>> I don't think about usb-conn-gpio.c but using the binding generic
>>> binding for usb-X-connector and define a connector with ID.
>>>
>>> Actually Rob could help here.
>>>
>>> Rob,
>>> Should the id-gpio be modeled as a property in this glue/wrapper driver
>>> or rather as part of usb-connector child node?
>>
>> That's a simple question. Where does the ID GPIO signal go to? The 
>> connector, so it goes in the connector node.
>>
> 
> Thank you for the clarification. Here ID-gpio is directly read by the
> wrapper and hence, I have modeled it as a property in the wrapper dt
> node. May I know if this wrong and should the modelling be looked at
> differently?

What do you mean here by "read"? If you refer to the driver reading the
pin value, it is less related to the hardware, right?


Best regards,
Krzysztof
