Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB2B46363F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbhK3ORH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:17:07 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:45168 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242083AbhK3OPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:15:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 668E8CE198C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 14:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16762C53FC1;
        Tue, 30 Nov 2021 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638281500;
        bh=T+TSCFtvX2inDp2gjsscBDWbL51eQSe+UW0aI3XegBA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RLzOJb2kt+6+n0YhgXKIPRypbHta5Nt6cHqqixZKMdvfsoOYp9coI4Jekgap+Km2q
         8DYTPOfI1zrhImtZQkhYf1MTCCT0yVOvLT0xmGxI7D7Gzg9oHwyZbaC6AkzRQ8Q+oT
         6kH92f1VGA3Ry8E9O6Q3DnSZyageK4Dxz0b3TFrzsuR4Ts0EWeIsRoxYqspleBrs/n
         spQ2TiN/0/kU3ds6eTZHzpOkMhlkJa9vx953dPjn+mxlCsoWcNCZ6ruDlYR13v/ROX
         enVlyH4FZXFkwntfdwIxIHK0D6ajfV+NsO1vWlEzsyykjQGFytA93U406YpPePo4bJ
         m9Y+2PCoKrA1g==
Date:   Tue, 30 Nov 2021 23:11:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH] selftests/ftrace: make kprobe profile testcase
 description unique
Message-Id: <20211130231130.41f9bfcc35ceda68471bbb0b@kernel.org>
In-Reply-To: <20211130122546.3622291-1-hca@linux.ibm.com>
References: <20211130122546.3622291-1-hca@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 13:25:46 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Commit 32f6e5da83c7 ("selftests/ftrace: Add kprobe profile testcase")
> added a new kprobes testcase, but has a description which does not
> describe what the test case is doing and is duplicating the desription
> of another test case.
> Therefore change the test case description, so it is unique and then
> allows easily to tell which test case actually passed or failed.

Good catch!

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  tools/testing/selftests/ftrace/test.d/kprobe/profile.tc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
> index 98166fa3eb91..34fb89b0c61f 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> -# description: Kprobe dynamic event - adding and removing
> +# description: Kprobe profile
>  # requires: kprobe_events
>  
>  ! grep -q 'myevent' kprobe_profile
> -- 
> 2.32.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
