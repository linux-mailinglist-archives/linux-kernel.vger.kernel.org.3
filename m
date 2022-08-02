Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6646F587BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbiHBMDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBMDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:03:50 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46ED4D81B;
        Tue,  2 Aug 2022 05:03:45 -0700 (PDT)
X-QQ-mid: bizesmtp69t1659441819tszfgaor
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:03:38 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: eSZ1CZgv+JB/NPavNiyOS9PrnEIDZJ+gNfOFq1XFzWcVjnkVyoB9uNOb+NuB/
        rwxzC9FmdsI6xTCxvBjKMhPYaRGa+pYBqkCGvj5MOtJaY5IuQP44WHqsPif67Q5BPeWITTu
        GBvSQeimG2dp5kmkuDuhaQKyOv2hP2dKHQN/cSY46H7LrRtlyADDWX1bcgHOKi5HAgNnB/X
        QNJBdxscsZM2MUwgxqVDyn4iciI3TWMUbbYQvuwJ5lJ9pNfqk9TATSkitAoXQl6U6tCB9XP
        wchpIpmxLmSZtdht98QeN3KAx1g/jy0mggVp3dBiKlY1I9dl7l7v2XOKMqiNtGR6xTfz6jo
        8rVD/VQba3FFuoKubXc5KhUXlaShhaGq5/Y0s5ZXkJaSbTAvc0qg7uFfdAJB2N4X4EPYRnl
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: ab8500: Fix comment typo
Date:   Wed,  3 Aug 2022 04:03:36 +0800
Message-Id: <20220802200336.5467-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index c19c50442761..914ce902b672 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1941,7 +1941,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
  * Due to a asic bug it is necessary to lower the input current to the vbus
  * charger when charging with at some specific levels. This issue is only valid
  * for below a certain battery voltage. This function makes sure that the
- * the allowed current limit isn't exceeded.
+ * allowed current limit isn't exceeded.
  */
 static void ab8500_charger_check_vbat_work(struct work_struct *work)
 {
-- 
2.35.1

