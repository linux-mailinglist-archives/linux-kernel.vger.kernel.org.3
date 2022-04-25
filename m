Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF850E699
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243744AbiDYRNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238725AbiDYRNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:13:18 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39917E0A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:10:12 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e2442907a1so16733633fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKPxk8T+PNpsX+t/Fbj+aBKeJtlWLiqDlWC/CAfDx2c=;
        b=g0SEwyj8gHZs144Ip4riSiMjWfpHFrJ7xX50lQ82lYEDVCaeszdY9VQ0BYoq1/QoCh
         pQDNtjETe+ryPaZ5Y2Ma02dVLaA1lVpR2Q0RJSbfyaKWRBpiJAHvjg+gLUeZLbV6s6og
         Ztc7244wbNq6eX98h1Dg6dHTDmYqhfh8JqKgDQdgojPMUeChiYEhbwIvM+vp/tVTdV8t
         rL3jRYH4SwCTpeYgoCcdvm0GQfDTl54LEsqlZCQJ9r1g9OEpnHYdxv3KoSWpAqVLTpsw
         qXHzNf6Uykj954vKSAWJFT33aJppnWltm7TbfRjLgx6jHC3yh/398OIt7ED8UeipIt1s
         txHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKPxk8T+PNpsX+t/Fbj+aBKeJtlWLiqDlWC/CAfDx2c=;
        b=1BPQ4GQvaO6UCgqCyMwWQVAcrFXv0iYPJJaKGov5B8J2pU1UpZUbuO9+sHt6HmWMZj
         uXRgBbhokOWXm0g5GdnMtVYKxB1ml2qiX+mtWJ6kaf5Yzy3mqZ+g/PvtGjj50DVyhrx/
         B0EvXF/4okcwMk28kBs/oPUbM5g8tnzRof9fshVBgY3krIwrSTdjwZ16tEzKjOWlTczD
         ScjA3Zq2eB8+i1cy4OoOBVpNfuDDQpFljApQvaHSds+kOq9o+i0T2u/FwAHLhfpt00m/
         tJ2QxKYDy7Wt09JHtEfNqAGIw7GwtTQluzuGYKlcObCWuztLabFw2klfKTOw4dOUVRtD
         uRhA==
X-Gm-Message-State: AOAM5308R0h1IwbTZDmSCOwG4zu7hbxe6c169BaP4+YehaoVSSCv1jr9
        t7O7fEiVJOeRzAjncOS6IQiK11zoSP2E8Xk6fhk=
X-Google-Smtp-Source: ABdhPJxDeMcCi6n0Vl4q2/ICp4DEmjg3kaj7k4WDNM3ZtsZWC6eVYEyE4tZ7EkHRjQNcogaKJ5M5u9+pBxCZQrJujFU=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr11123566oaa.200.1650906612105; Mon, 25
 Apr 2022 10:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220423200155.1735336-1-trix@redhat.com>
In-Reply-To: <20220423200155.1735336-1-trix@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 25 Apr 2022 13:10:00 -0400
Message-ID: <CADnq5_Oys5RXiksMGW8kvFiZ+DknGRqMnR6njEN1DZGWhYRcEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: change cac_weights_* to static
To:     Tom Rix <trix@redhat.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Apr 23, 2022 at 4:02 PM Tom Rix <trix@redhat.com> wrote:
>
> Sparse reports these issues
> si_dpm.c:332:26: warning: symbol 'cac_weights_pitcairn' was not declared. Should it be static?
> si_dpm.c:1088:26: warning: symbol 'cac_weights_oland' was not declared. Should it be static?
>
> Both of these variables are only used in si_dpm.c.  Single file variables
> should be static, so change their storage-class specifiers to static.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/radeon/si_dpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
> index 3add39c1a689..fbf968e3f6d7 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -329,7 +329,7 @@ static const struct si_dte_data dte_data_malta =
>         true
>  };
>
> -struct si_cac_config_reg cac_weights_pitcairn[] =
> +static struct si_cac_config_reg cac_weights_pitcairn[] =
>  {
>         { 0x0, 0x0000ffff, 0, 0x8a, SISLANDS_CACCONFIG_CGIND },
>         { 0x0, 0xffff0000, 16, 0x0, SISLANDS_CACCONFIG_CGIND },
> @@ -1085,7 +1085,7 @@ static const struct si_dte_data dte_data_venus_pro =
>         true
>  };
>
> -struct si_cac_config_reg cac_weights_oland[] =
> +static struct si_cac_config_reg cac_weights_oland[] =
>  {
>         { 0x0, 0x0000ffff, 0, 0x82, SISLANDS_CACCONFIG_CGIND },
>         { 0x0, 0xffff0000, 16, 0x4F, SISLANDS_CACCONFIG_CGIND },
> --
> 2.27.0
>
