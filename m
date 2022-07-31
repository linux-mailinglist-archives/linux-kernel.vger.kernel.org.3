Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61349585F4B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 16:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiGaOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 10:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGaOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 10:37:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBFF585
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 07:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BA55B80D60
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BDAC433C1;
        Sun, 31 Jul 2022 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659278257;
        bh=2+/VvW4FXQhZNTs7AE+JMbWDGKU62oUiFhqWYCH7hRs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dI29yFK92boTsZ/bRlXMcgoCMmBQBShmKXEjXqZ/pW4o0NkzSmqXp73OoFI5eGH4G
         jW88q4LcBB/xrXib4zvM4ATPl8tzeQ/8cL2a8LUQkwD2K9EJ7Q6tWDtCJ+510eC4MR
         8fTf9w3c6wQocRVh3LN0NUq+uppX3SOG7NauJkCGMryJfof4n2iG3l6Xxo4cHRlyE/
         CT5LdhI5EUudvLECc9B8GNa4k/GlcYPHYKS7FZp0xP/2+CyXkm74ki9YMGuPItFj5v
         6nTutqO+BkwVqQ6Df9iXJnVajnt///lEUn99ZPjT8RjpoWBWWC2U9PfifzDQFTA7SV
         nQNoQKeo0qkMQ==
Date:   Sun, 31 Jul 2022 23:37:32 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     zhangduo <zduo006@163.com>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, zhangduo <zhangduo@kylinos.cn>
Subject: Re: [PATCH 2/2] kprobes: fix the comments error
Message-Id: <20220731233732.446610618f2f208f13b8e2a1@kernel.org>
In-Reply-To: <20220722062505.20309-1-zduo006@163.com>
References: <20220722062505.20309-1-zduo006@163.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 14:25:05 +0800
zhangduo <zduo006@163.com> wrote:

> From: zhangduo <zhangduo@kylinos.cn>
> 
> fix the comments 'Copy the insn slot of ap to p'
> 
> Signed-off-by: zhangduo <zhangduo@kylinos.cn>

Looks good to me. 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks, 

> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f1dddc8fe..8bcef7d3c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1349,7 +1349,7 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
>  			    | KPROBE_FLAG_DISABLED;
>  	}
>  
> -	/* Copy the insn slot of 'p' to 'ap'. */
> +	/* Copy the insn slot of 'ap' to 'p'. */
>  	copy_kprobe(ap, p);
>  	ret = add_new_kprobe(ap, p);
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
