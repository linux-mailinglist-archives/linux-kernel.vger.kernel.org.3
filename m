Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0371359281B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiHODae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHODac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:30:32 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0D637A;
        Sun, 14 Aug 2022 20:30:26 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 27F3TtMr003473-27F3TtMu003473
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Aug 2022 11:30:01 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hid: fix indentation issue
Date:   Mon, 15 Aug 2022 11:29:06 +0800
Message-Id: <20220815032906.508250-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongliang Mu <mudongliangabcd@gmail.com>

Fix indenting issue reported by Smatch

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b7f5566e338d..83f8554f7cb0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2712,10 +2712,10 @@ int hid_add_device(struct hid_device *hdev)
 	/*
 	 * Check for the mandatory transport channel.
 	 */
-	 if (!hdev->ll_driver->raw_request) {
+	if (!hdev->ll_driver->raw_request) {
 		hid_err(hdev, "transport driver missing .raw_request()\n");
 		return -EINVAL;
-	 }
+	}
 
 	/*
 	 * Read the device report descriptor once and use as template
-- 
2.35.1

