Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BB578287
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234979AbiGRMmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGRMmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:42:11 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDBF1A068;
        Mon, 18 Jul 2022 05:42:05 -0700 (PDT)
X-QQ-mid: bizesmtp64t1658148108tlxqynwb
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:41:47 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: lp8jUtqYSiDf71SA9Xuw9eCA/WGIDCxypUNjwDHaWPP/HIJKU14EedbhFeeKH
        zmFajBJFUry5V4mhaowuAnBCi9pLw5aWG3s5j0pcWq+lY6rE2DVDlfmKwJtRDzGiGWFvBeH
        8p1VEdpio90N7xV0QPOq/VgMMGZNZZD9BZwqdqPmJHB1/4/EkWug0DEWwnwApFSMgh33Rf4
        YctssxyPRdqFGNrorSO9XuSkHq0LBp4fhqWvG9BqwOx+fPnRuB1fEMD+W8oUE3sEBTWLDSc
        ChplnsXel4n9Pnto+dgz6bik7hIrTKakTeWiJVaTMGd3UqUjHmFRdtrT5PoLjCDpRd/bX2n
        A2aFjxKS1uq1o3X2VVqS0GNEE1UGepBpJ6YDGDEmP8YLuDih+RlrFG0CNg3nYDoYy0Z5+XN
        F6MTGdH+zPEzbluYIQtCtg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     zajec5@gmail.com
Cc:     hauke@hauke-m.de, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] MIPS: Fix comment typo
Date:   Fri, 15 Jul 2022 12:39:50 +0800
Message-Id: <20220715043950.18378-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 72, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/mips/bcm47xx/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/bcm47xx/prom.c b/arch/mips/bcm47xx/prom.c
index 0a63721d0fbf..bcb9c90ea041 100644
--- a/arch/mips/bcm47xx/prom.c
+++ b/arch/mips/bcm47xx/prom.c
@@ -69,7 +69,7 @@ static __init void prom_init_mem(void)
 	 * call them at the beginning of the boot.
 	 *
 	 * BCM47XX uses 128MB for addressing the ram, if the system contains
-	 * less that that amount of ram it remaps the ram more often into the
+	 * less that amount of ram it remaps the ram more often into the
 	 * available space.
 	 */
 
-- 
2.35.1

