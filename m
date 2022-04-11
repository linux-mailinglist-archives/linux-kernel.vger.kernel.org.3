Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8304FBC09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbiDKMan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbiDKMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:30:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16039BA5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:28:27 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id k14so14089298pga.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e3rfORwlh+GfqoV3kM6mCVh4CbmOsNbVFGcxLf2a93Y=;
        b=tUzS/ZzNqMYlIK7xIRTzMRkB0E+u5pTIJc5hG2P+LzCVsM81KuY0HBTxPxRMvXMkzv
         oArvRyInh5BVoQ3NN8F1ULSlphST13oZQDkTAy7PISkJ/sw/GGwKDY73Ef1i6rS2/CQf
         fnZ2blBUbpt4VRCKuMf03pLBSIH/fOsSYSBaG23dUmknp/oe7F0mizwZhCJKFo1n6rwq
         sSIHsxmnjhbUHl3E/SkzJbB92zo11E2aDLbTndlxflxTwhBFLCLW0ELK+AXg30SA1Hhu
         qqK2l7tOTMABUv5l157AdADgW2SkC1fNQrZtWK1B/mWqqgrL9GWxiBaAfpv5IhGPnjOM
         gtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3rfORwlh+GfqoV3kM6mCVh4CbmOsNbVFGcxLf2a93Y=;
        b=R4z2q6PiEd6OpME49jQlZ9SxzDtwmB23rJkjxrIIWQY8Jz3cuveBrUER3fvtrlPRpg
         DUOwWk3Icht9yKth0L79/8I6TuSgDfZywXo/mhiJQsLZ88MbM+aEfo4CUDsK2lavLwtu
         6A3bieBg7S57pHk65KpHtPRhwLwwOHkuu6maZmBcxBXAITJz2YsCWc1VuXqajHGeAfpA
         jyXAcLAA9zZlSmGTrTb1do9wBASZOQQsAn2cmE8128ZqzywdY65JblyCQ/M1Tq/OX/qB
         SUYnSw327yN06/v6jqHr2MCDEZd9JjtmtzQvbetu4hv7TNEVvHhe0742Q4PYi4U0hlKq
         7/Xg==
X-Gm-Message-State: AOAM533Tr3PSTTwVK5iTmNoM9WXQbQSh3NSB5EP+QQa/NtR01mXKWl3H
        Qp/frxQNN1jrRv+2K2fKLFWpp3N8LjjX8W0xBELuyw==
X-Google-Smtp-Source: ABdhPJxYTTZYwoekbEmlJ9vg6MC9aSPPn1/GrkR9rhG/OcTek55aJldP+zAq4vHoJGXiv6FOT+/qDM9SUT15Z+BSqks=
X-Received: by 2002:a65:6a97:0:b0:398:ae2:d207 with SMTP id
 q23-20020a656a97000000b003980ae2d207mr25656875pgu.197.1649680106538; Mon, 11
 Apr 2022 05:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220321130341.935535-1-jens.wiklander@linaro.org> <20220321130341.935535-2-jens.wiklander@linaro.org>
In-Reply-To: <20220321130341.935535-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 11 Apr 2022 17:58:15 +0530
Message-ID: <CAFA6WYPJ5S0w3L8+PYGF474v+DqvSp8T=U2w=bjAKummrCuUBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] optee: rename rpc_arg_count to rpc_param_count
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 at 18:33, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Renames the field rpc_arg_count in struct optee to rpc_param_count.
> Function parameter names and local variables are also renamed to match.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c          |  6 +++---
>  drivers/tee/optee/ffa_abi.c       | 10 +++++-----
>  drivers/tee/optee/optee_private.h |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index bd49ec934060..a9a237d20c61 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -113,12 +113,12 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
>         struct optee_msg_arg *ma;
>
>         /*
> -        * rpc_arg_count is set to the number of allocated parameters in
> +        * rpc_param_count is set to the number of allocated parameters in
>          * the RPC argument struct if a second MSG arg struct is expected.
>          * The second arg struct will then be used for RPC.
>          */
> -       if (optee->rpc_arg_count)
> -               sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
> +       if (optee->rpc_param_count)
> +               sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
>
>         shm = tee_shm_alloc_priv_buf(ctx, sz);
>         if (IS_ERR(shm))
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index a5eb4ef46971..7686f7020616 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -678,7 +678,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
>
>  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
>                                     const struct ffa_dev_ops *ops,
> -                                   unsigned int *rpc_arg_count)
> +                                   unsigned int *rpc_param_count)
>  {
>         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
>         int rc;
> @@ -693,7 +693,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
>                 return false;
>         }
>
> -       *rpc_arg_count = (u8)data.data1;
> +       *rpc_param_count = (u8)data.data1;
>
>         return true;
>  }
> @@ -772,7 +772,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
>  static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  {
>         const struct ffa_dev_ops *ffa_ops;
> -       unsigned int rpc_arg_count;
> +       unsigned int rpc_param_count;
>         struct tee_shm_pool *pool;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
> @@ -788,7 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
>                 return -EINVAL;
>
> -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_arg_count))
> +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
>                 return -EINVAL;
>
>         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> @@ -805,7 +805,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         optee->ops = &optee_ffa_ops;
>         optee->ffa.ffa_dev = ffa_dev;
>         optee->ffa.ffa_ops = ffa_ops;
> -       optee->rpc_arg_count = rpc_arg_count;
> +       optee->rpc_param_count = rpc_param_count;
>
>         teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
>                                   optee);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index e77765c78878..e80c5d9b62ec 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -143,7 +143,7 @@ struct optee_ops {
>   * @notif:             notification synchronization struct
>   * @supp:              supplicant synchronization struct for RPC to supplicant
>   * @pool:              shared memory pool
> - * @rpc_arg_count:     If > 0 number of RPC parameters to make room for
> + * @rpc_param_count:   If > 0 number of RPC parameters to make room for
>   * @scan_bus_done      flag if device registation was already done.
>   * @scan_bus_wq                workqueue to scan optee bus and register optee drivers
>   * @scan_bus_work      workq to scan optee bus and register optee drivers
> @@ -161,7 +161,7 @@ struct optee {
>         struct optee_notif notif;
>         struct optee_supp supp;
>         struct tee_shm_pool *pool;
> -       unsigned int rpc_arg_count;
> +       unsigned int rpc_param_count;
>         bool   scan_bus_done;
>         struct workqueue_struct *scan_bus_wq;
>         struct work_struct scan_bus_work;
> --
> 2.31.1
>
