Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98F255E94C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346137AbiF1OnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345951AbiF1OnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:43:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D3411C21;
        Tue, 28 Jun 2022 07:43:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c13so17888883eds.10;
        Tue, 28 Jun 2022 07:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hmiP2nsm7GYKYeBHW+YUJEK/bavjayODZn3LUEPQfU=;
        b=Rg6Ce3D49JXUDLDeRZsgSz+yryqVA8Xki5kW8XtGn3by//+6dHO1GOAcOhbDNzgpwT
         aSztrbpOcnAUsBoPDQ7BV/QEUHC2BeteHolH+41XKkNYsy21dcDJNxo80eFEmFkffm7N
         xrlANZd2gutEao0wMT0i33DgFJ7qVkakqkuIKGzp1apMRQjGaeRIaAUATMXR7WhdJ1pG
         22Ybwmrl96PlHmzzq1U2dt/7mck7yCPOvFY/wTosedx//6dKv/OjQ8DN+UYG+pnrQ3V1
         CF2MqOlXTIJg0bcE8VwAUgguFd0E7qr/7G9hWBMzW3DOJ4XewARcERMpgO+veI9YZr7q
         Vt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hmiP2nsm7GYKYeBHW+YUJEK/bavjayODZn3LUEPQfU=;
        b=cJAxTUh0tUUGbhQwyJhZ+jroTtgiKpv8GZ1cLr72zTt21wZ0thAXCdDbi1fEdxPYAl
         KTuK3pFf/R3YCV8geSW7/IjC3lDOroTxWZik3cuA6DqzeCu8IkLhvtz0VM5VC3unWHhk
         pwIcHrUtE1DJeZpswz/NRcO30b8Et9icPEKFIMiU/f8vAHVIzGDJ6a5571OD/RnU1f6g
         6R1xWglYMRkqSaksXjZ8/pIrHxZ0ALhpj2QQB3f/BB7V/AB+4+wQj0BFsCAr/3oDtZTc
         AK/WTs877bZNDO75D4FMAAOPI93kWILWK6YYf4VFBc+6jCepl6E8xQ52D6XyzvF1PymK
         g9CA==
X-Gm-Message-State: AJIora++m7SwZf6S972xuWz4FAbtgC03pkzR3T2yHe5KGXCLhLIkLYTD
        spBJx6Ki0hmpl5svF2wbXDPtKDcUf2szI8LRb/r8IL+lm6Q=
X-Google-Smtp-Source: AGRyM1v3Zrmhh/ktA0MyQ64G0CINBj/oLTnBPPFjZQDaHSTrK7ZqnxVdUuVe2HWrTrfrPe56zqLklI36n15HTP7diSA=
X-Received: by 2002:a05:6402:50ce:b0:435:9249:dfe9 with SMTP id
 h14-20020a05640250ce00b004359249dfe9mr23490212edb.310.1656427386662; Tue, 28
 Jun 2022 07:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656409369.git.mchehab@kernel.org> <0129fa0ffb8d418ab66f2ab0f1d525cb49f01f75.1656409369.git.mchehab@kernel.org>
In-Reply-To: <0129fa0ffb8d418ab66f2ab0f1d525cb49f01f75.1656409369.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jun 2022 10:42:54 -0400
Message-ID: <CADnq5_Ps_Pp1tzroPh6VwDsaBP-q6bLeaap4159S5BkSzhK1Hg@mail.gmail.com>
Subject: Re: [PATCH 12/22] drm: gpu_scheduler: fix a kernel-doc warning
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>
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

On Tue, Jun 28, 2022 at 5:46 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> The dev field was not documented:
>
>         include/drm/gpu_scheduler.h:463: warning: Function parameter or member 'dev' not described in 'drm_gpu_scheduler'
>
> Document it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>


Generally in the drm tree we use / rather than : in the patch titles.  E.g.,

drm/scheduler: fix a kernel-doc warning

With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
>
>  include/drm/gpu_scheduler.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index addb135eeea6..c7c487e0c40e 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -435,6 +435,7 @@ struct drm_sched_backend_ops {
>   * @_score: score used when the driver doesn't provide one
>   * @ready: marks if the underlying HW is ready to work
>   * @free_guilty: A hit to time out handler to free the guilty job.
> + * @dev: pointer to struct device.
>   *
>   * One scheduler is implemented for each hardware ring.
>   */
> --
> 2.36.1
>
