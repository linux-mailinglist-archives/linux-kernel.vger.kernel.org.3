Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1B451B72D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiEEEet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242747AbiEEEei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:34:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED647395
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:30:58 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so3829294edw.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J4r++s4XK6X2VmgmsR/kDK3UrTmMmAhqRv3mwjxwC5U=;
        b=SgyzOj2WTFPsCeEIFqhDTkCjohkRSa5X4hxwMON4/02awTx6lvP6JfbUS8kjOh0lVI
         l5nl5RosgwmyaBXBAx5V+4x2My85F6zCFOcjVtYOqPnlyL9P95zCeitVVBVN0O5ivE9f
         6aJSLFQVMDj50ARacPwqI/GvGHtEIyZZMkknwKiQOyj4D5xqOkA/FV8KAvKsMRyHM3cW
         ersdwzh5mSS6VljkqHkQYFmgaGYn0dg3f081U5qiPYYDT8mviCyQWTKKT1PKeQNtWZtM
         x05AG73kslyI3WsStlgX4Gg+jS0DrQkOsFOpuJl90k78JDX3fK3LDIGxHBZzLWLcXSmN
         XP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J4r++s4XK6X2VmgmsR/kDK3UrTmMmAhqRv3mwjxwC5U=;
        b=5OMvOpzOO+2zMSjHuSa3Mdj4ZaMgwx3BmGKrtcQOz5TQWZaQzZ1QYvS+wuybq8Kkp7
         wjxdp7HcWFVxjzONfefo/dcdUNMIOnYhVQXkXHRvD3X6SrpUGgcO81CnL8noGD/goYHr
         7Ov0XB+vsI5AcVdFQ0uvIanP3Wx7IqMA47xxNoPX6PF60MdB6NLYBWGfAJn5pHd4QWRA
         e24jtWfEOB0lcfYNYgG+GkeiATnihtEHrzgV54eoXqMoD8d58JHIGAuw91Ha+5zaLGsB
         EzuE+bWIBDCbwbaDZTxCiZMAkiCTZSU9qGteZ1DGLDcvNIXdJMeVB2Ev5jLE/HU/FVQF
         VJGw==
X-Gm-Message-State: AOAM532xlTaxO9c2KNRHYgG+cxgX8D7xNw5qQ+Oh1HBBzNLlbHalN7pt
        fvrkLZz67EOFKFfrK+ihMbVITA==
X-Google-Smtp-Source: ABdhPJwO2J1aYMyFqWXwg4ZNOb9kPrVha9YCg2Qv7n7mprAl0RbPYoc9maLsgGz60S/qQ1TV3jO9Yg==
X-Received: by 2002:a05:6402:2692:b0:427:ddba:d811 with SMTP id w18-20020a056402269200b00427ddbad811mr14423701edd.343.1651725057018;
        Wed, 04 May 2022 21:30:57 -0700 (PDT)
Received: from ?IPV6:2003:d9:9709:6f00:a185:5aff:42c6:1e24? (p200300d997096f00a1855aff42c61e24.dip0.t-ipconnect.de. [2003:d9:9709:6f00:a185:5aff:42c6:1e24])
        by smtp.googlemail.com with ESMTPSA id e6-20020a170906374600b006f3ef214dfesm285074ejc.100.2022.05.04.21.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 21:30:55 -0700 (PDT)
Message-ID: <5b422b20-c168-9d25-b79b-cf0c0c00e646@colorfullife.com>
Date:   Thu, 5 May 2022 06:30:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4] ipc: Update semtimedop() to use hrtimer
Content-Language: en-US
To:     Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, akpm@linux-foundation.org,
        peterz@infradead.org, dave@stgolabs.net
References: <1651187881-2858-1-git-send-email-prakash.sangappa@oracle.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <1651187881-2858-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 01:18, Prakash Sangappa wrote:
> semtimedop() should be converted to use hrtimer like it has been done
> for most of the system calls with timeouts. This system call already
> takes a struct timespec as an argument and can therefore provide finer
> granularity timed wait.
>
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> v1->v2:
>    - Use timespec64_valid() to validate timeout
>       and other changes as suggested by Thomas Gleixner
> v2->v3: Added Reviewed by tag (Thomas)
> v3->v4: Added Reviewed by (Davidlohr)
>
>   ipc/sem.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
Reviewed-by: Manfred Spraul <manfred@colorfullife.com>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98..44b65b6 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1995,7 +1995,9 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>   	int max, locknum;
>   	bool undos = false, alter = false, dupsop = false;
>   	struct sem_queue queue;
> -	unsigned long dup = 0, jiffies_left = 0;
> +	unsigned long dup = 0;
> +	ktime_t expires, *exp = NULL;
> +	bool timed_out = false;
>   
>   	if (nsops < 1 || semid < 0)
>   		return -EINVAL;
> @@ -2003,12 +2005,11 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>   		return -E2BIG;
>   
>   	if (timeout) {
> -		if (timeout->tv_sec < 0 || timeout->tv_nsec < 0 ||
> -			timeout->tv_nsec >= 1000000000L) {
> -			error = -EINVAL;
> -			goto out;
> -		}
> -		jiffies_left = timespec64_to_jiffies(timeout);
> +		if (!timespec64_valid(timeout))
> +			return -EINVAL;
> +		expires = ktime_add_safe(ktime_get(),
> +				timespec64_to_ktime(*timeout));
> +		exp = &expires;
>   	}
>   
>   
> @@ -2166,10 +2167,8 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>   		sem_unlock(sma, locknum);
>   		rcu_read_unlock();
>   
> -		if (timeout)
> -			jiffies_left = schedule_timeout(jiffies_left);
> -		else
> -			schedule();
> +		timed_out = !schedule_hrtimeout_range(exp,
> +				current->timer_slack_ns, HRTIMER_MODE_ABS);
>   
>   		/*
>   		 * fastpath: the semop has completed, either successfully or
> @@ -2210,7 +2209,7 @@ long __do_semtimedop(int semid, struct sembuf *sops,
>   		/*
>   		 * If an interrupt occurred we have to clean up the queue.
>   		 */
> -		if (timeout && jiffies_left == 0)
> +		if (timed_out)
>   			error = -EAGAIN;
>   	} while (error == -EINTR && !signal_pending(current)); /* spurious */
>   


