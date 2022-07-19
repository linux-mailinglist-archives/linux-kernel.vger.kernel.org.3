Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8250957A76A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239631AbiGSTuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:50:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBDE52443
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:50:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ez10so29149834ejc.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MP2mNoHV5UbwTy8FhxrYTOnqC74G4vp1u8y7Ih8i6Gk=;
        b=HXOii4OqRMngJ85erwxpuDjSbMYDxJE4qXyd0P9MRABSLjttvKm45KAun5SY4VCsS9
         K6C42blnp93B2q6MMIefScXhep5eIC8mYUjr74y6OqyIbz9jpyrahwzV9pQKGpDl5ZXI
         LF21HIlI+tl05fwyzoavG+zd5I4vZCiVi97GTM/8zqbX8PVtQN9o21tshr4q1XUk0itr
         AI1Fn7jaeYQTngHANbBxE+ByFuVmTXgKT25Me4aYipyD0AeDcr5yo2p5V0qcCcMWtsxw
         jUeGzE9acPC8dcwn5DxwBBIj+DcFc6jt0uW4FOqbflK/luDSDKdNf80NOlIn3vCEla7C
         ADbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MP2mNoHV5UbwTy8FhxrYTOnqC74G4vp1u8y7Ih8i6Gk=;
        b=euBE2TEhQ+RdIB3zj2T9/NdU1uaa7czncwfBgcxjUpgb7/MLpXxUodb7vA9rZWW2Dc
         SL/7qhtsklu9smldOJG1bR9OO6OFhDy7mpLTn1Y/iOW5sQ9QaOZLfY27lv34V3cziX6s
         q3zV4P7y2wk2MXOcqRvWqbACv6aqRCK10LPO+hS/J9MOMBtgSE51gXTW2MwGbZugWaYB
         Ee505J/L1TZ/Tmi1FLhIPPH6mFRvtmG+3hevV9k7E18/UF/nBAMS52rveR19rJ42UkUr
         UoE/CmpfaGQyA45BaR7c+KTG/P5KI6sgUKGiRkMAxlc7iWfxQ1mvzUpl+uuSEBVuQQrZ
         OzyQ==
X-Gm-Message-State: AJIora+hXAPXSbgZ0FYf00BlSKLztzCEdlepQPy4PObqhDurt1e2ozVt
        Nago+AyL9zOYiBp1CofkGo0sXitarHeXSzAqm3Y=
X-Google-Smtp-Source: AGRyM1u6s0KwsJBJwcN1pS55Zw9h79wwsGyapUUrqQkHflO0aWasIqdqMC6rDczKC50rhDnaYsEeROk2BJOIpddn6Oc=
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id
 hb35-20020a170907162300b0072b64e3878amr33075752ejc.185.1658260246316; Tue, 19
 Jul 2022 12:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220716035732.30449-1-wangborong@cdjrlc.com> <ada7fc21-17e3-d3e0-5316-55ee6669ccd3@amd.com>
In-Reply-To: <ada7fc21-17e3-d3e0-5316-55ee6669ccd3@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 19 Jul 2022 15:50:34 -0400
Message-ID: <CADnq5_PtDTX0WBxW9e4SbzLnm15XTsir++26tp0YLnknAdNdYg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Fix comment typo
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jason Wang <wangborong@cdjrlc.com>, daniel@ffwll.ch,
        airlied@linux.ie, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jul 19, 2022 at 8:33 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.07.22 um 05:57 schrieb Jason Wang:
> > The double `have' is duplicated in line 696, remove one.
> >
> > Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >   drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/rade=
on/radeon_gem.c
> > index 84843b3b3aef..261fcbae88d7 100644
> > --- a/drivers/gpu/drm/radeon/radeon_gem.c
> > +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> > @@ -693,7 +693,7 @@ int radeon_gem_va_ioctl(struct drm_device *dev, voi=
d *data,
> >       }
> >
> >       /* !! DONT REMOVE !!
> > -      * We don't support vm_id yet, to be sure we don't have have brok=
en
> > +      * We don't support vm_id yet, to be sure we don't have broken
> >        * userspace, reject anyone trying to use non 0 value thus moving
> >        * forward we can use those fields without breaking existant user=
space
> >        */
>
