Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACA463223
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhK3LVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235674AbhK3LVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:21:01 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:17:42 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so8273676otu.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vi8MbxG85CYq9CNpZ44LAbBeodXmRyoupGjEHyG65DY=;
        b=iXezmFuJH1+Hgbo84C2QcMaXq6A4xQh3hOkRD9HWk7yHCPke2h6HeTl5PIURVm4tMU
         z9cH+9PY0fZy04TPo5fq33vjbfBhBHtwkn3HckuoJ9dulZNoeg9D4uG45Shx6WVqaeRh
         tbi98kBIcEmV93EKb49a2PP5+bgTw3o5Ni2CI5sNR92YWsIXIrpBWkpCLbcYhvbaAzK7
         aCZxW9hrP+Aij4zvRy4VwVybWiI6G/Hs6Q34Zog+2O6kS7iJZaUZzB9cjd+Vw0dOp8l1
         U5NNQndYtFX4Ei+IHUWknENj+emjKSvchbGOYwcydulPKJAmaBw0gNuzLJglsA3J1hU6
         GqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vi8MbxG85CYq9CNpZ44LAbBeodXmRyoupGjEHyG65DY=;
        b=bN9OVUFdUuYclIRdz0gpTygQioKAakoTeV2oyLcKKsPUH7Wr2pePWYukdVf+Gwx/ii
         1DHz8UyDKn6uBHMbPuJKCmL56ANxdHQcdLihpbkTvY2DpTum4rVZHvsxT1r8Gq5rvPR1
         Nd26H8/NKRGUsLPpqaBjhICvdfb1k+ON1lgRO46BryKygd29WtGpP99Bjh9SZrNFirf3
         IyV38EgWR5WgpRflK5AU2IXaeIy4qTPKcAp4ey0+Y8Xh/yQnpJDjtVd5tMYQl1krfwGz
         2LXwG3p032ldYWZPtNbLfgBnokz/X+X4ZRR9pZHp8OP0MMSleu/sPDwj83OoijiVtQJa
         yjGg==
X-Gm-Message-State: AOAM532I5IuS5OqFECPHFXasjoXfvGDAazZd6Cw0vIczmkWlHJPrKwTh
        nC5uegSosGLW7eb4jVJ650S0mLqFqHX9PaaKwzUJU0L0AyQ=
X-Google-Smtp-Source: ABdhPJzFuM1afuBfC8qppB4kUGyroaS87FAAfDg3iDhWzguxH+Ey/QnltKVZi8ZXLaP1OaZfp0JpspEBQSMDCMbLq5E=
X-Received: by 2002:a9d:326:: with SMTP id 35mr49780081otv.41.1638271062090;
 Tue, 30 Nov 2021 03:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20211129221346.365883-1-makvihas@gmail.com> <20211130094727.GT6514@kadam>
In-Reply-To: <20211130094727.GT6514@kadam>
From:   Vihas Mak <makvihas@gmail.com>
Date:   Tue, 30 Nov 2021 16:47:31 +0530
Message-ID: <CAH1kMwTbjN4_fqG94j4Ei2SWmjSsjanwMaSJrk4M6kGOzfB9fw@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: use ARRAY_SIZE() macro and fix
 camelcase issues
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Get rid of both the "arraylen" and "array" variables.  They only obscure
>> what the code is doing.  You may need to do additional clean up to make
>> it work without making the lines too long...
Alright.


On Tue, Nov 30, 2021 at 3:18 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Nov 30, 2021 at 03:43:47AM +0530, Vihas Mak wrote:
> > Fix camelcase warnings from checkpatch.pl and use ARRAY_SIZE()
> > to make the code cleaner and avoid following cocci warnings:
> >
> >       drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c:142:51-52: WARNING: Use ARRAY_SIZE
> >       drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:174:52-53: WARNING: Use ARRAY_SIZE
> >       drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:450:52-53: WARNING: Use ARRAY_SIZE
> >       drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c:655:49-50: WARNING: Use ARRAY_SIZE
> >       drivers/staging/r8188eu/hal/HalHWImg8188E_MAC.c:136:50-51: WARNING: Use ARRAY_SIZE
> >
> > Signed-off-by: Vihas Mak <makvihas@gmail.com>
> > ---
> >  .../staging/r8188eu/hal/HalHWImg8188E_BB.c    |  6 ++---
> >  .../staging/r8188eu/hal/HalHWImg8188E_MAC.c   |  2 +-
> >  .../staging/r8188eu/hal/HalHWImg8188E_RF.c    | 24 +++++++++----------
> >  3 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> > index f6e4243e0..ce46b3651 100644
> > --- a/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> > +++ b/drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c
> > @@ -171,7 +171,7 @@ enum HAL_STATUS ODM_ReadAndConfig_AGC_TAB_1T_8188E(struct odm_dm_struct *dm_odm)
> >  {
> >       u32     hex         = 0;
> >       u32     i           = 0;
> > -     u32     arraylen    = sizeof(array_agc_tab_1t_8188e) / sizeof(u32);
> > +     u32     arraylen    = ARRAY_SIZE(array_agc_tab_1t_8188e);
> >       u32    *array       = array_agc_tab_1t_8188e;
>
> Get rid of both the "arraylen" and "array" variables.  They only obscure
> what the code is doing.  You may need to do additional clean up to make
> it work without making the lines too long...
>
> Same for the rest.
>
> If that is too complicated then it's fine too, just leave it as-is for
> now.  I know that sometimes people just want to silence the checkpatch
> warnings but I prefer to keep the warning as a marker for bad code so
> let's leave it until someone can fix this in the correct way.
>
> regards,
> dan carpenter
>


--
Thanks,
Vihas
