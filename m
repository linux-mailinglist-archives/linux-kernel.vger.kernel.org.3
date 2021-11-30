Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A65463AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbhK3QEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhK3QEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:04:37 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:01:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DD75CCE1A5D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 16:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21595C53FC1;
        Tue, 30 Nov 2021 16:01:13 +0000 (UTC)
Date:   Tue, 30 Nov 2021 11:01:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: make kprobe profile testcase
 description unique
Message-ID: <20211130110102.7ee120f2@gandalf.local.home>
In-Reply-To: <20211130231130.41f9bfcc35ceda68471bbb0b@kernel.org>
References: <20211130122546.3622291-1-hca@linux.ibm.com>
        <20211130231130.41f9bfcc35ceda68471bbb0b@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 23:11:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Tue, 30 Nov 2021 13:25:46 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > Commit 32f6e5da83c7 ("selftests/ftrace: Add kprobe profile testcase")
> > added a new kprobes testcase, but has a description which does not
> > describe what the test case is doing and is duplicating the desription
> > of another test case.
> > Therefore change the test case description, so it is unique and then
> > allows easily to tell which test case actually passed or failed.  
> 
> Good catch!
> 
> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Shuah,

Care to take this through your tree?

Thanks!

-- Steve
