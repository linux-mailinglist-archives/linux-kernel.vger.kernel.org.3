Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6874C583EE5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiG1MbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbiG1MbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:31:20 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1C72CC88;
        Thu, 28 Jul 2022 05:31:14 -0700 (PDT)
X-QQ-mid: bizesmtp87t1659011462tgb3apw1
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:31:00 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: ao4JQgu0M3+P1vbyICLB3Uw2D1O1+KAjotXac10A389384peWefdNJPFwXF24
        iKQ3isJWd+jBTBNLf/4xkCk2D9+6jZ2XQmffrv2KnjaN9PWi8yu3jqs//kuMUYjGGjxslrj
        TGdSbaOCkkVtDuusdqTLrRofKciywvI4DbXg42lQfTqFD8sLIkCy76iOPNxlTNQ/IalvwMb
        Cn5V7TWzLWKbII8I8El+qEMAZgMHlxEpbVkN2pBwVeaZFG66eairxU8lVdSla60HKlgw78u
        l90PGqclNlsxW8UnLm6PqbrGXTQf+mkvbAkCsLGc6dcbkODSJ+Ctzx1FmZ6TpM2Dj/kX88i
        PcReb76hQPaTt43bTK0VD4dcQD2FLbv3VnbTnHg7SdMmKhdAp8A8gEnHitP1w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     hdegoede@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] Input: Fix comment typo
Date:   Mon, 25 Jul 2022 12:29:03 +0800
Message-Id: <20220725042903.4954-1-wangborong@cdjrlc.com>
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

The double `we' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/input/touchscreen/chipone_icn8505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
index f9ca5502ac8c..ea98657e6e49 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -285,7 +285,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn8505)
 
 	/*
 	 * Always load the firmware, even if we don't need it at boot, we
-	 * we may need it at resume. Having loaded it once will make the
+	 * may need it at resume. Having loaded it once will make the
 	 * firmware class code cache it at suspend/resume.
 	 */
 	error = firmware_request_platform(&fw, icn8505->firmware_name, dev);
-- 
2.35.1

