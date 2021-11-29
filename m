Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8FD4625E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhK2Wo2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Nov 2021 17:44:28 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:34410 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbhK2Wnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:43:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2A367CE1689
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 22:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE25C53FAD;
        Mon, 29 Nov 2021 22:40:27 +0000 (UTC)
Date:   Mon, 29 Nov 2021 17:40:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        kernel@pengutronix.de, Colin Cross <ccross@android.com>
Subject: Re: [PATCH] pstore/ftrace: add a kernel parameter to start pstore
 recording
Message-ID: <20211129174025.70b5718f@gandalf.local.home>
In-Reply-To: <202111161259.D0972333@keescook>
References: <20210610082134.20636-1-u.kleine-koenig@pengutronix.de>
        <20211116120603.4e0c04c2@gandalf.local.home>
        <20211116172835.r3puikipzryxnsoj@pengutronix.de>
        <20211116123705.7f99e35e@gandalf.local.home>
        <202111161259.D0972333@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2021 13:00:07 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Tue, Nov 16, 2021 at 12:37:05PM -0500, Steven Rostedt wrote:
> > On Tue, 16 Nov 2021 18:28:35 +0100
> > Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> >   
> > > > Is this still needed? It's still in my internal patchwork, and I haven't
> > > > seen any responses.    
> > > 
> > > I didn't see any responses either, and unless someone else implemented
> > > something similar somewhere else, it's still needed.
> > > 
> > > The change was actually useful to debug a clk problem, where the machine
> > > freezed when a certain driver was loaded.  
> > 
> > Perhaps I should ask this. Would anyone object if I just take this change
> > through my tree for the next merge window?  
> 
> If you can Ack it, I'll take it via the pstore tree; I've got a few
> other things that will likely need to go in for the next merge window
> too.
>

I've must have missed this.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
