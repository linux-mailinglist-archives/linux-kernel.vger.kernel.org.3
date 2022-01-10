Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC048963F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiAJKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:22:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiAJKWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:22:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88D171F395;
        Mon, 10 Jan 2022 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641810171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zMv3xqVerfhA9GCi94XW3otM0bLE+4IMKxrSjv9VEk0=;
        b=Qedm/NHtv3mR7ZK8/TrbzqVq5Ra/lbQoWUQgDRduvUsjY4FRqIp+dGpUn/dQx6NKIYCpfJ
        Wap2MUHBB4jZPoPGSCV6GaLQLoekIMYtoIPXKkAkXfYRkqBfuVAUxjWRpr4yuQvsGlIZUE
        V5JwZFfYEVHzcb2A+oSmW0ev/OtHgjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641810171;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zMv3xqVerfhA9GCi94XW3otM0bLE+4IMKxrSjv9VEk0=;
        b=ODLGeIdKubK00A1lTxxIkkhmkQDfJv9iqOAhwqhd9TXmfB4xE9DcHQdsF4iXEFTBxtCYd8
        7Ha18DU4A5vfVjAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 730B813CCB;
        Mon, 10 Jan 2022 10:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P4ScGvsI3GGuTAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 10:22:51 +0000
Date:   Mon, 10 Jan 2022 11:22:59 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/platform for v5.17
Message-ID: <YdwJAzTiMSIaGjsC@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86/platform fix for 5.17.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_platform_for_v5.17_rc1

for you to fetch changes up to 9e4d52a00a0217857fa40dc998971a375f861a61:

  x86/ce4100: Replace "ti,pcf8575" by "nxp,pcf8575" (2021-12-03 18:23:57 +0100)

----------------------------------------------------------------
- A DT compatibility fix for the Intel media processor CE4100 driver

----------------------------------------------------------------
Geert Uytterhoeven (1):
      x86/ce4100: Replace "ti,pcf8575" by "nxp,pcf8575"

 arch/x86/platform/ce4100/falconfalls.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
