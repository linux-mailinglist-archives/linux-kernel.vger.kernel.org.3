Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780A851B1C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358895AbiEDW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358817AbiEDW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:28:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3651FA76
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:24:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p12so2240547pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qvo1dzGzL2JmCNjYZk1fNrTcxUgcm4KOWzurldTYI3s=;
        b=gK03qTKIXewQFhPyvT47pEbIcdipk3r2FH2iFUMyT+KEiD/2rHJLN7rbUJq7v/HZMw
         r4EUmyTvIeET2LHKdQhORxf/vAo5/3E+/V6CmKSWJkDmvhaMbydTNjEgvfMO271wKD7A
         4/BvxyEA2KR1JDzk88Ui7WAUpU18dAk1bcdpPdVkePfdjUsoR9k+tUvAi2CvEgPkEvd3
         iWL/4IADtrrnj8Y38qG0gLcdQP8eb/EnCH3qsYNciZCGkxRxC7DDwj3d15AegUnFWtEv
         P1XSQ5vMJ8rav/dxEJ4SWmyQIdLzqprROriIJCV3AK9bRoDgHbU88ymG8rB/6iN759XO
         I0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qvo1dzGzL2JmCNjYZk1fNrTcxUgcm4KOWzurldTYI3s=;
        b=Spj2VNHEnRyr+uZgU+Crfis6pj3fNP3EIXKHGjaH8JLcw9THBw3eB7F8Dtk31bsRmk
         OdrxSsodhSJhIMkfB6Zf8pPZORl2s20ah1V9+LqnF/qKZ5o8qW0KqZngRxy3mAZ6qFoy
         tsaErZEcIijbw/56AbPoLtTsx8E+H9zargywQh/Yy21VV7yEJfOoY+66dTRC+VEYuXOk
         HSU9xGeB/NiHYy/yQZS90jk7fd2QKvCjGa/ltZiCFE0yt8YBvtpdUZI5FPiLm9gyUAaH
         Kr++c4KjASwwCa0+qroZaDhKy7H6sx5n7L0l4ajQQ+oZbThNtLChmHDvydWEJ8NviZSA
         vRDw==
X-Gm-Message-State: AOAM531V3bn+N04plpAemve1afjozVtboR9XCzBT2ZAq49PBSc+N5Upo
        /WzMMWlB1EYOnyUZ1BhizoUEfHSrIwU=
X-Google-Smtp-Source: ABdhPJwFc5JLjAEky7LScOnRsmDKdESGn+FrABNggxtJwcgl3s8HkaiqtnUdTAsUBOwMcsKhZM3YeQ==
X-Received: by 2002:a65:4787:0:b0:39d:96b7:bfaa with SMTP id e7-20020a654787000000b0039d96b7bfaamr20027629pgs.495.1651703092915;
        Wed, 04 May 2022 15:24:52 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id r7-20020a17090b050700b001d2bff34228sm3862102pjz.9.2022.05.04.15.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 15:24:52 -0700 (PDT)
Date:   Thu, 5 May 2022 07:24:50 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc: remove bogus nops and shutdowns
Message-ID: <YnL9MuVLtiGWD2EV@antec>
References: <20220504110911.283525-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504110911.283525-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 01:09:11PM +0200, Jason A. Donenfeld wrote:
> Nop 42 is some leftover debugging thing by the looks of it. Nop 1 will
> shut down the simulator, which isn't what we want, since it makes it
> possible to handle errors.

Do you mean impossible to handler errors?

> Cc: Stafford Horne <shorne@gmail.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

This looks good to me, I didn't add these debug's I think we can remove them.

-Stafford

> ---
>  arch/openrisc/mm/fault.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
> index 80bb66ad42f6..860da58d7509 100644
> --- a/arch/openrisc/mm/fault.c
> +++ b/arch/openrisc/mm/fault.c
> @@ -223,8 +223,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	{
>  		const struct exception_table_entry *entry;
>  
> -		__asm__ __volatile__("l.nop 42");
> -
>  		if ((entry = search_exception_tables(regs->pc)) != NULL) {
>  			/* Adjust the instruction pointer in the stackframe */
>  			regs->pc = entry->fixup;
> @@ -252,9 +250,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 */
>  
>  out_of_memory:
> -	__asm__ __volatile__("l.nop 42");
> -	__asm__ __volatile__("l.nop 1");
> -
>  	mmap_read_unlock(mm);
>  	if (!user_mode(regs))
>  		goto no_context;
> -- 
> 2.35.1
> 
