Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAB8497655
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 00:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240431AbiAWX17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 18:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiAWX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 18:27:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F28C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:27:58 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so14796122pjp.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 15:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OambT2HyQ0ksSzQY2cfN3PNR9KawIgMxaXdmBqJBPWc=;
        b=qkWfcwPbVcAL2gusNIG93Pe3gzsxsAsSDLsDWZDwS27VyzCiJ6ZuA07PvDLA5/yuLo
         /9Vo2aH3hq5KFcBD4e/p3oTOf0yZwqTZEOcB8xdJvdH/CuyhUAtfmv1OZ+qCV3HhVEfA
         HcOQQaouMeMnF57jlYCgYXcbNSNp6jt3rnsgKJRiHOW2LJ2qvDnK1o56zvlUGC6pgEtq
         jwbxA2SMjUan9XkYGSMnRyotYWM01eQfvFusrHRYwj939UE5awT1X4RZt7szZzDu7AHj
         mlGYo6T4Ml+ho2thupsxCow5t348d7rbsp3QvBshtpLhcHqkSuRG/V0yhxuyFz/IXIvL
         G6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OambT2HyQ0ksSzQY2cfN3PNR9KawIgMxaXdmBqJBPWc=;
        b=kN7Qm1s1VHb+A6Rw9JtTuthAkoTFS0IeAGYtRwb4xPUb0cyDFvf9CEEXrrCG6ruCNs
         1v/XaB3sFgaDZmSg5dAOqlE/v0I1URFW/wyy2Z5jIAfpYoO3lGRg9jq7B4hZBTvUuoif
         Tcd7OIhTSdF1UMH3Q3bg3hWxdfOSmh7eijXYJ8xkVGh9MwsKglB9AgBdIbCyMmnuzKzr
         Y05Y/BK9+HN6X1TGDpxwS8MPVfJ42ksM57pEKLOush749X23yk4tptB2obxUOU6mV1xS
         b54kAFJyjRckC7oPE6uxtzGXVUBkT67YH0oYYojWUJYVBPBkliBq/n3NPPoTnvyqtlru
         ycQA==
X-Gm-Message-State: AOAM531NZ9sZvi7LjvrN9a3iBd0+4TWoKxw2lVzYGE0VJ+Et9gs+q7l8
        Fxoo1CWCG6DGoJ7bZX4/15Q=
X-Google-Smtp-Source: ABdhPJwMNr3PXEokzxhNGsB/n1J+QIvtY/aK1oMnp6CJiL9L5RuUDLE/v7vUAq49vgOfREouA9rU+Q==
X-Received: by 2002:a17:902:da8e:b0:14b:370b:241e with SMTP id j14-20020a170902da8e00b0014b370b241emr6268252plx.121.1642980477444;
        Sun, 23 Jan 2022 15:27:57 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id b12sm14032944pfv.148.2022.01.23.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 15:27:56 -0800 (PST)
Date:   Mon, 24 Jan 2022 08:27:54 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.co.jp>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Kuniyuki Iwashima <kuni1840@gmail.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] openrisc/boot: Remove unnecessary initialisation in
 memcpy().
Message-ID: <Ye3keps4aHhkbYzr@antec>
References: <20220123020100.45201-1-kuniyu@amazon.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123020100.45201-1-kuniyu@amazon.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 11:01:00AM +0900, Kuniyuki Iwashima wrote:
> 'd' and 's' are initialised later with 'dest_w' and 'src_w', so we need not
> initialise them before that.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.co.jp>

This looks fine to me.  I will queue this for the next release.

Just curious why are you working on OpenRISC?

-Stafford

> ---
>  arch/openrisc/lib/memcpy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/lib/memcpy.c b/arch/openrisc/lib/memcpy.c
> index fe2177628..e2af9b510 100644
> --- a/arch/openrisc/lib/memcpy.c
> +++ b/arch/openrisc/lib/memcpy.c
> @@ -101,7 +101,7 @@ void *memcpy(void *dest, __const void *src, __kernel_size_t n)
>   */
>  void *memcpy(void *dest, __const void *src, __kernel_size_t n)
>  {
> -	unsigned char *d = (unsigned char *)dest, *s = (unsigned char *)src;
> +	unsigned char *d, *s;
>  	uint32_t *dest_w = (uint32_t *)dest, *src_w = (uint32_t *)src;
>  
>  	/* If both source and dest are word aligned copy words */
> -- 
> 2.30.2
> 
