Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA054F4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381454AbiFQJ4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380900AbiFQJ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:56:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FF1517CC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:55:59 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3137c877092so37169197b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PWf0Adiid/6NR0detbpVfvOyZzUuHhuHWQP9z+0eVV4=;
        b=cJibWBZZJ7C8KleOk5y0GSMX3X9O/oZZFgIK4z9Ealw3fl3p7Fos33qD8MiXLUNkdd
         FIHcWVlyQa/BpeyZ1eZXzWUIArTQAqnNKIc3xttrB9YpM7DSKns+cQijGKWlXhA/yard
         PzZeZdhsM5bMVzITtzvDg5UA4+3OTLPLI5DZbGh+XhgMTmiEp5Ixx0bWWLfbpeAukQlf
         5k/1OEnIsu3RsYbWc0igNEFnOrx9irbZ6yufNG+xh+/v44CSvuXUuD2L3FoYoQWtrZt/
         lx+OUhurg43e4CGdzu2of1RhPQO3YIDapWG4Kf/rXYS1VaXo0K0TZ3/agytQGuccPhTD
         TfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PWf0Adiid/6NR0detbpVfvOyZzUuHhuHWQP9z+0eVV4=;
        b=EzT9G5t7bAXQrRkyXCyqKQYgLNzEPK1orbCplcodaNYWSh0/IK9DvMZ+rE42yBj1z0
         pwzkZ90hY0sIX9y6KKuj5pE0TiFkGyQeWfldKNQA1TzuHKdrkGFfbQHoz40DfBHpxoy7
         gZAXPlxt4z/saOT9FAwyalZbr9Fla9bjUf+gjc1vL9HOd64N4b+PbKC8fF+CyacnRhpz
         Bdz0LMJsbZnmd5FIPp2uPNfDFVxY1IbWFN4PizNFf6fulmk1BcFdTJosnhCrUFeaeAOx
         Hd5Bfb0fcgdls/4mKqSAu4Ilc+qbwwSakDwcQU9A30gHVIDXNEL1IhiABCbds6BRoPBq
         yOvA==
X-Gm-Message-State: AJIora9rvRJ+swDogl9/ajv0WD9ML33Cd+Ev3EuRcgRI80z7Hd9chOTG
        o7f2NrhX2CWU8OsCX8sS4WhIbjhDBMl+BECL+ONV1Kh2fi+77FfaA08=
X-Google-Smtp-Source: AGRyM1t8BXB67ByVPRXwJ4/ocqOVlz76zKihr0sir6Bw39yrbyrQdrx6yDxgVjDN/B+tn2EErTYRca0QjFXAIgoZleE=
X-Received: by 2002:a81:710:0:b0:317:7f22:ddcb with SMTP id
 16-20020a810710000000b003177f22ddcbmr3059890ywh.480.1655459758314; Fri, 17
 Jun 2022 02:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220617083832.85287-1-wuchi.zero@gmail.com> <YqxAJ0JiN7V1uekr@kroah.com>
In-Reply-To: <YqxAJ0JiN7V1uekr@kroah.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Fri, 17 Jun 2022 17:55:46 +0800
Message-ID: <CA+tQmHCt9x+gZJR8jt0g9pEVwdpgRSgUo6+tLECYqAMwbYx=qw@mail.gmail.com>
Subject: Re: [PATCH] lib/kobject: Simplify checking of parameters in kobj_ns_type_register.
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B46=E6=9C=8817=E6=
=97=A5=E5=91=A8=E4=BA=94 16:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Jun 17, 2022 at 04:38:32PM +0800, wuchi wrote:
> > 1. Merge checking of following code:
> >     if (type >=3D KOBJ_NS_TYPES)
> >     ...
> >     if (type <=3D KOBJ_NS_TYPE_NONE)
>
> Why?

As lib/kobjecct.c following code in kobj_ns_type_register():
  L998: enum kobj_ns_type type =3D ops->type;
  L999: int error;
  L996: int kobj_ns_type_register(const struct kobj_ns_type_operations *ops=
)
  L1001: spin_lock(&kobj_ns_type_lock);

  L1003: error =3D -EINVAL;
  L1004: if (type >=3D KOBJ_NS_TYPES)
  L1005:     goto out;

  L1007: error =3D -EINVAL;
  L1008: if (type <=3D KOBJ_NS_TYPE_NONE)
  L1009:     goto out;

  L1011: error =3D -EBUSY;
              ...
  L1018: out:
  L1019: spin_unlock(&kobj_ns_type_lock);

L1003~L1005 and L1007~1009 set twice vaule and do the similar checking.
it is redundant code, So just simplify that.

>
> > 2. Move the checking of parameters out of critical section, there is
> > no need to check that with spinlock.
>
> Why does it matter?
>

[2]:
The result is ok, but just want to reduce the critical section code,
as @ops->type is input arg and KOBJ_NS_{TYPES|TYPE_NONE} is enum, so it
seems to be better to put the checking out of spinlock.

>
> >
> > Signed-off-by: wuchi <wuchi.zero@gmail.com>
> > ---
> >  lib/kobject.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index 5f0e71ab292c..6a8b009682b8 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -996,19 +996,13 @@ static const struct kobj_ns_type_operations *kobj=
_ns_ops_tbl[KOBJ_NS_TYPES];
> >  int kobj_ns_type_register(const struct kobj_ns_type_operations *ops)
> >  {
> >       enum kobj_ns_type type =3D ops->type;
> > -     int error;
> > -
> > -     spin_lock(&kobj_ns_type_lock);
> > +     int error =3D -EBUSY;
> >
> > -     error =3D -EINVAL;
> > -     if (type >=3D KOBJ_NS_TYPES)
> > -             goto out;
> > +     if (unlikely(type >=3D KOBJ_NS_TYPES || type <=3D KOBJ_NS_TYPE_NO=
NE))
>
> Why add unlikely?  Did you measure the performance benifit?  If not,
> please never add likely/unlikely.

[3]
Yes, just want to get some performance benifit, but i am sorry for that I d=
idn't
do the test, but just see the only call in netdev_kobject_init from
net/core/net-sysfs.c:
    kobj_ns_type_register(&net_ns_type_operations);
and the type of net_ns_type_operations is KOBJ_NS_TYPE_NET which is valid.

>
> > +             return -EINVAL;
> >
> > -     error =3D -EINVAL;
> > -     if (type <=3D KOBJ_NS_TYPE_NONE)
> > -             goto out;
> > +     spin_lock(&kobj_ns_type_lock);
> >
> > -     error =3D -EBUSY;
>
>
> How did you test this?  What is the benefit?

As the reply [2] [3] snippet, and just for a little bit of possible
performance to reduce the
preempt_disable time though it just called when system is bootting.

thanks for greg k-h's time
