Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA1E59B0EC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 01:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiHTXpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 19:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTXpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 19:45:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A31B7B0;
        Sat, 20 Aug 2022 16:45:45 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l5so5708700qtv.4;
        Sat, 20 Aug 2022 16:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Btkkj48d679yMHfGDb7blJcQxQiXhetd/ngCq9I26DY=;
        b=Kzx5zU0MeBIxlozUMBpXJavMDTSDnV2JELrkqEPducYlks2y3noS3EkIGMbZylbjcr
         wYaPfAsBKelN07jYLDGORcjvJrvuNo3Tlq8nzXZ9fYfCXIq/8Pqui9/u/5O2vi9mfI8Q
         oZIpjU32722CGSP9n4vFr78h34WhggEIDtw8m9pETHQfQo38rusr5ruR7VUgqCbQOXWs
         hikAGIoIyGJCnNZ7SSvmyvsnF9nEluk0Bu5jNKEjidgjOjIIkqUlDVC7uADKOXA0icoj
         GcvCsn5uPcPvX3oQDWY4KxHUiI/H9HF0tVJB9pMiNMYcKOJHYAC1CWY6Fcd7Xu9LwFNE
         KMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Btkkj48d679yMHfGDb7blJcQxQiXhetd/ngCq9I26DY=;
        b=rHv9WMoI4hYGYxjJ+aragoSwQhyv58fRhK5+V7AJtyc1Ehi4UyuniYE7j4T+Wl2OcO
         tnkatl8eYzVbtbfLHoJzuuAzhvd4ZT/WXCGVd20IpSZ99L5ND+omDoMlvgqKU4E/rKit
         MAb1twqTdhSfppYT869xgBkXkqTSJTxODXe91o8nAGYRaTCqeWq46szFv2Hg5SYBMG4z
         9fLf14Uwy38SFXcbwDByP/gg4qiQ9AUxUuL0ReoASjbEpO57kaIyZZjD0ynfckQbDY+d
         YMW1CfFL0wy3+Xzzwpia4rhNiZZKsf/f0ox2K2OqDTm1zd1rmZFS667DBKhcHqA1X5P/
         6UTA==
X-Gm-Message-State: ACgBeo1SNY1OjbhLgvRgGup4XB2KFNeGm+8NlcrIR1E26B00z3a40V0r
        wZ2f36OSyMaOS38O0568Gy8=
X-Google-Smtp-Source: AA6agR5t8qnthpzQ7Anx6Wp3jN1V6sDpW3q+oHh2UjFY2ftn0OpSjdpvjOskXSfXMp1zXabPUOzcOQ==
X-Received: by 2002:a05:622a:8a:b0:344:5611:7a8a with SMTP id o10-20020a05622a008a00b0034456117a8amr11221617qtw.565.1661039144395;
        Sat, 20 Aug 2022 16:45:44 -0700 (PDT)
Received: from [192.168.0.9] ([198.179.6.194])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b006bb2bca5741sm7793099qko.93.2022.08.20.16.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Aug 2022 16:45:43 -0700 (PDT)
Message-ID: <97ec87e6-b0c3-f2c9-4412-41a5884b6a24@gmail.com>
Date:   Sat, 20 Aug 2022 19:45:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: PROBLEM: Regression likely in hid_uclogic driver breaks Huion
 Inspiroy H640 drawing tablet
Content-Language: en-GB
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <9e16d503-2203-57ed-d6af-61fea0c3e10b@gmail.com>
 <nycvar.YFH.7.76.2207231339500.19850@cbobk.fhfr.pm>
 <20220724114849.GA32182@elementary> <20220725224841.GA75640@elementary>
 <3f2e0a49-38a8-417e-1bb0-9a9f28371240@gmail.com>
 <20220804182445.GA16569@elementary>
 <CAO-hwJ+hBipNJpeYaHRr2-rKXA5d79XT7zE2fo2oEKUKJtKJ0g@mail.gmail.com>
 <20220813110922.GA47526@elementary>
 <d8b91029-4a6e-1508-1512-faea768ae580@redhat.com>
From:   Stefan Hansson <newbie13xd@gmail.com>
In-Reply-To: <d8b91029-4a6e-1508-1512-faea768ae580@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

> FWIW, I found the issue: the hid-uclogic driver is emitting input data
> behind hid-input, and the state between the 2 is desynchronized.
> 
> The following patch seems to be working (with the Huion v1 protocol I
> have here that I have tweaked to resemble a v2):
> ---
>  From aeedd318e6cb4dbee551f67616302cc7c4308c58 Mon Sep 17 00:00:00 2001
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Date: Thu, 18 Aug 2022 15:09:25 +0200
> Subject: [PATCH] Fix uclogic
> 
> ---
>   drivers/hid/hid-input.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index c6b27aab9041..a3e2397bb3a7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1530,7 +1530,10 @@ void hidinput_hid_event(struct hid_device *hid, 
> struct hid_field *field, struct
>                * assume ours
>                */
>               if (!report->tool)
> -                hid_report_set_tool(report, input, usage->code);
> +                report->tool = usage->code;
> +
> +            /* drivers may have changed the value behind our back, 
> resend it */
> +            hid_report_set_tool(report, input, report->tool);
>           } else {
>               hid_report_release_tool(report, input, usage->code);
>           }

What branch should this be applied on top of?
