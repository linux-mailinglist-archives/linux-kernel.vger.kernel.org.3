Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549D5070B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353389AbiDSOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353508AbiDSOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:37:53 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A2EB859
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:35:10 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e5e8523fcbso6142071fac.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Y1kTXqtM0V/qhN0BJh+ustQ16GMNyceftqiFoXkOJo=;
        b=LKsrOa3nuP9NAcR8rarfjiNYcdHWNAGtZnJnexbhZXdC2BWsvnu2TlCnxPKl6u5Vj9
         Ve+GfJftnqI6Dw/kI2fvUr1sq+wn+NVcjYTWTM+3PQsmGlonuaOWJW2zsaPsusolhRyb
         Qtx1ps6ipjUss6V5UAEwmrcem2Y7xetfKYPQyGmy71RxKN1MpsWo6SXtKNe1529sbOtK
         VzXmYI9RR/zER2Vb6p1pOjC6VlZH1PGlD1sfA7OqzhCfOYhKosTy3+kJLZgvRsJ8FrvK
         IrBfsnJ05Se7Ng1T6bHk1yWeizt/Yr6RvX8UHUhNi+lD81yGxFSSftfMtsdrDV7w0fNc
         NNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Y1kTXqtM0V/qhN0BJh+ustQ16GMNyceftqiFoXkOJo=;
        b=ZBS5u+/Lte7ZqtAlH7sj/LeoJ8usbNwrQL9bLFtNvwG/BdGi7NhGUEK7AiQwkdNqBy
         vdXnstNHgmclnDNjZ5NCRWRQIUgnE0qUGo0wlQUfg+/qmKtHSwr/NGobkxoXfSbU8vAP
         eakUfAF99G9uBNZaX59sgs+m+boReDUlyranZRBs83Oe/8OLAbNP4gQMCzixmyYid+wR
         +KpIKfSL+RRpTybUsKaeUK8AzYzM43RtuhmDiZgmKLfQuXNEZDY+LXEVc0uOF06WS9EH
         cFXZ0NOBr/WeSy+41FG2WI5zzjOR5+FZLIb8lSp9zXFjGD5lP8WM2dPCSO4koJsYxPtn
         eILA==
X-Gm-Message-State: AOAM530Ta+g1L3TQqudbAsx8d2+s+9IUbedCWxxzgOAbRX+MRdilDiwJ
        ryMErGuyRVWWBQseJQtrCDp3iEXeKzhoscAvSHw=
X-Google-Smtp-Source: ABdhPJylz4Pe9jC88ome39PtLEkLwVqavuFbKl5Z+pnkPi4nxGJ15u5Pjxe998bBVBnUSyvu2UCMWVsYF5ENcONVNUg=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8023506oaa.200.1650378909464; Tue, 19
 Apr 2022 07:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220415182014.278652-1-tales.aparecida@gmail.com>
In-Reply-To: <20220415182014.278652-1-tales.aparecida@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Apr 2022 10:34:58 -0400
Message-ID: <CADnq5_NmOxp08Xf_P1Ljq94O2RYa_Ld4cVRtF=fmRqV_DAgDqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: make hubp1_wait_pipe_read_start() static
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, andrealmeid@riseup.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with minor change to drop the prototype in dcn10_hubp.h.  Thanks!

Alex

On Fri, Apr 15, 2022 at 2:21 PM Tales Lelo da Aparecida
<tales.aparecida@gmail.com> wrote:
>
> It's a local function, let's make it static.
>
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
> index fbff6beb78be..3a7f76e2c598 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
> @@ -1316,7 +1316,7 @@ void hubp1_set_flip_int(struct hubp *hubp)
>   *
>   * @hubp: hubp struct reference.
>   */
> -void hubp1_wait_pipe_read_start(struct hubp *hubp)
> +static void hubp1_wait_pipe_read_start(struct hubp *hubp)
>  {
>         struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
>
> --
> 2.35.1
>
