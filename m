Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812BB587BD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiHBL5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:57:37 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB964505F;
        Tue,  2 Aug 2022 04:57:31 -0700 (PDT)
X-QQ-mid: bizesmtp78t1659441447ts60284y
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 19:57:25 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: UMQM+3VOEYv6RDgJkmFUjN17c0U9/EK4D0r5xboTRYTlJWMTxCFW/bhL5ztfh
        KN732jL5tRiga2aMxYF8BcMwrkMrS5DVX52P78HCD5fZeGC3njHNCkGKQ7At5ZN2mTMUGqC
        QNM7Fi2FX10qdFu/2Uw8ShsohRPtrCdLWeuSDtzALYbTpyyRsZd0+q3YRy1QlzW75U/9ybp
        VhnMoZpIym+kpq8D7gdhwxkaDY74TrxwgI5uMR04LkyK9jA9YgByi8E87fnjPSxYVsB52Z8
        sKWW3IuhvWq2FICcxuTF93NZTh3T3qKjyB62EV6daO+wvWPHqXd3H8hBAzw/bX5yZH2vb0S
        x7UgxR3TwJDnGOkF0TZaJOTewGp1xy68HnZNlplqY36XH3qIqw=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: tps65217: Fix comment typo
Date:   Wed,  3 Aug 2022 03:56:38 +0800
Message-Id: <20220802195638.4324-1-wangborong@cdjrlc.com>
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

The double `the' is duplicated in the comment, remove one.

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

