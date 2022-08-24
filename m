Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9897959FD52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbiHXOaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiHXOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:30:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4E11468
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:30:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ca13so22623363ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=L3nhJ1oXEm66RN5YJpQxUjYOJUVJImLsdXQEym3JVNE=;
        b=JknGb3YsYH4h74OZgzf06J8m47ndvTj3jgsEk0rjExh7+xILbqdCRyR3KJTRo+duLR
         hA53EAUmakg+IufPqNIoL6KWa3OqcL4hQ69tCuysPX8XjWwj/jzIecMvLaWcrmCw91+2
         DFzU5c0PchnPoJl0qbWieoCGz0skfMDvvX7GQFZY1IJ/YzRMBqJWG8fPu7tNYScujZV6
         490SVTH8k41vKxRoEYvdxVesrC2gc1KQaPsY8qqc1d7htSN9iXEx/KKGobTM/s3iKP0s
         veZl7MtzPqRa+N8zTtaZ/xX/lX0auzQXObqigTpv2GhnKRHii0LMSaKr4z5VZw+XK8Pc
         SkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=L3nhJ1oXEm66RN5YJpQxUjYOJUVJImLsdXQEym3JVNE=;
        b=SGXOObehWvW6jJqHRGN41q4Qo+xcRIxqW4/9IPA01tcS19rvShVbnS+UiQL/xgbJxo
         H955XoRtacq+7MkUuLJ+HTwp456hR5qIMEelQCGeNujAiCow2HJesLp3VJSlOBDN4PNp
         jCwgTSDdlgIo6oNCh1RKmxxXKU9vLVktZtME4aJFSgnBzeyUxdJStd1zQ5+WV2Gg6OG1
         jbYJl98UdZ3nvTVFaw2kZwYGElguxy9hhGo7DxrJTWDsP5bvrZ6s+KG7xa49+TLrqNIg
         KpuLLCTi1iidVwtaWcY5WXp28LA4ds0zlBYyiRMSpD/PHmCexL7TNgo4xeaIypwkwp9F
         0fQg==
X-Gm-Message-State: ACgBeo3CgO71rxiGlEHEYGcGKAZrzLVVLcCI410EHHycKpnlICOpKCML
        XZ6gBMEg+gVrr9/fqLoRnuTKzxGfymZRdHhQX4PAfFWTD8A=
X-Google-Smtp-Source: AA6agR5NSfYqi4aiOyXY9NpkX/lrFYOyG2xevy89Tqs7/R3UIxulmNH7LSzKVDzuc7IdiZ6U+faz2D2VvV5PDq9QSvM=
X-Received: by 2002:a17:906:5d07:b0:73d:a136:760c with SMTP id
 g7-20020a1709065d0700b0073da136760cmr3000625ejt.435.1661351447121; Wed, 24
 Aug 2022 07:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220824075213.221397-1-ye.xingchen@zte.com.cn>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Aug 2022 16:30:36 +0200
Message-ID: <CAMGffEm=Ss1=Qvg_pd3MUT=XsKr+tvKn4bVaLUu4GEpDxHoC_g@mail.gmail.com>
Subject: Re: [PATCH linux-next] block/rnbd-clt: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, haris.iqbal@ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 9:52 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value from rtrs_clt_rdma_cq_direct() directly instead of
> storing it in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn
Acked-by: Jack Wang <jinpu.wang@ionos.com>
thx!
> ---
>  drivers/block/rnbd/rnbd-clt.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 9d01e7ab33e4..78334da74d8b 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1159,10 +1159,8 @@ static int rnbd_rdma_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>         struct rnbd_queue *q = hctx->driver_data;
>         struct rnbd_clt_dev *dev = q->dev;
> -       int cnt;
>
> -       cnt = rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
> -       return cnt;
> +       return rtrs_clt_rdma_cq_direct(dev->sess->rtrs, hctx->queue_num);
>  }
>
>  static void rnbd_rdma_map_queues(struct blk_mq_tag_set *set)
> --
> 2.25.1
