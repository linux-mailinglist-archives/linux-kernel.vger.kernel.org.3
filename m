Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17F653D6F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 15:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346671AbiFDNLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiFDNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 09:11:36 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E299253B77;
        Sat,  4 Jun 2022 06:11:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n10so20745514ejk.5;
        Sat, 04 Jun 2022 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FEDTgPDYr/JrMIvyDJDWCeB3cATgiGP7XKqUeswVrm0=;
        b=YwKofZ2PRKrVP9fWN6poJYzJiF2ulBXgN06HchVHNod+Zf3+1oXJHdmQKyNdMAUUiT
         rVwdMxo6wdABTi+Wz9O7NJETKjs6lqHJaEsgA3w7CKKokaBdOaLQuMyysBlVcEaNywny
         fFeulaU9t1SKItwo5mI4caV7BJ8J9cvoY7nflOM9GI2BmAkd+ZTdxCw7OGpX0yGS/IA5
         xafUfQLAACGmPb9Fvg+HeZu0auSvQwgkhi2bpVcK+4E/QVJ0oXH9GWNMNXhuD3xS/4kw
         aTVWLktA86vXTdY0yyuzSKqQjNJsv/YqZpb3DOcwVMp/YmHAnE/kPWDR6Uy1igu1BfR8
         r/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FEDTgPDYr/JrMIvyDJDWCeB3cATgiGP7XKqUeswVrm0=;
        b=Xc0e+pwUzfampb7oExTiFimgtuALMj4TjA0jBhJvIuU354nPYHWqd9fu3ynJI3xD2N
         PbWHzJyqidc1t3+y2r3MPGA++uHscR5zRduNELFeH5+VK2FQAOBzTE+iXKzADvwaNT4l
         vhdmIjtJx3VmhxBZJUXZzHmJz0KqUvC/ptfR2SgiZeHL7QqLeX+yuaOAM6emkhSLJWoa
         F+DOuPRiFo+jeb+0li3ROQgT6VYfco3g17ZOo3ud0HPaJuuzzvqr33tD+lgxMoosu4vo
         5pYjm/sqV/SHpmJtjlQqhVatb8ZNNV8oX7OgyfFKEHxmu4n5Vt/IPa52uNdYgRUi62Na
         AlbA==
X-Gm-Message-State: AOAM530u2+VN7wXkbyXNYgrscunp432iSKaZhlMv5jKty4/UcYp/nr/g
        j5j/7FwQ53mT+xiJGfrVsAM=
X-Google-Smtp-Source: ABdhPJx5hF9V9ebt3VbSfc1eolgwSE59Anu6ytFiq0pFiVcY3wexuufEpBcWkxGhfj+bONfzCGXp4g==
X-Received: by 2002:a17:907:3e82:b0:6ff:1e04:a365 with SMTP id hs2-20020a1709073e8200b006ff1e04a365mr13085439ejc.617.1654348289247;
        Sat, 04 Jun 2022 06:11:29 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5004:180:b236:b316:50dd:720e? ([2a01:e11:5004:180:b236:b316:50dd:720e])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906724800b006fee526ed66sm3962521ejk.35.2022.06.04.06.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jun 2022 06:11:28 -0700 (PDT)
Message-ID: <ec8722db-368a-6bf1-e4ac-7fe76bd39343@gmail.com>
Date:   Sat, 4 Jun 2022 15:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] HID: nintendo: fix face button mappings
Content-Language: en-US
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Max Fletcher <fletcher0max@gmail.com>,
        "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20220512001500.16739-1-fletcher0max@gmail.com>
 <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com>
 <eea10296-3c91-fe02-85b5-44de78733fbf@gmail.com>
 <CAEc3jaBA=jf251T8w9hbRyHu2BnKXRvK5CD9DxyYMe_Q79H0CQ@mail.gmail.com>
From:   Martino Fontana <tinozzo123@gmail.com>
In-Reply-To: <CAEc3jaBA=jf251T8w9hbRyHu2BnKXRvK5CD9DxyYMe_Q79H0CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made a PR: https://github.com/libsdl-org/SDL/pull/5755.

On 31/05/22 17:31, Roderick Colenbrander wrote:
> On Tue, May 31, 2022 at 8:19 AM Martino Fontana <tinozzo123@gmail.com> wrote:
>>
>>   > Second, even if the patch was right it would be tricky to merge. The
>>   > problem is that a changed mapping breaks user spaces and in general
>>   > can't do this unless there is a really good reason. It just would
>>   > break existing applications and libraries (often e.g. SDL)
>>
>> The problem is that the userspace is already broken.
>> If, out of the box, you attempt to launch something that uses SDL (like
>> Wine, or Super Tux Kart), the mapping you'll get will be wrong (and not
>> visually, the buttons are literally swapped).
>> Right now, this can be worked around (it makes the mapping correct) by
>> setting an environment variable (which isn't a thing that a user is
>> supposed to be doing, and the patch will remove the need of it):
>> ```
>> SDL_GAMECONTROLLERCONFIG=050000007e0500000920000001800000,Nintendo
>> Switch Pro
>> Controller,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,030000007e0500000920000011810000,Nintendo
>> Switch Pro
>> Controller,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,060000007e0500000620000000000000,Nintendo
>> Switch Combined
>> Joy-Cons,platform:Linux,a:b0,b:b1,x:b3,y:b2,back:b9,guide:b11,start:b10,leftstick:b12,rightstick:b13,leftshoulder:b5,rightshoulder:b6,dpup:b14,dpdown:b15,dpleft:b16,dpright:b17,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b7,righttrigger:b8,
>> ```
>> The weird thing however is that SDL should already uses a controller
>> database:
>> https://github.com/libsdl-org/SDL/blob/main/src/joystick/SDL_gamecontrollerdb.h.
>> If this problem is caused by an SDL bug (I don't know if it is), then
>> it's SDL that will need a patch, and the problem will be solved with
>> zero repercussions. I think that SDL should be investigated before
>> continuing to discuss this.
> 
> It looks like SDL lacks the patch to deal with the upstream driver
> properly. The chicken and egg problem SDL there is between the kernel
> and SDL, is that SDL supports a device prior to there being a kernel
> driver (or there being enough penetration for one). Without a driver,
> many devices function with an often strange mapping. That's the
> mapping SDL has in its table (for hid-generic). When a kernel driver
> comes around with a different, but proper mapping there is an issue.
> 
> At the time we first dealt with this for DualShock 3 / 4 devices. The
> trick used then was to patch the 'version' bit of the HID device with
> '0x8000'. This resulted in a different mapping line. To understand SDL
> uses a GUID as the index for the table, it is composed of
> vendor/product id, version id and other fiels. The patched version,
> resulted in a different GUID, which then allowed SDL2 to recognize the
> device properly as it would use a different mapping line.
> 
> For the Switch controllers, it looks like no patched line was added.
> Someone would need to provide a patch.
> 
>> If, however, SDL is working as intended (making the patch necessary) and
>> this patch is merged, it will make the mapping correct out of the box
>> but it will also break a few things:
>> - Those who were using this workaround will have to remove it (by the
>> way, the page on the Arch Wiki should be updated too:
>> https://wiki.archlinux.org/title/Gamepad#Using_hid-nintendo_with_SDL2_Games);
>> - Applications that use raw joydev/evdev mappings (like Dolphin
>> Emulator) will have to be reconfigured.
>> - Also, some applications use SDL2 mappings in a different way (for
>> example, PCSX2), so out of the box the mappings are applied and the
>> controller is mapped as expected. Merging the patch will break
>> applications like these (in PCSX2's case it will be temporary since its
>> database is updated weekly, but it will force the user to use the new
>> kernel version, otherwise they will be stuck with a wrong mapping).
>>
>> Whether it's a wise idea to merge this as soon as possible in order to
>> cause the least amount amount of breakage, is not my call.
>>
>>
>> On 13/05/22 21:58, Roderick Colenbrander wrote:
>>> Hi Max,
>>>
>>> Thanks for your patch, however I must say the patch is not correct for
>>> 2 reasons.
>>>
>>> Over the years different controllers have different layouts. The
>>> standard which this driver (as well as others such as
>>> hid-sony/hid-playstation) follow is the Linux gamepad standard (see
>>> Documentation/input/gamepad.rst). It stays away of the debate what is
>>> A/B/X/Y. It talks about North/west/.., (yes they are macros which map
>>> to A/B/X/Y). In case of the Switch it does mean things are flipped,
>>> but it was not meant to represent an Xbox controller. (Technically one
>>> could argue that the Xbox controller should be flipped as it was the
>>> SNES controller back in the days which introduced X/Y and the Switch
>>> is still consistent with that.)
>>>
>>> Second, even if the patch was right it would be tricky to merge. The
>>> problem is that a changed mapping breaks user spaces and in general
>>> can't do this unless there is a really good reason. It just would
>>> break existing applications and libraries (often e.g. SDL)
>>>
>>> Thanks,
>>> Roderick
>>>
>>> On Wed, May 11, 2022 at 8:12 PM Max Fletcher <fletcher0max@gmail.com> wrote:
>>>>
>>>> Previously, A and B would match the Xbox layout, but X and Y were incorrectly swapped. This corrects it so that X and Y match the Xbox layout.
>>>>
>>>> Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
>>>> ---
>>>>    drivers/hid/hid-nintendo.c | 10 +++++-----
>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>>>> index 2204de889739..7735971ede3f 100644
>>>> --- a/drivers/hid/hid-nintendo.c
>>>> +++ b/drivers/hid/hid-nintendo.c
>>>> @@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
>>>>                   input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
>>>>                   input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK);
>>>>                   input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
>>>> -               input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
>>>> -               input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
>>>> -               input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
>>>> -               input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
>>>> +               input_report_key(dev, BTN_X, btns & JC_BTN_Y);
>>>> +               input_report_key(dev, BTN_Y, btns & JC_BTN_X);
>>>> +               input_report_key(dev, BTN_B, btns & JC_BTN_A);
>>>> +               input_report_key(dev, BTN_A, btns & JC_BTN_B);
>>>>           }
>>>>
>>>>           input_sync(dev);
>>>> @@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs_l[] = {
>>>>
>>>>    static const unsigned int joycon_button_inputs_r[] = {
>>>>           BTN_START, BTN_MODE, BTN_THUMBR,
>>>> -       BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
>>>> +       BTN_A, BTN_B, BTN_Y, BTN_X,
>>>>           BTN_TR, BTN_TR2,
>>>>           0 /* 0 signals end of array */
>>>>    };
>>>> --
>>>> 2.35.3
>>>>
>>>
>>>
