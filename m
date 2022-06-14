Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703F354A34D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 02:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiFNAxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 20:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbiFNAxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 20:53:11 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9070A47D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:53:10 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id r82so12574844ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xpKoRC+jwQM/TE7zoR6njYywYa0xdPUzl/QI3qKrqR4=;
        b=R9e+8ya7HmN+rSK/ExFtG8j5LSj7tmxjhoikGEBFDMzGFjz4HHmN+lc/JXDQdtgsE8
         4CgP/+V0eae4QsTDjnJit2BIfy+1grFEdcuOyxFSdkOnzW5TzdXF7IZ2GX9tdzG5mRGe
         V5SNZ8qE3BYwg17E9LIy90dbd4WoZlI5N8EIXpLYcdsE+4Dd/K4O9YqdX1plLtW3/MWa
         38ApCY0VpdMV5syiO4QHnTzNtg+8inSLhnm4p2g2O9GKGe5jfGqKwdduwp0juTmHHKzN
         LPT+5HkrStorGLxT8J2ZHKpLZiGk3vXpS7RwMkwUvjhSyg6hBs8gXN4nxNJXB2ZTn9lm
         /Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xpKoRC+jwQM/TE7zoR6njYywYa0xdPUzl/QI3qKrqR4=;
        b=PeADrSr/q5Hv22Dud/NF1Tq+4wRIDP2DmWYkgbh7NLy+pgLzovY97n93TqYJ5xB+J0
         UhxRmAYOl2o2tK4XWb6ViBMnFS+CExeOfuJlOSYQWoMEidtIxm16ESuhoNXzwo+ukxIq
         UKi8KYgVj539QKat2kiDsAOrk8kYiEpWMsJLOukNr5o/IbwShRAhzc1+/zMb1Mgzgvi1
         gH9DlIvlNaXxlgKVdGTIbJKVseV/8yeVVbuulpEZYhOhKkk6BkOtyGMEY95CRnccP8Xn
         vR9GQjTjPqQrhot4+yxty3f80FqosF5QO1HF2htAZIRZKuCoaQ9g6d2tYZ+9mhNDrg3x
         frjQ==
X-Gm-Message-State: AJIora8Jb9B6c7WedioOGa6tWRICcObSaTeB/kKgRFXjU1ssxO+QEk2i
        A7pq4me8VW900OkzgDV0FNEblSmfP65yGfgzkw==
X-Google-Smtp-Source: AGRyM1sZAzxnmRwBl9jUt+2fb5jBD734EHnA2rxZ7epu8PcJ3lz+e4v+FGbpHvfJRLUM4E4SOWk6f2zRspIGVgzB6gc=
X-Received: by 2002:a5b:c51:0:b0:65c:af16:d7cf with SMTP id
 d17-20020a5b0c51000000b0065caf16d7cfmr2320624ybr.397.1655167990261; Mon, 13
 Jun 2022 17:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220612071535.1179039-1-sunliming@kylinos.cn> <Yqb9VoYe+D69KYTY@noodles-fedora.dhcp.thefacebook.com>
In-Reply-To: <Yqb9VoYe+D69KYTY@noodles-fedora.dhcp.thefacebook.com>
From:   sunliming <kelulanainsley@gmail.com>
Date:   Tue, 14 Jun 2022 08:52:59 +0800
Message-ID: <CAJncD7ToFdEWW70Suf1=STwOK8vzTgkgF1tQMu3GL-n=ffoRPw@mail.gmail.com>
Subject: Re: [PATCH RESEND] of: Add missing function declarations
To:     Jonathan McDowell <noodles@fb.com>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
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

OK=EF=BC=8Cthanks

Jonathan McDowell <noodles@fb.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 17:03=E5=86=99=E9=81=93=EF=BC=9A
>
> NAK. This is for a patch of mine that I don't believe has hit mainline
> yet - I've only seen it in daveh's test tree. The prototypes for these
> functions are now guarded by CONFIG_HAVE_IMA_KEXEC but all OF platforms
> build them even when the platform doesn't actually support IMA over
> kexec. I'll update my patch to avoid that.
>
> On Sun, Jun 12, 2022 at 03:15:35PM +0800, sunliming wrote:
> > Fixes the following w1 warning:
> >
> > drivers/of/kexec.c:126:5: warning: no previous prototype for 'ima_get_k=
exec_buffer' [-Wmissing-prototypes]
> > drivers/of/kexec.c:153:5: warning: no previous prototype for 'ima_free_=
kexec_buffer' [-Wmissing-prototypes
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: sunliming <sunliming@kylinos.cn>
> > ---
> >  include/linux/of.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index f0a5d6b10c5a..3a166a1c4ef6 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -844,6 +844,16 @@ static inline phys_addr_t of_dma_get_max_cpu_addre=
ss(struct device_node *np)
> >       return PHYS_ADDR_MAX;
> >  }
> >
> > +static inline int ima_get_kexec_buffer(void **addr, size_t *size)
> > +{
> > +        return -ENOSYS;
> > +}
> > +
> > +static inline int ima_free_kexec_buffer(void **addr, size_t *size)
> > +{
> > +        return -ENOSYS;
> > +}
> > +
> >  #define of_match_ptr(_ptr)   NULL
> >  #define of_match_node(_matches, _node)       NULL
> >  #endif /* CONFIG_OF */
> > --
> > 2.25.1
> >
