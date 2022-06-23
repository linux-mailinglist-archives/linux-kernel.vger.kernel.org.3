Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59101558B36
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 00:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiFWWYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 18:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiFWWYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 18:24:14 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89C4F447;
        Thu, 23 Jun 2022 15:24:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m184so285957wme.1;
        Thu, 23 Jun 2022 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=o9e7Ts6Hi1opGJ+Atgw8mcn0YfjvILiLQjVr7seDMqI=;
        b=cQ2r0YSj1G3iIlkPp6y6hD8Q5AAqYFX9fj5ddmgVVL+fNOom/gJ0WpQLxLOvfe9S3t
         juc4g3J5H0Nyu8vKcWqy0wVLLvJSq+XfuDSeamNbKBe4cJNK7QX8JyLcFgmzearj64ri
         9LI+NblNTRWj1psOFS+dGrs9arCYwMaMr7MR4YWfgWpoCQ61Nm/2hXhDFptZSVv/Vs71
         nkr7qnPCW5yn3vp13tCPhcnR4YOx8UAuZ6pFOo1RtZ3cVRrMCd73x1YI0p2rFLa1Dw28
         dP7GMCAvpyQaK24vFr36fFwz93yHeF6Mr5m3UX1Z+Y8YROkjOwecMzMGkwveiK5bBedx
         Chww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o9e7Ts6Hi1opGJ+Atgw8mcn0YfjvILiLQjVr7seDMqI=;
        b=ttyh2jjTwsi1ewYJ2bMxYB8i4a6CvJpMZUz/BoNsC6RZGxaxhIO7Sz/67zUVm1WIBc
         7yqLRbz8Fpy6MrmxPliF0OrCQiCEaOLnV/n3hfukvo0SH1BCoMs/BujbC5QDl3jaG1AJ
         qyZYpflfWlvFdgPVlvGhDS0kj9eTkZDTea2RPyxylSPa5kfsgjz0ywSjKYTZtuMM9e1m
         rtdslGMqvqBhX9V5ltM3txd1bq6VgCNj7SvUl91Ag1/ZRKeZUuU/XTe1S6BImYRXB6jw
         g4L6oXESlAX4g86q5Tq8p87W0QfpbnQk0Y9t/Vy4lO31s90TjfpQqInb3HYMBwqabaMD
         rjzQ==
X-Gm-Message-State: AJIora94lDrvlnkYxCKeTwetP6Drf7v5D4g9IarXHdtrr4NuHbkwl3Qs
        IjH2j6XgUF4XZdXFABuHpIU=
X-Google-Smtp-Source: AGRyM1s5VhCyYuY1AsAMuPOJCF1TBATF4MKTEVmcjplu6RT/IEdRP88V6ybdqnTVUVR7q2b51cxt9Q==
X-Received: by 2002:a05:600c:414b:b0:3a0:331b:4199 with SMTP id h11-20020a05600c414b00b003a0331b4199mr172150wmm.193.1656023052224;
        Thu, 23 Jun 2022 15:24:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id j25-20020a5d4539000000b0021b86dbad37sm517511wra.68.2022.06.23.15.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 15:24:11 -0700 (PDT)
Message-ID: <3f37e3fa-1b7d-1dbb-327c-69a4e96bdcdc@gmail.com>
Date:   Fri, 24 Jun 2022 00:24:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Content-Language: en-US
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        spbnick@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <20220623175116.GA4757@elementary>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there!

On 23/06/2022 19:51, José Expósito wrote:
> Hi Stefan,
> 
> On Wed, Jun 22, 2022 at 11:31:05PM +0200, Stefan Berzl wrote:
>> Hello!
>>
>>>> >From f9bb82e400effd3aea37b2be710add9e2bb832da Mon Sep 17 00:00:00 2001
>>>> From: Stefan Berzl <stefanberzl@gmail.com>
>>>> Date: Fri, 11 Mar 2022 04:04:30 +0100
>>>> Subject: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
>>>>
>>>> ...
>>>
>>> Stefan,
>>>
>>> sorry for not responding earlier, but this patch somehow fell in between 
>>> cracks. Please for your further submissions do not forget to at least CC 
>>> some of the relevant malinglists as well.
>>
>> Will do... I am still new to the process and tend to forget things, but 
>> I'll do my best.
>>
>>> Quite a lot has changed in uclogic driver since then, as José has been 
>>> pushing quite a lot of code there from DIGImend project ... could you 
>>> please update your patch on top of current codebase and resend it?
>>>
>>> Thanks,
>>>
>>
>> I think you'll be pleased to find that José's work is basically a 
>> superset of mine, therefore eliminating the need for my patch 
>> altogether. When running his newest deco l code, the deco mini 7 is 
>> fully supported as well. I should have given a tested-by or something, 
>> but since I am still new to this, I was kinda hesitant with the big 
>> changes introduced by the newest digimend work. As you know, there is no 
>> sort of registry to differentiate devices by ability, so one or two
>> useless evdev devices are generated for hardware the tablet may or may 
>> not have, like "Touch Ring" or "Touch Strip". I thought that this might 
>> cause confusion and would have to be amended.
> 
> Useless event nodes should not be created. At the moment, the driver
> disables all interfaces that are not used and, after switching to "raw"
> mode, it should only create a node for each valid device.
> 
> At the moment, there are only HID descriptors for the frame and the pen
> so, if your tablet is creating a touch ring device, something is not
> working as expected.
> 
> Running "sudo libinput record" should display only the frame and the
> pen. Does it show something different in your case?
> 
> 	$ sudo libinput record
> 	[...]
> 	/dev/input/event21:	Hanvon Ugee Technology Co.,Ltd Deco L
> 	/dev/input/event22:	Hanvon Ugee Technology Co.,Ltd Deco L Pad

This is certainly true for the newer xppen devices we are working on. 
However, while waiting for the xppen stuff to gain support, I bought a
tablet  that's already supported, the Gaomon S620. Executing libinput 
record or any other command that lists the devices, like evemu-describe, 
gives:

/dev/input/event15: GAOMON Gaomon Tablet
/dev/input/event16: GAOMON Gaomon Tablet Pad
/dev/input/event17: GAOMON Gaomon Tablet Touch Strip
/dev/input/event18: GAOMON Gaomon Tablet Dial

>> There is however one caveat that seems to be unique to the mini7, which 
>> is the ack packet that is sent when switching to the vendor defined 
>> usage. It doesn't do much though, as currently it gets interpreted as a 
>> pen report and since it doesn't have useful values, causes the cursor to 
>> go to the top left screen position. Since the ack packet is only sent 
>> once, it ought to be of little consequence.
>>
>> I would of course fix this, but I don't really know what's the preferred 
>> way. One can obviously simply set up an urb to catch this, but it would 
>> have to be a special corner case for the mini 7, as José assures me that 
>> none of his tablets display similar behavior. Is this acceptable?
> 
> My tablets also send an ACK packet, but in my case it does not have any
> visible effects. Maybe it is related to the DE environment used. I
> tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
> ACK is ignored... But catching it is fine, we can include the code you
> suggest.

Can the contents maybe differ?

This is the ack the mini 7 gives me:
02 b1 04 00 00 00 00 00 00 00 00 00

While this is a button:
02 f0 00 00 00 00 00 00 00 00 00 00

And here we have pen movement:
02 a1 59 23 ef 32 b8 0e 00 00 00 00

>> José already had a look at some firmware device descriptor string that 
>> reports the number of buttons and what not, but as far as I know, it 
>> doesn't say anything about ack packets (right José? Does it say 
>> anything about touch strips or similar?).
> 
> In the devices I tested, the ACK packet is always present, so it should
> be fine to catch it. I'll test your patch in all the devices I own to
> be safe.
> 
> Best wishes,
> Jose
> 

Yours truly
Stefan Berzl
