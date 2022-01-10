Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0297C489715
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244500AbiAJLNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:13:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48026 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244492AbiAJLLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:11:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 05A88210F8;
        Mon, 10 Jan 2022 11:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641813107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4hu8CgqNM02zljMtb7Tbw3bK/hJ7PG9hJ7JbpxPc8N4=;
        b=PxTqYBtONbFTsL0OZMQDuqSAo9cs4b3jJkcmai09W6z5hDm3w9MTtfjXN+XVaynBSiN713
        pUOXieIfRiunWLAitvuEw0TaKd6sAUviY3INq0O2+R3RSDgA49UdzWRw/q2eF0/X3c26zg
        gwUyqLrMpSd3BzDVpB7iCfQmy+LEgaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641813107;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4hu8CgqNM02zljMtb7Tbw3bK/hJ7PG9hJ7JbpxPc8N4=;
        b=oVmfV7sJgDLt9+dPLh2NhnHv+x+0EO/uUo3Vah2iTy5ZozsWbQD5/EclwepT/EF7yYxq+5
        fiZ9ttv225Wg0RCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2AF713D2A;
        Mon, 10 Jan 2022 11:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VJDtNXIU3GE/aAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 11:11:46 +0000
Date:   Mon, 10 Jan 2022 12:11:54 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/core for v5.17
Message-ID: <YdwUehYpPIp/0Zdd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single notifier facility fix for 5.17.

Thx.

---
The following changes since commit fc74e0a40e4f9fd0468e34045b0c45bba11dcbb2:

  Linux 5.16-rc7 (2021-12-26 13:17:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_core_for_v5.17_rc1

for you to fetch changes up to 5abb065dca7301de90b7c44bbcdc378e49e4d362:

  notifier: Return an error when a callback has already been registered (2021-12-29 10:37:33 +0100)

----------------------------------------------------------------
- Return an error when a notifier callback has been registered already

----------------------------------------------------------------
Borislav Petkov (1):
      notifier: Return an error when a callback has already been registered

 kernel/notifier.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
