Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F859A524
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350907AbiHSRKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 13:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352909AbiHSRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 13:10:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623411B4D2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:30:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f21so5118996pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:to:from:cc:subject:date:from:to:cc;
        bh=abzc3IOKnyG7znaSmuM01q+gkHWZzs9HSxr2HJ0iv2I=;
        b=zN1oJKSHaYJnt399XMEgCNiDx5IFWzHDDfmVDnEfaIhQwq0JOFS1xyHjyodC6823TG
         Oe6ULewp3RIbm4ja2NINrl7wnhn1j+05WCs/jIVopJNL0KF+ptDkdQfSxq6mXPX6QYAq
         uRIJqTSvDVc6sQEGF1Gaqsipw/V5nofBpJX3JYtVQsr8M0GRSmGZpYMyEa5vFfjGya2N
         UXUaNFZ3O4uVl69RFUv1Dacp8LLGtaBrZltuST81we2rPgFYJPyD429sIeK+DK/h2yX+
         Bg1xUOVLEEf3KwyN7q4mExNlEN+Lk8upd2NszmG/eRZcZnktH5zOskNliY38WvpfTvkR
         2Ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc;
        bh=abzc3IOKnyG7znaSmuM01q+gkHWZzs9HSxr2HJ0iv2I=;
        b=4FuYg5tBFhyD+M3oB10fL0gZtVSAw3D6mCX8avbLvuAo8WnUpMn7RfvaXWThu7+vpJ
         WifYtM0KfLh/NBiV4c0p6Z/GpG3NRFRINX9cPHituel3rYwgwLfaaXGjsHbknq1/HBDM
         1BfSTyNruDukhNHmVMD+xa/Bg903GAEqG3S954LNdph5VVZmKK5pxucDvMAq5mUByFT4
         6LVC9jVlCSupzHzCAAeKQzaXn14JJxY5wSvvnMEaekylN1r1LiirQbi+RXKuG55xr3A5
         NQ8FR5DX7K8Fglrjk4Hd5AsYWlKqFPX4RfCHF7PJBhkO12lOnebirUFlefrk+8lY2hEm
         XVaw==
X-Gm-Message-State: ACgBeo2pD+bvlEkLt30KIS4Tot5xA7blhNXnWl2sWotMY+gSqPTFd/VN
        /XcUhtTofPoGehHv9VuhgU1so6diBR8x4w==
X-Google-Smtp-Source: AA6agR6TstUoTsCyFarnRhLu89OJkhoG4+9grz0keRlRZ7DUxoVPSTmy6IFj6kWsetXsrU6Uv83TEg==
X-Received: by 2002:a17:902:e805:b0:16f:4a25:b5bd with SMTP id u5-20020a170902e80500b0016f4a25b5bdmr7948210plg.85.1660926524787;
        Fri, 19 Aug 2022 09:28:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id mm24-20020a17090b359800b001f24c08c3fesm5515603pjb.1.2022.08.19.09.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:28:44 -0700 (PDT)
Date:   Fri, 19 Aug 2022 09:28:44 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Aug 2022 09:28:42 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.0-rc2
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-74337228-62c4-40ed-b7af-0d988ff94993@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc2

for you to fetch changes up to 96264230a6817bcd4a7ae0fc30c60bfb46499f68:

  perf: riscv legacy: fix kerneldoc comment warning (2022-08-18 14:19:26 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.0-rc2

* A fix to make the ISA extension static keys writable after init.  This
  manifests at least as a crash when loading modules (including KVM).
* A fixup for a build warning related to a poorly formed comment in our
  perf driver.

----------------------------------------------------------------
Andrew Jones (1):
      riscv: Ensure isa-ext static keys are writable

Conor Dooley (1):
      perf: riscv legacy: fix kerneldoc comment warning

 arch/riscv/kernel/cpufeature.c  | 2 +-
 drivers/perf/riscv_pmu_legacy.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
