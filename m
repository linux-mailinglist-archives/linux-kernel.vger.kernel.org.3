Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED54E2457
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbiCUKae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbiCUKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:30:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CEF4474D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:29:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 263EF210F1;
        Mon, 21 Mar 2022 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647858546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ohkl4+33jfi6Z1kPMz6Vyni3nhlviTdHbNAfPyGKmX0=;
        b=yX+OlS4Pc8XpW8wiD0OTbl3YxYBef6efZS9AXrBoiYncf0q847KHox5t5gOfDq7lC4s7Q9
        Vwzwq4+UODirRouMgVVQOGBNfQNwA8FU2NLxFq0rBiqIpSu1OTyLb1bD+60ooaqtAJQNXy
        MtbvzX9iPPWSINYwgtFtTROKrpTfJco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647858546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ohkl4+33jfi6Z1kPMz6Vyni3nhlviTdHbNAfPyGKmX0=;
        b=R9SAD1aAuMKtazt6Uzllz9LrtKcnJPpuPfEKYhfBOcfT9l9+YTrwgXWvR9eWu3S///iWLu
        YwgPg0IRxEU4zPAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19F3613AD5;
        Mon, 21 Mar 2022 10:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id o/VOBnJTOGIaewAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:29:06 +0000
Date:   Mon, 21 Mar 2022 11:29:02 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for 5.18
Message-ID: <YjhTbqc1CNwBpENY@zn.tnic>
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

please pull the small pile of miscellaneous x86 updates for 5.18.

Thx.

---

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.18_rc1

for you to fetch changes up to 686016f732420f88dd2e1d67cf4bb5dffdb93c82:

  MAINTAINERS: Mark VMware mailing list entries as email aliases (2022-03-15 17:46:15 +0100)

----------------------------------------------------------------
- Add support for a couple new insn sets to the insn decoder: AVX512-FP16,
AMX, other misc insns.

- Update VMware-specific MAINTAINERS entries

----------------------------------------------------------------
Adrian Hunter (6):
      perf/tests: Add AMX instructions to x86 instruction decoder test
      x86/insn: Add AMX instructions to the x86 instruction decoder
      perf/tests: Add misc instructions to the x86 instruction decoder test
      x86/insn: Add misc instructions to x86 instruction decoder
      perf/tests: Add AVX512-FP16 instructions to x86 instruction decoder test
      x86/insn: Add AVX512-FP16 instructions to the x86 instruction decoder

Srivatsa S. Bhat (VMware) (3):
      MAINTAINERS: Update maintainers for paravirt ops and VMware hypervisor interface
      MAINTAINERS: Add Zack as maintainer of vmmouse driver
      MAINTAINERS: Mark VMware mailing list entries as email aliases

 MAINTAINERS                                  |   31 +-
 arch/x86/include/asm/insn.h                  |    2 +-
 arch/x86/lib/x86-opcode-map.txt              |  111 +-
 tools/arch/x86/include/asm/insn.h            |    2 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  111 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  |  918 +++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 1426 ++++++++++++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 1189 +++++++++++++++++++++
 8 files changed, 3749 insertions(+), 41 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
