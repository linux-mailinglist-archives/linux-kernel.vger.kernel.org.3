Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230594E8366
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 19:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbiCZSlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 14:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiCZSlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 14:41:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA631927;
        Sat, 26 Mar 2022 11:39:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:b:56bb:4cb:3227:231:99f8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 602761F44FBF;
        Sat, 26 Mar 2022 18:39:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648319975;
        bh=N0eR8mQkTGSS6+NrbKu8JzCIBdyNKMH/EWIJqHhJrCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKAHeVLH9T1B5iP85pQaGoLYfhGAtcVL5GU4OnL8Pyaqyg1jv2eWu65jEladStW99
         c0uBM4qeLc0qYrF0gZFxXN1dcQDm2CxcQNwd+TyvKmiIf94FaF67FKc8oa8/HOT3IA
         ZgolhcNSa3pUZD8g5ShY35j1LSjbjG2ae7RkLRwW+dofQFjm43dYeGtYwaqlUj1bPW
         wu+HAXPGkA1m0I4HAxZkApzBYKcXZhx7hgNV8hhaDMi3KD7Iml7IiWqHxwfa1oFf5A
         QpwkPajMmY3SImVi1gQySsTmzHIy6t/ZRcAU/Mqw+Eq1oFqNq1Gpxb9fpHWTuynQTE
         XWY4xa8Og1aCQ==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org (open list:HANTRO VPU CODEC DRIVER),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: media: rkvdec: Update TODO list
Date:   Sat, 26 Mar 2022 19:37:17 +0100
Message-Id: <20220326183715.67332-2-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220326183715.67332-1-sebastian.fricke@collabora.com>
References: <20220326183715.67332-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VP9 support has been added to the driver by f25709c4ff15.
And the VP9 uABI was merged with b88dbe38dca8.

The remaining codec that keeps this driver in staging is HEVC.
Update the TODO list accordingly.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/TODO | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/rkvdec/TODO b/drivers/staging/media/rkvdec/TODO
index e0f0f12f0ac5..2c0779383276 100644
--- a/drivers/staging/media/rkvdec/TODO
+++ b/drivers/staging/media/rkvdec/TODO
@@ -1,6 +1,6 @@
-* Support for VP9 is planned for this driver.
+* Support for HEVC is planned for this driver.
 
-  Given the V4L controls for those CODECs will be part of
+  Given the V4L controls for that CODEC will be part of
   the uABI, it will be required to have the driver in staging.
 
   For this reason, we are keeping this driver in staging for now.
-- 
2.25.1

