Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19AB5A2690
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiHZLGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiHZLFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:05:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5844642CF;
        Fri, 26 Aug 2022 04:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30C9ACE2F6F;
        Fri, 26 Aug 2022 11:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A03DC433C1;
        Fri, 26 Aug 2022 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661511949;
        bh=hTUIuHPBeCP7kGPU71SynWjBmXmLkWSnlXM1XJNBa94=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lGgtgCJs0zkraO6Xo0lxyJs4A/GyKJAurVuNOxaLbpKTLE/sdUptv1hxv8hJjrzMN
         rZT+Yu7xdXaE08JmxjlNZbyNh9uOxAkcUCgy40k9NOSjYc4mNBaK3NoaNFmasqzaEs
         BZEiqCLVkJUwvmURH/H0G/Ka3IznUEqwnj9SeauFqULzsNiV5dEGLWSO0RvlzWLTog
         8SF1CWDkaoj9M4La2dLzpzRH0N6aaNK721eEFVkscc9CAiPRMvF2kE+IwLkfB0nGsA
         LpWhELVbXlBSzzBwNM6GN3fL1C3Uk67hfrfvZBPFKwJZYH6Yz1Wf73Vko9Ib8sjsxA
         iEH3tBJ5mx2zA==
Date:   Fri, 26 Aug 2022 13:05:44 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        gomapo2868@safe-cart.com, LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Roman Romanenko <romu4444@gmail.com>,
        Nikolai Kondrashov <spbnick@gmail.com>,
        =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [Regression] Bug 216395 - XP-Pen Star G430S stops working on
 any kernel newer than 5.18.7
In-Reply-To: <a3ab81d9-0fe1-0bc9-b265-37793c11ff77@leemhuis.info>
Message-ID: <nycvar.YFH.7.76.2208261304470.19850@cbobk.fhfr.pm>
References: <a3ab81d9-0fe1-0bc9-b265-37793c11ff77@leemhuis.info>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022, Thorsten Leemhuis wrote:

> Hi, this is your Linux kernel regression tracker.
> 
> I noticed a regression report in bugzilla.kernel.org that afaics nobody
> acted upon since it was reported. That's why I decided to forward it by
> mail to those that afaics should handle this.
> 
> To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216395 :
> 
> >  gomapo2868@safe-cart.com 2022-08-22 16:28:00 UTC
> > 
> > XP-Pen Star G430S stops working on newer kernels than 5.18.7 (5.18.8, 5.19, 6.0rc1 tested)
> > It seems to use the uclogic drivers.
> 
> See the ticket for details and further comments.

Thorsten, thanks for the report.

CCing people who have been working on XP-Pen support recently (Roman, 
Nikolai, José).

Keeping the rest of the mail below for reference.

> 
> Please look into the issue if you're among the main recipients of this
> mail (and not just CCed). I hope I picked the right people to sent this
> to, if not just let everyone know (and apologies for getting it wrong!).
> 
> Anyway, to ensure this is not forgotten lets get this tracked by the the
> Linux kernel regression tracking bot:
> 
> #regzbot introduced: v5.18..5.18.7
> https://bugzilla.kernel.org/show_bug.cgi?id=216395
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply -- ideally with also
> telling regzbot about it, as explained here:
> https://linux-regtracking.leemhuis.info/tracked-regression/
> 
> Reminder for developers: When fixing the issue, add 'Link:' tags
> pointing to the report in bugzilla, as the kernel's documentation calls
> for; above page explains why this is important for tracked regressions.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
> 

-- 
Jiri Kosina
SUSE Labs

