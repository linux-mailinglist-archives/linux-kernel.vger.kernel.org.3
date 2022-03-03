Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8585E4CC272
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbiCCQSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiCCQSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:18:07 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B8198EF8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:17:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cx5so4969826pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wNHdI8Qs0iO8nGl1EMp9COLDywjh+H/qv94rCAasCRI=;
        b=f5cbZWp0l7V5NSC/zdO1vxrF3W7wwYFHKtO8cOCwJaIDiB6EMzBYBsj1g6UWsRfLB4
         aX1Uhevud6cITd1Z+d/TsvEbBYDd2fnfSH2cHOBQdRVrYGrTbq8thToFnuO46RA6Nybt
         hrtZ+n8mPcu9Dw/9i/Nfd40xkBTM0jFyQGyqVjkeya/O/FoNCdt5yq+Qct21QYxrQBrl
         ABzhjQ4qMXdxAzqEIhVt9BwtGKxSNSTuPWHd4BccpkheqvEWvMEgQEh/g+EWaqLl2M+8
         A9FQg4M80zo269WKPnX6UD67fSjA/ZTF1dF6VIBhzRatTW/U9ofK8sYf1kA/qH9dQbqx
         tJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wNHdI8Qs0iO8nGl1EMp9COLDywjh+H/qv94rCAasCRI=;
        b=dqQ+6ZMAvIGiCST0ZzkUJIbROvKvUbuP22KcCsatJoYX+tzO1wS4f4jsGUcVPWXDcD
         samHz/B00va68XFSMRZ/DyCfdy4hIA8crQmOn8qIfpUlCG8C7/zjIhDId1c9ITCD1Xgs
         kFJPn4yl5RJy8oNJAAY8xKuu7sInNvue62b4cr/nko2IuZ6pBMhquyAFnHRWkObqXeat
         fKVRNmPYgSii2U/Q6K1e+yXTK0o+jmjbVValNwUXf6uDknl13Gv8wa2tU6O614akN+om
         YRiuGW2UuMcXv6Bff/Uj5bIGefuUD7/rSUsgsmaNFQp/PoenqAyl1K72rJ062LYu2gIr
         hcjQ==
X-Gm-Message-State: AOAM530Qaf9/cU5R9qfROQwywRb+tznvMcQCpYUTBaBrNZrlJJrKc6bT
        7anunl68e++ezUuhNmHn3ChjZpf+uOul9g7ytY7+Dg==
X-Google-Smtp-Source: ABdhPJwPEu+6ywb/M5QvzZRCzi2yTouSdW4zQSvgUsZL0viME6YTiy6qZ4sf58hiUdsCnAuMA9/GDRf7cqf6M9ysSOo=
X-Received: by 2002:a17:903:24f:b0:14f:73fa:2b30 with SMTP id
 j15-20020a170903024f00b0014f73fa2b30mr37072357plh.174.1646324239927; Thu, 03
 Mar 2022 08:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20220302150717.11193-1-clement.leger@bootlin.com>
 <CAHUa44H4d2QdXSY5e5VqrGh5sQPhRuFBaBvsy_mTErQQmxJo6w@mail.gmail.com> <20220303091555.7a0298b9@fixe.home>
In-Reply-To: <20220303091555.7a0298b9@fixe.home>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 3 Mar 2022 17:17:08 +0100
Message-ID: <CAHUa44F8HLwd2b0sYR0ELJucEe3-__gSKwVigsr7Oig+vqiTTA@mail.gmail.com>
Subject: Re: [PATCH] rtc: optee: add RTC driver for OP-TEE RTC PTA
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 3, 2022 at 9:17 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@bootl=
in.com> wrote:
>
> Le Thu, 3 Mar 2022 08:35:17 +0100,
> Jens Wiklander <jens.wiklander@linaro.org> a =C3=A9crit :
>
> Hi Jens, looks like you forgot to "Reply All".

You're right.

>
> > > +
> > > +       /* Fill invoke cmd params */
> > > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> > > +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> > > +       param[0].u.memref.shm_offs =3D 0;
> > > +
> > > +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> > > +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> >
> > if (ret < 0 || inv_arg.ret) looks easier to me. Please check the patch
> > with checkpatch --strict do catch all these and other trivial checks.
>
> Acked, the rng-optee driver might not be a good starting point :/ Will
> check that.
>
> > > +static int optee_rtc_read_info(struct device *dev, struct rtc_device=
 *rtc,
> > > +                              u64 *features)
> > > +{
> > > +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> > > +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> > > +       struct tee_param param[4] =3D {0};
> > > +       struct optee_rtc_info *info;
> > > +       struct optee_rtc_time *tm;
> > > +       int ret =3D 0;
> > > +
> > > +       inv_arg.func =3D TA_CMD_RTC_GET_INFO;
> > > +       inv_arg.session =3D priv->session_id;
> > > +       inv_arg.num_params =3D 4;
> > > +
> > > +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> > > +       param[0].u.memref.size =3D sizeof(*info);
> > > +       param[0].u.memref.shm_offs =3D 0;
> > > +
> > > +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> > > +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > +               dev_err(dev, "TA_CMD_RTC_GET_RNG_INFO invoke err: %x\=
n",
> > > +                       inv_arg.ret);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       info =3D tee_shm_get_va(priv->entropy_shm_pool, 0);
> > > +       if (IS_ERR(info)) {
> > > +               dev_err(dev, "tee_shm_get_va failed\n");
> > > +               return PTR_ERR(info);
> > > +       }
> > > +
> > > +       if (param[0].u.memref.size < sizeof(*info)) {
> > > +               dev_err(dev, "Invalid read size from OPTEE\n");
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       if (info->version !=3D RTC_INFO_VERSION) {
> > > +               dev_err(dev, "Unsupported information version %llu\n"=
,
> > > +                             info->version);
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       *features =3D info->features;
> > > +
> > > +       tm =3D &info->range_min;
> > > +       rtc->range_min =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_m=
day,
> > > +                                 tm->tm_hour, tm->tm_min, tm->tm_sec=
);
> > > +       tm =3D &info->range_max;
> > > +       rtc->range_max =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_m=
day,
> > > +                                 tm->tm_hour, tm->tm_min, tm->tm_sec=
);
> >
> > If this is the only thing we're going to do with the returned min and
> > max, how come this wasn't done on the OP-TEE side already? Without
> > these large structs we could have defined an ABI without the need for
> > shared memory.
>
> mktime64 converts the time range to the number of seconds elapsed since
> 1970. I thought it would be better not to assess anything about the way
> the time is stored on OP-TEE side and thus return the full time struct.
> If you think it's acceptable to suppose that, then, we can still switch
> to using timestamps as the ABI with OP-TEE RTC PTA. The same could be
> done to get/set time if needed in this case.

This is a bit more complicated than I first thought. The proposed ABI
is fine from my point of view.

Cheers,
Jens

>
> > > +
> > > +static int optee_rtc_probe(struct device *dev)
> > > +{
> > > +       struct tee_client_device *rtc_device =3D to_tee_client_device=
(dev);
> > > +       struct tee_ioctl_open_session_arg sess_arg;
> > > +       struct tee_shm *entropy_shm_pool =3D NULL;
> > > +       int ret =3D 0, err =3D -ENODEV;
> >
> > There is generally no need to initialize these here.
> >
> > > +       struct optee_rtc *priv;
> > > +       struct rtc_device *rtc;
> > > +
> > > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > > +
> > > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       rtc =3D devm_rtc_allocate_device(dev);
> > > +       if (IS_ERR(rtc))
> > > +               return PTR_ERR(rtc);
> > > +
> > > +       /* Open context with TEE driver */
> > > +       priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, =
NULL,
> > > +                                              NULL);
> > > +       if (IS_ERR(priv->ctx))
> > > +               return -ENODEV;
> > > +
> > > +       /* Open session with rtc Trusted App */
> > > +       memcpy(sess_arg.uuid, rtc_device->id.uuid.b, TEE_IOCTL_UUID_L=
EN);
> >
> > Perhaps uuid_copy() would be better.
>
> Ok, I will use export_uuid() then.
>
> >
> > > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > > +       sess_arg.num_params =3D 0;
> > > +
> > > +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> > > +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> > > +               dev_err(dev, "tee_client_open_session failed, err: %x=
\n",
> > > +                       sess_arg.ret);
> > > +               err =3D -EINVAL;
> > > +               goto out_ctx;
> > > +       }
> > > +       priv->session_id =3D sess_arg.session;
> > > +
> > > +       entropy_shm_pool =3D tee_shm_alloc(priv->ctx,
> > > +                                        sizeof(struct optee_rtc_info=
),
> > > +                                        TEE_SHM_MAPPED | TEE_SHM_DMA=
_BUF);
> >
> > tee_shm_alloc() is about to be removed. Please rebase on
> > https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=3Dtee=
-shm-for-v5.18
>
> Acked.
>
> --
> Cl=C3=A9ment L=C3=A9ger,
> Embedded Linux and Kernel engineer at Bootlin
> https://bootlin.com
