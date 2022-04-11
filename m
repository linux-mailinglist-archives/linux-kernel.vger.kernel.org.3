Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702164FBFD1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347616AbiDKPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242472AbiDKPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:08:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D3A26AC9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:06:02 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649689560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0SpnBUNYF7IdMykaPknEWXlhXxtB3Szs3zjTPH9JYdo=;
        b=PbAYyuPoBduMJ19YSTPzj9A2Gvz5vsQgcCKAWM6Qoxq+pR+NvhdrAmMJ3SYVjwuCFp7cuM
        7iS+grK0BeRrbzPES145R2S4pNPb3mIv8vDkH5jEAnsWvwB1gS2jIY6jkCFb14hiq1TFx0
        8mH3bNeoVPvov0ufXIVjq7wWcqiBv5qGl0O0JBJq6o7ibE/GVirsTdNHM3k1Am2xhyOokF
        /S8rbwLejiB3II9RRB+GKnUQ44a/QtjM3e9XP7aEZwg4MRdPiwiWD4lMLsaX6Ln0r6Fkit
        uotwOTRjjZZynh/PfcCbCMu/hk1DqUBugPqjG5WeCaS+Qywq0Ah7m9ZTdpuK0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649689560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0SpnBUNYF7IdMykaPknEWXlhXxtB3Szs3zjTPH9JYdo=;
        b=5/yKKDhzWh3KVs5E5CvoSqXM8e4bIzDIfkmR9Zp/g1VNZgrmU77N/vRPQjOwuQUKkolqql
        IOXi8pi+Ee3WLvDQ==
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] include/linux/find: Fix documentation
Date:   Mon, 11 Apr 2022 17:05:55 +0200
Message-Id: <20220411150555.26023-1-anna-maria@linutronix.de>
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

The order of the arguments in function documentation doesn't fit the
implementation. Change the documentation so that it corresponds to the
code. This prevent people to get confused when reading the documentation.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 include/linux/find.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5bb6db213bcb..424ef67d4a42 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -21,8 +21,8 @@ extern unsigned long _find_last_bit(const unsigned long *addr, unsigned long siz
 /**
  * find_next_bit - find the next set bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
@@ -50,8 +50,8 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
  * find_next_and_bit - find the next set bit in both memory regions
  * @addr1: The first address to base the search on
  * @addr2: The second address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number for the next set bit
  * If no bits are set, returns @size.
@@ -79,8 +79,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
  * @addr: The address to base the search on
- * @offset: The bitnumber to start searching at
  * @size: The bitmap size in bits
+ * @offset: The bitnumber to start searching at
  *
  * Returns the bit number of the next zero bit
  * If no bits are zero, returns @size.
-- 
2.20.1

