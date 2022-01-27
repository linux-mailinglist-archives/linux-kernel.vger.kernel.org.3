Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDE949E92A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbiA0RgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbiA0RgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:36:21 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E54C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:36:21 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id e81so7257421oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZpFI8l5HPh70e90rEq4gULROdmVbaPdsdK5LgCBr5E=;
        b=Y4mzcqWqjCSQl9oLTQRDVuWxDI3ccz05N5LzPC0eV2iSuMLjGQsLqLJhLEwBz4Xq0f
         Oop0f1PpbCrHTT4BHHdyPVovcOAGKDUb72/c9m8CiHMNZQn4E9/p4J3Nj69atPJpzdkX
         BbGL6tfjELHhM9EnIf9jGl+hfaZXt30TBSHhxHldQOUdO0XQrcrX8kzFjWsH0oiWvCKc
         fOxoGbRtNGscmQcDWmBma2egEwdFTf4FNjrCBXbRkOp8ohEDFENGldjh/063kRs1LRjI
         EE1G4Ure7pEwEQaSPpofHZWV5Fu8ywUnoP9QWdcyXuzXCBjnIzZ7geXimQyhzQOsKPxV
         u0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZpFI8l5HPh70e90rEq4gULROdmVbaPdsdK5LgCBr5E=;
        b=fTBRuffajToWh+0L7tuEB1NOYloK5wdjYW+Zan/N+PFWAt0CoazJuUXQ3Cbfh5RgWA
         NASQXy1RXrStFfwBYqH6mXd6l7hQ9kB4FynTmoS3+EdMMG6U619HaUnqpcR9/fQaJ1TW
         yFdc3e02VWV85N539MLNxqmjgwCAF4ty9GpAJhBiBEDS9wWuS4OveJt7RLhRZR7jxYt2
         XE19izLtpXCOPX0aerzyEnhez2eGvEz7qEsIVCQr8lq+uWfr2zBj8GEXy++TLiiG86oo
         3Ixxr0UQ9azIDRygV1a6lEDMPh7S4LluXSVAHKV2vwtmMKvzK/H5bDuULyLMaU8WlwTX
         BLKw==
X-Gm-Message-State: AOAM531SKwKshBOAENPhX1twcMyegiFExcdlSY65lYQCnhvbAnfktVeE
        EPkrQuvexqQVrqD6a4pkGdj16m6DdKIW+qmCxI0=
X-Google-Smtp-Source: ABdhPJzXjC9kivhNdgqXKLMDJks/iHesfmgt1qChvejl45j8ptrGjrmSGCXtL1rUo1S3ZB1cKwwiFulggmn3klbeZpE=
X-Received: by 2002:a05:6808:2011:: with SMTP id q17mr7705612oiw.199.1643304980890;
 Thu, 27 Jan 2022 09:36:20 -0800 (PST)
MIME-Version: 1.0
References: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
In-Reply-To: <139A7689-463E-4AD9-A2D1-A9969C3958D0@live.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 27 Jan 2022 12:36:09 -0500
Message-ID: <CADnq5_OLpgEJjpN5y9b3gNwCmvdfNTA=puUv8UjOCDH96JgvOQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/amd/display: Force link_rate as LINK_RATE_RBR2
 for 2018 15" Apple Retina panels
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
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

On Wed, Jan 26, 2022 at 8:56 AM Aditya Garg <gargaditya08@live.com> wrote:
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
> Signed-off-by: Aun-Ali Zaidi <admin@kodeit.net>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 05e216524..17939ad17 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5597,6 +5597,25 @@ static bool retrieve_link_cap(struct dc_link *link)
>                 dp_hw_fw_revision.ieee_fw_rev,
>                 sizeof(dp_hw_fw_revision.ieee_fw_rev));
>
> +       /* Quirk for Apple MBP 2018 15" Retina panels: wrong DP_MAX_LINK_RATE */
> +       {
> +               uint8_t str_mbp_2018[] = { 101, 68, 21, 103, 98, 97 };
> +               uint8_t fwrev_mbp_2018[] = { 7, 4 };
> +               uint8_t fwrev_mbp_2018_vega[] = { 8, 4 };
> +
> +               // We also check for the firmware revision as 16,1 models have an
> +               // identical device id and are incorrectly quirked otherwise.

C style comments please.  I'll let one of the display guys comment on
the rest of the patch.  Seems reasonable, we have a similar quirk for
the Apple MBP 2017 15" Retina panel later in this function.  Could you
move this next to the other quirk?

Alex


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
