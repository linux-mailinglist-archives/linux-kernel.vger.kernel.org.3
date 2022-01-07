Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3148780D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347508AbiAGNPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:15:03 -0500
Received: from mx-out.tlen.pl ([193.222.135.145]:6899 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238765AbiAGNPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:15:02 -0500
Received: (wp-smtpd smtp.tlen.pl 6210 invoked from network); 7 Jan 2022 14:15:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1641561300; bh=HKIshfcDfNwxlPMSvEwhDL7TEq4EldQ+jNk8up92uPc=;
          h=Subject:To:From:Cc;
          b=caIZAalzbSJLpXq+HKdpge8f4bTIF1VwJojkbdUQ27NV/jcq+rXjo9T+CNeifBRU1
           PkQ42DESt7dZ4vmSYcMbk2+W8RhZpEH7urAan0cCm2OQW4/MSOlOi8bfcjwKZIDtpg
           VAhYnme/z3i8AGDdElhVUfhfqjsrQLs2OPkFpP1w=
Received: from aafo3.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.144.3])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <alexandre.belloni@bootlin.com>; 7 Jan 2022 14:15:00 +0100
Message-ID: <cccbd4cf-f302-b64d-bf32-abdefbc7c6d0@o2.pl>
Date:   Fri, 7 Jan 2022 14:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 0/9] rtc-cmos,rtc-mc146818-lib: fixes
Content-Language: en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20220107124934.159878-1-mat.jonczyk@o2.pl>
 <Ydg6EnPdWjB3Vznc@piout.net>
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
In-Reply-To: <Ydg6EnPdWjB3Vznc@piout.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 0552936ef59d4bd84ec17dfb3a117a0a
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000A [8UOk]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 07.01.2022 o 14:03, Alexandre Belloni pisze:
> Hi,
>
> On 07/01/2022 13:49:25+0100, Mateusz Jończyk wrote:
[snip]
>> v5: Increase maximum accepted duration of the UIP high pulse from 10 to 20ms,
>>     in case there are some very slow chips out there.
>>
>>     Note: this may cause problems with hpet_rtc_interrupt() if the CMOS
>>     RTC stops working while the system is running and RTC update
>>     interrupt / RTC alarm interrupt is enabled (which should be rare).
>>     In this case, hpet_rtc_interrupt() is executed 64 times per second
>>     and takes up to 20ms to complete - which may constantly occupy
>>     one CPU. I am not sure if this is likely enough to implement
>>     special handling of this case in hpet_rtc_interrupt().
>>
> Because v4 has been applied, 

Nice, thank you! I didn't know about this.

> you'd have to send a series against rtc-next.

OK

Greetings,

Mateusz

