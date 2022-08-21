Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8441959B4DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiHUPLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHUPLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:11:37 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C90B22B00;
        Sun, 21 Aug 2022 08:11:35 -0700 (PDT)
X-QQ-mid: bizesmtp86t1661094691ty6q47f6
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:11:30 +0800 (CST)
X-QQ-SSF: 0100000000200010B000B00A0000000
X-QQ-FEAT: 7jw2iSiCazplMiGtQJPWzBJh5BMzd0nwZpJfY25RNWZhD5ADaApglAlQ2qGZt
        f7gTys7+mqs+vIaRdTX+dCjnmpkpw1dhO4V1+uKJrPG+V/IfMVt3IwCLR5nwTE/1GjloTsx
        3IN1Mu4hK3AeLh/SDc+/jb6HaXycYSggUL0St6m8HfDjGc/9eCoX7CIZ4APXBFduRVXQ7C5
        vfvxP6Ss2gRGO70/Pl8BSmriljuCzsyENkREeV5BNnrqN2U/dBErzHlVbrEADqNGj/nQVPo
        fwtLM67slZ2PFU5Vf1pl9thKlRDeIMDFUlDxEnbs+Dx57KJPQhtRNsFaGxD1t5PsljVNfle
        wq1pw2lB22YQhLSOUouMKa7wnpedvIdX1ZLuUWGNr3IZvacj5g=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/of: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:11:23 +0800
Message-Id: <20220821151123.54778-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_PBL,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'of'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874f031442dc..1582388156a9 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -19,7 +19,7 @@
 
 /**
  * of_match_device - Tell if a struct device matches an of_device_id list
- * @matches: array of of device match structures to search in
+ * @matches: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an platform_device present in the
-- 
2.36.1

