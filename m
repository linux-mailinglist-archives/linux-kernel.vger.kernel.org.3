Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0C4D1C84
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348042AbiCHP7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348959AbiCHP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:59:01 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F99F36E1D;
        Tue,  8 Mar 2022 07:58:04 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso4432442otj.0;
        Tue, 08 Mar 2022 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vvKgn0sHuAllkwYzvRFG2BC617hGBzzXAeGk4mrg70E=;
        b=G61uZlPuyejOW7T+11EayRugjx1w1CLbBDWhQ229Ng+7kH6xC73iT1VpxXwsPswKrm
         BUJZr1YHDkI/sQz4/JyawVxm42ygHfH7e1BhNAbIPrjHBmvMvX/yB3WuDIWSb8vMgJtp
         Jq1XF2Rt48ftXftNceQV0+QuOTgGCf+UsebsIEX93H3r34PaztKFoR0g2H0sxBXTFrqF
         O2p/xx+TVOGZ5oGUlD6F2wsi6hXCYvSAF7Jl2jgPHcko16zU2C1XKjOlPf3gp/3PxnA5
         QFcz5e27bcIHeURZILrgFRIfL/MmH5unYekp6LY/zT8jTfjqDcdx1xgyrHsGPe84MUOI
         SSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vvKgn0sHuAllkwYzvRFG2BC617hGBzzXAeGk4mrg70E=;
        b=AA3/K7eCyrOYv90XaRMP96cceisCFMOwKt7I1PBLBS+zzYlg5D2gUt+aGqR5n3XeJX
         CyRW3RVeL/Dwi6ZszxvUIKSGvQznoVH3I+q5JEtvpD+fOpJ2PdrwDncQz5nZj0akVwGb
         8oiHJy8tt8FHRl0kMzJadBxn1X2E/+5fOsF7U9wAKOShLTOk9lZQuw8DF3AQXsn8lnzw
         0fksnBYw7AmuyqnkxB2qsUACIR5qmlsTHOf/V+/VnujOkSWDUTOVPvEKbTme3DbP04Pd
         Uw7qP4VRUTTn39da76G4E0vVS861SpviaCO3YWY4Flsmbqcx0SAeyb8OxkHo/LPkiJka
         IeCw==
X-Gm-Message-State: AOAM530Ar13JdUJnuz5uYkrMDkeD+RZUKWqAbqjTj0FXm5z5F0DLf24i
        DjidO8KoGl8zCCFjQazYfikWYhT1ATVoshYMMZw=
X-Google-Smtp-Source: ABdhPJyUocVQDe1TT+zkXqIvkSF3HasQjSkWt8UXbdo8kc+P8zJiKM7WAw/kWuca/PmBKC4HHA/oLkhRCyAr/37/i1s=
X-Received: by 2002:a9d:4b95:0:b0:5b2:46d4:94aa with SMTP id
 k21-20020a9d4b95000000b005b246d494aamr3241251otf.117.1646755083739; Tue, 08
 Mar 2022 07:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com>
 <20220217142133.72205-2-cgzones@googlemail.com> <CAHC9VhQPZ3_dXvM9eqwsxZ2c+2mcdvNNJbtUNs_-9Md5F3P8vA@mail.gmail.com>
In-Reply-To: <CAHC9VhQPZ3_dXvM9eqwsxZ2c+2mcdvNNJbtUNs_-9Md5F3P8vA@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 8 Mar 2022 16:57:52 +0100
Message-ID: <CAJ2a_DfpYp_n8F7rg5yRAK9S8r0GcTQFHfB=d6cwRSHwMUjCyA@mail.gmail.com>
Subject: Re: [PATCH 3/5] selinux: use consistent pointer types for boolean arrays
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Austin Kim <austin.kim@lge.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Fri, 18 Feb 2022 at 17:01, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:21 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Use a consistent type of unsigned int* for boolean arrays, instead of
> > using implicit casts to and from int*.
> >
> > Reported by sparse:
> >
> >     security/selinux/selinuxfs.c:1481:30: warning: incorrect type in as=
signment (different signedness)
> >     security/selinux/selinuxfs.c:1481:30:    expected unsigned int *
> >     security/selinux/selinuxfs.c:1481:30:    got int *[addressable] val=
ues
> >     security/selinux/selinuxfs.c:1398:48: warning: incorrect type in ar=
gument 3 (different signedness)
> >     security/selinux/selinuxfs.c:1398:48:    expected int *values
> >     security/selinux/selinuxfs.c:1398:48:    got unsigned int *bool_pen=
ding_values
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > ---
> > A more invasive change would be to change all boolean arrays to bool*.
>
> I think that might be a worthwhile change, although that can happen at
> a later date.
>
> A quick general comment: please try to stick to 80-char long lines.  I
> realize Linus/checkpatch.pl has started to allow longer lines but I
> would still like SELinux to try and keep to 80-chars or under.
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/servi=
ces.c
> > index 6901dc07680d..7865926962ab 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3175,7 +3175,8 @@ int security_get_bool_value(struct selinux_state =
*state,
> >  static int security_preserve_bools(struct selinux_policy *oldpolicy,
> >                                 struct selinux_policy *newpolicy)
> >  {
> > -       int rc, *bvalues =3D NULL;
> > +       int rc;
> > +       unsigned int *bvalues =3D NULL;
>
> Doesn't this cause a type mismatch (unsigned int vs int) when an entry
> from bvalues[] is assigned to cond_bool_datum::state later in the
> security_preserve_bools() function?

Yes, but those variables *should* only hold the values 0 or 1.
But probably it's better to re-spin for 5.19 with all arrays and
cond_bool_datum::state converted to literal bool type.

>
> --
> paul-moore.com
