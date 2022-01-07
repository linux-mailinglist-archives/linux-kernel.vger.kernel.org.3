Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5401C487868
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347644AbiAGNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiAGNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:44:22 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C940C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:44:22 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y130so16826094ybe.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cShoU76vrbE0mQ8bMH8Dhj79NbR2cnrdoCS7NmG1tqk=;
        b=dm3TPOKjEpcXX2HP4tlgHyCVDjM7Q4pKjcoe4YloY8UhVRkPfB8PgNfZg/OWREQmqd
         LEzLYkLvLtoPU5HZlGKkOhUtpCzLcNdEQDUilT7iMuWnjLToxQxqvH4EJCF62umcVqiG
         w2j1vG81y5hKKJBVaooqQsU01jY6hanXeK72PnIIqmxgk06Wwd1oZmd1CWfq3pl00cht
         6LQ6xMK3jIGNrVzaargYENIfHfEWEoSVZkVFI/v5m1ksOWmWG13ZD2Yck3Zi3YIWYE/c
         B+rLblSImExoo1VLH/u0F5gwN28/V9qgJFH05sPEjLCLzJOGQVfN5LEWsiiRL/JojDv6
         Nt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cShoU76vrbE0mQ8bMH8Dhj79NbR2cnrdoCS7NmG1tqk=;
        b=7JyTth6KGOcL16Y4HMwtc+9WMuWiMDumq8OH4GErMfJGBTMb/JBj+eNCisida8pP7S
         z1DMMwHhwVsPTZcUTfO5ocPBvfaVVMzcApyrdzpoPrNXE/Lga17v5862vxbd1vO/eFMJ
         b7CCVk546RG93BmuDMinC8SaxYBJ9bRc9wvUp4P3anD2hCEXtm6b0OmdswGOcUD/idG7
         4TfRms329xr6aaNM/wNQwDLAq22dDaqaLM5GhdIj6kX2SQvJz7o283UyDnEJhXVczQuB
         jE6MI9wMxAxFyAXH2pBpCY8sfL1+hW9/u7DnOVNDcEw2hFcjXOPiDn9s1Ug7589IMr+I
         geTg==
X-Gm-Message-State: AOAM530AWGksKR65b/i8SgzpR2Z6o/dr53imh2KkRCP2QftriU62eZI/
        H2nskvK+jsaiNICLoXQv46kbYUbCRXubvOmSr0wioqKaN3nAVw==
X-Google-Smtp-Source: ABdhPJyfEqvU6xnJsvTMPjXvjABY9UNAgoQdbxjwoYCNPCdd/98CB6eh73UsYhZ9Z2uSQFrYJxqKkDmq1CR0ucerCdE=
X-Received: by 2002:a25:8b8f:: with SMTP id j15mr79841190ybl.585.1641563061275;
 Fri, 07 Jan 2022 05:44:21 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain> <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain> <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
In-Reply-To: <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 7 Jan 2022 19:14:10 +0530
Message-ID: <CAOuPNLiJZu_HJQ+Hf5BJOgmT+v7DT96VLkiXrfx0MJQrkD3rSw@mail.gmail.com>
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, caoxiaofeng@yulong.com, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 17:35, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, Jan 06, 2022 at 08:27:47PM +0300, Cyrill Gorcunov wrote:
> > On Thu, Jan 06, 2022 at 10:19:55PM +0530, Pintu Agarwal wrote:
> > > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > > > > index 435d5c2..6e77e90 100644
> > > > > --- a/include/uapi/linux/sysinfo.h
> > > > > +++ b/include/uapi/linux/sysinfo.h
> > > > > @@ -12,6 +12,7 @@ struct sysinfo {
> > > > >       __kernel_ulong_t freeram;       /* Available memory size */
> > > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> > > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
> > > > >       __kernel_ulong_t freeswap;      /* swap space still available */
> > > > >       __u16 procs;                    /* Number of current processes */
> > > >
> > > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> > > > be part of user API, no? Don't we break it up here?
> > >
> > > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
> > > also needs to be updated.
> > > When we generate the kernel header it will be updated automatically.
> >
> > Wait. The userspace may pass old structure here, and in result we
> > return incorrect layout which won't match old one, no? Old binary
> > code has no clue about this header update.
>
> Yes, that won't work as done.
>
> If we want to do this it needs to be done at the end of the struct right
> before the padding field and the newly added field substracted from the
> padding. (Not the preferred way to do it these days for new structs.)
>
> A new kernel can then pass in the struct with the newly added field and
> an old kernel can just fill the struct in as usual. New kernel will
> update the field with the correct value.
>
> But there's a catch depending on the type of value.
> The problem with these types of extensions is that you'll often need
> indicators to and from the kernel whether the extension is supported.
>
> Consider an extension where 0 is a valid value meaning "this resource is
> completely used". Since the kernel and userspace always agree on the
> size of the struct the kernel will zero the whole struct. So if in your
> newly added field 0 is a valid value you can't differentiate between 0
> as a valid value indicating that your resource isn't available and 0 as
> the kernel not supporting your extension.
>
> Other APIs solve this and similar problems by having a request mask and
> a return mask.  Userspace fills in what values it wants reported in the
> request mask and kernel sets the supported flags in the return mask.
> This way you can differentiate between the two (see statx).
>
> If the 0 example is not a concern or acceptable for userspace it's
> probably fine. But you need to document that having 0 returned can mean
> both things.
>
> Or, you select a value different from 0 (-1?) that you can use to
> indicate to userspace that the resource is used up so 0 can just mean
> "kernel doesn't support this extension".

Thanks all for your inputs.
As Eric suggested in other thread (pasting here for reference):
{
> Before the padding and you should reduce the size of the padding by the
> size of your new field.

>> Also, I could not understand what this is for ?
>> Do we need to update this since sture is changed ?

> In general padding like that is so new fields can be added.  The
> comment about libc5 makes me a wonder a bit, but I expect libc5 just
> added the padding in it's copy of the structure that it exported to
> userspace many many years ago so that new fields could be added.

> Eric
}

I made the changes like below and this seems to work even with older user space.
I mean earlier, when I ran "free" command it was giving "stack
smashing..." error,
but now the "free" command (which comes as part of busybox) works fine
even without recompiling with the updated header.

These are the header changes for quick look:
{{{
diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
index 6e77e90..fe84c6a 100644
--- a/include/uapi/linux/sysinfo.h
+++ b/include/uapi/linux/sysinfo.h
@@ -12,7 +12,6 @@ struct sysinfo {
        __kernel_ulong_t freeram;       /* Available memory size */
        __kernel_ulong_t sharedram;     /* Amount of shared memory */
        __kernel_ulong_t bufferram;     /* Memory used by buffers */
-       __kernel_ulong_t availram;      /* Memory available for allocation */
        __kernel_ulong_t totalswap;     /* Total swap space size */
        __kernel_ulong_t freeswap;      /* swap space still available */
        __u16 procs;                    /* Number of current processes */
@@ -20,7 +19,8 @@ struct sysinfo {
        __kernel_ulong_t totalhigh;     /* Total high memory size */
        __kernel_ulong_t freehigh;      /* Available high memory size */
        __u32 mem_unit;                 /* Memory unit size in bytes */
-       char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
Padding: libc5 uses this.. */
+       __kernel_ulong_t availram;      /* Memory available for allocation */
+       char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
Padding: libc5 uses this.. */
 };
}}}

If this is fine, I will push the new patch set.

Thanks,
Pintu
