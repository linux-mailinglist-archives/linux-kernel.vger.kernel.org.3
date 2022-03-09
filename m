Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF08E4D2B05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiCII4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiCII4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:56:08 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A6513D935
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:55:10 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nRs68-0001O4-8Q; Wed, 09 Mar 2022 09:55:08 +0100
Message-ID: <880af98a-fc7a-4a46-6dd4-d5c0c3a0fda3@leemhuis.info>
Date:   Wed, 9 Mar 2022 09:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Linux regressions report for mainline [2022-03-06]
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <164659571791.547857.13375280613389065406@leemhuis.info>
 <871qzby15a.fsf@tynnyri.adurom.net>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <871qzby15a.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646816110;1e9cb451;
X-HE-SMSGID: 1nRs68-0001O4-8Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.22 09:34, Kalle Valo wrote:
> "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
> writes:
>> net: wireless: rtl8723bs (SDIO) - Access point mode causes a kernel panic
>> -------------------------------------------------------------------------
>> https://linux-regtracking.leemhuis.info/regzbot/regression/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
>> https://lore.kernel.org/regressions/d58625ad-6f3e-a7d7-b5b4-d18eb16f4082@leemhuis.info/
>>
>> By José Ángel Pastrana, 35 days ago; 3 activities, latest 2 days ago.
>> Introduced in 54659ca026e5 (v5.16-rc1)
>>
>> Fix incoming:
>> * staging: rtl8723bs: Fix access-point mode deadlock
>>   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=8f4347081be32e67b0873827e0138ab0fdaaf450
> 
> Just a small wish for the future, no need to change this report, but for
> staging drivers it would be good use "staging:" instead of "wireless:"
> in the title. This makes it easier for people to see that this is a
> staging driver, not a normal wireless driver.

Yeah, sorry about that, that is actually what I would do normally, but
seems for some reason I got it wrong here.

BTW, for anybody who cares: Jakub had a good idea to handle the "which
subsystem is this about" way better (in short: by checking which lists
are CCed), but I currently lack time to implement that. :-/

Ciao, Thorsten
