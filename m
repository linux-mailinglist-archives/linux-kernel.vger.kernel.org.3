Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F65355E8AE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiF1NvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiF1NvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:51:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C0C1F635
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:51:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i25so12289439wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CuCbBwkvPnJNnIdbwpSf7SFi7ylwDdTKSQ4thFgSXMQ=;
        b=jobcASpV9i7JAhttUMV5Qfwdjs4GAg+t7XuLGiCS3dZ0qTRZeDHlFwNyjDX7BC3VTS
         AroWtyAGMcY5qngbW0OneRSAd85GlXJSCSDWbZ9gTvkqcpUvW0rflbm6IBCBnxyeEJ5Q
         3pOADyf6RUyQrw4W85auTePIZCceM+VYNOY32NJL0BPenAK6vYg2X3CDrltNnYfdTI0L
         gEZxqRiELzwhhoUCeEZWdBE6qya+gEj7UvgYWhKDxqq1TxJvh4UWaw1+EXzt7QCc35eN
         xBQj+Sgf8WQUKdaJYOj5p2fC1rfk/8D1/+015yQJDuilu5L5fNOx4F+FyjanYJPCuoQ+
         a+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CuCbBwkvPnJNnIdbwpSf7SFi7ylwDdTKSQ4thFgSXMQ=;
        b=642pUNn58NEC02RjSUR44lbuhZUfPohWRwWRYUs1LkQNVy2O56083H6H/bpo5zKW7I
         0oth9kQzD/IJcqweKo5/T158Km5W5Yu1ap7tqawYU2DJRkMSkrG/1J56ZFeTebE21SBy
         B0HX7VObJJExN8XuZIM6yX4vnU2ogsr4ok0m56skZU/O6DlWNzYEV6kGiK4gNZRyhXWh
         idr2ugm7flxAvyPPaXX30W+VLXzCEzs/8lcqntT3QepcnCyTIVLGR/5ZIRInFkQ9F02l
         GYMhPieqHF2zmoErKNJiKYQR4JksuipIOfJhGHbfovMMKHCWQ2zwHh1+rcoYO8p2V0Up
         A3gA==
X-Gm-Message-State: AJIora/bUw+tGKS/DsoelE4Q+bOYdmKmy9c14NPQasQuzHX6brT4zUeZ
        QFjwkkg3EdBc2e6lUWAo22wpOw==
X-Google-Smtp-Source: AGRyM1vO42CnUgwJEKE3lPzV1mTghn8QpMp5Icmi8ZY5d2az84r+c2xdR5hmJcVfB+ceOdgJZWDqtg==
X-Received: by 2002:a5d:430d:0:b0:210:2ce0:e2a9 with SMTP id h13-20020a5d430d000000b002102ce0e2a9mr17668939wrq.627.1656424261847;
        Tue, 28 Jun 2022 06:51:01 -0700 (PDT)
Received: from [192.168.0.254] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6106000000b00213ba0cab3asm14014874wrt.44.2022.06.28.06.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:51:01 -0700 (PDT)
Message-ID: <3ab8afab-b6b7-46aa-06d4-6740cee422d7@linaro.org>
Date:   Tue, 28 Jun 2022 15:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9e58f421c27121977d11381530757a6e@walle.cc>
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

On 28/06/2022 15:47, Michael Walle wrote:
> [adding Horatiu Vultur, because we now digress to the bug
> in the switch, rather than that odd OF behavior]
> 
> Am 2022-06-28 15:29, schrieb Andy Shevchenko:
>> On Tue, Jun 28, 2022 at 3:23 PM Michael Walle <michael@walle.cc> wrote:
>>>
>>>>> I was trying to fix the lan966x driver [1] which doesn't work if there
>>>>> are disabled nodes in between.
>>>>
>>>> Can you elaborate what's wrong now in the behaviour of the driver? In
>>>> the code it uses twice the _available variant.
>>>
>>> Imagine the following device tree snippet:
>>>   port0 {
>>>     reg = <0>;
>>>     status = "okay";
>>>   }
>>>   port1 {
>>>     reg = <1>;
>>>     status = "disabled";
>>>   }
>>>   port@2 {
>>>     reg = <2>;
>>>     status = "okay";
>>>   }
>>>
>>> The driver will set num_phys_ports to 2. When port@2 is probed, it
>>> will have the (correct!) physical port number 2. That will then
>>> trigger various EINVAL checks with "port_num >= num_phys_ports" or
>>> WARN()s.
>>
>> It means the above mentioned condition is wrong: it should be
>>
>> "port_idx >= num_phys_ports" (if the port_idx doesn't exists, that's
>> the bug in the first place)
> 
> I can't follow you here. Please note, that you need the actual
> physical port number. It's not a made up number, but corresponds
> to a physical port on that ethernet switch. So you can't just skip
> the disabled ones. port@2 must have port number 2.

The number "2" you get from the reg property, so where is exactly the
problem?

If you want to validate it against some maximum number of ports, based
on DTS, it makes no sense... One can supply a DTS with port number 10000
and 10000 nodes, or with specific property "maximum-port-number=10000".
It would make sense if you validate it against driver-hard-coded values
(which you later mentioned in your reply).


Best regards,
Krzysztof
