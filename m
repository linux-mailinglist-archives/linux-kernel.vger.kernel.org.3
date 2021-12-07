Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C1B46C5E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 22:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhLGVFx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Dec 2021 16:05:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52792 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhLGVFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 16:05:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6744B81E8D;
        Tue,  7 Dec 2021 21:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053C7C341C3;
        Tue,  7 Dec 2021 21:02:04 +0000 (UTC)
Date:   Tue, 7 Dec 2021 16:02:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>, carnil@debian.org
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211207160203.30206456@gandalf.local.home>
In-Reply-To: <20211207205628.auc54rwl4duuisah@linutronix.de>
References: <YalDQe/lyXqAxB0K@uudg.org>
        <20211207201712.7yqbksbba3zgu7u3@linutronix.de>
        <20211207152049.1013e1ce@gandalf.local.home>
        <20211207205628.auc54rwl4duuisah@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 21:56:28 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-12-07 15:20:49 [-0500], Steven Rostedt wrote:
> > On Tue, 7 Dec 2021 21:17:12 +0100
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> > > On 2021-12-02 19:05:53 [-0300], Luis Claudio R. Goncalves wrote:  
> > > > I'm pleased to announce the 5.10.83-rt58 stable release.    
> > > …  
> > > >   https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.83-rt58.patch.xz    
> > > 
> > > Any particular reason why every patch has "v4.9-rt" in the Subject line?  
> > 
> > I'm guessing because he just took over 5.10-rt and did not update his
> > scripts ;-)  
> 
> It seems to confuse ppl. Is there a reason to have it?
>

It shouldn't. The point I'm making is that this is Luis's first release of
5.10-rt, and it sounds like it had some issues.

Luis, you may want to see what happened and fix it.

Thanks,

-- Steve
