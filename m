Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0A47731C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhLPN2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhLPN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:28:20 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F158C061574;
        Thu, 16 Dec 2021 05:28:20 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v203so64626520ybe.6;
        Thu, 16 Dec 2021 05:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7s1gf+Z5ga1LfUPoHmd/2M7U9UPHln3sHkGkN27dFM=;
        b=hE7Mfoja/1UUqKB4+pZPKwUBglu2XOKq0alsUxWV7sWnB3FbjRbpq3aQoT4jxZ0ehf
         DB/Z9K0wqHxuXUEnntV1qCnkn9YBj3R9TWewOy1il329TGsPnaCF9XJJKNvdR3nYWLRE
         ARYFeFwkxCLdLvmgGMtoKFUC89569erRynUjl8wgjh17zmwSzwIuYTvuyhxqMYYm7Z6V
         k0+XT2AoRauZnGsJ+Mf/3h3BZDANt3cZjwHHiXOptOEtTJSDji6IojIYSgsuiMgFNkXE
         4meaTRHKMeL1Y16P6kwC4jO2pppcN/NxHsyJo9johhkK/jJqhBGkBROcjhBR84faJEd2
         qEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7s1gf+Z5ga1LfUPoHmd/2M7U9UPHln3sHkGkN27dFM=;
        b=tEHxy3ZEuePqmnl5iHfb/QKeUz/ln4kge528jloJKydQjTStaZcaFUD8KiU8kj0S7n
         5O4wguPg4pHi6r4hdoOXCmMaqkKFxI1NXa7NO451vPH9b/qfyFAdkrMqW94ne8jqTtrO
         LgpQf67nOi6JpNE3PLfP3m3pTYI+mHxDSO+9gmRGPVJso1hJ9Znhl7b6JE2sZyIqKMab
         Ln6v5O0D9/FM51M3OOm7xX4RjL0VOd0du7X12Zd0Z60x7Jf/Atp3ylQKySpQM/bRmUrl
         HOSpXS74SGM0HsN/nz6CCtlEyJHo0klkqBoUjGnfI08sLXe4M2vRsdn861lQ7TyQopNa
         8IKw==
X-Gm-Message-State: AOAM533IUj8/Afmm0vjwQ+YxI7O22D5QARcZ/+zc6IJseuAxPybyo74K
        HMaXGLJIBY6Fsvj6g4dzP+To/5/uhBPBfcyYlNE=
X-Google-Smtp-Source: ABdhPJxnX2drLjDfDQNfdkAATdf9Rm/efs9K89jAJkZPW4D3DEQ5uNHgajZge/zwpHrF9YaNhnbrqdVTPQKM41kpkPc=
X-Received: by 2002:a25:3b04:: with SMTP id i4mr12248819yba.767.1639661299661;
 Thu, 16 Dec 2021 05:28:19 -0800 (PST)
MIME-Version: 1.0
References: <12f38ebde4dcd8b1ecbd37df1b6ce2018426f6dd.1639657049.git.mchehab+huawei@kernel.org>
 <20211216123014.GA286@LAPTOP-UKSR4ENP.internal.baidu.com> <Ybs8eJOBwxw/Tj3o@kroah.com>
In-Reply-To: <Ybs8eJOBwxw/Tj3o@kroah.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 16 Dec 2021 14:28:10 +0100
Message-ID: <CAKXUXMwsxiUncxS4Fip=7iK-xrUZSXY61jNcO61bgMyQ0DYp6A@mail.gmail.com>
Subject: Re: [PATCH v3] LICENSES/LGPL-2.1: Add LGPL-2.1-or-later as valid identifiers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 2:17 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Dec 16, 2021 at 08:30:14PM +0800, Cai Huoqing wrote:
> > On 16 12=E6=9C=88 21 13:17:35, Mauro Carvalho Chehab wrote:
> > > Some files have been flagged with the new LGPL-2.1-or-later
> > > identifier which replace the original LGPL-2.1+ in the SPDX license
> > > identifier specification, but the identifiers are not mentioned as
> > > valid in the LGPL-2.1 license file.
> > >
> > > Add it, together with the LGPL-2.1-only at the the license file.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  LICENSES/preferred/LGPL-2.1 | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/LICENSES/preferred/LGPL-2.1 b/LICENSES/preferred/LGPL-2.=
1
> > > index 27bb4342a3e8..b73f9b6230f5 100644
> > > --- a/LICENSES/preferred/LGPL-2.1
> > > +++ b/LICENSES/preferred/LGPL-2.1
> > > @@ -1,5 +1,7 @@
> > >  Valid-License-Identifier: LGPL-2.1
> > > +Valid-License-Identifier: LGPL-2.1-only
> > >  Valid-License-Identifier: LGPL-2.1+
> > > +Valid-License-Identifier: LGPL-2.1-or-later
> > >  SPDX-URL: https://spdx.org/licenses/LGPL-2.1.html
> > The URL is deprecated, do we need to update it together.
>
> No.
>
> > The same, GPL-2.0, LGPL-2.0
>
> Again, no.  We are using an older version of the SPDX specification,
> this is fine.
>

Mauro's patch just makes sure that spdxcheck.py does not complain
about the SPDX License Identifiers from SPDX spec v2 and from v3. It
really does not deprecate anything or implies that everything in the
kernel needs to move to v3 (which might really be some crazy
disturbing refactoring effort without a lot of gain), but it allows
developers that want to use the tags from SPDX spec v3 can do so.

I would assume making the kernel/a tool in the kernel supporting
something more while being backwards-compatible is the standard way we
work... So, Greg, this patch is fine to be included, right?


Lukas
