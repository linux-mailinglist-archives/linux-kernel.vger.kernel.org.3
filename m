Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C70847A0B5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 14:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhLSNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 08:40:12 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51480 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhLSNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 08:40:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A9357218ED;
        Sun, 19 Dec 2021 13:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639921209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9aSsP0RCai00ICYAFj3y5E2iYTuC6RB6ZVhj4Emlos=;
        b=HI9MiF10tKifzkxzFt9MUq8NylmL3OjAUpzR64TesKi9EyDanuKIkR2+VBxXJUsKXm6AK/
        wOXoK0lvIa7pCMkmeN2MkvAlmEoCM8NMels2scr/gfRrPI7+CikcUflGMhTghfo1MvxqGx
        y/UE/+9I/+NCETZCEFow1ApAsznekLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639921209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A9aSsP0RCai00ICYAFj3y5E2iYTuC6RB6ZVhj4Emlos=;
        b=BYnSDQcG9/XnuZMoAuREQGQtZ/+jmiO0MqAOJJf194jPOKin7p0pz4XqDNlFMPZNXu6R9+
        uyUYmMxBbMvsoYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D0D51377F;
        Sun, 19 Dec 2021 13:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y00HIjk2v2HTQAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Dec 2021 13:40:09 +0000
Date:   Sun, 19 Dec 2021 14:40:11 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] core/urgent for v5.16-rc6
Message-ID: <Yb82O5i2DVcK9nAJ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single core/urgent fix for 5.16.

Thx.

---

The following changes since commit cabdc3a8475b918e55744f43719b26a82dc8fa6b:

  sched,x86: Don't use cluster topology for x86 hybrid CPUs (2021-12-08 22:15:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_urgent_for_v5.16_rc6

for you to fetch changes up to 6c3118c32129b4197999a8928ba776bcabd0f5c4:

  signal: Skip the altstack update when not needed (2021-12-14 13:08:36 -0800)

----------------------------------------------------------------
- Prevent lock contention on the new sigaltstack lock on the common-case
path, when no changes have been made to the alternative signal stack.

----------------------------------------------------------------
Chang S. Bae (1):
      signal: Skip the altstack update when not needed

 kernel/signal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
