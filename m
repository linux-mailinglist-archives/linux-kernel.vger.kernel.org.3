Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BBB4FFFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiDMUDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiDMUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:03:48 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5278931
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:01:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r18so3586800ljp.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o4ItSd5UrGogzJFpfA7kpC8due1w5r/5uBtv2QX/BLA=;
        b=OIkZDE44VwpphzPpHz0O8HDe7L6c+KBHk7RmH018RtD5xGY7mBwQY2HD6V1uOWWGY3
         wNjbsEECS5Q2ybKvO2hGJ3sO0NhJPbx6SBQPBlFDwT2H71bJGjcBFWpWKqde7S2rdyS4
         a04dZYNME0jBv0MPkaie4FAdUIZY2KeptL1d5rGUlyLrB0r7iVqO7EOFnEyaS6TzjW4w
         D0ugaDvGt4fRq7XYBBfiXFqUldeJJKgzsJNOF+js5DHa8wXRlvPNVEwxKBGkCb9D4wfW
         QX5UrhyAjVvWgSmjSUlTUseMMowwSmJulaYdYbQyo2qlQp+n9ndc57qhD3J1W7eGwRu9
         r3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o4ItSd5UrGogzJFpfA7kpC8due1w5r/5uBtv2QX/BLA=;
        b=E1oEoBuldb+xS0l/UshWuB1iVEsqkhVBkgNFHsXpjYWQfzG1BvTUOOwsNaAT0LMaoQ
         TG+OLJ2Fgm+h56ZSw+MmwUJqONzWT10DJ5tE+XYFaolPuXN6NaEieXcrqgbwn9h/n16c
         4ghD79nq31sZ3eSQhLUu/tIWA+oKVlyJNBL8Ty/WkQ1ImkbjRnUCIgyU7VxXN0MiG7ts
         9WuJaXY/u5D42UT2U2Df0W7CDxW/g3T4MMxPCDwbSE0sapTUBroWDlR2uqpo6eORgAo/
         s6/c5s83+mfFyb+n2CBYONzZ7K+OCOiMUa8jsY6A9UyxWWlmzuyTYv3YwugHTm/Ldn78
         +e1A==
X-Gm-Message-State: AOAM530uOv82Ox8qCd0++4oHBhTxQR7Cb8p95TUNhxTqTuhzkCnHlOpe
        Z3FXH8wK6z7qkgLN1dDBXPuflA==
X-Google-Smtp-Source: ABdhPJwXAaLErFKexvX4iFWk0qnObYT8DdEbCpdcsrr6MExU3f/k0Cld8hQVf3ZMfgwwwlnRlniI8Q==
X-Received: by 2002:a05:651c:198c:b0:24c:8c34:d3cb with SMTP id bx12-20020a05651c198c00b0024c8c34d3cbmr1332145ljb.487.1649880083508;
        Wed, 13 Apr 2022 13:01:23 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e5-20020a2e8ec5000000b0024b6c2b5e58sm736197ljl.78.2022.04.13.13.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:01:23 -0700 (PDT)
Message-ID: <3626cd91-4c94-5b7d-4f3a-b9dcf026e2c9@linaro.org>
Date:   Wed, 13 Apr 2022 23:01:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-4-ansuelsmth@gmail.com>
 <20220325011037.03173C340EC@smtp.kernel.org>
 <Yj0XTYgoMScoiUHP@Ansuel-xps.localdomain>
 <20220325012231.899FBC340EC@smtp.kernel.org>
 <62570197.1c69fb81.c3de2.7b70@mx.google.com>
 <CAA8EJpp2uipTtV=gitiL0g-ywOirC=-UGrQ4tZMwc42jy2TK1Q@mail.gmail.com>
 <62570e48.1c69fb81.49fb8.143b@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <62570e48.1c69fb81.49fb8.143b@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,WEIRD_QUOTING
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 20:54, Ansuel Smith wrote:
> On Wed, Apr 13, 2022 at 08:32:21PM +0300, Dmitry Baryshkov wrote:
>> On Wed, 13 Apr 2022 at 20:00, Ansuel Smith <ansuelsmth@gmail.com> wrote:
>>>
>>> On Thu, Mar 24, 2022 at 06:22:29PM -0700, Stephen Boyd wrote:
>>>> Quoting Ansuel Smith (2022-03-24 18:13:49)
>>>>> On Thu, Mar 24, 2022 at 06:10:35PM -0700, Stephen Boyd wrote:
>>>>>> Quoting Ansuel Smith (2022-03-21 16:15:33)
>>>>>>> PXO_SRC is currently defined in the gcc include and referenced in the
>>>>>>> ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
>>>>>>> panic if a driver starts to actually use it.
>>>>>>>
>>>>>>> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
>>>>>>> ---
>>>>>>
>>>>>> What is this patch about? clk providers shouldn't be calling clk_get().
>>>>>>
>>>>>
>>>>> If pxo is passed as a clock in dts and defined as a fixed clock, what
>>>>> should be used?
>>>>
>>>> clk_parent_data
>>>
>>> Sorry but I'm not following you. No idea if you missed the cover letter
>>> where i describe the problem with PXO_SRC.
>>>
>>> The problem here is that
>>> - In DTS we have node that reference <&gcc PXO_SRC>
>>> But
>>> - gcc driver NEVER defined PXO_SRC
>>> As
>>> - PXO_SRC is actually pxo_board that should be defined as a fixed-clock
>>>    in dts or is defined using qcom_cc_register_board_clk.
>>>
>>> So in theory we should just put in PXO_SRC the clk hw of the
>>> fixed-clock. That is why I'm using clk_get(). I can use __clk_lookup()
>>> as an alternative but I really can't find a way to get the clock defined
>>> from DTS or qcom_cc_register_board_clk.
>>>
>>> (I have the same exact problem with the cpu qsb clock where is defined
>>> using fixed-clock API but can also defined directly in DTS and I have to
>>> use clk_get())
>>>
>>> I'm totally missing something so I would love some hint on how to solve
>>> this.
>>
>> When we were doing such conversion for other  platforms, we pointed
>> clock consumers to the board clocks directly. There is no need to go
>> through the gcc to fetch pxo.
>> Instead you can use a <&pxo_board> in the dts directly. Typically the
>> sequence is the following:
>> - Minor cleanup of the clock-controller driver
>> (ARRAY_SIZE(parent_data), removal of unused clock sources, unused enum
>> entries, etc)
>> - update drivers to use both .name and  .fw_name in replacement of
>> parent_names. Use parent_hws where possible.
>> - update dtsi to reference clocks using clocks/clock-names properties.
>> Pass board/rpmh/rpm clocks directly to their consumers without
>> bandaids in the gcc driver.
>> - (optionally) after several major releases drop parent_data.name
>> completely. I think we mostly skipped this, since it provides no gain.
>>
>> This way you don't have to play around clk_get to return PXO_SRC from
>> gcc clock-controller.
>>
>> -- 
>> With best wishes
>> Dmitry
> 
> Thanks for the list of steps to do this kind of cleanup.
>  From what I'm reading this series is ""stuck"" in the sense that I first
> have to fix the wrong PXO_SRC reference and then I can continue the
> conversion work. A bit sad considering most of the time DTS proposal got
> ignored :(

Not really. You can leave "pxo" as is. Use { .fw_name = "pxo", .name = 
"pxo_board" } as parent_data. Then pass <&pxo_board> as the "pxo" clock 
to the consumers. Yes, you will still have the lingering "pxo" / "cxo" 
clocks at this step. It's okay, they might be used by other drivers.

After the whole conversion is finished, you can make "pxo"/"cxo" 
registration conditional on !of_find_property("clocks") rather than 
using clk_get.

As a rule of thumb, you don't have to complete the whole thing in a 
single commit. Having smaller commits might be better.

[And yes, I'm looking forward to testing your cpufreq changes on my 
apq8064 devices].

-- 
With best wishes
Dmitry
