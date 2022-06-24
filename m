Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F1559B74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiFXOXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiFXOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:23:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A59A3E0F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:23:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AD3D61FEC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0459BC34114;
        Fri, 24 Jun 2022 14:23:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="odhF0LyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656080611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DDHqAmqsZ4bloLWJ5SSgC0PVJ41EyjROF8QxHskmM0g=;
        b=odhF0LyJPkU94nBENBOG8XASoqmfAfDlY7Ad5w1YoA4Uea+cLNHo7dVlY9YILvLUzi3kXc
        LYssvyQbaIxMw7mCRLWYbHXMc9GqYOXAxp6oItn3aq425b/2TkENK/HUVa+BQru7/G95Ut
        6KCt5J59Fs/qbRr7Oq4wTdsa99goVdo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c97580c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 14:23:31 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 0/2] powerpc rng cleanups
Date:   Fri, 24 Jun 2022 16:23:20 +0200
Message-Id: <20220624142322.2049826-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are two small cleanups for -next.

Jason A. Donenfeld (2):
  powerpc/powernv: rename remaining rng powernv_ functions to pnv_
  powerpc/kvm: don't crash on missing rng, and use darn

 arch/powerpc/include/asm/archrandom.h |  7 +--
 arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
 arch/powerpc/platforms/powernv/rng.c  | 63 ++++++++++-----------------
 drivers/char/hw_random/powernv-rng.c  |  2 +-
 4 files changed, 29 insertions(+), 50 deletions(-)

-- 
2.35.1

