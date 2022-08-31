Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B715A7DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiHaMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiHaMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:52:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB898B8F2E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:52:15 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by6so14503393ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hVxQm1TCSPVxMOrNlZWxpTg8PwWR+LHcRexmoisEYJ8=;
        b=tkWB8OAP/4fnwzsME4LYY9tsGNNhO5MvYbnypygMcliDTi+2X2AhbCng5occi3+kS5
         JHFOXBaDChiNh6heHKhyHjOlt6kiXn5kXY9bCEOYF8ZFXWdkBCU1bZSZC3oLQPH+A/b8
         Fmtdu27pIsmr4NC4zpg/w5biWEQ/YPYxXz90kwBuFUO7kld299Cf1HPmKfOAsr02BLT0
         4HImdRJfEI/Wj8O667sYLyyGw2gtbY4NrTRy1FXz9RuD/vOlTTI6Vp33TtQ4p14r8HT2
         I0W4wxaqNypKktUf1ds76H9t/Bmy1hHYuCoZY6t6tFdOuogfgdIYnhzkWBuepOJ4kwMg
         IUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hVxQm1TCSPVxMOrNlZWxpTg8PwWR+LHcRexmoisEYJ8=;
        b=GcJnB0OG2rd1DpVF//6Bv/SqhLGvbbbMTJ5ucVGb/H/BN08jWjlr0YRxrYNJi4faND
         gEeYP98KSj3MURwjOQAOJ32swC7eYGxUbrXxOc/6EMmAjkGQxJtX2/+YWa60Xsk/w5x4
         H9qA3nunHhj8g3aQ++WA2AmP57NWsUTl8GC1K9OaocVbisAHcC7l7jfHoLNcdThm2xH5
         kt/OARyjY4Zt77qFMjDg/vVJESSqWjAoKp8NameJMHG4B8YbFyifP1xwZsCEpk82mPYg
         zSRQKo27uWMSGJaDhwUYdn04AOJpZ8pshy8p6M75vKEeoDzuua2EjLi1QuqOnafwm/5D
         s7FQ==
X-Gm-Message-State: ACgBeo0zaDyvpjD6NgQRUycbTKf7736TsKL/y84yvBt65+Ih4tEnv71V
        1AN2g5p0uyHPt0RTU4HN1CloDQ==
X-Google-Smtp-Source: AA6agR57VgH5pRDQ+GJNmeB4maQmvrKm2Y2EPG5e/Q7Xu0/XnjlEtK4UqUsYajs2YLx/efsFyn2SMA==
X-Received: by 2002:a05:651c:198e:b0:261:d4a5:db55 with SMTP id bx14-20020a05651c198e00b00261d4a5db55mr9572265ljb.231.1661950331097;
        Wed, 31 Aug 2022 05:52:11 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c049e00b00263f036b405sm1400052ljc.70.2022.08.31.05.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 05:52:10 -0700 (PDT)
Message-ID: <9e37285e-9408-7adb-1242-77f580573283@linaro.org>
Date:   Wed, 31 Aug 2022 15:52:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 2/2] nvmem: lan9662-otp: add support.
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, UNGLinuxDriver@microchip.com
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
 <20220831064238.102267-3-horatiu.vultur@microchip.com>
 <1ddf261e-55fb-e30c-93b0-efb9bc0987b3@linaro.org>
 <20220831105237.ot5aaawnrwjqmjgj@soft-dev3-1.localhost>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220831105237.ot5aaawnrwjqmjgj@soft-dev3-1.localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/2022 13:52, Horatiu Vultur wrote:
> The 08/31/2022 10:29, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,
> 
>>
>> On 31/08/2022 09:42, Horatiu Vultur wrote:
>>
>>> +static const struct of_device_id lan9662_otp_match[] = {
>>> +     { .compatible = "microchip,lan9662-otp", },
>>> +     { .compatible = "microchip,lan9668-otp", },
>>
>> This is still wrong, does not match your bindings at all and still
>> duplicates entries without driver data. One entry - 9662.
> 
> I have look at some other drivers, where I can see they don't have any
> driver data. For example [1] and the bindings are here [2].
> 
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/ti/cpsw_new.c#L1832
> [2] https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml#L23

There are plenty of poor examples in Linux kernel code and it is not a
reason to re-use their patterns...

> Is this also wrong, or I still can't understand how the bindings are
> working?

The topic here is not that much related to the bindings, but device
matching in Linux kernel.

> 
> If I put only one entry:
> ---
> static const struct of_device_id lan9662_otp_match[] = {
>      { .compatible = "microchip,lan9662-otp", },
> ---
> 
> Wouldn't be a problem that the binding mentions also lan9668?

No. What could be the problem exactly, which you are afraid? Why
implementation should be a problem for a binding (which we try to be
mostly implementation independent)?

Best regards,
Krzysztof
