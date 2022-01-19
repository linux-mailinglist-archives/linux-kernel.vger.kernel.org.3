Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01EF4933FB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbiASEIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:08:55 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:42919 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235242AbiASEIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642565330;
        bh=Ql6j9PlAhOVvskyZmZUI53Opsdpkfj/d0GifJtIn9R8=;
        h=From:To:Cc:Subject:Date;
        b=eoJc+5YSKIw3L/9EzV0Xn9QIlT5gxn73zp+Y2g8xcjHnKqnWvZzU5kNTo6/R/zl7V
         NVaN0eUGKVDDOib8HY5KkZDGTbHBS39MBclQTWA/iFL5fhVp+bioBlaG5Om5uMleog
         YSQkjgMuskcTFBqbSs5Kc6Oy84LVQNHV+Hxk1/Lc=
Received: from localhost.localdomain ([124.204.76.123])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id D4D1A6FE; Wed, 19 Jan 2022 11:53:13 +0800
X-QQ-mid: xmsmtpt1642564393t6guz7zmq
Message-ID: <tencent_5DA124DA30164B8C65F2406B34E193F70A09@qq.com>
X-QQ-XMAILINFO: Mdw6+lqugK2CPiBgJlaJuwIPch7TgmoeikF7cM27REIhxqARxAyu5JsyLhEQ/U
         NNCg0/2wPTPufA1pIbk0XUkzf3GF4ZZcVPZ5BJHOtHz+xcHtF8EaXL4zK4DXsG84L9Fscsv59ZWp
         po8qFs7aiYW8pQy8yAIY9qtByY86cqJNQX/DClmKuQCX2mBb4MfbQ0Fm09QvK+01w2oMlgvbdfeM
         ecARXHqxWqkwt5Al77bzZqvJKA9024Ga7NVjImOaNKWFEcsDiTEatoHiI3pnOY/FOSr0EcQt7cIn
         Y6mR/MIThJgreRIzbZspbApztcgCqcOOnGuJDsjT8kqopWFIvDzidE841kIxD9i4HMfnS3SCn6A1
         nlec+F6j53JS+A6lHEyJc4xTCICVOj/e0d+3dDZf9XCK+iFtWdWEwKCIYpg5YMaDYWkMSgScMIbX
         H2/XVZ56rVBz5PgQi87rIAjgbtD07EzugG28Rs7HoXqUEhKfJVERLVxgIsl/3LLq44egM6/8GiEy
         Lki32Ktzz1/qBs8tpF50TV1wQCia8/j50kP9uxZlYYXZf/HWVAUoOVXuDpmwJtAyBvHkjgyvJZLU
         W7ak6VitUAsyumXHfE6Sg8Zg3OtVyfMDfY6dy/50q6wdXzozVehO97PpzKnQ37K3Y5Sx4tY686R+
         wTLJK7tUCsHJFOo8IXoxN/gEqP+CwWasWuFFJLDIaxPA0MNJ1St/LiJg61EbeFrCMaiHVc8vLhq9
         sh/dWoQvZjRr0g2LFGJg2zpuXIBHL7tES6Z1je4kKMcWWeU1W8F3hwArFkjAO6Pyfyp9LjRIHl7e
         N/u9dhOFlXZYYWANv9AbbkULa/2SG2h32yyt0076ZDc0HUaFXseOU0fy4Hx+1GS2E=
From:   elicec@foxmail.com
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hong Peng <elicec@foxmail.com>
Subject: [PATCH] power: supply: ab8500_charger: fix spelling typo
Date:   Wed, 19 Jan 2022 11:53:01 +0800
X-OQ-MSGID: <20220119035301.29862-1-elicec@foxmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hong Peng <elicec@foxmail.com>

fix the comment typo: "interrupts", "structcure"

Signed-off-by: Hong Peng <elicec@foxmail.com>
---
 drivers/power/supply/ab8500_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index ce074c018dcb..fcf4ed4e35aa 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -171,7 +171,7 @@ enum ab8500_usb_state {
 	struct ab8500_charger, ac_chg)
 
 /**
- * struct ab8500_charger_interrupts - ab8500 interupts
+ * struct ab8500_charger_interrupts - ab8500 interrupts
  * @name:	name of the interrupt
  * @isr		function pointer to the isr
  */
@@ -1083,7 +1083,7 @@ static int ab8500_vbus_in_curr_to_regval(struct ab8500_charger *di, int curr_ua)
 
 /**
  * ab8500_charger_get_usb_cur() - get usb current
- * @di:		pointer to the ab8500_charger structre
+ * @di:		pointer to the ab8500_charger structure
  *
  * The usb stack provides the maximum current that can be drawn from
  * the standard usb host. This will be in uA.
-- 
2.17.1

