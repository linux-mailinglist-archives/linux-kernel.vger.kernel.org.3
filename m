Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7256460FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhK2IDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhK2IBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:01:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5994C06174A;
        Sun, 28 Nov 2021 23:58:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7780AB80DFD;
        Mon, 29 Nov 2021 07:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBFBC004E1;
        Mon, 29 Nov 2021 07:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638172703;
        bh=st6CSRwhpxKiMe/nJ42MUikmXaEC8XkumOwqm1pDqYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUjTGtBf4tkVwIC6a9Cq8x6RXLigQxXOXF2Luat5nA5Jk6IngPPKSqGSMdSWyka+v
         zbqRx/hjS/qTf27je56WEfnftDGfTAiCnXQUEhjo4v1T1BUulnhIZ0Js7wKw26+bxL
         xkFfV1Yb7Xn1q4rckIzf4rOwrWDg6XuchoywVekEF1pzWCSkdOdaB+22qFG0p3cPAH
         bcsPJa/TAmeHauWgkv1zb2SpBT0K50AmU6d1pukfoEQhmwy0lm6mk0ViljvhwKXVGj
         XiIGVsNfy/3RvHY1q1CcIDlNaOi9vKp43tG+ITRmRCmZ9qra8DoJnYRkhojp3RZzMm
         MvbP5U4BEFt3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrbYJ-0007xC-Og; Mon, 29 Nov 2021 08:58:19 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 09/10] media: mc: drop an unused debug function
Date:   Mon, 29 Nov 2021 08:58:17 +0100
Message-Id: <ee1651ac643e94ac1b24b6bf58f064b70347d492.1638172681.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <YZtp115b6T+ErG+8@pendragon.ideasonboard.com>
References: <YZtp115b6T+ErG+8@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gobj_type() function translates the media object type into
a name, being useful for debugging purposes. It is currently
not used. So, drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/mc/mc-entity.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index f40f41977142..c02340698ad6 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -14,22 +14,6 @@
 #include <media/media-entity.h>
 #include <media/media-device.h>
 
-static inline const char *gobj_type(enum media_gobj_type type)
-{
-	switch (type) {
-	case MEDIA_GRAPH_ENTITY:
-		return "entity";
-	case MEDIA_GRAPH_PAD:
-		return "pad";
-	case MEDIA_GRAPH_LINK:
-		return "link";
-	case MEDIA_GRAPH_INTF_DEVNODE:
-		return "intf-devnode";
-	default:
-		return "unknown";
-	}
-}
-
 static inline const char *intf_type(struct media_interface *intf)
 {
 	switch (intf->type) {
-- 
2.33.1

