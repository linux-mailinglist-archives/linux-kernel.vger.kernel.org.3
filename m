Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2483951E820
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbiEGP1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiEGP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:27:50 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD7B433AE
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:24:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so8454701pgn.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cIpd969Y/rWkv3l4A4Fd61OrAM0/TLCY6M6nV2C3hPE=;
        b=NxGTyaXjoIEnxW0NSDK7tru0dYp5A7PZkDR89QnqFSM8tGcei+gPI51wFqXcalI5Gn
         qZJOFZKSlhKz1OfTMZVenJ/iHDtwgHunZ+7R1BR0nnhwqUwCpJRd7pTd3lOGKT6ylUms
         m6ybRnswuwQT8+3nbvO1zNbk10+yGiaugNODSvU55LplZhnW6fIzliH85o7PGrY2VYlp
         g4wryEdqgFWqLIkMoNlkTKDygabD1IKmyfRjrGeEE4kDVoxXBCld03usL+qKfEhORt+v
         RbwcozxKmcmHxg0VwOAGN3rxme7+/4dVvYRX2T1chL5CnoqW0n0HUB+QMe5K1rAv7P1p
         3fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cIpd969Y/rWkv3l4A4Fd61OrAM0/TLCY6M6nV2C3hPE=;
        b=UkuXHen1dvQNNDBoPqIel+Q6MyT6yth8TEQj2YVWLxes+O9SXvAGBAov0cblfKt443
         LdYuz7LjGGBQG2FpxnYZYCV0oRLqgB61fM2o4zd9vrLr4GrNLomc/jMgGfh8bo3zxvPy
         6UeT7RypDjdDbC4YqlegLEBze28B1KkftOuNSy59/VWdCmmcfeIvLhbP6Lka+wNlUhiz
         aWa4KT2jeV1ymukB4sdcWH9MApbZCRpRRLkXIjtoJEoutEloHfZSz6zU9TbgQVl/Gpzc
         bVmwakjVIHQxPiBb4UwRI9SY5U7OcriP2Bp7ompishN4pXL7tVWdDna5mxxouwBdKAMG
         UkIw==
X-Gm-Message-State: AOAM531vXLE7nFDtjq0PbazqZzo2/WneM5OC3Krf16oD41HqAeVklakr
        rlqFZsw0CJX/qMO2GrKASsB4Ag==
X-Google-Smtp-Source: ABdhPJyy1URP1Cd21C7fsRt50SKMrJwwXb+qgRFZ+9F4Nz2CeKF2SuSQVWv7aqFir2HGqxXamM039A==
X-Received: by 2002:a63:5752:0:b0:3c2:1c59:666f with SMTP id h18-20020a635752000000b003c21c59666fmr6728612pgm.59.1651937041478;
        Sat, 07 May 2022 08:24:01 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 24-20020a630e58000000b003c18e0768e3sm5218337pgo.78.2022.05.07.08.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:24:00 -0700 (PDT)
Message-ID: <a41a1f47-ad05-3245-8ac8-7d8e95ebde44@kernel.dk>
Date:   Sat, 7 May 2022 09:23:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/4] io_uring: implement multishot mode for accept
Content-Language: en-US
To:     Hao Xu <haoxu.linux@gmail.com>, io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20220507152009.87367-1-haoxu.linux@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220507152009.87367-1-haoxu.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/7/22 9:20 AM, Hao Xu wrote:
> @@ -5757,8 +5771,26 @@ static int io_accept(struct io_kiocb *req, unsigned int issue_flags)
>  		ret = io_install_fixed_file(req, file, issue_flags,
>  					    accept->file_slot - 1);
>  	}
> -	__io_req_complete(req, issue_flags, ret, 0);
> -	return 0;
> +
> +	if (!(req->flags & REQ_F_APOLL_MULTISHOT)) {
> +		__io_req_complete(req, issue_flags, ret, 0);
> +		return 0;
> +	}
> +	if (ret >= 0) {
> +		bool filled;
> +
> +		spin_lock(&ctx->completion_lock);
> +		filled = io_fill_cqe_aux(ctx, req->cqe.user_data, ret,
> +					 IORING_CQE_F_MORE);
> +		io_commit_cqring(ctx);
> +		spin_unlock(&ctx->completion_lock);
> +		if (!filled)
> +			return -ECANCELED;
> +		io_cqring_ev_posted(ctx);
> +		goto retry;
> +	}
> +
> +	return ret;

I'd still make that:

	if (filled) {
		io_cqring_ev_posted(ctx);
		goto retry;
	}
	ret = -ECANCELED;

as it flows better and shows what the likely outcome is.

>  static int io_connect_prep_async(struct io_kiocb *req)
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index f4d9ca62a5a6..7c3d70d12428 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -224,9 +224,9 @@ enum {
>  #define IORING_RECVSEND_POLL_FIRST	(1U << 0)
>  
>  /*
> - * accept flags stored in accept_flags
> + * accept flags stored in sqe->ioprio
>   */
> -#define IORING_ACCEPT_MULTISHOT	(1U << 15)
> +#define IORING_ACCEPT_MULTISHOT	(1U << 0)
>  
>  /*
>   * IO completion data structure (Completion Queue Entry)

This hunk needs to get folded in to the patch that adds the flag in the
first place.

-- 
Jens Axboe

