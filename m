Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6814F0125
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354694AbiDBLhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiDBLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:37:32 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF7AE75
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:35:40 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id z8so5303786oix.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVmxAeV6jn1gWoncdeIJ5il6g0CdD+Hlq/EJxdUklqE=;
        b=LX19uD64aLiDbq3sb546SA4HLqf42Hkj/oUycVdKLmFoJECd+hM13ExfTEaEPnp2PL
         2KZsm7KZk4HZb4V+xwi5sbfA3JGGZAX/D+5SNk5btOtJHf6uT2RR2ULjb9KlhkpTm7F1
         XmYasU+20jlkyQ0EDlHndJu7lWkehb+9JOLlXJR+9yBBR/4B/DXXKmS+W3m9YHlsMfu8
         HgFtjrjGD7qNUTQvhYOFhghbbKH1dmjzRDvPikJLUswtPre+XZwrflCzE+GrbkHD0fQQ
         7uG76GGsFNZqmVKV/uVkn7FJqv/mI5i/aCUVRxso0YK5hffxgs/0UvtsF7kncaawG2GU
         INQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVmxAeV6jn1gWoncdeIJ5il6g0CdD+Hlq/EJxdUklqE=;
        b=Hw/IEHhPn7nMdnF45YhwtPmjUHatwc3ZxqLxHTKkuK6Kz2y6r9PRWL3dXMBvCGJq98
         YV6SBOtUwHa+dtEGx2BovOZHx+czf06YuaaRy63d3TNDVzkvhR7VeqAWz/F4iF/P4lUz
         LtaSI437GhrU+WhqP03t0ztPmvkhz6aQDytbIGakhDxZaBfJMSlY2kCV55e4KXRn7QvY
         nq9Z4g183QEw2MbMSU9jRTlQfuPGX/ExT/txQLDLGY/G5EFSgVhUJSDdm2WoGGG8G9mn
         NLO2iy5k0aPuTyAdefpFxhNgIpHAxAZBVpaL+zC1ZbrAOIqnc9C0UsDlldmZ3AwvSdQf
         q3hg==
X-Gm-Message-State: AOAM53304MqL0AzUwLnvfEpEuuCrD57g2ReYrp9JKPGE5AeBiWog411f
        AE9NEvWQgyjzC826wgJ3ia1qMQ==
X-Google-Smtp-Source: ABdhPJwxMUnytlHFsdF6Bum7FoSq6ZYIQ0IJaVahiou9heXHf6ka4kyt7XPFCWoOXG6HgpUNyhO1og==
X-Received: by 2002:a05:6808:120e:b0:2f8:6db8:afa0 with SMTP id a14-20020a056808120e00b002f86db8afa0mr6338394oil.283.1648899339624;
        Sat, 02 Apr 2022 04:35:39 -0700 (PDT)
Received: from eze-laptop ([2803:9800:98c2:8470:9f4:8e2a:88e5:ec01])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm1998072oia.31.2022.04.02.04.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 04:35:39 -0700 (PDT)
Date:   Sat, 2 Apr 2022 08:35:33 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/23] media: rkvdec: Enable capture buffer holding
 for H264
Message-ID: <Ykg1BfGyI7ummQL8@eze-laptop>
References: <20220331193726.289559-1-nicolas.dufresne@collabora.com>
 <20220331193726.289559-18-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331193726.289559-18-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 03:37:19PM -0400, Nicolas Dufresne wrote:
> In order to support interlaced video decoding, the driver must
> allow holding the capture buffer so that the second field can
> be decoded into it.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

IMO, this patch (and the similar one for Hantro) should come
after interlaced support is added.

Thanks,
Ezequiel

> ---
>  drivers/staging/media/rkvdec/rkvdec.c | 4 ++++
>  drivers/staging/media/rkvdec/rkvdec.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
> index 1b805710e195..b6376eaa92d7 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.c
> +++ b/drivers/staging/media/rkvdec/rkvdec.c
> @@ -148,6 +148,7 @@ static const struct rkvdec_coded_fmt_desc rkvdec_coded_fmts[] = {
>  		.ops = &rkvdec_h264_fmt_ops,
>  		.num_decoded_fmts = ARRAY_SIZE(rkvdec_h264_vp9_decoded_fmts),
>  		.decoded_fmts = rkvdec_h264_vp9_decoded_fmts,
> +		.subsystem_flags = VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
>  	},
>  	{
>  		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
> @@ -404,6 +405,9 @@ static int rkvdec_s_output_fmt(struct file *file, void *priv,
>  	cap_fmt->fmt.pix_mp.ycbcr_enc = f->fmt.pix_mp.ycbcr_enc;
>  	cap_fmt->fmt.pix_mp.quantization = f->fmt.pix_mp.quantization;
>  
> +	/* Enable format specific queue features */
> +	vq->subsystem_flags |= desc->subsystem_flags;
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 2f4ea1786b93..e37f1a015fa0 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -81,6 +81,7 @@ struct rkvdec_coded_fmt_desc {
>  	const struct rkvdec_coded_fmt_ops *ops;
>  	unsigned int num_decoded_fmts;
>  	const u32 *decoded_fmts;
> +	u32 subsystem_flags;
>  };
>  
>  struct rkvdec_dev {
> -- 
> 2.34.1
> 
