Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB1B486946
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiAFR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiAFR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:59:14 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:59:14 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id d1so9702896ybh.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2D6EeoYb+b4mvX70XIdFK6lgodBeGTNmqesy1Eurmk=;
        b=Otbuw240aMoy4oKfiPfJinywWAixSuIX5t04hFFlZb/Gkp2z/CYyQRbHvVL5wFJlHF
         hX7biY1/3NX0yfxrbuGBftDmhuAgtE7vSo6N6VjjGXwoGCi29Occp6/vCyao1MtYTJIk
         Shazu2JghNMLGXb7FJrQ2rYkw0oskCwscTLbmrwkfY9cnJGFpk+FT8g2Ej2hHZyvg5KX
         DU00kz1hGpKv1qfmF4djni55PvkCRxCTv3WBNXmycLE60eew1LW8UllVRreNsx2bXtve
         dU+xBmTxf00bPYtC/sB3KnYNekcKUMGaUcWLdVtROcKWfJWiw1FpsaKMo9OsxnfB2yu5
         1wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2D6EeoYb+b4mvX70XIdFK6lgodBeGTNmqesy1Eurmk=;
        b=78WDOKbp/Lk9SlD7MBN93xaFt7wGN3zndEccHuFIrgL3WQRuoqbBeP6VB0R6sNCgqE
         +cgc+hNxxbqjbu+fx20A/K148ZuUTxZ64sP7Lh14hgSRArTNicGLOySxCcvWozu9se23
         jTCmc9wq7Cn2oR+XdiEIDpDpcfB+BDZVXtIvqIaYGvJwxjiJPZg7mULxLe9xwkkU0NLx
         zgxqwKZ22TNojPGfH+7QCl89/qck+bSy2pazBGwSxX6Av1oVHFNHYU2M+EfY6CWK3YFF
         0QNAv+vcTn4HEy7gw+7EgrCOUjQ61Kb6LlyTwL/Kzs/5eb7NW5COZTmOsx0jz3+666JO
         2N6Q==
X-Gm-Message-State: AOAM531sodAIfNi9Rghkf5/52ENJMZEvdIadAForle4JhInqDg2edBaV
        w+8yx35LGr3wF+IrP90TkiQ8gdah/m06tocv7fM=
X-Google-Smtp-Source: ABdhPJw4ocnS9niYedLirta2VK213X3djYSOmZQumrR2qeItR5A/r+UcVzvbK1kz/RVcnhNY4RzTBgSb3bD1E4fFPIo=
X-Received: by 2002:a25:6c55:: with SMTP id h82mr78729963ybc.214.1641491953789;
 Thu, 06 Jan 2022 09:59:13 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain> <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <14316cf852784a32b5214119a9d976cf@AcuMS.aculab.com>
In-Reply-To: <14316cf852784a32b5214119a9d976cf@AcuMS.aculab.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Thu, 6 Jan 2022 23:29:02 +0530
Message-ID: <CAOuPNLjh+OhnqqGWWj015eQmwGqp96iu2zycVq4sM+K7JjxumQ@mail.gmail.com>
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
To:     David Laight <David.Laight@aculab.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2022 at 23:12, David Laight <David.Laight@aculab.com> wrote:
>
> From: Pintu Agarwal
> > Sent: 06 January 2022 16:50
> >
> > On Thu, 6 Jan 2022 at 21:41, Cyrill Gorcunov <gorcunov@gmail.com> wrote:
> > >
> > > On Thu, Jan 06, 2022 at 09:04:10PM +0530, Pintu Kumar wrote:
> > > > The sysinfo member does not have any "available ram" field and
> > > > the bufferram field is not much helpful either, to get a rough
> > > > estimate of available ram needed for allocation.
> > > >
> > > > One needs to parse MemAvailable field separately from /proc/meminfo
> > > > to get this info instead of directly getting if from sysinfo itself.
> > > >
> > > > Thus, this patch introduce a new field as availram in sysinfo
> > > > so that all the info total/free/available can be retrieved from
> > > > one place itself.
> > > >
> > > > There are couple of places in kernel as well where this can be improved.
> > > > For example:
> > > > In fs/proc/meminfo.c:
> > > > meminfo_proc_show:
> > > >    si_meminfo(&i);
> > > >    available = si_mem_available();
> > > > Now with this change the second call be avoided.
> > > > Thus, we can directly do:
> > > > show_val_kb(m, "MemAvailable:   ", i.availram);
> > > >
> > > > Note, this also requires update in procfs for free and other commands.
> > > > Like in free command as well we frist call sysinfo then again parse
> > > > /proc/meminfo to get available field.
> > > > This can be avoided too with higher kernel version.
> > > >
> > > > A sample output with single sysinfo call is shown below:
> > > > Total RAM: 248376 kB
> > > >  Free RAM: 231540 kB
> > > > Avail RAM: 230448 kB
> > > >
> > > > Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> > > > Signed-off-by: Pintu Agarwal <pintu.ping@gmail.com>
> > > > ---
> > > >  include/uapi/linux/sysinfo.h | 1 +
> > > >  kernel/sys.c                 | 4 ++++
> > > >  mm/page_alloc.c              | 2 ++
> > > >  3 files changed, 7 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > > > index 435d5c2..6e77e90 100644
> > > > --- a/include/uapi/linux/sysinfo.h
> > > > +++ b/include/uapi/linux/sysinfo.h
> > > > @@ -12,6 +12,7 @@ struct sysinfo {
> > > >       __kernel_ulong_t freeram;       /* Available memory size */
> > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
> > > >       __kernel_ulong_t freeswap;      /* swap space still available */
> > > >       __u16 procs;                    /* Number of current processes */
> > >
> > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> > > be part of user API, no? Don't we break it up here?
> >
> > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
> > also needs to be updated.
> > When we generate the kernel header it will be updated automatically.
>
> You can't add a field in the middle of a UAPI structure.
> It breaks compatibility for old binaries.
>
> Depending on the interface definition you may be able to add one at the end.
>
oh okay thank you for your feedback. I will move to the end and check again.
But my doubt is, whether I should move before this
char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];
or after this ?

Also, I could not understand what this is for ?
Do we need to update this since sture is changed ?
