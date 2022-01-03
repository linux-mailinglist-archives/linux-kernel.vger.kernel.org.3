Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F7483578
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbiACRUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 12:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbiACRU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 12:20:29 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B3C061761;
        Mon,  3 Jan 2022 09:20:29 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n4R0S-0003uC-8c; Mon, 03 Jan 2022 18:20:25 +0100
Message-ID: <122bf6e0-8e1f-6567-252e-5120b3f8a573@leemhuis.info>
Date:   Mon, 3 Jan 2022 18:20:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-BW
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        workflows@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <cover.1641203216.git.linux@leemhuis.info>
 <7b71a1262b8b72d30154203bb14f00db7d4170ef.1641203216.git.linux@leemhuis.info>
 <20220103090746.2599f729@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [RFC PATCH v1 1/2] docs: add a document about regression handling
In-Reply-To: <20220103090746.2599f729@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1641230429;94223903;
X-HE-SMSGID: 1n4R0S-0003uC-8c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03.01.22 18:07, Jakub Kicinski wrote:
> On Mon,  3 Jan 2022 10:50:50 +0100 Thorsten Leemhuis wrote:
>> +How to see which regressions regzbot tracks currently?
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Check `regzbot's web-interface <https://linux-regtracking.leemhuis.info/regzbot/>`_
>> +for the latest info; alternatively, `search for the latest regression report
>> +<https://lore.kernel.org/lkml/?q=%22Linux+regressions+report%22+f%3Aregzbot>`_,
>> +which regzbot normally sends out once a week on Sunday evening (UTC), which is a
>> +few hours before Linus usually publishes new (pre-)releases.
> 
> Cool, I wonder if it would be a useful feature to be able to filter by
> mailing lists involved or such to give maintainers a quick overview of
> regressions they are on the hook for?

Ha, that's a great idea, many thx. I have been scratching my head for a
while already how to give maintainers a better overview, but the only
thing I came up with was "check the merge path a commit causing the
regression took", which has a few obvious downsides (it for example
won't work if the culprit is not known yet). This should work a lot better.

But be warned, will likely take a few weeks (months?) before I get to
implement that: I have less time to work on the regzbot code than in the
past weeks, as I have to take care of a few other things first (most of
them related to regzbot).

Ciao, Thorsten

