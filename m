Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48D4484236
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiADNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:18:15 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:50074 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233374AbiADNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:18:13 -0500
X-Greylist: delayed 481 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jan 2022 08:18:13 EST
Received: from sas1-d367461f7756.qloud-c.yandex.net (sas1-d367461f7756.qloud-c.yandex.net [IPv6:2a02:6b8:c08:fe02:0:640:d367:461f])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 4E43A6FF8F96;
        Tue,  4 Jan 2022 16:10:11 +0300 (MSK)
Received: from sas8-c6148047b62a.qloud-c.yandex.net (sas8-c6148047b62a.qloud-c.yandex.net [2a02:6b8:c1b:2a11:0:640:c614:8047])
        by sas1-d367461f7756.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 4AW5QZu7sy-AAeqSsAc;
        Tue, 04 Jan 2022 16:10:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ngs.ru; s=mail; t=1641301811;
        bh=aibARZXcrbaH73cgf7JYe3AOlnf+khcVeoZ8dUhPUzU=;
        h=In-Reply-To:References:Date:From:To:Subject:Message-ID;
        b=glXZYpuCYsqoyUdestY38yqE7WbeJNGBQlBwjBr67dfk8FU9kDUzCaoKxt1Fixe15
         kG620PRYwAcaobVXE2JASyqSVQhiYOW33D8BQ0+BgMMlFgbgVbiLGkau1gP+yIB7yV
         +ZIdKkZJEuKioTcYeep2obPdIfDc64Y8RSyOqmmk=
Authentication-Results: sas1-d367461f7756.qloud-c.yandex.net; dkim=pass header.i=@ngs.ru
Received: by sas8-c6148047b62a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ICpEPId7tD-A9Q4rHxQ;
        Tue, 04 Jan 2022 16:10:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Subject: Re: error fn f7 (asus)
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, jprvita@gmail.com,
        andy@infradead.org
References: <625e12e1-aee0-8b3c-8a4d-98e74739153c@ngs.ru>
 <3440f96b-291f-cd5e-7fc3-c3e9c0959f22@infradead.org>
From:   "jack_solovey@ngs.ru" <jack_solovey@ngs.ru>
Message-ID: <1180fe71-07c5-9de6-1d50-a16010773bcc@ngs.ru>
Date:   Tue, 4 Jan 2022 20:10:08 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3440f96b-291f-cd5e-7fc3-c3e9c0959f22@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.04.2020 10:19, Randy Dunlap пишет:
> [adding Cc's]
>
> On 3/8/20 11:43 PM, jack_solovey@ngs.ru wrote:
>> Hello, sorry this machine translation.
>>
>> Laptop  Asus N56V
>> Prior to kernel 5, the FN+F7 buttons turned off the laptop screen.
>> Starting with kernel 5, these buttons turn on standby mode.
>> I have to use core 4.18
>>
>> Linux Asus-N56VB 4.18.0-25-generic #26~18.04.1-Ubuntu SMP Thu Jun 27 07:28:31 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
>>
>> Whether it is planned to return the legacy function to the fn+f7 buttons to disable the main monitor.
> Hi,
>
> Possibly caused by 78f3ac76d9e5219589718b9e4733bee21627b3f5
> (platform/x86: asus-wmi: Tell the EC the OS will handle the display off hotkey).
>
Hello.
Please tell me, is there anything to be done to solve this problem?

-- 
___________________
С уважением,
Соловей Евгений

