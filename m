Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7254056724B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiGEPQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiGEPQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:16:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8879C165B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:16:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id li14so285966ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fdWsuH5iWeZPfROujivZGH/Cy5bmhPrXtMLFLUwX49M=;
        b=PxFjmDvc5PYKzenoLJAFdaUHY081Hi2HUvSiiBEZOQ28gnVnyWAnd34JfJWow6qdHR
         pEpuNXXGz8Q7EtExPHAZSMueQV16IbExfYmGJer90err9ileogEQne7e5MVpHHJZAa6R
         E20drhgKycenzCpyfcq/00tSbqqV1Jukhco/lX3x3x7ElS8NmzjeTvxCFBrWISZ4h5Y4
         AmuVHwhImlotcTmOogt7VQITuIjDx9WViEwaCq0VFJz4GBjWLQ9W0sqW7GzC1xyxLX8g
         Ef6pliikCB+8Svqy7+0RwqyFIT6dIBOuRspmrBuj5Bcp/IXqpoRZPu6Kwg05ce9rizPR
         DcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fdWsuH5iWeZPfROujivZGH/Cy5bmhPrXtMLFLUwX49M=;
        b=VROhpbA30+x7h6RWSHHQ06gktZz81LyCYQBncnTeYLWK0Lxx1fHwIIV4Jzaga2Q++O
         dmn9Il5iQuGKBoHtj2FPJRWbC3ApxBgxHzU+DJwqzHU1TYUfU+1IbOXkOf+YL2BT9bY2
         Y2R7tTOmmxXmC8M0RyCLmOc5fsl81z9njadRZEtgNq0lRlEaXOsX/8B0hd28+NNwe0iw
         hO/2hdpxnvzHC6G+0BVLmpZvzafG6JeQjVae/19D21r3yiJl1FhGC7NSfmUBqjtEdRsJ
         RzBHlWzVEqDnYJ8ITO0xaYtCZgXnRVVAKCLDBAMRb+Koo0uCf3tKBubCuIaw8vFUPsyd
         Y9wA==
X-Gm-Message-State: AJIora8vC6xOlWVZ5FMa/KxYjRoEUSHNyGKfo1nadeL+qZXhNeuF7Ak3
        mLHcR4kCETgCUjHf1WP2rSO0egkKmX2qi8aFPgU=
X-Google-Smtp-Source: AGRyM1vFVkwnAPwj8iiYegP0EW/QCymRUera0ZZmUX4II6xXiqox9uPVSU3N5XYK1ay3D+sd3vamxoEckE5PlGwLKxM=
X-Received: by 2002:a17:906:dc93:b0:726:a75b:f60f with SMTP id
 cs19-20020a170906dc9300b00726a75bf60fmr33930346ejc.564.1657034179094; Tue, 05
 Jul 2022 08:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220630185005.908140-1-mairacanal@riseup.net>
In-Reply-To: <20220630185005.908140-1-mairacanal@riseup.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 5 Jul 2022 11:16:07 -0400
Message-ID: <CADnq5_OGBxvr_rkRPKq6KggYR45t-DiKxBwJqvyCLNK9=YtV-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove return value of Calculate256BBlockSizes
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Alex

On Thu, Jun 30, 2022 at 2:50 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> The function Calculate256BBlockSizes always returns true, regardless of
> the parameters. As any file checks the return of the function, this
> commit changes the return value to void.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c | 3 +--
>  drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> index 2676710a5f2b..ed23c7c79d86 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
> @@ -957,7 +957,7 @@ static void recalculate_params(
>         }
>  }
>
> -bool Calculate256BBlockSizes(
> +void Calculate256BBlockSizes(
>                 enum source_format_class SourcePixelFormat,
>                 enum dm_swizzle_mode SurfaceTiling,
>                 unsigned int BytePerPixelY,
> @@ -995,7 +995,6 @@ bool Calculate256BBlockSizes(
>                 *BlockWidth256BytesY =3D 256 / BytePerPixelY / *BlockHeig=
ht256BytesY;
>                 *BlockWidth256BytesC =3D 256 / BytePerPixelC / *BlockHeig=
ht256BytesC;
>         }
> -       return true;
>  }
>
>  bool CalculateMinAndMaxPrefetchMode(
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/driv=
ers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> index 10ff536ef2a4..25a9a606ab6f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
> @@ -169,7 +169,7 @@ bool get_is_phantom_pipe(struct display_mode_lib *mod=
e_lib,
>                 unsigned int pipe_idx);
>  void PixelClockAdjustmentForProgressiveToInterlaceUnit(struct display_mo=
de_lib *mode_lib);
>
> -bool Calculate256BBlockSizes(
> +void Calculate256BBlockSizes(
>                 enum source_format_class SourcePixelFormat,
>                 enum dm_swizzle_mode SurfaceTiling,
>                 unsigned int BytePerPixelY,
> --
> 2.36.1
>
