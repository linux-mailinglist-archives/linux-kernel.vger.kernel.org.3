Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19CF570E39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 01:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiGKXY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGKXY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:24:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF9D7AC2D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 16:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5674E6147C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E7EC34115;
        Mon, 11 Jul 2022 23:24:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d3aWGlkY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657581892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NmYicdfsseYgls9XyLsN6eO4Eqo0Fw/zWhZFBkI25sg=;
        b=d3aWGlkYcAHifE8hBoclTSQxZA272pbu34TXoopVXe4EPC7eEnWTEMGHCUNht1vyf/F6tG
        7NSub/jwscV5rb3FSC/qzDYmtJuBHl6JqkNHimrg1uLXhuoWWlv+ceuSDLx6cdDiCrlm88
        tyHBH9BES32/MN9LPA02RDb5T9bLzBg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9e003974 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Jul 2022 23:24:52 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sachinp@linux.ibm.com, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v5 0/2] powerpc rng cleanups
Date:   Tue, 12 Jul 2022 01:24:46 +0200
Message-Id: <20220711232448.136765-1-Jason@zx2c4.com>
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

These are two small cleanups for -next. This v5 rebases on the latest
git master, as some whitespace was added that made v4 no longer apply.

Jason A. Donenfeld (2):
  powerpc/powernv: rename remaining rng powernv_ functions to pnv_
  powerpc/kvm: don't crash on missing rng, and use darn

 arch/powerpc/include/asm/archrandom.h |  7 +--
 arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
 arch/powerpc/platforms/powernv/rng.c  | 66 ++++++++++-----------------
 drivers/char/hw_random/powernv-rng.c  |  2 +-
 4 files changed, 30 insertions(+), 52 deletions(-)

-- 
2.35.1

