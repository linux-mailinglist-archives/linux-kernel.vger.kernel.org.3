Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D6F558B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 00:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiFWWqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 18:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiFWWqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 18:46:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA274F47D;
        Thu, 23 Jun 2022 15:46:22 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q9so744607wrd.8;
        Thu, 23 Jun 2022 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=An9ys9Mi63w5/7wUtP5WazBY5gumMGQ/JazyU9Yrp80=;
        b=YA+g1VK3yMuLmgkFNPCUAw6PDxmMU0vhE8WgeTV10HrmIdQRGlD1X8mkucmifQzgC8
         t5mE8Nh2XzJu6OyeakFJIh1jCjz1UROWunIr6numpnUqGqPUmMqmujm55gsrv4A7XjBL
         mrhNVbFcARLn0ADQ/78s0YWyrBbGKPghs3E3qbyh10owz535CwU6tfjbptemP5BSK8MD
         qhExk6Gsh1tcUcNOCjxlbAHWR6trxphoU6CWrsFYJXaxXSu5KprYi/XdZo5gLSxtFVPA
         FxAWEZZl0IPvv+HyP/xjqqncNaBFy9X96bidBK2z6ScqSHIZqz9CvaOOxL9p36KOLc09
         j8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=An9ys9Mi63w5/7wUtP5WazBY5gumMGQ/JazyU9Yrp80=;
        b=OEbcMPgwx1YPaybcPPrN6AVR9AN5HI3+ufxRJFtN6wWD+bge/3h6b3chI6DwepD4ua
         NPwUyqBVuw6VV9Vvwj1qc+3nLWCZ2z+BxfsXMbhN/lkBmnBC+izXx6DcnxPNVGpKQ4/W
         sSetfw0WtrubKwnCaDWPTCP+bUb3yxmoU1KheKF42kVxtjlxcZelJlD/f/WqFKmBisUg
         4ggjiVhpUX2JC3HQgX8jFM6XiZKLOkraYnr6IhnDqHxYf9IrqoGdhc/m6KLD0XWgIwvq
         hvRUH8xLElz6bJzjuWh5ATKmd1rhMV9jiZ+9otHomShpt3vp2Ni9UVAq6kEMGfFvPatx
         E9rg==
X-Gm-Message-State: AJIora8PSboOcfk/AAkSET7hyeB6aLzDYGDJ+CqTuLaMO/MU6DCRBQZx
        WuxAVzyUnOIZsm6YVfemAZ4q3lIXLcIu7A==
X-Google-Smtp-Source: AGRyM1tSWsfKfmjKvFP8agk8w4NgupFG3ctmcgI/+WIR9TMW2SfK03mMtPjROJ/B/4IeLM0xIwYRaw==
X-Received: by 2002:a05:6000:1191:b0:21b:a32e:983b with SMTP id g17-20020a056000119100b0021ba32e983bmr8139275wrx.348.1656024380713;
        Thu, 23 Jun 2022 15:46:20 -0700 (PDT)
Received: from [192.168.178.29] (ipb2196a31.dynamic.kabel-deutschland.de. [178.25.106.49])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0a4300b00397393419e3sm6152486wmq.28.2022.06.23.15.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 15:46:19 -0700 (PDT)
Message-ID: <39fb9b40-061d-284b-e36e-c944a2d209c0@gmail.com>
Date:   Fri, 24 Jun 2022 00:46:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Content-Language: en-US
To:     Nikolai Kondrashov <spbnick@gmail.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
 <62d69463-35c0-683d-f03e-c668ea82136d@gmail.com>
From:   Stefan Berzl <stefanberzl@gmail.com>
In-Reply-To: <62d69463-35c0-683d-f03e-c668ea82136d@gmail.com>
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

Hi!

On 23/06/2022 20:01, Nikolai Kondrashov wrote:
> On 6/23/22 20:51, José Expósito wrote:
>>> I would of course fix this, but I don't really know what's the preferred
>>> way. One can obviously simply set up an urb to catch this, but it would
>>> have to be a special corner case for the mini 7, as José assures me that
>>> none of his tablets display similar behavior. Is this acceptable?
>>
>> My tablets also send an ACK packet, but in my case it does not have any
>> visible effects. Maybe it is related to the DE environment used. I
>> tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
>> ACK is ignored... But catching it is fine, we can include the code you
>> suggest.
>>
>>> José already had a look at some firmware device descriptor string that
>>> reports the number of buttons and what not, but as far as I know, it
>>> doesn't say anything about ack packets (right José? Does it say
>>> anything about touch strips or similar?).
>>
>> In the devices I tested, the ACK packet is always present, so it should
>> be fine to catch it. I'll test your patch in all the devices I own to
>> be safe.
> 
> I think it's OK to just ignore the first packet for these devices, even if the ACK packet is not sent for some of them. Even with the report rate of 20 years ago nobody would've noticed if you dropped one packet.
> 
> Nick

Sounds good indeed. Does it also work if the user presses a button first?
The way I get it, we would only receive the button up event then, not the
button down?

Faithfully
Stefan Berzl
