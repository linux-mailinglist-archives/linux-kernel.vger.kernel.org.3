Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1F489789
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244796AbiAJLc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:32:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbiAJLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:32:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 92B891F39D;
        Mon, 10 Jan 2022 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641814343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5yczoqJ4BQg2WL0fyAH+pYH9xmK8XAHtm1nKm+BOQPg=;
        b=hfDPkNvQadiYfysoJqbMBBilYpiPfZ+TNVx5ycRY9qL5zvqrpr8fw8UqsBEI4ZdcS7WeYZ
        oIXTHrrDH0ssgW7u4HDj5fRNWHPes6JqvGQqbp/6fiuOC4Rt00E3p0AahKWG42AM19kmh+
        Z9Xsk1d1tU2vUAOqDZl5gBQayZvCnrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641814343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5yczoqJ4BQg2WL0fyAH+pYH9xmK8XAHtm1nKm+BOQPg=;
        b=ixrDC86H4UxFyog5/mx/RsSXkmRVtJXUw/lNYrJAXOZvuoeOrtW0snePz5XjHI/TSDKHvy
        LaZBGiaiGhFJz2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BF07139ED;
        Mon, 10 Jan 2022 11:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sN/PHEcZ3GFvdAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:32:23 +0000
Date:   Mon, 10 Jan 2022 12:32:26 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/vdso for v5.17
Message-ID: <YdwZStOiA4hwQsLg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/vdso build fixes for 5.17.

Thx.

---

The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_vdso_for_v5.17_rc1

for you to fetch changes up to 9102fa34604159642625f42d7f801f1e04d9ca12:

  x86/purgatory: Remove -nostdlib compiler flag (2021-12-30 14:13:06 +0100)

----------------------------------------------------------------
- Remove -nostdlib compiler flag now that the vDSO uses the linker
instead of the compiler driver to link files

----------------------------------------------------------------
Masahiro Yamada (2):
      x86/vdso: Remove -nostdlib compiler flag
      x86/purgatory: Remove -nostdlib compiler flag

 arch/x86/entry/vdso/Makefile | 2 +-
 arch/x86/purgatory/Makefile  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
