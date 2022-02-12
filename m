Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149684B3431
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 11:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiBLKZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 05:25:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiBLKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 05:25:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05F2611C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 02:25:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7BA01F3AB;
        Sat, 12 Feb 2022 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644661509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5yXRQYPz7tyCPh12Y6Rub4FEyQM5xqaM15UqmQ0cHI0=;
        b=hK0dVY9gMUYw5lm60eoc/yhhP8D82RZIj0sUbLJvcZM0BVyEIomMKz9HLqR75ORkZnMjZg
        Z/p4dfWEuxqFeT/MkfK1Z+PNmpLkaRgZmBCd2chTSVshmMJXI8vQJMzlcFvzoWtpQoWfPI
        wfeX/xpC7jJcU4NB/IOcjxqsqWhY7mQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99727133A6;
        Sat, 12 Feb 2022 10:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VLYyJAWLB2IUJwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 12 Feb 2022 10:25:09 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.17-rc4
Date:   Sat, 12 Feb 2022 11:25:09 +0100
Message-Id: <20220212102509.24629-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.17a-rc4-tag

xen: branch for v5.17-rc4

It contains the following patches:

- 2 small cleanups

- Another fix for addressing the EFI framebuffer above 4GB when running
  as Xen dom0

- A patch for letting Xen guests use reserved bits in MSI- and IO-APIC-
  registers for extended APIC-IDs the same way KVM guests are doing it
  already.

Thanks.

Juergen

 arch/x86/include/asm/xen/cpuid.h |  7 +++++++
 arch/x86/xen/enlighten_hvm.c     |  9 +++++++--
 arch/x86/xen/vga.c               | 16 ++++++++--------
 drivers/xen/pci.c                |  2 +-
 4 files changed, 23 insertions(+), 11 deletions(-)

Cai Huoqing (1):
      xen/pci: Make use of the helper macro LIST_HEAD()

Jan Beulich (1):
      xen/x86: obtain full video frame buffer address for Dom0 also under EFI

Jiapeng Chong (1):
      xen/x2apic: Fix inconsistent indenting

Roger Pau Monne (1):
      xen/x86: detect support for extended destination ID
