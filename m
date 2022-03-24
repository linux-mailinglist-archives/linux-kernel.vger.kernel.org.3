Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075E44E62BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbiCXLyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiCXLyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:54:44 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5B81ADAD;
        Thu, 24 Mar 2022 04:53:11 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id u26so5289952eda.12;
        Thu, 24 Mar 2022 04:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5ltKLzd5hL5HQokDkXemnqLoOTjdJvhrUSmUGjXhOKY=;
        b=v9UpqE5UxNDfqOhxObQvIBnuVCLY9yhQXbdUzcSOiOMW5TCoKJjlAr9whreuq1ySyf
         OIhYXneLHk+b/o+GIiatNref+srnHspVNxSdGRlQpX9xf8ZXkCAJWJBV2/2riSSNikWA
         +s7KZcy8of4oJanviNqJypSORH0XkjiDbfdHwzDsfZeEuapU+ziQ8gmQR1dhct1iuUhU
         wM6dIaa9tAeTk//mcKX/lYZz/uQ7tj3X+GGc9LWnR5SRyEHVsP8AuwjLfqJF9aQXLrIR
         yYhEhEXZpQ3V79fUARP3wQHZLXjlrxQn4UcMPyFaUA85AWLGySTRXoutwjLAsPcGzoQ0
         P+cQ==
X-Gm-Message-State: AOAM532vn62ZWuGlWLx33WDntRb1nZWaIa74lZSri8tbLFXfRA37VHlz
        2SQCUPAlUPwhOtKSwqQZWp7yuvvSw17oRQ==
X-Google-Smtp-Source: ABdhPJz6j4PqEWrxanuEP+vlNZkdiYyWicoY+CmwYGxtZYFcvjcm4oFtqKwL7YtAAZbwP55R+jzUxg==
X-Received: by 2002:aa7:cd7a:0:b0:419:48ce:3a10 with SMTP id ca26-20020aa7cd7a000000b0041948ce3a10mr6228425edb.312.1648122790189;
        Thu, 24 Mar 2022 04:53:10 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id da23-20020a056402177700b0041394d8173csm1281621edb.31.2022.03.24.04.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:53:09 -0700 (PDT)
Message-ID: <2b33798e-23c2-d4a5-171a-55c28bc40c40@kernel.org>
Date:   Thu, 24 Mar 2022 12:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh+dt@kernel.org>
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
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <41f79aa5-1e04-53f8-ab21-85fe6039e24e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 12:40, Aswath Govindraju wrote:
> Hi Krzysztof,
> 
> On 24/03/22 16:37, Krzysztof Kozlowski wrote:
>> On 24/03/2022 08:34, Aswath Govindraju wrote:
>>> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
>>> controller.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>
>>> Changes since v1:
>>> - made correction in grammer of clocks property description
>>>   and added maxItems in the interrupts property based on comments
>>>   received from Roger
>>> - corrected the title, fixed the description of
>>>   ti,syscon-phy-pll-refclk, added pattern properties and child node
>>>   in the example based on the comments from Krzysztof.
>>>
>>>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
>>>  1 file changed, 117 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>> new file mode 100644
>>> index 000000000000..452bfdc6fb09
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
>>> @@ -0,0 +1,117 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
>>> +
>>> +maintainers:
>>> +  - Aswath Govindraju <a-govindraju@ti.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: ti,am62-usb
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  ranges: true
>>> +
>>> +  power-domains:
>>> +    description:
>>> +      PM domain provider node and an args specifier containing
>>> +      the USB ISO device id value. See,
>>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    description: Clock phandle to usb2_refclk
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: ref
>>> +
>>> +  id-gpio:
>>> +    description:
>>> +      GPIO to be used as ID pin
>>> +    maxItems: 1
>>
>> I have doubts about this. If you USB controller handles the ID pin, then
>> probably this should be moved to usb-connector.yaml. I did not see
>> id-gpio in any other USB controller blocks.
>>
> 
> Yes, the USB wrapper handles the ID pin operation only. It also reads
> the status of VBUS by reading a register from its MMR and not using a
> gpio. After evaluating the role the based on the states if id pin and
> VBUS, this role is communicated to the dwc3 core driver using extcon.
> There is no way for the dwc3 driver to detect the role on its own.
> 
> 
> The usb-connector(drivers/usb/common/usb-conn-gpio.c) driver, seems to
> be implemented for driving the VBUS, based on ID and VBUS pin status.
> However, in case of the above implementation we need to communicate the
> detected role to the dwc3 core driver. Also, the wrapper does not
> control VBUS but it is the dwc3 core driver that drives the VBUS.
> Therefore, I think the usb-connector implementation cannot be used here.

I don't think about usb-conn-gpio.c but using the binding generic
binding for usb-X-connector and define a connector with ID.

Actually Rob could help here.

Rob,
Should the id-gpio be modeled as a property in this glue/wrapper driver
or rather as part of usb-connector child node?


Best regards,
Krzysztof
