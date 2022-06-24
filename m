Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6706955930B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiFXGI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiFXGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:08:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BDC33A23;
        Thu, 23 Jun 2022 23:08:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o8so1717620wro.3;
        Thu, 23 Jun 2022 23:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BuOcNtEX97vnnAOhuFDjnEWZ1WuRO6ssen4ZQZtNv5A=;
        b=qd8wayc/TtEw3Hk8l4mJJcGRF7nJUtMM2iX1f0Fa9G0XzZDYg559hByEko3tlcTyFx
         Tar2M7Q1hc7gCpLu4/Qnct6zQnSXpVApGYniQhMg174qPz/U9f2Bt5RQXX668JSa/C0E
         m4iM/DagJLvAgnJzsqgqEeOoeu48JaOigUaq/vezbWVdFmFjN97xKOyu6HBwmJWh/PnL
         MHCH0YoqdmmF1VnKcW2Cnt07O3Q+ZBNLTTKoE/F2uVX4sy8vAa2NcxlY6LEKLdxkOeXS
         bQRtK4Ocllk2TJucMX3BnSF4rPNpbnsdwKwQsm9A9ZJTMCB82Wmmp+B2Ei3XOaBgIwys
         BcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BuOcNtEX97vnnAOhuFDjnEWZ1WuRO6ssen4ZQZtNv5A=;
        b=iUwnvwIkFu3Zyj3W3Ie3jkxY0vZ8D9xSsXW9EiUhQDeyz/Np8vX7ehb8VhBSX9B/C1
         9rOt5DOOVuNpyxyeBXEwkZQX961lPorU9jJIMZvRTAaLkqJrJcRH4XLchPfmM8ZxeDeP
         p/UJN/D1Hd9RQgf3GveZRZYMAcv3l3VjqDL/55uVAaDZDWXIYp2aIaVS9Z9JMb4di0/C
         TAVSNK0RQvh7R/a2lwt7+CT+KjetWucRMEWdEBl2Q1cNOHgb7kxkzPcXeHrU/+Ec7sd7
         grTRm5BBRQBgRUc0Og2AZsAY5zUpGGCeH1krQOWUQ8wlPl9KlqBkxs6BTgMqYRftaS4Y
         u2hw==
X-Gm-Message-State: AJIora8yayRXQCZV6C7F+Ke7Ic6HONXybwrRL0CveGAPVObu14viw8Dc
        T0TN7CwHSOQmXNv+/9Ie2iKSJqOtXmD4wA==
X-Google-Smtp-Source: AGRyM1vFvd6wfgg829I5geY++S40verQpyGZ3jBtoVVGQqLVjM0W2VdZUR8CuCa/f9CiulQXSenhdg==
X-Received: by 2002:adf:fd4a:0:b0:21a:3cc1:a887 with SMTP id h10-20020adffd4a000000b0021a3cc1a887mr11735524wrs.439.1656050893513;
        Thu, 23 Jun 2022 23:08:13 -0700 (PDT)
Received: from [192.168.0.118] (88-113-28-27.elisa-laajakaista.fi. [88.113.28.27])
        by smtp.gmail.com with ESMTPSA id c12-20020adfe70c000000b0021b84ac7a05sm1614144wrm.0.2022.06.23.23.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 23:08:12 -0700 (PDT)
Message-ID: <a817b3d3-f749-e4e9-dd7c-7e97cfc8d57e@gmail.com>
Date:   Fri, 24 Jun 2022 09:08:11 +0300
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
