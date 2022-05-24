Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CB65331D5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240962AbiEXTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239067AbiEXTlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:41:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AB0049F2A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653421311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpWaat9buR/Fif/C0TdvorPSW4jwB7itL0WsZiKv6+A=;
        b=OdEEWr8bfArkReMvZ/LaOijYrPg0BfwLebM/TqY2lvdRIF4xi6dgT3w3XS0ocmmSqoKRdJ
        e9y8wHgNbyS5pFqYBiLVn/wKOH94ai6hNYxyYTtjovHexT87ae3qqCfex/UY/Ck/Sl8rIV
        KqJuvEZaFf9ITtfXIJjKTX3eLsWHm9s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-nd1k_FPOP4S-tvzqjo9TKA-1; Tue, 24 May 2022 15:41:47 -0400
X-MC-Unique: nd1k_FPOP4S-tvzqjo9TKA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 428C1100FB88;
        Tue, 24 May 2022 19:41:47 +0000 (UTC)
Received: from max.localdomain (unknown [10.40.195.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B95A7AD8;
        Tue, 24 May 2022 19:41:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] gfs2 fixes
Date:   Tue, 24 May 2022 21:41:45 +0200
Message-Id: <20220524194145.884805-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please consider pulling the following gfs2 fixes for 5.19.

Thank you very much,
Andreas

The following changes since commit d928e8f3af38abc8d2d56d9329a8280f7af5f10e:

  Merge tag 'gfs2-v5.18-rc4-fix3' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2022-05-13 14:32:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.18-rc6-fixes

for you to fetch changes up to c360abbb9db298d0548b31e1a86a48ebb157d7cd:

  gfs2: Convert function bh_get to use iomap (2022-05-24 21:29:14 +0200)

----------------------------------------------------------------
gfs2 fixes

- Clean up the allocation of glocks that have an address space attached.
- Quota locking fix and quota iomap conversion.
- Fix the FITRIM error reporting.
- Some list iterator cleanups.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Explain some direct I/O oddities

Andrew Price (1):
      gfs2: Return more useful errors from gfs2_rgrp_send_discards()

Bob Peterson (2):
      gfs2: use i_lock spin_lock for inode qadata
      gfs2: Convert function bh_get to use iomap

Jakob Koschel (1):
      gfs2: replace 'found' with dedicated list iterator variable

Kees Cook (1):
      gfs2: Use container_of() for gfs2_glock(aspace)

 fs/gfs2/file.c     |  4 ++++
 fs/gfs2/glock.c    | 35 ++++++++++++++++--------------
 fs/gfs2/glock.h    | 12 +++++++++--
 fs/gfs2/main.c     | 10 ++++-----
 fs/gfs2/meta_io.h  |  8 ++++---
 fs/gfs2/quota.c    | 62 ++++++++++++++++++++++++++++++++----------------------
 fs/gfs2/recovery.c | 22 +++++++++----------
 fs/gfs2/rgrp.c     |  4 ++--
 8 files changed, 91 insertions(+), 66 deletions(-)

