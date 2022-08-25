Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411265A161B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbiHYPsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiHYPs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:48:29 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1463AF4A5;
        Thu, 25 Aug 2022 08:48:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso17267295fac.7;
        Thu, 25 Aug 2022 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rC53qN5yRBX9ZLsKfXDzVV2nrRF5/aNN8DjC44zGscI=;
        b=A0wiYuHXOtVAdx2cVF9d2wu+8j7RuzDlcZHcvl8ofIHEEXtlf+xc94cvYQ1CVpjuP0
         g4MDq5HPhXx/OVskoS7i9u+mBlp7duwdKzulo4EoUjPdVCYfpAwyopCo0RuuIl5M7MLr
         ijMGzPwPHZ2SFPWMNtSqeAuEJm7QA02g2R4W3AYZhak8c/TG61KVixlQMOeMQ2gy+W8N
         MV+Mrms8kJPoSIxbLiM0bFjt+AWBf3+7KyzZggiZIqPe39CZZ5VAJWOA2LHTgEhnA3h8
         z/Zs0L3ZbVdQhqzMmdWLDtDjPYfUqKgn2n1OUgzfRGhphs2SuXLAnMmbAGECmbI49wIO
         J2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rC53qN5yRBX9ZLsKfXDzVV2nrRF5/aNN8DjC44zGscI=;
        b=mTpXaHYPynisN3flJxKXEfrTKOmG0HwWP0Wi9FP56euLGPY/ZUal13z7PWdEBDMqc2
         HRUGu01rQtyClSQFCLby3EjScZ8jKoW/LrDIsiGn/VvtXM14d2nHuxjVY6wrx4GC9Pbt
         kEe/LUJifG2bJfNqMu38fP9U37zKjtav5TiVskCSIK6JeudiPFoNd7vKzKkQf7Ncu8M1
         73vUia76He0oflR1a3+TMQvkOakAC/YcscCH9MpHMAhoJxjfu/oOWAMLTG89AsWwkDHD
         rv5rAh2vVCArS2vFJWoJlHbVCWSYRZWT1FBI/lOS4bp++ZFUai7j/bgiiRCBv3I4P/GF
         5cMg==
X-Gm-Message-State: ACgBeo1T8A3gAojnlrYBl9gE92/3MnhZzdWm7z+0zNaqk1iqorCuS5X6
        Q2rK8D7P0nzGAWZiDqS20N1nr8eOaaW8afDQTzO4/bWh
X-Google-Smtp-Source: AA6agR66nazVE3wlDfBDgpR68PAF2BHkFwZ8PKhcLRIYlt01toN6Li6zbn6KfQDEiOBKqACWN3ASLpAdpnUxxYd6B50=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr674391oah.46.1661442508241; Thu, 25 Aug
 2022 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <1831630.tdWV9SEqCh@kreacher> <8cb42207-b04c-7222-08fa-60c8eb0b3521@amd.com>
In-Reply-To: <8cb42207-b04c-7222-08fa-60c8eb0b3521@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 25 Aug 2022 11:48:17 -0400
Message-ID: <CADnq5_MrV4o6V34QBxbdKdqHEBgAPYAvqjWZmShDa8RM8hdRng@mail.gmail.com>
Subject: Re: [PATCH] drm: amd: amdgpu: ACPI: Add comment about ACPI_FADT_LOW_POWER_S0
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Aug 25, 2022 at 3:58 AM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 8/24/2022 12:32, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > According to the ACPI specification [1], the ACPI_FADT_LOW_POWER_S0
> > flag merely means that it is better to use low-power S0 idle on the
> > given platform than S3 (provided that the latter is supported) and it
> > doesn't preclude using either of them (which of them will be used
> > depends on the choices made by user space).
> >
> > However, on some systems that flag is used to indicate whether or not
> > to enable special firmware mechanics allowing the system to save more
> > energy when suspended to idle.  If that flag is unset, doing so is
> > generally risky.
> >
> > Accordingly, add a comment to explain the ACPI_FADT_LOW_POWER_S0 check
> > in amdgpu_acpi_is_s0ix_active(), the purpose of which is otherwise
> > somewhat unclear.
> >
> > Link: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2Fuefi.org%2Fspecs%2FACPI%2F6.4%2F05_ACPI_Software_Programming_Model%2FACP=
I_Software_Programming_Model.html%23fixed-acpi-description-table-fadt&amp;d=
ata=3D05%7C01%7Cmario.limonciello%40amd.com%7Cf43320dda5114deeb16908da85f69=
d3b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637969591512297179%7CUnkno=
wn%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC=
I6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dxp8pNzsXCkLcIJOJFY77yaLkMrvz5he3S%2Bi%=
2FwaxTwwg%3D&amp;reserved=3D0 # [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > Index: linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-pm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -1066,6 +1066,12 @@ bool amdgpu_acpi_is_s0ix_active(struct a
> >           (pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE))
> >               return false;
> >
> > +     /*
> > +      * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is genera=
lly
> > +      * risky to do any special firmware-related preparations for ente=
ring
> > +      * S0ix even though the system is suspending to idle, so return f=
alse
> > +      * in that case.
> > +      */
> >       if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
> >               dev_warn_once(adev->dev,
> >                             "Power consumption will be higher as BIOS h=
as not been configured for suspend-to-idle.\n"
> >
> >
> >
>
