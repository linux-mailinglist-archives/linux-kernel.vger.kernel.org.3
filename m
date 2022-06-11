Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BBB5476BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiFKRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiFKRMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:12:15 -0400
Received: from mail.enpas.org (zhong.enpas.org [IPv6:2a03:4000:2:537::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 865CC24F34;
        Sat, 11 Jun 2022 10:12:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 5AD2E100022;
        Sat, 11 Jun 2022 17:12:10 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org,
        Vincent Mailhol <vincent.mailhol@gmail.com>,
        linux-kernel@vger.kernel.org, Max Staudt <max@enpas.org>
Subject: [PATCH] can: Break loopback loop on loopback documentation
Date:   Sat, 11 Jun 2022 19:11:55 +0200
Message-Id: <20220611171155.9090-1-max@enpas.org>
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

There are two sections called "Local Loopback of Sent Frames".
One was meant to link to the other, but pointed at itself instead.

Signed-off-by: Max Staudt <max@enpas.org>
---
 Documentation/networking/can.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index f34cb0e4460e..ebc822e605f5 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -168,7 +168,7 @@ reflect the correct [#f1]_ traffic on the node the loopback of the sent
 data has to be performed right after a successful transmission. If
 the CAN network interface is not capable of performing the loopback for
 some reason the SocketCAN core can do this task as a fallback solution.
-See :ref:`socketcan-local-loopback1` for details (recommended).
+See :ref:`socketcan-local-loopback2` for details (recommended).
 
 The loopback functionality is enabled by default to reflect standard
 networking behaviour for CAN applications. Due to some requests from
-- 
2.30.2

