Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D7556DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 23:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiFVVbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 17:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiFVVbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 17:31:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D012A91;
        Wed, 22 Jun 2022 14:31:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id x6-20020a1c7c06000000b003972dfca96cso360394wmc.4;
        Wed, 22 Jun 2022 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:cc:from:in-reply-to:content-transfer-encoding;
        bh=LfYvC0Oyatj+4xO7FlqsMGvYvnlW1iYymFPQsq+aXcI=;
        b=BAihApAwCeabWwTaYpZYkTYDnk7xt0xUjPipoZGYLoRAR4UkCnqoV6JcwlB11c2aBi
         tP4g4c/ni+GqbDT/eU7uXz6uub4NIYQ/5A5tSJbCp+eaWtV+abHHn3+uyitX6t9J9+rD
         Nx3wq6nO6fdauyFEIrQOtRj3J/RcHt1kXrCZe8zLm0FH0zuW5eI8tw+dKzeMrFwTwyCH
         aCSiHZ56SbrrPVofmuVjy5XpcYzexhgE6DW/fAgsyZmt0cduT5g+T6r4EeouTwOVLx25
         ha2X4DHhjnVt/dY5Ul5z5VAEF5piJaYbtb2vyW++k6SDcvGEibO5h7strjQGfMNQ9ep0
         7+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:cc:from:in-reply-to
         :content-transfer-encoding;
        bh=LfYvC0Oyatj+4xO7FlqsMGvYvnlW1iYymFPQsq+aXcI=;
        b=Ils6rSUHpl20U+iul6kqMteZKci9oLEeCsrvySEKBjSPgFZVN1HVV9FuASScW1Xh64
         gXv7XKgB0tUyUGZFLcA8RjJTVwZi/C2kunqonEc1rdmt6DPv8Eu+AqLiFdjrBIBgTwrg
         S4R72iucA9+jlfefH70VZkV5K4I9GCoAMgJKwHMetYV7Qs9mtdoHqfIwCzi6GQ4FQo4l
         5cVgIlAZ+n8bnuO6zRqUgHXfkoX1BCS2dvBB8cqSth9+AKBCYac3BLETIZKoI6UPZIW8
         3PtaPnKBlTz7I4UpdMr+peHvQohA3q0puOrNdDFRtmMKK64t8WM4yHZMMIG2mentoVT/
         rDGw==
X-Gm-Message-State: AJIora/eMKCHXTNNNhxhnA2lcXdoa4BFtGzQNAIDzw1sW/2he+TQxLdR
        dWWV3y1nAeWFMegaM9I4QxH9tt1ikM/pvg==
X-Google-Smtp-Source: AGRyM1tcrUK22QbgTjbidfZUWrgg7Ox34Ew7yet8onoDV4ahyusBEkCcITGbJ+m/bL5Y5MErXZiYNg==
X-Received: by 2002:a05:600c:2241:b0:39c:405f:fba5 with SMTP id a1-20020a05600c224100b0039c405ffba5mr348955wmm.75.1655933468672;
        Wed, 22 Jun 2022 14:31:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:6d40:29d:ba85:78f8:3d80:548? ([2a02:810d:6d40:29d:ba85:78f8:3d80:548])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d4850000000b0021b829d111csm16300187wrs.112.2022.06.22.14.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 14:31:07 -0700 (PDT)
Message-ID: <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
Date:   Wed, 22 Jun 2022 23:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
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

Hello!

>> >From f9bb82e400effd3aea37b2be710add9e2bb832da Mon Sep 17 00:00:00 2001
>> From: Stefan Berzl <stefanberzl@gmail.com>
>> Date: Fri, 11 Mar 2022 04:04:30 +0100
>> Subject: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
>>
>> ...
> 
> Stefan,
> 
> sorry for not responding earlier, but this patch somehow fell in between 
> cracks. Please for your further submissions do not forget to at least CC 
> some of the relevant malinglists as well.

Will do... I am still new to the process and tend to forget things, but 
I'll do my best.

> Quite a lot has changed in uclogic driver since then, as José has been 
> pushing quite a lot of code there from DIGImend project ... could you 
> please update your patch on top of current codebase and resend it?
> 
> Thanks,
> 

I think you'll be pleased to find that José's work is basically a 
superset of mine, therefore eliminating the need for my patch 
altogether. When running his newest deco l code, the deco mini 7 is 
fully supported as well. I should have given a tested-by or something, 
but since I am still new to this, I was kinda hesitant with the big 
changes introduced by the newest digimend work. As you know, there is no 
sort of registry to differentiate devices by ability, so one or two
useless evdev devices are generated for hardware the tablet may or may 
not have, like "Touch Ring" or "Touch Strip". I thought that this might 
cause confusion and would have to be amended.

There is however one caveat that seems to be unique to the mini7, which 
is the ack packet that is sent when switching to the vendor defined 
usage. It doesn't do much though, as currently it gets interpreted as a 
pen report and since it doesn't have useful values, causes the cursor to 
go to the top left screen position. Since the ack packet is only sent 
once, it ought to be of little consequence.

I would of course fix this, but I don't really know what's the preferred 
way. One can obviously simply set up an urb to catch this, but it would 
have to be a special corner case for the mini 7, as José assures me that 
none of his tablets display similar behavior. Is this acceptable?
José already had a look at some firmware device descriptor string that 
reports the number of buttons and what not, but as far as I know, it 
doesn't say anything about ack packets (right José? Does it say 
anything about touch strips or similar?).

Everything said, I think this can be closed
https://patchwork.kernel.org/project/linux-input/patch/b401e453-9c66-15e3-1a1d-21f33b7a64e8@gmail.com/

Also I made this patch, which is very trivial and simplifies the hot path
https://patchwork.kernel.org/project/linux-input/patch/17153eb3-0eb9-cc05-4b65-9c0f4e8d3c90@gmail.com/

Thanks for your work on the linux input subsystem!


Kind Regards
Stefan Berzl


PS: notice how I put the right CCs and stuff :)
