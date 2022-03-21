Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82994E1FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 06:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbiCUFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiCUFNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 01:13:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C697B5A58F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 22:11:45 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n15so11755240plh.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 22:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljtCtXdVDHvboQzqZn2Q/lABoXg83zrD6bjOe7HHLFQ=;
        b=zfrmFyu/ZYdoUki2x8lfXqzA+xFOfDNne30+A0kuctzZXnrUfD659CDieFanTrv3ym
         h7/+Mi9WRZ8kPZXyA2Y27+TEoVcM3QsxC8yjssKaQgYIvuKCwEYlB3Wnyfr4cFQyTaK1
         nZ4s7AJMu7uVqv4/UnjgC8rv6vmx1l4/ycjLOnkiVxihvPOarlJvT1pnSRLkSeyqMRO5
         1qJl9DJK93bcaINaFdqtb9UQo84Y4IuUmTxZHvmmDep2CP0z9r9lEE6bISsIM8eCBXvo
         uPppjNLRkdm1iCvcgOQmohE4QG+QzsF8ONc1U9VYeQaBcQPx+aaTA/Fd7WgnHb+z0bVV
         Dd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljtCtXdVDHvboQzqZn2Q/lABoXg83zrD6bjOe7HHLFQ=;
        b=NZSErfu5NV2Dms2WLUX6dYeqO0TPUmdxJzrX0w5Vj77BthtyITGn9AXrpEUSq/J5Uj
         1Pf51w6kgu6HYs6Wqyl6oy76r8+y/3SWhBb7HRG9njPrCwYOYTrSpL21wAY77axiTCWW
         nIjJ8FQE7LObhy3VH90XO6kM3vElARHRYPiRFfNzyBqJH5i4jfl/ZqvYv58pJf6OV82e
         mgFii5ECIVpW1Kwp85JS8x5VCCPAuWzSg0fJOLPosgCO6P2vrSUepNyPgWd9YxVGA3nu
         t5phsMO6GRUegRumTmYvCZfrQO+p4OuAf8DlCDdeKX2r/ATT03CqlQaYQaBqCA9dyJ37
         iUug==
X-Gm-Message-State: AOAM5321F7j40fG2WDr24TO5h0EXd9WBgQZdK+JxfeN+XBHSU4cOzxlD
        +aNqnEhEKDpsKKKO7CV/VHgKyg==
X-Google-Smtp-Source: ABdhPJxpP7IH2vtw0+4J1t9nHjBU4tJNb2wQP+R8AXexRkuTkU6j6fBJND4g9OSGcNQaJ2MyM1HtBQ==
X-Received: by 2002:a17:902:700b:b0:148:ee33:70fe with SMTP id y11-20020a170902700b00b00148ee3370femr11279112plk.38.1647839505294;
        Sun, 20 Mar 2022 22:11:45 -0700 (PDT)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id o5-20020a655bc5000000b00372f7ecfcecsm13170925pgr.37.2022.03.20.22.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 22:11:44 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:41:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Viresh Kumar <vireshk@kernel.org>, kernel-janitors@vger.kernel.org,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: spear: fix typos in comments
Message-ID: <20220321051142.pkihlm6bnclmtdrq@vireshk-i7>
References: <20220318103729.157574-21-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318103729.157574-21-Julia.Lawall@inria.fr>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-03-22, 11:37, Julia Lawall wrote:
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  arch/arm/mach-spear/spear13xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
> index 74d1ca2a529a..b38391e9d8bf 100644
> --- a/arch/arm/mach-spear/spear13xx.c
> +++ b/arch/arm/mach-spear/spear13xx.c
> @@ -29,7 +29,7 @@ void __init spear13xx_l2x0_init(void)
>  	/*
>  	 * 512KB (64KB/way), 8-way associativity, parity supported
>  	 *
> -	 * FIXME: 9th bit, of Auxillary Controller register must be set
> +	 * FIXME: 9th bit, of Auxiliary Controller register must be set
>  	 * for some spear13xx devices for stable L2 operation.
>  	 *
>  	 * Enable Early BRESP, L2 prefetch for Instruction and Data,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
