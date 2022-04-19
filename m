Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF62506628
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349539AbiDSHro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbiDSHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:47:40 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C907240A2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:44:58 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id ks6so31162124ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+JSsT707sCv2QcWZYnglmbWyVpq/ugMdBKjViokwxWs=;
        b=X7MJF3e3O/9TZJaLqyu99oY47hm3JvDgc+DpsArE4X/d8YmnD8NhNv2z5dZQk9/dGo
         ZpPsEKRHJYsaOOFqJ1D7h4/2kN5Q3PIj3/ozBfQENI9Ze0mTczIVHceMKEunPaVXPipM
         pzTrTEF2zwWnRxpUQUwwMnU7UYJGeD4YJ3bOdtR0fP5xRZ/RMcrYfon+cuc7pXNenf3U
         XMn9Yg5WVl+d4R9J0SYC/AFxxIz9oB1CwQEbJ5kf01bVfSc4B3uDQRk2Q+Uipw+U2Jpd
         Tu1e4EUDCSlXsrF6DE92MuNy2Gl7RJl9azNb0ljVqTuwMo6ibv6GD+N/KZv/Pwzx0Jbr
         SBxg==
X-Gm-Message-State: AOAM533/QhuvyzYLXEsLg90grlWB6s7tQqwpt5ycpqfS23O9Vjynt5R4
        kSJU69jRZBJtoSlcpuQ8VB+V4HdW8YM=
X-Google-Smtp-Source: ABdhPJxxD5OJ/ccuoyLvC6PmJXvvwKQ0oTUSJzh6k1maDcFqFLQClafNjIZIPZzRqDy+BFhOzN1ZoQ==
X-Received: by 2002:a17:907:60d3:b0:6db:8b59:1564 with SMTP id hv19-20020a17090760d300b006db8b591564mr12243772ejc.228.1650354297244;
        Tue, 19 Apr 2022 00:44:57 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id b11-20020a17090630cb00b006e83fb1e6b1sm5408655ejb.100.2022.04.19.00.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 00:44:56 -0700 (PDT)
Message-ID: <b126db72-42f9-f767-a870-1e8d47d92674@kernel.org>
Date:   Tue, 19 Apr 2022 09:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] tty/sysrq: change the definition of sysrq_key_table's
 element to make it more readable
Content-Language: en-US
To:     Junwen Wu <wudaemon@163.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Junwen Wu <wudaemon@gmail.com>
References: <20220418153703.97705-1-wudaemon@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220418153703.97705-1-wudaemon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 04. 22, 17:37, Junwen Wu wrote:
> From: Junwen Wu <wudaemon@gmail.com>
> 
> The definition of sysrq_key_table's elements, like sysrq_thaw_op and
> sysrq_showallcpus_op are not consistent with sysrq_ftrace_dump_op,
> Consistency makes code more readable.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Junwen Wu <wudaemon@gmail.com>
> ---
> V1 -> V2: Fix some commit message's error
> 
>   drivers/tty/sysrq.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index bbfd004449b5..9485156bf48b 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -274,6 +274,8 @@ static const struct sysrq_key_op sysrq_showallcpus_op = {
>   	.action_msg	= "Show backtrace of all active CPUs",
>   	.enable_mask	= SYSRQ_ENABLE_DUMP,
>   };
> +#else
> +#define sysrq_showallcpus_op (*(const struct sysrq_key_op *)NULL)
>   #endif
>   
>   static void sysrq_handle_showregs(int key)
> @@ -405,6 +407,7 @@ static const struct sysrq_key_op sysrq_moom_op = {
>   	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
>   };
>   
> +#ifdef CONFIG_BLOCK
>   static void sysrq_handle_thaw(int key)
>   {
>   	emergency_thaw_all();
> @@ -415,6 +418,9 @@ static const struct sysrq_key_op sysrq_thaw_op = {
>   	.action_msg	= "Emergency Thaw of all frozen filesystems",
>   	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
>   };
> +#else
> +#define sysrq_thaw_op (*(const struct sysrq_key_op *)NULL)
> +#endif
>   
>   static void sysrq_handle_kill(int key)
>   {
> @@ -468,17 +474,9 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
>   	NULL,				/* g */
>   	NULL,				/* h - reserved for help */
>   	&sysrq_kill_op,			/* i */
> -#ifdef CONFIG_BLOCK
>   	&sysrq_thaw_op,			/* j */
> -#else
> -	NULL,				/* j */
> -#endif
>   	&sysrq_SAK_op,			/* k */
> -#ifdef CONFIG_SMP
>   	&sysrq_showallcpus_op,		/* l */
> -#else
> -	NULL,				/* l */
> -#endif
>   	&sysrq_showmem_op,		/* m */
>   	&sysrq_unrt_op,			/* n */
>   	/* o: This will often be registered as 'Off' at init time */


-- 
js
suse labs
