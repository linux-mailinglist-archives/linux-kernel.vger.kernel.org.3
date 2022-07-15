Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451CC578360
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiGRNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiGRNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:14:16 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3BF1057A;
        Mon, 18 Jul 2022 06:14:03 -0700 (PDT)
X-QQ-mid: bizesmtp85t1658150039tzrlvou3
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:13:58 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: oxALfFWpRnBBCbH3v0YNAjT7lgvhEOKOFA6m/uXmiPM8MyF81xu0Wp6NkRJpZ
        jzhUmbosPYf7zQlj7s762spT+vV+bHLQC8Tw81xELCrjrW3R/g1UdDhNwl/q44glWqtABiK
        FtTnq9qqMUOxFKYoTrFIeg+CVx29s5YEYUzTYzN5NF61YTRdkuPPeYjg4geJjDrnk102znc
        /eK0V2oeNqkxs5cQB2ho7CWk+ED/33WlMxvrYj6fYK5C6vTwSns1vSIBkrXM4RL5l4p2MCJ
        29nXX8vCycog4T/Bu2Bi/7vDCQpQAPBqEQpyFZp7tD0ig6OdgnBm6e23rWWBdtW8krdRxZk
        REFFJHJDpecthncstnOm2npC3OO5P1qHkSwjqjwkknSpsrqPz6DrXxe0E1A3watbrceZn0j
        Ksus4/h9810=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: tps65217: Fix comment typo
Date:   Fri, 15 Jul 2022 13:12:00 +0800
Message-Id: <20220715051200.28576-1-wangborong@cdjrlc.com>
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

The double `the' is duplicated in line 53, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/power/supply/tps65217_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index ba33d1617e0b..a4bc9f2a10bc 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -50,7 +50,7 @@ static int tps65217_config_charger(struct tps65217_charger *charger)
 	 * tps65217 rev. G, p. 31 (see p. 32 for NTC schematic)
 	 *
 	 * The device can be configured to support a 100k NTC (B = 3960) by
-	 * setting the the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
+	 * setting the NTC_TYPE bit in register CHGCONFIG1 to 1. However it
 	 * is not recommended to do so. In sleep mode, the charger continues
 	 * charging the battery, but all register values are reset to default
 	 * values. Therefore, the charger would get the wrong temperature
-- 
2.35.1

