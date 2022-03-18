Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3524DD53D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbiCRHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbiCRHbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:31:08 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC81A397
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:29:50 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c2so4482235pga.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9iyJySUUNjl+l+zvVdcSEmjuYmhQUV3mqx0A9jjhdc=;
        b=mjn+YnWrB5juWkbrW7YgVUF0KeELIfStfGTZVuLQOdPu5ZePerrFaT4M1qVsowaTnb
         itoRS4Hr3VNbcPnB012R9sZ20Ez8uGpwDaeTtrxjaHWqE5KNigpEithgpqae3/qMiOEM
         YrHrdreM6TqWaVchujglNrxk2pQu7fhRt9CCE4tBkt+1NvjTNILJVsPZKfwHaX+A6GkP
         gLbLpLSTtZKPBtNh7P61tOrB3xJ96qY0eGrm0/9d4GVkt9w43EPgWv9BgU9tiYYILLXT
         O2xOplYrVbSNUuYVfC7PLN+AyAP8JBeS3fsOhSL1VY1tQTFl3mT+k9i7JlZ+YRNNV7CY
         rPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9iyJySUUNjl+l+zvVdcSEmjuYmhQUV3mqx0A9jjhdc=;
        b=vAUxHB7ppD2l7v6QZmDnTjVgnGjsFYaMpdbTVid4BDj3zLEB6WjUuS71a1MaKLeGGR
         4f73sugNdfcYacqLBmsjJgU5ZJPC6361c8dwPSN4No5zcGETowRREePZImlD1gESlAKI
         TqsKB+BnuOINZ470vmmcNuOkj9OHS8cbCFw77u/Dy/Scfyq64BVVCVpnwpscpCjYVhrb
         RSFkroHmiRO6Tq7b/9LoPxgGIDmfzDV/ghdezzqoo+yyzZasXaCxkeYGZdnMkklImyKw
         c2/hgR6vW6QCBfZOCQWjTRgRiG/0QU0olZLQ1zwl34V72duvNU/GTMU4HfkPUKwlSVEp
         daTA==
X-Gm-Message-State: AOAM530YGMc6o0oSTOsBQ2dZOFRkVYyh75VhVIxzAZY8zFHK7YLamzMz
        oPYduPSKNiONSid2YLZXby0LLp2R9M2UfkZWdwyomF3Lwc9j0Q==
X-Google-Smtp-Source: ABdhPJwC9qjwUrItMlbvnJNAmItpFL+Hr4S2apUWjclwluSyqh+eh3c50YU/7rtibg7p5EFqcarIL6bVCXEuBgFVCJ8=
X-Received: by 2002:a63:1649:0:b0:382:2a04:4136 with SMTP id
 9-20020a631649000000b003822a044136mr1892485pgw.568.1647588589862; Fri, 18 Mar
 2022 00:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-2-jens.wiklander@linaro.org> <CAFA6WYMzwbX5OUgpxptAxy-uphTU4rMVJOxkzFHb+oYD0SN-sQ@mail.gmail.com>
 <20220316081728.GA2535470@jade> <CAFA6WYPYE1Ggs+6GB5Z9aMVcFjrS8mOm4LbggBocti+Yvz8idA@mail.gmail.com>
In-Reply-To: <CAFA6WYPYE1Ggs+6GB5Z9aMVcFjrS8mOm4LbggBocti+Yvz8idA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 18 Mar 2022 08:29:38 +0100
Message-ID: <CAHUa44G8brKgzV9DdriHD+aN_=k5K9gECvurk+hmK0y-NqF+rA@mail.gmail.com>
Subject: Re: [PATCH 1/3] optee: add OPTEE_SMC_CALL_WITH_RPC_ARG
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

On Thu, Mar 17, 2022 at 12:40 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Wed, 16 Mar 2022 at 13:47, Jens Wiklander <jens.wiklander@linaro.org> wrote:
[snip]
> > > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > > index d44a6ae994f8..378741a459b6 100644
> > > > --- a/drivers/tee/optee/optee_smc.h
> > > > +++ b/drivers/tee/optee/optee_smc.h
> > > > @@ -107,14 +107,22 @@ struct optee_smc_call_get_os_revision_result {
> > > >  /*
> > > >   * Call with struct optee_msg_arg as argument
> > > >   *
> > > > - * When calling this function normal world has a few responsibilities:
> > > > + * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
> > > > + * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
> > > > + * following after the first struct optee_msg_arg. The RPC struct
> > > > + * optee_msg_arg has reserved space for the number of RPC parameters as
> > > > + * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.
> > > > + *
> > > > + * When calling these functions normal world has a few responsibilities:
> > > >   * 1. It must be able to handle eventual RPCs
> > > >   * 2. Non-secure interrupts should not be masked
> > > >   * 3. If asynchronous notifications has been negotiated successfully, then
> > > > - *    asynchronous notifications should be unmasked during this call.
> > > > + *    the interrupt for asynchronous notifications should be unmasked
> > > > + *    during this call.
> > > >   *
> > > > - * Call register usage:
> > > > - * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> > > > + * Call register usage, OPTEE_SMC_CALL_WITH_ARG and
> > > > + * OPTEE_SMC_CALL_WITH_RPC_ARG:
> > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_ARG or OPTEE_SMC_CALL_WITH_RPC_ARG
> > > >   * a1  Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> > > >   * a2  Lower 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> > > >   * a3  Cache settings, not used if physical pointer is in a predefined shared
> > > > @@ -122,6 +130,15 @@ struct optee_smc_call_get_os_revision_result {
> > > >   * a4-6        Not used
> > > >   * a7  Hypervisor Client ID register
> > > >   *
> > > > + * Call register usage, OPTEE_SMC_CALL_WITH_REGD_ARG:
> > >
> > > Although I didn't see any reference to OPTEE_SMC_CALL_WITH_REGD_ARG in
> > > the commit message, but do we really need to introduce it? Wouldn't it
> > > be possible to just pass additional "shared memory cookie" value as
> > > part of "Not used" (a4-6) arguments?
> >
> > I'll update the commit message to mention OPTEE_SMC_CALL_WITH_REGD_ARG
> > too. I think it's more clear with a separate ID for this, less risk of
> > confusion.
>
> IMO, it would unnecessarily complicate and introduce ambiguity in the
> ABI as after this patch we will have:
>
> CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments buffer
> CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments buffer
> CALL_WITH_REGD_ARG: Registered arguments but *not* explicit whether
> RPC arguments buffer is there or not.

CALL_WITH_REGD_ARG is quite explicit in the description above (in the patch):
 * When called with OPTEE_SMC_CALL_WITH_RPC_ARG or
 * OPTEE_SMC_CALL_WITH_REGD_ARG in a0 there is one RPC struct optee_msg_arg
 * following after the first struct optee_msg_arg. The RPC struct
 * optee_msg_arg has reserved space for the number of RPC parameters as
 * returned by OPTEE_SMC_EXCHANGE_CAPABILITIES.

I chose to use two new SMC IDs to have one clear purpose for each.

I preferred the name OPTEE_SMC_CALL_WITH_REGD_ARG instead of
OPTEE_SMC_CALL_WITH_REGD_RPC_ARG since I thought the former was long
enough.

>
> If we keep the ABI simplified to say we only support two types of
> invocation irrespective of whether the arguments are allocated from
> statically shared memory or dynamically shared memory:
>
> CALL_WITH_ARG: Standard arguments *without* pre-allocated RPC arguments buffer
> CALL_WITH_RPC_ARG: Standard arguments *with* pre-allocated RPC arguments buffer

That's only simple on the surface. When looking into the details of
CALL_WITH_RPC_ARG you'd need a more complicated register usage since
the function would be doing two different things.

>
> > How would the callee know if it's the cookie or the physical
> > address it should use?  Whatever we do, we're extenting the ABI.
> >
>
> Isn't it possible for OP-TEE to determine if it's a valid cookie or
> not which will be passed into currently unused arguments?

Actually, we need three registers, one to pass the offset in too.

Cheers,
Jens

>
> -Sumit
>
> > >
> > > > + * a0  SMC Function ID, OPTEE_SMC_CALL_WITH_REGD_ARG
> > > > + * a1  Upper 32 bits of a 64-bit shared memory cookie
> > > > + * a2  Lower 32 bits of a 64-bit shared memory cookie
> > > > + * a3  Offset of the struct optee_msg_arg in the shared memory with the
> > > > + *     supplied cookie
> > > > + * a4-6        Not used
> > > > + * a7  Hypervisor Client ID register
> > > > + *
> > > >   * Normal return register usage:
> > > >   * a0  Return value, OPTEE_SMC_RETURN_*
> > > >   * a1-3        Not used
> > > > @@ -154,6 +171,10 @@ struct optee_smc_call_get_os_revision_result {
> > > >  #define OPTEE_SMC_FUNCID_CALL_WITH_ARG OPTEE_MSG_FUNCID_CALL_WITH_ARG
> > > >  #define OPTEE_SMC_CALL_WITH_ARG \
> > > >         OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_ARG)
> > > > +#define OPTEE_SMC_CALL_WITH_RPC_ARG \
> > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_RPC_ARG)
> > > > +#define OPTEE_SMC_CALL_WITH_REGD_ARG \
> > > > +       OPTEE_SMC_STD_CALL_VAL(OPTEE_SMC_FUNCID_CALL_WITH_REGD_ARG)
> > > >
