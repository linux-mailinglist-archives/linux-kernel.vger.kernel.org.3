Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C14A7E68
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 04:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiBCDlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 22:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349053AbiBCDlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 22:41:31 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A483C061714;
        Wed,  2 Feb 2022 19:41:31 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id b17-20020a9d4791000000b005a17fc2dfc1so1455408otf.1;
        Wed, 02 Feb 2022 19:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=cL0e/1XpGCblXeLFaeo45MWHkNdbqGHQt2g6YZMQ9Ow=;
        b=UWF7sU0nVfAyPOANrRr8bFEsVNLWvAXwCgEFvLInAR5YSEB8O20acnbbpQcYLo3d8V
         pqqPhm4Izkk/9D5WMP7HlZvH6pXYmfG8bDxGdJtEhSw7DveWwnVlFJY3xQ4zqMHZ0fuv
         4MnsDVOWm4Sqo6MMkZf+2tWj/c5lsLTAhZO8SKPqmc3ngA0nvgc7CrKVRvhkQKlv0Cak
         MqlOUHDEKmOgv9qDIinhOhJ1U9Z0U1SSYZayjLg3q8DFJlSalejwQw2yZLuZPPNT2Ee8
         vPg709bfcPWfrBR6gKsTUZAN686386JGwEj1AiG/6BhFeO6ef3rlrP8OLYdf8c4Ur9/I
         TmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=cL0e/1XpGCblXeLFaeo45MWHkNdbqGHQt2g6YZMQ9Ow=;
        b=W7pbuDyGAsAWRS8VmaI1tdE0+qNs+aXn+A2MFXXey7UL28f8oKQDihho2VsfaupKcA
         ANeyfX+97bqutjwH3ROUdF/QOoCOBlGgDlNYf88UTCdrH5K+hqqb2Kzo+xT3dLz30R3P
         Qzp5qXgkiy31rp+9ZCb26xdlVN5EzABBvvo4WUhhGMSk4UI4hytBKu41+dbOqQEU3M5d
         fz1WpJjvVQaWnxjVo2O02vpo2aGXxLTjyxAfujwfLH+2oJ6HiAHdLEJmUveDs9En+ILm
         ciXBGL/aaD+Wav5ogfxaCZHTu5qUNRqni+PLaAQSZjkqwx9jJpgklSzesRwRDnoFkqIE
         Bp5Q==
X-Gm-Message-State: AOAM532qBDW1E9v48Gf/MnJBj3+Fg3Ope0XBbJ26RkHMH4vP+yhoshDZ
        ul8HgVqHg2Wchpx7quBp6RJ8bU4tJNzGtw==
X-Google-Smtp-Source: ABdhPJxpJf9Fs2axHyL1jmdqT4HRmNzbldvLxwd6/BrNTgIwnVsAa9gBGHYvJer12F2U7DJRr+bCTQ==
X-Received: by 2002:a05:6830:18d8:: with SMTP id v24mr17369122ote.349.1643859690264;
        Wed, 02 Feb 2022 19:41:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v26sm15432485ooq.20.2022.02.02.19.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 19:41:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7c8f311f-a2e4-584f-eb29-7f0d2a335e8f@roeck-us.net>
Date:   Wed, 2 Feb 2022 19:41:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20220124015658.687309-1-eugene.shalygin@gmail.com>
 <CAB95QASxE8Z_z046mnOBD1Zk1oeg=xB-wS+J8Oeuj=akm8171Q@mail.gmail.com>
 <c613f73b-9c91-9aad-e367-87b9d8b17530@roeck-us.net>
 <CAB95QASv2nY6kttOw1rwReUuucfpSgoByA6yrAbuQPRcTUQJBQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [ASUS EC Sensors v8 0/3]
In-Reply-To: <CAB95QASv2nY6kttOw1rwReUuucfpSgoByA6yrAbuQPRcTUQJBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 17:16, Eugene Shalygin wrote:
>> I was waiting for someone to send me a Tested-by: for the series,
> 
> Oleksandr sent an informal one already.
> 

He wrote:

"Given minor changes against v7, I think my "Tested-by:" should have been preserved."

which doesn't mean he tested again, only that in his opinion
the tags should have been preserved.

>> since you dropped the previous feedback.
> 
> Does it mean it is possible to update patches while keeping it?
> 

See above. You are the one to make the call, and you made the call that
the series should be re-tested.

That means that I am left with either accepting the series without any
Tested-by: and/or Reviewed-by: tags, or I have to wait for some. I guess
you are telling me that I won't get any additional tags, so I'll have to
go in myself and have a closer look. I'll try to do that in the next week
or two.

Guenter
