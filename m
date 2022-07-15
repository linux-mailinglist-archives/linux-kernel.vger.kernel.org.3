Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A85783F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiGRNl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiGRNl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:41:26 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337D81EEFF;
        Mon, 18 Jul 2022 06:41:20 -0700 (PDT)
X-QQ-mid: bizesmtp75t1658151665taug2ewd
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:41:03 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: hoArX50alxFc5E7cYNVFeEf19y0Vrv/Cr+6UgenvfNYC34MNwrA09JARm/6x9
        ga7+d27j0ePKlyoHgHiD9jxLyIBY1n6HL+eQw+juaXzLHqFmm7nxmM50BP4F6qjkYQNODkM
        V522Pi6TNEUDZOsyPrROwbqv/bnSS2+IcDGEKlLA73cC/6O04pKYDgh8KZmxIRKIK5aWVgo
        RvJr1/4BcOmJBRpwp8neGSE5HcTVkHPTeoV81rIku4NF7XQpfsKoPeBDgfsLTmkAvuc+JgB
        uKZgpCqbxASCDX4dL+D0trX67wjQrpy1YxApORypnMPvNXQ7ZS0igAtURg4ieGxcwUX22Qk
        qFxq8ebQevWnEoMfcZtuiyXHi0GQDYc6mZ+xBTCd6UihIpD3SEx8tx5VLxzxZ+wx4OOa0PB
        cSNOfguORdwRWxLok94NMw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     svens@linux.ibm.com
Cc:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, baihaowen@meizu.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] s390/tape: Fix comment typo
Date:   Fri, 15 Jul 2022 13:38:38 +0800
Message-Id: <20220715053838.5005-1-wangborong@cdjrlc.com>
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

The double `that' is duplicated in line 551, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/s390/char/tape_34xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_34xx.c b/drivers/s390/char/tape_34xx.c
index 38cc1565d6ae..751945fb6793 100644
--- a/drivers/s390/char/tape_34xx.c
+++ b/drivers/s390/char/tape_34xx.c
@@ -548,7 +548,7 @@ tape_34xx_unit_check(struct tape_device *device, struct tape_request *request,
 	case 0x2e:
 		/*
 		 * Not capable. This indicates either that the drive fails
-		 * reading the format id mark or that that format specified
+		 * reading the format id mark or that format specified
 		 * is not supported by the drive.
 		 */
 		dev_warn (&device->cdev->dev, "The tape unit cannot process "
-- 
2.35.1

