Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDC54AA12
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353072AbiFNHJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiFNHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:09:22 -0400
Received: from mail.nearlyone.de (mail.nearlyone.de [46.163.114.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282F9BC87;
        Tue, 14 Jun 2022 00:09:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B4795DC28;
        Tue, 14 Jun 2022 09:09:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1655190556; h=from:subject:date:message-id:to:mime-version:content-type:
         content-transfer-encoding; bh=LU61zZsyQLzfqDARFpVtSGO6woiBxm/1cd4AGHZ5z6c=;
        b=xcc7xWqopZAk/8SULj76e8cs/Yzz7prN2CRT2TVvmUNHKh2BjjFuo+j1PiDP+FT7PwQIPK
        X+98uDcco/8GrM124oQe/G76EZz8RlfbUHZZs4IqXdc5BGgZJjjQur+6/vf7Rb85U2ov6p
        MKRv/Eh6PMwBHDd9VJeJ1HZSmac+jbrio2HsyoySg55UvRHNzF8n1QvokIQvt2B6G9JL2q
        EdCRABDIHWYNEhsfeC0ILs7pA6dhRRMPdSjLd74udk5n83gHCmNwiHt72FNtDeVNjHUtk5
        w7HCXKLB9DZYwCn2mMQ1lwBYyRP0VvxMduKKgkY0F/1astl1wJlq4TK0jPyGbQ==
Date:   Tue, 14 Jun 2022 09:08:48 +0200
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
Subject: [ANNOUNCE] 4.19.246-rt110
Message-ID: <165519045271.4481.16802639048289042479@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.19.246-rt110 stable release.  This is just
an update to the latest stable release. No RT specific changes.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 60a663a02ac911cb70dc964321b3c596e5b4c3ca

Or to build 4.19.246-rt110 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.246.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/older/patch-4.19.246-rt110.patch.xz

Signing key fingerprint:

  5BF6 7BC5 0826 72CA BB45  ACAE 587C 5ECA 5D0A 306C

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Daniel

Changes from v4.19.245-rt109:
---

Akira Yokosawa (1):
      docs: submitting-patches: Fix crossref to 'The canonical patch format'

Andy Shevchenko (1):
      ACPI: sysfs: Make sparse happy about address space in use

Arnaldo Carvalho de Melo (2):
      perf bench: Share some global variables to fix build with gcc 10
      perf tests bp_account: Make global variable static

Ben Hutchings (1):
      libtraceevent: Fix build with binutils 2.35

Chuck Lever (1):
      NFSD: Fix possible sleep during nfsd4_release_lockowner()

Dan Carpenter (1):
      dm integrity: fix error code in dm_integrity_ctr()

Daniel Wagner (2):
      Merge tag 'v4.19.246' into v4.19-rt
      Linux 4.19.246-rt110

Denis Efremov (Oracle) (1):
      staging: rtl8723bs: prevent ->Ssid overflow in rtw_wx_set_scan()

Eric Dumazet (1):
      tcp: change source port randomizarion at connect() time

Florian Westphal (1):
      netfilter: conntrack: re-fetch conntrack after insertion

Greg Kroah-Hartman (1):
      Linux 4.19.246

Gustavo A. R. Silva (1):
      drm/i915: Fix -Wstringop-overflow warning in call to intel_read_wm_latency()

Haimin Zhang (1):
      block-map: add __GFP_ZERO flag for alloc_page in function bio_copy_kern

Joel Stanley (1):
      net: ftgmac100: Disable hardware checksum on AST2600

Kees Cook (1):
      exec: Force single empty string when argv is empty

Liu Jian (1):
      bpf: Enlarge offset check value to INT_MAX in bpf_skb_{load,store}_bytes

Lorenzo Pieralisi (1):
      ACPI: sysfs: Fix BERT error region memory mapping

Marek Maślanka (1):
      HID: multitouch: Add support for Google Whiskers Touchpad

Mika Westerberg (1):
      i2c: ismt: Provide a DMA buffer for Interrupt Cause Logging

Mikulas Patocka (2):
      dm crypt: make printing of the key constant-time
      dm stats: add cond_resched when looping over entries

Miri Korenblit (1):
      cfg80211: set custom regdomain after wiphy registration

Piyush Malgujar (1):
      drivers: i2c: thunderx: Allow driver to work with ACPI defined TWSI controllers

Sarthak Kukreti (1):
      dm verity: set DM_TARGET_IMMUTABLE feature flag

Stefan Mahnke-Hartmann (1):
      tpm: Fix buffer access in tpm2_get_tpm_pt()

Stephen Brennan (1):
      assoc_array: Fix BUG_ON during garbage collect

Sultan Alsawaf (1):
      zsmalloc: fix races between asynchronous zspage free and page migration

Thomas Bartschies (1):
      net: af_key: check encryption module availability consistency

Thomas Gleixner (1):
      x86/pci/xen: Disable PCI/MSI[-X] masking for XEN_HVM guests

Willy Tarreau (1):
      secure_seq: use the 64 bits of the siphash for port offset calculation

Xiu Jianfeng (1):
      tpm: ibmvtpm: Correct the return value in tpm_ibmvtpm_probe()
