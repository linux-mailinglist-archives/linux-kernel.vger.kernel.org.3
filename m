Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517D4484447
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiADPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiADPJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:09:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1669C061761;
        Tue,  4 Jan 2022 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=v8liNB6aaaW1HxNxPzihRK7DuVOe86LHkJauyhdHUc8=; b=UucLCR0GHwXEmQR6ZeE6QV4MGi
        CFEUG8HK9pEcb3/ZxekgTMgWOg2XTx7pU1Yy2XqTfPbUetD0toPlrPxLKko87rfBtRVFjSYFKbwRO
        krvIJH2777xMAqpdrE8KlmKF038w7ycvBZb4rzxC8kBBFZ4P0NCT6lF9j8WvlQWYEtVW3z2fqs4ek
        K3iW2e/2BC1byFC/vs46wEqn9B+hNwzVJCsahozkp/DtrljYsXI0kIC7OLvJVPGA1HuK+dKBDinJp
        /Op+3Qrzt3qClkeWNH1YT3Y1CvtgPD8MPyre4CO3poEZB3glb2lyIsT0EWRLoPmnBWd24F5nrSazw
        WHOJjtKA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4lRe-005I6V-Fw; Tue, 04 Jan 2022 15:09:50 +0000
Message-ID: <43cb0393-c161-f853-144d-f28c6557154f@infradead.org>
Date:   Tue, 4 Jan 2022 07:09:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [RFC PATCH v1 2/2] docs: regressions.rst: rules of thumb for
 handling regressions
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>,
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87sfu3woj1.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/22 06:42, Jonathan Corbet wrote:
> Thorsten Leemhuis <linux@leemhuis.info> writes:
> 
>> On 04.01.22 13:16, Lukas Bulwahn wrote:
>>> On Mon, Jan 3, 2022 at 3:23 PM Thorsten Leemhuis <linux@leemhuis.info> wrote:
>>>> +Try to fix regressions quickly once the culprit got identified. Fixes for most
>>>
>>> s/got/gets/ --- at least, that is what the gmail grammar spelling suggests :)
>>
>> Hmm, LanguageTool didn't complain. Not totally sure, maybe both
>> approaches are okay. But the variant suggested by the gmail checker
>> might be the better one.
> 
> So we're deeply into nit territory, but "gets" would be the correct
> tense there.  Even better, though, is to avoid using "to get" in this
> way at all.  I'm informed that "to get" is one of the hardest verbs for
> non-native speakers, well, to get, so I try to avoid it in my own
> writing.  "once the culprit is identified" or "has been identified"
> would both be good here.

Agreed. Any uses of the verb get/got are best avoided.

-- 
~Randy
