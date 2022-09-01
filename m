Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE4B5A8A62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 03:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiIABNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 21:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiIABNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 21:13:51 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B68412A5FA;
        Wed, 31 Aug 2022 18:13:46 -0700 (PDT)
X-QQ-mid: bizesmtp64t1661994822t0foq260
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 01 Sep 2022 09:13:41 +0800 (CST)
X-QQ-SSF: 01000000000000D0F000000A0000000
X-QQ-FEAT: Yl5FOsZ5kXkmKP4wJouCLkMBfgdOs7J4lBDjZMdGPgAhTtJN8LzaSZqPRK1if
        3R1BLIgGu64MW7wSnhfn5OlaEHHFm2/2YAOThPKYwF+PSX1DmcKZUyIjWrFq5pEXbGx79sv
        55H+yiDVIel/yw8HvEG8a0ZTRC8sqXRxyXBCGjetNwD0+x6/BS+T5pwPes0GEUrvZXbFLz1
        y2jRBfTr9azNeauNizO4SUzHG63UC6C1ElpVTH29jHT5UBLBy9f64bt/fciBC2+khUgtzVT
        S/thsJ1IymqF3ziw353F/Ixz0OTtSb/8YbolIsSGsZuDP4spSmDcv0GQVxKPwO0IiGmhzbz
        /VLsNMvTBVAL8RSwGwAcTblpsiiqO/P+8U/dkbSjoss6JJ6QUM=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] media: siano: Use 'unsigned int' instead of just 'unsigned'.
Date:   Thu,  1 Sep 2022 09:13:35 +0800
Message-Id: <20220901011335.23313-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 T_SPF_HELO_TEMPERROR SPF: test of HELO record failed
        *      (temperror)
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' should be clearer than 'unsigned'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/media/common/siano/sms-cards.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/sms-cards.c b/drivers/media/common/siano/sms-cards.c
index d4a116ab6c88..905007275fd6 100644
--- a/drivers/media/common/siano/sms-cards.c
+++ b/drivers/media/common/siano/sms-cards.c
@@ -149,7 +149,7 @@ static struct sms_board sms_boards[] = {
 	},
 };
 
-struct sms_board *sms_get_board(unsigned id)
+struct sms_board *sms_get_board(unsigned int id)
 {
 	BUG_ON(id >= ARRAY_SIZE(sms_boards));
 
-- 
2.36.1

