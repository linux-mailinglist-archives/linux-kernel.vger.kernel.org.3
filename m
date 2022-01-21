Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602AD496048
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350761AbiAUODM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380942AbiAUOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:02:21 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E36C061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:02:18 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c2so18191891wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=her8pTQyVK8jreqAr5JeTBZvQUJTv2/MJ1OXGn/Z07c=;
        b=nxJ/Krh9rawBvAW5a2szanIGZ1i73UeIv0GSn0TsOKh2yT5pirgc26ZP/aOWDUGHCi
         0N5FuPUeqWw9axpSBpehyCLZ9TZENv7qJOsDFrEHvYCTOVl3k8J8i5HDJaKQOURJAYiP
         0KlAlnRw4ZhPemsPLWlSAwj2FhlPDBFYXpvSvqjZSA9b4cIzS9K3xmTAgc6SsjZRfGC0
         bYyBtvQVgyFsXHVnaA5iRqoaq6YCiloMRaj1YpUXgQyEMth5hVfy5aRfmkmmWctDTANl
         +HPq+H/PvxG7vZMd+bXuxmviLabcCnEhW672ZGUfRwzKKFFYNth+70uUu9INt3qoByHj
         SJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=her8pTQyVK8jreqAr5JeTBZvQUJTv2/MJ1OXGn/Z07c=;
        b=aNkflIiyqmDu0kqgTxQcb4DXRVZYID93kZC1B9uvbJUPvssqAPPwiqVj2RRhP+xgCb
         aGPcCffQufd3ZFudga78uIVA2EX58nlguIvA0g7YsH0ToiUUy4JBTAsKc4w9xl2QkuAA
         VHH+3MhdA38wL3vUr+8vHJ0KHpkbOSPqW/T05lq/bKrWte0FPKnBvep1k4vS7IPe5Y5S
         FsDyXEEVuyTl2a3o7oOCel6CQs0Vf1erjfo5Jf66h3Qb3XGZEzxN3KBGK1k4nGRisk+D
         ZFv6699tixDtqNf1FQqoEwRxbuj8GQwifz7PoqWWspNRzpLJlRXm0V8Zar8SyOfdwIQZ
         n5kA==
X-Gm-Message-State: AOAM530UbVzgSaHYXcwGwf1RxcpnL/AqP0LmCv2oKFaPIGWsUAkTaK8p
        q53dJI25oIelSYNMIDZvX1/0utOgos+xUu5veIh2Mo6p1tk=
X-Google-Smtp-Source: ABdhPJziNjRSUK9pdHhvlNl/V7EUFJMTcY7Sop6mMxH5IKk2wCgCRkmSvagz3PP+iMuRWZIhk2a/Xh6Du1oKcbkcS00=
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr901960wmm.8.1642773737211;
 Fri, 21 Jan 2022 06:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-8-jens.wiklander@linaro.org> <CAFA6WYN+NU6uj=R5y4A6RomWeKc74orvB7ouia8Sxuwxaz_-2w@mail.gmail.com>
 <ad7311fe-0655-e235-f755-2eb3425c79c1@forissier.org> <CAFA6WYNo2xJ8VncpwbHG65hTTshxa-SWaPnGCB2v3KCTGogJkQ@mail.gmail.com>
In-Reply-To: <CAFA6WYNo2xJ8VncpwbHG65hTTshxa-SWaPnGCB2v3KCTGogJkQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 21 Jan 2022 15:02:06 +0100
Message-ID: <CAHUa44H-t2fVFWHQDU6ZjY7qyk53rbOi_h7=V_pYXTN+TtbMjA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jerome Forissier <jerome@forissier.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 2:37 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 21 Jan 2022 at 18:58, Jerome Forissier <jerome@forissier.org> wrote:
> >
> > On 1/21/22 13:54, Sumit Garg wrote:
> > > + Jerome, Etienne
> > >
> > > On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > >>
> > >> Uses the new driver internal tee_context when allocating driver private
> > >> shared memory. This decouples the shared memory object from its original
> > >> tee_context. This is needed when the life time of such a memory
> > >> allocation outlives the client tee_context.
> > >>
> > >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > >> ---
> > >>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
> > >>  drivers/tee/optee/smc_abi.c |  7 ++++---
> > >>  2 files changed, 12 insertions(+), 11 deletions(-)
> > >>
> > >
> > > I guess with this patch we should no longer see issues [1] reported earlier.
> >
> > Correct. I have tested [1] again in QEMU with this whole series applied
> > and the issue is gone.
> >
>
> Thanks for the confirmation.
>
> Jens,
>
> Can we have a Fixes tag for this and CC stable? I know it won't be
> directly applicable to stable kernels but we can help with a backport.
>

OK, I'll add that.

Thanks,
Jens

> -Sumit
>
> > --
> > Jerome
> >
> > >
> > > FWIW,
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > [1] https://github.com/OP-TEE/optee_os/issues/1918
> > >
> > > -Sumit
> > >
> > >> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > >> index 88a028d4fb7b..5ec484b42432 100644
> > >> --- a/drivers/tee/optee/ffa_abi.c
> > >> +++ b/drivers/tee/optee/ffa_abi.c
> > >> @@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
> > >>   */
> > >>
> > >>  static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >> +                                             struct optee *optee,
> > >>                                               struct optee_msg_arg *arg)
> > >>  {
> > >>         struct tee_shm *shm;
> > >> @@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
> > >>                 break;
> > >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> > >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx,
> > >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx,
> > >>                                                     arg->params[0].u.value.b);
> > >>                 break;
> > >>         default:
> > >> @@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
> > >>  }
> > >>
> > >>  static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> > >> +                                   struct optee *optee,
> > >>                                     struct optee_msg_arg *arg)
> > >>  {
> > >> -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> > >> -
> > >>         arg->ret_origin = TEEC_ORIGIN_COMMS;
> > >>         switch (arg->cmd) {
> > >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> > >> -               handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
> > >> +               handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
> > >>                 break;
> > >>         case OPTEE_RPC_CMD_SHM_FREE:
> > >>                 handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
> > >> @@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> > >>         }
> > >>  }
> > >>
> > >> -static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
> > >> -                                struct optee_msg_arg *arg)
> > >> +static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
> > >> +                                u32 cmd, struct optee_msg_arg *arg)
> > >>  {
> > >>         switch (cmd) {
> > >>         case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
> > >> -               handle_ffa_rpc_func_cmd(ctx, arg);
> > >> +               handle_ffa_rpc_func_cmd(ctx, optee, arg);
> > >>                 break;
> > >>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
> > >>                 /* Interrupt delivered by now */
> > >> @@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
> > >>                  * above.
> > >>                  */
> > >>                 cond_resched();
> > >> -               optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
> > >> +               optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
> > >>                 cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
> > >>                 data->data0 = cmd;
> > >>                 data->data1 = 0;
> > >> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > >> index 1dbb13b08381..f2ef76451443 100644
> > >> --- a/drivers/tee/optee/smc_abi.c
> > >> +++ b/drivers/tee/optee/smc_abi.c
> > >> @@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
> > >>  }
> > >>
> > >>  static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >> +                                         struct optee *optee,
> > >>                                           struct optee_msg_arg *arg,
> > >>                                           struct optee_call_ctx *call_ctx)
> > >>  {
> > >> @@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
> > >>                 break;
> > >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> > >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
> > >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
> > >>                 break;
> > >>         default:
> > >>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > >> @@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> > >>         switch (arg->cmd) {
> > >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> > >>                 free_pages_list(call_ctx);
> > >> -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
> > >> +               handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
> > >>                 break;
> > >>         case OPTEE_RPC_CMD_SHM_FREE:
> > >>                 handle_rpc_func_cmd_shm_free(ctx, arg);
> > >> @@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
> > >>
> > >>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > >>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> > >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
> > >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
> > >>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
> > >>                         reg_pair_from_64(&param->a1, &param->a2, pa);
> > >>                         reg_pair_from_64(&param->a4, &param->a5,
> > >> --
> > >> 2.31.1
> > >>
