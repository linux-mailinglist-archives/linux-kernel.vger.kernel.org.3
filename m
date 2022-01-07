Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42143487B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiAGRrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAGRrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:47:42 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD1BC061574;
        Fri,  7 Jan 2022 09:47:42 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id m6so8496278ybc.9;
        Fri, 07 Jan 2022 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tbhQvAZirFGKAMYtYXqT4i9nbeU7HTQveLj+0iDD/dE=;
        b=Gd+WnpTy8NfzImoSlL8L9JuB7G4dUyX5ugV41+gdYkrB/dO3TZCWBQnlF4LrUgzTet
         0+PQZY6JS1xhl9g6mnGleBu6X1vQWaQNrQNJcOQIiwO/L7iMeA4gpYBBWRX4txMLYDNa
         /UNCEqGwlJfi3aa7YIT5nT1LL9sWP2uJv5GvJv+DTaHa3NcDNsqSjbp6Zne/h+X4Ssm7
         9L+L5yiBQxKMypPhpr/iRh3oVNUzQ7lyUiR4nyN4cHeHFpJubUDNOxHXLh5ShaSvokEL
         EiM46mr1q/ObjxNJqIHQh7lBz40dHOdLs8seseyFfn8FKiYtEzligHHaXqzMegD1rKJC
         6ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tbhQvAZirFGKAMYtYXqT4i9nbeU7HTQveLj+0iDD/dE=;
        b=lB4XM9PC/lhsnCUmQzBt5dzZssupYRSKCOUDOi6SiF5aYx2vihKQlv1jdEyoBpkuki
         e5g+3aGTfVXZH2AiJ42OmiBabRIc88iUxFBMPHTXz5wo/O2Zgrc/xLF+aYmcA2YxrRrk
         9BTHPQSF6s6eyeFxVH0jEJsMzxxOAwnaIcm+mlLmME+WKZ1bmQy80ezvoNNnnFSqc2MV
         Jwaqax0jHXlkZKYw3rDkohDlzOjmXQrJ59beVhIdMB9Bx2Fpt2bJzh3YQZTREH547QtS
         +x7qBxoSZ5XSfP9t/sFrrzpp1E7+mJK7kHZQpABwNukwN3HDk2p9alU2K1RKaf4y6iHj
         JQEQ==
X-Gm-Message-State: AOAM532w0OKU88P/EItGMMMreaT8rwRC80WqOaMz4KIAzUgixzPWmnx8
        rJa+ZrlekPeXTwEZ+khQd56PiGh4hMYaayLy2No=
X-Google-Smtp-Source: ABdhPJwlj1uhanHtVjLMTuEH0XkoQMfpwB/Ppcsh+ppOSH1LTEjcFabPlq0sCi5MwcYAmHbB/cSCpsOQNj72vnpt/mQ=
X-Received: by 2002:a25:cad0:: with SMTP id a199mr668058ybg.753.1641577661350;
 Fri, 07 Jan 2022 09:47:41 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain> <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain> <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
 <CAOuPNLiJZu_HJQ+Hf5BJOgmT+v7DT96VLkiXrfx0MJQrkD3rSw@mail.gmail.com> <91d662f1-baf6-1114-f237-a66ebc164009@suse.cz>
In-Reply-To: <91d662f1-baf6-1114-f237-a66ebc164009@suse.cz>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 7 Jan 2022 23:17:30 +0530
Message-ID: <CAOuPNLghbUrKwWdC7uEwyOZf2zmB=qL7WXoCnBc8J8=X6i7NTg@mail.gmail.com>
Subject: Re: [PATCH] sysinfo: include availram field in sysinfo struct
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, ebiederm@xmission.com,
        sfr@canb.auug.org.au, legion@kernel.org, sashal@kernel.org,
        chris.hyser@oracle.com, ccross@google.com, pcc@google.com,
        dave@stgolabs.net, caoxiaofeng@yulong.com, david@redhat.com,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 at 22:28, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> CC linux-api
>
> On 1/7/22 14:44, Pintu Agarwal wrote:
> > On Fri, 7 Jan 2022 at 17:35, Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> >>
> >> On Thu, Jan 06, 2022 at 08:27:47PM +0300, Cyrill Gorcunov wrote:
> >> > On Thu, Jan 06, 2022 at 10:19:55PM +0530, Pintu Agarwal wrote:
> >> > > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> >> > > > > index 435d5c2..6e77e90 100644
> >> > > > > --- a/include/uapi/linux/sysinfo.h
> >> > > > > +++ b/include/uapi/linux/sysinfo.h
> >> > > > > @@ -12,6 +12,7 @@ struct sysinfo {
> >> > > > >       __kernel_ulong_t freeram;       /* Available memory size */
> >> > > > >       __kernel_ulong_t sharedram;     /* Amount of shared memory */
> >> > > > >       __kernel_ulong_t bufferram;     /* Memory used by buffers */
> >> > > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> >> > > > >       __kernel_ulong_t totalswap;     /* Total swap space size */
> >> > > > >       __kernel_ulong_t freeswap;      /* swap space still available */
> >> > > > >       __u16 procs;                    /* Number of current processes */
> >> > > >
> >> > > > Hi! Sorry, but I don't understand -- the sysinfo structure seems to
> >> > > > be part of user API, no? Don't we break it up here?
> >> > >
> >> > > Yes, the corresponding user space header /usr/include/linux/sysinfo.h
> >> > > also needs to be updated.
> >> > > When we generate the kernel header it will be updated automatically.
> >> >
> >> > Wait. The userspace may pass old structure here, and in result we
> >> > return incorrect layout which won't match old one, no? Old binary
> >> > code has no clue about this header update.
> >>
> >> Yes, that won't work as done.
> >>
> >> If we want to do this it needs to be done at the end of the struct right
> >> before the padding field and the newly added field substracted from the
> >> padding. (Not the preferred way to do it these days for new structs.)
> >>
> >> A new kernel can then pass in the struct with the newly added field and
> >> an old kernel can just fill the struct in as usual. New kernel will
> >> update the field with the correct value.
> >>
> >> But there's a catch depending on the type of value.
> >> The problem with these types of extensions is that you'll often need
> >> indicators to and from the kernel whether the extension is supported.
> >>
> >> Consider an extension where 0 is a valid value meaning "this resource is
> >> completely used". Since the kernel and userspace always agree on the
> >> size of the struct the kernel will zero the whole struct. So if in your
> >> newly added field 0 is a valid value you can't differentiate between 0
> >> as a valid value indicating that your resource isn't available and 0 as
> >> the kernel not supporting your extension.
> >>
> >> Other APIs solve this and similar problems by having a request mask and
> >> a return mask.  Userspace fills in what values it wants reported in the
> >> request mask and kernel sets the supported flags in the return mask.
> >> This way you can differentiate between the two (see statx).
> >>
> >> If the 0 example is not a concern or acceptable for userspace it's
> >> probably fine. But you need to document that having 0 returned can mean
> >> both things.
> >>
> >> Or, you select a value different from 0 (-1?) that you can use to
> >> indicate to userspace that the resource is used up so 0 can just mean
> >> "kernel doesn't support this extension".
> >
> > Thanks all for your inputs.
> > As Eric suggested in other thread (pasting here for reference):
> > {
> >> Before the padding and you should reduce the size of the padding by the
> >> size of your new field.
> >
> >>> Also, I could not understand what this is for ?
> >>> Do we need to update this since sture is changed ?
> >
> >> In general padding like that is so new fields can be added.  The
> >> comment about libc5 makes me a wonder a bit, but I expect libc5 just
> >> added the padding in it's copy of the structure that it exported to
> >> userspace many many years ago so that new fields could be added.
> >
> >> Eric
> > }
> >
> > I made the changes like below and this seems to work even with older user space.
> > I mean earlier, when I ran "free" command it was giving "stack
> > smashing..." error,
> > but now the "free" command (which comes as part of busybox) works fine
> > even without recompiling with the updated header.
> >
> > These are the header changes for quick look:
> > {{{
> > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > index 6e77e90..fe84c6a 100644
> > --- a/include/uapi/linux/sysinfo.h
> > +++ b/include/uapi/linux/sysinfo.h
> > @@ -12,7 +12,6 @@ struct sysinfo {
> >         __kernel_ulong_t freeram;       /* Available memory size */
> >         __kernel_ulong_t sharedram;     /* Amount of shared memory */
> >         __kernel_ulong_t bufferram;     /* Memory used by buffers */
> > -       __kernel_ulong_t availram;      /* Memory available for allocation */
> >         __kernel_ulong_t totalswap;     /* Total swap space size */
> >         __kernel_ulong_t freeswap;      /* swap space still available */
> >         __u16 procs;                    /* Number of current processes */
> > @@ -20,7 +19,8 @@ struct sysinfo {
> >         __kernel_ulong_t totalhigh;     /* Total high memory size */
> >         __kernel_ulong_t freehigh;      /* Available high memory size */
> >         __u32 mem_unit;                 /* Memory unit size in bytes */
> > -       char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
> > Padding: libc5 uses this.. */
> > +       __kernel_ulong_t availram;      /* Memory available for allocation */
> > +       char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
> > Padding: libc5 uses this.. */
> >  };
> > }}}
> >
> > If this is fine, I will push the new patch set.
>
> Please CC linux-api@vger.kernel.org on the new posting.
>

@Christian Brauner,
Regarding 0 case I guess it is fine.
Just to cross check, I used my test program to run with some other
kernel (where there are no changes to sysinfo).
I see that the field returns 0.
# ./test-sysinfo.out
Total RAM: 249320 kB
Free RAM: 233416 kB
Avail RAM: 0 kB

And this is fine and this is also good.
This also indicates 2 things:
a) Either "availram" field is not available in this kernel version
(less than 5.1x)
==> Thus it should fall back to parsing MemAvailable from /proc/meminfo
b) Or, MemAvailable field itself is not available (less than 3.1x)

I will push the new patch set now..

Thanks all!
Pintu
