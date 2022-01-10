Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB57F489BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiAJOzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiAJOzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:55:20 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8E4C06173F;
        Mon, 10 Jan 2022 06:55:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id j83so38773368ybg.2;
        Mon, 10 Jan 2022 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEL+PwUNJ7VeDav8Vkg9ZEihg+obXr9BMf+UZGECSME=;
        b=WMmkNgc4gd0Com5/mH7FQrgGMn6uv9XH3VFL4H6JkCFziFz7n7vr/ThIe9LF7iNK9l
         x/F3Rhn09XlmkvucTt0lqtsAVsw6kcIhfJM8cSMpuafwVc6/YUgtVEDpTkuW+p6BmuJ6
         MNdiXaNftD7MnCMfFz5Ft9Wi2jh22JspVyDpqb01naJBxK1LgGpMFKoeL011q/QHNzHp
         Bpm+ZhgRQHgDhGSzcAoX0EBCYfTY0hKWpI+vauCSKbvgQzwqp2CLOQMHgUAzAu/7lIE/
         IDBx77XRa09Oq/cnWxyjiW/tzn6vwI/tsAkDH84Eu3UVwSER/dy8nFhvglkmxNK88QTn
         1MsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEL+PwUNJ7VeDav8Vkg9ZEihg+obXr9BMf+UZGECSME=;
        b=rzc8Fbla7Spg2Fanb4pVILA9kdg7yHAATHbMqPB1OjpqJTUzLA/8t3GcpnYDkW75wQ
         XzVtGqWB7h+PlxogBnF7N5WckaKv5CHVrUaNyFoj6apv/2zCeqX4Rm8PzcWzdAD3T1jy
         xMu0H4Q+23/omT3SCCT2nf5YLzsYpqlkYSnLIHUCStcH2N5EB8dMuzeisN9LSIri0bz0
         aCMYBaU0FH1+nxOLo/6h+Ji4ZGrC+gRbxojaFJ2oDzUMgRseCGijXv7X00muC8u+pBok
         LzNYSErxSD514TGnDBsFmOmD8G1YI4GyXU8slCvyPSaIKjwT9aQk5u/Rs7QwgN37BrZi
         C8eQ==
X-Gm-Message-State: AOAM530jwqvZ/JXnXPpeonrASGRHgdWzfM7qg1bMoC8bTdbqciKsJbk3
        WfRl1ROd28D/dyD5PuX/Czx42tVrzG20qMsoaww=
X-Google-Smtp-Source: ABdhPJycNKY8aWsJngqsCoXDYCvWAp/H3WkDOYKEoF7w0cRVsqvGaw4y822DqflQ0PMlIrF/yCHekML/FrBGNfrNq2E=
X-Received: by 2002:a25:98c6:: with SMTP id m6mr4482853ybo.494.1641826519183;
 Mon, 10 Jan 2022 06:55:19 -0800 (PST)
MIME-Version: 1.0
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
 <19cce51e24584c2a8090b618c580a0bd@AcuMS.aculab.com> <CAOuPNLh-WLxJ7w=_C7zKXArgZLbO7OahHHhuwAyN9E1yZvNTdQ@mail.gmail.com>
 <5aa1e8c55cf84436b35ee5557a508e8d@AcuMS.aculab.com>
In-Reply-To: <5aa1e8c55cf84436b35ee5557a508e8d@AcuMS.aculab.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 10 Jan 2022 20:25:07 +0530
Message-ID: <CAOuPNLiKU6EkacELA-ioewBADGLV3g-m=5Cd5vE8RsSNyOkVzA@mail.gmail.com>
Subject: Re: [PATCH v2] sysinfo: include availram field in sysinfo struct
To:     David Laight <David.Laight@aculab.com>
Cc:     Pintu Kumar <quic_pintu@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 at 04:05, David Laight <David.Laight@aculab.com> wrote:
>
> From: Pintu Agarwal
> > Sent: 08 January 2022 16:53
> >
> > On Sat, 8 Jan 2022 at 03:52, David Laight <David.Laight@aculab.com> wrote:
> > >
> > > From: Pintu Kumar
> > > > Sent: 07 January 2022 18:08
> > > >
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
> > > ...
> > > > diff --git a/include/uapi/linux/sysinfo.h b/include/uapi/linux/sysinfo.h
> > > > index 435d5c2..fe84c6a 100644
> > > > --- a/include/uapi/linux/sysinfo.h
> > > > +++ b/include/uapi/linux/sysinfo.h
> > > > @@ -19,7 +19,8 @@ struct sysinfo {
> > > >       __kernel_ulong_t totalhigh;     /* Total high memory size */
> > > >       __kernel_ulong_t freehigh;      /* Available high memory size */
> > > >       __u32 mem_unit;                 /* Memory unit size in bytes */
> > > > -     char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
> > >
> > > There are 4 pad bytes here on most 64bit architectures.
> > >
> > > > +     __kernel_ulong_t availram;      /* Memory available for allocation */
> > > > +     char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses this.. */
> > > >  };
> > >
> > > You've not compile-time tested the size of the structure.
> > >
> > With "32" instead of "20" in padding I get these size of sysinfo:
> > In x86-64 kernel, with app 64-bit: Size of sysinfo = 128
> > In x86-64 kernel, with app 32-bit:: Size of sysinfo = 76
> > In arm-64 kernel, with app 32-bit: Size of sysinfo = 76
>
> You need to compare the sizes before and after your patch
> to ensure it doesn't change on any architecture.

Without the changes:
On 32-bit, the size of structure = 64
On 64-bit, the size of structure = 112

With the addition of my new field (availram) if I try to fix the size
issue on one arch, the other arch gets disturbed.
I could fix the same size issue on 64-bit with below changes:

        __kernel_ulong_t freeswap;      /* swap space still available */
        __u16 procs;                    /* Number of current processes */
        __u16 pad;                      /* Explicit padding for m68k */
+       __u32 mem_unit;                 /* Memory unit size in bytes
*/        ============> Move the mem_unit up to adjust the padding
        __kernel_ulong_t totalhigh;     /* Total high memory size */
        __kernel_ulong_t freehigh;      /* Available high memory size */
-       __u32 mem_unit;                 /* Memory unit size in bytes */
+       __kernel_ulong_t availram;      /* Memory available for
allocation */   ========> Add the new field here
-        char _f[20-2*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
Padding: libc5 uses this.. */
+       char _f[28-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /*
Padding: libc5 uses this.. */   ====> Increase the size to 28 (thus _f
becomes 0 like original)
+       //char _f[4];
 };

Output with 64-bit build:
$ gcc test-sysinfo.c ; ./a.out
Total RAM: 32715804 kB
Free RAM: 1111296 kB
Size of sysinfo = 112
Size of sysinfo uptime = 8
Size of sysinfo loads = 24
Size of sysinfo totalram = 8
Size of sysinfo pad = 2
Size of sysinfo memunit = 4
Size of sysinfo _f = 0

Output with 32-bit build:
$ gcc test-sysinfo.c -m32 ; ./a.out
Total RAM: 7987 kB
Free RAM: 271 kB
Size of sysinfo = 72
Size of sysinfo uptime = 4
Size of sysinfo loads = 12
Size of sysinfo totalram = 4
Size of sysinfo pad = 2
Size of sysinfo memunit = 4
Size of sysinfo _f = 12

Are there any more suggestions/ideas to experiment with padding
changes before we give-up ?
Can we handle it using : __arch64__ check ?
Or, the only option is to add one more, say: sysinfo64 ?


> > Okay the sys robot reported some issue in 64-bit build.
> > {{{
> > >> include/uapi/linux/sysinfo.h:23:14: error: size of array '_f' is too large
> > >>    23 |         char _f[20-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];   /* Padding: libc5 uses
> > this.. */
> > >>       |              ^~
> > }}}
> >
> > Also, I got the same issue while building for arm64, so I tried to
> > adjust like this:
> > char _f[32-3*sizeof(__kernel_ulong_t)-sizeof(__u32)];
> >
> > With this the build works on both 32/64 but output fails when running
> > 32-bit program on 64-bit kernel.
> > Also, the free command on 64-bit reports "stack smashing error"..
> >
> > How do we resolve this issue to make it work on both arch ?
> > Also, I don't really understand the significance of that number "20"
> > in padding ?
>
> My guess is that someone added a char _f[20] pad to allow for expansion.
> Then two __kernel_ulong_t and one __u32 field were added, so the
> size of the pad was reduced.
> When __kernel_ulong_t is 64bit then it seems to be char _f[0]
> - which might generate a compile warning since you are supposed
> to use char _f[] to indicate an extensible structure.
> There is, however, 4 bytes of pad after the _f[] on most 64bit
> architectures.
>
Thanks, yes even I guessed the same.

> So actually there isn't enough space to anything useful at all.
>
Is this problem does not exist in other UAPI structures ?
Seems like nothing can be done to allow future expansion without
breaking existing things and without developing the new one.

Thanks,
Pintu
