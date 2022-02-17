Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3D4BAC9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343888AbiBQWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:33:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiBQWdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:33:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5C1688EA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:32:52 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f17so12266502edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 14:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bzVS3GxQBLj2+ZoHNymWmW7fgxIcXLRqtnHSkBFdVIo=;
        b=fYu1z8wdXTgQuGm083cZUw7N/B0Y+YjzhkPbVyYrvjpCB7OG1Jlwq4irqtPlNwlxF5
         oupo5/AMfqd0Y9DTn8VtlJj7ivOTw91JToHP0pSrnIfUp14Dm5+qB8PxSha0Jx8h1vrm
         76ZdMJcWbPU78mJS6ATFwleKjMn9WMswJA/XfJOTkyOvfmqshMJHPW/jIR0mvzDAllfU
         uqpuHEniPhzvXYZ3iaiaInLz1By6gNH9ESuWUQL8QtW6VwxVA1DldtvbmcE26FkKlh8y
         eDYYGlBGZ6twfpS1bzfI01e6YJ7OywisgT/QBPrr2z8pS6E5TXCS/urpRw0FghoqKak0
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bzVS3GxQBLj2+ZoHNymWmW7fgxIcXLRqtnHSkBFdVIo=;
        b=kORqU6t4ME4za+BIFrkGpaCkiQKG+1KJG8oN3LYD7/3LjCgdZDWrCrIFd0oAifR6tc
         8/GvBnmCeyIcV9Rkx60G0QkXp7DmBxOqgjLBxBPIdBLU6I3o123ObCvfXdh83YzfOpO+
         vUnEo8GMkiSOJD3VF9UwABYkHipJhp/tqbHdEBrKL6DHzMDVD38cSsgsJm+RGDL6Txt5
         NSKfqwlPH8+W0PKDwRtwRZQjcWKZV5ESdsltF+hTmPyG4tosdVr4I6DxV8XtdGnvcoTv
         TaXi3HkN2zXHjzBWM3nUUbVv03olZXfcGgBdP90welsAu2qBgRZm68L4zKxFvMZb0jsZ
         F4hQ==
X-Gm-Message-State: AOAM532/k1pmtuPUjaHHgEjsJ7g0ab38dJ45pvgiHZSBstdJWwnM7IRs
        Oeh0ruA7Y6gPreIj9lTQBtStKTgYJN8gFtrpZcrN
X-Google-Smtp-Source: ABdhPJzLADUccqBS7dHbAPwRxfeqZ9RsiV5nDqMSQfE7BDBfCv8Bo+Bd9MOqqWhYWUFl4mZ2cFv4XO0HaaAHRb5VYtw=
X-Received: by 2002:a05:6402:3487:b0:40f:fa53:956c with SMTP id
 v7-20020a056402348700b0040ffa53956cmr5034224edc.22.1645137170677; Thu, 17 Feb
 2022 14:32:50 -0800 (PST)
MIME-Version: 1.0
References: <20220125143304.34628-1-cgzones@googlemail.com>
 <CAHC9VhSdGeZ9x-0Hvk9mE=YMXbpk-tC5Ek+uGFGq5U+51qjChw@mail.gmail.com> <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
In-Reply-To: <CAJ2a_DeAUcGTGm_fk8viVbeFXr6FLrJ-oLw-abwFND6Kv0u0gQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Feb 2022 17:32:39 -0500
Message-ID: <CAHC9VhRRBrLVtvmbJSTZ7fOkD-8AN4iM0WRmeL4ND001d3viJg@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: create security context for memfd_secret inodes
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Thu, Feb 17, 2022 at 9:24 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Thu, 27 Jan 2022 at 00:01, Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Jan 25, 2022 at 9:33 AM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > >
> > > Create a security context for the inodes created by memfd_secret(2) v=
ia
> > > the LSM hook inode_init_security_anon to allow a fine grained control=
.
> > > As secret memory areas can affect hibernation and have a global share=
d
> > > limit access control might be desirable.
> > >
> > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > ---
> > > An alternative way of checking memfd_secret(2) is to create a new LSM
> > > hook and e.g. for SELinux check via a new process class permission.
> > > ---
> > >  mm/secretmem.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> >
> > This seems reasonable to me, and I like the idea of labeling the anon
> > inode as opposed to creating a new set of LSM hooks.  If we want to
> > apply access control policy to the memfd_secret() fds we are going to
> > need to attach some sort of LSM state to the inode, we might as well
> > use the mechanism we already have instead of inventing another one.
>
> Any further comments (on design or implementation)?
>
> Should I resend a non-rfc?

I personally would really like to see a selinux-testsuite for this so
that we can verify it works not just now but in the future too.  I
think having a test would also help demonstrate the usefulness of the
additional LSM controls.

> One naming question:
> Should the anonymous inode class be named "[secretmem]", like
> "[userfaultfd]", or "[secret_mem]" similar to "[io_uring]"?

The pr_fmt() string in mm/secretmem.c uses "secretmem" so I would
suggest sticking with "[secretmem]", although that is question best
answered by the secretmem maintainer.

--=20
paul-moore.com
