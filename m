Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DC14D7E13
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiCNJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbiCNJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:04:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14E531DED
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:03:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s11so13697948pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGhuM+Ul8ivfECgpMOf+uI9At4u/thxxxtZts2/cwIo=;
        b=jtuwA3otb+JEQeCtC5sFp76yUkFebNN67sz4Sd7Rz63tG5UuGaEOgjnNzrMGibzxgH
         B7jkx2iMfTNCvYp/0laSPFWrAXnu+7LGe7JoBDXpIYuUfSkDJAKC+snFugRnBMJozOMR
         EQgyaY2h9FX1R8v61Xc6Jerr2aqR0LkPusphMhUQecCREi0g41YKRvJqTq+ZpSan9KMm
         OSF+l64S6MYJxIPJtmxsoA8Nu5RydZkgPrkVB+7lvXtiPyfVnmEd57WsHjLcfALSqZCk
         ZxACblfSesJaiiPrgtr4njAkxFfj4RRD+oFRbQVgqoxHXRkbI9Zm8GyGUrAYoMCJuzIT
         1MdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGhuM+Ul8ivfECgpMOf+uI9At4u/thxxxtZts2/cwIo=;
        b=lziHe7pGqP/n19UbHgEomC1n0nC1R3VMWZ9P8YRNHFF7feVnYTgn38kkHtXTQpwpJW
         BjaqW8OEzOXrevdVAHdyO/lZKS9ja7lRKppiCUKUAlltUZr0CThuidpS+moQoGHvU1s7
         tUmFWNQFEIinJzxvLa9fv0ULmEb8dGoLRI7I+Ns5W8I8nUtIoZdS0aRgKGx0WIpt1NEb
         VtTgjRvXRoxwSOKqItDTe3ZFoIY+7mG1oToy82dd0NohQkrgakP/twaiybXmz6uXCojj
         PgJjoW6eatpt0Kc09AYBEwlE5hQzFp3gJ88LFa+EvMrUWJOwhDZElyJZO/GZudzrQnrW
         iKmw==
X-Gm-Message-State: AOAM530k5/2OXshbBE91WOoE1T1wfsSyQAxh5CkFkf2l6zl/DtD68dnj
        Zc1bHK5NsDvJfNm8s8anflyoECJbt6raKLrahViisx44/79haA==
X-Google-Smtp-Source: ABdhPJxGuJ+973f0F6J0wdUQG+sd71F7QlJJrClPl/UMGq8eoJPqhJOYvQrNx0WvcwhkIp9nytb8KwDRO+YQMsJRwes=
X-Received: by 2002:a63:174f:0:b0:381:2bb3:2661 with SMTP id
 15-20020a63174f000000b003812bb32661mr6760596pgx.197.1647248617345; Mon, 14
 Mar 2022 02:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org> <20220301194830.3557578-3-jens.wiklander@linaro.org>
In-Reply-To: <20220301194830.3557578-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 14 Mar 2022 14:33:26 +0530
Message-ID: <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
Subject: Re: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
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

On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
> OP-TEE with FF-A can support an argument struct at a non-zero offset into
> a passed shared memory object.
>

It isn't clear to me why FF-A ABI requires this capability.
shm->offset should be honoured by default, if it isn't then it's a
bug. AFAIK, FF-A is currently still in its early stages so it
shouldn't be that hard to fix bugs in the ABI.

-Sumit

> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
>  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 7686f7020616..cc863aaefcd9 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
>                 .data1 = (u32)shm->sec_world_id,
>                 .data2 = (u32)(shm->sec_world_id >> 32),
> -               .data3 = shm->offset,
> +               .data3 = 0,
>         };
>         struct optee_msg_arg *arg;
>         unsigned int rpc_arg_offs;
>         struct optee_msg_arg *rpc_arg;
>
> +       /*
> +        * The shared memory object has to start on a page when passed as
> +        * an argument struct. This is also what the shm pool allocator
> +        * returns, but check this before calling secure world to catch
> +        * eventual errors early in case something changes.
> +        */
> +       if (shm->offset)
> +               return -EINVAL;
> +
>         arg = tee_shm_get_va(shm, 0);
>         if (IS_ERR(arg))
>                 return PTR_ERR(arg);
> @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
>
>  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
>                                     const struct ffa_dev_ops *ops,
> +                                   u32 *sec_caps,
>                                     unsigned int *rpc_param_count)
>  {
>         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
>         }
>
>         *rpc_param_count = (u8)data.data1;
> +       *sec_caps = data.data2;
>
>         return true;
>  }
> @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         struct tee_device *teedev;
>         struct tee_context *ctx;
>         struct optee *optee;
> +       u32 sec_caps;
>         int rc;
>
>         ffa_ops = ffa_dev_ops_get(ffa_dev);
> @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
>                 return -EINVAL;
>
> -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
> +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> +                                    &rpc_param_count))
>                 return -EINVAL;
>
>         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> index ee3a03fc392c..97266243deaa 100644
> --- a/drivers/tee/optee/optee_ffa.h
> +++ b/drivers/tee/optee/optee_ffa.h
> @@ -81,8 +81,16 @@
>   *                   as the second MSG arg struct for
>   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
>   *        Bit[31:8]: Reserved (MBZ)
> - * w5-w7: Note used (MBZ)
> + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> + *       unused bits MBZ.
> + * w6-w7: Not used (MBZ)
> + */
> +/*
> + * Secure world supports giving an offset into the argument shared memory
> + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
>   */
> +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> +
>  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
>
>  /*
> @@ -112,6 +120,8 @@
>   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
>   *       for RPC, this struct has reserved space for the number of RPC
>   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
> + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
> + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
>   * w7:    Not used (MBZ)
>   * Resume from RPC. Register usage:
>   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> --
> 2.31.1
>
