Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83F346515A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350768AbhLAPXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350733AbhLAPXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:23:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDEC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 07:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43782B82013
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E3C53FAD;
        Wed,  1 Dec 2021 15:20:07 +0000 (UTC)
Date:   Wed, 1 Dec 2021 10:20:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] tracing/histograms: String compares should not care
 about signed values
Message-ID: <20211201102005.474ef579@gandalf.local.home>
In-Reply-To: <20211201112100.23d4caafd8319e15073a41ed@kernel.org>
References: <20211130123736.7c3cab27@gandalf.local.home>
        <20211201112100.23d4caafd8319e15073a41ed@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 11:21:00 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 30 Nov 2021 12:37:36 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From 95f7262b44dc54fed8007cc3db8b39cbd16999c6 Mon Sep 17 00:00:00 2001
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > Date: Tue, 30 Nov 2021 12:31:23 -0500
> > Subject: [PATCH] tracing/histograms: String compares should not care about
> >  signed values
> > 
> > When comparing two strings for the "onmatch" histogram trigger, fields
> > that are strings use string comparisons, which do not care about being
> > signed or not.
> > 
> > Do not fail to match two string fields if one is unsigned char array and
> > the other is a signed char array.
> > 
> > Link: https://lore.kernel.org/all/20211129123043.5cfd687a@gandalf.local.home/  
> 
> Looks good to me.
> 
> Review-by: Masami Hiramatsu <mhiramatsu@kernel.org>
> 
>

Thanks Masami. I'll add your reviewed-by before posting to Linus.

-- Steve
