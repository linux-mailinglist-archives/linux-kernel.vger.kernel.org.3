Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F231846DD42
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhLHUuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHUuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:50:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A177C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 12:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3155DB822BA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 20:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E977DC00446;
        Wed,  8 Dec 2021 20:46:35 +0000 (UTC)
Date:   Wed, 8 Dec 2021 15:46:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tracing: Iterate trace_[ku]probe objects directly
Message-ID: <20211208154634.71f97425@gandalf.local.home>
In-Reply-To: <20211126214055.b6a84e8add8f7ae3deb9411b@kernel.org>
References: <20211125202852.406405-1-jolsa@kernel.org>
        <20211126214055.b6a84e8add8f7ae3deb9411b@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 21:40:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 25 Nov 2021 21:28:52 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > As suggested by Linus [1] using list_for_each_entry to iterate
> > directly trace_[ku]probe objects so we can skip another call to
> > container_of in these loops.
> >   
> 
> This looks very good to me :)
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Added to my queue. Thanks Jiri and Masami.

-- Steve
