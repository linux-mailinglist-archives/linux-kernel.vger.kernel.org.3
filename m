Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE04E24BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbiCUK70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241272AbiCUK7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:59:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FA91EECA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:57:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93D501F387;
        Mon, 21 Mar 2022 10:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647860276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3hrTwRxaf8JhhT4Lj0BPM0yPh4nDTfLdo9IQlnytwMs=;
        b=qI8xvfI0+Bj8ST5Bnz+A1l34xDgr+puJ+c6+jGtW5KwqAV4FDdACLEeSf91NGL15Kl+zeC
        JsFMX76ujDivCLYku8XEQwCrS/bVuVcF20kAnWV3ouaT+LoewXAuNQx81BVyTHJQCuySf1
        IUOpgLGUYZHx9mMr1u9YD37l54SsAJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647860276;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3hrTwRxaf8JhhT4Lj0BPM0yPh4nDTfLdo9IQlnytwMs=;
        b=+gp1uLXyOCbyOm79bv/OPnuE0UlbnAfr0ke5Xd8ifsZ4SwFZ+M4vZXPVZtRTdCR0QtB3ej
        04TpWjKoefm3RPDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8752513AD5;
        Mon, 21 Mar 2022 10:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kvf8IDRaOGIzCwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:57:56 +0000
Date:   Mon, 21 Mar 2022 11:57:53 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sgx for 5.18
Message-ID: <YjhaMTdKv/728zQE@zn.tnic>
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

please pull a bunch of SGX selftests fixes for 5.18.

Thx.

---

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v5.18_rc1

for you to fetch changes up to 6170abb21e2380477080b25145da9747ad467d3d:

  selftests/sgx: Treat CC as one argument (2022-02-17 11:55:17 -0800)

----------------------------------------------------------------
- A couple of fixes and improvements to the SGX selftests

----------------------------------------------------------------
Muhammad Usama Anjum (2):
      selftests/x86: Add validity check and allow field splitting
      selftests/sgx: Treat CC as one argument

Reinette Chatre (4):
      selftests/sgx: Fix NULL-pointer-dereference upon early test failure
      selftests/sgx: Do not attempt enclave build without valid enclave
      selftests/sgx: Ensure enclave data available during debug print
      selftests/sgx: Remove extra newlines in test output

 tools/testing/selftests/sgx/Makefile    | 2 +-
 tools/testing/selftests/sgx/load.c      | 9 +++++----
 tools/testing/selftests/sgx/main.c      | 9 +++++----
 tools/testing/selftests/x86/check_cc.sh | 2 +-
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
