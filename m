Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4341B55E6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbiF1Oip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiF1Oin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:38:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53FE2873F;
        Tue, 28 Jun 2022 07:38:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ge10so26212567ejb.7;
        Tue, 28 Jun 2022 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2IvGKvL7xHbKgdp4YNJ7+ySjxu0hJFiVWDS9pQpBNk=;
        b=EcBgKNzJYFcIXq77mC+QLh+Q55CV5PEEkCt6SGuIjlr8nNlTqUUyaWmbT2G7JdgDGo
         uqmNvpq2WUhMBOjfHI6TWd2ppwa1SVtYuqKl5UIpiFbVZm942d9kd0oD9QbD3YVgoCSD
         SFlhn29XBVtI//iLY2i1cuSBVYvwyYNunt2R3uw/l8S9q86k09viSPZME21XQ1zy4y86
         Q2WY8QDQlqDnZzIyRjRL1iqIdTAZ6A8Zuu3Uzbis9dyTr9jetyFvOTdzy0Rpznj+FNyN
         RV0y4x/2Byy5dYiaMqeCNu9OaDND630skNeHGfq3IZid5ej14diTDvF7wEaiBx0s8oeS
         kkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2IvGKvL7xHbKgdp4YNJ7+ySjxu0hJFiVWDS9pQpBNk=;
        b=Gz6oiZG5isWe0innBdRZ4KldIunvG5BR0pQnILW+2NQda/iqM2pRHWclUAWJ8GPT6G
         4qxilQhpVYpY4ssch/5s3koDQx0gwsR8yfm4e/4IXKj3by0JAUQoazALXkB9r4ZqU8kT
         Ay1JGSQRtm8VkK3xtJl3F0rcudlgyr71rBa4WOmH/euKnVI25f3QOduwxUq7UdketmBK
         FzeHrzOtA7F7hdPThIlWUUKBFlrA2Zdmx1CY8XeTMrAGgkatIXkPJpIBqRRz4UrvsbJZ
         ELzp1wc5ZQdDi0Ouh9hcgGxOGayjNXlIvTNCXe3Jt9NNgreECXpFbDITZdrVbNrBln0Z
         Ja0w==
X-Gm-Message-State: AJIora9E1+rWLCNTPpv7ESl61TmMNNMfIGHvS0l/3QFBB/vt6DU1MxUL
        5tRSGpcfjkxviEXxCxd8reF9DLKmZkq2z4K3YCs=
X-Google-Smtp-Source: AGRyM1shI3TGX5wshjkJFJrz2mDXSYu4lQcGDUhsZNRYOYlP5MHGbzWtZvb2qfxNCOMOmPZt2NzdiNV9hBqFxBUlu9E=
X-Received: by 2002:a17:907:94cf:b0:726:c81a:f30e with SMTP id
 dn15-20020a17090794cf00b00726c81af30emr5834374ejc.451.1656427121388; Tue, 28
 Jun 2022 07:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656409369.git.mchehab@kernel.org> <3aee446a0e396fe3f338f270746939f6e803a4de.1656409369.git.mchehab@kernel.org>
In-Reply-To: <3aee446a0e396fe3f338f270746939f6e803a4de.1656409369.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 28 Jun 2022 10:38:29 -0400
Message-ID: <CADnq5_OJ=-hNo=Tx1L70sa4hyRx8YD=RMMJ0uEx4QegXDofkJw@mail.gmail.com>
Subject: Re: [PATCH 11/22] drm: amd: amd_shared.h: Add missing doc for PP_GFX_DCS_MASK
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        David Zhang <dingchen.zhang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kenneth Feng <kenneth.feng@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Zhan Liu <zhan.liu@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        David Airlie <airlied@linux.ie>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>
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

Applied.  Thanks!

On Tue, Jun 28, 2022 at 5:46 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
>
> This symbol is missing documentation:
>
>         drivers/gpu/drm/amd/include/amd_shared.h:224: warning: Enum value 'PP_GFX_DCS_MASK' not described in enum 'PP_FEATURE_MASK'
>
> Document it.
>
> Fixes: 680602d6c2d6 ("drm/amd/pm: enable DCS")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH 00/22] at: https://lore.kernel.org/all/cover.1656409369.git.mchehab@kernel.org/
>
>  drivers/gpu/drm/amd/include/amd_shared.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index bcdf7453a403..2e02a6fc1717 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -193,6 +193,7 @@ enum amd_powergating_state {
>   * @PP_ACG_MASK: Adaptive clock generator.
>   * @PP_STUTTER_MODE: Stutter mode.
>   * @PP_AVFS_MASK: Adaptive voltage and frequency scaling.
> + * @PP_GFX_DCS_MASK: GFX Async DCS.
>   *
>   * To override these settings on boot, append amdgpu.ppfeaturemask=<mask> to
>   * the kernel's command line parameters. This is usually done through a system's
> --
> 2.36.1
>
