Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1C591B87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiHMPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiHMPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:39:11 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B581F25C5E;
        Sat, 13 Aug 2022 08:39:09 -0700 (PDT)
X-QQ-mid: bizesmtp74t1660405136teg4hwd1
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 13 Aug 2022 23:38:49 +0800 (CST)
X-QQ-SSF: 0100000000200080H000B00A0000020
X-QQ-FEAT: ILHsT53NKPiNk4bRb0kPAJY/QtGiaRH8J/HzxnHfLoNJrHOFmjgz5qyvD+Be6
        LhMv7Xujrtk3qpUMcO3VZsn0p/WdvprwMS8WlW+vau1Dtzj+jmIXC+nEHA6TSgyjTY1GMEu
        B2dJgjH3eDKbsIvs3YHrXl22+jY3ItrDOhmk+Mq8SdpU47Fzv4ZDLrGCXCw5g6SFjwBalOR
        NS6W8yaLlGJaRx2hNBERxwPDWClcD3z1syLdQrAkNA+XV8nFpj0GeT6CgtSgI06QsGIhoST
        HaRfdmSoxnz9prkE+xq33HZcJ+fZmVhxlbCOycA4frNrEub1RsHgzC5FgviwM54QZoFmuVQ
        0o0nzr7QVRs9mOUaiSbtvLEMldvsO4/XKPwJgLH0pTFrgbKcE4jvi/nDkX66w==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     brking@us.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] scsi: ipr: Unneeded semicolon
Date:   Sat, 13 Aug 2022 23:38:37 +0800
Message-Id: <20220813153837.4938-1-tangmin@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no semicolon after '}' in line 1980.

Signed-off-by: min tang <tangmin@cdjrlc.com>
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
2.17.1

