Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBA7535B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349844AbiE0Igw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349705AbiE0IgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:36:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED547FC4E4;
        Fri, 27 May 2022 01:36:01 -0700 (PDT)
Date:   Fri, 27 May 2022 08:35:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653640560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaZhiO/1h58LHPXSSD9Yz5BrkOXSmqA4TJWBaMN70sc=;
        b=YL31eUGRsibt4co3wbOTCHzlwm8Uy3+AzfNqR8baY7XNECP5sBJjWWx/p8T5bTDk5dLzJY
        eBR3AEpwhk8JXTIqkfWWnM95c6Z5NIYFFglETYAPHBW0OhD9sll4kqpUn1CQLm8r3IbveQ
        amrQBXOcaS7ot5eZkWBs3eqigxRbBTgWBKqt3Sp2Q20Gi+0C1fGTHMP41HGxJZip/rKsEi
        EcfRz6n3sx0XaMISyohcPD5pCoRoARVGjtS8rwGx7i5mO/uUIO3FIwbsqNL2bS5ewkxNBm
        hI0yTUVTBhyXZDXOH5P0hq9V9H/JMD2Z8L4vGXz0yF11QlX5LPbp4SBo+t9zIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653640560;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaZhiO/1h58LHPXSSD9Yz5BrkOXSmqA4TJWBaMN70sc=;
        b=ZKG2lvz3YEYx5yPTbswjYHaiHCZKqmEuIoHFaxQFplMLCzHwI6u7PbKF6u03A8mg3QboZh
        qxKZAy1fY+SCjSBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/jcore: Convert to SPDX identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220510171254.467236056@linutronix.de>
References: <20220510171254.467236056@linutronix.de>
MIME-Version: 1.0
Message-ID: <165364055898.4207.11683748946363593495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     eb988ba4afbf821e8877810221e6bc00af161014
Gitweb:        https://git.kernel.org/tip/eb988ba4afbf821e8877810221e6bc00af161014
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 19:24:38 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 18 May 2022 11:08:59 +02:00

clocksource/drivers/jcore: Convert to SPDX identifier

The licensing text references explicitely the COPYING file in the kernel
base directory, which is clearly GPL version 2 only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20220510171254.467236056@linutronix.de
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/jcore-pit.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index 5d3d88e..a4a9911 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * J-Core SoC PIT/clocksource driver
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/kernel.h>
