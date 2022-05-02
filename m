Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F505170DC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 15:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiEBNt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 09:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385518AbiEBNtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 09:49:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0786512614;
        Mon,  2 May 2022 06:45:52 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso3710387fac.1;
        Mon, 02 May 2022 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KlkPJd9IPwI3xuM5T+5Eqx8x2n4AENEmfcA0g1h3kb8=;
        b=Y9Ge8Zh0P8Nn7vrmdfyiKMNSXTRSp9YFHQZim+UHkCEFcfwdVdW7Vb8ezfueGEUcHa
         B1aAFddnxIPGLjcRzkP7XtGk2dlF8RTkPlKJaCYmt9O1naej9QSykekHptyii+fwZRQy
         l1EWiBVCqbJWRkZ4Klnvtx0ozhx62AmU09qkR9Ola2hClwQjEQZyfYh6q/uEpQuAyrm/
         YDfjUjrwscX61c0ALQUvQcDFIU5370j4EfVKP7iQobmAodMzzuNMPCmW4S2LWhgAbo8X
         VwWzk9s3kNbfC3hUgXGX/2R2pel9rOhniwQEMnG5Tpm9jRGvRtVuWVtt1ofUS4hLNBNY
         P3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KlkPJd9IPwI3xuM5T+5Eqx8x2n4AENEmfcA0g1h3kb8=;
        b=GlaqFoK98nXaEEYvyCg7kUV2gvAIhFDe7jvAcGk5OPws8WwO7CX7y7roSQPVnZVebg
         80brvven4c0dIYkmGfxyCDAmYaEayqTQRgjJRVU+06XTVWojlpFudpuyNQiwAqqIKLMG
         nz0hSosO/BoWUL2TayosZULy7xhUG4rM3PjX7C9omb0ghmO5KsFMmwabF/pHkjP7uwee
         emPp6qXPpnRkyk9Io72nKjmhAhcmK1vxKdbKvjjTOVcCjzgPzD/m8mIIUbWM2gUrA0hL
         LS627xsLm+EnZyCz2hk4LxvI/7LA6UjE7jsntNZXV8DWnhMQ09KU+KNAFgZQYyNn9A2N
         6c1w==
X-Gm-Message-State: AOAM531tY60jo5iauU6oCT2LzUvclGVdGN4j9DcdeIMxf9NkYrvNj747
        F+dw6UGdetW9/GvaGgmNo1t/1naRFi4rZ2G5mZs=
X-Google-Smtp-Source: ABdhPJx5rwU6X5NnnuNmcAS5EItDn5UYn1+bETi6E6Je7tDTBL6rzvnM5hyy2El994VvmDm+qlbjgH1Ln9bev9p14BE=
X-Received: by 2002:a05:6870:5b8a:b0:e6:589e:201d with SMTP id
 em10-20020a0568705b8a00b000e6589e201dmr6394064oab.71.1651499145960; Mon, 02
 May 2022 06:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
 <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com>
 <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com> <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com>
In-Reply-To: <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 2 May 2022 15:45:35 +0200
Message-ID: <CAJ2a_DeT6AG0jp4gTdsEy7nh=s6cLR7QCsYXAz2+3vsdRKxddg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
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

On Thu, 17 Feb 2022 at 23:32, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 17, 2022 at 9:24 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Create a security context for the inodes created by memfd_secret(2)=
 via
> > > > the LSM hook inode_init_security_anon to allow a fine grained contr=
ol.
> > > > As secret memory areas can affect hibernation and have a global sha=
red
> > > > limit access control might be desirable.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > > An alternative way of checking memfd_secret(2) is to create a new L=
SM
> > > > hook and e.g. for SELinux check via a new process class permission.
> > > > ---
> > > >  mm/secretmem.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > >
> > > This seems reasonable to me, and I like the idea of labeling the anon
> > > inode as opposed to creating a new set of LSM hooks.  If we want to
> > > apply access control policy to the memfd_secret() fds we are going to
> > > need to attach some sort of LSM state to the inode, we might as well
> > > use the mechanism we already have instead of inventing another one.
> >
> > Any further comments (on design or implementation)?
> >
> > Should I resend a non-rfc?
>
> I personally would really like to see a selinux-testsuite for this so
> that we can verify it works not just now but in the future too.  I
> think having a test would also help demonstrate the usefulness of the
> additional LSM controls.
>

Any comments (especially from the mm people)?

Draft SELinux testsuite patch:
https://github.com/SELinuxProject/selinux-testsuite/pull/80

> > One naming question:
> > Should the anonymous inode class be named "[secretmem]", like
> > "[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?
>
> The pr_fmt() string in mm/secretmem.c uses "secretmem" so I would
> suggest sticking with "[secretmem]", although that is question best
> answered by the secretmem maintainer.
>
> --
> paul-moore.com
