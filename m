Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC74B7A90
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiBOWjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:39:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241229AbiBOWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:39:45 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03863C1166
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:33 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r8so219583ioc.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j1nzk/danIMGsNQWKcwdkdLLJvgXwcdFos2H4vIztX4=;
        b=lyCQrdROdvX5dP1D3M5SgL3KrVGDz66TFF4jFfaWSMent66ZwDTo9U/JX+kGmFMkzn
         tOEd85Kl9X67KWixK3C67HnFlFoTrxZJdVZJ09hp7od8Q9/nQ2i0Hq3o2dNJrC/Lbati
         7gatWREZrO9591tUvaordnRFThYFgmKDfwwqB4S0ka42zW2EQXNUKqkkCrIY9yrfot7v
         JhWynd6m4oGvtZQrpY499NUqzF3Kpw5upY78qUYqAXUi6EwnZpWE8hNpNR7JfoY08/hX
         ZDvcJ6Cbv5EhgYq6Q2kIRkxwny0jKoSDEOM7Vs7WkOo1uCqdXgePJd6tAtXpgLPhbKV9
         iSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j1nzk/danIMGsNQWKcwdkdLLJvgXwcdFos2H4vIztX4=;
        b=TcSTI2UY8xn4cB3AUPqVy6CuKLLxw9bNmWsJXU8Ywzj+lDGEBVXQ6HKFBAvcyMK4SG
         9NBGu/KoG9T/6VNxxhL2mJZTZDrSpTcfpqJudpmJpAZXoZSbvCzH4WljY0Ive55Lc/QO
         QQaV/I2+tRUvvFAg4T5k1LT3RRgTCWBqcQja3lhTR4zGa6OvGoXaa1/XpxKEhKGabx4Y
         2L81BBQqum/6OJmgiFzzERvyo5qCcLFMIX01QmClH7IRGI31KvDsLXJrQLSp27srNBrM
         DISJET8yI37LemoGFTo/e300tdtM0XDIJ5boRIaRhDxOF5Avio60oD5XtDuX/6/eI66T
         72Kg==
X-Gm-Message-State: AOAM530JTQ2eD44xKJ+NyCiF42rEqi4t2Uk9n022627xJInAuuywecId
        bqvq/djLPFnAkQG20hqAY+l1NA==
X-Google-Smtp-Source: ABdhPJx4D7ERuJQQrbEjrtb0Ogp/sr8AJO6f8+5wFcRgiHAyI4F6NmejLlxKF1ACvG/U+ebgGdPWCw==
X-Received: by 2002:a02:9f84:: with SMTP id a4mr671450jam.137.1644964772323;
        Tue, 15 Feb 2022 14:39:32 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e20sm17829801ioc.35.2022.02.15.14.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 14:39:31 -0800 (PST)
Message-ID: <d5bf8b66-e9ec-4750-9d9d-deb55cbcee94@linaro.org>
Date:   Tue, 15 Feb 2022 16:39:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 15/25] bus: mhi: ep: Add support for processing MHI
 endpoint interrupts
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-16-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-16-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:21 PM, Manivannan Sadhasivam wrote:
> Add support for processing MHI endpoint interrupts such as control
> interrupt, command interrupt and channel interrupt from the host.
> 
> The interrupts will be generated in the endpoint device whenever host
> writes to the corresponding doorbell registers. The doorbell logic
> is handled inside the hardware internally.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Unless I'm mistaken, you have some bugs here.

Beyond that, I question whether you should be using workqueues
for handling all interrupts.  For now, it's fine, but there
might be room for improvement after this is accepted upstream
(using threaded interrupt handlers, for example).

					-Alex

> ---
>   drivers/bus/mhi/ep/main.c | 113 +++++++++++++++++++++++++++++++++++++-
>   include/linux/mhi_ep.h    |   2 +
>   2 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index ccb3c2795041..072b872e735b 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -185,6 +185,56 @@ static void mhi_ep_ring_worker(struct work_struct *work)
>   	}
>   }
>   
> +static void mhi_ep_queue_channel_db(struct mhi_ep_cntrl *mhi_cntrl,
> +				    unsigned long ch_int, u32 ch_idx)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_item *item;
> +	struct mhi_ep_ring *ring;
> +	unsigned int i;

Why not u32 i?  And why is the ch_int argument unsigned long?  The value
passed in is a u32.

> +
> +	for_each_set_bit(i, &ch_int, 32) {
> +		/* Channel index varies for each register: 0, 32, 64, 96 */
> +		i += ch_idx;

This is a bug.  You should not be modifying the iterator
variable inside the loop.  Maybe do this instead:

	u32 ch_id = ch_idx + i;

	ring = &mhi_cntrl->mhi_chan[ch_id].ring

> +		ring = &mhi_cntrl->mhi_chan[i].ring;
> +

You are initializing all fields here so kmalloc() is fine
(rather than kzalloc()).  But if you ever add another field
to the mhi_ep_ring_item structure that's not guaranteed.
I think at least a comment here explaining why you're not
using kzalloc() would be helpful.

> +		item = kmalloc(sizeof(*item), GFP_ATOMIC);

Even an ATOMIC allocation can fail.  Check the return
pointer.

> +		item->ring = ring;
> +
> +		dev_dbg(dev, "Queuing doorbell interrupt for channel (%d)\n", i);

Use ch_id (or whatever you call it) here too.

> +		spin_lock(&mhi_cntrl->list_lock);
> +		list_add_tail(&item->node, &mhi_cntrl->ch_db_list);
> +		spin_unlock(&mhi_cntrl->list_lock);

Instead, create a list head on the stack and build up
this list without using the spinlock.  Then splice
everything you added into the ch_db_list at the end.

> +
> +		queue_work(mhi_cntrl->ring_wq, &mhi_cntrl->ring_work);

Maybe there's a small amount of latency saved by
doing this repeatedly, but you're queueing work
with the same work structure over and over again.

Instead, you could set a Boolean at the top:
	work = !!ch_int;

	for_each_set_bit() {
		. . .
	}

	if (work)
		queue_work(...);


> +	}
> +}
> +
> +/*
> + * Channel interrupt statuses are contained in 4 registers each of 32bit length.
> + * For checking all interrupts, we need to loop through each registers and then
> + * check for bits set.
> + */
> +static void mhi_ep_check_channel_interrupt(struct mhi_ep_cntrl *mhi_cntrl)
> +{
> +	u32 ch_int, ch_idx;
> +	int i;
> +
> +	mhi_ep_mmio_read_chdb_status_interrupts(mhi_cntrl);

You could have the above function could return a summary Boolean
value, which would indicate whether *any* channel interrupts
had occurred (skipping the below loop when we get just a control
or command doorbell interrupt).

> +
> +	for (i = 0; i < MHI_MASK_ROWS_CH_EV_DB; i++) {
> +		ch_idx = i * MHI_MASK_CH_EV_LEN;
> +
> +		/* Only process channel interrupt if the mask is enabled */
> +		ch_int = (mhi_cntrl->chdb[i].status & mhi_cntrl->chdb[i].mask);

Parentheses not needed.

> +		if (ch_int) {
> +			mhi_ep_queue_channel_db(mhi_cntrl, ch_int, ch_idx);
> +			mhi_ep_mmio_write(mhi_cntrl, MHI_CHDB_INT_CLEAR_A7_n(i),
> +							mhi_cntrl->chdb[i].status);
> +		}
> +	}
> +}
> +
>   static void mhi_ep_state_worker(struct work_struct *work)
>   {
>   	struct mhi_ep_cntrl *mhi_cntrl = container_of(work, struct mhi_ep_cntrl, state_work);
> @@ -222,6 +272,53 @@ static void mhi_ep_state_worker(struct work_struct *work)
>   	}
>   }
>   
> +static void mhi_ep_process_ctrl_interrupt(struct mhi_ep_cntrl *mhi_cntrl,
> +					 enum mhi_state state)
> +{
> +	struct mhi_ep_state_transition *item = kmalloc(sizeof(*item), GFP_ATOMIC);
> +

Do not assume ATOMIC allocations succeed.

I don't have any further comments on the rest.

> +	item->state = state;
> +	spin_lock(&mhi_cntrl->list_lock);
> +	list_add_tail(&item->node, &mhi_cntrl->st_transition_list);
> +	spin_unlock(&mhi_cntrl->list_lock);
> +
> +	queue_work(mhi_cntrl->state_wq, &mhi_cntrl->state_work);
> +}
> +

. . .
