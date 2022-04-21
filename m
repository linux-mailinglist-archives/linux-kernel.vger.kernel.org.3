Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A950A207
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389122AbiDUOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357522AbiDUOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:21:45 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7753C4BF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:18:56 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-e5e8523fcbso5503513fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6DcgaBgifbl98HwTQyTz4opgdKW16OPxOhCg6ox3bw=;
        b=akZH1M9X1Mq0wvuSic/T+8WK0gaoybBnq14OO+c+2tuwmuNrFE/Tz1feJvZ4HpbwtI
         NZ49Dc9Owb5RUujQIA47u/DGtnwCpY/5weTW/7vDTtfD3g+GENCOi/neHowgA7im+dTh
         w7pTm5p5Iy+pIjTHy4XRTiP1Adthk4fO2oGUL5K9CNtmt/1k43Eke5y0ZvlacYlP95lP
         EWnK6lnz/IP8J0Gp3g2S1B7QjrptJgveyM/mzQSQ3EOV4piUVeYgYjSgMLPca87vwUMI
         4sSBwGpSAb80sXMEMvjVideV7RceGWxOy8SutDao5yiyVAFTNPwqxERvGnOt3kakP/kG
         z3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6DcgaBgifbl98HwTQyTz4opgdKW16OPxOhCg6ox3bw=;
        b=dZUMF0/uWBg66QCsoXh78/5ZMKfasd9ljnBHfrhGzZ7WaNcycirhBfWHtC6N1x0CRd
         9yV3LBH9GtMwyP2sOlRX6k+kr8ulsGJP4KtAxFHyAC2jJRYPCbcgvEQb11hkfxyy0+ln
         pX+ejBcjS8TuE+YUDTz3A1cW5W0KrnsVwhTmZg2dH2ydFHl7IvvSl8D6u/iii2djllsU
         /UeO77mHwIdO4RzqJ/JBL+m2JMoLBbBAfdlDLuXLnX+6lf3WjhRraoZUAzenNXLrFaAE
         um6uas0ewKsw3f01dm8IWrmEhyNsuPrl8T2QGZmHvV03arXy9Ooc0NJPMhCR4K1jRvYa
         RTag==
X-Gm-Message-State: AOAM533RJd0uLJRCM8+eFttE+TkxU4ddHvdwOJHj0WTnGghh+EAcy7O+
        nmhsPu8h5+Y0z+b02JGcVAEuQ7usJeWoEmbp7/A=
X-Google-Smtp-Source: ABdhPJzuZENytfXhDw4gnAPlJURyrJyYpEVhxUavxnPVMpQVwHQL3dxxaZOzCAfQotdDEP6MCIiiT4dbinmfyqR2jCA=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr4071428oap.253.1650550735602; Thu, 21
 Apr 2022 07:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <1650536939-13778-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1650536939-13778-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 21 Apr 2022 10:18:44 -0400
Message-ID: <CADnq5_Of9Z0LV4DFhGcsoeXHdKGXTekntXePufNeZ+LGJ13XxA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove useless code
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Apr 21, 2022 at 6:29 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> aux_rep only memset but no use at all, so we drop it.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 8e814000db62..29e20d92b0bb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -565,13 +565,11 @@ int dce_aux_transfer_raw(struct ddc_service *ddc,
>         struct ddc *ddc_pin = ddc->ddc_pin;
>         struct dce_aux *aux_engine;
>         struct aux_request_transaction_data aux_req;
> -       struct aux_reply_transaction_data aux_rep;
>         uint8_t returned_bytes = 0;
>         int res = -1;
>         uint32_t status;
>
>         memset(&aux_req, 0, sizeof(aux_req));
> -       memset(&aux_rep, 0, sizeof(aux_rep));
>
>         aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
>         if (!acquire(aux_engine, ddc_pin)) {
> --
> 2.7.4
>
