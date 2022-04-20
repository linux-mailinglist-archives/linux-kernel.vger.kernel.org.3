Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887265087EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378427AbiDTMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242236AbiDTMSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:18:25 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A0167F4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:15:39 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id o127so1567466iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Ctf05BnnO/qOOsj3lddSfaG/ckbIuPH18mve0wqxytc=;
        b=MOLLrmIbPhbcuVPkAQ//MoR8UOLTM7HHPzV8X75L6wD9+Wdrs1poUTr/Dge/vUt5Sl
         g3JxL8ioJFyr49Foa1yI8VuHEwf7Urlsu6wkJI+RL36Cy1vQUwkchkt7JdPmtuXORkQ4
         x8RMivE61Gx/gtWTJnsLGiKnd8M8gPPExucRmI+KrI2/FAxVdNQwNxO7coS3ll0/wUuk
         l/DukXjH5WTNMfBpn5TM+wOkOqoURzbNEfcmeBhTOui/4WnCxqL+IniflFx4v6rqmTCa
         3fzieVNrdABSaiWvxg6hCSReLlqHZpUuo2eGZoui1RivR1kxMK3ZQJIVJsnk1Je1dv5+
         Z/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ctf05BnnO/qOOsj3lddSfaG/ckbIuPH18mve0wqxytc=;
        b=OCq2ULG8OQuwOZVHCHFFhFYPax3bCOGt0Jja1PTtFEWdluAS9p860yfpQST7gzujkG
         bNVkOlVZmYLxSgVEMzZ6CCJNKFLbeTCSMBTvr0D17QcIdRpU9GRAwKV7LuEj2/IMuCiJ
         ETJ+kK9hVCVhSwuhiSO7PYZ0iSFjHoE0uj5pDyGsM8X0u9HdivqA+GPl0nPMQ4coJ7k/
         pCFrrug9mflTHEP3tIB8dUF+4xbl+KDeDy26FM4Ed5AlGeLic+s6mOl+tWDa5ccsyP/U
         NBiec6ve8EdWi8pW07deQJke7GZnJkRvphAQzuJk4Wy7jUVbkrxc+sJwHOD/kRiGgyiS
         bgMQ==
X-Gm-Message-State: AOAM5316jZVNlb2s/YSQu4xtKYdgllZ3d1ccmLju3NFg7wLerwwhfqKa
        CWj7iMzT3hpXuhwE4PGK5IwV8+CaUG0y5Q==
X-Google-Smtp-Source: ABdhPJxWfk/nAf1Dm0w32dF4UstB4QlQHnDUirwxOVjblMaKE8IgXOAi2O3VwePL6xJC0hz1fj2o7Q==
X-Received: by 2002:a05:6638:481a:b0:326:6a2c:2396 with SMTP id cp26-20020a056638481a00b003266a2c2396mr9535358jab.122.1650456938840;
        Wed, 20 Apr 2022 05:15:38 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id 131-20020a6b0189000000b0065393383518sm8806980iob.48.2022.04.20.05.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:15:38 -0700 (PDT)
Message-ID: <caec273c-b15c-6dca-cd8e-e1b48c5d5490@gmail.com>
Date:   Wed, 20 Apr 2022 14:15:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RESEND PATCH] soc: mediatek: cmdq: Use mailbox rx_callback
 instead of cmdq_task_cb
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1650102868-26219-1-git-send-email-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/04/2022 11:54, Chun-Kuang Hu wrote:
> rx_callback is a standard mailbox callback mechanism and could cover the
> function of proprietary cmdq_task_cb, so use the standard one instead of
> the proprietary one. Client has changed to use the standard callback
> machanism and sync dma buffer in client driver, so remove the proprietary
> callback in cmdq helper.
> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Applied, thanks

> ---
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +------------------------
>   include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
>   2 files changed, 2 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 3c8e421..c1837a4 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>   }
>   EXPORT_SYMBOL(cmdq_pkt_finalize);
>   
> -static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> -{
> -	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
> -	struct cmdq_task_cb *cb = &pkt->cb;
> -	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> -
> -	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> -				pkt->cmd_buf_size, DMA_TO_DEVICE);
> -	if (cb->cb) {
> -		data.data = cb->data;
> -		cb->cb(data);
> -	}
> -}
> -
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> -			 void *data)
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
>   {
>   	int err;
>   	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>   
> -	pkt->cb.cb = cb;
> -	pkt->cb.data = data;
> -	pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
> -	pkt->async_cb.data = pkt;
> -
> -	dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
> -				   pkt->cmd_buf_size, DMA_TO_DEVICE);
> -
>   	err = mbox_send_message(client->chan, pkt);
>   	if (err < 0)
>   		return err;
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index ac6b5f3..2b498f4 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>    * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
>    *                          packet and call back at the end of done packet
>    * @pkt:	the CMDQ packet
> - * @cb:		called at the end of done packet
> - * @data:	this data will pass back to cb
>    *
>    * Return: 0 for success; else the error code is returned
>    *
> @@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>    * at the end of done packet. Note that this is an ASYNC function. When the
>    * function returned, it may or may not be finished.
>    */
> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> -			 void *data);
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
>   
>   #endif	/* __MTK_CMDQ_H__ */
