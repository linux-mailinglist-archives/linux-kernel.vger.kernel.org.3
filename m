Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F254E7863
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358147AbiCYPum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiCYPuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:50:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9980A2DE0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:49:05 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w4so8427158ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU4PpVun15CjYOS+Kcp+U9XJU5F8p5wc/1y7BVXGRtk=;
        b=JdyP4p7gNyMT3HZGNbV3XM4eqxDm+fB8KidHH+CkQusOFydnPcb94Q4F3hH/FfbwXD
         2n3Vmp6AHvHzuQsn6rkJbMf03ShX/MIezjYOH8m1n1x2mwH0sayaCPWVPYoa3U5CdyZu
         9bWEl66Wf5pYryXgkkA7q3Dc4lWaN6haXahe+15arX0LHpal3glkh9uruWUuWQy7/du1
         e8WGFtZPJ8N5mpvlaRVA5K8KBslzjDcxpbbzf4fmDTAd9/uwEKoJndjU2k56fDjbpwn1
         pcyM5bvHt93Wm0tbnRo+kjebmU7Gazmm3Dkb8DNFqO87S9WHUd5j2LFLvBT8Ery0Q9Mt
         vi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PU4PpVun15CjYOS+Kcp+U9XJU5F8p5wc/1y7BVXGRtk=;
        b=kYSNGSRcYfc0J5PkuXlwLZIibucDOV1QtaHUNYnrQ9F2Y6TzPI46OVtyo/dHHcjrh0
         JKEEKi+vm08UPXBRMcGCs/xRiXU7ykHIeJtNZNTz8weNC8FCO1CQ0It9IfZFQXeJZ5qn
         J2E90q4NpO6IcV0sGG4BDuIzCd76E/EI4Ac9uP34ju60e1Z9MhUglI0wUo95sYUo22Id
         ziEo3TQvhpW2f910pCw1vKZ8zgoIWMZuyN4z4+/i2nZ/tBLKBFX63CGiX64DoKGyVCof
         qSjzk3psk3UA2tpEUH+MTUgsMI7VCdLOeeeZ8jtAS2Dz6XWM+YHoGA4r30cvnbjK01W1
         BP9Q==
X-Gm-Message-State: AOAM531y5Op3h0yP4bNzfokNZMShdxEnzuG26yUIgUR0JRCibYkxdqD8
        NlKrZjB8to8TfXpaqjGdcLzm4EDPHfF7QQ==
X-Google-Smtp-Source: ABdhPJwx9f7dtYa7G9xRihuFbtIOa/EHiD1/eAIZmv+KK3Wniv4Rcmp395xBto2u+BpjDEYlk2E0LQ==
X-Received: by 2002:a17:902:da90:b0:154:4737:a3f with SMTP id j16-20020a170902da9000b0015447370a3fmr12284159plx.73.1648223344904;
        Fri, 25 Mar 2022 08:49:04 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:7734:79fa:d15c:6089])
        by smtp.gmail.com with ESMTPSA id i7-20020a628707000000b004fa6eb33b02sm6885040pfe.49.2022.03.25.08.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:49:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 00/18] xtensa updates for v5.18
Date:   Fri, 25 Mar 2022 08:48:48 -0700
Message-Id: <20220325154848.107863-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa updates for v5.18:

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git@github.com:jcmvbkbc/linux-xtensa.git tags/xtensa-20220325

(btw, I've noticed that github removed support for the unauthenticated
 git:// protocol. Should I send pull request URLs using ssh or https?)

for you to fetch changes up to 1c4664faa38923330d478f046dc743a00c1e2dec:

  xtensa: define update_mmu_tlb function (2022-03-22 09:45:09 -0700)

----------------------------------------------------------------
Xtensa updates for v5.18

- remove dependency on the compiler's libgcc
- allow selection of internal kernel ABI via Kconfig
- enable compiler plugins support for gcc-12 or newer
- various minor cleanups and fixes

----------------------------------------------------------------
Bjorn Helgaas (1):
      xtensa: Remove unused early_read_config_byte() et al declarations

Jason Wang (2):
      net: xtensa: use strscpy to copy strings
      xtensa: use strscpy to copy strings

Max Filippov (15):
      xtensa: rename PT_SIZE to PT_KERNEL_SIZE
      xtensa: use XCHAL_NUM_AREGS as pt_regs::areg size
      xtensa: add missing XCHAL_HAVE_WINDOWED check
      xtensa: add helpers for division, remainder and shifts
      xtensa: don't link with libgcc
      xtensa: add kernel ABI selection to Kconfig
      xtensa: make secondary reset vector support conditional
      xtensa: fix stop_machine_cpuslocked call in patch_text
      xtensa: fix DTC warning unit_address_format
      xtensa: merge stack alignment definitions
      xtensa: rearrange NMI exit path
      xtensa: clean up kernel exit assembly code
      xtensa: enable plugin support
      xtensa: fix xtensa_wsr always writing 0
      xtensa: define update_mmu_tlb function

 arch/xtensa/Kconfig                         |  48 ++++++++++
 arch/xtensa/Makefile                        |  10 +--
 arch/xtensa/boot/dts/xtfpga-flash-128m.dtsi |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-16m.dtsi  |   8 +-
 arch/xtensa/boot/dts/xtfpga-flash-4m.dtsi   |   4 +-
 arch/xtensa/include/asm/asmmacro.h          |  34 ++++++-
 arch/xtensa/include/asm/core.h              |   7 ++
 arch/xtensa/include/asm/pci-bridge.h        |   9 --
 arch/xtensa/include/asm/pgtable.h           |   4 +
 arch/xtensa/include/asm/processor.h         |  10 +--
 arch/xtensa/include/asm/ptrace.h            |   7 +-
 arch/xtensa/kernel/Makefile                 |   3 +-
 arch/xtensa/kernel/asm-offsets.c            |   2 +-
 arch/xtensa/kernel/entry.S                  |  75 ++++++++--------
 arch/xtensa/kernel/jump_label.c             |   2 +-
 arch/xtensa/kernel/mxhead.S                 |   2 +
 arch/xtensa/kernel/process.c                |  10 ---
 arch/xtensa/kernel/setup.c                  |  10 +--
 arch/xtensa/kernel/vectors.S                |   4 +-
 arch/xtensa/kernel/vmlinux.lds.S            |   4 +-
 arch/xtensa/kernel/xtensa_ksyms.c           |  14 ---
 arch/xtensa/lib/Makefile                    |   2 +
 arch/xtensa/lib/ashldi3.S                   |  28 ++++++
 arch/xtensa/lib/ashrdi3.S                   |  28 ++++++
 arch/xtensa/lib/divsi3.S                    |  74 ++++++++++++++++
 arch/xtensa/lib/lshrdi3.S                   |  28 ++++++
 arch/xtensa/lib/modsi3.S                    |  87 ++++++++++++++++++
 arch/xtensa/lib/mulsi3.S                    | 133 ++++++++++++++++++++++++++++
 arch/xtensa/lib/udivsi3.S                   |  68 ++++++++++++++
 arch/xtensa/lib/umodsi3.S                   |  57 ++++++++++++
 arch/xtensa/mm/tlb.c                        |   6 ++
 arch/xtensa/platforms/iss/network.c         |   4 +-
 32 files changed, 676 insertions(+), 114 deletions(-)
 create mode 100644 arch/xtensa/lib/ashldi3.S
 create mode 100644 arch/xtensa/lib/ashrdi3.S
 create mode 100644 arch/xtensa/lib/divsi3.S
 create mode 100644 arch/xtensa/lib/lshrdi3.S
 create mode 100644 arch/xtensa/lib/modsi3.S
 create mode 100644 arch/xtensa/lib/mulsi3.S
 create mode 100644 arch/xtensa/lib/udivsi3.S
 create mode 100644 arch/xtensa/lib/umodsi3.S

-- 
Thanks.
-- Max
