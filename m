Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA1846BD30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237524AbhLGOH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:07:27 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37316 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbhLGOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:07:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5E7DBCE1AAC;
        Tue,  7 Dec 2021 14:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15329C341C3;
        Tue,  7 Dec 2021 14:03:48 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:03:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Keeping <john@metanate.com>
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH/RFC] tracing: make trace_marker{,_raw} stream-like
Message-ID: <20211207090347.15822d87@gandalf.local.home>
In-Reply-To: <Ya835b6JGrjBQCtF@donbot>
References: <20210909115734.3818711-1-john@metanate.com>
        <20210909083529.34ae09da@gandalf.local.home>
        <Ya835b6JGrjBQCtF@donbot>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Dec 2021 10:31:15 +0000
John Keeping <john@metanate.com> wrote:

> Were you expecting more input from me on this?  The above sounded like
> "will be added for 5.16" but I don't see this change in v5.16-rc4 and
> the patch is still marked as "New" in patchwork [1]
> 
> [1] https://patchwork.kernel.org/project/linux-trace-devel/patch/20210909115734.3818711-1-john@metanate.com/

And that explains why I didn't add it :-(

The linux-trace-devel is mainly for user space tools, although some kernel
patches end up there too. Any patch that hits my inbox without Cc'ing
linux-trace-devel falls into my internal patchwork. I look at that one
first for kernel patches to add to my queue, and then I'll look at that
public one. I forgot about this conversation, and because the title of that
patch has RFC in it, I thought there would be another patch coming. I don't
add RFC patches generally, and forgot about this conversation.

Can you resend the patch to me, but remove the linux-trace-devel mailing
list (but still include linux-kernel).

Thanks!

-- Steve
