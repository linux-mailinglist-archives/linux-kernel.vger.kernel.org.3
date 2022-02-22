Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE114BFEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiBVQdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbiBVQcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:32:50 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83B09E579
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:32:24 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id p15so15116342oip.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aSdxbzUUBFyhsvNwdRhnX3Mec7pbpC71E8zAtuMoNSw=;
        b=FX0sGlOaHKUnWtxEV6HYKy2nafu8fuljFBoACNBVftni/Q58eaCkncHFWGp2OrD2C7
         SDoNGW9popiT9/vht4gT9Bxb0ur4WAPXseAppf5T46OFdmKkpfESNAT2bFZ+FzWYushi
         Cup7BrHE+eOWFUq/y8CwoD8aORSMiasZHczGydJhs4/qlq28l/+PL4RDeNpi5SdA1B1a
         miu/LbAaMWwhsdqEjVqbhMwrBCOrNaekbAFCk4vLbL4s+ZJPCOzs7oJY3kFtjqdxJcZW
         nLEUXyj5/0RGoBn154D9dFV2Q6lYXTDe1FTVOHRUAFFHjJGRrUVuMGLmBPzIPz3aTUlZ
         d34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aSdxbzUUBFyhsvNwdRhnX3Mec7pbpC71E8zAtuMoNSw=;
        b=ko3SbAEXiBYPrT3QquhBPXnAnzS/1AT3lW3zbtrGfH+PSU5POB29Num5qN+08hAepj
         RA6e5JA9UVxnipzFjW0G0bNB0qeGHabXRQFNtP4o5b1EJEwJNgSaKPi7515/WoBzKoe8
         jdDLQGxGGgvXwpwo+jxIbRfbjbXRz6d9zAKShtSd/4dVKlQWCCatQhxZ7TdxbxVrfibb
         g9UDQ1K8B2kduxJYrL/8KzVvjZRtPJJUxpfmIOiAG0AD238WNj1jytVa24p0fHqTh2Ef
         YKZW22an/tj009GjYLrOfSCdXTl9eCV3zA8jawUIDEyki9/IofCljRLZoch0o1t5VK6i
         AWBA==
X-Gm-Message-State: AOAM532Htm+HdAaEdpVqriGd3Mc0u39qnvq6m1i+p85nzqMsp1DJm1Zs
        tPUU/l0vzq7O7D5ssQ/x8VkZ+Q5UgB/GZHOC3Q0=
X-Google-Smtp-Source: ABdhPJy6A7uqVEJVD4y7y1YfQGjjopexCYY0c40a6Xh4XUKujc3FuLvcm8mgvXFwCBo2/1BU/wrLj1y1uaQOcVZOi00=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2374308oie.132.1645547544141; Tue, 22
 Feb 2022 08:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-6-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-6-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:32:13 -0500
Message-ID: <CADnq5_MaeAaKemJyNyAkzsVrnUv9G4zqQrd4PbCj3vJaTpxVoA@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/amd/display: Remove unused dcn316_smu_set_voltage_via_phyclk
 function
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

Alex

On Tue, Feb 22, 2022 at 8:18 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Remove dcn316_smu_set_voltage_via_phyclk function, which is not used in t=
he
> codebase.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_smu.c:171:=
5:
> warning: no previous prototype for function
> 'dcn316_smu_set_voltage_via_phyclk' [-Wmissing-prototypes]
> int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, i=
nt
> requested_phyclk_khz)
>     ^
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  .../amd/display/dc/clk_mgr/dcn316/dcn316_smu.c   | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> index b7f9e1b34c11..fd6497fd2dc5 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> @@ -168,22 +168,6 @@ int dcn316_smu_set_dispclk(struct clk_mgr_internal *=
clk_mgr, int requested_dispc
>         return actual_dispclk_set_mhz * 1000;
>  }
>
> -int dcn316_smu_set_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, =
int requested_phyclk_khz)
> -{
> -       int actual_phypclk_set_mhz =3D -1;
> -
> -       if (!clk_mgr->smu_present && requested_phyclk_khz)
> -               return requested_phyclk_khz;
> -
> -       /*  Unit of SMU msg parameter is Mhz */
> -       actual_phypclk_set_mhz =3D dcn316_smu_send_msg_with_param(
> -                       clk_mgr,
> -                       VBIOSSMC_MSG_SetPhyclkVoltageByFreq,
> -                       khz_to_mhz_ceil(requested_phyclk_khz));
> -
> -       return actual_phypclk_set_mhz * 1000;
> -}
> -
>  int dcn316_smu_set_hard_min_dcfclk(struct clk_mgr_internal *clk_mgr, int=
 requested_dcfclk_khz)
>  {
>         int actual_dcfclk_set_mhz =3D -1;
> --
> 2.35.1
>
