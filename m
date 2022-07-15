Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E2578381
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbiGRNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGRNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:18:29 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508D27B0E;
        Mon, 18 Jul 2022 06:18:25 -0700 (PDT)
X-QQ-mid: bizesmtp89t1658150296t4dmd2js
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:18:15 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: zK0nlCs2Z6F0XWAXfajss1FWPt3X6ei3kB8dmrQOBIk3JU1itTUNqdxm/S6j+
        3zYWDBOPGqhVj2isrzhObEyEcZUc1xlNANZiTnpclxNaKjfUkHXXhXTOqT7WnSPOUDDlMWE
        0fy95lRwYY12aHnHeu2/AAyVu0C7xzRT9n78IoXrRuN2vcwR4ytnXyXvrx7QBnoF5b52A/o
        Ff7SbzVo3jjHgBDH2cW/e8y1joRjP5dySWtcmMlthiLNeVw5BCVrBVjqbdW9ST5gRPv8US5
        ux0Q0zqtcNqhOJkNb/z3MHNReyJIv8Ip0eBP9mEtF4loKmYoayxq1ETlBaG8JyghcnlP/W2
        d/4ZLaIogtMDj2h9SMBm7IsgTLBc5H0zdFw3WMFqpsUsFAmHAW9D2PpFOGD9Cb4sjh5rYaB
        uXmftVs2UR2zIAf7sXt+VQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, zhou1615@umn.edu,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: dib8000: Fix comment typo
Date:   Fri, 15 Jul 2022 13:16:16 +0800
Message-Id: <20220715051616.29946-1-wangborong@cdjrlc.com>
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

The double `this' is duplicated in line 3215, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/dvb-frontends/dib8000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index d67f2dd997d0..25980e90d6bf 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -3212,7 +3212,7 @@ static int dib8000_tune(struct dvb_frontend *fe)
 
 	case CT_DEMOD_STEP_6: /* (36)  if there is an input (diversity) */
 		if ((state->fe[1] != NULL) && (state->output_mode != OUTMODE_DIVERSITY)) {
-			/* if there is a diversity fe in input and this fe is has not already failed : wait here until this this fe has succedeed or failed */
+			/* if there is a diversity fe in input and this fe is has not already failed : wait here until this fe has succedeed or failed */
 			if (dib8000_get_status(state->fe[1]) <= FE_STATUS_STD_SUCCESS) /* Something is locked on the input fe */
 				*tune_state = CT_DEMOD_STEP_8; /* go for mpeg */
 			else if (dib8000_get_status(state->fe[1]) >= FE_STATUS_TUNE_TIME_TOO_SHORT) { /* fe in input failed also, break the current one */
-- 
2.35.1

