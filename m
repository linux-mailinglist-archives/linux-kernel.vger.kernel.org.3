Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98D952FDD8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiEUP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiEUP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEF36161B;
        Sat, 21 May 2022 08:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8368E60DD4;
        Sat, 21 May 2022 15:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D1EC385A5;
        Sat, 21 May 2022 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653146910;
        bh=AIDLIbiM3xgYCLX2XEeSflOaYYKL7d+10fkOYwkK2EU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K+WxHnneXjL/20w2aIWiw+f4dHin6WyiZNiBWel/jpsprVdcTELFSzyhYkDszCqIb
         JhgtBt4XEzekfBJxYA79GDXD3CmDWQSJ26U7xb0AAtybduaULJI8knRLfpiILH6uGz
         Px2IAUNlqCXVRsZWUGI0gLdU3Ar5gVH2K6StZmMdCBAGnOy0e1QJAJCti3fc3mxxVK
         P+FFyB3WN6ihtY0HHVgO5YEs3S/reug6I3vRAO6xfMwLt7BxRODZzsMXXe/Im2262y
         3j3HKK6EyqRYSVkhPPth34PB+RE+M6WTg4N5s8J7pQA9ZEwW8HZPSuaUHAk5OXQKU2
         Wtv5OtRU/DP2A==
Date:   Sun, 22 May 2022 00:28:26 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        kernel-janitors@vger.kernel.org,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: fix typo in comment
Message-Id: <20220522002826.b1afffb4d70b0be5c0dce363@kernel.org>
In-Reply-To: <20220521111145.81697-63-Julia.Lawall@inria.fr>
References: <20220521111145.81697-63-Julia.Lawall@inria.fr>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 May 2022 13:11:13 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dd58c0be9ce2..4721b76e61a1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -651,7 +651,7 @@ void wait_for_kprobe_optimizer(void)
>  	while (!list_empty(&optimizing_list) || !list_empty(&unoptimizing_list)) {
>  		mutex_unlock(&kprobe_mutex);
>  
> -		/* This will also make 'optimizing_work' execute immmediately */
> +		/* This will also make 'optimizing_work' execute immediately */
>  		flush_delayed_work(&optimizing_work);
>  		/* 'optimizing_work' might not have been queued yet, relax */
>  		cpu_relax();
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
