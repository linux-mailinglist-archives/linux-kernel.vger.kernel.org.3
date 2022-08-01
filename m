Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A2586809
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiHALWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiHALWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:22:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5C2ED66
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:22:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 49E744DB4B;
        Mon,  1 Aug 2022 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659352956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/l6a860jXi02OmWDmag4BykBREMwF/VBzivNExpBTvE=;
        b=GUkGRikbno+YM/fWEt5EMLBWcvVaHqFVJPWf6CoAI3tPg6xGLmqBsQ5+Z6CDuIaUFjdtOy
        uaPIoqKdkQYGGM5yWH+dBR9WKuJfSP6DPwZiqBypTJ9pC3YZZBhjdyDqdS5urLTzb3RZh1
        UYJq2DJ8ekiMGqGcsGwbRNVyXUUDzAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659352956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/l6a860jXi02OmWDmag4BykBREMwF/VBzivNExpBTvE=;
        b=22UChz7IROxBUe7hO5/WmAGNc5pIWoZVuPhAtlCo/uttiFmKvTlUhTSnM0pcGPTVzwNinS
        pMNSu4H4B3iC72Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E46413A72;
        Mon,  1 Aug 2022 11:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HXooD3y352JZfgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 11:22:36 +0000
Date:   Mon, 1 Aug 2022 13:22:35 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.0
Message-ID: <Yue3e/D/045z5X4Q@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of x86/cpu changes for 6.0.

Thx.

---

The following changes since commit 2147c438fde135d6c145a96e373d9348e7076f7f:

  x86/speculation: Add missing prototype for unpriv_ebpf_notify() (2022-04-28 11:12:17 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.0_rc1

for you to fetch changes up to 3f2adf00f52b5f2e9e9f23bb5c77608fc9ee297c:

  x86/cpu: Use MSR_IA32_MISC_ENABLE constants (2022-07-19 20:53:10 +0200)

----------------------------------------------------------------
- Remove the vendor check when selecting MWAIT as the default idle state

- Respect idle=nomwait when supplied on the kernel cmdline

- Two small cleanups

----------------------------------------------------------------
Paolo Bonzini (1):
      x86/cpu: Use MSR_IA32_MISC_ENABLE constants

Wyes Karny (3):
      x86: Handle idle=nomwait cmdline properly for x86_idle
      x86: Remove vendor checks from prefer_mwait_c1_over_halt
      x86: Fix comment for X86_FEATURE_ZEN

 Documentation/admin-guide/pm/cpuidle.rst | 15 ++++++-----
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/include/asm/mwait.h             |  1 +
 arch/x86/kernel/cpu/intel.c              |  4 +--
 arch/x86/kernel/process.c                | 44 ++++++++++++++++++++++----------
 5 files changed, 44 insertions(+), 22 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
