Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC6553D5AE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 07:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348790AbiFDF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiFDF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 01:56:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669F4DF7F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 22:56:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 307C61F8DE;
        Sat,  4 Jun 2022 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654322169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=vspAA2gcSD1QkHhRhCOdcZ08ie07v+Yx0GVIhaTtDrI=;
        b=JWiouut0d2cp7hKK+zKFICpWUjpYRhU6Qx3HWCZb43yVunl4EfZZAHMW93i6Jeld75JC2F
        tDt1p7M6eQKEb7BJdquXb5ebIBSrtSBj6jzTnT9GvSr+OCIMbY5hsgcfkx1g4pe/IMKgH9
        t8oHvYA39STnitYCOzrj+QL6mLfzwtE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0790813A5F;
        Sat,  4 Jun 2022 05:56:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 035nAPnzmmKgLwAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 04 Jun 2022 05:56:09 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v5.19-rc1b
Date:   Sat,  4 Jun 2022 07:56:08 +0200
Message-Id: <20220604055608.9037-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.19-rc1b-tag

xen: 2nd batch for v5.19-rc1

It contains 2 cleanup patches for Xen related code and (more important)
an update of MAINTAINERS for Xen, as Boris Ostrovsky decided to step
down.

Thanks.

Juergen

 MAINTAINERS                         | 18 ++++++++++++------
 arch/x86/include/asm/xen/page.h     |  3 ---
 drivers/block/xen-blkfront.c        |  6 +++---
 drivers/input/misc/xen-kbdfront.c   |  4 ++--
 drivers/net/xen-netfront.c          |  7 +++----
 drivers/tty/hvc/hvc_xen.c           |  2 +-
 drivers/xen/gntalloc.c              |  9 +++------
 drivers/xen/gntdev-dmabuf.c         |  2 +-
 drivers/xen/grant-table.c           | 14 +++++++-------
 drivers/xen/pvcalls-front.c         |  6 +++---
 drivers/xen/xen-front-pgdir-shbuf.c |  2 +-
 drivers/xen/xenbus/xenbus_client.c  |  2 +-
 drivers/xen/xenbus/xenbus_probe.c   |  8 ++++----
 include/xen/arm/page.h              |  3 ---
 include/xen/grant_table.h           |  6 +++---
 net/9p/trans_xen.c                  |  8 ++++----
 16 files changed, 48 insertions(+), 52 deletions(-)

Boris Ostrovsky (1):
      MAINTAINERS: Update Xen maintainership

Juergen Gross (2):
      xen: switch gnttab_end_foreign_access() to take a struct page pointer
      xen: replace xen_remap() with memremap()
