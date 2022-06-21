Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B57552A69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344915AbiFUFOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 01:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiFUFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 01:14:02 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C99015808;
        Mon, 20 Jun 2022 22:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655788440; x=1687324440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zD3t7P3beJnqprKw6pK4SaA1mOaXHFNana/obLJCFKc=;
  b=uLtzbaLCcmxgKNUJ6vUmdk0MhnsXSmrH4BVg+5zp9LL/z0Q21TtmZ4hH
   DhHzZcJ+HCVuasQqbbzPubc69rTXMlglOTf0ZUiOjBt92t3fWv9BAcgQ2
   yxntmRN4foc64h8rNXajiXu+ED2hIuRx1fdrSe7VXjyxZ+RjD8CKoVXPx
   s=;
Received: from ironmsg02-sd.qualcomm.com ([10.53.140.142])
  by alexa-out.qualcomm.com with ESMTP; 20 Jun 2022 22:14:00 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 22:11:59 -0700
Received: from [10.50.44.13] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 20 Jun
 2022 22:11:57 -0700
Message-ID: <3988b203-0a65-526e-b445-c2ee9ea0f4e8@quicinc.com>
Date:   Tue, 21 Jun 2022 10:41:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH rcu 3/3] doc: Document rcutree.nocb_nobypass_lim_per_jiffy
 kernel parameter
Content-Language: en-US
To:     "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <rostedt@goodmis.org>, Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20220620221733.GA3839136@paulmck-ThinkPad-P17-Gen-1>
 <20220620221757.3839212-3-paulmck@kernel.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <20220620221757.3839212-3-paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 3:47 AM, Paul E. McKenney wrote:
> This commit provides documentation for the kernel parameter controlling
> RCU's handling of callback floods on offloaded (rcu_nocbs) CPUs.
> This parameter might be obscure, but it is always there when you need it.
> 
> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> Reported-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---

Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>

>   Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdf431bdbfdc4..a30890141b1a5 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4681,6 +4681,19 @@
>   			invoked in the context of an rcuoc kthread, which
>   			scheduler will preempt as it does any other task.
>   
> +	rcutree.nocb_nobypass_lim_per_jiffy= [KNL]
> +			On callback-offloaded (rcu_nocbs) CPUs,
> +			RCU reduces the lock contention that would
> +			otherwise be caused callback floods through

Minor : "caused by" ?


Thanks
Neeraj

> +			use of the ->nocb_bypass list.	However, in the
> +			common non-flooded case, RCU queues directly to
> +			the main ->cblist in order to avoid the extra
> +			overhead of the ->nocb_bypass list and its lock.
> +			But if there are too many callbacks queued during
> +			a single jiffy, RCU pre-queues the callbacks into
> +			the ->nocb_bypass queue.  The definition of "too
> +			many" is supplied by this kernel boot parameter.
> +
>   	rcutree.rcu_nocb_gp_stride= [KNL]
>   			Set the number of NOCB callback kthreads in
>   			each group, which defaults to the square root
