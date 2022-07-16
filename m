Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD617579E50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiGSNBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 09:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242599AbiGSM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:59:09 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345CA5FAE7;
        Tue, 19 Jul 2022 05:23:54 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658233414tdshc6pu
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:23:33 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: +N0aDBfR9LWKmk7Cm6MZO183x4CWNFE6ULv1jzaOcDN64ENn+jNOxFvyMQM+Q
        L53n9JuFEWD/Y+k0digcDsh7aXATZHzRbgEIltGhM8lCH1OVNVbdGgaM1umg8lxi6u2sfS9
        DOY4cooGEYQ/JGz03OrQrlq/6G5UhWxErwdtlv40u5Z94wxC45+zn6ilGgsku4DgHlwbEBm
        +TzqdtKRAKL2pMn5th25qzBAR/AdXUSwsLcwxYDqLYdjdwo4HhW9cdhpZsZYq5wEqoDywKv
        phx7+IC2Mop7siOwA//RgailbLvuX1K1h+yaPL9VmQHWrBfbvlFI6Ek5AaMzLY/YgCyXZ+e
        H/C4Qdpwyqer97xPJbEAsyJiVD8gVvJYzwQVLuIVxXWbEKWwP/yRFfXIx3D1CRFJJcxZy2b
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jikos@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] HID: intel-ish-hid: Fix comment typo
Date:   Sat, 16 Jul 2022 12:21:37 +0800
Message-Id: <20220716042137.35364-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.35.1

