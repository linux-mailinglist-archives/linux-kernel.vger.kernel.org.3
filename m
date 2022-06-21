Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C155320C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350158AbiFUM3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350436AbiFUM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:28:24 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99110FD;
        Tue, 21 Jun 2022 05:28:16 -0700 (PDT)
X-QQ-mid: bizesmtp65t1655814483teg44yp4
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:27:53 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: BLQ9xozS6nKO2fJc7K3FCQ6uMHAMk0W73wUJqm1jNxRuIPK4ZaVVKNf8uS3H2
        0+UQVlDxgBY3c4vZLXLLL0BsEQsJJaIYO1i+8iUjzXXQC19z7G57m7cf3FaB+k3Nt9MJmzd
        cZnzGpaXXWFwoabE1BHGENw49r56uFWvuKi0WCnJ2v98RW8kDIGDllL7+iye2MoETYJ5szc
        Oz0i4NmE15RIV79QnSiSUl9eO0ImpE0YRkZCwCs+2tZANEX24DlSmOM4I+av8X2pNGcur1u
        T7SFH8dSVijiUPTg87tKl9u6PFRkCKUJLmd/OLcCS9b9JI1t9wkSNCfksn2aF39T9E2noY3
        uETm/6e1vhHKozE6eo=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] ID: intel-ish-hid: hid-client: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:27:51 +0800
Message-Id: <20220621122751.117143-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/hid/intel-ish-hid/ishtp-hid-client.c
line: 331
 * @device: Pointer to the the ishtp client device for which this message
changed to
 * @device: Pointer to the ishtp client device for which this message

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
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
2.17.1

