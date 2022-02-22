Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1184C4BFF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiBVQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:41:41 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE2C168094
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:41:15 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id r41-20020a4a966c000000b0031bf85a4124so18394595ooi.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YXHD+C0/B8yXZE8EfrgFtwcPwJgyLlmaD7cEYGEmRMM=;
        b=fuBlPcCzxrvT7+ShgM3+W3qsp2u2V09DJmwqNLjX5fLhy8dc8j6/w2JhloLbmKInG8
         XNqQmB8Rp+vR7/XvSAScTjH/URtFM43zt8LOmtmew8O5k5Y6dhZ1Dp/ePsMeph62HmWB
         eurPiPNpYGp+qmwdrBhTqfwOCdl26C3gAd5+ayQ8HL6xO/tLZ/CNHzfatDwwpw8/if/d
         ZVkgN14V5KAxCaesOfAUhsGGP8cUDJHD/d979cQFm8yTuVxSXW5Cl7Jl0wov3NwNVOET
         YT2rO3Xdq+qTv1ItNrlgA7CYu/z48farfnqcgHkAIfwu0gYbGSRd98id1a3OtbiFR+Q0
         EQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YXHD+C0/B8yXZE8EfrgFtwcPwJgyLlmaD7cEYGEmRMM=;
        b=0AGWU3q6yDG/ptJYUm+rJZcxZSvXIHGR+4NP4mA0Mx9VGT58ro5nCZLtRGsian3Dho
         g4PJYj13ea/rRu7E90UYILc+t/BKuVlQOPzGTmqTTcLwSNCQm+1M7IUhYSYDP4a9GHL6
         eVssNLL/v8GvgsZTiAu7ntRuJLSPPEDGwyb5EIuVIcuQbtbpdGEAYJx1JspekN/68euR
         +tVH760f6WZlwZwY8g/F/Rs1mgF1oUupJsXdUgwynvSRlz4PDX9+hWbVaLzrT1M0InjY
         68dpeqho8qA+410unz5Ayd9ZvVaooao0svRWc1m4bQupUhioxaLQedYwUDYdPSNFuK83
         SmFA==
X-Gm-Message-State: AOAM531LRZYKDV0b/ScT58aR2RjzNcpNSGqR3ZroVQX4PpNe+qq+IvS9
        bE5eGjCyHefzy7MVqY247ZqEx35idRd2fPvFWvw=
X-Google-Smtp-Source: ABdhPJya4bay6XYFIZCyMsuysyg0pIii92FwYXZtsMNZ0psrVz6aeSWA23ZVot6d/3GAmeGPNEphCTWbuu8Dw2gDNWA=
X-Received: by 2002:a05:6870:3e0d:b0:d3:fe6d:57c3 with SMTP id
 lk13-20020a0568703e0d00b000d3fe6d57c3mr2042169oab.225.1645548075325; Tue, 22
 Feb 2022 08:41:15 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-10-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-10-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:41:04 -0500
Message-ID: <CADnq5_O-LmQ3qD7p0bHHhcc7BRpExahhtg9d4dcPx1_x3pDzUw@mail.gmail.com>
Subject: Re: [PATCH 09/10] drm/amd/display: Add missing prototypes to dcn201_init
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
> Include the header with the prototype to silence the following clang
> warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c:127:6:
> warning: no previous prototype for function 'dcn201_hw_sequencer_construc=
t'
> [-Wmissing-prototypes]
>     void dcn201_hw_sequencer_construct(struct dc *dc)
>          ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/driver=
s/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
> index f1f89f93603f..1826dd7f3da1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
> @@ -27,6 +27,7 @@
>  #include "dcn10/dcn10_hw_sequencer.h"
>  #include "dcn20/dcn20_hwseq.h"
>  #include "dcn201_hwseq.h"
> +#include "dcn201_init.h"
>
>  static const struct hw_sequencer_funcs dcn201_funcs =3D {
>         .program_gamut_remap =3D dcn10_program_gamut_remap,
> --
> 2.35.1
>
