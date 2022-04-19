Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F204507136
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345213AbiDSPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiDSPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:02:03 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8D03B033;
        Tue, 19 Apr 2022 07:59:20 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so17776611fac.7;
        Tue, 19 Apr 2022 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txu5qF77kz021syUspWnSzVq95Qu7gMs2hI1GWgdN0g=;
        b=BDcVCy0mQEGbuXPpCkJme82wpCfSVxCgreSd1AQrcG8cDczRdYp6fo63Zl1UesunPw
         U+7T3oBEdXRDpEg2KWIKa7WShBAA+F6PTR1cIET+TL7hiJpdY5dcimQKuRMq/tT/LXan
         JqOlL1xYoi4+pfxn//1yfmGhfJKw41MR5D28CjSMGWBLL6EcSv7cebg4hlEdqKKDrDKl
         lHBIoE3gp2GlIZeRx8yEJThzNHeVJblMX9/2Dmo0yQ+3xRfcDzAErd6DCNTAISNfsAFw
         II1R2VA/PxqGjA52stjrt2fjgMj1ZAZmf2WHvwt8D3qOCAIPe6DyOldDy9ZLlQGvH95K
         /5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txu5qF77kz021syUspWnSzVq95Qu7gMs2hI1GWgdN0g=;
        b=beoMY7XLA1nNNjmezjyVNsMX/7vdXSPQXxRfwImK3IMig0XwGByuweTo78gpH/LxEm
         igYDk7sniiW33FzTEdB79eLv02CAaUYfxOLLGY2tkTteHgbMGnQri6xkUaFk/lIXGrz/
         pF4O+yty0zU20Rw1souL/Pm5sl5HIfa84fPiGE1yRO76cdcof3ZmUVTQS0CXe/3683eQ
         g5S0T71xNaUso0nYfKyaR1aJR3Y3ECj7sYdaARAM/1eogTTH2KzpR6I0mS99LrVPQp8J
         N7elOVxJL7MGdzRt9VtKQ/kei0pCs6yJ2u6jpQIOEL9JV1Jc7P5gqD7mv2IrFXXQSzn4
         jxAw==
X-Gm-Message-State: AOAM530BdSFgdTg2WIgkRY+wjQk9x0csT0vFSCPt9XUlJ6WN0RKn0MfI
        K+xH7fNdsdlUJrfl1KsSCzO5Rdw3V2NGlTU7DAwTzV/7
X-Google-Smtp-Source: ABdhPJwkeTzLw742f1pLT1h5HcgounlwYPVNsuzflB54s8eFTAPlS5s6EXzaHdH41CdsZRH5FTve/PqKvS145BOY6YE=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr8077760oaa.200.1650380360073; Tue, 19
 Apr 2022 07:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220415195027.305019-1-tales.aparecida@gmail.com> <20220415195027.305019-2-tales.aparecida@gmail.com>
In-Reply-To: <20220415195027.305019-2-tales.aparecida@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Apr 2022 10:59:09 -0400
Message-ID: <CADnq5_O9rV+42=7Lyy7dAwVZkBoxJgmwn0oavzN1pVBmKFLfcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation/gpu: Add entries to amdgpu glossary
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
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

Applied the series with minor fix to capitalize the U in Compute Unit.  Thanks!

Alex

On Fri, Apr 15, 2022 at 3:52 PM Tales Lelo da Aparecida
<tales.aparecida@gmail.com> wrote:
>
> Add missing acronyms to the amdgppu glossary.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1939#note_1309737
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
> ---
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> index 859dcec6c6f9..48829d097f40 100644
> --- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> +++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
> @@ -8,12 +8,19 @@ we have a dedicated glossary for Display Core at
>
>  .. glossary::
>
> +    active_cu_number
> +      The number of CUs that are active on the system.  The number of active
> +      CUs may be less than SE * SH * CU depending on the board configuration.
> +
>      CP
>        Command Processor
>
>      CPLIB
>        Content Protection Library
>
> +    CU
> +      Compute unit
> +
>      DFS
>        Digital Frequency Synthesizer
>
> @@ -74,6 +81,12 @@ we have a dedicated glossary for Display Core at
>      SDMA
>        System DMA
>
> +    SE
> +      Shader Engine
> +
> +    SH
> +      SHader array
> +
>      SMU
>        System Management Unit
>
> --
> 2.35.1
>
