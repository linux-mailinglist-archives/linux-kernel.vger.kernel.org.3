Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE54DAD76
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354878AbiCPJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348909AbiCPJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:28:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BC463500
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:27:09 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 17so2308140lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQMz0PwakWnU4nM9DU6PqzQRcq2dQ0VoNHu+lLX1c14=;
        b=KXujradAyodaT/eW4V8+sCOMQX84gd8jUBVuBF9E/iet2piDcysuGbvh3RMrEOy3MY
         pDURn/nNdVBoIekFf1eDeomV1vs2UEUGU36UTniT96G92j5Xlqz6t7k1XKY4FJ2jxjFi
         8ZaPvl8fpYvXOGpsA7OzbcDjfscgY/6UYIzxgkVQnrGN7J8pke+3yY+aTuHXpz5LntO2
         PnRVW2MdDRtoijEG3wTf33fPuczn/wRigDSwvIGQIGywi5jrC3MTOZ6QRmcS7e/Vc4fs
         m8N23mWAGht2vZVDwUS/vJvI9xKkwE+MBrceUWr+hf5hoTFHqBT6gUNznpPjbTMN3WnZ
         C5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQMz0PwakWnU4nM9DU6PqzQRcq2dQ0VoNHu+lLX1c14=;
        b=F0w2D++FEhHUF7PzdmmPblX0zVd5yLLx7LnstNIz8bsXE+m1iSIxDjVja7ZasB6cE1
         x/IwZteBI5g5AC0PW4lcKiYNOAzQqQGdydF9EQMxJehnOcub+byWcPCUxgz9+KPO5r+5
         5OPmaFAzZZfPMxgEYAriDnkft8AAMPdJA2f1i85kub3BMs/0ZBybaMRqfFLiXT7MWzjJ
         TZU2FaIaiIZ88iw3G2RJK7Lvznfhe9Gv1r7coQJb79X2Z4ilX5TTlMqDB7ZJvxw+WZ+X
         Txfup5eI6OBef39lInbcPbX+/82RY4X7F8klhmNjIeWxdGxhiP2vrR+IQUoPabO4XgVM
         MrMw==
X-Gm-Message-State: AOAM533q6fdZ2YX/4p6e8t4YADYpaAG17+yQN7gsxOX1IGqiwxMojwKR
        mfmi58ROytmB6qeGfFm3aIWYbQ==
X-Google-Smtp-Source: ABdhPJwyx46Bn7lleEE7k7ELGqElPeOK9DhK3ss1el5t4XQBTa/AQp+vweMSzT37vYNbeOVCi1Pang==
X-Received: by 2002:a05:651c:50a:b0:246:74cb:2222 with SMTP id o10-20020a05651c050a00b0024674cb2222mr20687451ljp.484.1647422827285;
        Wed, 16 Mar 2022 02:27:07 -0700 (PDT)
Received: from jade (h-79-136-84-253.A175.priv.bahnhof.se. [79.136.84.253])
        by smtp.gmail.com with ESMTPSA id v5-20020ac25b05000000b00448c88374aasm21204lfn.27.2022.03.16.02.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:27:06 -0700 (PDT)
Date:   Wed, 16 Mar 2022 10:27:05 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/3] optee: add FF-A capability
 OPTEE_FFA_SEC_CAP_ARG_OFFSET
Message-ID: <20220316092705.GB2535470@jade>
References: <20220301194830.3557578-1-jens.wiklander@linaro.org>
 <20220301194830.3557578-3-jens.wiklander@linaro.org>
 <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFA6WYNj_onTOtETKTLTGG6=GYHMDvty90KftLkfEz_v7nZx9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 02:33:26PM +0530, Sumit Garg wrote:
> On Wed, 2 Mar 2022 at 01:18, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds the secure capability OPTEE_FFA_SEC_CAP_ARG_OFFSET to indicate that
> > OP-TEE with FF-A can support an argument struct at a non-zero offset into
> > a passed shared memory object.
> >
> 
> It isn't clear to me why FF-A ABI requires this capability.
> shm->offset should be honoured by default, if it isn't then it's a
> bug.

Yes, there was a bug in secure world when using a non-zero offset. So
far the driver has always used a zero offset that's why it hasn't been
caught earlier.

It's not a serious bug, but it might be quite hard to track down. This
is of course fixed now, but there is a window where it can be triggered.

So in order to spare FF-A developers this problem I'm making a non-zero
offset an extension guarded by a capability bit. Even though this is an
ABI change it's in practice not since it has been unused and not working
as expected.

The next commit will start using non-zero offsets if supported, so this
will change to become a problem (if left unchecked) in the window
mentioned above.

> AFAIK, FF-A is currently still in its early stages so it
> shouldn't be that hard to fix bugs in the ABI.

Starting from the kernel release (v5.16) where FF-A support in this
driver was merged the ABI is supposed to be stable.

Thanks,
Jens

> 
> -Sumit
> 
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c   | 17 +++++++++++++++--
> >  drivers/tee/optee/optee_ffa.h | 12 +++++++++++-
> >  2 files changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 7686f7020616..cc863aaefcd9 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -615,12 +615,21 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
> >                 .data0 = OPTEE_FFA_YIELDING_CALL_WITH_ARG,
> >                 .data1 = (u32)shm->sec_world_id,
> >                 .data2 = (u32)(shm->sec_world_id >> 32),
> > -               .data3 = shm->offset,
> > +               .data3 = 0,
> >         };
> >         struct optee_msg_arg *arg;
> >         unsigned int rpc_arg_offs;
> >         struct optee_msg_arg *rpc_arg;
> >
> > +       /*
> > +        * The shared memory object has to start on a page when passed as
> > +        * an argument struct. This is also what the shm pool allocator
> > +        * returns, but check this before calling secure world to catch
> > +        * eventual errors early in case something changes.
> > +        */
> > +       if (shm->offset)
> > +               return -EINVAL;
> > +
> >         arg = tee_shm_get_va(shm, 0);
> >         if (IS_ERR(arg))
> >                 return PTR_ERR(arg);
> > @@ -678,6 +687,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
> >
> >  static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> >                                     const struct ffa_dev_ops *ops,
> > +                                   u32 *sec_caps,
> >                                     unsigned int *rpc_param_count)
> >  {
> >         struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
> > @@ -694,6 +704,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
> >         }
> >
> >         *rpc_param_count = (u8)data.data1;
> > +       *sec_caps = data.data2;
> >
> >         return true;
> >  }
> > @@ -777,6 +788,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         struct tee_device *teedev;
> >         struct tee_context *ctx;
> >         struct optee *optee;
> > +       u32 sec_caps;
> >         int rc;
> >
> >         ffa_ops = ffa_dev_ops_get(ffa_dev);
> > @@ -788,7 +800,8 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> >         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
> >                 return -EINVAL;
> >
> > -       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &rpc_param_count))
> > +       if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,
> > +                                    &rpc_param_count))
> >                 return -EINVAL;
> >
> >         optee = kzalloc(sizeof(*optee), GFP_KERNEL);
> > diff --git a/drivers/tee/optee/optee_ffa.h b/drivers/tee/optee/optee_ffa.h
> > index ee3a03fc392c..97266243deaa 100644
> > --- a/drivers/tee/optee/optee_ffa.h
> > +++ b/drivers/tee/optee/optee_ffa.h
> > @@ -81,8 +81,16 @@
> >   *                   as the second MSG arg struct for
> >   *                   OPTEE_FFA_YIELDING_CALL_WITH_ARG.
> >   *        Bit[31:8]: Reserved (MBZ)
> > - * w5-w7: Note used (MBZ)
> > + * w5:   Bitfield of secure world capabilities OPTEE_FFA_SEC_CAP_* below,
> > + *       unused bits MBZ.
> > + * w6-w7: Not used (MBZ)
> > + */
> > +/*
> > + * Secure world supports giving an offset into the argument shared memory
> > + * object, see also OPTEE_FFA_YIELDING_CALL_WITH_ARG
> >   */
> > +#define OPTEE_FFA_SEC_CAP_ARG_OFFSET   BIT(0)
> > +
> >  #define OPTEE_FFA_EXCHANGE_CAPABILITIES OPTEE_FFA_BLOCKING_CALL(2)
> >
> >  /*
> > @@ -112,6 +120,8 @@
> >   *       OPTEE_MSG_GET_ARG_SIZE(num_params) follows a struct optee_msg_arg
> >   *       for RPC, this struct has reserved space for the number of RPC
> >   *       parameters as returned by OPTEE_FFA_EXCHANGE_CAPABILITIES.
> > + *       MBZ unless the bit OPTEE_FFA_SEC_CAP_ARG_OFFSET is received with
> > + *       OPTEE_FFA_EXCHANGE_CAPABILITIES.
> >   * w7:    Not used (MBZ)
> >   * Resume from RPC. Register usage:
> >   * w3:    Service ID, OPTEE_FFA_YIELDING_CALL_RESUME
> > --
> > 2.31.1
> >
