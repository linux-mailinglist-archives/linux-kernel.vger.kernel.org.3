Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43384B2D84
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352876AbiBKT2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:28:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239323AbiBKT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:28:20 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEEA1AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:28:18 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i6so16082853pfc.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:cc:from:to:message-id;
        bh=Uv12JWSqyaA89KyaqlTkaZWGZ+lpLktvAFt4Fx/FGy4=;
        b=XMPGoR676J2pTU7mUJtm+AGAF9HwKBRg5ENRwhQXbntkSFzSKcIiFc/2N7a5heSYlP
         dpPFFpEzlejBb7tuUDNuogz37CnMkeuwkYnrQ5w3lo92lBSyNLKaJrPfgX/g5gxxBMoG
         76Y2NoJAt63TLlWvjvHVk3iMq7sOSbnRbvLs6BDrFs2AV+mRiZvACptBhuq5kUj/+b6y
         033j9VsxzvE4jLXnG8zXeKa8u5O3ePXFfv1UdpRct0Np7rJ28DvXIFkRGEWvAMFpcjRp
         hNRoiUVSpBcVW04KxWfFTwlVEpp67Z0uwVzL4PKQbW5tIQWa6TnsGXpsWOVZRj7w0HVK
         tOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=Uv12JWSqyaA89KyaqlTkaZWGZ+lpLktvAFt4Fx/FGy4=;
        b=Z7X0FLmnENQEN62cPjqT0IV5S5evdKtShbjMQ3wMPFNB9PewESmotby0naZrp2Wwav
         zCsvitW4hkuwwTkZj20dnA0Q4PrUEZgMJe7whzxVe8OjFK6GJ3As5q/rMNLV8fswIJeS
         Iq6HIT9+zPPoArSvVDGg3GTB/Epl6FLs62E8wPqpda9HDhOckundPW2xfWM6Vt8TsMIX
         5+xj3qcylyRX5ELATi0OI5HNHwJm7DpkKq5hAUWXVr7wFFBK+/I3SONlpJm9uGkzhcLZ
         f0vdznLs2rxx8D9Cmc8RMWnCGsIBHhCzXjIvRGHLf50RmqrklPP62R63G5aKKJnBoanl
         Ix4w==
X-Gm-Message-State: AOAM533QTkJedm2YfkrxQNkDvFQeDxHe2S5XS2N8g06i8hyMWWpf7X/H
        NyTcNkSADKNs5K1zcrRVuHJ7/2PP/Mgtig==
X-Google-Smtp-Source: ABdhPJwY5u/v8sJev3tj+JnELKIaldF+H+FmT39ZaDKMGxg4aQx4gvAmGVPrCRWJovBPS13WXF3KxA==
X-Received: by 2002:a62:8442:: with SMTP id k63mr3157755pfd.54.1644607697834;
        Fri, 11 Feb 2022 11:28:17 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j10sm27936704pfu.93.2022.02.11.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 11:28:17 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:28:17 -0800 (PST)
X-Google-Original-Date: Fri, 11 Feb 2022 11:27:40 PST (-0800)
Subject: [GIT PULL] RISC-V Fixes for 5.17-rc4
CC:        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-9ae96702-cb8f-4e96-b126-0ae9b4f5a7af@palmer-mbp2014>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.17-rc4

for you to fetch changes up to 6df2a016c0c8a3d0933ef33dd192ea6606b115e3:

  riscv: fix build with binutils 2.38 (2022-02-10 09:17:01 -0800)

----------------------------------------------------------------
RISC-V Fixes for 5.17-rc4

* A fix to avoid undefined behavior when stack backtracing, which
  manifests in GCC as incorrect stack addresses.
* A few fixes for the XIP kernels.
* A fix to tracking NUMA state on CPU hotplug.
* Support for the recently relesaed binutils-2.38, which changed the
  default ISA version to one without CSRs or fence.i in I.

----------------------------------------------------------------
Aurelien Jarno (1):
      riscv: fix build with binutils 2.38

Changbin Du (1):
      riscv: eliminate unreliable __builtin_frame_address(1)

Jisheng Zhang (1):
      riscv: extable: fix err reg writing in dedicated uaccess handler

Myrtle Shah (1):
      riscv: Fix XIP_FIXUP_FLASH_OFFSET

Palmer Dabbelt (2):
      riscv/mm: Add XIP_FIXUP for phys_ram_base
      riscv/mm: Add XIP_FIXUP for riscv_pfn_base

Pingfan Liu (1):
      riscv: cpu-hotplug: clear cpu from numa map when teardown

 arch/riscv/Makefile             |  6 ++++++
 arch/riscv/kernel/cpu-hotplug.c |  2 ++
 arch/riscv/kernel/head.S        | 11 +++++------
 arch/riscv/kernel/stacktrace.c  |  9 +++++----
 arch/riscv/mm/extable.c         |  6 +++---
 arch/riscv/mm/init.c            |  2 ++
 6 files changed, 23 insertions(+), 13 deletions(-)
