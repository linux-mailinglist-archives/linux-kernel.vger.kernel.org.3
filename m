Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2835358D8E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbiHIMrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiHIMq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:46:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB9BE0C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:46:55 -0700 (PDT)
Received: from mail-ed1-f53.google.com ([209.85.208.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MG9Pg-1oBWBl26Pc-00GW01 for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022
 14:46:53 +0200
Received: by mail-ed1-f53.google.com with SMTP id r4so14923710edi.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:46:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo1+zSt3Rgq7JmEiU7R6Vu0GLzHbA6vaesy0G4eRB6GzKmFivBKM
        oKL1foAFNDTVQPZEZcp+B+h7qRIQ2rjKAtK0C1w=
X-Google-Smtp-Source: AA6agR6Xuo8oq3O93hYf9/RvjWY1aU8DCMG2Z/kMBHq6EOz9ee/eJ7mLajy5lJizAABBbY8Pdw7DvT09sNceWQOXAwQ=
X-Received: by 2002:a05:6402:3693:b0:43d:1a40:21fd with SMTP id
 ej19-20020a056402369300b0043d1a4021fdmr16756256edb.206.1660049213118; Tue, 09
 Aug 2022 05:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <YuvctaLwRi+z0Gw4@nvidia.com> <CAFCwf12wD3uEhr+kxwN9ROXApHzGh_n1je5susZV5NgGR9fCcQ@mail.gmail.com>
 <Yuxi1eRHPN36Or+1@nvidia.com> <CAFCwf13QF_JdzNcpw==zzBoEQUYChMXfechotH31qmAfYZUGmg@mail.gmail.com>
 <CAFCwf107tLxHKxkPqSRsOHVVp5s2tDEFOOy2oDZUz_KGmv-rDg@mail.gmail.com>
 <YvCozvgodIY19LSr@kroah.com> <YvFOEPdC9r8QBH11@nvidia.com>
 <YvH9X5puer4jpzMX@kroah.com> <YvIU/wMdqFA1fYc6@infradead.org>
 <CAK8P3a3y2=FyzK4S6MRfZdrz=DdLat1ajdT_uPmN533mNYmF9w@mail.gmail.com> <YvJQqxWAQbevR9Ok@nvidia.com>
In-Reply-To: <YvJQqxWAQbevR9Ok@nvidia.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Aug 2022 14:46:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2149buJammrS=hqHPjKOYLRjJOxpSuT8-D_avYPZndOA@mail.gmail.com>
Message-ID: <CAK8P3a2149buJammrS=hqHPjKOYLRjJOxpSuT8-D_avYPZndOA@mail.gmail.com>
Subject: Re: New subsystem for acceleration devices
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5W7DOJUDEevjM8KPpXzU3m8GiDen41AiZgpgfeBI/A6BsGmmj1n
 e4HaJkatGQFbfeP6+97t7yzffwKYHADRrOiVAMWV18RL9RkVyPhERE4sJGRE0fsJ+LUJuPI
 PSajsOvpAinghZ1rM8vDnpZlF9cd6j2B6I6/pkV3zoA+DgzAaUbj/2395iYPSQamzeqEYI7
 BPl59NhqLDyIzg9Bn0/VQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZcSB44UJGIM=:tIG6GcI3tMJunk28B+6fE2
 w3hW40+eRMCq2prY6LWLHmvKR7CuHirgKC3dNMjDijHlqfLZiC7nR1nE0XUKaLlv/wnhUXmfu
 EMTm5w60kBWxmTSEhy1udUhJPU++8hx+XowVSHhFkpdIRdoPfDbTpebjZvHjSPJ1pDGWlcy7Q
 /HGsWVr7+IFkOmTA/TLAa0oRSCarTrktSHPYji+b+2MBqqVrlU4baJczEkU53cwSEbZ5FTAXZ
 8Z1IWKbbSVRFFYbpVyAigiB7QKcpdm/7eljgdAumEenPHJ+LJUbIBIwZHxJ7N6u20t81S+M3i
 KXTqNFLjSWXRU16GEA2OSZw1tkR0ewI0dS9aYBcjzuYE8y7OHVViVvkGlmpYYLXHJK5NPbhAL
 nfTFvE2t60rlN9TI5syA7rUFAr0IApkXDsjoRtE2v3FD2RdIJQmChdYTGmW5bYNKVe6MVj5Ln
 03OwPiy4jCVIXvXh0DQb/ELKGZjxbc9u8NkPMFfVC0n3vD8rK6JAh/KN/NCDxwTX5mraa0k0G
 GJm66KRCWTRULNI/ZcRoS8yZT4QpvsO719jPnrgYFWomz6bMgn0ANZsQ6bIKlHVeZ6mVGC6/a
 F3Y7fihqZDG3kyK4u4uTE39XL+mYCiytTF6+5zYjcfzTKSYT/VGOoHs1Gw4m4G2nrbN3iJODk
 uSJM48zkLaNeWg6BbH+RlFBs7+uWvrhmY1hhrUeUBjBhTzcvsCRWYHXlugajyKIQTorJZ+nh/
 I8t4GMTsBf629FC2+hu4uwoqNv91r0+Yfu9sI0f+6oKXCJvFSo6Etqn2wwzGFD2Y/SWf530H1
 O6/35eNwa4q56y0FYcWtwqiB/ZMZqa80jjXvc1y8vvnuMo7r6u39kvJZ3Lt0poOE9qh76lko8
 Eyt6GDA5YJRZQBEr4ONQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 9, 2022 at 2:18 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Tue, Aug 09, 2022 at 10:32:27AM +0200, Arnd Bergmann wrote:
> > On Tue, Aug 9, 2022 at 10:04 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > I think for devices with hardware MMU contexts you actually want to
> > bind the context to a 'mm_struct', and then ensure that the context
> > is only ever used from a process that shares this mm_struct,
> > regardless of who else has access to the same file or inode.
>
> I can't think of a security justification for this.
>
> If process A stuffs part of its address space into the device and
> passes the FD to process B which can then access that addresss space,
> how is it any different from process A making a tmpfs, mmaping it, and
> passing it to process B which can then access that address space?
>
> IMHO the 'struct file' is the security domain and a process must be
> careful to only allow FDs to be created that meet its security needs.
>
> The kernel should not be involved in security here any further than
> using the standard FD security mechanisms.
>
> Who is to say there isn't a meaningful dual process use case for the
> accelerator? We see dual-process designs regularly in networking
> accelerators.

I think there is a lot of value in keeping things simple here, to
make sure users and developers don't make a mess of it. If the
accelerator has access to the memory of one process but I run
it from another process, I lose the benefits of the shared page
tables, but gain a lot of the complexity that I think the 'single-opener'
logic was trying (without success) to avoid.

E.g. attaching a debugger to single-step through the accelerator code
would then involve at least four address spaces:

 - the addresses of the debugger
 - the addresses local to the accelerator
 - addresses in the shared address space of the process that owns
   the memory
 - addresses in the process that owns the accelerator context

which is at least one more than I'd like to deal with.

This is somewhat different for accelerators that have coherent
access to a process address space and only access explicitly
shared buffers. On these you could more easily allow sharing the
file descriptor between any number of processes.

       Arnd
