Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803A94E2473
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346395AbiCUKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbiCUKhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:37:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5A01168F2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 03:35:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE6E9210DE;
        Mon, 21 Mar 2022 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647858946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7+XMEOhK3D+awit/ithHqo4rIsrR8qyi2fhlkuLgcwE=;
        b=UVvJscs4pyOSW9tJW++VrjBGii+bbTdhQPXgEiUb5lf2yAJGaLzSYVDK4lcEOcOtM+77uB
        yeca16WWAZEmtmGuNb5sosQKunChqWcWVgyDx+yIWsqKjSrS/P7JPDAW1gNtHRH/rD8+yf
        TTPbQe6JSzxf2XvHF/Fi1lbLXgc60ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647858946;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7+XMEOhK3D+awit/ithHqo4rIsrR8qyi2fhlkuLgcwE=;
        b=wrb7X8w0bZUdi68lMyOtbon1cRKpL1UvFsHzTzx19RRmiObQL3TbnnV8cNYWU4Yflasndw
        E+5iOjOIHaJnU+Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2DDF13AD5;
        Mon, 21 Mar 2022 10:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VCGQMwJVOGLxfgAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 21 Mar 2022 10:35:46 +0000
Date:   Mon, 21 Mar 2022 11:35:47 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/paravirt for 5.18
Message-ID: <YjhVA/LtQ4qFZuKd@zn.tnic>
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

please pull a single x86/paravirt improvement for 5.18.

Thx.

---

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_paravirt_for_v5.18_rc1

for you to fetch changes up to 2e1f8e55f9e054b4a49ffc06c7e33b5d4725f05e:

  x86/paravirt: Use %rip-relative addressing in hook calls (2022-01-24 20:21:19 +0100)

----------------------------------------------------------------
- Shorten CALL insns to pvops by a byte by using rip-relative addressing

----------------------------------------------------------------
Jan Beulich (1):
      x86/paravirt: Use %rip-relative addressing in hook calls

 arch/x86/include/asm/paravirt_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
