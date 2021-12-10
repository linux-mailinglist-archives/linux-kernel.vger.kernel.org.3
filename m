Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204FE47078A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbhLJRn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:43:57 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:50582 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLJRn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1360ACE2C3F;
        Fri, 10 Dec 2021 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19BCC341C5;
        Fri, 10 Dec 2021 17:40:17 +0000 (UTC)
Date:   Fri, 10 Dec 2021 12:40:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] recordmcount.pl: look for jgnop instruction as well as
 bcrl on s390
Message-ID: <20211210124016.48d7883c@gandalf.local.home>
In-Reply-To: <YbN3h7cyC01adiwr@osiris>
References: <20211210093827.1623286-1-jmarchan@redhat.com>
        <alpine.LSU.2.21.2112101054070.5704@pobox.suse.cz>
        <YbMyvJ6gz7LvoXgE@osiris>
        <alpine.LSU.2.21.2112101310080.5704@pobox.suse.cz>
        <alpine.LSU.2.21.2112101321010.5704@pobox.suse.cz>
        <YbN3h7cyC01adiwr@osiris>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2021 16:51:35 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Fri, Dec 10, 2021 at 01:31:23PM +0100, Miroslav Benes wrote:
> > > > Otherwise I would be surprised that this would make any difference.  
> > > 
> > > How come? I mean, s390 does not define HAVE_C_RECORDMCOUNT which implies 
> > > that recordmcount.pl is used (see scripts/Makefile.build and 
> > > BUILD_C_RECORDMCOUNT definition in Makefile).  
> > 
> > Ah, sorry, that was too quick.
> > 
> > I guess you want to say that recordmcount is not used at all and GCC 
> > should do it. Because CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT is not set, 
> > since FTRACE_MCOUNT_USE_CC should be set.
> > 
> > What a maze.
> > 
> > But isn't -mrecord-mcount x86_64-only option?  
> 
> No, it is (at least) also supported on s390. IIRC that was added with
> gcc9. Anyway, this is not too important since the fix makes sense
> anyway.

Thanks everyone for fixing this.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
