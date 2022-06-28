Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F18855E794
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbiF1PRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiF1PRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:17:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169631536
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:17:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so10187273edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aSy4S6OkwU5Fk+1ynDZhkvWk4BHGx0AAK4bKb1Eq7Iw=;
        b=aF1qoIqXU4mpquNkBwAfdWtJ+lDlwzsxizK1Yn65wbp/x+wE5PeMa3TztoOwBlO9V5
         6ByMG5HEzbblW3i7YC1W7CuYl7kOXXaLv+9uL9RwkaGz6tLWfuSbrhCVWqYgbUxUyOXk
         8dbeU6uydZlsr7Nqfv6+wXexrLVRawzM3aW7OchfnL8R8b1XhH23Msm3o4wOhiqFIEqC
         ah5luGE1x5j/BuE2PxSU+KsQqVxJ3NTdS/6I8xvELHNev4ekIdhmWRJkP/Hdf4xQWekw
         yyjTNh+i439N/mDdNyC7TMFU9cniWlPVfg2DO3YfXZyTWYDeiz9bWyBKfHZftQAJ/Qc5
         90Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aSy4S6OkwU5Fk+1ynDZhkvWk4BHGx0AAK4bKb1Eq7Iw=;
        b=QmxufNbE7Z6vIpSV5qY1doDl7lDpnJnWiwmAT7cHFAUUWzJmYIXgEVXaGQHl0mTKfJ
         Zp+6Nkk5WJTBp7/mPwaP2Cb51DhZLsy2EwY05HGAE6X1Bpd3pXytb8rRynwJd+UWJVKP
         uusKW1jT70ZRe0U8U5Q8/h3IqiOdHfdXVIiJ75eockKZ+BL4NMqUYZBYWsDRVAFc/hb1
         ioh3cz87UDmMhQQ41cCXzNWFF2WSF2pKhNLySkcU0PZHcSJY9HQOMzlcuo1AjRvZ/pYr
         EptZEjmXF1m3gqQHa+1shQaT7584rBshDTEU8SgmwzeqSvPuTHxHYEKwIqYgdRAKTmaE
         jzww==
X-Gm-Message-State: AJIora+PNFjs++UHtjW+RDyPOoLLVU6pE8Ky7nhtF9RpQuiqxEUxMLTD
        B8nGF82GpdjG+Qf2fexbfxfLV5fIdzsRGQ==
X-Google-Smtp-Source: AGRyM1unDm6ZbuLpiudtxj55d4HB8KbGOWrH02RP85j/krqr1kifT1DKAYZtE1ZzPvcI52TyTgt0Yg==
X-Received: by 2002:a05:6402:4302:b0:437:7990:992e with SMTP id m2-20020a056402430200b004377990992emr19557861edc.194.1656429426555;
        Tue, 28 Jun 2022 08:17:06 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709061c8300b0070759e37183sm6542987ejh.59.2022.06.28.08.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:17:06 -0700 (PDT)
Message-ID: <f9eb6d94-c451-0c9f-f123-2f1324f68b68@linaro.org>
Date:   Tue, 28 Jun 2022 17:17:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc>
 <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
 <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
 <2f2d7685e0e43194270a310034004970@walle.cc>
 <CAHp75VcANMjxgS6S24Zh+mz66usb6LBnQk-ENvU9JHSXXsG1DA@mail.gmail.com>
 <9e58f421c27121977d11381530757a6e@walle.cc>
 <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
 <288f56ba9cfad46354203b7698babe91@walle.cc>
 <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
 <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96f40ae6abf76af3b643b1e1c60d1d9f@walle.cc>
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

On 28/06/2022 17:09, Michael Walle wrote:
>> It's bad also from another reason - the DT node was explicitly 
>> disabled,
>> but you perform some operation on actual hardware representing this
>> node. I would assume that a disabled DT node means it is not
>> operational, e.g. hardware not present or missing clocks, so you should
>> not treat it as another meaning - power down/unused.
> 
> Mh. Assume a SoC with an integrated ethernet switch. Some ports
> are externally connected, some don't. I'd think they should be disabled,
> no? Until now, all bindings I know, treat them as disabled. But OTOH
> you still need to do some configurations on them, like disable port
> forwarding, disable them or whatever. So the hardware is present, but
> it is not connected to anything.

I see your point and the meaning is okay... except that drivers don't
touch disabled nodes. If a device (with some address space) is disabled,
you do not write there "please be power off". Here the case is a bit
different, because I think ports do not have their own address space.
Yet it contradicts the logic - something is disabled in DT and you
expect to perform actual operations on it.

> 
>>> But it works,
>>> as long as no ports are disabled and all ports are described in the
>>> device tree. But I have device trees where some are disabled.
>>
>> I am not sure if I follow this. You have devices which
>> 1. have unused ports, but all DT nodes are available/okay,
>> 2. have unused ports, which are in DT status=disabled?
>>
>> Doesn't case 2 break the bindings? If so, we don't care about such
>> out-of-tree users. We cannot support all of possible weird combinations
>> in out-of-tree DTS files...
> 
> Case 1 is invalid I think.
> 
> How does case 2 break the binding? It breaks the driver, yes. But not
> the binding.

The binding asks to describe all the ports, not describe and disable them.

> I agree on the out-of-tree argument, *but* isn't that
> what the binding is for, that out-of-tree device trees gonna work as
> long as they follow the binding? And I don't see where it dictates that 
> all
> nodes must be enabled; nor that it must either be 2 or 8 children nodes.

True, that's not specific, but as with any incomplete hardware
description in DTS, the binding cannot guarantee you
backwards-compatibility.

The hardware should be described fully in DTS and bindings expect that
as well.

> 
>>> I assume, you cannot read the hardware itself to get the number of
>>> physical ports; and we have the compatible "microchip,lan966x-switch",
>>> which is the generic one, so it could be the LAN9668 (with 8 ports)
>>> or the LAN9662 (with 2 ports).
>>
>> I'll keep that argument for future when I see again patches adding such
>> wildcard compatible. :) I had to discuss with some folks...
>>
>> Although the compatible difference does not have to be important here,
>> because one could say the 9662 and 9668 programming model is exaclty 
>> the
>> same and they differ by number of ports. This number of ports can be a
>> dedicated property or counted from the children (if they were all
>> available).
> 
> Mh. Rob was always in favor of dedicated compatible strings. And I
> think there are also subtle differences. Eg. the LAN9662 has some kind
> of accelerating engine, if I'm not mistaken.
> 
> So what do you prefer:
> 
>    compatible = "microchip,lan9668";
> and
>    compatible = "microchip,lan9662";

This one.

> 
> or
> 
>    compatible = "microchip,lan966x";
>    microchip,num-phys-ports = <8>;
> and
>    compatible = "microchip,lan966x";
>    microchip,num-phys-ports = <2>;
>    microchip,accelerating-engine;
>    ..
> 
> The argument here was always, we don't want too much properties if
> it can be deduced by the compatible string.
> 
>>> We somehow have to retain backwards
>>> compatibility. Thus my idea was to at least make the handling slightly
>>> better and count *any* child nodes. So it doesn't fall apart with
>>> disabled
>>> nodes. Then introduce proper compatible strings
>>> "microchip,lan9668-switch"
>>> and use that to hardcode the num_phys_ports to 8. But there will be
>>> device trees with microchip,lan966x-switch out there, which we do want
>>> to support.
>>>
>>> I see the following options:
>>>   (1) just don't care and get rid of the "microchip,lan966x-switch"
>>>       compatible
>>>   (2) quick fix for the older kernels by counting all the nodes and
>>>       proper fix for the newer kernels with dedicated compatibles
>>>   (3) no fix for older kernels, introduce new compatibles for new
>>>       kernels
>>
>> I propose this one. I would not care about out-of-tree DTSes which
>> decided to disable random stuff and expect things working. :)
> 
> I'd argue, that is the usual case for all the switch bindings I
> know of; not some unusual config. E.g. the SoC dtsi disables all
> ports by default and only the ones which are actually connected
> by the board are then enabled in the board dts, see
> arch/arm/boot/dts/lan966x.dtsi
> arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> 
> That being said, I don't care too much about the older kernels.
> So I'm fine with (3).


Best regards,
Krzysztof
