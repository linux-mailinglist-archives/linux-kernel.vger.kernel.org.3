Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384334BFF00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiBVQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:40:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0D160412
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:40:32 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id x193so15188778oix.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p40txYoRuDqRToAk//92DsV14CqomtL3Q8ARQVWa/nE=;
        b=TkCFnrgW0aoLHODg9trdPkzSCZhWdz2TpEfAoMCyxt+YUGogRXWkGP51I4Pvac+mW1
         lDSXdMyHaAnGC5BFOVYuGq7XQ0L9Smf8ey4INkOhItVXkekZQqk2BYpaX7elAkS/R01i
         nF3Gj41+2U3ukwABWrB0UaoXZNcF5TSffK7YT4AF2nHAty6DEVRQ6OC6PHihbR8rjd4w
         z914Z2jKY2lAuzRd6z6xcm178A7g9Liup+3zN+pYqHCqbt4NLhBY7+Rz7RUmhfp3oY7p
         BGdY6U+9i774sAXJ1GNG0907qbMtwmq3lVw8AtF0fjTJuBwRmZigbZANGbyr5vFz6vRk
         3V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p40txYoRuDqRToAk//92DsV14CqomtL3Q8ARQVWa/nE=;
        b=dmhWmlFuDUHaeXQoycMcOZ/hUXTL8ozlFSPP0xte0kpTu4DSGZox1Pq5Ycxz3s4/ZX
         y72FUAHB3GSfaPbEL6dlmbrXxGgDH9FD8ZN1WyU0mZ/1SRahIBDo3RbVDe962tLUXn2f
         /5P6lVLHVpfSzcP3k7sOCL7ogbFFW577z1uFzXxPPbigQwj8OydMmgq6SDcMRVbXoGUW
         AvakiTFFjxHxPwCYEt2UUbu8z5fjYtv14ja4pss3ElcRb1YWqBqybRvHBP9m2UkZAjEE
         pNTZK+McEsBTeLcz1fhB0wbOmjS6neg3EjBBAW8NBYoxEhYMl6kOg/TVLPJTi/EPwGZ+
         ipaQ==
X-Gm-Message-State: AOAM532ja3kO3eCzxHp3XLcWJY6f2HJ6OvchHdWYfbGthYzAzRNaLIp9
        acITwlq2DumPLT+OUJFRuqZTiES6SRwBU8w7SuI=
X-Google-Smtp-Source: ABdhPJzGgNDMe4B8iHx1OozJUpsE/fOo2XJZsl0TfO1F2smK9orBVi+gBIiiqvVg+AvsVwgn36rMJ9ruAYaTFI7pEXw=
X-Received: by 2002:a05:6808:612:b0:2d5:1c6a:db4 with SMTP id
 y18-20020a056808061200b002d51c6a0db4mr2488935oih.199.1645548031784; Tue, 22
 Feb 2022 08:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-9-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-9-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:40:20 -0500
Message-ID: <CADnq5_MqzkkNaXRuEqx8oCdF=zL9GgAWF_UNR=21BO4MaojydA@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/amd/display: Remove unused variable
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
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

On Tue, Feb 22, 2022 at 8:18 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Remove the variable clamshell_closed from the function
> dcn10_align_pixel_clocks.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2063:=
7:
> warning: variable 'clamshell_closed' set but not used
> [-Wunused-but-set-variable]
>     bool clamshell_closed =3D false;
>          ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 8dc1afc03961..559aa45f27e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2060,14 +2060,11 @@ static int dcn10_align_pixel_clocks(struct dc *dc=
, int group_size,
>         uint32_t embedded_pix_clk_100hz;
>         uint16_t embedded_h_total;
>         uint16_t embedded_v_total;
> -       bool clamshell_closed =3D false;
>         uint32_t dp_ref_clk_100hz =3D
>                 dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk=
_khz*10;
>
>         if (dc->config.vblank_alignment_dto_params &&
>                 dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk=
) {
> -               clamshell_closed =3D
> -                       (dc->config.vblank_alignment_dto_params >> 63);
>                 embedded_h_total =3D
>                         (dc->config.vblank_alignment_dto_params >> 32) & =
0x7FFF;
>                 embedded_v_total =3D
> --
> 2.35.1
>
