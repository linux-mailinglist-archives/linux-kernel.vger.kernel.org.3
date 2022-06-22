Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231B455537B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376692AbiFVSr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiFVSr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:47:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C832DD48
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:47:25 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t5so3661682eje.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G+CACZy3Mxqt2TdD/PGEXumJzA2wixKKRDT9daZiP3c=;
        b=o6jn9j2lXpVzeSsFW8lIMJD2FICQqWpBbxlCNOxwbXeMpjJTeD58bupZS2q24Cmlfk
         SPxeRixrduH/9d5it/xQvKGeUzVawm3ooAubTb1JgYmD5O6GlzDxZcKN60JQ4A+B6jPn
         Ri1abaj9MmmCcWw/fKs6ISKZTO/CN39vc1d91NHjLXeNEGYSGYsCXnJXnaWUi4/zLj5C
         YPCllGolqmZA7mBCALskOYOlfoxoneJ8ToXJ9D30ndSVIGSg9btK5c6VpRFvnWmiZzDd
         9ngDr++brL0QJ5OIzADsAUd8QWrBItO+sPzHIMtW+RM5Crg+vgye0fHRV38DQID8EEuM
         Vhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G+CACZy3Mxqt2TdD/PGEXumJzA2wixKKRDT9daZiP3c=;
        b=YSF6z6t1MDn2yfvFHqzZI5JiDcspUlBt4WMtvCc3c2+YLtHn9pFEHnYh8K8WJqMvH/
         /Muta49stzio9jaUQAB41DTMs4rxnAa/6QehVE0joDtA6pALvqs7G8lnttEC2uMpOmJd
         uB8r8GzmBvwlT9PK1ZuHGIe6XW0pDFr1G+7o7sxkYBBDpfhrYQu/gz1CILHDZu+2FiXf
         NomaDj0zfSuR8szL82z7TytpNpKJYys+VGrBMOWu/85rscXUD4Ojx6F/yD8UHJ+NCMM6
         Z6n1NNH5CWzxk9rk0/zYASO31t+HcTxB2eGwNGZ1pNt+U1lPkBtQyebNZ++ptKs9uCP/
         P5Lg==
X-Gm-Message-State: AJIora8e9Y7FEEhX+mwfnwi6vQYlr7bttwlU6J0g48ryiHODtNKy3xXh
        TuzcWbPdah6Ml+Ja83CTEjJvFSqlnBmUNYr91zQ=
X-Google-Smtp-Source: AGRyM1uvOjttkKJarHebvSGxiaguvPTg97iaFQSlND6h0S/OvEothPCoC+FRjaPv1QR0gPFXvDB3yBSKili0mzPRkhE=
X-Received: by 2002:a17:906:74c2:b0:722:e1e2:edea with SMTP id
 z2-20020a17090674c200b00722e1e2edeamr4536987ejl.658.1655923643901; Wed, 22
 Jun 2022 11:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220621203921.3594920-1-cmllamas@google.com> <uvR86emMYmXwy4OxDiY5OlpRs9UIoEce59p_VukwHwNa368FpqXYVtN7tqccW6WzG5Vz08ycVdxXonbMczsohHw8O8Dx7WdJv8pnrYb9V34=@emersion.fr>
In-Reply-To: <uvR86emMYmXwy4OxDiY5OlpRs9UIoEce59p_VukwHwNa368FpqXYVtN7tqccW6WzG5Vz08ycVdxXonbMczsohHw8O8Dx7WdJv8pnrYb9V34=@emersion.fr>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 22 Jun 2022 14:47:12 -0400
Message-ID: <CADnq5_MLUi5LL0cXFU=1m3r_TEWw=rTSXHm3V+6NYT_LfdmK+A@mail.gmail.com>
Subject: Re: [PATCH] drm/fourcc: fix integer type usage in uapi header
To:     Simon Ser <contact@emersion.fr>
Cc:     Carlos Llamas <cmllamas@google.com>,
        David Airlie <airlied@linux.ie>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>
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

On Wed, Jun 22, 2022 at 3:02 AM Simon Ser <contact@emersion.fr> wrote:
>
> On Tuesday, June 21st, 2022 at 22:39, Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> > Kernel uapi headers are supposed to use __[us]{8,16,32,64} types define=
d
> > by <linux/types.h> as opposed to 'uint32_t' and similar. See [1] for th=
e
> > relevant discussion about this topic. In this particular case, the usag=
e
> > of 'uint64_t' escaped headers_check as these macros are not being calle=
d
> > here. However, the following program triggers a compilation error:
> >
> >   #include <drm/drm_fourcc.h>
> >
> >   int main()
> >   {
> >       unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
> >       return 0;
> >   }
> >
> > gcc error:
> >   drm.c:5:27: error: =E2=80=98uint64_t=E2=80=99 undeclared (first use i=
n this function)
> >       5 |         unsigned long x =3D AMD_FMT_MOD_CLEAR(RB);
> >         |                           ^~~~~~~~~~~~~~~~~
> >
> > This patch changes AMD_FMT_MOD_{SET,CLEAR} macros to use the correct
> > integer types, which fixes the above issue.
> >
> >   [1] https://lkml.org/lkml/2019/6/5/18
> >
> > Fixes: 8ba16d599374 ("drm/fourcc: Add AMD DRM modifiers.")
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
>
> Reviewed-by: Simon Ser <contact@emersion.fr>
>
> Cc'ing Bas as well
>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourc=
c.h
> > index f1972154a594..0980678d502d 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -1444,11 +1444,11 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64=
 modifier)
> >  #define AMD_FMT_MOD_PIPE_MASK 0x7
> >
> >  #define AMD_FMT_MOD_SET(field, value) \
> > -     ((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
> > +     ((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
> >  #define AMD_FMT_MOD_GET(field, value) \
> >       (((value) >> AMD_FMT_MOD_##field##_SHIFT) & AMD_FMT_MOD_##field##=
_MASK)
> >  #define AMD_FMT_MOD_CLEAR(field) \
> > -     (~((uint64_t)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_=
SHIFT))
> > +     (~((__u64)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHI=
FT))
> >
> >  #if defined(__cplusplus)
> >  }
> > --
> > 2.37.0.rc0.104.g0611611a94-goog
