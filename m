Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A04477548
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238248AbhLPPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhLPPCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:02:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302D2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 07:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC1FB61E50
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 15:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BABC36AE4;
        Thu, 16 Dec 2021 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639666958;
        bh=+ymRfnMDzS4Q00ODy6O0GETDfu0WUzcmTTTVopGCNyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pdufl+BNvm172d5N0T+EA45nB4IdQFjhQUgRlEJ6jU+ntmlgzYQl1V3VYxUmiHgVi
         Au5Xm5Kmj62x5srcRdhwsWniho1cf4p5Mckrs956HQdYoX1Xg1Vys7cSYo8FsWwaz+
         9MfHjN+y7UvY8+l3nx6oCWO099nVzwPCKeqXa1FwvNpbOeWHmB5FwghVC3X3TgVHt4
         6f9q1Upridr8mzw4eSqusQodsnJHO1XIr/dAaVDrIzZcnUMuzUhVXlrs5vFwtJkZy7
         bfJQVMZEkCOwIMg7sJ6FXMfSEucSTV5QtuEH7G1eXiL2I9dzRRY2u+6AX6nQ/NfAxF
         e2Yksm8G3og7g==
Date:   Fri, 17 Dec 2021 00:02:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v6 3/5] trace/README: Document objtrace trigger
 syntax
Message-Id: <20211217000234.46a613cf12d8402176c49322@kernel.org>
In-Reply-To: <20211129164951.220511-4-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
        <20211129164951.220511-4-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Tue, 30 Nov 2021 00:49:49 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Add a short description of the use of objtrace trigger.

Please merge this into the [1/5] and [2/5], because the changes of
"a new feature" and "the existance of the feature which
kernel indicates" must be atomic.

My recommendation is

- add following line in the first patch

	"\t            objtrace:add:obj[:count][if <filter>]\n"

- and update it as following in the next patch according to the changes

	"\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"


Thank you!


> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  kernel/trace/trace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 88de94da596b..a84b6813769e 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5590,6 +5590,9 @@ static const char readme_msg[] =
>  	"\t            enable_hist:<system>:<event>\n"
>  	"\t            disable_hist:<system>:<event>\n"
>  #endif
> +#ifdef CONFIG_TRACE_OBJECT
> +	"\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
> +#endif
>  #ifdef CONFIG_STACKTRACE
>  	"\t\t    stacktrace\n"
>  #endif
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
