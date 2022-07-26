Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43B580F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiGZJDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 26 Jul 2022 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGZJDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:03:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E422AC55
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:03:17 -0700 (PDT)
Received: from mail-ed1-f47.google.com ([209.85.208.47]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuUvS-1nOqnp30vC-00rae0 for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022
 11:03:15 +0200
Received: by mail-ed1-f47.google.com with SMTP id m8so16912192edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 02:03:15 -0700 (PDT)
X-Gm-Message-State: AJIora82R75SH/LVVXdX0lipIYlkmlmJbgnSLVU5CoSHdzYltFSbpGot
        +7CnY7HnEBxNYYTWmC1K8g5lt7mlwlfC9vjiuO0=
X-Google-Smtp-Source: AGRyM1uM4FGsU1Sfwdcu3eSFPSMGUqP71dbbyYOxhCDhMTwGw3Str5b2UpaCbD8rBQQ/NhAwvtPpctYnLNTq/5Ffs+s=
X-Received: by 2002:a05:6402:28c4:b0:43a:cdde:e047 with SMTP id
 ef4-20020a05640228c400b0043acddee047mr17514935edb.368.1658826195405; Tue, 26
 Jul 2022 02:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220722090929.mwhmxxdd7yioxqpz@pali> <6b227478-73b8-2a97-1c78-89570d928739@csgroup.eu>
 <20220723150702.jecerkhxhy65dgww@pali> <875yjld2oe.fsf@mpe.ellerman.id.au>
 <20220725125256.cg6su4d2ageylvp6@pali> <e2487668-b6d9-9ddb-1bb4-9f4d37fae1a7@csgroup.eu>
 <20220725201009.gwuchzswcqaxntrk@pali> <20220725215416.GV25951@gate.crashing.org>
 <20220726083406.tcjvny6d2di6q7ar@pali>
In-Reply-To: <20220726083406.tcjvny6d2di6q7ar@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Jul 2022 11:02:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2iM+RoySWEC2e0==rwBSVrZoRa8c4ADyFNB24JZM=hkw@mail.gmail.com>
Message-ID: <CAK8P3a2iM+RoySWEC2e0==rwBSVrZoRa8c4ADyFNB24JZM=hkw@mail.gmail.com>
Subject: Re: Regression: Linux v5.15+ does not boot on Freescale P2020
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:V/HIU2XZ8wpI5/ZfF7yOvcXNQGzmM1ugUEx8XIklX8wqgpHdwCH
 Uhwgnu+p1DjRIwNWUUvDFDtP7dGhkn+BDQYQ7tVt2ofW+b0zjudk7RRhoTPRY9J6AVsbLoN
 OrDFIR3ijfNTFwzADcw5c8tpPETl3ae5kluz2Gr1L9+l2h5FhyJmg7M34J3XgiEOTU2wjjF
 jstPY7otGCVp5Yx+PT4Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H6WvOHL6Xyc=:S1HgeVFeHNCcB1p1pzBV/1
 h4pMGZuY/YszX6yAYdfVPQC50M+C1BAWJGTPW98DU6bvwkDhoF+NxNcni2zSHRfQlUPkhoenu
 VYJ9+OCvqQ21HoAnuIt613bH+yH4bKMHaS5OEbHVQa48A0+oTA/XaBtq5AtEOv0SqEkvdGxXN
 o52ABR/eYEWrdP7GAk8J68EvIsDfylhmBOAhNqwLnWAO2zhas5Dg3Od247pY/2BxKux8jWI+b
 sAbv5KfSWabXhBRzGkXMNgqgHqEYNekdG7KOsiEm8aIxvt46rtjV2Qu/sO2ASdEAkgyqbO6kV
 eT2ZCQossb1DM736WIfwBzHhkeAZdmCgrWWzBqyG4M3s0TcDoA0mDnpgKuGrmyhdyDGUa/pto
 t7ZuAG3qLbwPjtzLEguuf+ANW1xsXsH9xQedUgWee0Mio555mrX3/TgbkOKWD0vMdHqQcka2N
 21r+45TcONS/wE0hR0ck/YWaovFuWmLU+HO7JOLbzwkEPJEdDBebQH3YIAdRniBwtapiv4ZqJ
 /dSU654BM/8ulH3kIw5BL3LO4+L+UKCOqEaeqZ5rAxyv8jAi4mXtA6A3Y7yZXtk5KXcbS2Qj5
 3HU/DOku/5H/wMagzeAmQpDxQCjWYji4K4fW6ms6TScwr24K9A4jZ4Xb/zjfTYZXxiDPrTztx
 JbaAbnuUKC+PvGk8mIr7hHPmHeQHPpXcn1RHfdPGshox7v/njHalGRUeM3FmXtZRz4JXmTw3T
 wMN9yYIxsigO/9l/J+GMViXS4jCQj9jiq/t/ZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:34 AM Pali Rohár <pali@kernel.org> wrote:
> On Monday 25 July 2022 16:54:16 Segher Boessenkool wrote:
> > On Mon, Jul 25, 2022 at 10:10:09PM +0200, Pali Rohár wrote:
> > > On Monday 25 July 2022 16:20:49 Christophe Leroy wrote:
> > > Now I did again clean test with same Debian 10 cross compiler.
> > >
> > > $ git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git && cd linux
> > > $ git checkout v5.15
> > > $ make mpc85xx_smp_defconfig ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > > $ make vmlinux ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > > $ cp -a vmlinux vmlinux.v5.15
> > > $ git revert 9401f4e46cf6965e23738f70e149172344a01eef
> > > $ make vmlinux ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnuspe-
> > > $ cp -a vmlinux vmlinux.revert
> > > $ powerpc-linux-gnuspe-objdump -d vmlinux.revert > vmlinux.revert.dump
> > > $ powerpc-linux-gnuspe-objdump -d vmlinux.v5.15 > vmlinux.v5.15.dump
> > > $ diff -Naurp vmlinux.v5.15.dump vmlinux.revert.dump
> > >
> > > And there are:
> > >
> > > -c000c304:      7d 20 f8 29     lwarx   r9,0,r31,1
> > > +c000c304:      7d 20 f8 28     lwarx   r9,0,r31
> > >
> > > I guess it must be reproducible this issue as I'm using regular
> > > toolchain from distribution.
> >
>
> > The EH field in larx insns is new since ISA 2.05, and some ISA 1.x cpu
> > implementations actually raise an illegal insn exception on EH=1.  It
> > appears P2020 is one of those.
> >
>
> P2020 has e500 cores. e500 cores uses ISA 2.03. So this may be reason.
> But in official Freescale/NXP documentation for e500 is documented that
> lwarx supports also eh=1. Maybe it is not really supported.
> https://www.nxp.com/files-static/32bit/doc/ref_manual/EREF_RM.pdf (page 562)
> At least there is NOTE:
> Some older processors may treat EH=1 as an illegal instruction.

In commit d6ccb1f55ddf ("powerpc/85xx: Make sure lwarx hint isn't set on ppc32")
this was clarified to affect (all?) e500v1/v2, this one apparently
fixed it before,
but Christophe's commit effectively reverted that change.

I think only the simple_spinlock.h file actually uses EH=1 and this is not
included in non-SMP kernels, so presumably the only affected machines were
the rare dual-core e500v2 ones (p2020, MPC8572, bsc9132), which would
explain why nobody noticed for the past 9 months.

          Arnd
