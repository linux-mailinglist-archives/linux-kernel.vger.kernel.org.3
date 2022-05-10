Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732B2521016
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbiEJI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiEJI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8642AC6C5;
        Tue, 10 May 2022 01:53:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652172822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VyW/pgclapZRlcTTJzzE/icqxkwWumTJuh4R6WTC77Q=;
        b=qRQn0qwFHixTsIez14IYsjNwL2hMAEYnj7CZGKl1+KXdCz6NOq0ClvgQGI5QWj4ZjNUJ+L
        97jc5cb485uuchetrCdfnNOs1D+tMyV8tptxQiGYYxg4QW3iRU07fGtUPnYi8ZAiRNPD7E
        IYsDEgGmyI8DwzIS/0l5Yq7pNyTkFRNyQOoshP/Sc1mquAEiSDwDtcYrzty/oBYkcQjl1k
        9g8rczUfNo0HqCBTYBtSnAD4zUhZTF1cOZ2vQbYlzkkz5VabP84O3TVeBjK6KYwuBFT50S
        PtIuJe0FEPH+ewAg0hXaVN3Lff5jlM9+C/Uid8p4bRNxcog4yiRmg03VeA2tFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652172822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=VyW/pgclapZRlcTTJzzE/icqxkwWumTJuh4R6WTC77Q=;
        b=vgtl5DaZrRVjhAeuxskTsrhJiVG6lvFOu3JGwD5Zn0ua0KiNv6mahvjaejbiDG0cJ5uWpB
        NcuSpjCbxiuCFWCA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org
Subject: debugobjects: Convert to SPDX license identifier
Date:   Tue, 10 May 2022 10:53:41 +0200
Message-ID: <87v8udpy3u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic infrastructure for lifetime debugging of objects.
  *
- * Started by Thomas Gleixner
- *
  * Copyright (C) 2008, Thomas Gleixner <tglx@linutronix.de>
- *
- * For licencing details see kernel-base/COPYING
  */
 
 #define pr_fmt(fmt) "ODEBUG: " fmt
