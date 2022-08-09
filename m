Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8C258D3A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236682AbiHIGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234904AbiHIGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:20:06 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99661FCCF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:20:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so13251402wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=HzJEHEogclImFx3JS53NA1MN0TYdRDAM6xDRXu3UOrE=;
        b=ZKN8OuS5xvN+0dIUa2BaxJybevuxji/JJZ1CvassuywlINUdlMQb1TLhGDyeGKb8Rb
         jHTUrwqpv3OJRKKdfsS4C+LvQtJrSfmUzOqzTQIGrf8wYzSziTgH5e7GlJf5YzyPqYP5
         G9ed6ry8bp3DNdwTmQMT7HDaEUGIC28B8VyqsZxIgLiUlEKbYbp6MXU8SoZShvkVJKGG
         B16ifzBZjBWKTVkqUiw8V2ps5VD1SFcRZzy0HzqqhxgF9AZalvvGOzrfEeX3ZkNXNTc/
         76Rt5tHFcig/IohYRObT9GkgHEi3K1ABs8ibVx5vQsL/4VVHdpTMMPFRXz13ev6jVLkk
         4DLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=HzJEHEogclImFx3JS53NA1MN0TYdRDAM6xDRXu3UOrE=;
        b=LLZ3RTjh0qnm88p/ADmEReHinwOne94TA/Hw4i5cJ+NWQ5g6MwfqWcsq3+baAL3zTV
         Ee68JW5iTP5iXKj+NTPgs1KBl2MYYQk88WZGIYTVndxhmAfszzuHE8DVO/1U9Hh1NRjH
         Tu9s9PDHaUItJL1kLqDVfHIqOZXwoS+3x8HHY6XP/9byJWP8uBR37tVS1cycKjGaXi96
         7rURmiExH2xYpnzFS51kbJ7e18lJBalc/Uv4aekxCL9kwNXcACdAKR4hv4kUTFgXl1LQ
         mQgK8aadzxLzCOftdFPPooPZiMDD5kKsRbAgxnVcYtSRpR7XgshAEjFK2gHjaFVMMYBH
         ThoA==
X-Gm-Message-State: ACgBeo3m1DUCxZXUIBJoA0Hx3Bt3OpM4VnKlKqv14JaYOsnU3vUkKn4d
        jAY80w+tQo6Y9sODDbelxezS0g==
X-Google-Smtp-Source: AA6agR4CHsbaB5ACoegjloJu1T4V0QX9Bbmu2ZYJFOj0poNovlAEARwWvuNGeRFfyMfu0vAuIVm4Qw==
X-Received: by 2002:a05:6000:549:b0:220:5a5d:e2e2 with SMTP id b9-20020a056000054900b002205a5de2e2mr13682609wrf.695.1660026001171;
        Mon, 08 Aug 2022 23:20:01 -0700 (PDT)
Received: from [192.168.1.69] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b003a545ff43c5sm3971305wmq.45.2022.08.08.23.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 23:20:00 -0700 (PDT)
Message-ID: <733242ec-2f17-e843-5e36-2f804c040a9d@baylibre.com>
Date:   Tue, 9 Aug 2022 08:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH v3 2/2] iio: time: capture-tiecap: capture driver support
 for ECAP
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mranostay@ti.com
References: <20220728175124.468461-1-jpanis@baylibre.com>
 <20220728175124.468461-3-jpanis@baylibre.com>
 <20220731164116.30e91f34@jic23-huawei>
 <11b7436b-5c31-671e-ba77-435fe8e3b767@baylibre.com>
 <98d17617-72b5-6330-d4f5-1bece928ceab@baylibre.com> <YvBZQsiAm6f3yxME@fedora>
 <d47c842b-579d-b119-73f9-e8c95984b30b@baylibre.com> <YvE3m+jLPuLvXXdS@fedora>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <YvE3m+jLPuLvXXdS@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2022 18:19, William Breathitt Gray wrote:
> On Mon, Aug 08, 2022 at 10:58:22AM +0200, Julien Panis wrote:
>> On 08/08/2022 02:30, William Breathitt Gray wrote:
>>> Hi Julien,
>>>
>>> I've taken a cursory look over the TI ECAP reference guide and your
>>> descriptions in this thread. I think a device driver for this would fit
>>> better in the Counter subsystem than IIO.
>>>
>>> First I want to correct a minor misunderstanding: the "timestamp"
>>> member of struct counter_event is simply a way to identify Counter
>>> events on the system as a way of grouping multiple Counter watches. In
>>> other words, the "timestamp" member here represents when a Counter event
>>> was detected by the system, not when an event was logged on the counter
>>> device hardware. Instead, hardware timestamps such as the CAPx registers
>>> would be provided by the "value" member of struct counter_event.
>>>
>>> Now, I have a few ideas for how we could expose the timestamps using a
>>> Counter device driver, but first I want to make sure I understand
>>> correctly what's happening in this device. If I understand correctly, we
>>> have the following device components:
>>>
>>> * CTR: 32-bit counter timer
>>> * Mod4: 2-bit counter
>>> * CAP1-CAP4: four 32-bit registers, each indepedently store a timestamp
>>> * ECAP: input signal providing event trigger edges
>>>
>>> Four edge polarities are configured corresponding to each CAPx register,
>>> yet the input signal is still the same single ECAP pin. The event that
>>> is fired is instead determined by the Mod4 counter: when Mod4 is 0 and
>>> the edge of ECAP matches the polarity configured for CAP1 then an event
>>> is triggered which saves the current CTR value to CAP1 and increments
>>> Mod4 to 1, etc.
>>>
>>> Is my understanding of how this device behaves correct?
>> Hi William. Thank you for your help.
>> Yes, your understanding of how this device behaves is correct.
>>
>>> If so, then one possible way to represent this device in the Counter
>>> sysfs tree is something like this:
>>>
>>> * CTR: /sys/bus/counter/devices/counterX/count0/count
>>> * Mod4: /sys/bus/counter/devices/counterX/count1/count
>>> * CAP1: /sys/bus/counter/devices/counterX/count1/cap1
>>> * CAP2: /sys/bus/counter/devices/counterX/count1/cap2
>>> * CAP3: /sys/bus/counter/devices/counterX/count1/cap3
>>> * CAP4: /sys/bus/counter/devices/counterX/count1/cap4
>>> * ECAP: /sys/bus/counter/devices/counterX/signal0/signal
>>> * polarity1: /sys/bus/counter/devices/counterX/signal0/cap1_polarity
>>> * polarity2: /sys/bus/counter/devices/counterX/signal0/cap2_polarity
>>> * polarity3: /sys/bus/counter/devices/counterX/signal0/cap3_polarity
>>> * polarity4: /sys/bus/counter/devices/counterX/signal0/cap4_polarity
>>>
>>> This is just a tentative arrangement (you could also include "enable"
>>> attributes as well), but it should give you an idea of how it could be
>>> organized.
>>>
>>> In your driver, you could then use counter_push_event() whenever you get
>>> an event triggered. In userspace, your application will add Counter
>>> watches for the CAPx registers they want. When an event triggers,
>>> userspace can then received all four CAP register values at the same
>>> time via the respective /dev/counterX character device node.
>>>
>>> Would this design work for your needs?
>> Yes, that would work for my needs.
>> The "how" is not fully clear to me yet, since I never used counter
>> subsystem. But the
>> best way to understand better how it works is probably to start working with
>> it. :-)
>> So, next patch version will be based on counter subsystem.
> The Counter subsystem is relatively nascent so the number of existing
> Counter device drivers to study is unfortunately sparse. If you
> encounter any trouble along the way as you work on this, please don't
> hestitate to reach out and I'll be happy to answer any questions you may
> have. That said, here are some more hints that can help guide you. :-)
>
> Although we've been using CAPx to refer to these registers, in the
> context of sysfs it'll be better to call the attributes "capture1",
> "capture2", etc.; that will make their use as capture buffers more
> obvious. Furthermore, despite my previous example, I think it's better
> to have these exist underneath the CTR hierarchy rather than Mod4
> because they are captures of the CTR value:
>
> * CTR: /sys/bus/counter/devices/counterX/count0/count
> * CAP1: /sys/bus/counter/devices/counterX/count0/capture1
> * CAP2: /sys/bus/counter/devices/counterX/count0/capture2
> * CAP3: /sys/bus/counter/devices/counterX/count0/capture3
> * CAP4: /sys/bus/counter/devices/counterX/count0/capture4
>
> In your device driver, you would define a struct counter_count to
> represent CTR. In this struct counter_count there is an "ext" member
> where you provide an array of struct count_comp. Each CAPx will have a
> corresponding struct count_comp; it'll look something like this::
>
>          static struct counter_comp ctr_count_ext[] = {
>                  COUNTER_COMP_COUNT_U64("capture1", cap1_read, NULL),
>                  COUNTER_COMP_COUNT_U64("capture2", cap2_read, NULL),
>                  COUNTER_COMP_COUNT_U64("capture3", cap3_read, NULL),
>                  COUNTER_COMP_COUNT_U64("capture4", cap4_read, NULL),
>          };
>
> As you already know, counter_push_event() lets you push Counter events
> in your interrupt handler. I recommend introducing a new event type
> under enum counter_event_type in the include/uapi/linux/counter.h header
> file; something like COUNTER_EVENT_CAPTURE should be descriptive enough.
>
> The "channel" member of struct counter_watch refers to Counter event
> channels; The purpose here is to allow us to support concurrent events
> of the same type (e.g. two COUNTER_EVENT_OVERFLOW but for different
> Counts). If I understand the TI ECAP device correctly, we'll be getting
> a COUNTER_EVENT_CAPTURE event whenever a CAPx register is updated with a
> new capture. It's up to you if you want to group them under the same
> channel or separate channels for each CAPx; you would just pass the
> channel in counter_push_event() to indicate which COUNTER_EVENT_CAPTURE
> event is being handled.

2 options, indeed :
1) By grouping them under the same channel, the only thing I'm not a 
great fan of is that
I will need to use separate functions to read capture registers 
(cap1_read/cap2_read/
cap3_read/cap4_read), and also to set/get polarity.
2) By using separate channels, code will look more simple but it is 
likely to be a little bit
confusing for the user.
I will probably use option 2.

> Finally, you can take a look at tools/counter/counter_example.c as an
> example userspace application. The interesting bits for you are
> COUNTER_ADD_WATCH_IOCTL/COUNTER_ENABLE_EVENTS_IOCTL ioctl calls and
> reading the event data out of the queue. You will need to first define
> an array of struct counter_watch indicating that you want to watch the
> "capture" attributes of the CTR count; something like this (assuming
> event channel 0)::
>
>          /* assuming capture attributes are under the count0 directory */
>          #define CAPTURE_WATCH(_id, _channel) \
>          { \
>                  .component.type = COUNTER_COMPONENT_EXTENSION, \
>                  .component.scope = COUNTER_SCOPE_COUNT, \
>                  .component.parent = 0, \
>                  .component.id = _id, \
>                  .event = COUNTER_EVENT_CAPTURE, \
>                  .channel = _channel, \
>          }
>          /* get id from respective "captureX_component_id" attributes */
>          static struct counter_watch watches[4] = {
>                  CAPTURE_WATCH(42, 0),
>                  CAPTURE_WATCH(43, 0),
>                  CAPTURE_WATCH(44, 0),
>                  CAPTURE_WATCH(45, 0),
>          };
>
> Later you add the watches, enable events, and finally read the event
> data as it arrives::
>
> 	struct counter_event event_data[4];
>          
>          ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[0]);
>          ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[1]);
>          ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[2]);
>          ioctl(fd, COUNTER_ADD_WATCH_IOCTL, &watches[3]);
> 	ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
>          
> 	for (;;) {
> 	        read(fd, event_data, sizeof(event_data));
> 		printf("cap1: %llu", event_data[0].value);
> 		printf("cap2: %llu", event_data[1].value);
> 		printf("cap3: %llu", event_data[2].value);
> 		printf("cap4: %llu", event_data[3].value);
> 	}
>
> If you want to keep track of channel, you can take a look under the
> event_data[i].watch.channel member.
>
> William Breathitt Gray

Thank you for all these explanations. After a few hours working with 
counter subsystem
I began to understand how it works, but now it's fully clear.
