Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791A7594D54
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347315AbiHPAvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348905AbiHPAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 20:46:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290C719580E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:44:45 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-116c7286aaaso9423558fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=tYUBnH/MsVRH8/bfqF/s2biQgFrJkgqn5c8u0QHLws4=;
        b=J1dcXg+0hcTPJW/ZFLCExzXkIuscsbapWoMN+oGZ2ujZl4NZ16nqo3WNgPZnti6lTd
         i7o+MTQUVCOUB6pvodzFhmHDJhSxaAY++pPvcG5fEEQXa0a3m0EXlT4/T2pxmF122VKl
         a1618VIaaciGn2grpGWNCl/z9cqvZVtcTaGaMnu3wxNxfYfO+me+b5iLcA05XURxNft6
         t167aLOTrk3vPSXG1PPU6honySFp+qSkiQ8KHU+FFjGQaHUnVnyx0ZpPoOWNJrIeii5C
         Hju9gpxGbCEJnXhSlU+fwOB2AxLmhZ2+xeXcuzRHZ1FGvYOqvUp6LBRnrLjCjMywvrx6
         4w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=tYUBnH/MsVRH8/bfqF/s2biQgFrJkgqn5c8u0QHLws4=;
        b=QN75AEVdMai9DnL9bBb/alEgvLBOFD1th2nwCBH9HYOcA4yV/PGaNWndbB9Bwd0eFm
         Rz07LH4FmRP6L3qxKeaY4uY1Q7RrgUrPRAl2zcLjUE9YrYv4LLO5ECxd+4P9k9CBy5UB
         e9juWSPakUwkvrasLqW2rN32EYAs5ALnFhkgitmpNXaWgrCc8NH+Ue4sYSFp1i8nN1v6
         Pgay2YpolUJk36QGxxxT6C8FPpyK/wwkjDqHtklNSlyPdERqINVaCn6QeEfz6dmI61tE
         8FsZVXYxWAhTc4O4DoUVJwSdHFbf4UkgNgwb8CJkc/FVatgaRyb4o0PIDhAk1UzLFY3e
         jGkw==
X-Gm-Message-State: ACgBeo3qapqMaYdZXO6eci49/3uBzBRb25YaX3B4uDfgvYXZpUYrSZbb
        ZJMkF9ch1xe73ogHWyUIOWLNlNQh3dXH3Ql+wp8=
X-Google-Smtp-Source: AA6agR4lTNg/R9bH8fCViZfGEvc6dMFDdsFFr0Vis26Tmv/uGc+ltdRMU8B4hhcEYejU4tKiurv9Q3FDzVnrTQSIoRM=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr7668019oao.106.1660596284103; Mon, 15
 Aug 2022 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220810232858.11844-1-andrealmeid@igalia.com> <20220810232858.11844-5-andrealmeid@igalia.com>
In-Reply-To: <20220810232858.11844-5-andrealmeid@igalia.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Aug 2022 16:44:33 -0400
Message-ID: <CADnq5_N2EToKQG7xS6NOTvgLrVuzWTtqZgHbF6LEOH3gZdHhgQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amdgpu: Document gfx_off members of struct amdgpu_gfx
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom St Denis <tom.stdenis@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        kernel-dev@igalia.com
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

Applied the series.  Thanks!

Alex

On Wed, Aug 10, 2022 at 7:30 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Add comments to document gfx_off related members of struct amdgpu_gfx.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 1b8b4a5270c9..8abdf41d0f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -332,12 +332,12 @@ struct amdgpu_gfx {
>         uint32_t                        srbm_soft_reset;
>
>         /* gfx off */
> -       bool                            gfx_off_state; /* true: enabled, =
false: disabled */
> -       struct mutex                    gfx_off_mutex;
> -       uint32_t                        gfx_off_req_count; /* default 1, =
enable gfx off: dec 1, disable gfx off: add 1 */
> -       struct delayed_work             gfx_off_delay_work;
> -       uint32_t                        gfx_off_residency;
> -       uint64_t                        gfx_off_entrycount;
> +       bool                            gfx_off_state;      /* true: enab=
led, false: disabled */
> +       struct mutex                    gfx_off_mutex;      /* mutex to c=
hange gfxoff state */
> +       uint32_t                        gfx_off_req_count;  /* default 1,=
 enable gfx off: dec 1, disable gfx off: add 1 */
> +       struct delayed_work             gfx_off_delay_work; /* async work=
 to set gfx block off */
> +       uint32_t                        gfx_off_residency;  /* last logge=
d residency */
> +       uint64_t                        gfx_off_entrycount; /* count of t=
imes GPU has get into GFXOFF state */
>
>         /* pipe reservation */
>         struct mutex                    pipe_reserve_mutex;
> --
> 2.37.1
>
