Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA02949FE55
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350259AbiA1QuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349979AbiA1QuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:50:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96242C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:50:03 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id g2so5654797pgo.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VRPDGMB2yv2UCcnyNA1XpQwhMox6PqjnnqptMofNKR4=;
        b=dTBBeXMyg1oj7klVQGzyS8Pb6J1TmwcLk3mELUpgI3UsMN24RFRMpWN7iqcbI5PgCu
         QaWS2lof3mq2x+BuWlTbiSuoLBwYliMitZgVWgsqUSUKLbHwEy58VR22Qql8zAy1/sTN
         fcKfk5DifS8VHL8ES5rU3AgTcM7E5PRbm3FcuT8ipKwXRhPyJmlDbg3C0WKX3BZApWjZ
         Ix3CHYZRfvLTz6Kgx2becCCoYgBHFGWFtAymrtZrSP/UzoSZWov0QCpBWBJoGTkJ0wLU
         Rd4MPgdKpJqnDTl7lX3lclbeoKs2GZQ26mU7ufprI0dbpXP/D6Jbwklc9dtxAJJVAk+7
         xepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VRPDGMB2yv2UCcnyNA1XpQwhMox6PqjnnqptMofNKR4=;
        b=MkFIwGNuamNsGctPjq0pvw7ite0dwhVtYDOByoj5nphfhnAGVgFAHyklcoqnPGAyt+
         /DHnknNkx/MJ6KkTp7GhtHhLlYGHa9fNG1yBLx9oJiRfYP5nAI1X5fgy3xwLr3mrW3Kq
         hvglIjaleT5QyLgt9lCFMGAgoZUmfDqVXTODyx78VK7cc9q2HP8esAXyCiLwi5VHNx/W
         BPTSk83JnIWwUg2vzRZ+8LbbXESfBIoagA3f754jzppz2pJ6yBtGsVAsWW4GsGBULsFi
         YaPLk0KBBuNBEIfZx6iTANcWvDIwYMln6lrAGfck2BFyLcaz1WkeOKYvnGilaYsZL1OJ
         FPww==
X-Gm-Message-State: AOAM530pBsKfglZdmSRFN9xJFmfFh0PzxtxEFhHIQWcCiNBipU08lrKH
        P7+FhtIrZXKUUmD+TLzmw2GXDODN2XrwiBNVTzCK1lo1
X-Google-Smtp-Source: ABdhPJyd2+oGjlGWVy/GU2KOrUTbh+YI67jawNt4aUdIX5x7oXnyeY4+J0f34V8rjPfqxAUrhf0seNoo46SKLv/ePDU=
X-Received: by 2002:a62:15c3:: with SMTP id 186mr8870670pfv.59.1643388602926;
 Fri, 28 Jan 2022 08:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20220128075346.GG8421@xsang-OptiPlex-9020> <YfO39Q3mNHMQOkd4@gofer.mess.org>
In-Reply-To: <YfO39Q3mNHMQOkd4@gofer.mess.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 28 Jan 2022 08:49:51 -0800
Message-ID: <CAADnVQJ3RCPUQ0k9nu2urrRK=U7SUetuPmY0_b17M_PD=j4fkw@mail.gmail.com>
Subject: Re: [tools headers UAPI] e2bcbd7769: kernel-selftests.ir.make_fail
To:     Sean Young <sean@mess.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 1:32 AM Sean Young <sean@mess.org> wrote:
>
> On Fri, Jan 28, 2022 at 03:53:46PM +0800, kernel test robot wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: e2bcbd7769ee8f05e1b3d10848aace98973844e4 ("tools headers UAPI: =
remove stale lirc.h")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >
> > in testcase: kernel-selftests
> > version: kernel-selftests-x86_64-db530529-1_20220124
> > with following parameters:
> >
> >       group: group-01
> >       ucode: 0xe2
> >
> > test-description: The kernel contains a set of "self tests" under the t=
ools/testing/selftests/ directory. These are intended to be small unit test=
s to exercise individual code paths in the kernel.
> > test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
> >
> >
> > on test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz with=
 16G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> >
> >
> > 2022-01-27 18:57:29 make -C ir
> > make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir'
> > gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-e2bcbd7769ee8f05e1b3d10848aace989738=
44e4/tools/testing/selftests/ir/ir_loopback
> > ir_loopback.c: In function =E2=80=98main=E2=80=99:
> > ir_loopback.c:147:20: error: =E2=80=98RC_PROTO_RCMM32=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98RC_PROTO_RC6_MCE=E2=
=80=99?
> >     if (rc_proto =3D=3D RC_PROTO_RCMM32 &&
> >                     ^~~~~~~~~~~~~~~
> >                     RC_PROTO_RC6_MCE
> > ir_loopback.c:147:20: note: each undeclared identifier is reported only=
 once for each function it appears in
> > make: *** [../lib.mk:146: /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir/i=
r_loopback] Error 1
> > make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir'
> > 2022-01-27 18:57:29 make run_tests -C ir
> > make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir'
> > gcc -Wall -O2 -I../../../include/uapi    ir_loopback.c  -o /usr/src/per=
f_selftests-x86_64-rhel-8.3-kselftests-e2bcbd7769ee8f05e1b3d10848aace989738=
44e4/tools/testing/selftests/ir/ir_loopback
> > ir_loopback.c: In function =E2=80=98main=E2=80=99:
> > ir_loopback.c:147:20: error: =E2=80=98RC_PROTO_RCMM32=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98RC_PROTO_RC6_MCE=E2=
=80=99?
> >     if (rc_proto =3D=3D RC_PROTO_RCMM32 &&
> >                     ^~~~~~~~~~~~~~~
> >                     RC_PROTO_RC6_MCE
>
> So this commit removes the copy of lirc.h from tools/include/uapi/linux/l=
irc.h,
> so now the test uses /usr/include/linux/lirc.h. It appears that this file
> does not have RC_PROTO_RCMM32 defined on this system, which means it is a
> kernel header from v5.1 or earlier (this was added in commit
> 721074b03411327e7bf41555d4cc7c18f49313f7).
>
> It looks like this machine is redhat 8.3, which ships with kernel 4.18.
>
> I guess my change was far too optimistic; I had no ideal enterprise kerne=
ls
> were so ancient.
>
> We should probably drop e2bcbd7769ee8f05e1b3d10848aace98973844e4. Sorry a=
bout
> the turbulence.

I'd rather avoid reverting.
Just add ifdef or something to shut up the error on old distros.

>
> Sean
>
> > ir_loopback.c:147:20: note: each undeclared identifier is reported only=
 once for each function it appears in
> > make: *** [../lib.mk:146: /usr/src/perf_selftests-x86_64-rhel-8.3-kself=
tests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir/i=
r_loopback] Error 1
> > make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselft=
ests-e2bcbd7769ee8f05e1b3d10848aace98973844e4/tools/testing/selftests/ir'

Please trim your replies.
