Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D393A474BD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhLNTXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbhLNTXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:23:35 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037ACC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:23:35 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso5203183ooa.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ly7ashr0Abfix6SoCDJYNsr0pgjAfUrtoNa4BxcGFmI=;
        b=DaubiwHwzJwXsWIRixjWAKO7YA+Njfarz7GWWLXaUfA2fcW40KoSMkWIh3y/Zkdxyh
         BdXsnDNnEGn2GhdebKFdq7tXv/4MW3ZEK7emL9lvnOVwIPB8udu9qVCEX085iBt40FAe
         eGrE6OmNnQjO/CHduWdRD9ucpoUFbkz+H6f+3IQox3dSQU4SYvd89vx/JvAJQFhrPmMl
         D0h14/RP1SoYbCNAbMbEV5rI3Bnsc2shomrnanhui91YPDbEzrbz/2BQ6GPWWxUVpV6P
         BsvQNY8RMOOQmXMxpnIi7V06SBq6apMW3fz80Tu4fpGNFJDDYjYP4qF0xN5mKRb3Vr+3
         sSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ly7ashr0Abfix6SoCDJYNsr0pgjAfUrtoNa4BxcGFmI=;
        b=Oci9MiBTID/gzPiDoVENRDRrfgpsrzb3GQlN4UkcDnzvDD1YgK3Pp+zJZ5CJfCcGd6
         e2JyA1Ht2pCBNVqkMlCCHSooTMG0erOJs2lycLn7QJyO2dM9kpiq9gfKAPN9ZRF2gp+H
         MIc9REyEkc9MEBbyIB+S0cU+xvo1n81vLFEto8Qp7AAHV4xKyPZpct8wkN1q9RrT2PMT
         5C8ct7a/ytDsIrExORpXfdP9JFOrm7U6ReDydZ+dxvX2a34C1BiDfCjC8+z+mmyV6RXb
         F9ugySorxrXMoVGAIVJHRWB3wtdmTP2IhxIokYs1TMIt/0LcFnxtJgp7OMh4NuaZnts5
         POqw==
X-Gm-Message-State: AOAM531F6YOWUo0yTYHF7dYOQsiZiLC/A7V6MTlTLc1l7yEtwWn7BAXO
        kuaLgCfiVmzlnvBMyinl5Z52oU8O1VlpW3T2KJA/oD4A
X-Google-Smtp-Source: ABdhPJz/pMYwME4RUdHlSZKIwCyCbYPbaG8SyeKTNS+1TSa4EuIzL7K2wrWvAQGoXRVaGW3cZxi1o4susTjozQai9T8=
X-Received: by 2002:a4a:8701:: with SMTP id z1mr4746722ooh.68.1639509814392;
 Tue, 14 Dec 2021 11:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20211214135217.24444-1-wangxiang@cdjrlc.com> <ba96bb4f-1666-32a2-68a9-8fe3d6e2c10e@gmail.com>
In-Reply-To: <ba96bb4f-1666-32a2-68a9-8fe3d6e2c10e@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Dec 2021 14:23:23 -0500
Message-ID: <CADnq5_M_VJ7jisaqJuq9x7GrUjQHCDLDJmwo+KNUpPuYgQEwxQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix syntax errors in comments
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Xiang wangx <wangxiang@cdjrlc.com>, Dave Airlie <airlied@linux.ie>,
        xinhui pan <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Tue, Dec 14, 2021 at 9:54 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.12.21 um 14:52 schrieb Xiang wangx:
> > Delete the redundant word 'we'.
> >
> > Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
>
> Well not a syntax error in the sense of a coding error, but valid fix
> anyway :)
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_vce.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/rade=
on/radeon_vce.c
> > index 511a942e851d..ca4a36464340 100644
> > --- a/drivers/gpu/drm/radeon/radeon_vce.c
> > +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> > @@ -513,7 +513,7 @@ int radeon_vce_cs_reloc(struct radeon_cs_parser *p,=
 int lo, int hi,
> >    * @allocated: allocated a new handle?
> >    *
> >    * Validates the handle and return the found session index or -EINVAL
> > - * we we don't have another free session index.
> > + * we don't have another free session index.
> >    */
> >   static int radeon_vce_validate_handle(struct radeon_cs_parser *p,
> >                                     uint32_t handle, bool *allocated)
>
