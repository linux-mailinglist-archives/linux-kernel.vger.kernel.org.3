Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C7A4E4F34
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiCWJXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbiCWJXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:23:13 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2937375C0F;
        Wed, 23 Mar 2022 02:21:44 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id p15so1544610ejc.7;
        Wed, 23 Mar 2022 02:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=V7cFXLe0Ac3dhEHnygD54hmubbEibQ543cmeBXtuvAg=;
        b=PK1qor4p6wuQJuAjI/qfuGWEp+WgcGKI5bHLEiS7iIQmu5MAcwQZ7WSxZgWG6rQSJD
         cDC77lsb0RUeqJUmB1NtFPjF91b3SqkUpM0fJJigf5oxwsd7+eehKq9O7kAsrjn0l3E8
         qY4wABXuFaPWiu4UFgKGrOlKa2tSNbdrmXLi/UTDvu7DZhQehvKY+TapsW0vH1o08BKU
         23tC+VCF6UJZWMOT7vQA3JC1lPMhPVssnCyHhrIOPlWg2lE439vRdzr1MaiXfVHeQvYD
         zsGrlk92+/rn+wJ8nnYUgL+fcByiODdcaK3gwtN/uIICdMxLtDwGqZYugb87hkpLpovu
         si4g==
X-Gm-Message-State: AOAM533Wafeoo4Wm19Bxf1pf6a8w2T+VhvCF7wdsLGCQjgs5yN6zDEQR
        lvKU3f4baLVORnJK/OR9cOnapASx4Dc=
X-Google-Smtp-Source: ABdhPJy7MV6xyddcHt6m3B0LTYQ3xvlfGk7tespcbjb8vqMugRQhoJZnMEfw7oV9V0zSoFdXZNS3bA==
X-Received: by 2002:a17:906:68c2:b0:6b4:9f26:c099 with SMTP id y2-20020a17090668c200b006b49f26c099mr31260479ejr.41.1648027302702;
        Wed, 23 Mar 2022 02:21:42 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id w6-20020a170906d20600b006ca00cb99e0sm9658170ejz.34.2022.03.23.02.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:21:42 -0700 (PDT)
Message-ID: <65609100-3664-11e3-f229-c203e52888f0@kernel.org>
Date:   Wed, 23 Mar 2022 10:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220323053524.7009-1-a-govindraju@ti.com>
 <20220323053524.7009-2-a-govindraju@ti.com>
 <f17f1f14-d78f-7b54-7fa7-ebf52c6da90a@kernel.org>
 <8b8dcc55-dda8-0715-ccff-22fbe84ff18a@ti.com>
In-Reply-To: <8b8dcc55-dda8-0715-ccff-22fbe84ff18a@ti.com>
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

On 23/03/2022 10:17, Aswath Govindraju wrote:
> Hi Krzysztof,

(...)

>>> +
>>> +  ti,syscon-phy-pll-refclk:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      - items:
>>> +          - description: Phandle to the SYSCON entry
>>> +          - description: USB phy control register offset within SYSCON
>>> +    description: Specifier for configuring frequency of ref clock input.
>>
>> This is a bit strange. The ref clock is the "ref" input clock, right? In
>> such case use clk_set_rate()... Using syscon for managing clocks is not
>> the proper way.
>>
> 
> The syscon property is not being used to set the ref clock frequency but
> is rather being used to indicate the input clock frequency for USB PHY
> operation. I think the description seems be misleading. I will update it
> in the respin, to reflect the above description.

Yes, please, it will help.

> 
>> Plus all the issues pointed out by Roger.
>>
>>> +
>>> +  '#address-cells':
>>> +    const: 2
>>> +
>>> +  '#size-cells':
>>> +    const: 2
>>
>> No children allowed?
>>
>> I understand this is a wrapper, which explains why you do not include
>> usb-hcd.yaml schema. But since it is a wrapper, what is it wrapping?
>>
> 
> Yes, there is a child node, which would be the dwc3-contoller node.
> Would adding the child node too in the example help capture this better?

Yes, please, because then you will also spot errors when running
dt_binding_check.

You need patternProperties for "^usb@[0-9a-f]+$" referencing Synopsys
schema. Something like:
Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml



Best regards,
Krzysztof
