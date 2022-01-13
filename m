Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC548D386
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 09:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiAMIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:23:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229685AbiAMIXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642062219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XYvDNCqrzjNQi1i94ndAiCZSNdRpN6HLa1QDjOS6xvo=;
        b=hamDK02SpYb/8AGkrZa1/uhLiVO1GNObnQSw8iAY+QJE2BRSIezH0rE/c/YKzy1XA7l1iF
        J47UTJUMc1M9IaZTLMkbbWmmekf1k9/3Zdmv20S9JPkGwoE0B26cSE3LtfHfJAldvNJdUq
        lNXJjK6OnLElByTrCzVms8ZYJQ/XigU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-JBFki6HuMWaVbybtEwmKqw-1; Thu, 13 Jan 2022 03:23:38 -0500
X-MC-Unique: JBFki6HuMWaVbybtEwmKqw-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso4625986edd.22
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XYvDNCqrzjNQi1i94ndAiCZSNdRpN6HLa1QDjOS6xvo=;
        b=fmj+mOAcx0SWIhmPxM4GzvqXRYWjCejMg5LI+4Dp26YeKSop9FpynK5jI7fner98bt
         p8hlrj+cymZAi72LuQTMHTEWox+cHF9GyPvbScY7/a9nBYWGMed32iRGXQS3mhnj10XP
         teUUDdLAAR9lLagzOs5An4K3XVKI98NkkMRnyEufl+nhXu6FkIzDokqOa1+oitAzdZL1
         IGCDwl/1aOJ9Mswj04aCxQdpZIolXj/orwtqeJmh2I7SKWtO7OGrhxiJF9c4AkvS3jP1
         A/Y3lMpMOmMaj8EWKYJ26ZFMRylzF6LCtrZvBiEXX4bBQHlRdBp3O1d9zqpWq1hqpYaO
         ya3A==
X-Gm-Message-State: AOAM531aoJoMic4n4WDs35IY1HhJ4X/y45VNbGJOulV2+4fP6JDa7wM5
        egrjweUtba6VvpTi84KktjNP4qgEjqmp6il5FH1d4clepuDy4kWHZLfOaCGpiM5yF2/fBRL0qqN
        W4WfTxNt9U7SzpX7GNe4kk264
X-Received: by 2002:a05:6402:d44:: with SMTP id ec4mr3203026edb.109.1642062216953;
        Thu, 13 Jan 2022 00:23:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziKJ5OG3S6i4OF7ONpfKZ/LR7Ux0jYsJnPLJkhb4dchu4epXcviB/vcR0lYiYyrvFAxYCpEg==
X-Received: by 2002:a05:6402:d44:: with SMTP id ec4mr3203011edb.109.1642062216777;
        Thu, 13 Jan 2022 00:23:36 -0800 (PST)
Received: from [10.0.0.88] (host-79-47-126-144.retail.telecomitalia.it. [79.47.126.144])
        by smtp.gmail.com with ESMTPSA id 17sm623390eju.65.2022.01.13.00.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 00:23:36 -0800 (PST)
Message-ID: <8f37120b-9980-115b-3b7c-9351600b62b2@redhat.com>
Date:   Thu, 13 Jan 2022 09:23:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] kernel/sched: remove dl_boosted flag comment
Content-Language: en-US
To:     Hui Su <suhui_kernel@163.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
References: <20220107095254.GA49258@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220107095254.GA49258@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/22 10:52, Hui Su wrote:
> since commit 2279f540ea7d ("sched/deadline: Fix priority
> inheritance with multiple scheduling classes"), we should not
> keep it here.
> 
> Signed-off-by: Hui Su <suhui_kernel@163.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

-- Daniel

> ---
>  include/linux/sched.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 78c351e35fec..64426351d424 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -610,10 +610,6 @@ struct sched_dl_entity {
>  	 * task has to wait for a replenishment to be performed at the
>  	 * next firing of dl_timer.
>  	 *
> -	 * @dl_boosted tells if we are boosted due to DI. If so we are
> -	 * outside bandwidth enforcement mechanism (but only until we
> -	 * exit the critical section);
> -	 *
>  	 * @dl_yielded tells if task gave up the CPU before consuming
>  	 * all its available runtime during the last job.
>  	 *

