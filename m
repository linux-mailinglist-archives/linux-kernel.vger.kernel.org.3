Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7758900A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbiHCQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiHCQNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:13:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0532DAA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:13:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FBE93FB30;
        Wed,  3 Aug 2022 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659543209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JfQwF4E7OboR29C8Isxq3UTgiJebTWsqig0GU3KaiGI=;
        b=Cw3HYPSYQIc1yFmx/vH7yzfG4Gr0wYT49nrb4jw0ehEcXHUsyO1TTElIdinWunD0Hn0a4W
        X/K4JxdvBunhZ7LyyCP4Kh/7Pu50MpF0M/XjHimpQ9DvAdnj6fJO/TSvAkFfofvY87wXtS
        uSI87KkF/6aV85kU5yEGm5JoDyGXYjY=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 928CC2C141;
        Wed,  3 Aug 2022 16:13:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5E50EDA85A; Wed,  3 Aug 2022 18:08:28 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS fix for 5.20
Date:   Wed,  3 Aug 2022 18:08:26 +0200
Message-Id: <cover.1659542557.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

one update to AFFS, switching the kmap/kmap_atomic API. Please pull,
thanks.

----------------------------------------------------------------
The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-5.20-tag

for you to fetch changes up to 5abbb7b92820cf6ba9154a35cff6d64b62d7f273:

  affs: use memcpy_to_page and remove replace kmap_atomic() (2022-08-01 19:53:31 +0200)

----------------------------------------------------------------
David Sterba (1):
      affs: use memcpy_to_page and remove replace kmap_atomic()

 fs/affs/file.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
