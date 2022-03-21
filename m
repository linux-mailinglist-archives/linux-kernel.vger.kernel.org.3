Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0594C4E2357
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbiCUJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238396AbiCUJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:30:48 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:488:66:1000:2ea3:7291:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F122B191
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:29:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FA575CD07;
        Mon, 21 Mar 2022 10:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1647854956; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=b7RW9fXWhylpRSbGeJmunDT0CS9knZcJbO4bFAhNtik=;
        b=cU/s0f3R3Vm/+HwStGMOry0aNmxDKNzXH6EKxO69TgW7eOQdDUAwkCxKiMbKptaCH+ELVY
        Px0sXMOiMY2gYV/PRW/A2Lo649EEwyRoVGjMTr+ARD1yGAEi/zx5DCfrSo1QyzaHMLMEU0
        XxxDpABXRTyvYLYuLyJ8Yd6mPyWgu2jjg+tXZJQr1RQqSYdN7jfViAQqgYrgGld7wedHaY
        1RTIeBE9yz57DwWczLd0fIS3NqnJvvgKz5/mxUFbbJZoloJ5WFIE7gNS8qY96Fh0utDagH
        i555U7m6S/+WIyjmfwvICyysqX7eriPMUnEfDnXMMOnV1JVnRBmHKiDLI/ND6Q==
Date:   Mon, 21 Mar 2022 10:29:13 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: [ANNOUNCE] 4.19.235-rt106
Message-ID: <164785484522.16899.3791817109174125365@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.235-rt106 stable release. This just
is just an update to the latest stable update. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 56a5ccf805575928700ca71f287622cb8b74f5f4

Or to build 4.19.235-rt106 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.235.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.235-rt106.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.233-rt105:
---

Borislav Petkov (1):
      x86/speculation: Merge one test in spectre_v2_user_select_mitigation()

Clément Léger (1):
      net: phy: DP83822: clear MISR2 register to disable interrupts

Dan Carpenter (1):
      staging: gdm724x: fix use after free in gdm_lte_rx()

Daniel Wagner (2):
      Merge tag 'v4.19.235' into v4.19-rt
      Linux 4.19.235-rt106

Duoming Zhou (1):
      ax25: Fix NULL pointer dereference in ax25_kill_by_device

Emil Renner Berthing (1):
      riscv: Fix auipc+jalr relocation range checks

Emmanuel Gil Peyrot (1):
      ARM: fix build error when BPF_SYSCALL is disabled

Eric Dumazet (1):
      sctp: fix kernel-infoleak for SCTP sockets

Greg Kroah-Hartman (2):
      Linux 4.19.234
      Linux 4.19.235

Jia-Ju Bai (1):
      net: qlogic: check the return value of dma_alloc_coherent() in qed_vf_hw_prepare()

Jiasheng Jiang (2):
      net: ethernet: ti: cpts: Handle error for clk_enable
      net: ethernet: lpc_eth: Handle error for clk_enable

Josh Poimboeuf (3):
      x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
      x86/speculation: Warn about Spectre v2 LFENCE mitigation
      x86/speculation: Warn about eIBRS + LFENCE + Unprivileged eBPF + SMT

Josh Triplett (1):
      ext4: add check to prevent attempting to resize an fs with sparse_super2

Juergen Gross (11):
      xen/xenbus: don't let xenbus_grant_ring() remove grants in error case
      xen/grant-table: add gnttab_try_end_foreign_access()
      xen/blkfront: don't use gnttab_query_foreign_access() for mapped status
      xen/netfront: don't use gnttab_query_foreign_access() for mapped status
      xen/scsifront: don't use gnttab_query_foreign_access() for mapped status
      xen/gntalloc: don't use gnttab_query_foreign_access()
      xen: remove gnttab_query_foreign_access()
      xen/9p: use alloc/free_pages_exact()
      xen/pvcalls: use alloc/free_pages_exact()
      xen/gnttab: fix gnttab_end_foreign_access() without page specified
      xen/netfront: react properly to failing gnttab_end_foreign_access_ref()

Kim Phillips (2):
      x86/speculation: Use generic retpoline by default on AMD
      x86/speculation: Update link to AMD speculation whitepaper

Marek Marczykowski-Górecki (2):
      Revert "xen-netback: remove 'hotplug-status' once it has served its purpose"
      Revert "xen-netback: Check for hotplug-status existence before watching"

Mark Featherston (1):
      gpio: ts4900: Do not set DAT and OE together

Mark Rutland (1):
      arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()

Miaoqian Lin (2):
      ethernet: Fix error handling in xemaclite_of_probe
      gianfar: ethtool: Fix refcount leak in gfar_get_ts_info

Michael S. Tsirkin (2):
      virtio: unexport virtio_finalize_features
      virtio: acknowledge all features before access

Mike Kravetz (1):
      selftests/memfd: clean up mapping in mfd_fail_write

Mohammad Kabat (1):
      net/mlx5: Fix size field in bufferx_reg struct

Nathan Chancellor (1):
      ARM: Do not use NOCROSSREFS directive with ld.lld

Pavel Skripkin (1):
      NFC: port100: fix use-after-free in port100_send_complete

Peter Zijlstra (3):
      x86,bugs: Unconditionally allow spectre_v2=retpoline,amd
      x86/speculation: Add eIBRS + Retpoline options
      Documentation/hw-vuln: Update spectre doc

Peter Zijlstra (Intel) (1):
      x86/speculation: Rename RETPOLINE_AMD to RETPOLINE_LFENCE

Qu Wenruo (1):
      btrfs: unlock newly allocated extent buffer after error

Randy Dunlap (1):
      ARM: Spectre-BHB: provide empty stub for non-config

Robert Hancock (1):
      net: macb: Fix lost RX packet wakeup race in NAPI receive

Russell King (Oracle) (8):
      ARM: report Spectre v2 status through sysfs
      ARM: early traps initialisation
      ARM: use LOADADDR() to get load address of sections
      ARM: Spectre-BHB workaround
      ARM: include unprivileged BPF status in Spectre V2 reporting
      ARM: fix co-processor register typo
      ARM: fix build warning in proc-v7-bugs.c
      ARM: fix Thumb2 regression with Spectre BHB

Sami Tolvanen (1):
      kbuild: add CONFIG_LD_IS_LLD

Steven Price (1):
      arm/arm64: Provide a wrapper for SMCCC 1.1 calls

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

Tom Rix (1):
      qed: return status of qed_iov_get_link

suresh kumar (1):
      net-sysfs: add check for netdevice being present to speed_show
