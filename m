Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3168F473238
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhLMQsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbhLMQsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:48:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0F5C061574;
        Mon, 13 Dec 2021 08:48:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17DD6118A;
        Mon, 13 Dec 2021 16:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EE3C34603;
        Mon, 13 Dec 2021 16:48:17 +0000 (UTC)
Date:   Mon, 13 Dec 2021 11:48:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/13] user_events: Add minimal support for
 trace_event into ftrace
Message-ID: <20211213114816.782e8504@gandalf.local.home>
In-Reply-To: <20211213090915.58034cd6c74782a4f58aacc2@kernel.org>
References: <20211209223210.1818-1-beaub@linux.microsoft.com>
        <20211209223210.1818-3-beaub@linux.microsoft.com>
        <20211210194358.e590d49a1620df7345f9f679@kernel.org>
        <20211210124305.24acd61f@gandalf.local.home>
        <20211213090915.58034cd6c74782a4f58aacc2@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 09:09:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > > Steve, can we write such a big event data on the trace buffer?  
> > 
> > In the future yes!
> > 
> >   https://lore.kernel.org/all/20211125175253.186422-1-tz.stoyanov@gmail.com/  
> 
> Ah, nice!
> 
> > 
> > But it will still require some configuration changes from user space. But
> > that said, if the user wants to add a larger size, then they can do so (in
> > the future).  
> 
> Hmm, so, at this moment I recommend to pick the max size of the event
> smaller than page size but enough large (e.g. 1024, that is finally Beau
> has chosen).
> And after that new ring buffer introduced, expand it.
> What would you think?

I'm fine with that.

-- Steve
