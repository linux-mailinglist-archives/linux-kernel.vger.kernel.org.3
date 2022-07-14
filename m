Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41257477E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiGNIpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiGNIp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:45:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A90540BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:45:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l23so2158674ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DCSvqcav6l8eJQqjYpF2DaiSo2frXUVuTNeqvYGx9c4=;
        b=Y0HLr3Jrkb2BkndbxJvh4HAc6m6j8GShL3F0YYnXwBmhROpgOg7sT8uX4/7/wgJ+f1
         7RhYPoxXn8Yftbqtz3Lk6446MLrhopvqxJBNUV9+lQSv34hh9yprRR3l8wIQak9sSM11
         HGNfWFkwd9belk35C8gzydc4h4jmlNGAJwvgjgS22UL3GyGhKtI+2EGtY0fMdnG75ZtN
         +xAAP1QREWz/d8vKTAsGctxsDM6cQywYrtvujNiI+Wk4GnhoS2rpJUuYiLrGPip8RTnr
         MiQ4moMZeume3nxa1gM5l1uCtGwoLXoFv8tkpnMsdFLOkIesEgbRcaona3ljIwb68IXZ
         X2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DCSvqcav6l8eJQqjYpF2DaiSo2frXUVuTNeqvYGx9c4=;
        b=I8MqtMzKqjQuoFcpcEmEbv1ruR4aF01Of38uLDUuSjPhr8axaCpjaioe/Y/is4zHVK
         gPLse6x5VABNyIv/8KpH8bid58fFM6PVJ2BCzZVk2jBEDj0m0qgdLghrIjdwtqg1HFsb
         yGWwnPmUUsG894jQ0i5SU3NPTwOW0XsiTyi+VQZXi/mf+2aSoY5AlRdpBGSqiXMHXE7i
         LPSt3oJAX6DKICPOOa2/0aCJjpuVL22wTpIxPnB5LFeYJgqhWxN5CgW7LP9WG9gu86Hh
         aMf4o3su9eVpmwGTOHmEZdMj8m7eHUC6u4uXNs1gF/eFtcmBmsLeQKq8N7dGGufl8zE8
         a2jg==
X-Gm-Message-State: AJIora8ylF9DcRJm36Pgg30kiLvxPBbA/5N1tpFWeT/P5tdtXFeB0Qyn
        Whip4i5J9w0uIDQUUgc4MLYpT15NX2UibRYIb+PWZZqfv9i5Ig==
X-Google-Smtp-Source: AGRyM1tGSWZeAf/bcOSZSnUFtmu/Ol3Pw434l46o5MWH60pWrYtA9fX6Dz2r/yt6iRLOqsDbpnjg95nZ2ZT5oTR3dwY=
X-Received: by 2002:a17:907:b0a:b0:72b:3176:3fe5 with SMTP id
 h10-20020a1709070b0a00b0072b31763fe5mr7622175ejl.48.1657788318691; Thu, 14
 Jul 2022 01:45:18 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 14 Jul 2022 14:15:07 +0530
Message-ID: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com>
Subject: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
 RETBleed attacks, data leaks possible!
To:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Results from Linaro=E2=80=99s test farm.

We are booting the i386 kernel on an x86 machine.
With Spectre V2 patches merged into Linux mainline we have been noticing
RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable to
RETBleed attacks, data leaks possible!
Please find the detailed boot log in the below link [1] and [2].

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: 4a57a8400075bc5287c5c877702c68aeae2a033d
  git_describe: v5.19-rc6-115-g4a57a8400075
  kernel_version: 5.19.0-rc6
  kernel-config: https://builds.tuxbuild.com/2Bu6unA4pJ0TotIOQ6jcNKfhmew/co=
nfig
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline=
/-/pipelines/587353280
  artifact-location: https://builds.tuxbuild.com/2Bu6unA4pJ0TotIOQ6jcNKfhme=
w
  toolchain: gcc-11

boot log:
---------
[    0.000000] Linux version 5.19.0-rc6 (tuxmake@tuxmake)
(i686-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU ld (GNU Binutils for
Debian) 2.38) #1 SMP PREEMPT_DYNAMIC @1657744061
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'

<trim>

[    1.275957] LSM: Security Framework initializing
[    1.275957] SELinux:  Initializing.
[    1.275957] Mount-cache hash table entries: 2048 (order: 1, 8192
bytes, linear)
[    1.275957] Mountpoint-cache hash table entries: 2048 (order: 1,
8192 bytes, linear)
[    1.275957] CPU0: Thermal monitoring enabled (TM1)
[    1.275957] process: using mwait in idle threads
[    1.275957] Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
[    1.275957] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    1.275957] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    1.275957] Spectre V2 : Mitigation: Retpolines
[    1.275957] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    1.275957] RETBleed: WARNING: Spectre v2 mitigation leaves CPU
vulnerable to RETBleed attacks, data leaks possible!
[    1.275957] RETBleed: Vulnerable
[    1.275957] Speculative Store Bypass: Vulnerable
[    1.275957] L1TF: Kernel not compiled for PAE. No mitigation for L1TF
[    1.275957] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.275957] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
[    1.275957] MMIO Stale Data: Vulnerable: Clear CPU buffers
attempted, no microcode
[    1.275957] SRBDS: Vulnerable: No microcode

Full test log link,
[1] https://lkft.validation.linaro.org/scheduler/job/5282509#L490
[2] https://qa-reports.linaro.org/lkft/linux-mainline-master-sanity/build/v=
5.19-rc6-115-g4a57a8400075/testrun/10817056/suite/log-parser-boot/tests/

Best regards
Naresh Kamboju

--
Linaro LKFT
https://lkft.linaro.org
