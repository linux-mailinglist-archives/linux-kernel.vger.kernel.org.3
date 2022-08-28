Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD5A3F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 21:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiH1TIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 15:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiH1TIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 15:08:15 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1294E1CFD3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 12:08:14 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oSNdk-0003tY-Km; Sun, 28 Aug 2022 21:08:12 +0200
Message-ID: <9ec7563f-906f-2e72-73ae-6f373b9445d0@leemhuis.info>
Date:   Sun, 28 Aug 2022 21:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: Linux regressions report for mainline [2022-08-28]
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <166170992386.1651569.17504808724724706636@leemhuis.info>
 <CAHk-=wjn-GVDLEN0F+WT0PWysqH7HMD+mBjKUr65DEhav47u3w@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAHk-=wjn-GVDLEN0F+WT0PWysqH7HMD+mBjKUr65DEhav47u3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1661713694;033e5bf2;
X-HE-SMSGID: 1oSNdk-0003tY-Km
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.08.22 20:41, Linus Torvalds wrote:
> On Sun, Aug 28, 2022 at 11:23 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> Not sure, maybe it would have been good if the following fix would have
>> found the way into rc3, as it seems more than just one or two people
>> already stumbled over the regression fixed by it:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id a8e0f6b01b14b2e28ba144e112c883f03a3db2
>> https://lore.kernel.org/all/?qœbffc7*
> 
> Neither of those links are valid for me.
> 
> "a8e0f6b01b14b2e28ba144e112c883f03a3db2" doesn't exist in linux-next.
> never mind that that isn't valid link syntax anyway.
> 
> The lore.kernel.org link is also just random noise.
> 
> So I'm not actually sure what you are trying to say...

Sorry, you are right, I did something really stupid when preparing the
mail (I manually modified one that was ready so send and already
encoded...). Here are the links:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=13a8e0f6b01b14b2e28ba144e112c883f03a3db2
https://lore.kernel.org/all/?q=9cbffc7*

But I just noticed that's not the only stupid thing I did, as the linked
commit in next (13a8e0f6b01b) is part of a series:

https://lore.kernel.org/all/20220819221616.2107893-1-saravanak@google.com/

The series fixes the regression "Regression: PM: domains: Delete usage
of driver_deferred_probe_check_state" that is in the list from regzbot:
https://lore.kernel.org/all/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/

But there are more reports, for example:
https://lore.kernel.org/all/YvrkjH6%2FFpIzyAv+@euler/

Not sure if Greg didn't sent them to you because he think they need more
time or because he's simply afk/busy and didn't manage to send pull
requests.

Guess waiting another week won't do too much harm.

Ciao, Thorsten
