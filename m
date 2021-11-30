Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490FC46352C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbhK3NPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbhK3NPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:15:51 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5AC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:12:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so7672938wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 05:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=13fLHiEQF6pzhcz2WtgN+CcxU86iHvn9Ed1PMe3Dgmc=;
        b=u94G9RNZ+Tui6a3YE83HCfNfuShwxCK308YdsOGaSxwcjaYs4fitQoypt8CBQnWdsq
         po8v86TxHvVeUhvx9UPVM98K1KCJ7bxyhy9zTrtYZXJAYjvC+7EY+/ubNp/ahKgEpFg5
         3GFFFU1r4OUC04MyMs5V4CjsHMnHWIUPLwA9oz2PJ1dkXQ2+RCucH/jbAZfMkkKCJrUY
         cdLH8Qmux93WId5nxyPMfCEPO8lpzgBOtZekLCcBCjhxYDx50fGU1GdHOORfhWTxczQa
         fUGE9zIlroft18PH2uLRbFGMxVPqYHWc4VLDu32Rmqjk3PhmM7H3srNkDwLjOmB+ec4X
         9iZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=13fLHiEQF6pzhcz2WtgN+CcxU86iHvn9Ed1PMe3Dgmc=;
        b=ps7G3iLRn9mwOEn1yPUBxdm3MI8AANr070dD1tTVR+r10ix4y3RWLsANSLDE/388M3
         AgiUoULlDzwiA1XAwczzMOxZt0ytgDWO/6BNu9A17GmHHetSONEq1IlSizK6RVIhCPz5
         J087IKaU+/jVNwshRD+e9VLiwg8s/AZgWSjZNzNWAdRq3BTAW2Nz7IWERnQ5mS8Vwm9a
         u/zY2BIKE/L9BW2TdaM9foVUZVI/UQB7+DhRDr5s/MafJ5x39IU/HTXxZaUrAfXtV9Yj
         k7VOE6qA3w5JQzGAtyEnHDTtR5dstkUad+YKNglgROK7WLvjgwtBazpn2tsz/uV+bHxY
         o+3Q==
X-Gm-Message-State: AOAM531Tgojs+U/7W7W/LcW67o/seRePNzYy8iuomBDXxS4cbtJYtN8L
        +FanpGqbJX/TRKCQ1krvFzEcZhv6jE3qQA==
X-Google-Smtp-Source: ABdhPJwt8PVAIHAdDmXhCR7nPn458i2K2GdL1l197sJ2LP7lNV9hxJV1Qwy1Nr8mXfKX6BYgZTgEgA==
X-Received: by 2002:a1c:9d03:: with SMTP id g3mr4738698wme.143.1638277950315;
        Tue, 30 Nov 2021 05:12:30 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id h22sm2577321wmq.14.2021.11.30.05.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Nov 2021 05:12:29 -0800 (PST)
Subject: Re: [PATCH 1/2] misc: fastrpc: Add fdlist implementation
To:     Jeya R <jeyr@codeaurora.org>, ekangupt@qti.qualcomm.com,
        linux-arm-msm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
References: <1638276897-6146-1-git-send-email-jeyr@codeaurora.org>
 <1638276897-6146-3-git-send-email-jeyr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <cadd374b-cb22-9eaf-0513-67b34ccbbcf1@linaro.org>
Date:   Tue, 30 Nov 2021 13:12:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638276897-6146-3-git-send-email-jeyr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

This is version 2 of the patchset which is not reflected in the subject 
line.




On 30/11/2021 12:54, Jeya R wrote:
> Add fdlist implementation to support dma handles. fdlist is populated
> by DSP if any map is no longer used and it is freed during put_args.
> 
> Signed-off-by: Jeya R <jeyr@codeaurora.org>
> ---
>   drivers/misc/fastrpc.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)

Have you missed comments my comments on this patch

https://www.spinics.net/lists/linux-arm-msm/msg99023.html

--srini

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
>   
>   	if (ctx->buf)
> @@ -785,6 +785,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
>   	if (err)
>   		return err;
> +	memset(ctx->buf->virt, 0, pkt_size);
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
> +			fastrpc_map_put(mmap);
> +	}
> +
>   	return 0;
>   }
>   
> 
