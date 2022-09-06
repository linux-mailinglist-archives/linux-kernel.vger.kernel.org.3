Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DEA5AEFC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiIFP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbiIFP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:59:01 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1621056F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:17:32 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1274ec87ad5so14047581fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=elNxuUX6lGeeEhgvNfq4ozFit+ITf2yHnwbewtLwpz4=;
        b=NmH2CksanrE8Jg5SuuE0bgmFiHP6nQwdoGRvft2TPyWAdlUNzdJymK9JA5iQRuAuG3
         eaqK6vAK4Wgtj2BVu0d2608vZbXbhBVDGnpznuvTj/S9K4n9XByQuZACAVpgjLOAVu8G
         LQ6yevrMZ2DF4TUSj6m2+BKitfq8vicZJWXi4HhKgaOv2iw2mo/y5LIm65ABdPM+pnA9
         JaX35Vi/bH4JGrtG622F6l731Ycepgh4UMyVH8O+vkJB68ZbGMeFzW2/8WMC4+JWpxw9
         +TwcDiJvCgvbS0H2hOgzZ5BC+VFfRKokboX44FHTbPm6sjcnQGm7HoZ9rpXKcvo/FXvA
         tGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=elNxuUX6lGeeEhgvNfq4ozFit+ITf2yHnwbewtLwpz4=;
        b=mS4bwHlQ3Fsqj6Xu8OlLpl+BQtn4q+c1uQZXOgw0RVvmlyWcynAuzgl9LUbt5feDGt
         E/TUZdPSb/nqWInyo5U/pSECbpA11KJk74Dz4dfDAXxr6FB2udOFhsccQJUF6s6+pUiI
         t9zUNTmVqwVG+cGZFAN9AEQLqNPZCcqdcTHs5uewjwnCvo884PGefdioouV0z585cVC1
         Ax58nbS6VH4GSMi0RdSylQGqQ0p3OUI/Hxi8KMoaZbF0WJ7GfA8IcRZs4qaWk7QDVssy
         6MwtdIEFoyFlUAiqMzlcwoFb0ZrYIkvHDvwQfYNkes/7GjyqyAv/KfvyhfbTkmCsah5G
         thmg==
X-Gm-Message-State: ACgBeo2/z5Mo1+PoSH/GIR5Y8bI/4xPEvAupgZGvhtvUK6j8QbmXgaI6
        LE8y8aiDsR0nyeed8k5DDhrcXonE1FMQ0Ck/xISvIAhc
X-Google-Smtp-Source: AA6agR7EE3xwmNOpnaKh+tokhUCsSnbEdbIMeQTOdDjOcE1dmBGUpeWwdoyF2QflF5b+E/DFc4ei+KMtcY76k/kD2rQ=
X-Received: by 2002:a05:6870:738d:b0:125:1b5:420f with SMTP id
 z13-20020a056870738d00b0012501b5420fmr11244760oam.96.1662477451902; Tue, 06
 Sep 2022 08:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220905005329.19501-1-jingyuwang_vip@163.com>
In-Reply-To: <20220905005329.19501-1-jingyuwang_vip@163.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Sep 2022 11:17:20 -0400
Message-ID: <CADnq5_NJp0GMSbwv4rYU=KYLxfY0EsKD10MdZ0k+YV3sGXabng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_atpx_handler.c
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        isabbasso@riseup.net, Rodrigo.Siqueira@amd.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 2:29 AM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Fix everything checkpatch.pl complained about in amdgpu_atpx_handler.c
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 27 +++++++++++--------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index d6d986be906a..911d6a130ec5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -74,24 +74,29 @@ struct atpx_mux {
>         u16 mux;
>  } __packed;
>
> -bool amdgpu_has_atpx(void) {
> +bool amdgpu_has_atpx(void)
> +{
>         return amdgpu_atpx_priv.atpx_detected;
>  }
>
> -bool amdgpu_has_atpx_dgpu_power_cntl(void) {
> +bool amdgpu_has_atpx_dgpu_power_cntl(void)
> +{
>         return amdgpu_atpx_priv.atpx.functions.power_cntl;
>  }
>
> -bool amdgpu_is_atpx_hybrid(void) {
> +bool amdgpu_is_atpx_hybrid(void)
> +{
>         return amdgpu_atpx_priv.atpx.is_hybrid;
>  }
>
> -bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
> +bool amdgpu_atpx_dgpu_req_power_for_displays(void)
> +{
>         return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
>  }
>
>  #if defined(CONFIG_ACPI)
> -void *amdgpu_atpx_get_dhandle(void) {
> +void *amdgpu_atpx_get_dhandle(void)
> +{
>         return amdgpu_atpx_priv.dhandle;
>  }
>  #endif
> @@ -134,7 +139,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
>
>         /* Fail only if calling the method fails and ATPX is supported */
>         if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -               printk("failed to evaluate ATPX got %s\n",
> +               DRM_WARN("failed to evaluate ATPX got %s\n",

I'm not sure these need to be warnings.  Also, please use the
dev_info() functions instead so we can tell which device on the system
is reporting the issue.

>                        acpi_format_exception(status));
>                 kfree(buffer.pointer);
>                 return NULL;
> @@ -190,7 +195,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>
>                 size = *(u16 *) info->buffer.pointer;
>                 if (size < 10) {
> -                       printk("ATPX buffer is too small: %zu\n", size);
> +                       DRM_WARN("ATPX buffer is too small: %zu\n", size);
>                         kfree(info);
>                         return -EINVAL;
>                 }
> @@ -223,11 +228,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>         atpx->is_hybrid = false;
>         if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>                 if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
> -                       printk("ATPX Hybrid Graphics, forcing to ATPX\n");
> +                       DRM_WARN("ATPX Hybrid Graphics, forcing to ATPX\n");
>                         atpx->functions.power_cntl = true;
>                         atpx->is_hybrid = false;
>                 } else {
> -                       printk("ATPX Hybrid Graphics\n");
> +                       DRM_WARN("ATPX Hybrid Graphics\n");

These are definitely not warnings.  Please use dev_info() here.

>                         /*
>                          * Disable legacy PM methods only when pcie port PM is usable,
>                          * otherwise the device might fail to power off or power on.
> @@ -269,7 +274,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>
>         size = *(u16 *) info->buffer.pointer;
>         if (size < 8) {
> -               printk("ATPX buffer is too small: %zu\n", size);
> +               DRM_WARN("ATPX buffer is too small: %zu\n", size);
>                 err = -EINVAL;
>                 goto out;
>         }
> @@ -278,7 +283,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>         memcpy(&output, info->buffer.pointer, size);
>
>         /* TODO: check version? */
> -       printk("ATPX version %u, functions 0x%08x\n",
> +       DRM_WARN("ATPX version %u, functions 0x%08x\n",

Same here.

>                output.version, output.function_bits);
>
>         amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
>
> base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
> --
> 2.34.1
>
