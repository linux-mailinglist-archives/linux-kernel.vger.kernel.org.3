Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91516576E10
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 14:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbiGPMtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 08:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGPMtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 08:49:53 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F618380;
        Sat, 16 Jul 2022 05:49:45 -0700 (PDT)
X-QQ-mid: bizesmtp74t1657975696tiishuk1
Received: from localhost.localdomain ( [182.132.179.58])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 16 Jul 2022 20:48:15 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000B00A0000020
X-QQ-FEAT: DQ0OCu3gog304FWbG4SwhH19WcZsbVUVPrzrmEZDmlamM/CNqWtAbrckIYRok
        NHp1icBxt560LDv8znL0edffbVTzlW+vTEYRVCrpJlvNK9tRwp42AA4kswIv/siwiupwkE/
        XbHHyf6pUBT23xLRDH0DpxvMa7cZiG8EybtLQanf6u7x3QH0rBl8UapayWpXh2zOLImlqZh
        9UO8wiZjGn89fGMvK6FMvyKDa3PNshgScIwQHZaGFxgSO2nFfm22KX/PNIeMRh6rAO0PTqR
        l9qVhDShDH00qw2CR2yi7eiMtzB5MjAM1p/Zu3bqTHTxGl7IYrcua1wE5zb9rvJZV5dmFjg
        SVdamqucIalB4Svi4hgPZhVolg22nXzA6w5GJGOFKiUPn/hhjg=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, brking@us.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: ipr: Remove unneeded semicolon
Date:   Sun, 17 Jul 2022 02:31:43 +0800
Message-Id: <20220716183143.55421-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon after the `}' in line 1980 is unneeded.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/ipr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.h b/drivers/scsi/ipr.h
index 69444d21fca1..54e47ce18338 100644
--- a/drivers/scsi/ipr.h
+++ b/drivers/scsi/ipr.h
@@ -1977,7 +1977,7 @@ static inline int ipr_sdt_is_fmt2(u32 sdt_word)
 	case IPR_SDT_FMT2_BAR5_SEL:
 	case IPR_SDT_FMT2_EXP_ROM_SEL:
 		return 1;
-	};
+	}
 
 	return 0;
 }
-- 
2.35.1

