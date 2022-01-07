Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7FD487A99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348301AbiAGQm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239949AbiAGQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:42:58 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D3C061574;
        Fri,  7 Jan 2022 08:42:58 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n5sKM-000492-Sp; Fri, 07 Jan 2022 17:42:55 +0100
Message-ID: <f2736445-b7a8-e6cb-682e-a5a2ab69500a@leemhuis.info>
Date:   Fri, 7 Jan 2022 17:42:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Thorsten Leemhuis <linux@leemhuis.info>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1641565030.git.linux@leemhuis.info>
 <YdhqNHI/f2B/SlcE@kroah.com>
Content-Language: en-BS
Subject: Re: [RFC PATCH v2 0/2] docs: add a text about regressions to the
 Linux kernel's documentation
In-Reply-To: <YdhqNHI/f2B/SlcE@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641573778;d4f7e5b8;
X-HE-SMSGID: 1n5sKM-000492-Sp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resending after finishing the mail for real, accidentally it the keys
to send :-/]

On 07.01.22 17:28, Greg Kroah-Hartman wrote:
> On Fri, Jan 07, 2022 at 03:21:00PM +0100, Thorsten Leemhuis wrote:
>> 'We don't cause regressions' might be the first rule of Linux kernel
>> development, but it and other aspects of regressions nevertheless are hardly
>> described in the Linux kernel's documentation. The following two patches change
>> this by creating a document dedicated to the topic.
>>
>> The second patch could easily be folded into the first one, but was kept
>> separate, as it might be a bit controversial. This also allows the patch
>> description to explain some backgrounds for this part of the document.
>> Additionally, ACKs and Reviewed-by tags can be collected separately this way.
>>
>> v2/RFC:
>> - a lot of small fixes, most are for spelling mistakes and grammar
>>   errors/problems pointed out in the review feedback I got so far
>> - add ACK for the series from Greg
> 
> My ack seems not to be here :(

Huh, how did that happen? Sorry, thx for pointing it out, will be in v3.

> Also, this is a "real" series, no need for a RFC anymore, right?

I was taken a bit back-and-forth and then settled on calling this one
still RFC, as I was unsure if people like Jon and Randy might want to
wait on feedback from Linus before they take a closer look at all that
huge amount of text...

Ciao, Thorsten
