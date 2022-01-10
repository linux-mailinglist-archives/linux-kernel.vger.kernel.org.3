Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85B248973B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiAJLUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:20:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244617AbiAJLT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:19:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31607210F8;
        Mon, 10 Jan 2022 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641813597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GRbX85PkaWdijkdNXZXuaLkD9bKKSzcrXv8mpwNzSHA=;
        b=ww/P3QBZR95J8sF4vK7yfLOOgGzwgKxTAssGXVwddI8sAaVPzt+YCXs/0i82WHstqTumYH
        09PfI/REP3jHs86pseHryW3dJNqXuyR86bd2TYdfp1pny1NnH9vV6fmNHD9wKOH80fHvLx
        /7oNnXBHsx2VzP7EoZlwjACrlnamgb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641813597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GRbX85PkaWdijkdNXZXuaLkD9bKKSzcrXv8mpwNzSHA=;
        b=i/m07hGf6r1Hn2egk16bn2ilR3WuaQM3afZhxmr6zW6PPVQSxyuRw93/ftN+hq9iU2uIdT
        euz/Wc+vbtqw9TDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A23E13D2A;
        Mon, 10 Jan 2022 11:19:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D8I9BV0W3GE+bQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:19:57 +0000
Date:   Mon, 10 Jan 2022 12:20:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.17
Message-ID: <YdwWZeajNhOasI3U@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/build update for 5.17.

Thx.

---

The following changes since commit a7904a538933c525096ca2ccde1e60d0ee62c08e:

  Linux 5.16-rc6 (2021-12-19 14:14:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.17_rc1

for you to fetch changes up to 5fe392ff9d1f7254a1fbb3f72d9893088e4d23eb:

  x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS (2021-12-23 11:03:28 +0100)

----------------------------------------------------------------
- A fix for cross-compiling the compressed stub on arm64 with clang

----------------------------------------------------------------
Nathan Chancellor (1):
      x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS

 arch/x86/boot/compressed/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
