Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C3F57C48C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiGUGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGUGf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:35:56 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44AF73AE41;
        Wed, 20 Jul 2022 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=9XCyq
        eP4OtkNEsuVjEU+S2obYwxCz6LbY9AgANlqHIU=; b=p9jV8LuQBsqNUwbLmMrJj
        7cHUiLq7omRxJ57HeWtXr+qDw7qZhuZyHz5OmqKRkuP6ozy1+K7/dxlKTVCMMS5X
        YUxktA9mdtkLZsAo4wBocbl4CwAAXvZYAcK0jV6hBM4R3SR41ie4KbFqFDKmLRQu
        iT1WFwU+8BR3gDkChxqsuE=
Received: from localhost.localdomain (unknown [112.97.57.47])
        by smtp1 (Coremail) with SMTP id GdxpCgDH5ta389hiWptLPg--.4289S2;
        Thu, 21 Jul 2022 14:35:38 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] HID: intel-ish-hid: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 14:35:34 +0800
Message-Id: <20220721063534.47272-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgDH5ta389hiWptLPg--.4289S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1kCFy5tr4xArW3trb_yoWfAFg_Cw
        1Fvrn7G3yktFs3tr4qkr9xZrW7t3yFqrna93WfKryFkFy8uwn8ZF4ktr18Xw45Gr45t3Z3
        XFyDurn8AF1xWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRfnOQUUUUUU==
X-Originating-IP: [112.97.57.47]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRpFZGAJpJiCPgABs2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 4338c9b68a43..e3d70c5460e9 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -328,7 +328,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 
 /**
  * ish_cl_event_cb() - bus driver callback for incoming message/packet
- * @device:	Pointer to the the ishtp client device for which this message
+ * @device:	Pointer to the ishtp client device for which this message
  *		is targeted
  *
  * Remove the packet from the list and process the message by calling
-- 
2.25.1

