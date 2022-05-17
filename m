Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BFB529B03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241629AbiEQHhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiEQHfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:35:47 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386E49CA8;
        Tue, 17 May 2022 00:34:24 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id s6so7281627ilp.9;
        Tue, 17 May 2022 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=pEIcGVNsbeP6EiKjnzSjTr7kPW4tfGTBsDC1SnKAcwM=;
        b=AWgu/vGIkG8SmK3kIloR1l6q55qvAy1lBIHmOz8KORVQPGImI9XQpuXsSewqtqK4dY
         AhJuZcWVYo2jdg5ieemepA284NKyMoJ8SDzMFb/B36gaJgd5p69vb+m3LABO/YVtbrtf
         n6v8I7qGuiH4GdumG8EsJ+0e/nbhe8akw3iEC4oblawPKLd29OgOzARUx9xeYM2yCNR7
         HqbkoJQ+I13WPVx6ZsHls7+ypCXVOk3/tPt0JUP+vqdY85PWOj+7DAbYm8jzeBx9vKBD
         lTwBelAoH0dqeTRw2yh3z0YH7gmQOtRiPHxGx9UZEj+VOYhaoVrkej3TEfVDv2frlzEk
         xA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=pEIcGVNsbeP6EiKjnzSjTr7kPW4tfGTBsDC1SnKAcwM=;
        b=zlH8fmcZO4U5cmDfcH6hTpFQ1QKvXLA1TKLfTWE6EsBoRqPbzw7c1/7uW6pgMrWedu
         8W9c4lA68FFcvNNMNnmxmM8gErn1VE6FSE+ezA5EdwP/6URd1r5WWVW4n3Le63fwlGkB
         7T8HG/utk3Rk0w6OnipmY63886WTbuYxlAU9CrazLDpSHcow9dUirTsOPi6GMgnsBA4i
         9FIO+23MPPGuPOCDO2cl0m+gx46DSavPrtAIiUN7w3Oqp0Sy61x3X/1Nems4d9TYEAZ5
         aARUxckjb3NqQLapsvDmqujCVS9n4avtZ7lAbEzDjpYbJA2L6UE3RB5Nz7JOBSMLHC8q
         zbBQ==
X-Gm-Message-State: AOAM531ipZqzwAYakFRtnui3PjI62T+AgNisUOvTgjqC8JdDWmIRJEp3
        drSQ/QPbZySCrjps+oelp37zAhEIG3nzPgej6QI=
X-Google-Smtp-Source: ABdhPJxpxXwSTo6irCiTCVwfZuGB/jC8kC7emFTJHW5uAL3gMHm1SrXQKLS+6z5JRZflp7ueEwaZj1o0WavbtC3Flvs=
X-Received: by 2002:a05:6e02:1a88:b0:2d1:f00:78b0 with SMTP id
 k8-20020a056e021a8800b002d10f0078b0mr7010341ilv.20.1652772863639; Tue, 17 May
 2022 00:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220513202159.1550547-1-samitolvanen@google.com>
 <CA+icZUWr+-HjMvY1VZf+nqjTadxSTDciux0Y5Y-+p_j4o7CmXg@mail.gmail.com> <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
In-Reply-To: <CABCJKueVcwYishxSoEyn9b1vaGTXdoYWF7VyANPm7V=H+yyfhQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 17 May 2022 09:33:47 +0200
Message-ID: <CA+icZUUBqz1zTcj61nK=sbkWcSncKYZgR2Qg0FSCWi9un84yLw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/21] KCFI support
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
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

On Mon, May 16, 2022 at 7:57 PM Sami Tolvanen <samitolvanen@google.com> wro=
te:
>
> On Mon, May 16, 2022 at 10:31 AM Sedat Dilek <sedat.dilek@gmail.com> wrot=
e:
> >> Anything Like LLVM cmake Options to be condidered and Set?
> >
> >
> > I activate Clang and LLD ad projects - OK - enough?
>
> Clang and LLD should be sufficient.
>

Before I give this a try...
Some questions about the LLVM toolchain requirements...

I use tc-build to generate a selfmade LLVM toolchain for X86
(stage1-only + BPF).

$ python3 ./build-llvm.py --no-update --build-type Release -p
clang;lld -t X86;BPF --clang-vendor dileks -B
/home/dileks/src/llvm-toolchain/build -I /opt/llvm-toolchain
--check-targets clang lld --build-stage1-only --install-stage1-only -D
LLVM_PARALLEL_LINK_JOBS=3D1 --show-build-commands

Link: https://github.com/ClangBuiltLinux/tc-build.git

tc-build uses a GOOD_REVISION for regular kernel-builds, this is
currently 3b2e605e33bd.

$ git describe
llvmorg-15-init-5163-g3b2e605e33bd

$ git show -1 42a879eb2f22
commit 42a879eb2f22af6d1b85983c12fac68b2e9a5e03
Author: Nathan Chancellor <nathan@kernel.org>
Date:   Mon Mar 21 09:19:26 2022 -0700

   build-llvm.py: Update known good revision

   Qualified with https://github.com/nathanchance/llvm-kernel-testing.

   Signed-off-by: Nathan Chancellor <nathan@kernel.org>

diff --git a/build-llvm.py b/build-llvm.py
index c3aade1092ec..54e5d4729a1a 100755
--- a/build-llvm.py
+++ b/build-llvm.py
@@ -16,7 +16,7 @@ import urllib.request as request
from urllib.error import URLError

# This is a known good revision of LLVM for building the kernel
-GOOD_REVISION =3D '08f70adedb775ce6d41a1f8ad75c4bac225efb5b'
+GOOD_REVISION =3D '3b2e605e33bd9017ff2eff1493add07822f9d58b'


class Directories:

So, your LLVM git is approx. 5.200 commits further.

$ git log --oneline
tc-build/GOOD_REVISION-20210321..for-15/kcfi-rfc-v2-samitolvanen | wc
-l
5190

Is your tags/kcfi-rfc-v2 the recommended LLVM toolchain for testing kcfi-rf=
c-v2?

What I want to ask is if your commit well tested for x86 (and arm64)
means build and boot on bare metal?

From Nathan I know if he says I have run kernel-tests - it works.
"Qualified with https://github.com/nathanchance/llvm-kernel-testing."

Just for the records:
You definitely need a pre-LLVM-15 toolchain + KCFI sanitizer patch?
LLVM-14?

> >> This series is also available in GitHub:
> >>
> >>   https://github.com/samitolvanen/linux/commits/kcfi-rfc-v2
> >>
> >>
> >>
> >
> >> Can you please add a history of what changed?
>
> Oops, I forgot to include that.
>

Thanks.
Please fold this ChangeLog into kcfi-rfc-v3.

> Changes in v2:
> - Changed the compiler patch to encode arm64 target and type details
> in the ESR, and updated the kernel error handling patch accordingly.
> - Changed the compiler patch to embed the x86_64 type hash in a valid
> instruction to avoid special casing objtool instruction decoding, and
> added a __cfi_ symbol for the preamble. Changed the kernel error
> handling and manual type annotations to match.
> - Dropped the .kcfi_types section as that=E2=80=99s no longer needed by
> objtool, and changed the objtool patch to simply ignore the __cfi_
> preambles falling through.
> - Dropped the .kcfi_traps section on arm64 as it=E2=80=99s no longer need=
ed,
> and moved the trap look-up code behind CONFIG_ARCH_USES_CFI_TRAPS,
> which is selected only for x86_64.
> - Dropped __nocfi attributes from arm64 code where CFI was disabled
> due to address space confusion issues, and added type annotations to
> relevant assembly functions.
> - Dropped __nocfi from __init.
>
> > Nathan has a i915 cfi patch in His personal kernel.org Git.
> > Is this relevant to kcfi?
>
> It fixes a type mismatch, so in that sense it's relevant.
>

Here the link to patch "drm/i915: Fix CFI violation with show_dynamic_id()"=
:

https://git.kernel.org/pub/scm/linux/kernel/git/nathan/linux.git/commit/?h=
=3Dsubmitted/i915-cfi-fix&id=3D53735be6dc53453fcfbac658e847b54360e73871

> > To distinguish between clang-cfi we should use different kbuild variabl=
es for kcfi.
>
> The plan is to replace the current CFI implementation. Does reusing
> the kbuild variable names cause a problem?
>

No hurry.
Afaics someone in the long list of comments to single patches was
thinking of when GCC has "KCFI" support implemented...

You say no need to build your kernel with LTO...
That sounds good.
Currently, I build my kernels with Clang-14 and CONFIG_LTO_CLANG_THIN=3Dy.
Does something speak against using CONFIG_LTO_CLANG_THIN=3Dy with KCFI supp=
ort?
Build-time?
Disc-usage?

Thanks for answering my questions.

- Sedat -
