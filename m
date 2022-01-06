Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCCF485D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343827AbiAFAaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343788AbiAFAaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:30:20 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14FFC0611FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 16:30:19 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v22so731779qtx.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 16:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=XzlMRK1FhwMuePIvLEhvqHTLG+Z497r7/k29BszxCjs=;
        b=U8WG9lf6XKQM/k9AFEZ4ZJDoyVZu0YdXE9uARoYTxNc3Ud9604S6eQrcmhAZgyHPsk
         9evhwRrOmIBuixz8pMzb0zx6wFaIHjPS+hCy5bBqulK8xL6Vcxiyh0RKr7o49YVxmCsJ
         aI+BIVji0ilfINWkPRqMW02Wq12sHVSxw8zVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=XzlMRK1FhwMuePIvLEhvqHTLG+Z497r7/k29BszxCjs=;
        b=Oczy8Yc4BU7/MYv5LjXPZ7Y73O5YrJ7myozyoKj10xLR4bOwWFOKZ4iS9uPXVlQIYP
         rurEdW4ngC0xWmQHxXseyInqcmNCXTBMafn5/iYoa6d+MlQhsQY4WtMp0igu+VG05OnE
         JrZCoo5cuPnD/euNtb/N0QESte4+NqYrpCSxGMAxRVNuVlggtTZ+/JIK+3z0oNYJ4X4H
         8cZiDsfGWtlYTpxiO0S9zmwM6VMCwN5gR08nli/7NJR05b0DCdBuCXFFRkbdNLo5DJGY
         DgneSh9JL9/Vnc4qO7xXHVMQaAfY4u2/qNH3+eD7h9RTw+1W1ev5ZP0kDzr8DOEPyRlX
         7xRw==
X-Gm-Message-State: AOAM533k7WPu0xIWtOqXoLyzpkq2bIK11RhsZw5foKVfHBixfW0PGJ1d
        JJ/+SIM9juUJ9x8POotuGkvxGw==
X-Google-Smtp-Source: ABdhPJyxIca9AUkdt425rPWk77DPoVto6swQCVcx4vpspyIQuv3ojarkPC7soabj1xSmplMe/annhg==
X-Received: by 2002:a05:622a:1716:: with SMTP id h22mr35401467qtk.322.1641429019104;
        Wed, 05 Jan 2022 16:30:19 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id o5sm338225qkp.132.2022.01.05.16.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 16:30:18 -0800 (PST)
Message-ID: <454a3828-aa1f-7160-9ff2-e4c5967490f4@ieee.org>
Date:   Wed, 5 Jan 2022 18:30:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
From:   Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 09/20] bus: mhi: ep: Add support for ring management
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
 <20211202113553.238011-10-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
In-Reply-To: <20211202113553.238011-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/21 5:35 AM, Manivannan Sadhasivam wrote:
> Add support for managing the MHI ring. The MHI ring is a circular queue
> of data structures used to pass the information between host and the
> endpoint.
> 
> MHI support 3 types of rings:
> 
> 1. Transfer ring
> 2. Event ring
> 3. Command ring
> 
> All rings reside inside the host memory and the MHI EP device maps it to
> the device memory using blocks like PCIe iATU. The mapping is handled in
> the MHI EP controller driver itself.

A few more comments here.  And with that, I'm done for today.

					-Alex

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/ep/Makefile   |   2 +-
>   drivers/bus/mhi/ep/internal.h |  23 +++
>   drivers/bus/mhi/ep/main.c     |  53 +++++-
>   drivers/bus/mhi/ep/ring.c     | 314 ++++++++++++++++++++++++++++++++++
>   include/linux/mhi_ep.h        |  11 ++
>   5 files changed, 401 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/bus/mhi/ep/ring.c
> 
> diff --git a/drivers/bus/mhi/ep/Makefile b/drivers/bus/mhi/ep/Makefile
> index a1555ae287ad..7ba0e04801eb 100644
> --- a/drivers/bus/mhi/ep/Makefile
> +++ b/drivers/bus/mhi/ep/Makefile
> @@ -1,2 +1,2 @@
>   obj-$(CONFIG_MHI_BUS_EP) += mhi_ep.o
> -mhi_ep-y := main.o mmio.o
> +mhi_ep-y := main.o mmio.o ring.o
> diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
> index 39eeb5f384e2..a7a4e6934f7d 100644
> --- a/drivers/bus/mhi/ep/internal.h
> +++ b/drivers/bus/mhi/ep/internal.h
> @@ -97,6 +97,18 @@ enum mhi_ep_execenv {
>   	MHI_EP_UNRESERVED
>   };
>   
> +/* Transfer Ring Element macros */
> +#define MHI_EP_TRE_PTR(ptr) (ptr)
> +#define MHI_EP_TRE_DWORD0(len) (len & MHI_MAX_MTU)
> +#define MHI_EP_TRE_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
> +	| (ieot << 9) | (ieob << 8) | chain)
> +#define MHI_EP_TRE_GET_PTR(tre) ((tre)->ptr)
> +#define MHI_EP_TRE_GET_LEN(tre) ((tre)->dword[0] & 0xffff)
> +#define MHI_EP_TRE_GET_CHAIN(tre) FIELD_GET(BIT(0), (tre)->dword[1])
> +#define MHI_EP_TRE_GET_IEOB(tre) FIELD_GET(BIT(8), (tre)->dword[1])
> +#define MHI_EP_TRE_GET_IEOT(tre) FIELD_GET(BIT(9), (tre)->dword[1])
> +#define MHI_EP_TRE_GET_BEI(tre) FIELD_GET(BIT(10), (tre)->dword[1])
> +
>   enum mhi_ep_ring_state {
>   	RING_STATE_UINT = 0,
>   	RING_STATE_IDLE,
> @@ -161,6 +173,17 @@ struct mhi_ep_chan {
>   	bool skip_td;
>   };
>   
> +/* MHI Ring related functions */
> +void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id);
> +void mhi_ep_ring_stop(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring);
> +size_t mhi_ep_ring_addr2offset(struct mhi_ep_ring *ring, u64 ptr);
> +int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> +		      union mhi_ep_ring_ctx *ctx);
> +int mhi_ep_process_ring(struct mhi_ep_ring *ring);
> +int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *element,
> +			    int evt_offset);
> +void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring);
> +
>   /* MMIO related functions */
>   void mhi_ep_mmio_read(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 *regval);
>   void mhi_ep_mmio_write(struct mhi_ep_cntrl *mhi_cntrl, u32 offset, u32 val);
> diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
> index fddf75dfb9c7..6d448d42f527 100644
> --- a/drivers/bus/mhi/ep/main.c
> +++ b/drivers/bus/mhi/ep/main.c
> @@ -18,6 +18,42 @@
>   
>   static DEFINE_IDA(mhi_ep_cntrl_ida);
>   
> +static void mhi_ep_ring_worker(struct work_struct *work)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = container_of(work,
> +				struct mhi_ep_cntrl, ring_work);
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring *ring;
> +	struct list_head *cp, *q;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	/* Process the command ring first */
> +	ret = mhi_ep_process_ring(&mhi_cntrl->mhi_cmd->ring);
> +	if (ret) {
> +		dev_err(dev, "Error processing command ring\n");
> +		goto err_unlock;
> +	}
> +
> +	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);
> +	/* Process the channel rings now */

Use list_for_each_entry_safe() here.

But actually, rather than doing this, you can do the
trick of grabbing the whole list under lock, then
handling processing the entries outside of it.  You'll
have to judge whether that can be done, but basically:

	struct mhi_ep_ring *ring, *tmp;
	LIST_HEAD(list);

	spin_lock_irqsave(&mhi_cntrl->list_lock, flags);

	list_splice_init(&mhi_cntrl->ch_db_list, &list);

	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);

	list_for_each_entry_safe(ring, tmp, &list, list) {
		list_del(&ring->list);
		ret = mhi_ep_process_ring(ring);
		...
	}

> +	list_for_each_safe(cp, q, &mhi_cntrl->ch_db_list) {
> +		ring = list_entry(cp, struct mhi_ep_ring, list);
> +		list_del(cp);
> +		ret = mhi_ep_process_ring(ring);
> +		if (ret) {
> +			dev_err(dev, "Error processing channel ring: %d\n", ring->ch_id);
> +			goto err_unlock;
> +		}
> +
> +		/* Re-enable channel interrupt */
> +		mhi_ep_mmio_enable_chdb_a7(mhi_cntrl, ring->ch_id);
> +	}
> +
> +err_unlock:
> +	spin_unlock_irqrestore(&mhi_cntrl->list_lock, flags);
> +}
> +
>   static void mhi_ep_release_device(struct device *dev)
>   {
>   	struct mhi_ep_device *mhi_dev = to_mhi_ep_device(dev);

. . .

> +void mhi_ep_ring_inc_index(struct mhi_ep_ring *ring)
> +{
> +	ring->rd_offset++;
> +	if (ring->rd_offset == ring->ring_size)
> +		ring->rd_offset = 0;
> +}
> +
> +static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	size_t start, copy_size;
> +	struct mhi_ep_ring_element *ring_shadow;
> +	phys_addr_t ring_shadow_phys;
> +	size_t size = ring->ring_size * sizeof(struct mhi_ep_ring_element);

Do you cache the entire ring just in case you need to wrap
around the end of it?

> +	int ret;
> +
> +	/* No need to cache event rings */
> +	if (ring->type == RING_TYPE_ER)
> +		return 0;
> +
> +	/* No need to cache the ring if write pointer is unmodified */
> +	if (ring->wr_offset == end)
> +		return 0;
> +
> +	start = ring->wr_offset;
> +
> +	/* Allocate memory for host ring */
> +	ring_shadow = mhi_cntrl->alloc_addr(mhi_cntrl, &ring_shadow_phys,
> +					   size);
> +	if (!ring_shadow) {
> +		dev_err(dev, "Failed to allocate memory for ring_shadow\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Map host ring */
> +	ret = mhi_cntrl->map_addr(mhi_cntrl, ring_shadow_phys,
> +				  ring->ring_ctx->generic.rbase, size);
> +	if (ret) {
> +		dev_err(dev, "Failed to map ring_shadow\n\n");
> +		goto err_ring_free;
> +	}
> +
> +	dev_dbg(dev, "Caching ring: start %d end %d size %d", start, end, copy_size);
> +
> +	if (start < end) {
> +		copy_size = (end - start) * sizeof(struct mhi_ep_ring_element);
> +		memcpy_fromio(&ring->ring_cache[start], &ring_shadow[start], copy_size);
> +	} else {
> +		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ep_ring_element);
> +		memcpy_fromio(&ring->ring_cache[start], &ring_shadow[start], copy_size);
> +		if (end)
> +			memcpy_fromio(&ring->ring_cache[0], &ring_shadow[0],
> +					end * sizeof(struct mhi_ep_ring_element));
> +	}
> +
> +	/* Now unmap and free host ring */
> +	mhi_cntrl->unmap_addr(mhi_cntrl, ring_shadow_phys);
> +	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, size);
> +
> +	return 0;
> +
> +err_ring_free:
> +	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, &ring_shadow, size);
> +
> +	return ret;
> +}
> +

. . .

> +static int mhi_ep_process_ring_element(struct mhi_ep_ring *ring, size_t offset)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_element *el;
> +	int ret = -ENODEV;
> +
> +	/* Get the element and invoke the respective callback */
> +	el = &ring->ring_cache[offset];
> +

You already know that the ring_cb function pointer is non-null (you set
it in mhi_ep_ring_init(), below).  At least you *should* be able to
be sure of that...

> +	if (ring->ring_cb)
> +		ret = ring->ring_cb(ring, el);
> +	else
> +		dev_err(dev, "No callback registered for ring\n");
> +
> +	return ret;
> +}
> +
> +int mhi_ep_process_ring(struct mhi_ep_ring *ring)
> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret = 0;
> +
> +	/* Event rings should not be processed */
> +	if (ring->type == RING_TYPE_ER)
> +		return -EINVAL;
> +
> +	dev_dbg(dev, "Processing ring of type: %d\n", ring->type);
> +
> +	/* Update the write offset for the ring */
> +	ret = mhi_ep_update_wr_offset(ring);
> +	if (ret) {
> +		dev_err(dev, "Error updating write offset for ring\n");
> +		return ret;
> +	}
> +
> +	/* Sanity check to make sure there are elements in the ring */
> +	if (ring->rd_offset == ring->wr_offset)
> +		return 0;
> +
> +	/* Process channel ring first */
> +	if (ring->type == RING_TYPE_CH) {
> +		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
> +		if (ret)
> +			dev_err(dev, "Error processing ch ring element: %d\n", ring->rd_offset);
> +
> +		return ret;
> +	}
> +
> +	/* Process command ring now */
> +	while (ring->rd_offset != ring->wr_offset) {
> +		ret = mhi_ep_process_ring_element(ring, ring->rd_offset);
> +		if (ret) {
> +			dev_err(dev, "Error processing cmd ring element: %d\n", ring->rd_offset);
> +			return ret;
> +		}
> +
> +		mhi_ep_ring_inc_index(ring);
> +	}
> +
> +	return 0;
> +}
> +
> +/* TODO: Support for adding multiple ring elements to the ring */
> +int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ep_ring_element *el, int size)

I'm pretty sure the size argument is unused, so should be eliminated.

> +{
> +	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	struct mhi_ep_ring_element *ring_shadow;
> +	size_t ring_size = ring->ring_size * sizeof(struct mhi_ep_ring_element);

Use sizeof(*el) in the line above.

> +	phys_addr_t ring_shadow_phys;
> +	size_t old_offset = 0;
> +	u32 num_free_elem;
> +	int ret;
> +
> +	ret = mhi_ep_update_wr_offset(ring);
> +	if (ret) {
> +		dev_err(dev, "Error updating write pointer\n");
> +		return ret;
> +	}
> +
> +	if (ring->rd_offset < ring->wr_offset)
> +		num_free_elem = (ring->wr_offset - ring->rd_offset) - 1;
> +	else
> +		num_free_elem = ((ring->ring_size - ring->rd_offset) + ring->wr_offset) - 1;
> +
> +	/* Check if there is space in ring for adding at least an element */
> +	if (num_free_elem < 1) {

	if (!num_free_elem) {

> +		dev_err(dev, "No space left in the ring\n");
> +		return -ENOSPC;
> +	}
> +
> +	old_offset = ring->rd_offset;
> +	mhi_ep_ring_inc_index(ring);
> +
> +	dev_dbg(dev, "Adding an element to ring at offset (%d)\n", ring->rd_offset);
> +
> +	/* Update rp in ring context */
> +	ring->ring_ctx->generic.rp = (ring->rd_offset * sizeof(struct mhi_ep_ring_element)) +
> +				      ring->ring_ctx->generic.rbase;
> +
> +	/* Allocate memory for host ring */
> +	ring_shadow = mhi_cntrl->alloc_addr(mhi_cntrl, &ring_shadow_phys, ring_size);
> +	if (!ring_shadow) {
> +		dev_err(dev, "failed to allocate ring_shadow\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Map host ring */
> +	ret = mhi_cntrl->map_addr(mhi_cntrl, ring_shadow_phys,
> +				  ring->ring_ctx->generic.rbase, ring_size);
> +	if (ret) {
> +		dev_err(dev, "failed to map ring_shadow\n\n");
> +		goto err_ring_free;
> +	}
> +
> +	/* Copy the element to ring */

Use sizeof(*el) in the memcpy_toio() call.

> +	memcpy_toio(&ring_shadow[old_offset], el, sizeof(struct mhi_ep_ring_element));
> +
> +	/* Now unmap and free host ring */
> +	mhi_cntrl->unmap_addr(mhi_cntrl, ring_shadow_phys);
> +	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, ring_size);
> +
> +	return 0;
> +
> +err_ring_free:
> +	mhi_cntrl->free_addr(mhi_cntrl, ring_shadow_phys, ring_shadow, ring_size);
> +
> +	return ret;
> +}
> +
> +void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
> +{
> +	ring->state = RING_STATE_UINT;
> +	ring->type = type;
> +	if (ring->type == RING_TYPE_CMD) {
> +		ring->db_offset_h = CRDB_HIGHER;
> +		ring->db_offset_l = CRDB_LOWER;
> +	} else if (ring->type == RING_TYPE_CH) {
> +		ring->db_offset_h = CHDB_HIGHER_n(id);
> +		ring->db_offset_l = CHDB_LOWER_n(id);
> +		ring->ch_id = id;
> +	} else if (ring->type == RING_TYPE_ER) {
> +		ring->db_offset_h = ERDB_HIGHER_n(id);
> +		ring->db_offset_l = ERDB_LOWER_n(id);
> +	}

There is no other case, right?  If you hit it, you should report
it.  Otherwise there's not really any need to check for ring->type
RING_TYPE_ER...

					-Alex

> +}
> +
> +int mhi_ep_ring_start(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring,
> +			union mhi_ep_ring_ctx *ctx)
> +{
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	int ret;
> +
> +	ring->mhi_cntrl = mhi_cntrl;
> +	ring->ring_ctx = ctx;
> +	ring->ring_size = mhi_ep_ring_num_elems(ring);
> +
> +	/* During ring init, both rp and wp are equal */
> +	ring->rd_offset = mhi_ep_ring_addr2offset(ring, ring->ring_ctx->generic.rp);
> +	ring->wr_offset = mhi_ep_ring_addr2offset(ring, ring->ring_ctx->generic.rp);
> +	ring->state = RING_STATE_IDLE;
> +
> +	/* Allocate ring cache memory for holding the copy of host ring */
> +	ring->ring_cache = kcalloc(ring->ring_size, sizeof(struct mhi_ep_ring_element),
> +				   GFP_KERNEL);
> +	if (!ring->ring_cache)
> +		return -ENOMEM;
> +
> +	ret = mhi_ep_cache_ring(ring, ring->ring_ctx->generic.wp);
> +	if (ret) {
> +		dev_err(dev, "Failed to cache ring\n");
> +		kfree(ring->ring_cache);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void mhi_ep_ring_stop(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_ring *ring)
> +{
> +	ring->state = RING_STATE_UINT;
> +	kfree(ring->ring_cache);
> +}
> diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
> index 902c8febd856..729f4b802b74 100644
> --- a/include/linux/mhi_ep.h
> +++ b/include/linux/mhi_ep.h
> @@ -62,6 +62,11 @@ struct mhi_ep_db_info {
>    * @ch_ctx_host_pa: Physical address of host channel context data structure
>    * @ev_ctx_host_pa: Physical address of host event context data structure
>    * @cmd_ctx_host_pa: Physical address of host command context data structure
> + * @ring_wq: Dedicated workqueue for processing MHI rings
> + * @ring_work: Ring worker
> + * @ch_db_list: List of queued channel doorbells
> + * @st_transition_list: List of state transitions
> + * @list_lock: Lock for protecting state transition and channel doorbell lists
>    * @chdb: Array of channel doorbell interrupt info
>    * @raise_irq: CB function for raising IRQ to the host
>    * @alloc_addr: CB function for allocating memory in endpoint for storing host context
> @@ -90,6 +95,12 @@ struct mhi_ep_cntrl {
>   	u64 ev_ctx_host_pa;
>   	u64 cmd_ctx_host_pa;
>   
> +	struct workqueue_struct	*ring_wq;
> +	struct work_struct ring_work;
> +
> +	struct list_head ch_db_list;
> +	struct list_head st_transition_list;
> +	spinlock_t list_lock;
>   	struct mhi_ep_db_info chdb[4];
>   
>   	void (*raise_irq)(struct mhi_ep_cntrl *mhi_cntrl);
> 

