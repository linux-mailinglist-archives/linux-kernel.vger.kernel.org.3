Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835224BFEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbiBVQil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBVQij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:38:39 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB50BF974
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:38:13 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id k2so11359123oia.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gGjkIZdn8iDygTC74bA8nSai9fnVzHtbdRMYVYGrfT4=;
        b=pMIIbsd55BhAHXzDncwJDFaoOpcF1JY1qxQPilcyT26Qxu/McqAW3L2Oc4KYVG3IE3
         0fawyyZe7TzzanS8DKSyt/POvD+2k06/UEHiMLmuEiKYnYRKmKtdkfuWEM776cY1yZl3
         +TuLtOD1Mie67XV1QiKXv0iuCeCfewE6DJSh65Sg+gR9bH7hFtT4FAHaWsViIGCSobT3
         4P1Os4tfO+IQ3sjbD9iv0zCMnnqyDr3xCsIPzGy3aOwIwmbejNBxAT58re5XcOe2VFIl
         ZRx0ps3lJe+LD5EyVwxlQ7B7MQj59n+nHbuUa81q21Z4o3secnKC031WczgJ1bx2QlmF
         SPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gGjkIZdn8iDygTC74bA8nSai9fnVzHtbdRMYVYGrfT4=;
        b=mTEcyPcPec6Llg3nIVbyWidahTEd0KCNVz5k0aXyb1UqlW7ZOr2CfTNiuSOfmZ7O8O
         yY3fPingIN5GAaaD98/P1yMead8QfKGLre7vyQX3F1pnEo6cmxTwCDxk28s9zQIMKynC
         D/ZaZuScab+WlWL+wJ0OaAha/LowzyGeDDWvfl//Yy7NbZgjtiSU+SHbTpnA62Z+xsU8
         jECMk57H6yc0Sr0zv86MhFNxP29OB6zxUIY21A0vIJRnNYsp9Uk1iKnpRfpJRSlEGKMI
         CgeQDp4WcUGEQurpUHPu+GvGEyS8Lyv4kv+Iud3XQGm/rqgX3/qmsmuJknX92dg2M4c7
         8P8Q==
X-Gm-Message-State: AOAM530MTkdMm//KqcFqOYyQbo65xtPAETQcKzPNpCO0RlPxb+Ce+CAX
        1saOMlY8XyscJILtB+zSr6fA7BSDnCF1p6bl9Vo=
X-Google-Smtp-Source: ABdhPJzmfTAp4Sj4WVRbXm3Si8HXcxr7ff9pQ3CcSdD+6jcXlEyVCZXJw1HrD4rfTNApYpY6u/vtBTcW+BrNV5f0OxQ=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2389607oie.132.1645547893097; Tue, 22
 Feb 2022 08:38:13 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-7-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-7-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:38:02 -0500
Message-ID: <CADnq5_O_YzwjBOBv8_ifZHZQy2rmOyC5d4n1bEeL3Xw0w6JEkg@mail.gmail.com>
Subject: Re: [PATCH 06/10] drm/amd/display: Remove vupdate_int_entry definition
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
> Remove the vupdate_int_entry definition and utilization to avoid the
> following warning by Clang:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
0:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(0),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
4:2:
> note: previous initialization is here
>     vupdate_int_entry(0),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
1:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(1),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
5:2:
> note: previous initialization is here
>     vupdate_int_entry(1),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
2:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(2),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
6:2:
> note: previous initialization is here
>     vupdate_int_entry(2),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
3:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(3),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
7:2:
> note: previous initialization is here
>     vupdate_int_entry(3),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
4:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(4),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
8:2:
> note: previous initialization is here
>     vupdate_int_entry(4),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:41=
5:2:
> warning: initializer overrides prior initialization of this subobject
> [-Winitializer-overrides]
>     vupdate_no_lock_int_entry(5),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:28=
0:39:
> note: expanded from macro 'vupdate_no_lock_int_entry'
>     [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>     ^~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:40=
9:2:
> note: previous initialization is here
>     vupdate_int_entry(5),
>     ^~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn21/irq_service_dcn21.c:26=
9:39:
> note: expanded from macro 'vupdate_int_entry'
>         [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
>         ^~
> 6 warnings generated.
>
> fixes: 688f97ed ("drm/amd/display: Add vupdate_no_lock interrupts for
> DCN2.1")
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c=
 b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> index 0f15bcada4e9..717977aec6d0 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -265,14 +265,6 @@ static const struct irq_source_info_funcs vline0_irq=
_info_funcs =3D {
>                 .funcs =3D &pflip_irq_info_funcs\
>         }
>
> -#define vupdate_int_entry(reg_num)\
> -       [DC_IRQ_SOURCE_VUPDATE1 + reg_num] =3D {\
> -               IRQ_REG_ENTRY(OTG, reg_num,\
> -                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_INT_EN,\
> -                       OTG_GLOBAL_SYNC_STATUS, VUPDATE_EVENT_CLEAR),\
> -               .funcs =3D &vblank_irq_info_funcs\
> -       }
> -
>  /* vupdate_no_lock_int_entry maps to DC_IRQ_SOURCE_VUPDATEx, to match se=
mantic
>   * of DCE's DC_IRQ_SOURCE_VUPDATEx.
>   */
> @@ -401,12 +393,6 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] =3D {
>         dc_underflow_int_entry(6),
>         [DC_IRQ_SOURCE_DMCU_SCP] =3D dummy_irq_entry(),
>         [DC_IRQ_SOURCE_VBIOS_SW] =3D dummy_irq_entry(),
> -       vupdate_int_entry(0),
> -       vupdate_int_entry(1),
> -       vupdate_int_entry(2),
> -       vupdate_int_entry(3),
> -       vupdate_int_entry(4),
> -       vupdate_int_entry(5),
>         vupdate_no_lock_int_entry(0),
>         vupdate_no_lock_int_entry(1),
>         vupdate_no_lock_int_entry(2),
> --
> 2.35.1
>
