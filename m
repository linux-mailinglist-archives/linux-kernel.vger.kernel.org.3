Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24DE58FEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiHKPMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiHKPMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:12:33 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3667B793;
        Thu, 11 Aug 2022 08:12:27 -0700 (PDT)
X-QQ-mid: bizesmtp83t1660230728t7q7362u
Received: from localhost.localdomain ( [110.188.55.240])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 11 Aug 2022 23:11:58 +0800 (CST)
X-QQ-SSF: 0100000000200070H000B00A0000020
X-QQ-FEAT: UMQM+3VOEYsTPC6jMH0yz2i4V+oZLsGcQU83QUJxmWPROYvQZ4BMGwaf+LtgI
        7CDKQfi+bB1csRp6nSTxoQx8kG1V9KxQmeH5BiOi6CS9Ol/0gDnq+ixD2kfsqM7Im1XBhWz
        kMhcstK/vS4TqTFK9ARDHWWu/sLQG5VdWgGg0IcvIArQdg8463bTMzR/7Eo7uMempJ2/ke3
        nKVqvori/Egh+PIrtf3WhXTZJ9FlOaQrSJt6K0J8ZEpWVKGDYvziHQW1dCPeu5BQx9T8FPt
        aWyrnzJuO5mKnhX/cakL6fZ3p2VjveNskSCfqkGKNwP0O39midPA76BJ5ztNxQdcXcS5dqX
        HuvjhPpQPAdXH/e5qVbSzwLRfuH+PP9qFzXGU4TLqxZdVNBEDAxOgrmnew40w==
X-QQ-GoodBg: 0
From:   min tang <tangmin@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, min tang <tangmin@cdjrlc.com>
Subject: [PATCH] scsi: Fix comment typo
Date:   Thu, 11 Aug 2022 23:11:46 +0800
Message-Id: <20220811151146.12677-1-tangmin@cdjrlc.com>
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

The double `the' is duplicated in line 208, remove one.

Signed-off-by: min tang <tangmin@cdjrlc.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 39e16eab47aa..28e8b9f1e1a4 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -205,7 +205,7 @@ static int fcoe_sysfs_fcf_add(struct fcoe_fcf *new)
 		 * that doesn't have a priv (fcf was deleted). However,
 		 * libfcoe will always delete FCFs before trying to add
 		 * them. This is ensured because both recv_adv and
-		 * age_fcfs are protected by the the fcoe_ctlr's mutex.
+		 * age_fcfs are protected by the fcoe_ctlr's mutex.
 		 * This means that we should never get a FCF with a
 		 * non-NULL priv pointer.
 		 */
-- 
2.17.1

