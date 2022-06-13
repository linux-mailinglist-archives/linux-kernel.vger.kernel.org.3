Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F1549AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243555AbiFMRz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243304AbiFMRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:54:33 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003201ADA5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:39:57 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u8so7156738wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=wQnoBtrfVqerdDXtoRJNXxFJ8ERaywkQKEUxnchF8QU=;
        b=Tllb95AleXMxXyeBwv7CpMAXehORNHpEs+cthLcVV5jw9/oFcVQli7Afj7fCxQzmNE
         +C9c4mGSCLY/MylFVNEK2H4DbI4VgFTYB8wPeVZXqnj/g8r9R/HoSWLIu8ZzS1HI2+yA
         SvcFbCVln4LbAwEhjVIqzyMUx7z20qITI55robQo5dmXd8lHxX+FSdkemEMs0PgCLlNa
         Rm2f4zaTbnPhuHxoCPzBl2R0QH6JBY1V2m0A8xOO3SI6xJPTelAYvi5Oh6V5pn8hsW34
         +gjwvopzJESwJDVyC/Va9IerEMajbi7DefzuSNh+GxLUBw4vf7QJsLC/qP1m/bxCnzxU
         Z0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wQnoBtrfVqerdDXtoRJNXxFJ8ERaywkQKEUxnchF8QU=;
        b=MTVI/pKEh7ARbdcKdSa73J7JB8NMMh0jqGdXLUT8jdNYFqOd9nLgOQOUTXafJ4ESEj
         50b/LVKTW8UFxVeRwp+j7tLPQgJJw3AylvrBqcPTqSDVR0+zoPc8vElvuyqxE4VaZ5Sp
         AfML6HgC1V2+zgKVM6NF28Atk/2LMy7uhNuDUoWxUjxq4FpuTMR8ZilQK8cRchjyC+je
         gqRoAZDxnxoW7dJ4jILOIu5ZVrjkB91lt50+1WW0JI8HBBHot/90bbc3rJuFwCF9f8hq
         HpyCZe9ncAuAF1PggNepFnN8HVuGD3xcA4UBeNiKKisWwcVhPQv9egzgvBd4GTioMdaD
         34Aw==
X-Gm-Message-State: AOAM530/NjRAJDWy73pq7jzjW4HPXJ8kXiSvto8Ae9pKJrQdJMXBb5Tq
        juSOU0104zg4u1d3fvGzOlw=
X-Google-Smtp-Source: ABdhPJzaB7syhPpYvqUXtQrW/XfIxiI0fU2XTi7T+9RC2+CQ6lyBLhW79NarIKvbDng0DRfhrmSyPw==
X-Received: by 2002:a5d:6d8c:0:b0:217:a419:c3f8 with SMTP id l12-20020a5d6d8c000000b00217a419c3f8mr42252830wrs.260.1655127595429;
        Mon, 13 Jun 2022 06:39:55 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b0039c5fb1f592sm9365680wmq.14.2022.06.13.06.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 06:39:54 -0700 (PDT)
Message-ID: <fed3da9f-2a87-96f7-347b-d1c4f5f133ae@gmail.com>
Date:   Mon, 13 Jun 2022 15:39:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] mailbox: mtk-cmdq: Remove proprietary cmdq_task_cb
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220608144055.27562-1-chunkuang.hu@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220608144055.27562-1-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/06/2022 16:40, Chun-Kuang Hu wrote:
> rx_callback is a standard mailbox callback mechanism and could cover the
> function of proprietary cmdq_task_cb, so use the standard one instead of
> the proprietary one. Client driver has changed to use standard
> rx_callback, so remove proprietary cmdq_task_cb.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c       | 11 -----------
>   include/linux/mailbox/mtk-cmdq-mailbox.h | 10 ----------
>   2 files changed, 21 deletions(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 2578e5aaa935..9465f9081515 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -192,15 +192,10 @@ static bool cmdq_thread_is_in_wfe(struct cmdq_thread *thread)
>   
>   static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
>   {
> -	struct cmdq_task_cb *cb = &task->pkt->async_cb;
>   	struct cmdq_cb_data data;
>   
>   	data.sta = sta;
> -	data.data = cb->data;
>   	data.pkt = task->pkt;
> -	if (cb->cb)
> -		cb->cb(data);
> -
>   	mbox_chan_received_data(task->thread->chan, &data);
>   
>   	list_del(&task->list_entry);
> @@ -448,7 +443,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
>   static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
>   {
>   	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
> -	struct cmdq_task_cb *cb;
>   	struct cmdq_cb_data data;
>   	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
>   	struct cmdq_task *task, *tmp;
> @@ -465,13 +459,8 @@ static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long timeout)
>   
>   	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>   				 list_entry) {
> -		cb = &task->pkt->async_cb;
>   		data.sta = -ECONNABORTED;
> -		data.data = cb->data;
>   		data.pkt = task->pkt;
> -		if (cb->cb)
> -			cb->cb(data);
> -
>   		mbox_chan_received_data(task->thread->chan, &data);
>   		list_del(&task->list_entry);
>   		kfree(task);
> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
> index 44365aab043c..a8f0070c7aa9 100644
> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
> @@ -67,24 +67,14 @@ enum cmdq_code {
>   
>   struct cmdq_cb_data {
>   	int			sta;
> -	void			*data;
>   	struct cmdq_pkt		*pkt;
>   };
>   
> -typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
> -
> -struct cmdq_task_cb {
> -	cmdq_async_flush_cb	cb;
> -	void			*data;
> -};
> -
>   struct cmdq_pkt {
>   	void			*va_base;
>   	dma_addr_t		pa_base;
>   	size_t			cmd_buf_size; /* command occupied size */
>   	size_t			buf_size; /* real buffer size */
> -	struct cmdq_task_cb	cb;
> -	struct cmdq_task_cb	async_cb;
>   	void			*cl;
>   };
>   
