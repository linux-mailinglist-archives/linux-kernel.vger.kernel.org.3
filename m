Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F834EEE11
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346313AbiDAN2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346305AbiDAN2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:28:19 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079321E5A76
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:26:29 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-dacc470e03so2673620fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lSOTdsVE0ZLDEykC7YpcLsTm8m5xnJaxpsAzG7AskyA=;
        b=DPjOVqd6sczWiem7CVMNGNIsxfRmqaAw0T7Vr3T+7ra3ub8PliNU6apv5gb5/0VTaJ
         +VZWu9Zf61/miMv8qdkDDOQCEtQa7dn3DzGxPlfXFBLF94FCJkoPfzk5SrZMuF/JWAYO
         te2pEENMNzGA+l39vajx8HsOUy/kSQgIhQDAMVdGXyHzsnQ3qQF7bjcey2cZFMRlbZC6
         YCBjmJpal0oOr4yMVtwlzVuueWvUPxlbmi0f5syjcKawKtEVEPaUZ4ojGsr8Wn9isahV
         +upeEgosPhLb59qGTPXofzgjPbvwYsaA1G1ttCQzZnYnElTeXxDa6WYIq1reJqYyvaKW
         keYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lSOTdsVE0ZLDEykC7YpcLsTm8m5xnJaxpsAzG7AskyA=;
        b=ZdkLZnl7bEqjaxATaNS903km44EndKMJGwIN2hKVv9sb//q/6yxM6FPrXoOQT7WYcI
         fQV0hDWSW1fp+Lo66128em9PozbwtxhqsxK8Jwbx22+2TiS3ju9wSFKF13OoXQ83YFPQ
         XmIPvLEiS2wJF+t/S6BSeiTD9yImQoPfhXbeopRv735F32zhIHWKkApxAI8n2tjHiPaL
         E7DeL6M0DrN9mSh0rs5gDQWGyENqPkXePaMzMSOF+s8Yi1WD2wK+C5p5YoNxk2+mT3Nv
         ZiHaPwTmiQmhjHGcXVXPjs1VMzehS/RQxd7dRSk91lXcWtA61wG4pH0ymwjyzhm92Ulm
         o7rA==
X-Gm-Message-State: AOAM532vK0UfUQTraVaZmDNG21wrf5vEoipSEynM5YXPSLQKHeYMrYkW
        Z0AwH89WBh27zieegoxpvsVpHIrXzMuq564u9kbNl3l9
X-Google-Smtp-Source: ABdhPJxgN9DZ7VfGH4Ogv6rAyXbwrEE6/Fq4Zz5D3iZ1jysSTFxGBV4Q5s/n9B+qBB0Ua0dP70POnievRyeeTITMBVo=
X-Received: by 2002:a05:6870:311d:b0:de:9b6c:362b with SMTP id
 v29-20020a056870311d00b000de9b6c362bmr4721650oaa.200.1648819586647; Fri, 01
 Apr 2022 06:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <1648706190-4596-1-git-send-email-baihaowen@meizu.com> <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de>
In-Reply-To: <2a2b1f76-7e9b-9561-e190-16d808eb5399@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Apr 2022 09:26:15 -0400
Message-ID: <CADnq5_Nc7BU7235ZGN6iBq9iV50UcjC6aUpGr2qBnAA1fwMpKQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: remove Unneeded semicolon
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Haowen Bai <baihaowen@meizu.com>, David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Fri, Apr 1, 2022 at 1:54 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Haowen,
>
>
> Thank you for your patch.
>
> Am 31.03.22 um 07:56 schrieb Haowen Bai:
>
> In the commit message summary, please use:
>
> Remove unneeded semicolon
>
> > report by coccicheck:
> > drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c:1951:2-3: Unneeded semicolon
> >
> > fixed c543dcb ("drm/amdgpu/vcn: Add VCN ras error query support")
>
> Please use
>
> Fixes: =E2=80=A6
>
> and a commit hash length of 12 characters. (`scripts/checkpatch.pl =E2=80=
=A6`
> should tell you about this.)

I don't know that you need to add a fixes tag unless the patch is an
actual bug fix.  Coding style or spelling fixes are not really
critical for getting into stable trees.

Alex

>
>
> Kind regards,
>
> Paul
>
>
> > Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v2_5.c
> > index 3e1de8c..17d44be 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > @@ -1948,7 +1948,7 @@ static uint32_t vcn_v2_6_query_poison_by_instance=
(struct amdgpu_device *adev,
> >               break;
> >       default:
> >               break;
> > -     };
> > +     }
> >
> >       if (poison_stat)
> >               dev_info(adev->dev, "Poison detected in VCN%d, sub_block%=
d\n",
