Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1315A4F60F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbiDFOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiDFOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:08:40 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09429D25F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:57:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id g22so1978680edz.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 02:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DZ+POTcsaLkbMBo1CqBhzn/vBLLAxpoEW4QABrQlisQ=;
        b=CRTnuQGhMYTEe3X2W6mPLm/rYVRez1DDjvF3norRcXMqm0kR5DF1fyXugZDH4Q/ZJE
         HO7KjSES2fw061YnAiRTCHNmJ4y/X1chnVfNxCcayYvzRwwb+p+IrPP8bWSw/jLv/yq2
         TVmmeEJdH4eXZ7jEYQKx2DkZ7DTDzEdfHxuIdg9YH6uCAwSj9C7aDvAZC1ZZMKTFxpzZ
         hvt7SJCf7wKlI7F/F9P+azTvbK+wW7IrxGt2U72CYVgcMq3tX9/p4W5wy1moNYAs9kus
         92b/rRLNCQTDA4HtNwRR4Kc++OCHMfLWLwg7iP48HYfG7m3iKRVSQAJJ4AOXm9JuZx78
         uTtw==
X-Gm-Message-State: AOAM533EP3b/8QgkVsoivskviLxtkoai8Ck9rfiG/mt4PFo1H5fKvxbB
        5l+WbSFb+YiSF+WkN0wBVHFxNT4R+HU=
X-Google-Smtp-Source: ABdhPJxpg8ho5fSv2sVWTjZY4TksMQ+SF2ZZRW0S++abhw2YiStIbejQjLOOG1NE+CNGVeHgAb3h9g==
X-Received: by 2002:a05:6402:31e2:b0:41c:dd5e:3c61 with SMTP id dy2-20020a05640231e200b0041cdd5e3c61mr7797701edb.407.1649239033620;
        Wed, 06 Apr 2022 02:57:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm3691091edl.28.2022.04.06.02.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 02:57:13 -0700 (PDT)
Message-ID: <19e11d77-1f81-c5a8-8a72-4fb7616438bf@kernel.org>
Date:   Wed, 6 Apr 2022 11:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1] tty/sysrq: change the definition of sysrq_key_table's
 element to make it more readable
Content-Language: en-US
To:     wujunwen <wudaemon@163.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220405153625.55689-1-wudaemon@163.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220405153625.55689-1-wudaemon@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05. 04. 22, 17:36, wujunwen wrote:
> the definition of sysrq_key_table's elements, like sysrq_thaw_op and

The starts the sentence, so should be with capital T.

> sysrq_showallcpus_op are massive,

massive?

> so we should make it consistent.

You should elaborate consistent to what.

> Signed-off-by: wujunwen <wudaemon@163.com>

Is this really your real full name?

Other than that, the patch appears to be correct.

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
