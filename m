Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE0450836A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbiDTIcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356317AbiDTIcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:32:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F035A8A;
        Wed, 20 Apr 2022 01:29:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u5-20020a17090a6a8500b001d0b95031ebso1340979pjj.3;
        Wed, 20 Apr 2022 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uAM52mYRx4qBEh42tbPo6qRRezPozANpFEE+yUsZh1M=;
        b=PLBx8sIfEo7u7z0vDmz374mj6swYn89R0DC396DQ1IrKdi6dtsykJG7OpVWO6BprE3
         d+osOcXdTb2UWBy19hUay57jdOueZzEG2i/wbIF9VUUwiphodqy7XCKe4PnFa8b64LWM
         YohwU+lps6GObSG34fz53DOoDTK1WyeSGCcRyYuuhBeBCWnWvrz2i7G+maIP+Ku9cI/2
         WnYGlAOo3Vpc7eBBeQQzyyjZT9/BfAom/1v/06uA1MdZD25YZ7ejcrtY5rpDjjsFgj55
         YzZmPXImfDL62N2cI9Oo+h2s3nUZRULbGdcEIU4o418DJaYfvRorkrRIbIgecpjTODkV
         b2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uAM52mYRx4qBEh42tbPo6qRRezPozANpFEE+yUsZh1M=;
        b=DC1c7+rV/ZgOCtsknDtFx+PFUkPdrSlsjk/nK76n8fTKFJiAIKlIdsOx4DPKBq1Pf7
         RlaU0OcHJtVlfGupSFEv70gekzdCidmxa7Xf9DAeFt2ESSht05hVl/yqp/hHk54tbenK
         tNkdCSiVaf/rSl4QK7A1F4TAO1ztT9DLmRIOz5dmxzAYbAoRwQoBD9vKIqO0hYXgGYSR
         +qhyDcBAf3aH3Bn6DY5TElaDlKUeRXTJMIblXlZ7q+3DorAi4Dxs24ajyK7OvCuqqX4A
         mgjeenP2NER3rPAtS3KFB2idNLzdGEdFX09iRfr5/aREb//lhTiSpN2gH5KXXDC4/9nc
         S63Q==
X-Gm-Message-State: AOAM530BtyIxHTq03bbm2VIfvP59JIwSpxasaCnsYYYtNYAD8B+yhrHK
        Zj12hSOpoi8c4qGc6CNid/MnWeBduOXbwe0hPtPhWCTwR90=
X-Google-Smtp-Source: ABdhPJztltEmK8pxuKsgH84cz3z1ArsVEVvKIsVhy7FM2nE1eHHgpkkAhkBr7DgY8ILW7tHZ5UN3S2yGbMwtFd2Q0HU=
X-Received: by 2002:a17:903:18f:b0:15a:d3e:1e47 with SMTP id
 z15-20020a170903018f00b0015a0d3e1e47mr7424334plg.54.1650443354615; Wed, 20
 Apr 2022 01:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220420175500.240e4eb3@canb.auug.org.au>
In-Reply-To: <20220420175500.240e4eb3@canb.auug.org.au>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 20 Apr 2022 01:29:03 -0700
Message-ID: <CAAH8bW9gb+OKcTHUFDE9V38F=yniXZyxauBmbapre3ymBc9Zwg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the bitmap tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

(Adding Maxim Kuvyrkov from linaro/TCWG as he might be interested in
arm part of this.

On Wed, Apr 20, 2022 at 12:55 AM Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
>
> Hi all,
>
> After merging the bitmap tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/b=
itmap.h:425: WARNING: Unexpected indentation.
> Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/b=
itmap.h:426: WARNING: Block quote ends without a blank line; unexpected uni=
ndent.
> Documentation/core-api/kernel-api:87: /home/sfr/next/next/include/linux/b=
itmap.h:431: WARNING: Unexpected indentation.
>
> Introduced by commit
>
>   6f46c24da767 ("bitmap: add bitmap_weight_{cmp, eq, gt, ge, lt, le} func=
tions")

I'll build docs and fix those warnings. Thanks for pointing this out.

From previous linux-next build message:

> ../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_weight_cmp';=
 have 'int(const long unsigned int *, unsigned int,  int)'
>    21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int=
 bits, int num)
>       |     ^~~~~~~~~~~~~~~~~~~
> In file included from ../lib/bitmap.c:6:
> tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitma=
p_weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsi=
gned int)'
>    15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int=
 bits,
>       |     ^~~~~~~~~~~~~~~~~~~
> ../lib/bitmap.c: In function '__bitmap_weight_cmp':
> ../lib/bitmap.c:26:50: error: comparison of integer expressions of differ=
ent signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
>    26 |                 if (w + bits - k * BITS_PER_LONG < num)
>       |                                                  ^
> ../lib/bitmap.c:31:23: error: comparison of integer expressions of differ=
ent signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare]
>    31 |                 if (w > num)
>       |                       ^
> cc1: all warnings being treated as errors
> tools/perf/../lib/bitmap.c:21:5: error: conflicting types for '__bitmap_w=
eight_cmp'; have 'int(const long unsigned int *, unsigned int,  int)'
>    21 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int=
 bits, int num)
>       |     ^~~~~~~~~~~~~~~~~~~
> In file included from tools/perf/../lib/bitmap.c:6:
> tools/include/linux/bitmap.h:15:5: note: previous declaration of '__bitma=
p_weight_cmp' with type 'int(const long unsigned int *, unsigned int,  unsi=
gned int)'
>    15 | int __bitmap_weight_cmp(const unsigned long *bitmap, unsigned int=
 bits,
>       |     ^~~~~~~~~~~~~~~~~~~
> tools/perf/../lib/bitmap.c: In function '__bitmap_weight_cmp':
> tools/perf/../lib/bitmap.c:26:50: error: comparison of integer expression=
s of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare=
]
>    26 |                 if (w + bits - k * BITS_PER_LONG < num)
>       |                                                  ^
> tools/perf/../lib/bitmap.c:31:23: error: comparison of integer expression=
s of different signedness: 'unsigned int' and 'int' [-Werror=3Dsign-compare=
]
>    31 |                 if (w > num)
>       |                       ^
> cc1: all warnings being treated as errors

I fixed tools build error and updated the bitmap-for-next branch. The
problem is that tools/perf
enables -Werror=3Dsign-compare, and main kernel not. So direct copying
of functions from kernel
to tools doesn't work. This might be an issue by itself because I
think it would be better to keep
kernel and tools code consistent whenever possible.

Another problem is that the tools lacks testing from (obviously) me,
0-day and TCWG. I added
tools/perf to my testing build suite, and found that the build fails
for arm and s390 on v5.18-rc2.
See tools/perf build log attached.

Thanks,
Yury

s390:
  PERF_VERSION =3D 5.18.rc2.gce522ba9ef7e
In file included from /usr/s390x-linux-gnu/include/stdio.h:866,
                 from
/home/yury/work/linux/tools/lib/perf/include/perf/cpumap.h:7,
                 from util/session.c:13:
In function =E2=80=98printf=E2=80=99,
    inlined from =E2=80=98dump_event=E2=80=99 at util/session.c:1292:2,
    inlined from =E2=80=98machines__deliver_event=E2=80=99 at util/session.=
c:1502:2,
    inlined from =E2=80=98perf_session__deliver_synth_event=E2=80=99 at uti=
l/session.c:1703:9:
/usr/s390x-linux-gnu/include/bits/stdio2.h:112:10: error: =E2=80=98%s=E2=80=
=99
directive argument is null [-Werror=3Dformat-overflow=3D]
  112 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt,
__va_arg_pack ());
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
util/session.c: In function =E2=80=98perf_session__deliver_synth_event=E2=
=80=99:
util/session.c:1292:25: note: format string is defined here
 1292 |  printf("\n%#" PRIx64 "@%s [%#x]: event: %d\n",
      |                         ^~
cc1: all warnings being treated as errors

arm:
  PERF_VERSION =3D 5.18.rc2.gce522ba9ef7e
/tmp/ccHIlKZJ.s: Assembler messages:
/tmp/ccHIlKZJ.s:541: Error: selected processor does not support `ldrd
r0,r1,[r2]' in ARM mode
/tmp/ccHIlKZJ.s:630: Error: selected processor does not support `strd
r4,r5,[r3]' in ARM mode
make[9]: *** [/home/yury/work/linux/tools/build/Makefile.build:96:
/home/yury/work/linux/build/arm/tools/perf/arch/arm/util/auxtrace.o]
Error 1
