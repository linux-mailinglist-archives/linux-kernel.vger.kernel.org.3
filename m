Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFB534330
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbiEYSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiEYSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:40:40 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A1EB2244
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:40:39 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k186so5031746oia.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IsIJb2bLdZeT3b6zZvcrkP7qwrS6+3RvK/fXCEbZ8Xk=;
        b=WwnZnZBcCw/Lgbs6q/t0HQLejAV7AaY1UZg/u+6/RxLgzg67BuTLQZ3axx9gmYR6gh
         EUWw/IIDQW01LSaipuTYCHHffE17EyBVVzbvBJIN6RG0sBpV9u2e7T88RJaqZSSPMGRj
         klBRTnvNVwswNbNoz0SX+tq/g837HmociAbHxhWKE79UFDGZbItqirbvSLYw3U248G8v
         a7HpRsNN6scZ+lP/gILfmUcsVv29e6C2EEGDuB+IyHPQSEUeIo5qnYOLxTEftZDZAt/v
         QysHqVm9lbwQS77EFOlAFo1vy1FtB7kl8fj44yqwFDXekSxVeZXIaLIfFiobnefOmphP
         FayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IsIJb2bLdZeT3b6zZvcrkP7qwrS6+3RvK/fXCEbZ8Xk=;
        b=ykIluE1WhAy/ICzy1I9Jandv6R0F/qII21vMkU2Z2W3HsqoTMrY4aMla/khpnkm0N8
         62iJRkuVgRXllLU56xfBwTVCzDRjcuEmBXI1J07nDyqAsuKrfDlDIxSiier+xRoLZt8p
         9F/gcYxJa9jgT0L1rco5ZfPF7YFgiq+pO0EJLVo+wE9Fl+4GOycTiwsXj5T33EJvvqB6
         Jmwq1q1H5SgMuuhVhOezSkKcDgFl0SAjHwYuCRgkLmM+0L42kVKAPjB7Z3rq4R3VKF8+
         fRzlnZUgbjVjP2hqE/lrYJRv5ziJetreK1jDuZBdFjxV+Jp/KELNi24m2cKdbHvbo9zk
         1Rpw==
X-Gm-Message-State: AOAM531QIjI8odWEvBDGU7+vX429vNTTrfmaFn0Po1qkhv8o9zPTa0zP
        S1IG3m2oqgVajbVF7Vr/fwSr87kjGY553fvfslSL3abj
X-Google-Smtp-Source: ABdhPJyOwUeuC147uYslh7O/kMgrID5j8lwN+MKYuAzgczWF4cVVrT5/c+7+RplRpMc7z7HtOrTgY1IJPNLYSJ3Ji9M=
X-Received: by 2002:a05:6808:15a7:b0:32b:aeac:84d0 with SMTP id
 t39-20020a05680815a700b0032baeac84d0mr530515oiw.253.1653504038768; Wed, 25
 May 2022 11:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220525093702.57166-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20220525093702.57166-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 25 May 2022 14:40:27 -0400
Message-ID: <CADnq5_Pp8gCkW1L6RVzKYALSk-Z5sQNEFDbOd9D8khwJsF+qEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make program_imu_rlc_ram static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>
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

On Wed, May 25, 2022 at 5:37 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> This symbol is not used outside of imu_v11_0.c, so marks it
> static.
>
> Fixes the following w1 warning:
>
> drivers/gpu/drm/amd/amdgpu/imu_v11_0.c:302:6: warning: no previous
> prototype for =E2=80=98program_imu_rlc_ram=E2=80=99 [-Wmissing-prototypes=
].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/imu_v11_0.c
> index 5d2dfeff8fe5..d63d3f2b8a16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
> @@ -299,7 +299,7 @@ static const struct imu_rlc_ram_golden imu_rlc_ram_go=
lden_11_0_2[] =3D
>         IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__=
GPA_OVERRIDE_MASK, 0)
>  };
>
> -void program_imu_rlc_ram(struct amdgpu_device *adev,
> +static void program_imu_rlc_ram(struct amdgpu_device *adev,
>                                 const struct imu_rlc_ram_golden *regs,
>                                 const u32 array_size)
>  {
> --
> 2.20.1.7.g153144c
>
