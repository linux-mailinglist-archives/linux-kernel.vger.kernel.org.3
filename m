Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF3B4D2C74
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiCIJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiCIJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:49:24 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1E1107085
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:48:25 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id g26so3113233ybj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 01:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fln6PvGW2wnKK+QzB1IRt1U3qJZULX7Btq0LpotYgZ8=;
        b=aCBA+OVthA4VS9Y1iTuT1Ulu5NvBH6uc9Peb5l2HGtzAm0DHZEXRdFldxf3CgL5407
         syxlCXUdh9i5Ulaw+sFXGOWOWk+NgbXxKsoX4djjYL33sIJ86GA83H6nyzi6YpTMMUcy
         B5wWQ4zlWApoZ7BZr16DKvoECvB2j/Lwy8tNzToPsuVwRhzmAgXcO/cRj/6EAdxtvQMH
         jaXZ1biBXSYpSBHyrJo0L/zZU83/LvfaXyD2sFzDIIms+gySnWAHvmUXAsKaoQwoH8hP
         ty33b+dt2UuyLo+o7O+N1fBjuVfoDoImVVSjuFJa+CYpOe2RjUhJQ2GQN2vGxrVYMHlp
         OM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fln6PvGW2wnKK+QzB1IRt1U3qJZULX7Btq0LpotYgZ8=;
        b=pvmeQIv936DVpUM1RYoEmdodPmTyWjHL7Snlb1saKwhUtW5D5eFrVG4zW7HpAqUOQx
         bAFgDs8u6e+uUEns5D++rP8WwTBHIr0C8O9JCbFI4ULJAueMhfoqBZrYYNAc7eGWMK9E
         8qdbPT3A4ure2ehCdV0Q0UW/XzUUOka0oNBJ2qpBFXm6QzwCNvZ3LqbBFCC81j+1LrM1
         ab+9A5eKnqVI6ms9ZpHRRsiN2cKi/oG5tzqnoagHTwWG4wouLvJqZBfzgrhoZkPgRHPU
         dbO1EPBU38bZcXX33vQIkdo2rNt8VvbtiMQx70D10QCVsSEGsHvnZSKsBjRNIIu8ckoO
         OunA==
X-Gm-Message-State: AOAM533bUW/0fFt/AJ2ZW1oxJ6jOKjtPr+UIq39EU8/+rmLur11ClJhR
        mxDpLObtYkC6SnU7u7+3AOEOGaFvefMsRPNp/1S7JAkqXAtRXwZX
X-Google-Smtp-Source: ABdhPJyy6zrbbRiDtVFJWv8sDtpwAXkouQgedzw+wOQXFn+W4G+U9PZgKD489X0PYyRHy1/fDwgDFe2lFmloj4u0Q7U=
X-Received: by 2002:a25:da91:0:b0:628:aa84:f69e with SMTP id
 n139-20020a25da91000000b00628aa84f69emr16534271ybf.603.1646819303539; Wed, 09
 Mar 2022 01:48:23 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 9 Mar 2022 15:18:12 +0530
Message-ID: <CA+G9fYtpy8VgK+ag6OsA9TDrwi5YGU4hu7GM8xwpO7v6LrCD4Q@mail.gmail.com>
Subject: [next] arm: Internal error: Oops: 5 PC is at __read_once_word_nocheck
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While boting linux next-20220308 on BeagleBoard-X15 and qemu arm the following
kernel crash reported which is CONFIG_KASAN enabled build [1] & [2].

Few configs [3]
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=y
<>
# CONFIG_UNWINDER_FRAME_POINTER is not set
CONFIG_UNWINDER_ARM=y
CONFIG_ARM_UNWIND=y


metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: cb153b68ff91cbc434f3de70ac549e110543e1bb
  git_describe: next-20220308
  kernel-config: https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/config

[    0.000000] Linux version 5.17.0-rc7-next-20220308
(tuxmake@tuxmake) (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1
20210110, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP @1646729452
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7), cr=10c5383d
<trim>
[[0;32m  OK  [0m] Started Rebuild Dynamic Linker Cache.
[   10.756111] 8<--- cut here ---
[   10.757434] Unable to handle kernel paging request at virtual
address 00003fe4
[   10.760221] [00003fe4] *pgd=00000000
[   10.761624] Internal error: Oops: 5 [#1] SMP ARM
[   10.763414] Modules linked in:
[   10.764628] CPU: 0 PID: 152 Comm: udevadm Not tainted
5.17.0-rc7-next-20220308 #1
[   10.767979] Hardware name: Generic DT based system
[   10.770206] PC is at __read_once_word_nocheck+0x0/0x8
[   10.772606] LR is at unwind_frame+0x680/0xab4
[   10.774676] pc : [<c0313ffc>]    lr : [<c031482c>]    psr: 600f0013
[   10.777544] sp : c66b3910  ip : c34d5940  fp : 00000000
[   10.779972] r10: 00000000  r9 : c66b3a20  r8 : 809b47af
[   10.782413] r7 : c2957230  r6 : 00003fe4  r5 : 00004004  r4 : c66b3990
[   10.785427] r3 : 00004004  r2 : 00000007  r1 : 00000000  r0 : 00003fe4
[   10.788443] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   10.791726] Control: 10c5383d  Table: 4746006a  DAC: 00000051
[   10.794420] Register r0 information: non-paged memory
[   10.796788] Register r1 information: NULL pointer
[   10.799004] Register r2 information: non-paged memory
[   10.801346] Register r3 information: non-paged memory
[   10.803719] Register r4 information: non-slab/vmalloc memory
[   10.806367] Register r5 information: non-paged memory
[   10.808720] Register r6 information: non-paged memory
[   10.811091] Register r7 information: non-slab/vmalloc memory
[   10.813728] Register r8 information: non-paged memory
[   10.816094] Register r9 information: non-slab/vmalloc memory
[   10.818743] Register r10 information: NULL pointer
[   10.820974] Register r11 information: NULL pointer
[   10.823227] Register r12 information: non-slab/vmalloc memory
[   10.825895] Process udevadm (pid: 152, stack limit = 0xed5429af)
[   10.828682] Stack: (0xc66b3910 to 0xc66b4000)
[   10.830737] 3900:                                     00000000
c8b591c0 c8b59210 c3842400
[   10.834526] 3920: c34d5940 00008000 00003fe4 c66b3a6c c66b3a78
c66b3a70 b7cd672c c61d7380
[   10.838303] 3940: c66b3a74 c66b3dac c2957230 00000003 c66b3a20
1965ee6e 00000000 c5cf6400
[   10.842074] 3960: 41b58ab3 c277a460 c03141ac 00000000 c3573fc0
c4550588 c2d0a900 c0519f68
[   10.845841] 3980: 41b58ab3 c2789cf8 c382243c 00000000 c053bf94
00000003 c61d7380 25706000
[   10.849623] 39a0: c4c04000 c7f1d810 c7f1d828 00004004 c4052058
00003fe4 c182cf44 00000000
[   10.853410] 39c0: c452e758 00000064 00090009 00000003 00090009
00000002 00000002 c08cb260
[   10.857200] 39e0: c2d0a900 b7cd6744 c66b3a80 c61d7380 c66b3a40
c3573fc0 00000003 1965ee6e
[   10.860998] 3a00: 1965ee6e 00000000 600f0013 c66b3b60 1965ee6e
c28974e0 c66b3bc4 c043af20
[   10.864821] 3a20: 1965ee6e c2c13820 00000000 c038559c c2c13820
1965ee6e c2c13820 c61d7380
[   10.868604] 3a40: b7cd6754 c61d7380 00000000 00000004 00000cc0
c2c07150 c66b3a94 c030da40
[   10.872378] 3a60: c66b3ac0 00000000 00000000 00004004 c66b3db0
c182cf44 c182cf44 c66b3dac
[   10.876170] 3a80: c66b3cf8 1965ee6e 00260026 c66b3b00 b7cd6770
c040c060 00000026 c08cb260
[   10.880372] 3aa0: 41b58ab3 c278c190 c040bfdc 000800e0 c19943e0
c7f1d800 c66b3cb4 c0562a1c
[   10.884274] 3ac0: 00000005 00000040 c66b3ba0 00000001 00000001
c61d7380 c0990664 00000cc0
[   10.888160] 3ae0: c7f1d800 c66b3cb4 02e39ae9 0000b8e6 00000000
c03cc370 c745b400 b7cd676c
[   10.892023] 3b00: c2c06f50 0000b8e6 c66b3b80 c03ccaec c66b3d00
1965ee6e 00000000 c66b3ba0
[   10.895925] 3b20: c28974e0 00000000 c2cf6560 c051d4c4 00000012
c3801200 00000cc0 c61d7380
[   10.899823] 3b40: 00000004 c3801204 c2c07278 c66b3ba0 00000001
c61d7380 00000000 00000000
[   10.903713] 3b60: 41b58ab3 c2788e18 c03cce00 c61d7380 b7cd677c
c61d7380 00000000 c053746c
[   10.907826] 3b80: 41b58ab3 c2796554 c051d3a8 c030da40 c66b3c00
00000000 00000000 c66b3bc4
[   10.911698] 3ba0: c03ccaec c03a75dc c03ad5e0 c03b482c c182cf44
1965ee6e 1965ee6e c66b3c40
[   10.915579] 3bc0: c4550588 c040c060 b7cd6788 1965ee6e 00000000
1965ee6e c745c400 e82aabc0
[   10.919456] 3be0: c745b400 8079a2ac 00000002 e82aab40 00000000
00000000 e82aacc4 c03a75dc
[   10.923335] 3c00: c9055504 00000000 00000000 00000001 00000000
c61d7380 b7cd6788 c745b480
[   10.927195] 3c20: c66b3ca0 1965ee6e c040bfdc c61d7380 00000000
1965ee6e 00000000 c9055504
[   10.931078] 3c40: 41b58ab3 c2788e18 c03a7440 c053746c c9055500
c61d7380 ff7eae78 c6237000
[   10.934959] 3c60: 25706000 00000000 00013542 600f0093 c61d7654
c044e294 c61d7600 c745c000
[   10.938847] 3c80: 00013542 00000000 00013542 00000000 c6237000
c03ac094 00000800 c09a7ee8
[   10.942733] 3ca0: 41b58ab3 1965ee6e e82aabc0 c745b400 c745b400
e82aabc0 e82ab180 c3511180
[   10.946603] 3cc0: 8079a2ac 00000002 e82aad1c c03ad5e0 00000000
c745b400 c3511960 e82aab40
[   10.950482] 3ce0: c2c06f50 e82ab1ec e82aabc0 c61d7614 c76e3480
c03b482c c289578c 1965ee6e
[   10.954348] 3d00: c61d7380 c3801200 00000000 c356e980 00000cc0
00000004 00000cc0 c2c07150
[   10.958214] 3d20: c0615340 c0516d4c c4c04c80 c2c18b20 c2c070dc
c8b5be00 00000000 c66b3e50
[   10.962131] 3d40: c8b5be44 c66b3e10 c66b3e10 00000000 00000003
c0615340 c66b3e10 00000001
[   10.966006] 3d60: 00000001 c66b3df0 c66b3ec0 b7cd67b8 c7f1d800
c61d7380 c66b3f40 c66b3ec0
[   10.969884] 3d80: c66b3e10 00000000 c19abc80 c053bf94 00000003
c61d7380 25706000 c4c04000
[   10.973748] 3da0: c7f1d810 c7f1d828 00004004 c182cf44 c7f1d814
00020001 c7f1d800 00000020
[   10.977609] 3dc0: 41b58ab3 c2797334 c053ba98 c2ba4b40 00000002
00000002 c61d7598 c61d7388
[   10.981622] 3de0: b7cd67c0 c4c04ca8 c66b3e60 e82ab16c b6acaf65
00000003 00080040 000800e0
[   10.985553] 3e00: 41b58ab3 c27887f4 c182c9ac c04cb4d8 00010000
00000000 00000003 c66b3df0
[   10.989488] 3e20: 00000001 00000000 c08c2d08 00000100 00000001
c04061c0 e82ab400 c7f1d900
[   10.993781] 3e40: c053dec0 c04021e0 00000000 00000000 c7f1d800
00000000 00000000 00000000
[   10.997862] 3e60: 00000000 00000000 00000000 40040000 00000000
00000000 c61d75a4 c03002c4
[   11.001983] 3e80: 00000002 5ac3c35a b6dffc88 c66b3fb0 c66b3ea4
c182d8e4 c387f780 c61d7ae4
[   11.006052] 3ea0: 00000003 c61d7380 c66b3f80 c61d7380 b6acaf65
c056c8bc 5ac3c35a 00004000
[   11.010057] 3ec0: 41b58ab3 c27970a8 c0537a1c 0051d5b8 c7f1d800
1965ee6e c7f1d820 c7f1d800
[   11.014050] 3ee0: b7cd67e4 c7f1d800 c61d7380 c66b3f80 c7f1d840
00000000 00000000 c053c37c
[   11.018369] 3f00: 41b58ab3 c2798010 c055c494 00000000 00000000
00000000 00000012 00000000
[   11.022313] 3f20: 41b58ab3 c2797380 c053c2c0 00000000 00000000
00000000 c350fb20 c0391fe0
[   11.026184] 3f40: 00000000 00000000 c7f1d900 c61d7380 c350fb20
00000001 aedbb900 c0385240
[   11.030043] 3f60: c7f1d900 c61d7380 00000001 00000006 c03002c4
c61d7380 00000006 1965ee6e
[   11.033946] 3f80: c7f1d900 0051d5b8 b6aca434 0048c1c0 00000004
c03002c4 c61d7380 00000004
[   11.037790] 3fa0: aedbb900 c03000c0 0051d5b8 b6aca434 00000003
b6acaf65 00000003 00000000
[   11.041654] 3fc0: 0051d5b8 b6aca434 0048c1c0 00000004 00000003
b6acaf65 0045b9f4 aedbb900
[   11.045561] 3fe0: 0048be3c b6aca400 0040b29c aecbe4c0 600f0010
00000003 00000000 00000000
[   11.049425]  __read_once_word_nocheck from unwind_frame+0x680/0xab4
[   11.052517]  unwind_frame from __save_stack_trace+0x70/0x94
[   11.052560]  __save_stack_trace from stack_trace_save+0x84/0xac
[   11.052595]  stack_trace_save from __kfence_alloc+0x11c/0x9d0
[[  [0; 1321.m05  OK  26[030m]]   St__kfarentedce O_alpkglo fc firsrot
bootm  conf__igkmaurell.
oc+0x460/0x58c
[   11.065215]  __kmalloc from kernfs_fop_write_iter+0xdc/0x240
[   11.068069]  kernfs_fop_write_iter from vfs_write+0x4fc/0x6d0
[   11.070909]  vfs_write from ksys_write+0xbc/0x154
[   11.073228]  ksys_write from ret_fast_syscall+0x0/0x54
[   11.075812] Code: e8bd8070 eec11e10 e3a00000 e12fff1e (e5900000)
[   11.079039] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/4677964#L600
[2] https://lkft.validation.linaro.org/scheduler/job/4677965#L2390
[3] https://builds.tuxbuild.com/2661dIAPUjE2DMJvye91He2gus0/
