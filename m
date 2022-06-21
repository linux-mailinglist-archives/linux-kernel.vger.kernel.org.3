Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47F552FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiFUKco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiFUKcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:32:41 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411A28735;
        Tue, 21 Jun 2022 03:32:36 -0700 (PDT)
X-QQ-mid: bizesmtp69t1655807486tz9qxx2r
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 18:31:22 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: 12WmTNdz4A2GoaWCvcCF9Kah1F9MRC/IaBdPf9aTvkOpMYtufAJDkWffRNh3h
        qrqNocBrembt7PJ0yWatRyXwzsXs0qCSM0hrPTn/jfF+kafDyFygUK8AGq9mpV7vrPV8qjL
        4hva569l3L4icTGQ/kUN+/4wk9Sc5CYFyipqVMGWugUim9qlWSUtHoM0uAeH8nlJLi2gs/n
        X+woROn6C21lOVJw1FHlDFDCNmJwZXP3o2zuCeyXJ9NlJg1VonDYFeFA9NdPnG/43w0lhxP
        40hVxY8ZI6xCqkg0nRrm6CXS62Zb9cb5sCamXhFUyQQD4Dd7Gv5Uk0u7YeTj58IRJjt2DnF
        p0EyJ7BfOwdz7N/ukLjXj6xFpViEg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangjian@cdjrlc.com
Subject: [PATCH] scsi: message: fusion: drop unexpected word "the"
Date:   Tue, 21 Jun 2022 18:31:19 +0800
Message-Id: <20220621103119.91492-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

>-   *  Update the target negotiation parameters based on the the Inquiry
>+   *  Update the target negotiation parameters based on the Inquiry

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/message/fusion/mptspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/message/fusion/mptspi.c b/drivers/message/fusion/mptspi.c
index 388675cc1765..4c87a6b986f6 100644
--- a/drivers/message/fusion/mptspi.c
+++ b/drivers/message/fusion/mptspi.c
@@ -101,7 +101,7 @@ static u8	mptspiInternalCtx = MPT_MAX_PROTOCOL_DRIVERS; /* Used only for interna
  *	@target: per target private data
  *	@sdev: SCSI device
  *
- * 	Update the target negotiation parameters based on the the Inquiry
+ * 	Update the target negotiation parameters based on the Inquiry
  *	data, adapter capabilities, and NVRAM settings.
  **/
 static void
-- 
2.17.1

