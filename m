Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE434BAC90
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241468AbiBQW00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:26:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiBQW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:26:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD94F1688C4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:26:08 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a23so10587260eju.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hw18NUxIkws+pKv9BXQqVUxZL0gpw+nsSHJBAiFK+Tw=;
        b=TuxlNCMAZu67yIZesw5qD2l9WluJYajpYSvf7ilkvdFkcII5B7zOSrrA1JUzqomlZ8
         10Pki1W92fbUSBIJ10nS3MOH/QBtxY239+/IjpOoIKS/kh1J+Sn1bBO93h4HgD7QB4Yi
         k0PvxI8CuyRgNDmVscNQkrZcnvJZ0adyLP8lcudBKiUK2i9Z2LO18ySqzS/TX5RUgJmd
         69ljAM3WDQb9KkbfS5Q1hJmapvZHsXtShA553HRBqz3h4t0dHfYtNLSfWKH5IGn9lQ0p
         AnJOcyId/KBm0DtJmumd+61FcdRtSK5dRbdlgCVFZOQy0Xa6G0i+gEdNLxvVhYaJCK0M
         3s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hw18NUxIkws+pKv9BXQqVUxZL0gpw+nsSHJBAiFK+Tw=;
        b=aLFJMgo7BlWDCFKfxqVbWsQ/rYDtA3uFxTU/ih5etxhDHDC/Rqgv3ZxMGeURUp2HJF
         Xjsu7i/OTpkXDjOBb1jwMa9q5TxWI5LES6MAEXOlGufQ72X1WORFwTghZBeWOC+KiiuQ
         GXNQzz6MJgkJphKKCdIva1+hW2n2N+3N+j6zjPuSD0Mu9d3O1Aq2s0yYOg/y6jrzn7JR
         zTl9rIHh7zBXiO28ERgWQN65x3wDwED4+jsNrrV91T4Nr3csKDVhWHdbLS++SB2Pe/TR
         vjDwek3VoluejkZmhBpLK2wqVm19claQCKdxAq1jFMNWORfaTxULl/IdOGm8kCrIsXiq
         O46Q==
X-Gm-Message-State: AOAM530YoiRLXYqX2+RTcYGM2SNMf3Bcjzx/TpO6xJaJjTqG4HZR89Bd
        gTkitA7SdeO4XD/KjBvXekF3fANzrHaC6/7MaSz+
X-Google-Smtp-Source: ABdhPJy1UezhTFruqiqe8V4twoHJGohohUqRTgPpDF29eHvN/oARbMjAkwSO8pP+EspKeeaGIvA+GMoozt/tM6avkDw=
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr4072554ejp.12.1645136767084; Thu, 17 Feb
 2022 14:26:07 -0800 (PST)
MIME-Version: 1.0
References: <4df50e95-6173-4ed1-9d08-3c1c4abab23f@gmail.com>
 <CAHC9VhSjTqT-4TMxBnQOQHkj+djONihfeoPVyy1egrZY2t10XA@mail.gmail.com>
 <c8a616e4-26a6-af51-212c-31dca0e265cd@gmail.com> <CAHC9VhQTZdeNOx3AXdoc9LXUzDk5n7wyGBX-tV-ZaovhPAdWwQ@mail.gmail.com>
 <e85dd38b-ef7b-ed7e-882e-124cdf942c44@gmail.com> <CAHC9VhROuJtvNHuVaR6pEekNFacH3Tywx58_hn1f5Mwk+kjC8g@mail.gmail.com>
 <b7e55304-d114-bcbe-08d2-b54828121a01@gmail.com> <CAHC9VhSdgD4Nfaxbnnn4r-OK8koSZ7+zQoPShDbGi9PvkJFpng@mail.gmail.com>
 <478e1651-a383-05ff-d011-6dda771b8ce8@linux.microsoft.com>
 <875ypt5zmz.fsf@defensec.nl> <CAFftDdo9JmbyPzPWRjOYgZBOS9b5d+OGKKf8egS8_ysbbWW87Q@mail.gmail.com>
 <CABXk95Az0V0qWyB0Cp9D+MaCKNBfcdk4=bvXRdm5EXzHdjXJJg@mail.gmail.com>
 <CAHC9VhQKuQuR1pJfa0h2Y5dCjmrpiYaGpymwxxE1sa6jR3h-bA@mail.gmail.com> <CAJ2a_Ddh8p0fzJHf7R=BwAULfS8jYq08x=H45mF9jaR1QbWTww@mail.gmail.com>
In-Reply-To: <CAJ2a_Ddh8p0fzJHf7R=BwAULfS8jYq08x=H45mF9jaR1QbWTww@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Feb 2022 17:25:53 -0500
Message-ID: <CAHC9VhRK+VBN_VhpgNkRN=rwP+EUYMAbUT++tJ+oBzd81H9mxw@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Always allow FIOCLEX and FIONCLEX
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Demi Marie Obenour <demiobenour@gmail.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Dominick Grift <dominick.grift@defensec.nl>,
        Chris PeBenito <chpebeni@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:05 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Tue, 15 Feb 2022 at 21:35, Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Feb 14, 2022 at 2:11 AM Jeffrey Vander Stoep <jeffv@google.com>=
 wrote:
> > > On Tue, Feb 8, 2022 at 3:18 PM William Roberts <bill.c.roberts@gmail.=
com> wrote:
> > > >
> > > > <snip>
> > > >
> > > > This is getting too long for me.
> > > >
> > > > > >
> > > > > > I don't have a strong opinion either way.  If one were to allow=
 this
> > > > > > using a policy rule, it would result in a major policy breakage=
.  The
> > > > > > rule would turn on extended perm checks across the entire syste=
m,
> > > > > > which the SELinux Reference Policy isn't written for.  I can't =
speak
> > > > > > to the Android policy, but I would imagine it would be the simi=
lar
> > > > > > problem there too.
> > > > >
> > > > > Excuse me if I am wrong but AFAIK adding a xperm rule does not tu=
rn on
> > > > > xperm checks across the entire system.
> > > >
> > > > It doesn't as you state below its target + class.
> > > >
> > > > >
> > > > > If i am not mistaken it will turn on xperm checks only for the
> > > > > operations that have the same source and target/target class.
> > > >
> > > > That's correct.
> > > >
> > > > >
> > > > > This is also why i don't (with the exception TIOSCTI for termdev
> > > > > chr_file) use xperms by default.
> > > > >
> > > > > 1. it is really easy to selectively filter ioctls by adding xperm=
 rules
> > > > > for end users (and since ioctls are often device/driver specific =
they
> > > > > know best what is needed and what not)
> > > >
> > > > > >>> and FIONCLEX can be trivially bypassed unless fcntl(F_SETFD)
> > > > >
> > > > > 2. if you filter ioctls in upstream policy for example like i do =
with
> > > > > TIOSCTI using for example (allowx foo bar (ioctl chr_file (not
> > > > > (0xXXXX)))) then you cannot easily exclude additional ioctls late=
r where source is
> > > > > foo and target/tclass is bar/chr_file because there is already a =
rule in
> > > > > place allowing the ioctl (and you cannot add rules)
> > > >
> > > > Currently, fcntl flag F_SETFD is never checked, it's silently allow=
ed, but
> > > > the equivalent FIONCLEX and FIOCLEX are checked. So if you wrote po=
licy
> > > > to block the FIO*CLEX flags, it would be bypassable through F_SETFD=
 and
> > > > FD_CLOEXEC. So the patch proposed makes the FIO flags behave like
> > > > F_SETFD. Which means upstream policy users could drop this allow, w=
hich
> > > > could then remove the target/class rule and allow all icotls. Which=
 is easy
> > > > to prevent and fix you could be a rule in to allowx 0 as documented=
 in the
> > > > wiki: https://selinuxproject.org/page/XpermRules
> > > >
> > > > The questions I think we have here are:
> > > > 1. Do we agree that the behavior between SETFD and the FIO flags ar=
e equivalent?
> > > >   I think they are.
> > > > 2. Do we want the interfaces to behave the same?
> > > >   I think they should.
> > > > 3. Do upstream users of the policy construct care?
> > > >   The patch is backwards compat, but I don't want their to be cruft
> > > > floating around with extra allowxperm rules.
> > >
> > > I think this proposed change is fine from Android's perspective. It
> > > implements in the kernel what we've already already put in place in
> > > our policy - that all domains are allowed to use these IOCLTs.
> > > https://cs.android.com/android/platform/superproject/+/master:system/=
sepolicy/public/domain.te;l=3D312
> > >
> > > It'll be a few years before we can clean up our policy since we need
> > > to support older kernels, but that's fine.
> >
> > Thanks for the discussion everyone, it sounds like everybody is okay
> > with the change - that's good.  However, as I said earlier in this
> > thread I think we need to put this behind a policy capability, how
> > does POLICYDB_CAPABILITY_IOCTL_CLOEXEC/"ioctl_skip_cloexec" sound to
> > everyone?
>
> May I ask why?
> To my understanding policy capabilities exist to retain backwards
> compatibility for older
> policies, e.g. if a new check is introduced or a new essential class
> or permission, which
> would break systems running an updated kernel with a non updated policy.
> In this case no check or class/permission is added, the xperm checks
> against FIO(N)CLEX
> are just dropped.  Old policies still defining related allow rules
> continue to work.  Existing
> polices explicitly not allowing them and relying on SELinux to block chan=
ges on
> the close-on-exec flag are already broken due to the bypasses via
> fnctl(2) and dup(2).

Policy capabilities are a general tool that we can use when we make a
change in the kernel that could potentially have an effect on the
policy; it allows the policy to (typically) "opt-in" to the change.

In this particular case we are talking about removing access controls,
which is a Very Serious Thing, and protecting this behavior with an
opt-in policy capability seems like a good way to not surprise anyone
with the change.  You are correct in that old policy would continue to
load and work regardless, but I believe it is safer to create a new
policy capability for this.

--=20
paul-moore.com
