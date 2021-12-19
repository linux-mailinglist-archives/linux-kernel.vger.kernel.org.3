Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0147A0B6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhLSNqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:46:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51784 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhLSNqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:46:02 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C1A4C21106;
        Sun, 19 Dec 2021 13:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639921561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=toP9P6aZ9YwuOwK6IKoZ1MYwlBYbk7xa712aGF3pH4E=;
        b=Ixn9hPACLnUMk6YW7O2qlAvVzhJK90NZGR7BocBtwGAuRSS0BYoFkfKLvUtd/YhaO/C0+O
        6pTM54VIuWU+EenveQnWnaFDBciupeDelWsNLbViv+zIGvMjuZMv4nNuvSJL6pKbwtNq0Z
        Mv4RP+q92d26Drx6o6TWwcwBpS1ZBKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639921561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=toP9P6aZ9YwuOwK6IKoZ1MYwlBYbk7xa712aGF3pH4E=;
        b=yA5LoG62MQiWU9QS+5polhtANthkfgCk3ST0XOcJiQgvqyR9kBf45iI2nodzis2pl9nd+s
        Nr75kI7uefnGIfAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6B391377F;
        Sun, 19 Dec 2021 13:46:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MIJPKJk3v2F0QgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Dec 2021 13:46:01 +0000
Date:   Sun, 19 Dec 2021 14:46:08 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.16-rc6
Message-ID: <Yb83oF7xlfqqblGt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent locking fix for 5.16.

Thx.

---

The following changes since commit 2585cf9dfaaddf00b069673f27bb3f8530e2039c:

  Linux 5.16-rc5 (2021-12-12 14:53:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.16_rc6

for you to fetch changes up to 8f556a326c93213927e683fc32bbf5be1b62540a:

  locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner() (2021-12-18 10:55:51 +0100)

----------------------------------------------------------------
- Fix the condition checking when the optimistic spinning of a waiter needs
to be terminated

----------------------------------------------------------------
Zqiang (1):
      locking/rtmutex: Fix incorrect condition in rtmutex_spin_on_owner()

 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
