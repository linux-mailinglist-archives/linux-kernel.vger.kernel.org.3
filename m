Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCF531CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiEWTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiEWTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:32:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406DABF78
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:16:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAA3E1F747;
        Mon, 23 May 2022 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653333384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Go5nZzNXHmKF4R7s+PkX6pCw7htskuScNkZKhciSpNE=;
        b=muz1sonuVvEvBeiI6PSi0friQ6+E/JQ3JFanxLzulgRViz5ALQPMsTo9YjqnYe+JvAj/HX
        hHYnnZmWYeckIhuAdbMtFwcYcBwmiCXsYhReN8WgdY3WT5m1rJrSoi3GoTyRED5kj//mNQ
        DlV9I8E03se32nv7iYg7IUWvVXAXAxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653333384;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Go5nZzNXHmKF4R7s+PkX6pCw7htskuScNkZKhciSpNE=;
        b=WfHJFgcZbytEA0XJC2onqEM+faiRWTacY9l0I+8loq+YUXEOJkU7yhFaGLS6JUy71STckl
        vlzAUJ+6v5vyX5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDE2513AA5;
        Mon, 23 May 2022 19:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JpE6Mojdi2KocAAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 19:16:24 +0000
Date:   Mon, 23 May 2022 21:16:20 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/apic for 5.19
Message-ID: <YovdhH0QBN7csz/b@zn.tnic>
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

two fixes in x86/apic for 5.19, this time around.

Please pull,
thx.

---

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_v5.19_rc1

for you to fetch changes up to 7a116a2dd32d96869f0f93bac00b900859ba0434:

  x86/apic: Do apic driver probe for "nosmp" use case (2022-05-01 22:40:29 +0200)

----------------------------------------------------------------
- Always do default APIC routing setup so that cpumasks are properly
allocated and are present when later accessed ("nosmp" and x2APIC)

- Clarify the bit overlap between an old APIC and a modern, integrated one

----------------------------------------------------------------
Kuppuswamy Sathyanarayanan (1):
      x86/apic: Do apic driver probe for "nosmp" use case

Thomas Gleixner (1):
      x86/apic: Clarify i82489DX bit overlap in APIC_LVT0

 arch/x86/include/asm/apicdef.h |  6 ------
 arch/x86/kernel/apic/apic.c    | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
