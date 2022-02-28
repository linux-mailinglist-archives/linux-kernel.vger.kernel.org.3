Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD884C7101
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiB1Pxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiB1Pxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:53:31 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91163DF94
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:52:51 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id w7so15165411ioj.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9DgP6TI3SFCIIOrHJXN8Egjc5iVP90Y7lmiiWFecc0g=;
        b=ly/fLusKxhw2jnw8hLVf6/rIfvqMAbEtYCnNF7yTJ4IKqKSwoTJujvGbbfV/uPYduK
         xbIZJEy7QP3aDgV1bOo3CdT5ORVdKKUyDksJyXknehJEKDctFYSw36wTt6plLLzK/X+D
         d9o1L5tQX+8HpNzI9wjCdC4zUva9yHtD1cFjE+os8SVbgJB5EI89hZtlub3qL+AcQRes
         3/kubTOsXzox522BLQpud0sSWsY8RCxY599IjGzZyPgh8lDanukcduKH9TC3eSIEw3RG
         CoM3ViKRj4nPU+GyX9duTDaeZQyCzqsJs4NnNURIhRTFnDJPLt4qu5ZrpglDCIY+LKMJ
         tdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9DgP6TI3SFCIIOrHJXN8Egjc5iVP90Y7lmiiWFecc0g=;
        b=qRRzltNstFJRyRSAOn0LMG0uIulQLh1CE1jWk1S5upcARGXx11bI1f2/kx2ENkqacs
         JiHEK/0aXRujFzDSXRyalU39fAnStrF93A3A1XiQAfESoqv0C5v/lFsjGjqkNeJOyeBP
         MB1Yp0Sm1fqY6DDfDDoYyRTLiqlJYT3XzJqpN3DXljMr46vpTG8FSDvhD1QTJ2e+RFqA
         5uuHVYc/pcz+Qz/7jDbfYa3qUbUP7grGdXDhzJgdqU8WA8/RwmmticmYp5CG2YkGiUmV
         6JIfVtbnO8NOy/0f5GIJEvhmxicD+r/oeNuZcnuHDw2GklP4cBETCgH4X2c2E84R5gmV
         KEzA==
X-Gm-Message-State: AOAM530uRdxyRQX0vjPU2JolcllpROlMVNfo3hXzE/2ugR4Ixyg0W7vo
        ozfBJWLCXb9qB3RqJmMTxMrRdw==
X-Google-Smtp-Source: ABdhPJzb8Xax1Bkzh7HPqy6djxjqWe8odWAEo5OvXO1fj2SDwX+1QHNzOUMhHFGuOSVIrtEvL1nuFw==
X-Received: by 2002:a05:6638:3b3:b0:314:bcc7:d975 with SMTP id z19-20020a05663803b300b00314bcc7d975mr16790706jap.202.1646063570979;
        Mon, 28 Feb 2022 07:52:50 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y20-20020a5d94d4000000b00640843474e2sm5948216ior.10.2022.02.28.07.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 07:52:50 -0800 (PST)
Message-ID: <797c1e16-6393-8cdb-81c8-da25dc9be1fa@linaro.org>
Date:   Mon, 28 Feb 2022 09:52:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 07/27] bus: mhi: host: Rename "struct mhi_tre" to
 "struct mhi_ring_element"
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <20220228124344.77359-8-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220228124344.77359-8-manivannan.sadhasivam@linaro.org>
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

On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> Structure "struct mhi_tre" is representing a generic MHI ring element and
> not specifically a Transfer Ring Element (TRE). Fix the naming.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/mhi/host/init.c     |  6 +++---
>   drivers/bus/mhi/host/internal.h |  2 +-
>   drivers/bus/mhi/host/main.c     | 20 ++++++++++----------
>   3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index ca068a017a42..016dcc35db80 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -339,7 +339,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>   		er_ctxt->msivec = cpu_to_le32(mhi_event->irq);
>   		mhi_event->db_cfg.db_mode = true;
>   
> -		ring->el_size = sizeof(struct mhi_tre);
> +		ring->el_size = sizeof(struct mhi_ring_element);
>   		ring->len = ring->el_size * ring->elements;
>   		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
>   		if (ret)
> @@ -371,7 +371,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
>   	for (i = 0; i < NR_OF_CMD_RINGS; i++, mhi_cmd++, cmd_ctxt++) {
>   		struct mhi_ring *ring = &mhi_cmd->ring;
>   
> -		ring->el_size = sizeof(struct mhi_tre);
> +		ring->el_size = sizeof(struct mhi_ring_element);
>   		ring->elements = CMD_EL_PER_RING;
>   		ring->len = ring->el_size * ring->elements;
>   		ret = mhi_alloc_aligned_ring(mhi_cntrl, ring, ring->len);
> @@ -598,7 +598,7 @@ int mhi_init_chan_ctxt(struct mhi_controller *mhi_cntrl,
>   
>   	buf_ring = &mhi_chan->buf_ring;
>   	tre_ring = &mhi_chan->tre_ring;
> -	tre_ring->el_size = sizeof(struct mhi_tre);
> +	tre_ring->el_size = sizeof(struct mhi_ring_element);
>   	tre_ring->len = tre_ring->el_size * tre_ring->elements;
>   	chan_ctxt = &mhi_cntrl->mhi_ctxt->chan_ctxt[mhi_chan->chan];
>   	ret = mhi_alloc_aligned_ring(mhi_cntrl, tre_ring, tre_ring->len);
> diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
> index 1c7a48be033f..5860cd326db6 100644
> --- a/drivers/bus/mhi/host/internal.h
> +++ b/drivers/bus/mhi/host/internal.h
> @@ -168,7 +168,7 @@ struct mhi_ctxt {
>   	dma_addr_t cmd_ctxt_addr;
>   };
>   
> -struct mhi_tre {
> +struct mhi_ring_element {
>   	__le64 ptr;
>   	__le32 dword[2];
>   };
> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
> index 3e6e615466b7..dabf85b92a84 100644
> --- a/drivers/bus/mhi/host/main.c
> +++ b/drivers/bus/mhi/host/main.c
> @@ -554,7 +554,7 @@ static void mhi_recycle_ev_ring_element(struct mhi_controller *mhi_cntrl,
>   }
>   
>   static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
> -			    struct mhi_tre *event,
> +			    struct mhi_ring_element *event,
>   			    struct mhi_chan *mhi_chan)
>   {
>   	struct mhi_ring *buf_ring, *tre_ring;
> @@ -590,7 +590,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>   	case MHI_EV_CC_EOT:
>   	{
>   		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
> -		struct mhi_tre *local_rp, *ev_tre;
> +		struct mhi_ring_element *local_rp, *ev_tre;
>   		void *dev_rp;
>   		struct mhi_buf_info *buf_info;
>   		u16 xfer_len;
> @@ -689,7 +689,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>   }
>   
>   static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
> -			   struct mhi_tre *event,
> +			   struct mhi_ring_element *event,
>   			   struct mhi_chan *mhi_chan)
>   {
>   	struct mhi_ring *buf_ring, *tre_ring;
> @@ -753,12 +753,12 @@ static int parse_rsc_event(struct mhi_controller *mhi_cntrl,
>   }
>   
>   static void mhi_process_cmd_completion(struct mhi_controller *mhi_cntrl,
> -				       struct mhi_tre *tre)
> +				       struct mhi_ring_element *tre)
>   {
>   	dma_addr_t ptr = MHI_TRE_GET_EV_PTR(tre);
>   	struct mhi_cmd *cmd_ring = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
>   	struct mhi_ring *mhi_ring = &cmd_ring->ring;
> -	struct mhi_tre *cmd_pkt;
> +	struct mhi_ring_element *cmd_pkt;
>   	struct mhi_chan *mhi_chan;
>   	u32 chan;
>   
> @@ -791,7 +791,7 @@ int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
>   			     struct mhi_event *mhi_event,
>   			     u32 event_quota)
>   {
> -	struct mhi_tre *dev_rp, *local_rp;
> +	struct mhi_ring_element *dev_rp, *local_rp;
>   	struct mhi_ring *ev_ring = &mhi_event->ring;
>   	struct mhi_event_ctxt *er_ctxt =
>   		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> @@ -961,7 +961,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   				struct mhi_event *mhi_event,
>   				u32 event_quota)
>   {
> -	struct mhi_tre *dev_rp, *local_rp;
> +	struct mhi_ring_element *dev_rp, *local_rp;
>   	struct mhi_ring *ev_ring = &mhi_event->ring;
>   	struct mhi_event_ctxt *er_ctxt =
>   		&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
> @@ -1185,7 +1185,7 @@ int mhi_gen_tre(struct mhi_controller *mhi_cntrl, struct mhi_chan *mhi_chan,
>   			struct mhi_buf_info *info, enum mhi_flags flags)
>   {
>   	struct mhi_ring *buf_ring, *tre_ring;
> -	struct mhi_tre *mhi_tre;
> +	struct mhi_ring_element *mhi_tre;
>   	struct mhi_buf_info *buf_info;
>   	int eot, eob, chain, bei;
>   	int ret;
> @@ -1256,7 +1256,7 @@ int mhi_send_cmd(struct mhi_controller *mhi_cntrl,
>   		 struct mhi_chan *mhi_chan,
>   		 enum mhi_cmd_type cmd)
>   {
> -	struct mhi_tre *cmd_tre = NULL;
> +	struct mhi_ring_element *cmd_tre = NULL;
>   	struct mhi_cmd *mhi_cmd = &mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING];
>   	struct mhi_ring *ring = &mhi_cmd->ring;
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1518,7 +1518,7 @@ static void mhi_mark_stale_events(struct mhi_controller *mhi_cntrl,
>   				  int chan)
>   
>   {
> -	struct mhi_tre *dev_rp, *local_rp;
> +	struct mhi_ring_element *dev_rp, *local_rp;
>   	struct mhi_ring *ev_ring;
>   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>   	unsigned long flags;

