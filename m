Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB9B553533
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiFUPGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352197AbiFUPGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:06:07 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291227FD5;
        Tue, 21 Jun 2022 08:06:02 -0700 (PDT)
X-QQ-mid: bizesmtp69t1655823934t1w17i80
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 23:05:30 +0800 (CST)
X-QQ-SSF: 0100000000700070B000D00A0000000
X-QQ-FEAT: rCzLTtzQ0gdSWwagS7lrQndYDD9VIhn4pCNGLyT5Mjd3ZQPnyyxPayz+KTxHR
        +6UrKBj9U7yOF78n/xoyMnhY/i5cwKM0uykY7R6m7N8IMqvd//Fh1mBpcrfy5gaVwlZKynE
        CUJ71pUmKdFyXhi+i9GpAsp8XwA4VtQY1Tn+Ts/Iu5dCFU94V8fMEO7RfRSjk2lBTWo7CcS
        MEaoQg+y05Gms0F22laztKb8Mpf6Us8T9Sc/dmPUkGTY3811uLRqQLUOcwmQx+1hbGlBHAO
        CWZBrwXdfq+NCTqk07rEOvhoiSjW48w4ejOlptk0Yd7QkrFbLrxKJpXzz5tNiOqspbELZNv
        kOE9p3XKF1UkFEwSLnx2EDOU212VA==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, jiangjian@cdjrlc.com,
        colin.king@intel.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: saa7164: Remove duplicate 'on' in two places.
Date:   Tue, 21 Jun 2022 23:05:28 +0800
Message-Id: <20220621150528.11270-1-jiangjian@cdjrlc.com>
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

file: drivers/media/pci/saa7164/saa7164-api.c
line: 804
/* Assumption: Hauppauge eeprom is at 0xa0 on on bus 0 */
changed to
/* Assumption: Hauppauge eeprom is at 0xa0 on bus 0 */

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/pci/saa7164/saa7164-api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-api.c b/drivers/media/pci/saa7164/saa7164-api.c
index 5526bcc7a9bd..965d285a9240 100644
--- a/drivers/media/pci/saa7164/saa7164-api.c
+++ b/drivers/media/pci/saa7164/saa7164-api.c
@@ -801,7 +801,7 @@ int saa7164_api_read_eeprom(struct saa7164_dev *dev, u8 *buf, int buflen)
 	if (buflen < 128)
 		return -ENOMEM;
 
-	/* Assumption: Hauppauge eeprom is at 0xa0 on on bus 0 */
+	/* Assumption: Hauppauge eeprom is at 0xa0 on bus 0 */
 	/* TODO: Pull the details from the boards struct */
 	return saa7164_api_i2c_read(&dev->i2c_bus[0], 0xa0 >> 1, sizeof(reg),
 		&reg[0], 128, buf);
-- 
2.17.1

