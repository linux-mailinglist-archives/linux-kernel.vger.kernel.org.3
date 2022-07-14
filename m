Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C085752D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiGNQch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiGNQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:32:35 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133365D52
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:32:34 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ez10so4330744ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MQQLZDnraOk05TyTJ/NoEzLsjvMb4sYNTl3FKSVedI4=;
        b=U61SpsT0ra/rbLywhQDkYlbjqbRoXP1i4GeZrk7HnehHSPteHyg0kVgayq7z7h0uDE
         5HyRR8iWr2x17yrbhq1QVw4iafAZSAvwAxHc92+eFL0LcHD6aa3cGrv8gk9g4v81nv0s
         tD9UOZP1hGyyF+HhL4SZID9zQM+ov8Rh2dtoaRMO7pcetZW7qQ4UZKXZflTGURUpokhW
         fm8fBVJ2chR0XPfx2lNK/C/zt9OKEbKCSfUp3RUt2bAmchb84H0YwmiE+Leum2HOsK5o
         /hqXTxNonqdUJgTAlIQ5KslZtQ7lkFvOhD1cUwK1BOFEjJvtXJcVR4BnfcilWJca0AJL
         TNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MQQLZDnraOk05TyTJ/NoEzLsjvMb4sYNTl3FKSVedI4=;
        b=CDFeQkucj/UxyCH/1/A0Ox9ONTH9nhqK1fOSQ7Q6cFsejQBZRuXI3LQyils4nhGq/8
         5Nv936597fCLOxXiqdo1v+B87OZUGU8/pG47t9uKuxYoGu0yKdLuiM4iX+fVJfx/xGqT
         0R9oE0E9lc//+1lEfBdnuM3YERy6iQwIvHeiCjIhyIvFAGlB4TX7oglE7BVw1a+7yKaq
         iBbZp/1s5+yz1numMLpSYPPOxVQv4Lcfm4IrjJXwgvvu6nQPiEoL+iIzYrO4jR7sbBR1
         Vv3VqnWW3x4rsxdxVHz0w/mA3LSTNRDeOo7ADqFVO0uEqs3gZ8YCIRcR6wfmMjJ2Aei4
         okDg==
X-Gm-Message-State: AJIora/uVaUDyRU9L+jMrRTopu8Wd5RytjY7tmEEQhDy4xOqOLrE2Rzf
        /gWEYmUPcGG/PLv3+qGe/6t+pFwZ8HN3mtKE0fY=
X-Google-Smtp-Source: AGRyM1vlytD0v6dn3HOd2gXV76HLjUKojSLRL55b5g8HIpRWvreWcklT0NDIWnKYlVq3tnGI7bQPKr+Z6CDJMyg1aWU=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr9621924ejk.658.1657816353203; Thu, 14
 Jul 2022 09:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220714134950.9564-1-andrealmeid@igalia.com>
In-Reply-To: <20220714134950.9564-1-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jul 2022 12:32:21 -0400
Message-ID: <CADnq5_MzH14zJnt0vj1q+dL7D=eVNz-s5WW7xYDQyHD6QANXSQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Clarify asics naming in Kconfig options
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

On Thu, Jul 14, 2022 at 9:50 AM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Clarify which architecture those asics acronyms refers to.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 74a8105fd2c0..7777d55275de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -4,7 +4,7 @@ config DRM_AMDGPU_SI
>         depends on DRM_AMDGPU
>         help
>           Choose this option if you want to enable experimental support
> -         for SI asics.
> +         for SI (Southern Islands) asics.
>
>           SI is already supported in radeon. Experimental support for SI
>           in amdgpu will be disabled by default and is still provided by
> @@ -16,7 +16,8 @@ config DRM_AMDGPU_CIK
>         bool "Enable amdgpu support for CIK parts"
>         depends on DRM_AMDGPU
>         help
> -         Choose this option if you want to enable support for CIK asics.
> +         Choose this option if you want to enable support for CIK (Sea
> +         Islands) asics.
>
>           CIK is already supported in radeon. Support for CIK in amdgpu
>           will be disabled by default and is still provided by radeon.
> --
> 2.37.0
>
