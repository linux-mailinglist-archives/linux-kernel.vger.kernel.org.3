Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0F5AEE40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiIFO5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiIFO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:57:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE627A6C75
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:12:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so9680860wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QFOWb4bNGHQvSTabTViDu0Cbcdb9l1RT04Dkmi7BSfQ=;
        b=tdjsW+5hYm+Bhc2EXr/TxH7TGvkjf6NusRICVuJF7Nfq0A6GNkQXK1Pe527n7FHSQI
         5lIFX5MokkNkujvJ+SdLooA1/QQHuA9lKHTmhbha9g0Wqh2woTOhxXwPaO8+p6Ycx1f7
         X/qVw6hHno078CR0GKKEUIqb1DIIXV0iYlMIdXOiUqiGWHSy2mPneqGFhoEeD9k7Ynnc
         cD3R3B/I/XV6/H7C0MpqncWGdiB6dF3B3H1qIVNTGAzJWnN7CJC7TuNpFoQmOiNbOuN4
         BHAJNwxr9fBfkkAO4lIlyKwT+xPIOITYg3JkaBjeTXbtCpvtOacoX4UwEKAuBqXIplrt
         zKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QFOWb4bNGHQvSTabTViDu0Cbcdb9l1RT04Dkmi7BSfQ=;
        b=VO9cBChs6j7fpILi64a0Uvq4m3Y5IRlfIez/8fis8ag6z3SGLNNCKXV82i9nw2bL0r
         myZzu7zWmunWTFvFJ7pH9uXrYtBYrv36QHG4eBVEVS9+Hv8EuCWREj4PSigwTIcv46vs
         WrijfzeYAl2a5sIJxkdG3/810u9SyeYNKGRRf/NnIQ+1dlQjAi1Ih5pqeYtQq5W0R3lO
         b5bDG0pL3+NPCEEAtAp2/ZL/SwYblb4jcL+Gzr5hn1jvy5MoN+1UxjaQijsYyq/hOMu+
         x3XJpmSnbdKTAILwHYc+yTYzDG1G1HakbG/eo2Q/tkOzrUnRv97ES2p7YFCoZjCPylpt
         2e4g==
X-Gm-Message-State: ACgBeo2offJBkfRIGB87NfO2gCucEgF6obbIgzvl3rkoTLCh/ecktxLY
        gdoUoAuYmOVcwPPcvGiFYVyExw==
X-Google-Smtp-Source: AA6agR50jeblKj4XYDfu/HSa2NwkPVXOo766FtBYHiW9bA059xq9qU6yuFzurjMmTE1vAJ6AgCVT+A==
X-Received: by 2002:a1c:ed0b:0:b0:3a6:30c:12f with SMTP id l11-20020a1ced0b000000b003a6030c012fmr13853478wmh.133.1662473452609;
        Tue, 06 Sep 2022 07:10:52 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l17-20020a5d6751000000b00228ccd00cedsm4439569wrw.107.2022.09.06.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 07:10:52 -0700 (PDT)
Message-ID: <a9fe2f55-a175-26b4-2542-53ac87f7ec58@linaro.org>
Date:   Tue, 6 Sep 2022 15:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/10] misc: fastrpc: Safekeep mmaps on interrupted
 invoke
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
 <20220902154900.3404524-9-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220902154900.3404524-9-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2022 16:48, Abel Vesa wrote:
> If the userspace daemon is killed in the middle of an invoke (e.g.
> audiopd listerner invoke), we need to skip the unmapping on device
> release, otherwise the DSP will crash. So lets safekeep all the maps
> only if there is in invoke interrupted, by attaching them to the channel
> context (which is resident until RPMSG driver is removed), and restore
> them back to the fastrpc user on the next device open call.
>

Am bit confused with this patch.

Intention is to support interrupted invoke calls, but resorting the maps 
on next open is totally something different.

if we move maps from interrupted list to compute context list on open 
then these will be freed in the close.

AFAIU, to support interrupted invoke we need to check the fd and sc and 
restore.


> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---


>   drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 2c656da4ca5e..41eabdf0a256 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
>   	struct fastrpc_device *secure_fdevice;
>   	struct fastrpc_device *fdevice;
>   	struct fastrpc_buf *remote_heap;
> +	struct list_head invoke_interrupted_mmaps;
>   	bool secure;
>   	bool unsigned_support;
>   };
> @@ -1114,6 +1115,26 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
>   
>   }
>   
> +static void fastrpc_invoke_interrupted_restore_mmaps(struct fastrpc_user *fl)
> +{
> +	struct fastrpc_buf *buf, *b;
> +
> +	list_for_each_entry_safe(buf, b, &fl->cctx->invoke_interrupted_mmaps, node) {
> +		list_del(&buf->node);
> +		list_add(&buf->node, &fl->mmaps);
> +	}
> +}
> +
> +static void fastrpc_invoke_interrupted_save_mmaps(struct fastrpc_user *fl)
> +{
> +	struct fastrpc_buf *buf, *b;
> +
> +	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> +		list_del(&buf->node);
> +		list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> +	}
> +}
> +
>   static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   				   u32 handle, u32 sc,
>   				   struct fastrpc_invoke_args *args)
> @@ -1182,6 +1203,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   		fastrpc_context_put(ctx);
>   	}
>   
> +	if (err == -ERESTARTSYS)
> +		fastrpc_invoke_interrupted_save_mmaps(fl);
> +
>   	if (err)
>   		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
>   
> @@ -1551,6 +1575,8 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
>   		return -EBUSY;
>   	}
>   
> +	fastrpc_invoke_interrupted_restore_mmaps(fl);
> +
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	list_add_tail(&fl->user, &cctx->users);
>   	spin_unlock_irqrestore(&cctx->lock, flags);
> @@ -2268,6 +2294,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	dev_set_drvdata(&rpdev->dev, data);
>   	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
>   	INIT_LIST_HEAD(&data->users);
> +	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
>   	spin_lock_init(&data->lock);
>   	idr_init(&data->ctx_idr);
>   	data->domain_id = domain_id;
> @@ -2292,6 +2319,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>   static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   {
>   	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> +	struct fastrpc_buf *buf, *b;
>   	struct fastrpc_user *user;
>   	unsigned long flags;
>   
> @@ -2306,6 +2334,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	if (cctx->secure_fdevice)
>   		misc_deregister(&cctx->secure_fdevice->miscdev);
>   
> +	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
> +		list_del(&buf->node);

AFAIU, This list will be empty all the time, as you are moving them to 
compute context list on open.

> +
>   	if (cctx->remote_heap)
>   		fastrpc_buf_free(cctx->remote_heap);
>   
