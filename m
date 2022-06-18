Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C67550670
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiFRSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiFRSBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 14:01:54 -0400
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37444CE23;
        Sat, 18 Jun 2022 11:01:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id D6E4F100029;
        Sat, 18 Jun 2022 18:01:50 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: [PATCH] tty: Add N_CAN327 line discipline ID for ELM327 based CAN driver
Date:   Sat, 18 Jun 2022 20:01:34 +0200
Message-Id: <20220618180134.9890-1-max@enpas.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual driver will be added via the CAN tree.

Signed-off-by: Max Staudt <max@enpas.org>
---
Dear TTY maintainers,

The CAN people (well, a subset) have spoken and decided to accept the
can327 driver (formerly elmcan), an ldisc based CAN driver allowing CAN
experiments with commodity hardware.

After several rounds of reviews, the final condition is for you to
accept this patch for N_CAN327, so here goes - please add this new line
discipline to the list, and once this filters through, the driver itself
will be added to can-next :)


Thanks!

Max

---
 include/uapi/linux/tty.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index 9d0f06bfbac3..68aeae2addec 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -38,8 +38,9 @@
 #define N_NULL		27	/* Null ldisc used for error handling */
 #define N_MCTP		28	/* MCTP-over-serial */
 #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
+#define N_CAN327	30	/* ELM327 based OBD-II interfaces */
 
 /* Always the newest line discipline + 1 */
-#define NR_LDISCS	30
+#define NR_LDISCS	31
 
 #endif /* _UAPI_LINUX_TTY_H */
-- 
2.30.2

