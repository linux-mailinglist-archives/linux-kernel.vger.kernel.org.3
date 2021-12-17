Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8364797A1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLQXrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhLQXrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:47:47 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEA8C061574;
        Fri, 17 Dec 2021 15:47:47 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so4807411otl.3;
        Fri, 17 Dec 2021 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0AFImQH1jxveNZAS/rrsUWhnMnHTnqUdIP1E4lcaoQ8=;
        b=TKT0UJsRYaX08bpCDjrGexfZqywLftsF5LQUNCpB2NPAE3KLR2aOc9IZ/Y4mELz5O0
         urIJsnuZErAwzKRTgvJ1hIiTcf4A41+mJAFlWvh+pVDqL7D23shCcNiiRlVlHi02nUr8
         zRXggEFmu9mvljSHSE54o1dxmMevztqHbpMfn/OnfDPuPwY5aNFPOuT0CSkAHqAwjBl7
         yM4B+CvwjdnMYbSsAVK0MYtuRTo6kECnt3dMT8bWjBRFuGlX4CBcabEYN/7zUlHy8SsN
         FVi5PMbE6UnA7PsHsRW/NxS1o9JWqdmGnYI2swM9CWy6oLNcpqSjpekjNwnIwVMg1xXL
         ruiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0AFImQH1jxveNZAS/rrsUWhnMnHTnqUdIP1E4lcaoQ8=;
        b=J6IWlnrsvUvOvloqkaN5RWqY68WAac2OWmO1G3z5VvkUh/DPes5dKSx3Wts80FpAE+
         Blf40+GGJBavpcCuD8K06OAJp2PhQVbc4JIDc+Rm6RKyxoZP6AGb89kLoxA7szWp/rFf
         7dJIJYH6N24biBrS75rLTG7ABC8D8J8N8Tm60d8ZC3pocl1QCgM0QQXuYYjWWcDLT6At
         BLvpMajazeAQZxhCI7Ee04XIQ/khh0DvQzFDRKBND5z/R/7agGTaYIh+SoYWHVUziLBm
         z+G5cMyp3WnVXh+Xn3ptUA3mgTqAyiJ60vd+O7j6ziJcOPzjM7gM8vDgbVgtxUfld4dF
         TOng==
X-Gm-Message-State: AOAM533aRTq+NYIwx0YNMwYyI0ZLHad3VMzpSSFpLbnejJYwQIasMuBP
        cPCC1eMoFFYxp3h7Ry9i8RPs/1D8oGE=
X-Google-Smtp-Source: ABdhPJwYON1OMYK30Blayf0FfnEiyJV5zA7eFstXb4avRPMsYOtLZ3AOxbaWkQNxuUtLc+5wXKm7Ig==
X-Received: by 2002:a9d:6a84:: with SMTP id l4mr3849608otq.216.1639784866230;
        Fri, 17 Dec 2021 15:47:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q10sm1974364oiw.17.2021.12.17.15.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 15:47:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
References: <20211217164307.1514192-1-eugene.shalygin@gmail.com>
 <20211217164307.1514192-2-eugene.shalygin@gmail.com>
 <20211217215233.GA490048@roeck-us.net>
 <CAB95QATUTvoopfCUez3exhStcGtPGacpyAYW-rswGnVSw-cmjw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
Message-ID: <caab79d7-6c48-5426-5d3a-dbbe88fd13f9@roeck-us.net>
Date:   Fri, 17 Dec 2021 15:47:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAB95QATUTvoopfCUez3exhStcGtPGacpyAYW-rswGnVSw-cmjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/21 2:33 PM, Eugene Shalygin wrote:
> Günter,
> 
> On Fri, 17 Dec 2021 at 22:52, Guenter Roeck <linux@roeck-us.net> wrote:
>> There is a lot of complexity around mutex_path in this driver, yet there is
>> always exactly one entry for each board, and the name of the mutex is always
>> the same for all boards. This doesn't make sense. Either the code is needed
>> or it isn't. We don't usually add complex code like this into the kernel
>> "just because it may be needed at some point in the future". Either give me
>> a use case, or drop it all.
> 
> When we discussed this approach which utilises an ACPI mutex, Andy and
> Denis were sceptical about its maintainability. One of the objections
> was that the mutex name is internal to the DSDT code and can be
> changed by ASUS. I know when older AM4 boards received BIOS updates
> for Ryzen 5000, their BIOS changed completely and I overheard that the
> DSDT code changed too. Unfortunately, I have no samples at hand. So I
> went ahead and added version support. I can, of course, revert that
> and apply it if somebody encounters such a BIOS update. To some extent
> I wanted to demonstrate how overcoming the problem with possible
> changes of the mutex path can look.
> 

That is not how kernel development works. It does not make sense to
introduce code that isn't used. The code is by its nature untested,
and it is completely unknown if it is even going to work if it is ever
needed. We simply can not predict how a future BIOS version / DSDT
looks like.

I don't have an answer for the maintainability problem, but introducing
speculative code is most definitely not the answer.

Guenter
