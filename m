Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245B6554320
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350338AbiFVGc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiFVGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:32:55 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7C62F64A;
        Tue, 21 Jun 2022 23:32:47 -0700 (PDT)
X-QQ-mid: bizesmtp68t1655879559t7m5rgxa
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 14:32:33 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000D00A0000000
X-QQ-FEAT: JCzhYPHCTbgEymvzOAeyowkIqeCwWz3/9D1jSz6HQpWUKME/jX5/lbLKRuxSt
        rfjqNEylMh3p94Rn9dFtEGqoDtyQY8RFNBBRYoErtZneew8lGVeQ3GLZEgQwK33BhFxFgvL
        P/V503VZhrSiwWKA1EHsGjhGI9Kon/b41BywadfBbYtITqi/qPuSfzfpzkodi5aJQt5xZt/
        isn9E8vmwpPVLXyS9D4GlMIzYm+LeTTZTsCVGsBPU1YCCEPUEgCtX7/bvccVC3fZFkTxyNi
        UOWMI9gIVHrIDLhcksYf+9dO6j7vBg1RePxrBzVmutCj+mTUX0cIve/h2KUbrxu/UKfnWzU
        b1b0xh6/VbKMW1cchM=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] hwmon: (pmbus/ucd9200): fix typos in comments
Date:   Wed, 22 Jun 2022 14:32:31 +0800
Message-Id: <20220622063231.20612-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the redundant word 'the' in the comments following
    /*
     * Set PHASE registers on all pages to 0xff to ensure that phase
     * specific commands will apply to all phases of a given page (rail).
     * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
     * READ_IOUT will return the sum of currents of all phases of a rail,
     * and READ_TEMPERATURE2 will return the maximum temperature detected
     * for the [the - DROP] phases of the rail.
     */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/hwmon/pmbus/ucd9200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
index 6bc3273e31e7..3ad375a76f3e 100644
--- a/drivers/hwmon/pmbus/ucd9200.c
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -148,7 +148,7 @@ static int ucd9200_probe(struct i2c_client *client)
 	 * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
 	 * READ_IOUT will return the sum of currents of all phases of a rail,
 	 * and READ_TEMPERATURE2 will return the maximum temperature detected
-	 * for the the phases of the rail.
+	 * for the phases of the rail.
 	 */
 	for (i = 0; i < info->pages; i++) {
 		/*
-- 
2.17.1

