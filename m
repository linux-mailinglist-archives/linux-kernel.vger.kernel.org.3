Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C9E461FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379650AbhK2S44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379544AbhK2Syz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:54:55 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084D2C08C5F1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:13:02 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id t9so20574178wrx.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xquLonnK7pAKBqVBzE4OuytOwfJ3qCkRHAHnNdpdzPw=;
        b=hHMyva5D2w89wjRhCI6ExzexdQiQ9tO2PwCgN4OhQg0fYHIsbEVelK1zk1v25I8wXn
         kQeisU7JhMX579OFnK7wz81792tamQIlxG3ObAg+xrHi6wgZxqu8mrL9B38wRjZFgfI7
         n/l378P8RaiAyzDqQPjOrhpPp+5EVL7ni6CQdnadcYoMXChvTWmTotMIRDDP1bXknVX2
         2JCx1bsgwMQlb3X5InXz2T3dFO8ET1/Ep+9EU8wo4wa1YxhlePsMF+YVlWs5A+v0keuk
         6i2UCbWBVIHPpaBQfYfkWURJfLouNqZdVBsGfn2ybuc/euGQtBr/1CEyUufjiHy66qW9
         cpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xquLonnK7pAKBqVBzE4OuytOwfJ3qCkRHAHnNdpdzPw=;
        b=dXYHSJRJ7cRSeQiC50Ulzk4gXkVesaugneHlF4JsqE8CEt6+K9HUMD16y+j+b1iZs5
         d+y8/LTT9CLWhZXx1oZNuUtvalA7pLDqwYPILc4PiOB6qG1DRgpT9CzKw81sVfRyHe6J
         oxxkwuVQgw6zffrT9h9I/DwUnaus4GgOFb76HjHXZcnHXKzmyp6ClE4nBjkLJcHbJ9dG
         iT/Xm90DMBCUtX2m/pe351Ljk4yb6c2QlHJO0NPlhR4xKu2KZPJazMFFN1u9vCRFE1PN
         iBIsQmmHbjmZ6H9z6G+3j78pafL5MqQBx5N+8RPPBeanSroNJqbYh5KLChm296ZtNu/1
         2+mg==
X-Gm-Message-State: AOAM531BeEpTWcRgnSE8gfWz73vX7emBTxnRuNJSYfM6miMSP55o8zR9
        Kd3LrCKVicgwrg9iYzI1kAbEoQ==
X-Google-Smtp-Source: ABdhPJzKyl4TJblK+Slv12GEcnCAS7+Hp0r869ZbGOnYYo0uMtagIcvKyzHPiYTmDU6aEL5fGE/k3w==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr33167492wrx.378.1638198780445;
        Mon, 29 Nov 2021 07:13:00 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id r17sm22290873wmq.5.2021.11.29.07.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 07:12:59 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
References: <1638163720-23123-1-git-send-email-jeyr@codeaurora.org>
 <1638163720-23123-2-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3ee1388d-2528-56ed-ce5f-4c667beb67cb@linaro.org>
Date:   Mon, 29 Nov 2021 15:12:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638163720-23123-2-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch,


On 29/11/2021 05:28, Jeya R wrote:
> Add fdlist implementation to support dma handles. fdlist is populated
> by DSP if any map is no longer used and it is freed during put_args.

Does the dsp add all the fds (from in/out handles) to this list or only 
ones that are no-longer used by the dsp?


> 
> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   drivers/misc/fastrpc.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 39aca77..3c937ff 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -353,7 +353,7 @@ static void fastrpc_context_free(struct kref *ref)
>   	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
>   	cctx = ctx->cctx;
>   
> -	for (i = 0; i < ctx->nscalars; i++)
> +	for (i = 0; i < ctx->nbufs; i++)
>   		fastrpc_map_put(ctx->maps[i]);

If above question is true, then who is going to free the rest of the 
scalars.

>   
>   	if (ctx->buf)
> @@ -785,6 +785,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
>   	if (err)
>   		return err;
> +	memset(ctx->buf->virt, 0, pkt_size);

Why do we need to make this zero, dma_alloc_coherent should have 
returned zeroed memory here anyway?


>   
>   	rpra = ctx->buf->virt;
>   	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
> @@ -887,9 +888,19 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   			    u32 kernel)
>   {
>   	struct fastrpc_remote_arg *rpra = ctx->rpra;
> -	int i, inbufs;
> +	struct fastrpc_map *mmap = NULL;
> +	struct fastrpc_invoke_buf *list;
> +	struct fastrpc_phy_page *pages;
> +	u64 *fdlist;
> +	int i, inbufs, outbufs, handles;
>   
>   	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
> +	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
> +	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
> +	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
> +	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
> +		sizeof(*rpra));
> +	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
>   
>   	for (i = inbufs; i < ctx->nbufs; ++i) {
>   		if (!ctx->maps[i]) {
> @@ -906,6 +917,13 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
>   		}
>   	}
>   
> +	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
> +		if (!fdlist[i])
> +			break;
> +		if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))

fastrpc_map_find() is will invoke a kref_get on the map so calling 
single fastrpc_map_put() here is not going to work. driver will be 
leaking memory.

Have you tested this patch with kmemleak enabled?

--srini


> +			fastrpc_map_put(mmap);


> +	}
> +
>   	return 0;
>   }
>   
> 
