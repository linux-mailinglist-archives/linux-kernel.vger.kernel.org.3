Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A097B4A5003
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378582AbiAaUSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378534AbiAaUSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:18:08 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375FCC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:18:08 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id y23so28893399oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 12:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+6Hlw5bi1mRKnGmEwqEzr0N+3dJ3SBtS+eV/8eoOzY=;
        b=ePD2H90c1U2FfI6edAE4mJ7tIzRLoeAVgOYLn0Cf8okDIFvKYoylzirAc3R9maIznD
         O/Je25AqBL6ZOLaZSLRjeN1HHaI8bk2M/jOcoMl2M1GCzhb6bmNgr4dMNrSirQCrMZnn
         CuufUOFMzg0MF2D57oEhO0yF9xLMeXoLsCaY6FeH9zUJFYtanv86rHaE0MjgJcN/SSqO
         A5ftWLUzUmyzk0/xbhFyeMbmYLCgrueFQ3DYB4caUCVtMahVHeFMGL9bv4lGjsUjQYc0
         0cCDaNVPdVA/F76hB/l1Xv0V9rZJzZzjNUB1vxT2on46W0d/Rxft9O+rrCWTWv2VzzfR
         3XzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+6Hlw5bi1mRKnGmEwqEzr0N+3dJ3SBtS+eV/8eoOzY=;
        b=ELwkmz6ditdUgEn4s2KvD2iRjQ7ZROJ7is7GIb2YOkCF2ylPLb7NyRbk2GSPdMSkz6
         h4Hvo1DvSuPPqXax4rTlqli+YvrajySxGdilK855PZjWGbLCjZBYnKSLzCtJHBRHctwD
         C/GXBQIwyr6a9lHrWfoMMEt0Ul5QbP4BWVnJp627OJdThnlcP2Zp+2y5Ft57icBsm+NH
         OqpeWgERyUq+F9OZ9PP9tjXf1giFxcgmL3bwsMnASDOAkoBnE7vSed63oiP6jkhKjieb
         KdARtbpFJcmHbrLH7Q0GWhq0ZTqpOoBbnFSWIlYV2xv1qTO+Vtngbt7NFx3ml9zTQy1+
         rv3A==
X-Gm-Message-State: AOAM530yekTFZQj4GqryZi1affrAeCf7FtQNKHCrVZYGd5fhvYVElmk9
        +yJafrSlLGEhXivmVSCJEHpwlB4ifI1Pl3u0sFo=
X-Google-Smtp-Source: ABdhPJzvGcXiMK6fhyQRD4f8b79aSskovJO2s2WLmPVT+ibyd29b/52aG8mRWZnXNHt/np854hlGLi/yrAnhmpox/tE=
X-Received: by 2002:a05:6808:2189:: with SMTP id be9mr19136202oib.93.1643660287560;
 Mon, 31 Jan 2022 12:18:07 -0800 (PST)
MIME-Version: 1.0
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
 <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
 <58B7B0D4-BA3B-43EA-9F54-06CCEB7EF833@live.com> <0932bbf6-409e-0d3e-2824-b33914033f81@amd.com>
 <5CC8BCC9-176A-4478-B03B-3E4B4D7D88E6@live.com>
In-Reply-To: <5CC8BCC9-176A-4478-B03B-3E4B4D7D88E6@live.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 31 Jan 2022 15:17:56 -0500
Message-ID: <CADnq5_NsTJm5YazeM8O7C2hUS_7vCVw_CX2ZwYV0w5=iBUMeCA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Force link_rate as LINK_RATE_RBR2 for
 2018 15" Apple Retina panels
To:     Aditya Garg <gargaditya08@live.com>
Cc:     Harry Wentland <hwentlan@amd.com>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "evan.quan@amd.com" <evan.quan@amd.com>,
        "stylon.wang@amd.com" <stylon.wang@amd.com>,
        "wesley.chalmers@amd.com" <wesley.chalmers@amd.com>,
        "qingqing.zhuo@amd.com" <qingqing.zhuo@amd.com>,
        "George.Shen@amd.com" <George.Shen@amd.com>,
        "roman.li@amd.com" <roman.li@amd.com>,
        "solomon.chiu@amd.com" <solomon.chiu@amd.com>,
        "Aurabindo.Pillai@amd.com" <Aurabindo.Pillai@amd.com>,
        "wayne.lin@amd.com" <wayne.lin@amd.com>,
        "mikita.lipski@amd.com" <mikita.lipski@amd.com>,
        "Bhawanpreet.Lakha@amd.com" <Bhawanpreet.Lakha@amd.com>,
        "agustin.gutierrez@amd.com" <agustin.gutierrez@amd.com>,
        "pavle.kotarac@amd.com" <pavle.kotarac@amd.com>,
        Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Jan 29, 2022 at 12:50 AM Aditya Garg <gargaditya08@live.com> wrote:
>
> From: Aun-Ali Zaidi <admin@kodeit.net>
>
> The eDP link rate reported by the DP_MAX_LINK_RATE dpcd register (0xa) is
> contradictory to the highest rate supported reported by
> EDID (0xc = LINK_RATE_RBR2). The effects of this compounded with commit
> '4a8ca46bae8a ("drm/amd/display: Default max bpc to 16 for eDP")' results
> in no display modes being found and a dark panel.
>
> For now, simply force the maximum supported link rate for the eDP attached
> 2018 15" Apple Retina panels.
>
> Additionally, we must also check the firmware revision since the device ID
> reported by the DPCD is identical to that of the more capable 16,1,
> incorrectly quirking it. We also use said firmware check to quirk the
> refreshed 15,1 models with Vega graphics as they use a slightly newer
> firmware version.
>
> Tested-by: Aun-Ali Zaidi <admin@kodeit.net>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2 :- Use C styled comments
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 05e216524..086f7ee2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5597,6 +5597,26 @@ static bool retrieve_link_cap(struct dc_link *link)
>                 dp_hw_fw_revision.ieee_fw_rev,
>                 sizeof(dp_hw_fw_revision.ieee_fw_rev));
>
> +       /* Quirk for Apple MBP 2018 15" Retina panels: wrong DP_MAX_LINK_RATE */
> +       {
> +               uint8_t str_mbp_2018[] = { 101, 68, 21, 103, 98, 97 };
> +               uint8_t fwrev_mbp_2018[] = { 7, 4 };
> +               uint8_t fwrev_mbp_2018_vega[] = { 8, 4 };
> +
> +               /* We also check for the firmware revision as 16,1 models have an
> +                * identical device id and are incorrectly quirked otherwise.
> +                */
> +               if ((link->dpcd_caps.sink_dev_id == 0x0010fa) &&
> +                   !memcmp(link->dpcd_caps.sink_dev_id_str, str_mbp_2018,
> +                            sizeof(str_mbp_2018)) &&
> +                   (!memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018,
> +                            sizeof(fwrev_mbp_2018)) ||
> +                   !memcmp(link->dpcd_caps.sink_fw_revision, fwrev_mbp_2018_vega,
> +                            sizeof(fwrev_mbp_2018_vega)))) {
> +                       link->reported_link_cap.link_rate = LINK_RATE_RBR2;
> +               }
> +       }
> +
>         memset(&link->dpcd_caps.dsc_caps, '\0',
>                         sizeof(link->dpcd_caps.dsc_caps));
>         memset(&link->dpcd_caps.fec_cap, '\0', sizeof(link->dpcd_caps.fec_cap));
> --
> 2.25.1
>
>
