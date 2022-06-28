Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12EC55E92A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346819AbiF1Ogt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346391AbiF1Ogr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:36:47 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05692C651
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:36:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lw20so26237757ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1kG5KHBbJK53FyqEc1h82Hzpb97sM1z63scdMZFmZU0=;
        b=WWluulmXXBI8m3ENfy2GJ9QWnt0QqRikc4ZvP592zsX/93LReUqVGWewqmF7WNxuN8
         oiGVAuJ7RgMl2Sd7cYcY4HBlU26kxOU2tceKLYaPjO2JBBBk1i5ZjzYguun7YZElgQBG
         KwErKupJyqYCFixUtKTkfcefy8nKOa0YR5kapZwuMwi3MXqdR0/zE9ts5rj/Pw41Ts7v
         DBl3f3AAw7OVNrYrI2XVNFz3Q7++YmDCNDdMEBUoSSL1xMhISu6kJHP4FtwrNAlSiz8k
         TKAbAJqFpnsjpgtzQQWNhG5tSljTdNX1x3laF0h67J5rqxUGTtAxiyJTakOyPj/uRHv6
         Igwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1kG5KHBbJK53FyqEc1h82Hzpb97sM1z63scdMZFmZU0=;
        b=eW8/TtGlIyHOp3VaGuq8pBcYrq3LxkMnU3mVMa5OIzUQPZDgbgVYx4Hsx931+9RvmS
         FdOjfCwWWivXRetEZjLswse1cwYMl9n4u8ImbGtUvlpdaD3MS/XI1MxCc30xL2bVwtZb
         PnZpNGAsrai6mmXBV5rSCUqvxWpgcYPRNj0uBa/z9q4RM4peyMSK60RY2i+NBtef3SbD
         dIvS/vpxj1KgAkUIc92YKGtvqha68JUHz460OjSgeJBmQB4162XRccOcXygHiYlZbcog
         xC/TwA7HEYcB1Iyu2/s0A/yz0DweYAC+QMyB2lsH6ITi5BfN0l1AqtykYkcW+dtK3JJl
         n9PA==
X-Gm-Message-State: AJIora/MbGhaSY3bXjr5V2Rf5oIUwxlbHCennm0/eKjezZPZAfPDb6gI
        dogeMDV7yNXLT3GzOgpoojr8dQ==
X-Google-Smtp-Source: AGRyM1sVC7TWIYpt1oIZW6wYctnUWBGj4Dur26pc2yKwD7xpPyvlOl/zb+adOPdngTZFXm/Rlj4gQA==
X-Received: by 2002:a17:907:3e0e:b0:726:602b:c19b with SMTP id hp14-20020a1709073e0e00b00726602bc19bmr16383689ejc.117.1656427004391;
        Tue, 28 Jun 2022 07:36:44 -0700 (PDT)
Received: from [192.168.0.254] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y21-20020a170906559500b00726dbb16b8dsm780222ejp.65.2022.06.28.07.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 07:36:43 -0700 (PDT)
Message-ID: <daaddbd5-1cd4-d3ce-869a-249bdd8aecb9@linaro.org>
Date:   Tue, 28 Jun 2022 16:36:42 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <288f56ba9cfad46354203b7698babe91@walle.cc>
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

On 28/06/2022 16:22, Michael Walle wrote:
>>> I can't follow you here. Please note, that you need the actual
>>> physical port number. It's not a made up number, but corresponds
>>> to a physical port on that ethernet switch. So you can't just skip
>>> the disabled ones. port@2 must have port number 2.
>>
>> The number "2" you get from the reg property, so where is exactly the
>> problem?
> 
> That you need to get the total number of ports of the hardware (which
> is also used for things beyond validation, eg. during switch init
> all ports will are disabled). And right now, that is done by counting
> all the nodes - which is bad, I guess we agree here. 

It's bad also from another reason - the DT node was explicitly disabled,
but you perform some operation on actual hardware representing this
node. I would assume that a disabled DT node means it is not
operational, e.g. hardware not present or missing clocks, so you should
not treat it as another meaning - power down/unused.

> But it works,
> as long as no ports are disabled and all ports are described in the
> device tree. But I have device trees where some are disabled.

I am not sure if I follow this. You have devices which
1. have unused ports, but all DT nodes are available/okay,
2. have unused ports, which are in DT status=disabled?

Doesn't case 2 break the bindings? If so, we don't care about such
out-of-tree users. We cannot support all of possible weird combinations
in out-of-tree DTS files...

> 
> I assume, you cannot read the hardware itself to get the number of
> physical ports; and we have the compatible "microchip,lan966x-switch",
> which is the generic one, so it could be the LAN9668 (with 8 ports)
> or the LAN9662 (with 2 ports). 

I'll keep that argument for future when I see again patches adding such
wildcard compatible. :) I had to discuss with some folks...

Although the compatible difference does not have to be important here,
because one could say the 9662 and 9668 programming model is exaclty the
same and they differ by number of ports. This number of ports can be a
dedicated property or counted from the children (if they were all
available).

> We somehow have to retain backwards
> compatibility. Thus my idea was to at least make the handling slightly
> better and count *any* child nodes. So it doesn't fall apart with 
> disabled
> nodes. Then introduce proper compatible strings 
> "microchip,lan9668-switch"
> and use that to hardcode the num_phys_ports to 8. But there will be
> device trees with microchip,lan966x-switch out there, which we do want
> to support.
> 
> I see the following options:
>   (1) just don't care and get rid of the "microchip,lan966x-switch"
>       compatible
>   (2) quick fix for the older kernels by counting all the nodes and
>       proper fix for the newer kernels with dedicated compatibles
>   (3) no fix for older kernels, introduce new compatibles for new
>       kernels

I propose this one. I would not care about out-of-tree DTSes which
decided to disable random stuff and expect things working. :)

>   (4) keep generic compatible if the hardware can be read out to get
>       the number of ports.
> 
> I think (1) isn't the way to go. (2) was my try until I noticed
> that odd fwnode behavior. But judging by this thread, I don't think
> thats possible. I don't know if (4) is possible at all. If not we'd
> be left with (3).


Best regards,
Krzysztof
