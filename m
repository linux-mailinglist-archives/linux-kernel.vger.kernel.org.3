Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734CD4A0334
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351661AbiA1Vuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiA1Vut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:50:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30EC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 13:50:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 851EF61ED1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 21:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDB1C340E7;
        Fri, 28 Jan 2022 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643406647;
        bh=qN9zmboicEwS+GEda7jyDN1YakV0e6bDVAycbGdvEUs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tdW+2mo0LTbRg5Ue8hrf9MRo08NjU3OOH5YLh/Ocfci67vz3XuWanyXmqW2gNht2X
         FZRJicE7ItTQjQ8Nsb8X3TvMfoasCOBD+pxZP67a8w0iklUlkJayPB7Adu64mxzrZZ
         7/jI8r1TtlHV5ZQ8/b+syyz5NCJzflDhDn2i7AANrXIzRdF00/uH0c1f9BYWLsvmDa
         oHi0UPX8/KqcmuLtqQsGKQclkA3U0Lhqvmn1RzCKXO7qMPjVEmKty1sgh/mwMljMCQ
         DGYtAmr1jCf5QgqFChp6qEn1CS9f+ES2Et7o4zrLgcFuqquyZwdR1PmhFn2h9CDfFO
         qWJ2KTfNGT6qQ==
Message-ID: <52c7f9e7effb6bd09d35b95bdca056a3e0907667.camel@kernel.org>
Subject: Re: [PATCH v2 0/2] tracing: Misc bugfixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:50:45 -0600
In-Reply-To: <20220128164219.1a5189cd@gandalf.local.home>
References: <cover.1643399022.git.zanussi@kernel.org>
         <20220128164219.1a5189cd@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-01-28 at 16:42 -0500, Steven Rostedt wrote:
> On Fri, 28 Jan 2022 14:08:25 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > There were 2 patches in v1 that were flagged by the 0day robot for
> > strncpy off-by-1 warnings:
> > 
> >   tracing: Remove size restriction on hist trigger cmd error
> > logging
> >   tracing: Remove size restriction on synthetic event cmd error
> > logging
> > 
> >   warning: 'strncpy' output truncated before terminating nul
> > copying
> >   as many bytes from a string as its length [-Wstringop-truncation]
> > 
> > This v2 patchset consists of just those two patches with the fix
> > for
> > those warnings.
> 
> 
> So this just replaces the last two patches you sent previously?
> 

Yes.

> Probably would have been better to send all three (since the other 4
> already made it into mainline).
> 

OK, yeah, thought about doing that but guessed wrong, as usual ;-)

> But if "tracing: Remove size restriction on tracing_log_err cmd
> strings" is
> OK:
> 
>    

Yeah, that one is ok as-is without changes.

Tom

> 
https://lkml.kernel.org/r/ca965f23256b350ebd94b3dc1a319f28e8267f5f.1643319703.git.zanussi@kernel.org
> 
> then I'll just replace the other two.
> 
> -- Steve



