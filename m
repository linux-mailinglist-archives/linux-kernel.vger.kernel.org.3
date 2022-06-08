Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7984554270D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiFHD47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiFHD4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:56:24 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D723F224;
        Tue,  7 Jun 2022 18:06:01 -0700 (PDT)
X-QQ-mid: bizesmtp87t1654650215t7lcf720
Received: from localhost.localdomain ( [182.148.15.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 08 Jun 2022 09:03:25 +0800 (CST)
X-QQ-SSF: 01000000000000209000000A0000000
X-QQ-FEAT: /bItHp+/hBgwwBc6ufl9SttNv8vY7eHAakJdU2zK306udwi1WHEE8dJGu/T44
        Z/r1Rue3cXwnVr5dsrBduj42bpx5QdDep7N1dDKcnDdiU6Z6YyIUnOBR1yL00YGfJnvYHNU
        sofkdMU99toGtDxwmUZH2hVCqxxX2IuZ7285EHA0/EBXvjvprEoeHT8N6hul7SR1ff1ye8R
        UGc+sqQhVnf00VVfLqgzCp72C9HJ46IClSgoI5h09oaDif9o+8N3JRWRIPgDZuyPew3oRns
        Lx87ej3/wTJFFlLtdhMGbIdPBD1k4FcrpdcesxCb0seYG1
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     thierry.reding@gmail.com, lee.jones@linaro.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] pwm: stmpe: Deleted extra {}
Date:   Wed,  8 Jun 2022 09:03:18 +0800
Message-Id: <20220608010318.18040-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary braces

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/pwm/pwm-stmpe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 2df526fe9c38..c45fe27859de 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -78,10 +78,9 @@ static void stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 	value = ret & ~BIT(pwm->hwpwm);
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
-	if (ret) {
+	if (ret)
 		dev_err(chip->dev, "error writing PWM#%u control\n",
 			pwm->hwpwm);
-	}
 }
 
 /* STMPE 24xx PWM instructions */
-- 
2.36.1

