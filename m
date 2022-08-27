Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9773C5A35DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbiH0Iat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiH0Iar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 04:30:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B269BB5E
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 01:30:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BA1E61FA82;
        Sat, 27 Aug 2022 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661589044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QFtJgi7SuZq8TP8XBsbv6JKb1wtY2N+Odb/y/cSybqg=;
        b=mUlKFSVIs4zmpbiR8nLXQSrIJVYUfgdHXWLxI8YOILZ3FHacm95z4rtxzMBf3+4M/r8nc+
        JWKkkTBls+8xHF1fOC5IdJUKlurBA+jvxvQ8WEkxXMwuT9koK3zPOFAF8GqdBFJNB42rrI
        IZLpiUZdd9EcK40/RUZgHn2zDTX2Mq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F2FF1341F;
        Sat, 27 Aug 2022 08:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TEqAITTWCWN+CgAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 27 Aug 2022 08:30:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.0-rc3
Date:   Sat, 27 Aug 2022 10:30:44 +0200
Message-Id: <20220827083044.5631-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
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

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc3-tag

xen: branch for v6.0-rc3

It contains the following patches:

- 2 minor cleanups

- a fix of the xen/privcmd driver avoiding a possible NULL dereference
  in an error case


Thanks.

Juergen

 arch/x86/configs/xen.config                |  1 -
 drivers/xen/privcmd.c                      | 21 +++++++++++----------
 drivers/xen/xen-scsiback.c                 |  2 +-
 drivers/xen/xenbus/xenbus_probe_frontend.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

Juergen Gross (1):
      xen/privcmd: fix error exit of privcmd_ioctl_dm_op()

Lukas Bulwahn (1):
      xen: x86: remove setting the obsolete config XEN_MAX_DOMAIN_MEMORY

Wolfram Sang (1):
      xen: move from strlcpy with unused retval to strscpy
