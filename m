Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E404DD586
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiCRHur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiCRHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:50:44 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE4E8BE39
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:49:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso9803414pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z45L2cWmZstSCqaxO6Enz5cNR4pE5b0VpLuF4/Ovk4A=;
        b=OnoKYqCZSM3qBgB2/t9uzFaprydbidI2Y5TKYfAv/JBPsb0Q6JcaqxgP5DV6iM2NOd
         amLgmw14ailVzPnjszaDMnrwZ8iyuy/LAQ2GWt3PS+4DL8+T99isEwAUl4dbA7/8sAq2
         I2+5gZYixM1bPsPWK5Jg/gnvCfQdFeFgq9HXNtwIMwoVJpNf7FU+2SpPjGYAZM2f1o1D
         dB7NXmhFjz1OTWGpz14pI3sBTK+0ImOluhtzkK9BTExqMsVY84qRin3ObqRB5eCAaxzY
         noEjBHWcfKkVevy3vo45juaepfzA+i42XKrJ8U1uX30TRYazpIVHoeNJTW80OZnwl3tL
         tupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z45L2cWmZstSCqaxO6Enz5cNR4pE5b0VpLuF4/Ovk4A=;
        b=5QygXSROS1D9ob+Mr0oVuCluiIW6YHpinTTKnZdUNkwABP/VVBFJEAklUWl2/Hw8gO
         +bOc3CjFGSTj1Es+V6Jr/C2uhbFew1j5I4aRPHkIvGIrrgY6mv5JkPal09UC6szGQj5i
         L263zmfzMcBJAE18Y1js6gvkdsaQSu+bZ+59+PFoWerPbpqr1YlbIvtDutfe+vFUIply
         hAUA4hV/H49kzPW7ZQaXi6A57W9KG2v1uYf5yYNl5IZzaeQlyfDpyWAI3ykBd3OM1De6
         B1X//U4VInihRsHX/9b6Qlbl3pqhwrzPH8Z9NusdUaSnoMm/oMRLUTJk+XM64R9dDBvK
         MQGQ==
X-Gm-Message-State: AOAM531n3rC7QDd9Nn+bLGTNRWxdK9KobWD6CsYakO7yd0ff5WVBqpNF
        BbWZMT3ay0xyWBOplASE04iTfNVjBu821x3NBCEv+w==
X-Google-Smtp-Source: ABdhPJx3WYYLzvJjA5PogWFe8QDj0u5TDf6QAU1O3572jNfsT0+gS4sBH6c+iH5HifS/L84rfECWCplZu4K6fGs+Xvw=
X-Received: by 2002:a17:902:a3cb:b0:151:e52e:fa0c with SMTP id
 q11-20020a170902a3cb00b00151e52efa0cmr8439526plb.70.1647589764519; Fri, 18
 Mar 2022 00:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-3-jens.wiklander@linaro.org> <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
 <20220316092705.GB2535470@jade> <CAFA6WYPDxHz45Ev4yqi0rE4W08YnNbrwUg8FMt9y1FnL3f84yw@mail.gmail.com>
In-Reply-To: <CAFA6WYPDxHz45Ev4yqi0rE4W08YnNbrwUg8FMt9y1FnL3f84yw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 18 Mar 2022 08:49:13 +0100
Message-ID: <CAHUa44EqPprBC_M8vuhxpJE8gVuzbYYitgsvHpRLHWp4-vJnfQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Thu, Mar 17, 2022 at 1:17 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 16 Mar 2022 at 14:57, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > On Mon, Mar 14, 2022 at 02:33:26PM +0530, Sumit Garg wrote:
> > > On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > > >
> > > > Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
> > > > OP-TEE with FF-A can support an argument struct at a non-zero offset into
> > > > a passed shared memory object.
> > > >
> > >
> > > It isn't clear to me why FF-A ABI requires this capability.
> > > shm->offset should be honoured by default, if it isn't then it's a
> > > bug.
> >
> > Yes, there was a bug in secure world when using a non-zero offset. So
> > far the driver has always used a zero offset that's why it hasn't been
> > caught earlier.
> >
> > It's not a serious bug, but it might be quite hard to track down. This
> > is of course fixed now, but there is a window where it can be triggered.
>
> I am not able to find the fix in this [1] OP-TEE OS commit. Could you
> help me to point it out?
>
> [1] https://github.com/OP-TEE/optee_os/commit/89d991352352b80ae90f82228a014bb8cadfb80b

I believe it's this one:
https://github.com/OP-TEE/optee_os/commit/7267624eef019476f20aee7dba11ff949d005670

>
> >
> > So in order to spare FF-A developers this problem I'm making a non-zero
> > offset an extension guarded by a capability bit. Even though this is an
> > ABI change it's in practice not since it has been unused and not working
> > as expected.
> >
> > The next commit will start using non-zero offsets if supported, so this
> > will change to become a problem (if left unchecked) in the window
> > mentioned above.
> >
> > > AFAIK, FF-A is currently still in its early stages so it
> > > shouldn't be that hard to fix bugs in the ABI.
> >
> > Starting from the kernel release (v5.16) where FF-A support in this
> > driver was merged the ABI is supposed to be stable.
> >
>
> From Linux kernel perspective, there are dedicated stable branches for
> that purpose in case we want to push a fix for OP-TEE FF-A kernel
> driver.

The problem isn't in the kernel driver. What I'm doing here is to
formalize the ABI that the kernel defacto was using. Since we
obviously didn't test the driver with a non-zero offset before, we
didn't notice that the offset wasn't used in the right way by the
secure world.

Cheers,
Jens

>
> -Sumit
>
> > Thanks,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
> > > >  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
> > > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > > index 7686f7020616..cc863aaefcd9 100644
> > > > --- a/drivers/tee/optee/ffa_abi.c
> > > > +++ b/drivers/tee/optee/ffa_abi.c
> > > > @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> > > >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> > > >                 .data1 = (u32)shm->sec_world_id,
> > > >                 .data2 = (u32)(shm->sec_world_id >> 32),
> > > > -               .data3 = shm->offset,
> > > > +               .data3 = 0,
> > > >         };
> > > >         struct optee_msg_arg *arg;
> > > >         unsigned int rpc_arg_offs;
> > > >         struct optee_msg_arg *rpc_arg;
> > > >
> > > > +       /*
> > > > +        * The shared memory object has to start on a page when passed as
> > > > +        * an argument struct. This is also what the shm pool allocator
> > > > +        * returns, but check this before calling secure world to catch
> > > > +        * eventual errors early in case something changes.
> > > > +        */
> > > > +       if (shm->offset)
> > > > +               return -EINVAL;
> > > > +
> > > >         arg = tee_shm_get_va(shm, 0);
> > > >         if (IS_ERR(arg))
> > > >                 return PTR_ERR(arg);
> > > > @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> > > >
> > > >  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > >                                     const struct ffa_dev_ops *ops,
> > > > +                                   u32 *sec_caps,
> > > >                                     unsigned int *rpc_param_count)
> > > >  {
> > > >         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > > > @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> > > >         }
> > > >
> > > >         *rpc_param_count = (u8)data.data1;
> > > > +       *sec_caps = data.data2;
> > > >
> > > >         return true;
> > > >  }
> > > > @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > >         struct tee_device *teedev;
> > > >         struct tee_context *ctx;
> > > >         struct optee *optee;
> > > > +       u32 sec_caps;
> > > >         int rc;
> > > >
> > > >         ffa_ops = ffa_dev_ops_get(ffa_dev);
> > > > @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > > >         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> > > >                 return -EINVAL;
> > > >
> > > > -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
> > > > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > > > +                                    &rpc_param_count))
> > > >                 return -EINVAL;
> > > >
> > > >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > > > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> > > > index ee3a03fc392c..97266243deaa 100644
> > > > --- a/drivers/tee/optee/optee_ffa.h
> > > > +++ b/drivers/tee/optee/optee_ffa.h
> > > > @@ -81,8 +81,16 @@
> > > >   *                   as the second MSG arg struct for
> > > >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> > > >   *        Bit[31:8]: Reserved (MBZ)
> > > > - * w5-w7: Note used (MBZ)
> > > > + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> > > > + *       unused bits MBZ.
> > > > + * w6-w7: Not used (MBZ)
> > > > + */
> > > > +/*
> > > > + * Secure world supports giving an offset into the argument shared memory
> > > > + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
> > > >   */
> > > > +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> > > > +
> > > >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
> > > >
> > > >  /*
> > > > @@ -112,6 +120,8 @@
> > > >   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
> > > >   *       for RPC, this struct has reserved space for the number of RPC
> > > >   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > > + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
> > > > + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > > >   * w7:    Not used (MBZ)
> > > >   * Resume from RPC. Register usage:
> > > >   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> > > > --
> > > > 2.31.1
> > > >
