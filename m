Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FD2484761
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiADSCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiADSCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:02:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0253AC061761;
        Tue,  4 Jan 2022 10:02:06 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4o8K-0008OH-5f; Tue, 04 Jan 2022 19:02:04 +0100
Message-ID: <832e4888-f002-6930-ab91-a5d73e16dbd5@leemhuis.info>
Date:   Tue, 4 Jan 2022 19:02:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BS
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1641203216.git.linux@leemhuis.info>
 <9a68f2fcb5fe599b76e278a61928e23eb950cd83.1641203216.git.linux@leemhuis.info>
 <CAKXUXMx_J-enVGQtX6ZqKKRZ7SwZe203tLnQoJ=VLPz3tUhK+Q@mail.gmail.com>
 <ed8ffc6c-19cd-6558-7f7e-d7bdde4ecdb9@leemhuis.info>
 <87sfu3woj1.fsf@meer.lwn.net>
 <43cb0393-c161-f853-144d-f28c6557154f@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 2/2] docs: regressions.rst: rules of thumb for
 handling regressions
In-Reply-To: <43cb0393-c161-f853-144d-f28c6557154f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641319326;17e607b6;
X-HE-SMSGID: 1n4o8K-0008OH-5f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.01.22 16:09, Randy Dunlap wrote:
> On 1/4/22 06:42, Jonathan Corbet wrote:
>> Thorsten Leemhuis <linux@leemhuis.info> writes:
>>
>>> On 04.01.22 13:16, Lukas Bulwahn wrote:
>>>> On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>>> +Try to fix regressions quickly once the culprit got identified. Fixes for most
>>>>
>>>> s/got/gets/ --- at least, that is what the gmail grammar spelling suggests :)
>>>
>>> Hmm, LanguageTool didn't complain. Not totally sure, maybe both
>>> approaches are okay. But the variant suggested by the gmail checker
>>> might be the better one.
>>
>> So we're deeply into nit territory, but "gets" would be the correct
>> tense there.  Even better, though, is to avoid using "to get" in this
>> way at all.  I'm informed that "to get" is one of the hardest verbs for
>> non-native speakers, well, to get, so I try to avoid it in my own
>> writing.  "once the culprit is identified" or "has been identified"
>> would both be good here.
> 
> Agreed. Any uses of the verb get/got are best avoided.

Ahh, good to known, thx to both of you. I guess my English teachers
tried to put that into my head like 30 years ago, but I assume the lossy
compression algorithm in there threw it away...

Went through the document and removed all get/got, was not that hard
most of the time.

Ciao, Thorsten



