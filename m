Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0642055930F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiFXGIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiFXGIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:08:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EF11B79F;
        Thu, 23 Jun 2022 23:08:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e7so1654318wrc.13;
        Thu, 23 Jun 2022 23:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BuOcNtEX97vnnAOhuFDjnEWZ1WuRO6ssen4ZQZtNv5A=;
        b=oY77c9+4rdoh+rQMzf9Hscr/aBDxqWNC0TTvtOqfOGiwPw6payvz5Gb6veCPoQOilC
         gQAQs2rHcJlJKehV95D0WSSZua+aQdr2G3xIExRGB2NFp38roYTtdwCTba2qstGqSD8s
         xl0nbtepcqYZCjJUPFsYHIzIoHXlgpw8V6butN00vVUWF102p0loCUtE7b6xDOgR1TZQ
         6mJc1/9aQFB5irulWe2tswTwnXGqCAgWbxKEciN6NIIDqoHZFeDW6YZHmA+82wT+p0ah
         Jir7abdp2saVol+awZ1RTYhpEbzNyVl6xy3KZ5zm5HJyQ/8s5ocFSJ0WQF7XLb5XitmW
         hOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BuOcNtEX97vnnAOhuFDjnEWZ1WuRO6ssen4ZQZtNv5A=;
        b=PHDt7OpCqOkNXHxTmz7EvTITy5bCv9OaPCx1441VO9KC3cL5Fm9IaPlDFXWLjfCHPG
         DQ6Dkm77BVmXUeylEi1TNo/eOw7HZKCElk6m5tfM+dBrjZfwRENGhTLKSnTD4z5Q2FBM
         Zp1xuBK60PbCFCpPtcwLQRLZcm54JGqPmzo3426RDulDOc8l3rhFGJynkgYnBg3RSkZg
         ZnGVPzuIi5LsN0kBiWzMOoY4CEYPXvwmo6mEV086fipQHkWDGTcepIqprXYPAyFMZ3dD
         zFntrJVuddyO+yWMXh3RGe6gHe6iOAJ7CydT6xTjvl4J2zUbMqcSQz1yNGFPjk9YV+Ei
         IQDA==
X-Gm-Message-State: AJIora9Qdbn6IOcdwKewCznO6Np5z//C4ABv7fjzUtPGCcVToeUGdFxn
        1EHLfPQYB31fqL3nonlXASI=
X-Google-Smtp-Source: AGRyM1ulkcGT1Ciu97QrPRZhxI4HqO2de5v2QdWYHxt8k61GEeVXaDdQpejU32yDnTmeziB+a5upIA==
X-Received: by 2002:adf:db89:0:b0:21b:84a6:9cce with SMTP id u9-20020adfdb89000000b0021b84a69ccemr11558102wri.675.1656050903103;
        Thu, 23 Jun 2022 23:08:23 -0700 (PDT)
Received: from [192.168.0.118] (88-113-28-27.elisa-laajakaista.fi. [88.113.28.27])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b0039c587342d8sm5773249wma.3.2022.06.23.23.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 23:08:22 -0700 (PDT)
Message-ID: <6ebb8b6c-901e-f7b1-f29e-2182fd183b8d@gmail.com>
Date:   Fri, 24 Jun 2022 09:08:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] hid: Add support for the xp-pen deco mini7 tablet
Content-Language: en-US
To:     Stefan Berzl <stefanberzl@gmail.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <85312611-797f-2dd2-f864-f7c13cb889f9@gmail.com>
 <nycvar.YFH.7.76.2206091058530.14340@cbobk.fhfr.pm>
 <c856a79c-1d42-6af5-0ff3-589688701fc0@gmail.com>
 <20220623175116.GA4757@elementary>
 <62d69463-35c0-683d-f03e-c668ea82136d@gmail.com>
 <39fb9b40-061d-284b-e36e-c944a2d209c0@gmail.com>
From:   Nikolai Kondrashov <spbnick@gmail.com>
In-Reply-To: <39fb9b40-061d-284b-e36e-c944a2d209c0@gmail.com>
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

On 6/24/22 01:46, Stefan Berzl wrote:
> Hi!
> 
> On 23/06/2022 20:01, Nikolai Kondrashov wrote:
>> On 6/23/22 20:51, José Expósito wrote:
>>>> I would of course fix this, but I don't really know what's the preferred
>>>> way. One can obviously simply set up an urb to catch this, but it would
>>>> have to be a special corner case for the mini 7, as José assures me that
>>>> none of his tablets display similar behavior. Is this acceptable?
>>>
>>> My tablets also send an ACK packet, but in my case it does not have any
>>> visible effects. Maybe it is related to the DE environment used. I
>>> tested it on elementary OS (Ubuntu) and Fedora 36, in both cases the
>>> ACK is ignored... But catching it is fine, we can include the code you
>>> suggest.
>>>
>>>> José already had a look at some firmware device descriptor string that
>>>> reports the number of buttons and what not, but as far as I know, it
>>>> doesn't say anything about ack packets (right José? Does it say
>>>> anything about touch strips or similar?).
>>>
>>> In the devices I tested, the ACK packet is always present, so it should
>>> be fine to catch it. I'll test your patch in all the devices I own to
>>> be safe.
>>
>> I think it's OK to just ignore the first packet for these devices, even if the ACK packet is not sent for some of them. Even with the report rate of 20 years ago nobody would've noticed if you dropped one packet.
>>
>> Nick
> 
> Sounds good indeed. Does it also work if the user presses a button first?
> The way I get it, we would only receive the button up event then, not the
> button down?

It's basically humanly impossible to register a pen's button press without 
first producing some movement reports. You have to hold the pen within range 
for it to register, and it's hard to hold it still enough within range to not 
produce movement reports, while also trying to press a button. I think we're 
safe here.

If there are any buttons on the frame, then it's likely possible to 
distinguish their reports from the pen ones by looking at the report contents 
before discarding.

Nick
