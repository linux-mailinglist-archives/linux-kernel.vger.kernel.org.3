Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E7C587C4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiHBMVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiHBMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:21:12 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7E4CE3B;
        Tue,  2 Aug 2022 05:21:07 -0700 (PDT)
X-QQ-mid: bizesmtp64t1659442862t7nrn8ne
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:21:01 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 239gR2IZrluC1pAPMzCNZ8NMBaIrAycgGKaZ3zX/swGBEWqaiMTvbnFVcHmKI
        +dWXvxpw3iwXhoP0LqwA2YT6zOSWDjjaDzQpQBQ8KJ+5L66mAqZy5ZoMOCalsE5y4lm/fgF
        ho09gbsw+RG66qX26aSDbRlvNJg99hyN08Nt8HMGidr//Moop1rQR9hwZcdb8aqcJ6nuGxZ
        ekHcQomlLsz5jYLqjNoKS9k9JP5KAIsCU69k27yzuZ+JN19tsZN/x+gXMi/khsJervIhB8+
        dIkCYf74N1WBNN6MhW6Uana1r7DJO8w4/2xEkyQ6lEJjn04bPZQMho5aw+6qE1brEVf9+mv
        oSC7DS5iNM5xhrc2cwimTkDPF1BM+TzWrnk0xRdvraGoKQJFNBpAfRHh8njXYVoet8ultnX
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] target/pscsi: Fix comment typo
Date:   Wed,  3 Aug 2022 04:21:00 +0800
Message-Id: <20220802202100.9102-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `calling' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/target/target_core_pscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index e6a967ddc08c..245912fc209c 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -500,7 +500,7 @@ static int pscsi_configure_device(struct se_device *dev)
 			continue;
 		/*
 		 * Functions will release the held struct scsi_host->host_lock
-		 * before calling calling pscsi_add_device_to_list() to register
+		 * before calling pscsi_add_device_to_list() to register
 		 * struct scsi_device with target_core_mod.
 		 */
 		switch (sd->type) {
-- 
2.35.1

