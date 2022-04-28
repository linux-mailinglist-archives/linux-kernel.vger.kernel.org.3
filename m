Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95DD513B48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349793AbiD1ST4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350874AbiD1STu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:19:50 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01937496BE;
        Thu, 28 Apr 2022 11:16:34 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i8so2516705ila.5;
        Thu, 28 Apr 2022 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T6XQPBzj4qlVESNMSZre3n1h1i/4cIcF55AXPyrVmO0=;
        b=b+L+dq2BmBZ5rFSSjn+fZzmtwTSK3h/eTgN3BK+wpEUunnkE+McgN7oLLboGmjrtAj
         TFTGdCvYZYr4L8lUQyMAYYGiSStwV7B2FtAKG3hdDyD8uxRd87swTSH4uBy7Nom6pN+b
         mqxXIsrH+XQvZYcj1OdD7cUWJsp5YGsEP/BahEZOBVhzpAIU/tygBQ745CMzJLcCmB2p
         0VN0PU9xuuSGFfXfqlKTqHqgJ1+B+7v5RfAJ5COEUctUDtU7dXis5pfwhU98cQnLwzqU
         ugkdUx2i3AjiVzNk3A9ySo2yaovSHYWEY6RpS9zqjVAq7TwKa7Wbrw+od3QgjDDbTmNv
         NV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T6XQPBzj4qlVESNMSZre3n1h1i/4cIcF55AXPyrVmO0=;
        b=TItOFLRWKN1HvEMplTGVIQKSkFNCEQxIOkt3cMiW2ey7BZQrHCJc3a8Kb1hN69c3n3
         qEQaCv4H2CLP8N78fT54bKFiBs9pPJXRdysuq4FCJw+GWsbQzYcXSDq+BMpoCYfo5GbK
         Y+Yds1GnuOioVgh46DHoZDnXZAD5K72mdLaXQ1RPyBd1dGd/q3IkpVbMknqsgpyMKC5X
         Dq36Wf5nmSUEWuJxtXxZMV/tMxiDgYWdVr/058clITzkReedLD46EL0avAwayEq1dQWp
         jiKn18N3VGrNvkEwxhSvfnBv+gm7GoKyy4NtdoExTCdMGP6UGiT/VDmCCa07w7oqWZVe
         QOig==
X-Gm-Message-State: AOAM532RoFXglrTQaHSJMqQ0euvyIh5e8f4NUO6zSJHEn1VM8pSsB13I
        51pTX9EeZqOIIOK0VoJhFyA=
X-Google-Smtp-Source: ABdhPJw7nR8ryMafd3FK4Xp5kpi8QwxX4jGk+pbNVcIsd5g7BYxHuiLfYeOTHDKBZJrVLy01ZuMLjw==
X-Received: by 2002:a05:6e02:1905:b0:2cd:9176:58ab with SMTP id w5-20020a056e02190500b002cd917658abmr9225125ilu.81.1651169794434;
        Thu, 28 Apr 2022 11:16:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:75d0:a34:61ff:fa0b? ([2600:1700:2442:6db0:75d0:a34:61ff:fa0b])
        by smtp.gmail.com with ESMTPSA id k17-20020a92c9d1000000b002cacb37614esm302542ilq.43.2022.04.28.11.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 11:16:33 -0700 (PDT)
Message-ID: <93d88940-1fb1-ce6c-4e1e-84bc868e7ff9@gmail.com>
Date:   Thu, 28 Apr 2022 13:16:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] of: unittest: rename overlay source files from .dts
 to .dtso
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
References: <CAMuHMdXPn9FHr41xmihuuzNNNKvY-50yAwY4HyuyVo6qBn=Z1w@mail.gmail.com>
 <CAMuHMdWeL3DOXY3xcPOBW2WDDGW3PxgSM8didt7J1KxSm1ivJg@mail.gmail.com>
 <CAMuHMdWXXoS9mmX9VWRQyXfmsy8YROgpLZ-xB7zthEdPdM2u4A@mail.gmail.com>
 <CAMuHMdVWkSnki8VQDaYRzJ8yu8xtEKpXyfQppTtw3wXDQPmYzw@mail.gmail.com>
 <d4b7ce06-23e7-1c60-cc0c-b6aea07e0a1a@gmail.com>
 <CAL_JsqKTckMABk6cM8d=boZcHyLdcqYmbzfKDjAHdCXoCPSDtg@mail.gmail.com>
 <CAMuHMdU4oUKaGxmaPiC=cX0XpHG3KXhr+4MywEfeQ8sq-EG18A@mail.gmail.com>
 <CAL_JsqL3fHXNdGS=ap6+5Y25T2zmnDYRkt5dNV9mW7hyanVvuw@mail.gmail.com>
 <CAL_JsqJn459-8wnwT0N0CKumnvh_gDkVdgVebvMVa13oTxfQ=g@mail.gmail.com>
 <CAMuHMdUyuJbyHthc4ATuRXY=zM_Vbc7DmsZvWgX_u8w3FfhzDg@mail.gmail.com>
 <YmqRK1uWiady7BHD@robh.at.kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <YmqRK1uWiady7BHD@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 08:05, Rob Herring wrote:
> On Thu, Apr 28, 2022 at 08:25:31AM +0200, Geert Uytterhoeven wrote:
>> Hi Rob,
>>
>> On Wed, Apr 27, 2022 at 11:14 PM Rob Herring <robh@kernel.org> wrote:
>>> On Wed, Jan 26, 2022 at 1:31 PM Rob Herring <robh@kernel.org> wrote:
>>>> On Fri, Jan 14, 2022 at 3:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>>> On Fri, Jan 14, 2022 at 3:10 AM Rob Herring <robh@kernel.org> wrote:
>>>>>> On Thu, Jan 6, 2022 at 11:23 AM Frank Rowand <frowand.list@gmail.com> wrote:
>>>>>>> Patient Geert has pinged again.
>>>>>>
>>>>>> If it's not a patch to be reviewed, then I'm not going to see it most
>>>>>> likely. I don't read the DT list regularly...
>>>>>
>>>>> Fair enough...
>>>>>
>>>>>>> If I remember correctly you guys were not thrilled with this idea, but
>>>>>>> also did not seem strongly against it.  Are you willing to go along
>>>>>>> with .dtso for overlay source files?  If so, I will revive this patch
>>>>>>> series.
>>>>>>>
>>>>>>> David, if you are against supporting .dtso in the dtc compiler then
>>>>>>> the kernel can still support it through make rules.
>>>>>>
>>>>>> I'm not really interested in diverging from dtc. I'd suggest moving
>>>>>> the discussion to dtc list and/or devicetree-spec if you want to get
>>>>>> more attention on this.
>>>>>
>>>>> What needs to be supported in the dtc compiler?
>>>>> The fallback passed to guess_input_format() is "dts".
>>>>> So this has been working out-of-the-box since forever?
>>>>
>>>> Ah, okay.
>>>>
>>>>>> Also, keep in mind that extensions also affect MIME types which
>>>>>> someone was also asking about recently.
>>>>>
>>>>> You mean "MIME type of Devicetree Blobs and Sources"[1]?
>>>>> According to [2](2022-01-13), none of that has happened.
>>>>
>>>> This is what I was thinking of:
>>>>
>>>> https://github.com/devicetree-org/devicetree-specification/issues/46
>>>>
>>>> In any case, given everyone is ambivalent, send me an updated patch
>>>> and I'll apply it.
> 
> ^^^^^^^^
> 
>>>
>>> Ping! Anyone still want this?
>>>
>>> What I don't want to see is a mixture of .dts and .dtso. And now I'm
>>> reviewing RPi overlay patches[1] with .dts.
>>
>> I still prefer .dtso over .dts, as it allows tools to detect the file
>> type without having to read the file's contents.
>> Without this, e.g. make needs to have all overlays listed explicitly
>> in a Makefile.
>>
>> We do have .c, .h, .s (even .S), .dtsi. So why not .dtso?
> 
> Read above! I said to resend this patch and I will apply it.

Sorry for the delay.  Earlier I said the I would rework the patch (if needed
for the current kernel) and resend.  I've been distracted by other things
like bug fixes.  Otherwise resending this patch is at the top of my todo
list.

-Frank

> 
> Rob

