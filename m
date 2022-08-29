Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6FF5A4E73
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiH2NsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiH2NsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:48:03 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5C09413A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:48:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id p187so10367402oia.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=boJNilqu5rkLXIrZXtZ+13kCjg+IVe8CBRV4aqjI3IQ=;
        b=kMzNApZWAepG8844yhdKAszbolxRMCr4T+NZX6qZyk4HXX5WGa/xOKJMkyeaYeyGIV
         gGPctdEYzEMmPH/0QF4SQjImmks2NCtrJJG5iRCh800OcIulJhnhJJvHLT6iPJC99Nsi
         4H+N+bZRUg1CWo0PPv4Pl2cjlCxqRxc/r/xp4KB0afY0jL0P1bPvNbODbM2AJCCHArz3
         4pyjCGQvX/e/9UPbCK80eF/+dqAmalmZRjQqfIw7F41sHKKheEyu2E24Bs7hVSDOBUYs
         Fz1KUf8zkHrmHVMTsouCKyTk2BctKRG6UqIYDagyLyA/GUlzp4Ujyf9WbbgErxSwfPB0
         uM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=boJNilqu5rkLXIrZXtZ+13kCjg+IVe8CBRV4aqjI3IQ=;
        b=GoB1YgviAGREybtx/Y0avO6LK8pirAQhyaEF9RYWkjSqVMjsLGLCeAOWhSV7SdXcHi
         Q+hWa3OxjQWAoX8wdTe0t3YXe426f8cg2wvFuqJFSGZJBQ4laWrZOyG55DieqUq6EoBi
         nf58RbxuWoItHAQav3uywu2y4MmoMgC5tRlRFBt7A8ydd8pJpcxbhDwCZdt63K8Q8KqC
         t7P80FtSp7u5UETV8ysljpNc15jziZDC8X8erB89sVF6+tH4STPwy4ldtO7unPSoHiB9
         H4bnFQRxg5DUuZVp+/LaZEq8mwjCPXEjK9/dwOFv5jzTYsirWWGL9CJ6gsX0jpF+Oh5o
         E+uA==
X-Gm-Message-State: ACgBeo1b9Edq8E6ok4+u9b5NW9KGCuV2ERxeohZoi06f3rPv+9Wsb0B9
        NvWwgsFq5eyDFR1vxJwCMErvjSGmHtUKxSAZ9FSCxuy6
X-Google-Smtp-Source: AA6agR5ZkGCAzYchqafGj2oNqKZbHuDk+qOgihZvR2eaNfjMBopqDWWFPHuoApwE0QzrDc6rJ3T3cUdTjfbQ4dJyqLM=
X-Received: by 2002:a05:6808:138e:b0:345:13d1:fd66 with SMTP id
 c14-20020a056808138e00b0034513d1fd66mr7375330oiw.96.1661780881704; Mon, 29
 Aug 2022 06:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220829123654.4333-1-nizhen@uniontech.com>
In-Reply-To: <20220829123654.4333-1-nizhen@uniontech.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 29 Aug 2022 09:47:50 -0400
Message-ID: <CADnq5_P9b3QbO_u4y+isN07WiErPKQRB1O1wvmhXMbV52PeV6Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add modeset module parameter support
To:     Zhen Ni <nizhen@uniontech.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, evan.quan@amd.com,
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

On Mon, Aug 29, 2022 at 9:43 AM Zhen Ni <nizhen@uniontech.com> wrote:
>
> Nomodeset kernel parameter is for all graphics cards. Amdgpu cannot
> be set separately in some scenarios, such as hybrid graphics(i + a).
> Add modeset module parameter for amdgpu to set kernel mode separately.
>
> Signed-off-by: Zhen Ni <nizhen@uniontech.com>

amdgpu didn't support this option since it never supported the legacy
drm mode that other older drivers did.  If you just want the option to
keep the driver from loading, you can already do this by blacklisting
the driver.  E.g.,
modprobe.blacklist=amdgpu

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 429fcdf28836..856a70370e3c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -107,6 +107,7 @@
>  #define KMS_DRIVER_MINOR       48
>  #define KMS_DRIVER_PATCHLEVEL  0
>
> +int amdgpu_modeset = -1;
>  int amdgpu_vram_limit;
>  int amdgpu_vis_vram_limit;
>  int amdgpu_gart_size = -1; /* auto */
> @@ -199,6 +200,13 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>         .period = 0x0, /* default to 0x0 (timeout disable) */
>  };
>
> +/**
> + * DOC: modeset (int)
> + * Disable/Enable kernel modesetting (1 = enable, 0 = disable, -1 = auto (default)).
> + */
> +MODULE_PARM_DESC(modeset, "Disable/Enable kernel modesetting");
> +module_param_named(modeset, amdgpu_modeset, int, 0400);
> +
>  /**
>   * DOC: vramlimit (int)
>   * Restrict the total amount of VRAM in MiB for testing.  The default is 0 (Use full VRAM).
> @@ -2753,7 +2761,10 @@ static int __init amdgpu_init(void)
>  {
>         int r;
>
> -       if (drm_firmware_drivers_only())
> +       if (drm_firmware_drivers_only() && amdgpu_modeset == -1)
> +               amdgpu_modeset = 0;
> +
> +       if (amdgpu_modeset == 0)
>                 return -EINVAL;
>
>         r = amdgpu_sync_init();
> --
> 2.20.1
>
