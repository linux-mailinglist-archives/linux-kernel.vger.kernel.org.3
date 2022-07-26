Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616C2581943
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiGZR6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiGZR6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:58:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA6DF2;
        Tue, 26 Jul 2022 10:58:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id a9so10984761qtw.10;
        Tue, 26 Jul 2022 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GsDluhTDUq9T1XAH8j35rEpoLb7XXYwX8pV0xfq3Nes=;
        b=Ox0GzJGRbtbBrx0o7hvGb+9xTqQZyeeUMXTmgftFg5CENo0MuXfu4so3AYdXJGIdsX
         w2YLD7UmbkN1XaukovVDDXcegca0Zvqoiji+NhcEtZl/SqEFtd5QNitvGBlcScg5tFIM
         oQ0i2MFGbipz5RPZxjdNE9TutMEIhofRe7QQ6WIyVskUQlQ21Oc5pqPp2zQ4YFdqe7c+
         VrDONVnLdcX/q1aZVhnCSqYlwKa3iXeQXcuEEVA/FlUW2fU6KPEZCMkuFIG+KPpUwgA4
         5Y4x1j+Pi4j28PDShSiAcWYndoPtJur4cRPRyDNmLvt29SeAR0cP/31vusBmPR1sbQA4
         j8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GsDluhTDUq9T1XAH8j35rEpoLb7XXYwX8pV0xfq3Nes=;
        b=T6dUPxDfu01iSZ36xiy9nGXlTiT0rn28RkpFZRKrEygLRUctBIsgOU/tS0TCj/MfzK
         nBSmsGBv7NrPchbyVkmAsp3iX/31J/D3cD7ItKgDodr6wxovwKjBDJTNNvpmnJerfnZK
         qHXnQDmpnJPoD43OKb+SBUg84u9Gvc9PdPzoOCodLUiRXRbBqecDf3G2SIuj6tF26y7o
         AlwGzfkTZX4xxoc0+2pM3bjTuQk6Lx5CMKCRYxvygv38I8E5/joh5+pGNvbgkcv7QwEx
         hiIQQW0XcrSTLK0MLC7Yw+ZRpR1pzgDBRZmxA9diBp9CfEnJnCsM1dVJ6+Gs+2z9UFO8
         uECw==
X-Gm-Message-State: AJIora9vze5fgDew3NeBNetNHmiAtRzPuxAhWI4DzQgx+sB9QvY+uIu/
        QX+/lqCfktGG3f33lc+gPzc=
X-Google-Smtp-Source: AGRyM1uETOdIGqbEw3eF1isP3IPEsUjjxu+2K/0X5Vjskgr3nbCWi4yVFpeRbE+lT7/SWtk1565Esw==
X-Received: by 2002:ac8:59d3:0:b0:31e:ff86:f344 with SMTP id f19-20020ac859d3000000b0031eff86f344mr15326720qtf.199.1658858306955;
        Tue, 26 Jul 2022 10:58:26 -0700 (PDT)
Received: from [192.168.0.9] ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id g11-20020a05620a40cb00b006af08c26774sm12372867qko.47.2022.07.26.10.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:58:26 -0700 (PDT)
Message-ID: <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
Date:   Tue, 26 Jul 2022 13:58:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary> <20220725224841.GA75640@elementary>
From:   Stefan Hansson <newbie13xd@gmail.com>
In-Reply-To: <20220725224841.GA75640@elementary>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again!

On 2022-07-25 18:48, José Expósito wrote:
> Hi everyone,
> 
> On Sun, Jul 24, 2022 at 01:48:49PM +0200, José Expósito wrote:
>> On Fri, 22 Jul 2022, Stefan Hansson wrote:
>>> Hi!
>>>
>>> Somewhere between Linux 5.17.6 and 5.18.11 the Huion tablet I have stopped
>>> working properly. In GNOME Control Center it is identified as Huion New 1060
>>> Plus, however that's a different tablet than the one I have. Mine is a Huion
>>> Inspiroy H640, and it uses the hid_uclogic driver.
>>>
>>> With Linux 5.17.6, the tablet works as expected with all the buttons being
>>> detected and the stylus being usable. With 5.18.11, the buttons work fine but
>>> the stylus does not work correctly. The first time I approach the tablet with
>>> the stylus it works properly, i.e., the cursor on my screen moves around and
>>> follows the stylus around the tablet as expected. It continues working like
>>> this until I remove the stylus from the tablet. After I remove it from the
>>> tablet, the cursor never gets controlled by the stylus again. I can see that
>>> the tablet detects the stylus (it has a small indicator light), but the cursor
>>> doesn't move when I approach the tablet again. To clarify, with Linux 5.17.6,
>>> the cursor moves around just fine when I remove and then put it back to the
>>> tablet, just as you would expected.
>>>
>>> It may also be worth noting that it worked fine when I previously used it
>>> around six months ago, although I'm not sure what version of Linux I was using
>>> at that time (whatever Fedora shipped back then). I also tried reproducing it
>>> with yesterday's linux-next and Linux 5.19.0-RC7, and the behaviour was the
>>> same as 5.18.11. I am currently trying to bisect this, but it's not going very
>>> fast as I currently only have access to a dual core laptop from 2014, so
>>> building Linux takes a good while.
>>
>> Thanks a lot for reporting the issue.
>>
>> HUION and other non-Wacom tablets are handled by the UCLogic driver.
>> This driver is present in the kernel but its changes were deployed
>> and tested first in the DIGImend driver:
>> https://github.com/DIGImend/digimend-kernel-drivers
>>
>> A while ago, I started including in the kernel the code present in
>> DIGImend. At this moment, 5.19.0-RC7 and DIGImend have the same code
>> (well, 5.19 has more features, but they don't affect your tablet).
>>
>> I'm telling you this because it might be easier for you to bisect the
>> changes in the DIGImend driver as it builds way faster than the kernel.
>> Let me know if you need help bisecting it and I'll do my best to help
>> you.
>>
>> Is this your device?
>> https://www.huion.com/pen_tablet/Inspiroy/H640P.html

Yes :)

>> It is affordable, so I ordered it. I don't have any HUION devices to
>> debug and this is a good excuse to buy one ;)
>> I'll let you know how it goes once I receive it.
> 
> The tablet arrived today and it is a bank holiday in Spain, so I had
> some time to bisect the bug.
> 
> The first bad commit is 87562fcd1342 ("HID: input: remove the need for
> HID_QUIRK_INVERT"):
> https://lore.kernel.org/all/20220203143226.4023622-11-benjamin.tissoires@redhat.com/
> (CCing the folks whose email is in the patch tags)
> 
> I reverted the patch on hid/for-next and, after fixing a tiny conflict,
> I can confirm that the tablet works again as expected.

Thanks for looking into this! Bisecting has been slow on my end 
unfortunately. I built today's linux-next (20220726) with your proposed 
patch below and my drawing tablet curiously still does not work as 
expected. The stylus works a couple of times, but eventually stops 
working (unlike prior where it always seemed to only work once). Do I 
need both your revert and this diff for it to work properly?

Also, do you know whether the revert be backported to stable 5.18?

> I'd need to investigate a bit more over the weekend, but I think that
> all HUION tablets with the latest firmware (internally, v2) are
> affected.
> 
> Those tablets do not set the inrange bit (UCLOGIC_PARAMS_PEN_INRANGE_NONE).
> The driver sets it and uses a timer to remove it.
> See drivers/hid/hid-uclogic-core.c, function uclogic_raw_event_pen().
> 
> However, at least the Huion Inspiroy H640, sends a 0x00 byte when the
> tool is removed, making it possible to fix it in the driver [1].
> 
> Unfortunately, the affected code path is used by many tablets and I
> can not test them, so I'd prefer to hear Benjamin's opinion and see if
> this should be fixed in hid-input rather than in the driver before
> sending a fix.
> 
> Best wishes,
> José Expósito
> 
> [1] Diff of a possible fix:
> 
> diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
> index 47a17375c7fc..bdcbbd57d0fc 100644
> --- a/drivers/hid/hid-uclogic-core.c
> +++ b/drivers/hid/hid-uclogic-core.c
> @@ -316,8 +316,11 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
>          }
>          /* If we need to emulate in-range detection */
>          if (pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
>                  /* Set in-range bit */
> -               data[1] |= 0x40;
> +               if (data[1])
> +                       data[1] |= 0x40;
> +
>                  /* (Re-)start in-range timeout */
>                  mod_timer(&drvdata->inrange_timer,
>                                  jiffies + msecs_to_jiffies(100));
Regards,
Stefan Hansson
