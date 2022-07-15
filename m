Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3611D578420
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiGRNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbiGRNpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:45:35 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153D71B7BC;
        Mon, 18 Jul 2022 06:45:29 -0700 (PDT)
X-QQ-mid: bizesmtp69t1658151911tdj95e5o
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:45:09 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: FVl8EHhfVR42yOTe1p83ZzYmW5d/SExUSDKTFkTBKzhCRk1NJSDQR0xKqO1C4
        I3pGVoMFqn124lP4YcPukRWcoTUDvF+2qUp9B2rZHFeC59xHDVpsb7zsQ7tSwWhR0oHYE12
        xpXRUtbDki5QVIT84nqJiTzXBAaeTHpU7eFohT9ZIeX45va3us/rrTTNxukZsyxF3jt49cF
        yXEm/Pqgtag9EYK6NB6pxyxTYDxYp9oFt5z380sJMEiihPVEMMUmzGRi12n6Tm/rX2x5bay
        CjNf591FL919pNmJF/Q/KhH59MQbp0DXoKDs3uqnRFTDoRAbMbwlWe6FsoupD5LWoq0xI0w
        vJU3Sff/JKJR7j2xZs9fOtbMzIgoI9QQXnlMAiOgfJd3X7KJ592HFtkTdWO+4A5+PHwGc9Y
        JikLcft9QYs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     jikos@kernel.org
Cc:     hdegoede@redhat.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] HID: lg-g15: Fix comment typo
Date:   Fri, 15 Jul 2022 13:43:12 +0800
Message-Id: <20220715054312.9320-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `with' is duplicated in line 769, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/hid/hid-lg-g15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
index b2a08233f8d5..c8f82bcbf1ab 100644
--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -766,7 +766,7 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/*
 	 * Some models have multiple interfaces, we want the interface with
-	 * with the f000.0000 application input report.
+	 * the f000.0000 application input report.
 	 */
 	rep_enum = &hdev->report_enum[HID_INPUT_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list) {
-- 
2.35.1

