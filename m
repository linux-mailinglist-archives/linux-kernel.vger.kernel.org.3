Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7DB4E241E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344477AbiCUKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbiCUKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:18:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5875399ECA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:17:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1517F210E4;
        Mon, 21 Mar 2022 10:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647857834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SzkFjLShwfU4UWYLoXbolwOgRQD8kBZbbw6hAMUhHlA=;
        b=rx7/SZo5kRRzkgFhYcdIuHXyMWj4sSDW7C7STjtQ5mLTPhbjXZSG1ALHus/btQAVcFj7Cu
        t5jTjeyWJzbkVB98n6rR8Mf4Ytmy4V7IWorvpxiqE/vq2j287oEDaLaSr3r88TZi6MCVfZ
        KoULqkZvun/fySfYiEn5nyCazNmVBys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647857834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SzkFjLShwfU4UWYLoXbolwOgRQD8kBZbbw6hAMUhHlA=;
        b=Qv6mBNm5INvrO0DQF8ZMkAzvF7J34hC/jgL/RJTBrhy971N85E4wiRCBpJtIct9K+wKVht
        LERZGBboQXrQkeCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0736213AD5;
        Mon, 21 Mar 2022 10:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P5O3AapQOGJldQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:17:14 +0000
Date:   Mon, 21 Mar 2022 11:17:15 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for 5.18
Message-ID: <YjhQq9ZAfgSk3im3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/cpu updates for 5.18.

Thx.

---
The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.18_rc1

for you to fetch changes up to 08f253ec3767bcfafc5d32617a92cee57c63968e:

  x86/cpu: Clear SME feature flag when not in use (2022-02-16 19:45:53 +0100)

----------------------------------------------------------------
- Merge the AMD and Intel PPIN code into a shared one by both vendors.
Add the PPIN number to sysfs so that sockets can be identified when
replacement is needed

- Minor fixes and cleanups

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      x86/CPU/AMD: Use default_groups in kobj_type

Jim Mattson (1):
      x86/cpufeatures: Put the AMX macros in the word 18 block

Mario Limonciello (1):
      x86/cpu: Clear SME feature flag when not in use

Tony Luck (5):
      x86/cpu: Merge Intel and AMD ppin_init() functions
      x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
      x86/cpu: Read/save PPIN MSR during initialization
      topology/sysfs: Add format parameter to macro defining "show" functions for proc
      topology/sysfs: Add PPIN in sysfs under cpu topology

 Documentation/ABI/stable/sysfs-devices-system-cpu  |  4 ++
 Documentation/ABI/testing/sysfs-devices-system-cpu |  6 ++
 arch/x86/include/asm/cpufeatures.h                 |  6 +-
 arch/x86/include/asm/processor.h                   |  2 +
 arch/x86/include/asm/topology.h                    |  1 +
 arch/x86/kernel/cpu/amd.c                          | 35 ++--------
 arch/x86/kernel/cpu/common.c                       | 79 ++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/amd.c                      |  7 +-
 arch/x86/kernel/cpu/mce/core.c                     |  7 +-
 arch/x86/kernel/cpu/mce/intel.c                    | 42 ------------
 arch/x86/kernel/cpu/scattered.c                    |  1 +
 arch/x86/kernel/process.c                          |  5 +-
 drivers/base/topology.c                            | 20 +++---
 include/linux/topology.h                           |  3 +
 14 files changed, 125 insertions(+), 93 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
