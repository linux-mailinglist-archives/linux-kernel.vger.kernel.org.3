Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F35C5A4229
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiH2FUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664FEE0A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 22:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E93161000
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E43C433D6;
        Mon, 29 Aug 2022 05:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661750428;
        bh=klNFK0zlZI++873Czf0Md6dHlhc5Jg4+H48SL864YBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZiJTXhA02tvA/MjrTiDITvQT/PQPFiKGpYIuPZ8f4GdTNPj+rTuxO3A3jujJA9GY
         h1Fnq3NIs0hzy46FCz3lRz/tbGeQSUb+Iws1s/t5siZUJwiLVU1b9qHWgYsxyNmgiz
         kDMNwP22DqJW2gqKvtPTZpWPAK8H5tx1LYy4QeD8=
Date:   Mon, 29 Aug 2022 07:20:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2022-08-28]
Message-ID: <YwxMqn6FbFmdKKFv@kroah.com>
References: <166170992386.1651569.17504808724724706636@leemhuis.info>
 <CAHk-=wjn-GVDLEN0F+WT0PWysqH7HMD+mBjKUr65DEhav47u3w@mail.gmail.com>
 <9ec7563f-906f-2e72-73ae-6f373b9445d0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ec7563f-906f-2e72-73ae-6f373b9445d0@leemhuis.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 09:08:12PM +0200, Thorsten Leemhuis wrote:
> 
> 
> On 28.08.22 20:41, Linus Torvalds wrote:
> > On Sun, Aug 28, 2022 at 11:23 AM Regzbot (on behalf of Thorsten
> > Leemhuis) <regressions@leemhuis.info> wrote:
> >>
> >> Not sure, maybe it would have been good if the following fix would have
> >> found the way into rc3, as it seems more than just one or two people
> >> already stumbled over the regression fixed by it:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id a8e0f6b01b14b2e28ba144e112c883f03a3db2
> >> https://lore.kernel.org/all/?qœbffc7*
> > 
> > Neither of those links are valid for me.
> > 
> > "a8e0f6b01b14b2e28ba144e112c883f03a3db2" doesn't exist in linux-next.
> > never mind that that isn't valid link syntax anyway.
> > 
> > The lore.kernel.org link is also just random noise.
> > 
> > So I'm not actually sure what you are trying to say...
> 
> Sorry, you are right, I did something really stupid when preparing the
> mail (I manually modified one that was ready so send and already
> encoded...). Here are the links:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=13a8e0f6b01b14b2e28ba144e112c883f03a3db2
> https://lore.kernel.org/all/?q=9cbffc7*
> 
> But I just noticed that's not the only stupid thing I did, as the linked
> commit in next (13a8e0f6b01b) is part of a series:
> 
> https://lore.kernel.org/all/20220819221616.2107893-1-saravanak@google.com/
> 
> The series fixes the regression "Regression: PM: domains: Delete usage
> of driver_deferred_probe_check_state" that is in the list from regzbot:
> https://lore.kernel.org/all/DU0PR04MB941735271F45C716342D0410886B9@DU0PR04MB9417.eurprd04.prod.outlook.com/
> 
> But there are more reports, for example:
> https://lore.kernel.org/all/YvrkjH6%2FFpIzyAv+@euler/
> 
> Not sure if Greg didn't sent them to you because he think they need more
> time or because he's simply afk/busy and didn't manage to send pull
> requests.

I was busy, will get these out to Linus in the next few days.

thanks,

greg k-h
