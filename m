Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7E4F0154
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 14:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbiDBMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241537AbiDBMFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 08:05:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED091E49
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 05:03:49 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 12so5309674oix.12
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MUMGXPrqhpvIg0z7EbjNFhlD2pXd3vJXCzo/3QPQm0U=;
        b=slPzghhizm6vOrspQTwF79a4wz9zjj1ZH4K8G7OATmi+KyjLTur1IHmXK8yG200QTg
         WcfNxzSC3ZpkCivqbqjidMFbuOwb7ZBuDDLS4BOJQPxDR9xdKgJDpS99cA4J0Awvfozw
         oec1zWyrL14gIOo6XcDUrNCZiApNVVixg9UCe5OzDIhl1Bca0hsZIreOZdDvYg/U6Oct
         Kcc/EE4S6pE9jPYz+64zk1AZyfJRrHJP4bW5zBffvnRJTiyF59xmwsMZVo35+brRfeJq
         jClmkNFUGKTL1wXGtcIkfwe71TI6OjJOFLCpMSaak87MFqpsLkFHYFd6Yk23S6L7T6lr
         oo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MUMGXPrqhpvIg0z7EbjNFhlD2pXd3vJXCzo/3QPQm0U=;
        b=d9LEbR4X7uTvr+OY84bAyL0I8NWC0E/QI/dAQgw2xIPo980RYsBsiEBUKgyhPVc43O
         t95++em+omnEeG34a6qlOsd1MRjEtgGhQe3A7fX5sjbbBlkAyc5ZkesGZh/U0d6eGyQA
         5DY8xcyTMZcAfWgVofNoajYFOzJ3rCocZ5cnFWozx+lmWtruzMfvNkEOhOTmT7vwSjTb
         K39k28HT7nnk8QlNSzV8YJi9UYgLhjM5X4Dih8Cd5tDqFnCdSNDWdXynmlJxJQyXO1pq
         Z+QZsDuVh1/il3VAjLcG94NOy0/PELUW7Y2Sb4MVnHKl48lw6kHfPB2dhgfapn9L6Oxm
         AWnA==
X-Gm-Message-State: AOAM532w3TwLvjXkfarVcbRb/YK0QeVkOey4u88znb9WcFUFevjy4Iyr
        JlJ7JV66zekabmOaqvvOweuBvA==
X-Google-Smtp-Source: ABdhPJyVm3SEe6m69LmK1R0CuNduK1Owo1bZ9uOPeNTUVOBr/U7jLy0gVAnDVQbwrRzI5OjhF5gZqA==
X-Received: by 2002:a05:6808:1809:b0:2da:3311:3290 with SMTP id bh9-20020a056808180900b002da33113290mr6709699oib.295.1648901029264;
        Sat, 02 Apr 2022 05:03:49 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id q12-20020a4ad54c000000b003245ac0a745sm2082881oos.22.2022.04.02.05.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 05:03:48 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:03:43 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 06/23] media: h264: Increase reference lists size to 32
Message-ID: <Ykg7n2QM/TjH7Vro@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-7-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-7-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:08PM -0400, Nicolas Dufresne wrote:
> This is to accommodate support for field decoding, which splits the top
> and the bottom references into the reference list.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  drivers/media/v4l2-core/v4l2-h264.c        | 6 +++---
>  drivers/staging/media/hantro/hantro_hw.h   | 6 +++---
>  drivers/staging/media/rkvdec/rkvdec-h264.c | 6 +++---
>  include/media/v4l2-h264.h                  | 8 ++++----
>  4 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
> index afbfcf78efe4..4b46b36526c0 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -212,7 +212,7 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
>   * v4l2_h264_build_p_ref_list() - Build the P reference list
>   *
>   * @builder: reference list builder context
> - * @reflist: 16 sized array used to store the P reference list. Each entry
> + * @reflist: 32 sized array used to store the P reference list. Each entry
>   *	     is a v4l2_h264_reference structure
>   *
>   * This functions builds the P reference lists. This procedure is describe in
> @@ -235,9 +235,9 @@ EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
>   * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
>   *
>   * @builder: reference list builder context
> - * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
> + * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
>   *		is a v4l2_h264_reference structure
> - * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
> + * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
>   *		is a v4l2_h264_reference structure
>   *
>   * This functions builds the B0/B1 reference lists. This procedure is described
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index 2bc6b8f088f5..292aaaabaf24 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -69,9 +69,9 @@ struct hantro_h264_dec_ctrls {
>   * @b1:		B1 reflist
>   */
>  struct hantro_h264_dec_reflists {
> -	struct v4l2_h264_reference p[HANTRO_H264_DPB_SIZE];
> -	struct v4l2_h264_reference b0[HANTRO_H264_DPB_SIZE];
> -	struct v4l2_h264_reference b1[HANTRO_H264_DPB_SIZE];
> +	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
> +	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
> +	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
>  };
>  
>  /**
> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
> index 3c7f3d87fab4..dff89732ddd0 100644
> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> @@ -100,9 +100,9 @@ struct rkvdec_h264_priv_tbl {
>  #define RKVDEC_H264_DPB_SIZE 16
>  
>  struct rkvdec_h264_reflists {
> -	struct v4l2_h264_reference p[RKVDEC_H264_DPB_SIZE];
> -	struct v4l2_h264_reference b0[RKVDEC_H264_DPB_SIZE];
> -	struct v4l2_h264_reference b1[RKVDEC_H264_DPB_SIZE];
> +	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
> +	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
> +	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
>  	u8 num_valid;
>  };
>  
> diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
> index ef9a894e3c32..e282fb16ac58 100644
> --- a/include/media/v4l2-h264.h
> +++ b/include/media/v4l2-h264.h
> @@ -37,7 +37,7 @@ struct v4l2_h264_reflist_builder {
>  		u16 longterm : 1;
>  	} refs[V4L2_H264_NUM_DPB_ENTRIES];
>  	s32 cur_pic_order_count;
> -	struct v4l2_h264_reference unordered_reflist[V4L2_H264_NUM_DPB_ENTRIES];
> +	struct v4l2_h264_reference unordered_reflist[V4L2_H264_REF_LIST_LEN];
>  	u8 num_valid;
>  };
>  
> @@ -51,9 +51,9 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
>   * v4l2_h264_build_b_ref_lists() - Build the B0/B1 reference lists
>   *
>   * @builder: reference list builder context
> - * @b0_reflist: 16 sized array used to store the B0 reference list. Each entry
> + * @b0_reflist: 32 sized array used to store the B0 reference list. Each entry
>   *		is a v4l2_h264_reference structure
> - * @b1_reflist: 16 sized array used to store the B1 reference list. Each entry
> + * @b1_reflist: 32 sized array used to store the B1 reference list. Each entry
>   *		is a v4l2_h264_reference structure
>   *
>   * This functions builds the B0/B1 reference lists. This procedure is described
> @@ -70,7 +70,7 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
>   * v4l2_h264_build_p_ref_list() - Build the P reference list
>   *
>   * @builder: reference list builder context
> - * @reflist: 16 sized array used to store the P reference list. Each entry
> + * @reflist: 32 sized array used to store the P reference list. Each entry
>   *	     is a v4l2_h264_reference structure
>   *
>   * This functions builds the P reference lists. This procedure is describe in
> -- 
> 2.34.1
> 
