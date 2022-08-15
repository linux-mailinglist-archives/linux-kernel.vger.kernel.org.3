Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683DA595151
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiHPEyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 00:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiHPEvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:51:31 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C4B81C6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:48:47 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so6198614oti.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Q7YZzg5zy6bNcVY2jRxF79+UC83JmaUvI/+TZ/8tdUU=;
        b=BtGr6YAH+McAQv+oqie8OGaJM/LJeNoC0wnHIAAgPPsUHCURZFFq4ZtHHEOZfCkTwy
         qrVKqv6R4OnltqFh0jVJjy15wouZSYVMICRCovcxHhYyZ7anlzhwvo4gWJA2rcIrrK0w
         X9xYYt1a09r5jeSYZ9ROa8b7Wllp33F8mIiKJtbOPczRNhc6G7zDxumyb197be+G/bn3
         6sAzHbY+bsBk33LutarZ4ewzKTvXvVt9HmAAHIHktC8xcxNMcJY2I2EYhW9pWVw94nIu
         DhAGh2EpI+JPmwJ51nZhaRay2+uMS+lyV91SoY76sNolfpgUlHLI0fQt/RqbQsYQJ4IF
         0cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Q7YZzg5zy6bNcVY2jRxF79+UC83JmaUvI/+TZ/8tdUU=;
        b=5Nnm7h0VqnYZdE/goFaB2IlceNEqBQ/lQqbibEPBo2Tnt6El8KmQ29R8qh9VCOgr7k
         dDCvu7U9V6MU3wYyiUQ4cMNAeJirfEZTL2qg0QBIBICMNirvMlMTtCkn4Bvx9kn9xThW
         z8s0ZtI9O/QcxYmoIiaf0JhtC+wDi5O4ZX8TluCbaB8UxGE3lUs/qwZ160YY/KsR25qh
         J8IAmPMmCNrw110017PAQREqCPs4ZU+/dqrB19KkWeQYiJPLB4H6YToN3qRNpp/pDrYp
         XZV8WBswhBRuqfRZJejMZmO+YqV4Un5HNEqCR+EgLvNxIEYQiWHxyTvM7zP7w01z90n9
         Rg2g==
X-Gm-Message-State: ACgBeo1SduH2HWYBWy56Zd8YkL1RsLr0HjLJiv9V9ftRSFxB2dZ8BDdB
        Ok8zWC5rSChC+EzmhKRQaxNBkP9MlOqGfAkgLjc=
X-Google-Smtp-Source: AA6agR4AxpLwfS11OLIkrikL4YqYc2UykZk/chEQqqURGqAW/fKLVeujmnfvUO/aVUYqw02150ZzKLzbWVka5N/5oac=
X-Received: by 2002:a9d:c64:0:b0:636:df4c:e766 with SMTP id
 91-20020a9d0c64000000b00636df4ce766mr6666652otr.12.1660596526370; Mon, 15 Aug
 2022 13:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220815183425.14867-1-khalid.masum.92@gmail.com> <SJ1PR12MB6194F4ADBF5DEBB1AEEF1E5295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
In-Reply-To: <SJ1PR12MB6194F4ADBF5DEBB1AEEF1E5295689@SJ1PR12MB6194.namprd12.prod.outlook.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 15 Aug 2022 16:48:35 -0400
Message-ID: <CADnq5_NkQqLdQxeD_Za=0bsS-3BGTRPBs3iF0nnWxR2t2mJtfw@mail.gmail.com>
Subject: Re: [PATCH linux-next] drm/amdgpu/vcn: Return void from the stop_dbg_mode
To:     "Dong, Ruijing" <Ruijing.Dong@amd.com>
Cc:     Khalid Masum <khalid.masum.92@gmail.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Jiang, Sonny" <Sonny.Jiang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhu, James" <James.Zhu@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
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

On Mon, Aug 15, 2022 at 2:40 PM Dong, Ruijing <Ruijing.Dong@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> This patch is
>
> Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Khalid Masum <khalid.masum.92@gmail.com>
> Sent: Monday, August 15, 2022 2:34 PM
> To: Dong, Ruijing <Ruijing.Dong@amd.com>; amd-gfx@lists.freedesktop.org; =
dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Zhu, James <James.Zhu@amd=
.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Wan =
Jiabing <wanjiabing@vivo.com>; Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg>; Khalid Masum <khalid.masum.92@gmail.com>
> Subject: [PATCH linux-next] drm/amdgpu/vcn: Return void from the stop_dbg=
_mode
>
> There is no point in returning an int here. It only returns 0 which the c=
aller never uses. Therefore return void and remove the unnecessary assignme=
nt.
>
> Addresses-Coverity: 1504988 ("Unused value")
> Fixes: 8da1170a16e4 ("drm/amdgpu: add VCN4 ip block support")
> Suggested-by: Ruijing Dong <ruijing.dong@amd.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---
> Past discussions:
> - V1 Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flore.kernel.org%2Flkml%2F20220815070056.10816-1-khalid.masum.92%40gma=
il.com%2F&amp;data=3D05%7C01%7Cruijing.dong%40amd.com%7C017222a9e81f49ea336=
f08da7eecd6c8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6379618529504644=
12%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DTyXtoF2flWNqabtiJ%2BDVcR2vds=
nLZ19qr3b%2BQT2DBQA%3D&amp;reserved=3D0
>
> Changes since V1:
> - Make stop_dbg_mode return void
> - Update commit description
>
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index ca14c3ef742e..fb2d74f30448 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1115,7 +1115,7 @@ static int vcn_v4_0_start(struct amdgpu_device *ade=
v)
>   *
>   * Stop VCN block with dpg mode
>   */
> -static int vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_i=
dx)
> +static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int
> +inst_idx)
>  {
>         uint32_t tmp;
>
> @@ -1133,7 +1133,6 @@ static int vcn_v4_0_stop_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx)
>         /* disable dynamic power gating mode */
>         WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 0,
>                 ~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
> -       return 0;
>  }
>
>  /**
> @@ -1154,7 +1153,7 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev=
)
>                 fw_shared->sq.queue_mode |=3D FW_QUEUE_DPG_HOLD_OFF;
>
>                 if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -                       r =3D vcn_v4_0_stop_dpg_mode(adev, i);
> +                       vcn_v4_0_stop_dpg_mode(adev, i);
>                         continue;
>                 }
>
> --
> 2.37.1
>
