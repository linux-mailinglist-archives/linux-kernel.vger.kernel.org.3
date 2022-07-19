Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74947579881
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiGSLaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiGSLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:30:07 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCBA40BC6;
        Tue, 19 Jul 2022 04:30:02 -0700 (PDT)
X-QQ-mid: bizesmtp71t1658230177tvagcbga
Received: from harry-jrlc.. ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 19:29:11 +0800 (CST)
X-QQ-SSF: 0100000000600030C000B00A0000020
X-QQ-FEAT: oxALfFWpRnBBcswIsH4uNpmlux2z+bM7mq+g1Ezdqkd97Qhxqb+sNzXcJ/PIJ
        zItViy23ulmXfZgOPRXafS/2hXAi47NnVcDDa9tDb5QsG91d0rvI8ighc3/4gzIOyRRN97w
        GgP6iHqTqzm3psOIO65es4Ctb/40xDCgpFvHGYJEOO/jPT7XCEiGfcnIkA+YNtJx5fYDc0s
        gJpesK36bnvVJKtlmYxi6hIMeIbZRM8jCqhZ6U6kafrzLggiSmBajNZdynUTv7748t0/in0
        GRwo3moPPsKxuW8sYBzoLTCMTqeHrO/Ui2rCR5dpHeZfHoEc012TPik2aXlNEo/Au6L+Z0V
        vL7KvzL/TP74ISMx5MXeYNbx/rT3U2DdDqj4NvjfqiyjXjYtjFMP2OxqLdPmEqeTX+e1MyN
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] Date:do not initialise statics to 0
Date:   Tue, 19 Jul 2022 19:29:08 +0800
Message-Id: <20220719112908.7333-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
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

do not initialise statics to 0

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 drivers/ata/pata_artop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_artop.c b/drivers/ata/pata_artop.c
index 20a8f31a3f57..1aad8df2ea87 100644
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -37,7 +37,7 @@
  *	test stuff.
  */
 
-static int clock = 0;
+static int clock;
 
 /**
  *	artop62x0_pre_reset	-	probe begin
-- 
2.30.2

