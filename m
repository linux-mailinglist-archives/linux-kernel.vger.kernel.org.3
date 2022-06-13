Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9DE549C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbiFMSwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbiFMSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:51:51 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61548F073D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:52:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1769189wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=OCL5aWKRbj0ROQTskl1q1tCaL14mdMWA6juXly3fSBY=;
        b=Knn6GmPZQULHNfmfoeI4Fpg+udRaQGh5orUc4dJD4WbSTCQCnxwcWiNs993WqlEUWs
         /6dHHJAhYJXBD7Va9MK0UFIRRSTwEiqPoMPoIzSY+23D8k94rLcFIKpuMi18R1m3IWSh
         3NiJMMEsxpXeaiWNV7fWwvBZiSynlf72E1S6jqf9Mr+jY75/8l2OJed49AXo/ENVEthc
         Tkol+fq+LvPAWmT/LxapbDTbjAKe8Ml4vXGcnH1To03kPwyRe/68RiV6UaWxzWYUlfwu
         AYDngHNUGy6AxTykccByw6LHJvLS3ZwZb+RGAuBop5BjyTNj1VbSlh37MV5pNYlFBxXh
         AjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=OCL5aWKRbj0ROQTskl1q1tCaL14mdMWA6juXly3fSBY=;
        b=OGrUqQ7on8ZIgYD+z8EqKxyOos9Gri5m0Ek+3x/ZeTzylaHzjfu/G5YG/MywzJ408x
         FGcBAzjN5HtNuNNzKDz+85v+j1leyH+BRX9iI6iCWpZlRdTKW7Ni4hpmJqfFzhWRs4ip
         o1CZAPZTim/N/stWAmKG3kLlof0UMNL5713JHVXbRf5L7KvC2g+l3V87RrhcZC0w3N4q
         F0GVWp3FvfUALqN6d+tezb6DNFwN4MVCvQyh6jxI5e1Y07pbhBPHwRZxPkjexNTefHNa
         EfS44jCCxfKZM1TScCrZeXFLnH+ddRZHmji35IAcG4/qOBA4ZXBFq60XtVHFEdbDomin
         2TFQ==
X-Gm-Message-State: AOAM530ZKgREGnjUlTzCf/sieN70GHJ6O3VCmfUb+ntGcWDjnVpbMkLK
        wrVuU8w6QqUf/XGSbojV+tk=
X-Google-Smtp-Source: ABdhPJxb8jGNR9Uj1sykaV4sMfYHmhnT+dMd4lOi3/Cadt9gYuj/PJgSkxQCaPTx4jhhNoioc0o5Nw==
X-Received: by 2002:a05:600c:22d9:b0:39c:4b1b:5f99 with SMTP id 25-20020a05600c22d900b0039c4b1b5f99mr118995wmg.151.1655135564826;
        Mon, 13 Jun 2022 08:52:44 -0700 (PDT)
Received: from [192.168.0.36] ([37.223.143.134])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c129100b0039754d1d327sm9736322wmd.13.2022.06.13.08.52.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:52:43 -0700 (PDT)
Message-ID: <606c3409-0e27-e993-8657-0c8d36a16a97@gmail.com>
Date:   Mon, 13 Jun 2022 17:52:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     "moudy.ho" <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220608144055.27562-1-chunkuang.hu@kernel.org>
 <55b84b36832b0da24c267d06a43b9db4ee345176.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Remove proprietary cmdq_task_cb
In-Reply-To: <55b84b36832b0da24c267d06a43b9db4ee345176.camel@mediatek.com>
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



On 10/06/2022 04:49, moudy.ho wrote:
> On Wed, 2022-06-08 at 22:40 +0800, Chun-Kuang Hu wrote:
>> rx_callback is a standard mailbox callback mechanism and could cover
>> the
>> function of proprietary cmdq_task_cb, so use the standard one instead
>> of
>> the proprietary one. Client driver has changed to use standard
>> rx_callback, so remove proprietary cmdq_task_cb.
>>
>> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 
> Depends on:
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org/
> 
> Tested-by: Moudy Ho <Moudy.Ho@mediatek.com>
> 

Thanks for helping by testing this, although:

Your message makes me think that you didn't test against v5.19-rc1 nor against 
v5.18 (!) based kernel but something older. Giving a Tested-by tag to an older 
kernel with lots of out-of-tree patches on top can be critical as the kernel 
evolves and changes pretty much over time.
Upstream development should always be done against an upstream kernel, as 
otherwise bugs in the upstream kernel could stay unnoticed and show up as 
"regressions" later on, when you update your base kernel version.

Best regards,
Matthias

>> ---
>>   drivers/mailbox/mtk-cmdq-mailbox.c       | 11 -----------
>>   include/linux/mailbox/mtk-cmdq-mailbox.h | 10 ----------
>>   2 files changed, 21 deletions(-)
>>
>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>> index 2578e5aaa935..9465f9081515 100644
>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>> @@ -192,15 +192,10 @@ static bool cmdq_thread_is_in_wfe(struct
>> cmdq_thread *thread)
>>   
>>   static void cmdq_task_exec_done(struct cmdq_task *task, int sta)
>>   {
>> -	struct cmdq_task_cb *cb = &task->pkt->async_cb;
>>   	struct cmdq_cb_data data;
>>   
>>   	data.sta = sta;
>> -	data.data = cb->data;
>>   	data.pkt = task->pkt;
>> -	if (cb->cb)
>> -		cb->cb(data);
>> -
>>   	mbox_chan_received_data(task->thread->chan, &data);
>>   
>>   	list_del(&task->list_entry);
>> @@ -448,7 +443,6 @@ static void cmdq_mbox_shutdown(struct mbox_chan
>> *chan)
>>   static int cmdq_mbox_flush(struct mbox_chan *chan, unsigned long
>> timeout)
>>   {
>>   	struct cmdq_thread *thread = (struct cmdq_thread *)chan-
>>> con_priv;
>> -	struct cmdq_task_cb *cb;
>>   	struct cmdq_cb_data data;
>>   	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
>>   	struct cmdq_task *task, *tmp;
>> @@ -465,13 +459,8 @@ static int cmdq_mbox_flush(struct mbox_chan
>> *chan, unsigned long timeout)
>>   
>>   	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
>>   				 list_entry) {
>> -		cb = &task->pkt->async_cb;
>>   		data.sta = -ECONNABORTED;
>> -		data.data = cb->data;
>>   		data.pkt = task->pkt;
>> -		if (cb->cb)
>> -			cb->cb(data);
>> -
>>   		mbox_chan_received_data(task->thread->chan, &data);
>>   		list_del(&task->list_entry);
>>   		kfree(task);
>> diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h
>> b/include/linux/mailbox/mtk-cmdq-mailbox.h
>> index 44365aab043c..a8f0070c7aa9 100644
>> --- a/include/linux/mailbox/mtk-cmdq-mailbox.h
>> +++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
>> @@ -67,24 +67,14 @@ enum cmdq_code {
>>   
>>   struct cmdq_cb_data {
>>   	int			sta;
>> -	void			*data;
>>   	struct cmdq_pkt		*pkt;
>>   };
>>   
>> -typedef void (*cmdq_async_flush_cb)(struct cmdq_cb_data data);
>> -
>> -struct cmdq_task_cb {
>> -	cmdq_async_flush_cb	cb;
>> -	void			*data;
>> -};
>> -
>>   struct cmdq_pkt {
>>   	void			*va_base;
>>   	dma_addr_t		pa_base;
>>   	size_t			cmd_buf_size; /* command occupied
>> size */
>>   	size_t			buf_size; /* real buffer size */
>> -	struct cmdq_task_cb	cb;
>> -	struct cmdq_task_cb	async_cb;
>>   	void			*cl;
>>   };
>>   
> 
