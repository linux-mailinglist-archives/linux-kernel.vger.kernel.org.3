Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6905AA522
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiIBBfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbiIBBfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:35:21 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA572B74
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:35:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11f0fa892aeso1515312fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=jaxWGJ05CBTEiLoS2e5Z8hP+DMaic01fqmwKk8izU3g=;
        b=h5I+k6VaPc5GzBADRDdOvKSE2BN/u0CZzDMYc2h1MvhVbI4di49XeiqMecNvb8QZRK
         Dv8pmy8NJRG4WP5/K4V9zqWH9YgGoxf0eDP8H/qYp86Z+kMYrMTLFHEmDFg9yG4bIWII
         773RnoY2lFhZht/gTaivJNiZHFrSA+F3eJcH7Ehf4YHAketIrlqIHxJN4aDspWtO/EJT
         LtEvD1UfXPRh4XjMwuwHzSjnz7O9PBs6k9PVPTIcGp4I3rWFuUn8jjgqaB6CPuqwudMT
         BVQf/WVzIe2mPk+19DZbVyCWbPUFzGshifztGbye9GDxIlnelNJmD2Isvctzca83lFJy
         0sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jaxWGJ05CBTEiLoS2e5Z8hP+DMaic01fqmwKk8izU3g=;
        b=RpXxLJhLqKXmr/E61Wv+J+IDq7d34xh8FmpK/zpGjepvDlj9a20+utBPThdXSAPzpc
         aERJfjWZNX3f/CUiwFaPml4SG9SD5NcZHXZh7b9UNoKCwfRkG5fr9oxJwatFj5FIpEEA
         n/KLJaUwPOCuU751NfLwws6lT1iMwP33TNCEf1E01mc0pfAAEqn7JgvzNRvCEMkU3Iy7
         dOu6/BMk9GKK1sKzonkj/+Xkv5Wr4aKBgehYE9Ul1LWHT6PvzIp7snyu96IPY4HGFEj4
         EQ05FNUaIqEcd5pH1SToNnTvpA2N+I8xQg97U7TjGCF1z6XHfGRJdoz8YHD+V0tqIN8I
         +CeQ==
X-Gm-Message-State: ACgBeo2BjVIxzAIK5ZbSsk/QiiiM8RvXvDMFKIa5PUPiAFS6ApuOsbUG
        v2LrtjBXFk1qGFFq/SK3+wOfnLacMFfoyXddgMurpUSDvfGd
X-Google-Smtp-Source: AA6agR7xp8nLVThqF8nuicqqq1i6x82AyEKWYamSX7ZhZ6EZ3Owp1CnkutuH/9dz6/ZDbyylNnlwaN7TkDxevTyZjGI=
X-Received: by 2002:a05:6808:bd1:b0:345:da59:d3ae with SMTP id
 o17-20020a0568080bd100b00345da59d3aemr956860oik.136.1662082516553; Thu, 01
 Sep 2022 18:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220502160030.131168-8-cgzones@googlemail.com>
 <20220615152623.311223-1-cgzones@googlemail.com> <20220615152623.311223-8-cgzones@googlemail.com>
 <CAHC9VhS8ASN+BB7adi=uoAj=LeNhiD4LEidbMc=_bcD3UTqabg@mail.gmail.com>
In-Reply-To: <CAHC9VhS8ASN+BB7adi=uoAj=LeNhiD4LEidbMc=_bcD3UTqabg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Sep 2022 21:35:05 -0400
Message-ID: <CAHC9VhTRALdnO2JteNzt2j+4FK6DkKWMZ3q-dVPYVJ9_fvPBfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] capability: add any wrapper to test for multiple
 caps with exactly one audit message
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 8:56 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Jun 15, 2022 at 11:27 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Add the interfaces `capable_any()` and `ns_capable_any()` as an
> > alternative to multiple `capable()`/`ns_capable()` calls, like
> > `capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
> > `capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.
> >
> > `capable_any()`/`ns_capable_any()` will in particular generate exactly
> > one audit message, either for the left most capability in effect or, if
> > the task has none, the first one.
> >
> > This is especially helpful with regard to SELinux, where each audit
> > message about a not allowed capability will create an AVC denial.
> > Using this function with the least invasive capability as left most
> > argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables policy writer=
s
> > to only allow the least invasive one and SELinux domains pass this chec=
k
> > with only capability:sys_nice or capability:sys_admin allowed without
> > any AVC denial message.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >
> > ---
> > v3:
> >    - rename to capable_any()
> >    - fix typo in function documentation
> >    - add ns_capable_any()
> > v2:
> >    avoid varargs and fix to two capabilities; capable_or3() can be adde=
d
> >    later if needed
> > ---
> >  include/linux/capability.h | 10 +++++++
> >  kernel/capability.c        | 53 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+)
>
> ...
>
> > diff --git a/kernel/capability.c b/kernel/capability.c
> > index 765194f5d678..ab9b889c3f4d 100644
> > --- a/kernel/capability.c
> > +++ b/kernel/capability.c
> > @@ -435,6 +435,59 @@ bool ns_capable_setid(struct user_namespace *ns, i=
nt cap)
> >  }
> >  EXPORT_SYMBOL(ns_capable_setid);
> >
> > +/**
> > + * ns_capable_any - Determine if the current task has one of two super=
ior capabilities in effect
> > + * @ns:  The usernamespace we want the capability in
> > + * @cap1: The capabilities to be tested for first
> > + * @cap2: The capabilities to be tested for secondly
> > + *
> > + * Return true if the current task has at least one of the two given s=
uperior
> > + * capabilities currently available for use, false if not.
> > + *
> > + * In contrast to or'ing capable() this call will create exactly one a=
udit
> > + * message, either for @cap1, if it is granted or both are not permitt=
ed,
> > + * or @cap2, if it is granted while the other one is not.
> > + *
> > + * The capabilities should be ordered from least to most invasive, i.e=
. CAP_SYS_ADMIN last.
> > + *
> > + * This sets PF_SUPERPRIV on the task if the capability is available o=
n the
> > + * assumption that it's about to be used.
> > + */
> > +bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
> > +{
> > +       if (ns_capable_noaudit(ns, cap1))
> > +               return ns_capable(ns, cap1);
> > +
> > +       if (ns_capable_noaudit(ns, cap2))
> > +               return ns_capable(ns, cap2);
> > +
> > +       return ns_capable(ns, cap1);
>
> I'm slightly concerned that some people are going to be upset about
> making an additional call into the capabilities code with this
> function.  I think we need to be a bit more clever here to take out
> some of the extra work.
>
> I wonder if we create a new capability function, call it
> ns_capable_audittrue(...) or something like that, that only generates
> an audit record if the current task has the requested capability ...

To be clear, when I mean by generating an audit record when true is
that the LSMs implementing the security_capable() hook would only call
their audit related code when the capability requirement was met, in
many cases that will *not* likely generate an audit record, but you
get the basic idea I hope.  For SELinux this would likely mean
modifying cred_has_capability() something like this ...

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 03bca97c8b29..c1b7f0582d16 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1581,6 +1581,7 @@ static int cred_has_capability(const struct cred *cre=
d,
       u16 sclass;
       u32 sid =3D cred_sid(cred);
       u32 av =3D CAP_TO_MASK(cap);
+       bool audit;
       int rc;

       ad.type =3D LSM_AUDIT_DATA_CAP;
@@ -1601,7 +1602,10 @@ static int cred_has_capability(const struct cred *cr=
ed,

       rc =3D avc_has_perm_noaudit(&selinux_state,
                                 sid, sid, sclass, av, 0, &avd);
-       if (!(opts & CAP_OPT_NOAUDIT)) {
+       audit =3D !(opts & CAP_OPT_NOAUDIT);
+       if (opts & CAP_OPT_AUDITTRUE)
+               audit =3D !rc;
+       if (audit) {
               int rc2 =3D avc_audit(&selinux_state,
                                   sid, sid, sclass, av, &avd, rc, &ad);
               if (rc2)

[There is likely a cleaner patch than the above, this was just mean as
a demonstration]

> ... if
> the current task does not have the requested capability no audit
> record is generated.  With this new function I think we could rewrite
> ns_capable_any(...) like this:
>
>   bool ns_capable_any(ns, cap1, cap2)
>   {
>     if (ns_capable_audittrue(ns, cap1))
>       return true;
>     if (ns_capable_audittrue(ns, cap2))
>       return true;
>     return ns_capable(ns, cap1);
>   }
>
> ... we would still have an extra capability check in the failure case,
> but that's an error case anyway and not likely to draw much concern.
>
> Of course this would require some additional work, meaning a new
> CAP_OPT_XXX flag (CAP_OPT_AUDITTRUE?), and updates to the individual
> LSMs.  However, the good news here is that it appears only SELinux and
> AppArmor would need modification (the others don't care about
> capabilities or audit) and in each case the modification to support
> the new CAP_OPT_AUDITTRUE flag look pretty simple.
>
> Thoughts?
>
> > +}
> > +EXPORT_SYMBOL(ns_capable_any);

--=20
paul-moore.com
