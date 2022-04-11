Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B794FBCE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiDKNVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbiDKNVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:21:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6C63DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:18:58 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c29so141509pfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mFJg6aUAvFG4H5Lui1cBMhAa9G9WlVMAA3W1WdMbM0=;
        b=APki+WMAK/cG9Edt26aUT0e3NciBoDFgChdUTSoIaGNaDWyiw5VZeH+1kHVqDjJDqv
         0uElvqgcPt7+8vEsEK1pSNNuyyd98vcjU5m3iR7xyJpGK5VjjX4+DfKQGcaRQtvvFMYS
         ts23Z6POoUgTHcDUkaIAocULjV+Lbs5rVpQabKHYEtpttCp3lzpSm5M9DFgfCCvaXOPT
         XCnwXmZjRbiQxgTRgyB2440RngPqX6919zVDut4rcWAnaFlrtGb38ULl3FfNTfepLrZE
         EQ0r9MWTys89Thy6vULLFguQGZintFmU8wxjLwr9VOIZ2kHV4VjSb/gNB7Rb3V5Su3l2
         ejBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mFJg6aUAvFG4H5Lui1cBMhAa9G9WlVMAA3W1WdMbM0=;
        b=SHTZCfdkEkKxwlrmWpZjjmBQtRrxSBdsegTNP2JAh4df/FrxX7XTsOPU8cyvkayykV
         7QEoBfyCb66SCHPkHMzyTQLF9RNRszxTfFq6ioz2SWAwNUNP77G3NnIhSiyUNzrLCN8F
         Pp9z+qdV0YWt2oNf5oGkGmHml0WwbW6CiOiQf9+T0mcaSFjdZvsRpGMtF4s46hNwu5+y
         ZUluqJwPN3byS+XSyYBpD6pNshtXvzkBll9tBJE4t+8X8e7AMSMDqSLZQvKzHoEjKM4R
         RScisfGgNfk0TM9kNALLUowb4oGehXORJjtPFBHtzphs6+TY6jDpF+5xpKskHwlJ8qtY
         KVSw==
X-Gm-Message-State: AOAM532p+byqbHppeMMamanT/dSc5QQF1fzVftkfABuiMZI6IQjHvqMM
        fx5rbSxw6BDEThyPgxHwUu3AH3WD9wJeQb9Kd9zyzg==
X-Google-Smtp-Source: ABdhPJxdRdjqKTe9obeluyYkasgeAVsBqAcMgHdXgqsBccdIsEy8KlVwpkb95Vp+kGqHwvSWHQnPEoF70aZbi0OoLRc=
X-Received: by 2002:a65:6a97:0:b0:398:ae2:d207 with SMTP id
 q23-20020a656a97000000b003980ae2d207mr25829701pgu.197.1649683137802; Mon, 11
 Apr 2022 06:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220321130341.935535-1-jens.wiklander@linaro.org> <20220321130341.935535-3-jens.wiklander@linaro.org>
In-Reply-To: <20220321130341.935535-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 11 Apr 2022 18:48:46 +0530
Message-ID: <CAFA6WYPv_ReHmWCU9-i6nsDEXUhKW-dT0_4ph1PvqT4RWMxzpQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG
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
> Adds OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG where
> the struct optee_msg_arg to be used for RPC is appended in the memory
> following the normal argument struct optee_msg_arg. This is an
> optimization to avoid caching the RPC argument struct while still
> maintaining similar performance as if it was cached.
>
> OPTEE_SMC_CALL_WITH_REGD_ARG optimized one step further by using a
> registered shared memory object instead. It's in other aspects identical
> to OPTEE_SMC_CALL_WITH_RPC_ARG.
>
> The presence of OPTEE_SMC_CALL_WITH_RPC_ARG and
> OPTEE_SMC_CALL_WITH_REGD_ARG is indicated by the new
> OPTEE_SMC_SEC_CAP_RPC_ARG bit returned by
> OPTEE_SMC_EXCHANGE_CAPABILITIES. OPTEE_SMC_EXCHANGE_CAPABILITIES also
> reports the number of arguments that the RPC argument struct must have
> room for.
>
> OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_ARG can be used
> interleaved with difference that when OPTEE_SMC_CALL_WITH_RPC_ARG is
> used the RPC argument struct to be used is the one appended to the
> normal argument struct. The same is true for
> OPTEE_SMC_CALL_WITH_REGD_ARG.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c      |  2 +-
>  drivers/tee/optee/optee_smc.h | 47 ++++++++++++++---
>  drivers/tee/optee/smc_abi.c   | 99 ++++++++++++++++++++++++++---------
>  3 files changed, 116 insertions(+), 32 deletions(-)
>

Apart from minor nits below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index a9a237d20c61..58ac15c02818 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -130,7 +130,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
>                 return (void *)ma;
>         }
>
> -       memset(ma, 0, OPTEE_MSG_GET_ARG_SIZE(num_params));
> +       memset(ma, 0, sz);
>         ma->num_params = num_params;
>         *msg_arg = ma;
>
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index d44a6ae994f8..378741a459b6 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -107,14 +107,22 @@ struct optee_smc_call_get_os_revision_result {
>  /*
>   * Call with struct optee_msg_arg as argument
>   *
> - * When calling this function normal world has a few responsibilities:
> + * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> + * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> + * following after the first struct optee_msg_arg. The RPC struct
> + * optee_msg_arg has reserved space for the number of RPC parameters as
> + * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> + *
> + * When calling these functions normal world has a few responsibilities:

s/functions normal/functions, the normal/

>   * 1. It must be able to handle eventual RPCs
>   * 2. Non-secure interrupts should not be masked
>   * 3. If asynchronous notifications has been negotiated successfully, then
> - *    asynchronous notifications should be unmasked during this call.
> + *    the interrupt for asynchronous notifications should be unmasked
> + *    during this call.
>   *
> - * Call register usage:
> - * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> + * Call register usage, OPTEE_SMC_CALL_WITH_ARG and
> + * OPTEE_SMC_CALL_WITH_RPC_ARG:
> + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_ARG or OPTEE_SMC_CALL_WITH_RPC_ARG
>   * a1  Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
>   * a2  Lower 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
>   * a3  Cache settings, not used if physical pointer is in a predefined shared
> @@ -122,6 +130,15 @@ struct optee_smc_call_get_os_revision_result {
>   * a4-6        Not used
>   * a7  Hypervisor Client ID register
>   *
> + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> + * a1  Upper 32 bits of a 64-bit shared memory cookie
> + * a2  Lower 32 bits of a 64-bit shared memory cookie
> + * a3  Offset of the struct optee_msg_arg in the shared memory with the
> + *     supplied cookie
> + * a4-6        Not used
> + * a7  Hypervisor Client ID register
> + *
>   * Normal return register usage:
>   * a0  Return value, OPTEE_SMC_RETURN_*
>   * a1-3        Not used
> @@ -154,6 +171,10 @@ struct optee_smc_call_get_os_revision_result {
>  #define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEE_MSG_FUNCID_CALL_WITH_ARG
>  #define OPTEE_SMC_CALL_WITH_ARG \
>         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
> +#define OPTEE_SMC_CALL_WITH_RPC_ARG \
> +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> +#define OPTEE_SMC_CALL_WITH_REGD_ARG \
> +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
>
>  /*
>   * Get Shared Memory Config
> @@ -202,6 +223,10 @@ struct optee_smc_get_shm_config_result {
>   * a0  OPTEE_SMC_RETURN_OK
>   * a1  bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
>   * a2  The maximum secure world notification number
> + * a3  Bit[7:0]: Number of parameters needed for RPC to be supplied
> + *               as the second MSG arg struct for
> + *               OPTEE_SMC_CALL_WITH_ARG
> + *     Bit[31:8]: Reserved (MBZ)
>   * a3-7        Preserved

s/a3-7/a4-7/

>   *
>   * Error return register usage:
> @@ -215,7 +240,6 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_HAVE_RESERVED_SHM    BIT(0)
>  /* Secure world can communicate via previously unregistered shared memory */
>  #define OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM     BIT(1)
> -

nit: blank line shouldn't be removed.

>  /*
>   * Secure world supports commands "register/unregister shared memory",
>   * secure world accepts command buffers located in any parts of non-secure RAM
> @@ -227,6 +251,8 @@ struct optee_smc_get_shm_config_result {
>  #define OPTEE_SMC_SEC_CAP_MEMREF_NULL          BIT(4)
>  /* Secure world supports asynchronous notification of normal world */
>  #define OPTEE_SMC_SEC_CAP_ASYNC_NOTIF          BIT(5)
> +/* Secure world supports pre-allocating RPC arg struct */
> +#define OPTEE_SMC_SEC_CAP_RPC_ARG              BIT(6)
>
>  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
>  #define OPTEE_SMC_EXCHANGE_CAPABILITIES \
> @@ -236,7 +262,7 @@ struct optee_smc_exchange_capabilities_result {
>         unsigned long status;
>         unsigned long capabilities;
>         unsigned long max_notif_value;
> -       unsigned long reserved0;
> +       unsigned long data;
>  };
>
>  /*
> @@ -358,6 +384,9 @@ struct optee_smc_disable_shm_cache_result {
>   * should be called until all pended values have been retrieved. When a
>   * value is retrieved, it's cleared from the record in secure world.
>   *
> + * It is expected that this function is called from an interrupt handler
> + * in normal world.
> + *
>   * Call requests usage:
>   * a0  SMC Function ID, OPTEE_SMC_GET_ASYNC_NOTIF_VALUE
>   * a1-6        Not used
> @@ -390,6 +419,12 @@ struct optee_smc_disable_shm_cache_result {
>  #define OPTEE_SMC_GET_ASYNC_NOTIF_VALUE \
>         OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_ASYNC_NOTIF_VALUE)
>
> +/* See OPTEE_SMC_CALL_WITH_RPC_ARG above */
> +#define OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG     18
> +
> +/* See OPTEE_SMC_CALL_WITH_REGD_ARG above */
> +#define OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG    19
> +
>  /*
>   * Resume from RPC (for example after processing a foreign interrupt)
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 67b7f7d2ff27..b258d7306042 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -732,16 +732,9 @@ static void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx)
>  }
>
>  static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> -                               struct tee_shm *shm,
> +                               struct optee_msg_arg *arg,
>                                 struct optee_call_ctx *call_ctx)
>  {
> -       struct optee_msg_arg *arg;
> -
> -       arg = tee_shm_get_va(shm, 0);
> -       if (IS_ERR(arg)) {
> -               pr_err("%s: tee_shm_get_va %p failed\n", __func__, shm);
> -               return;
> -       }
>
>         switch (arg->cmd) {
>         case OPTEE_RPC_CMD_SHM_ALLOC:
> @@ -765,11 +758,13 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>   * Result of RPC is written back into @param.
>   */
>  static void optee_handle_rpc(struct tee_context *ctx,
> +                            struct optee_msg_arg *rpc_arg,
>                              struct optee_rpc_param *param,
>                              struct optee_call_ctx *call_ctx)
>  {
>         struct tee_device *teedev = ctx->teedev;
>         struct optee *optee = tee_get_drvdata(teedev);
> +       struct optee_msg_arg *arg;
>         struct tee_shm *shm;
>         phys_addr_t pa;
>
> @@ -801,8 +796,19 @@ static void optee_handle_rpc(struct tee_context *ctx,
>                  */
>                 break;
>         case OPTEE_SMC_RPC_FUNC_CMD:
> -               shm = reg_pair_to_ptr(param->a1, param->a2);
> -               handle_rpc_func_cmd(ctx, optee, shm, call_ctx);
> +               if (rpc_arg) {
> +                       arg = rpc_arg;
> +               } else {
> +                       shm = reg_pair_to_ptr(param->a1, param->a2);
> +                       arg = tee_shm_get_va(shm, 0);
> +                       if (IS_ERR(arg)) {
> +                               pr_err("%s: tee_shm_get_va %p failed\n",
> +                                      __func__, shm);
> +                               break;
> +                       }
> +               }
> +
> +               handle_rpc_func_cmd(ctx, optee, arg, call_ctx);
>                 break;
>         default:
>                 pr_warn("Unknown RPC func 0x%x\n",
> @@ -816,7 +822,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>  /**
>   * optee_smc_do_call_with_arg() - Do an SMC to OP-TEE in secure world
>   * @ctx:       calling context
> - * @arg:       shared memory holding the message to pass to secure world
> + * @shm:       shared memory holding the message to pass to secure world
>   *
>   * Does and SMC to OP-TEE in secure world and handles eventual resulting
>   * Remote Procedure Calls (RPC) from OP-TEE.
> @@ -824,21 +830,46 @@ static void optee_handle_rpc(struct tee_context *ctx,
>   * Returns return code from secure world, 0 is OK
>   */
>  static int optee_smc_do_call_with_arg(struct tee_context *ctx,
> -                                     struct tee_shm *arg)
> +                                     struct tee_shm *shm)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
>         struct optee_call_waiter w;
>         struct optee_rpc_param param = { };
>         struct optee_call_ctx call_ctx = { };
> -       phys_addr_t parg;
> +       struct optee_msg_arg *rpc_arg = NULL;
>         int rc;
>
> -       rc = tee_shm_get_pa(arg, 0, &parg);
> -       if (rc)
> -               return rc;
> +       if (optee->rpc_param_count) {
> +               struct optee_msg_arg *arg;
> +               unsigned int rpc_arg_offs;
> +
> +               arg = tee_shm_get_va(shm, 0);
> +               if (IS_ERR(arg))
> +                       return PTR_ERR(arg);
>
> -       param.a0 = OPTEE_SMC_CALL_WITH_ARG;
> -       reg_pair_from_64(&param.a1, &param.a2, parg);
> +               rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> +               rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> +               if (IS_ERR(arg))
> +                       return PTR_ERR(arg);
> +       }
> +
> +       if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> +               param.a0 = OPTEE_SMC_CALL_WITH_REGD_ARG;
> +               reg_pair_from_64(&param.a1, &param.a2, (u_long)shm);
> +               param.a3 = 0;
> +       } else {
> +               phys_addr_t parg;
> +
> +               rc = tee_shm_get_pa(shm, 0, &parg);
> +               if (rc)
> +                       return rc;
> +
> +               if (rpc_arg)
> +                       param.a0 = OPTEE_SMC_CALL_WITH_RPC_ARG;
> +               else
> +                       param.a0 = OPTEE_SMC_CALL_WITH_ARG;
> +               reg_pair_from_64(&param.a1, &param.a2, parg);
> +       }
>         /* Initialize waiter */
>         optee_cq_wait_init(&optee->call_queue, &w);
>         while (true) {
> @@ -862,7 +893,7 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>                         param.a1 = res.a1;
>                         param.a2 = res.a2;
>                         param.a3 = res.a3;
> -                       optee_handle_rpc(ctx, &param, &call_ctx);
> +                       optee_handle_rpc(ctx, rpc_arg, &param, &call_ctx);
>                 } else {
>                         rc = res.a0;
>                         break;
> @@ -1118,7 +1149,8 @@ static bool optee_msg_api_revision_is_compatible(optee_invoke_fn *invoke_fn)
>  }
>
>  static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
> -                                           u32 *sec_caps, u32 *max_notif_value)
> +                                           u32 *sec_caps, u32 *max_notif_value,
> +                                           unsigned int *rpc_param_count)
>  {
>         union {
>                 struct arm_smccc_res smccc;
> @@ -1145,6 +1177,10 @@ static bool optee_msg_exchange_capabilities(optee_invoke_fn *invoke_fn,
>                 *max_notif_value = res.result.max_notif_value;
>         else
>                 *max_notif_value = OPTEE_DEFAULT_MAX_NOTIF_VALUE;
> +       if (*sec_caps & OPTEE_SMC_SEC_CAP_RPC_ARG)
> +               *rpc_param_count = (u8)res.result.data;
> +       else
> +               *rpc_param_count = 0;
>
>         return true;
>  }
> @@ -1251,7 +1287,8 @@ static int optee_smc_remove(struct platform_device *pdev)
>          * reference counters and also avoid wild pointers in secure world
>          * into the old shared memory range.
>          */
> -       optee_disable_shm_cache(optee);
> +       if (!optee->rpc_param_count)
> +               optee_disable_shm_cache(optee);
>
>         optee_smc_notif_uninit_irq(optee);
>
> @@ -1274,7 +1311,10 @@ static int optee_smc_remove(struct platform_device *pdev)
>   */
>  static void optee_shutdown(struct platform_device *pdev)
>  {
> -       optee_disable_shm_cache(platform_get_drvdata(pdev));
> +       struct optee *optee = platform_get_drvdata(pdev);
> +
> +       if (!optee->rpc_param_count)
> +               optee_disable_shm_cache(optee);
>  }
>
>  static int optee_probe(struct platform_device *pdev)
> @@ -1283,6 +1323,7 @@ static int optee_probe(struct platform_device *pdev)
>         struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
>         struct optee *optee = NULL;
>         void *memremaped_shm = NULL;
> +       unsigned int rpc_param_count;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
>         u32 max_notif_value;
> @@ -1306,7 +1347,8 @@ static int optee_probe(struct platform_device *pdev)
>         }
>
>         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
> -                                            &max_notif_value)) {
> +                                            &max_notif_value,
> +                                            &rpc_param_count)) {
>                 pr_warn("capabilities mismatch\n");
>                 return -EINVAL;
>         }
> @@ -1335,6 +1377,7 @@ static int optee_probe(struct platform_device *pdev)
>         optee->ops = &optee_ops;
>         optee->smc.invoke_fn = invoke_fn;
>         optee->smc.sec_caps = sec_caps;
> +       optee->rpc_param_count = rpc_param_count;
>
>         teedev = tee_device_alloc(&optee_clnt_desc, NULL, pool, optee);
>         if (IS_ERR(teedev)) {
> @@ -1403,7 +1446,12 @@ static int optee_probe(struct platform_device *pdev)
>          */
>         optee_disable_unmapped_shm_cache(optee);
>
> -       optee_enable_shm_cache(optee);
> +       /*
> +        * Only enable the shm cache in case we're not able to pass the RPC
> +        * arg struct right after the normal arg struct.
> +        */
> +       if (!optee->rpc_param_count)
> +               optee_enable_shm_cache(optee);
>
>         if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
>                 pr_info("dynamic shared memory is enabled\n");
> @@ -1416,7 +1464,8 @@ static int optee_probe(struct platform_device *pdev)
>         return 0;
>
>  err_disable_shm_cache:
> -       optee_disable_shm_cache(optee);
> +       if (!optee->rpc_param_count)
> +               optee_disable_shm_cache(optee);
>         optee_smc_notif_uninit_irq(optee);
>         optee_unregister_devices();
>  err_notif_uninit:
> --
> 2.31.1
>
