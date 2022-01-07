Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58542487ABA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348356AbiAGQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiAGQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:51:25 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2A0C061574;
        Fri,  7 Jan 2022 08:51:25 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n5sSX-0005tb-QS; Fri, 07 Jan 2022 17:51:22 +0100
Message-ID: <1126ce91-f22b-c397-4d1e-13d290a424a5@leemhuis.info>
Date:   Fri, 7 Jan 2022 17:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Matthias Brugger <mbrugger@suse.com>, linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <cover.1641565030.git.linux@leemhuis.info>
 <f71246e0999520d681c7b35d24f7eed2f53ee2b4.1641565030.git.linux@leemhuis.info>
 <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v2 1/2] docs: add a document about regression handling
In-Reply-To: <28b56512-d681-4a3a-98f0-a2eae34a217e@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641574285;664ac7ac;
X-HE-SMSGID: 1n5sSX-0005tb-QS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.01.22 16:37, Matthias Brugger wrote:
> On 07/01/2022 15:21, Thorsten Leemhuis wrote:
>> Create a document explaining various aspects around regression handling
>> and tracking both for users and developers. Among others describe the
>> first rule of Linux kernel development and what it means in practice.
>> Also explain what a regression actually is and how to report one
>> properly. The text additionally provides a brief introduction to the bot
>> the kernel's regression tracker uses to facilitate his work. To sum
>> things up, provide a few quotes from Linus to show how serious he takes
>> regressions.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> [...]
>> +The important bits for people fixing regressions
>> +================================================
>> +
>> +When receiving regression reports by mail, check if the reporter CCed
>> `the
>> +regression mailing list <https://lore.kernel.org/regressions/>`_
>> +(regressions@lists.linux.dev). If not, forward or bounce the report
>> to the Linux
>> +kernel's regression tracker (regressions@leemhuis.info), unless you
>> plan on
> 
> I would have expected it to be the same mailing list
> (regressions@lists.linux.dev), is this a typo maybe?

Thx for taking a look. Hmm. That's possible, but I (and the grep call I
just ran) fail to spot the typo.

Maybe the wording is to confusing: regressions@lists.linux.dev is the
list, regressions@leemhuis.info is a dedicated email address I (the
kernel's regression tracker) use for regression tracking (which reminds
me: maybe I should ask for a alias like regressions@kernel.org or
regression-tracker@kernel.org).

Ciao, Thorsten
