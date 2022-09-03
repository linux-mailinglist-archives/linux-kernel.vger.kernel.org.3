Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6755ABF6D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 16:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiICOyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 10:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiICOyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 10:54:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1EEB7D2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 07:54:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7B3D34C2C;
        Sat,  3 Sep 2022 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662216868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CJfyMJFEqY/Rw/Ebm+V1xYgPDk5ZiuDtFBgSCD431IE=;
        b=KHwL4zNuFAmaKbIR2Y5apZfyfeGzXIFIjyttYMjgv7LGAAMidfWFffpPRNbXE4prRuyKR4
        0fbhNVRfPd10vBHYeCCHkoF0iWRFE05iUzYB4Q/GE/LevHeQbZJjEX7d4gklgJLSBs4eDL
        XaFZLosKG96wZMvDzqHfJIoxfM/OEFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84A8013517;
        Sat,  3 Sep 2022 14:54:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NmM2H6RqE2PWVQAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 03 Sep 2022 14:54:28 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: branch for v6.0-rc4
Date:   Sat,  3 Sep 2022 16:54:28 +0200
Message-Id: <20220903145428.29553-1-jgross@suse.com>
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

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc4-tag

xen: branch for v6.0-rc4

It contains:

- a minor fix for the Xen grant driver

- a small series fixing a recently introduced problem in the Xen
  blkfront/blkback drivers with negotiation of feature usage


Thanks.

Juergen

 drivers/block/xen-blkback/common.h |  3 +++
 drivers/block/xen-blkback/xenbus.c |  6 ++++--
 drivers/block/xen-blkfront.c       | 20 ++++++++++++--------
 drivers/xen/grant-table.c          |  3 +++
 4 files changed, 22 insertions(+), 10 deletions(-)

Dan Carpenter (1):
      xen/grants: prevent integer overflow in gnttab_dma_alloc_pages()

SeongJae Park (3):
      xen-blkback: Advertise feature-persistent as user requested
      xen-blkfront: Advertise feature-persistent as user requested
      xen-blkfront: Cache feature_persistent value before advertisement
