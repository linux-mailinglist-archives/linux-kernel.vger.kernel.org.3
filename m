Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37EF4896B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbiAJKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:48:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244189AbiAJKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:48:04 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55A4621108;
        Mon, 10 Jan 2022 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641811683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E2Ac87/Ro/HmgxBQ3HvbRbTupeaxFQ8Madpkt8mKMbM=;
        b=EfBt0o9zyZvOhs7a9i0xS8VnZGHePKbK1jdfYE/yuhN1igI96r0Hje2lb5Lvpej4wseN05
        mVLAyRAhO6X3GVSPBSxlG/JwBalPRtMrLWVqgZ9NuC1cOG/Ne9RasDnhCWi9yyH1sN54N6
        dIJHLArw+zlBoppIE8Ji/vxIrj9xrSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641811683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=E2Ac87/Ro/HmgxBQ3HvbRbTupeaxFQ8Madpkt8mKMbM=;
        b=sf5Ngkd2miY1XKR7R8ZVsrts3v4DldCWGUaUJZBNDTldd6Fs+Vvc+uGDkOSmgSWRM2Mq4t
        dKuA6EZOG1my8jDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F58713A98;
        Mon, 10 Jan 2022 10:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XujDuMO3GFkWgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:48:03 +0000
Date:   Mon, 10 Jan 2022 11:48:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for v5.17
Message-ID: <YdwO50sY81Qjr/H7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a relatively lively (in comparison to other tip branches)
x86/sgx development branch for 5.17.

Thx.

---

The following changes since commit ac5d272a0ad0419f52e08c91953356e32b075af7:

  x86/sgx: Fix free page accounting (2021-11-16 11:17:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.17_rc1

for you to fetch changes up to 2056e2989bf47ad7274ecc5e9dda2add53c112f9:

  x86/sgx: Fix NULL pointer dereference on non-SGX systems (2022-01-07 08:47:23 -0800)

----------------------------------------------------------------
- Add support for handling hw errors in SGX pages: poisoning, recovering
from poison memory and error injection into SGX pages

- A bunch of changes to the SGX selftests to simplify and allow of SGX
features testing without the need of a whole SGX software stack

- Add a sysfs attribute which is supposed to show the amount of SGX
memory in a NUMA node, similar to what /proc/meminfo is to normal
memory

- The usual bunch of fixes and cleanups too

----------------------------------------------------------------
Dave Hansen (1):
      x86/sgx: Fix NULL pointer dereference on non-SGX systems

Ingo Molnar (1):
      Merge branch 'x86/urgent' into x86/sgx, to resolve conflict

Jarkko Sakkinen (10):
      selftests/sgx: Assign source for each segment
      selftests/sgx: Make data measurement for an enclave segment optional
      selftests/sgx: Create a heap for the test enclave
      selftests/sgx: Dump segments and /proc/self/maps only on failure
      selftests/sgx: Encpsulate the test enclave creation
      selftests/sgx: Move setup_test_encl() to each TEST_F()
      selftests/sgx: Add a new kselftest: Unclobbered_vdso_oversubscribed
      selftests/sgx: Provide per-op parameter structs for the test enclave
      x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node
      selftests/sgx: Fix corrupted cpuid macro invocation

Reinette Chatre (5):
      selftests/sgx: Rename test properties in preparation for more enclave tests
      selftests/sgx: Add page permission and exception test
      selftests/sgx: Enable multiple thread support
      selftests/sgx: Add test for multiple TCS entry
      x86/sgx: Fix minor documentation issues

Sean Christopherson (1):
      selftests/sgx: Fix a benign linker warning

Tony Luck (7):
      x86/sgx: Add new sgx_epc_page flag bit to mark free pages
      x86/sgx: Add infrastructure to identify SGX EPC pages
      x86/sgx: Initial poison handling for dirty and free pages
      x86/sgx: Add SGX infrastructure to recover from poison
      x86/sgx: Hook arch_memory_failure() into mainline code
      x86/sgx: Add hook to error injection address validation
      x86/sgx: Add check for SGX pages to ghes_do_memory_failure()

 Documentation/ABI/stable/sysfs-devices-node       |   6 +
 Documentation/firmware-guide/acpi/apei/einj.rst   |  19 ++
 Documentation/x86/sgx.rst                         |  14 +-
 arch/Kconfig                                      |   4 +
 arch/x86/Kconfig                                  |   2 +
 arch/x86/include/asm/processor.h                  |   8 +
 arch/x86/include/asm/set_memory.h                 |   4 +
 arch/x86/kernel/cpu/sgx/main.c                    | 162 +++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h                     |   8 +-
 drivers/acpi/apei/einj.c                          |   3 +-
 drivers/acpi/apei/ghes.c                          |   2 +-
 drivers/base/node.c                               |   3 +
 include/linux/mm.h                                |  13 +
 include/linux/numa.h                              |   4 +
 mm/memory-failure.c                               |  19 +-
 tools/testing/selftests/sgx/Makefile              |   2 +-
 tools/testing/selftests/sgx/defines.h             |  33 +-
 tools/testing/selftests/sgx/load.c                |  40 ++-
 tools/testing/selftests/sgx/main.c                | 356 +++++++++++++++++++---
 tools/testing/selftests/sgx/main.h                |   6 +-
 tools/testing/selftests/sgx/sigstruct.c           |  12 +-
 tools/testing/selftests/sgx/test_encl.c           |  60 +++-
 tools/testing/selftests/sgx/test_encl_bootstrap.S |  21 +-
 23 files changed, 698 insertions(+), 103 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
