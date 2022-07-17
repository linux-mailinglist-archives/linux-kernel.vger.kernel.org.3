Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C382F577292
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 02:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiGQAiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 20:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGQAh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 20:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64451262F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 17:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4021E60C2D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F26C34114;
        Sun, 17 Jul 2022 00:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658018275;
        bh=jSSsB/i+Cf2qsXiMbFN7Vs+OI8eKquku+CHSUyQmSOQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xNSUAW0t5qVkmdsc5mswH6KApEVpZz/rCHu2qzalDPMNVzk0mx+XkUuRcPI4U6DgF
         wzwBTafU8briQD9257Q7fmVukf/h2dSIRYwPcSxK4ksWHxB7z+ppJzNPVyQ4v7TpYs
         Mm2kK85sCTFYJr48dFwqPkti2w4bnOjAdoHU1TLI=
Date:   Sat, 16 Jul 2022 17:37:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Gavin Keusch <gavinkeusch@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: watchdog: fix missing space coding style issue
Message-Id: <20220716173754.62f9cc348cfa08951770bb0b@linux-foundation.org>
In-Reply-To: <20220714083149.GC2737@pathway.suse.cz>
References: <20220714060457.96599-1-gavinkeusch@gmail.com>
        <20220714083149.GC2737@pathway.suse.cz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 10:31:49 +0200 Petr Mladek <pmladek@suse.com> wrote:

> Adding Andrew into Cc who usually takes patches for kernel/watchdog.c.
> 
> Best Regards,
> Petr
> 
> On Wed 2022-07-13 23:04:57, Gavin Keusch wrote:
> > Fixed missing space causing coding style error
> > 
> > Signed-off-by: Gavin Keusch <gavinkeusch@gmail.com>
> > ---
> >  kernel/watchdog.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> > index ecb0e8346e65..b6b150c4b179 100644
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -306,7 +306,7 @@ static int is_softlockup(unsigned long touch_ts,
> >  			 unsigned long period_ts,
> >  			 unsigned long now)
> >  {
> > -	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh){
> > +	if ((watchdog_enabled & SOFT_WATCHDOG_ENABLED) && watchdog_thresh) {
> >  		/* Warn about unreasonable delays. */
> >  		if (time_after(now, period_ts + get_softlockup_thresh()))
> >  			return now - touch_ts;

Patch is too minor to justify merging, sorry.  If it fixed 15
coding-style errors then maybe.  But this way just leads to too much
noise.

