Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3725393D1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 17:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbiEaPTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 11:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiEaPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:19:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A61B633AE;
        Tue, 31 May 2022 08:19:34 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v25so9934961eda.6;
        Tue, 31 May 2022 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=N+gzwF9WjUL+s9Jd87RsXaHWROaYrbUpPPfYeYSq2m0=;
        b=jDPZdoS8gdk3Z0daYxEl0z2bsgq+HCA3JtAzBFR7gseEChqo89fhAXnzLERHS/+ZK1
         Xsm10Ifv5/KGcEU8riW4KRq+hirQzDUz8vf1WYmAq5RbupwcRlPGFLKlt356ENCs536A
         NR5qDA096KfWuocnafx0U1pJEuWayHFNQQuNdJNZuBfOUbjgythO82/rQfedb7WI336C
         4hYc9xiYDGqAOjbzDYNRDECrIDRkiFhe+V331dU17Rxgu34O1TCKEjK4kNLwxvuYbu+M
         UrnoSN9bfTG+BFZUtMiLeQoKKeoLFawvOKJ6CSu/RH1kwvS/kQoea1Nq3tta9FUM9xy9
         q+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N+gzwF9WjUL+s9Jd87RsXaHWROaYrbUpPPfYeYSq2m0=;
        b=lbot4DIK1IOSYTsbve9bZKUEcmGvdKIKmHlQm3gMB/3GAyzlai8nkUCL1Iw5i5eyx0
         xS0MjcCQwsXbXy5NceA4QmSscACD20czBr6myO1/IF0QuVFj1EQIMkRpBNoVluwkAdaA
         mlwqFIitcBbD19qcHaWGgl9wFnvnHOyWV5S0SGQjv/pvPpqF0lDoHvn6RJfah5YQo3I5
         h/+Th/wBRBCDrub5Cit/yxBGKiaufOxXGFt7SRggNS1Yrv4VDUqEceO56kgo/UJIdvXK
         XzCaWbjVmP4z5QRwlCy1uN4Bzbxh3Mbn4WZJRS0S6KVeZdZWAtMcNxaBvI7K7Y5aVV5g
         I+jQ==
X-Gm-Message-State: AOAM533jaQVUPOgUqbCsnDrKHLQaGkMucw7iBeEZRy1j5mqkYN3KNufh
        YULVS3p+RqUU9Fc0cOCqjN60Y3hTEDVaR2YW
X-Google-Smtp-Source: ABdhPJxyjgLMjKCTRWGq3uPhx8OZkxp2azKw7Z7GuEgEewF2KQxEb2J/kftAO0Z9qIvUpqTpWsuVvg==
X-Received: by 2002:a05:6402:1449:b0:42d:d250:e504 with SMTP id d9-20020a056402144900b0042dd250e504mr11024960edx.213.1654010372882;
        Tue, 31 May 2022 08:19:32 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5004:180:eafa:4efe:5389:9a7b? ([2a01:e11:5004:180:eafa:4efe:5389:9a7b])
        by smtp.gmail.com with ESMTPSA id ss14-20020a170907c00e00b006fec4ee28d0sm3072478ejc.189.2022.05.31.08.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 08:19:32 -0700 (PDT)
Message-ID: <eea10296-3c91-fe02-85b5-44de78733fbf@gmail.com>
Date:   Tue, 31 May 2022 17:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] HID: nintendo: fix face button mappings
Content-Language: en-US
To:     Roderick Colenbrander <thunderbird2k@gmail.com>,
        Max Fletcher <fletcher0max@gmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20220512001500.16739-1-fletcher0max@gmail.com>
 <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com>
From:   Martino Fontana <tinozzo123@gmail.com>
In-Reply-To: <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 > Second, even if the patch was right it would be tricky to merge. The
 > problem is that a changed mapping breaks user spaces and in general
 > can't do this unless there is a really good reason. It just would
 > break existing applications and libraries (often e.g. SDL)

The problem is that the userspace is already broken.
If, out of the box, you attempt to launch something that uses SDL (like 
Wine, or Super Tux Kart), the mapping you'll get will be wrong (and not 
visually, the buttons are literally swapped).
Right now, this can be worked around (it makes the mapping correct) by 
setting an environment variable (which isn't a thing that a user is 
supposed to be doing, and the patch will remove the need of it):
```
SDL_GAMECONTROLLERCONFIG=050000007e0500000920000001800000,Nintendo 
Switch Pro 
Controller,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,030000007e0500000920000011810000,Nintendo 
Switch Pro 
Controller,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,060000007e0500000620000000000000,Nintendo 
Switch Combined 
Joy-Cons,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:b14,dpdown:b15,dpleft:b16,dpright:b17,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,
```
The weird thing however is that SDL should already uses a controller 
database: 
https://github.com/libsdl-org/SDL/blob/main/src/joystick/SDL_gamecontrollerdb.h.
If this problem is caused by an SDL bug (I don't know if it is), then 
it's SDL that will need a patch, and the problem will be solved with 
zero repercussions. I think that SDL should be investigated before 
continuing to discuss this.

If, however, SDL is working as intended (making the patch necessary) and 
this patch is merged, it will make the mapping correct out of the box 
but it will also break a few things:
- Those who were using this workaround will have to remove it (by the 
way, the page on the Arch Wiki should be updated too: 
https://wiki.archlinux.org/title/Gamepad#Using_hid-nintendo_with_SDL2_Games);
- Applications that use raw joydev/evdev mappings (like Dolphin 
Emulator) will have to be reconfigured.
- Also, some applications use SDL2 mappings in a different way (for 
example, PCSX2), so out of the box the mappings are applied and the 
controller is mapped as expected. Merging the patch will break 
applications like these (in PCSX2's case it will be temporary since its 
database is updated weekly, but it will force the user to use the new 
kernel version, otherwise they will be stuck with a wrong mapping).

Whether it's a wise idea to merge this as soon as possible in order to 
cause the least amount amount of breakage, is not my call.


On 13/05/22 21:58, Roderick Colenbrander wrote:
> Hi Max,
> 
> Thanks for your patch, however I must say the patch is not correct for
> 2 reasons.
> 
> Over the years different controllers have different layouts. The
> standard which this driver (as well as others such as
> hid-sony/hid-playstation) follow is the Linux gamepad standard (see
> Documentation/input/gamepad.rst). It stays away of the debate what is
> A/B/X/Y. It talks about North/west/.., (yes they are macros which map
> to A/B/X/Y). In case of the Switch it does mean things are flipped,
> but it was not meant to represent an Xbox controller. (Technically one
> could argue that the Xbox controller should be flipped as it was the
> SNES controller back in the days which introduced X/Y and the Switch
> is still consistent with that.)
> 
> Second, even if the patch was right it would be tricky to merge. The
> problem is that a changed mapping breaks user spaces and in general
> can't do this unless there is a really good reason. It just would
> break existing applications and libraries (often e.g. SDL)
> 
> Thanks,
> Roderick
> 
> On Wed, May 11, 2022 at 8:12 PM Max Fletcher <fletcher0max@gmail.com> wrote:
>>
>> Previously, A and B would match the Xbox layout, but X and Y were incorrectly swapped. This corrects it so that X and Y match the Xbox layout.
>>
>> Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
>> ---
>>   drivers/hid/hid-nintendo.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index 2204de889739..7735971ede3f 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
>> @@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
>>                  input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
>>                  input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK);
>>                  input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
>> -               input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
>> -               input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
>> -               input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
>> -               input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
>> +               input_report_key(dev, BTN_X, btns & JC_BTN_Y);
>> +               input_report_key(dev, BTN_Y, btns & JC_BTN_X);
>> +               input_report_key(dev, BTN_B, btns & JC_BTN_A);
>> +               input_report_key(dev, BTN_A, btns & JC_BTN_B);
>>          }
>>
>>          input_sync(dev);
>> @@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs_l[] = {
>>
>>   static const unsigned int joycon_button_inputs_r[] = {
>>          BTN_START, BTN_MODE, BTN_THUMBR,
>> -       BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
>> +       BTN_A, BTN_B, BTN_Y, BTN_X,
>>          BTN_TR, BTN_TR2,
>>          0 /* 0 signals end of array */
>>   };
>> --
>> 2.35.3
>>
> 
> 
