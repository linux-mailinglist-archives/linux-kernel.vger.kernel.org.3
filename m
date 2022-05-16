Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A19527D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiEPGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEPGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:20:33 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D8D237CD;
        Sun, 15 May 2022 23:20:32 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so16455410pju.2;
        Sun, 15 May 2022 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=DcZjs3ba7f9w8RDs+CRDdm+yhwI/+KTZPcRVRyvUNKE=;
        b=HOSdc5gOHPemmhTL1XOivDupnikED1vxreDU44nW7s0fajBnemu2JOSnt+mdErJq1L
         94iIxGcDkfyqkaetzLMSpIPzaSUKO0NUpkEXa9QM24nBP4lDq5DjDLxv3D4T+0B+JNhS
         siLukponbqWnaosw/uID2jjx011/S0DSEIpFhr/3SQ5byuPgyaSqbWlYv7y8EMhYQ9A2
         la5whvYCB0DebZhbkT6HfmD+4Xi0YjEEz+PtJI4g2QVmLN1ACae0e4qk1DCGiaSNOUPb
         q1tIgvUWo4x2cuazMZeGF3+sOjjFAGwCZ5rR+wqpcfWaic1Q4Qy+8dADObSy0o1+p+Cb
         aQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DcZjs3ba7f9w8RDs+CRDdm+yhwI/+KTZPcRVRyvUNKE=;
        b=c5k9YwPydZHFG1RbXs/0gpf4mepl+y+je+Ow9aLx4cey9dlxadASi23vgRXwEKIYxe
         5glI+nzUMYvbBtnAJu7lG6g0hQ+oh0dUCuOqQx5dD+vhwo3L+4QcCMgjtlLqCr6eqYSy
         0ESGKMQHfNPjWASeSBUR0HEVJ/lVkYc3WoSkf2zuHQZ+CDwloh67pHmtB5kCRWEhzvrB
         YWHrjiUsNxFMC8AUFbOGArmuP5447zIrGUVq85BbfCRxjBTdlJyijCfhA8yJwCT6/KVF
         5+Rxr5sU6YPmp9adjJVH7HGYgSZQe9xzZH16uLtXUNKhBBXV/CAz5pbE1b75tSAS547t
         6H8Q==
X-Gm-Message-State: AOAM531yBOWdnytYWkAw6lEygGS2eBVcgMO90UDYgdQjhmm3uYeAW6mm
        xHK9dZNdBRZ2FhvWHs71yNU=
X-Google-Smtp-Source: ABdhPJzc1Z3QiVN/g6C2H+ZM4bEnqCR9FjyMRYwog6HRLTBOfoXH7Q8xVhGqHWpKj4Yzvn4XlD6ujA==
X-Received: by 2002:a17:90b:4c8a:b0:1dc:6b4b:bf9c with SMTP id my10-20020a17090b4c8a00b001dc6b4bbf9cmr17806666pjb.54.1652682031863;
        Sun, 15 May 2022 23:20:31 -0700 (PDT)
Received: from [192.168.2.225] (93.179.119.173.16clouds.com. [93.179.119.173])
        by smtp.gmail.com with ESMTPSA id d13-20020a62f80d000000b0050dc7628162sm6022977pfh.60.2022.05.15.23.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 May 2022 23:20:31 -0700 (PDT)
Message-ID: <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com>
Date:   Mon, 16 May 2022 14:20:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall
 trigger
Content-Language: en-US
To:     Chen Wandun <chenwandun@huawei.com>, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, surenb@google.com, alexs@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
References: <20220516033524.3130816-1-chenwandun@huawei.com>
From:   Alex Shi <seakeel@gmail.com>
In-Reply-To: <20220516033524.3130816-1-chenwandun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/22 11:35, Chen Wandun wrote:
> Nowadays, psi events are triggered when stall time exceed
> stall threshold, but no any different between these events.
> 
> Actually, events can be divide into multi level, each level
> represent a different stall pressure, that is help to identify
> pressure information more accurately.
> 
> echo "some 150000 350000 1000000" > /proc/pressure/memory would

This breaks the old ABI. And why you need this new function?

Thanks

> add [150ms, 350ms) threshold for partial memory stall measured
> within 1sec time window.
> 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  include/linux/psi_types.h |  3 ++-
>  kernel/sched/psi.c        | 19 +++++++++++++------
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> index c7fe7c089718..2b1393c8bf90 100644
> --- a/include/linux/psi_types.h
> +++ b/include/linux/psi_types.h
> @@ -119,7 +119,8 @@ struct psi_trigger {
>  	enum psi_states state;
>  
>  	/* User-spacified threshold in ns */
> -	u64 threshold;
> +	u64 min_threshold;
> +	u64 max_threshold;
>  
>  	/* List node inside triggers list */
>  	struct list_head node;
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 6f9533c95b0a..17dd233b533a 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -541,7 +541,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>  
>  			/* Calculate growth since last update */
>  			growth = window_update(&t->win, now, total[t->state]);
> -			if (growth < t->threshold)
> +			if (growth < t->min_threshold || growth >= t->max_threshold)
>  				continue;
>  
>  			t->pending_event = true;
> @@ -1087,15 +1087,18 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  {
>  	struct psi_trigger *t;
>  	enum psi_states state;
> -	u32 threshold_us;
> +	u32 min_threshold_us;
> +	u32 max_threshold_us;
>  	u32 window_us;
>  
>  	if (static_branch_likely(&psi_disabled))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
> +	if (sscanf(buf, "some %u %u %u", &min_threshold_us,
> +				&max_threshold_us, &window_us) == 3)
>  		state = PSI_IO_SOME + res * 2;
> -	else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
> +	else if (sscanf(buf, "full %u %u %u", &min_threshold_us,
> +				&max_threshold_us, &window_us) == 3)
>  		state = PSI_IO_FULL + res * 2;
>  	else
>  		return ERR_PTR(-EINVAL);
> @@ -1107,8 +1110,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  		window_us > WINDOW_MAX_US)
>  		return ERR_PTR(-EINVAL);
>  
> +	if (min_threshold_us >= max_threshold_us)
> +		return ERR_PTR(-EINVAL);
> +
>  	/* Check threshold */
> -	if (threshold_us == 0 || threshold_us > window_us)
> +	if (max_threshold_us > window_us)
>  		return ERR_PTR(-EINVAL);
>  
>  	t = kmalloc(sizeof(*t), GFP_KERNEL);
> @@ -1117,7 +1123,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
>  
>  	t->group = group;
>  	t->state = state;
> -	t->threshold = threshold_us * NSEC_PER_USEC;
> +	t->min_threshold = min_threshold_us * NSEC_PER_USEC;
> +	t->max_threshold = max_threshold_us * NSEC_PER_USEC;
>  	t->win.size = window_us * NSEC_PER_USEC;
>  	window_reset(&t->win, 0, 0, 0);
>  
