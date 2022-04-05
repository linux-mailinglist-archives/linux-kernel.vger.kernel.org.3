Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490F04F4686
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349241AbiDEUeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572980AbiDERjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:39:52 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE2EB8203
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:37:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id s11so7085272pla.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nwu8jpVkI6C7VwnrywKtcRGeDT2fuyh+kt2g5bo1y9w=;
        b=Lw5EATL+sOQBSkpUq+6d2yFb3UX+wLpMPBMs1qT7H2FEnxAxS+Out/GTJK1O6Dl9Rh
         zzVeKLhcn9Iqw5nnSbmT59AtX+vxfT3tVF++IZuE8YPig+uL0Qd73A/szLBe14lkFRhT
         sKkEy0M5HsZGZhfriWrrucPJywYn7pNKnInUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nwu8jpVkI6C7VwnrywKtcRGeDT2fuyh+kt2g5bo1y9w=;
        b=BfmUb870CgyuCBdvCs97mIRLX2AISnjbUys9RBrjfdZN2Eq66rLKxUOGpUOvxtq/Kl
         ezJC7YlbDCy0GuctsE1vM4RM35W5HoROZD3sy6sEXBoeZvVF2ERszVGHzqjJeSbaerae
         X35On3R5p6cZmwuSLFmFZU3uWpxsan35oAG6Dc+1o+MaRRgv2+Px+serFAaS8olzS78k
         H+Hh3qJvzKkFHSD3Kngx15gjVkYy2JwQpc6rpzspcGB/GVr9obIRfvv+cHjpyH5+ylYU
         ltm0bYLjrvuK7mHu3Xpz0zklK8Obded91OK7p+s0z5OIeDYdqIGttrqF+h8nym01zwQ1
         kulg==
X-Gm-Message-State: AOAM530h9sOgz9ojYphXL36phFnt6w+2OaIrhahkKnABFtXX15/0U0mk
        uL5aw/IZbP4SC0FViX3TZTGnTA==
X-Google-Smtp-Source: ABdhPJx/Ml/KJFa13Olx66XGO/m5W3BLJXnALBjf/zubTA+VU5XEeYwj7jehcCiBfOkP4z4ChXJsAA==
X-Received: by 2002:a17:902:7ec1:b0:156:17a4:a2f8 with SMTP id p1-20020a1709027ec100b0015617a4a2f8mr4774620plb.155.1649180273187;
        Tue, 05 Apr 2022 10:37:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1331:63a2:a876:db1d])
        by smtp.gmail.com with UTF8SMTPSA id v3-20020a056a00148300b004fb04acde5dsm16033146pfu.166.2022.04.05.10.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 10:37:52 -0700 (PDT)
From:   "Jes B. Klinke" <jbk@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jes B. Klinke" <jbk@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
Date:   Tue,  5 Apr 2022 10:37:41 -0700
Message-Id: <20220405173741.4023216-1-jbk@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept one additional numerical value of DID:VID for next generation
Google TPM, to be used in future Chromebooks.

This patch touches more lines than may seem necessary, as a result of
the need to move the error case to sit after the two recognized cases.

Signed-off-by: Jes B. Klinke <jbk@chromium.org>
---

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f6c0affbb4567..bf54ebd6724b0 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -31,6 +31,7 @@
 #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
 #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
 #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
+#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
 #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
 #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
 #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
@@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID) {
-		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
-		tpm_cr50_release_locality(chip, true);
-		return -ENODEV;
+	if (vendor == TPM_CR50_I2C_DID_VID) {
+		dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+			 client->addr, client->irq, vendor >> 16);
+		return tpm_chip_register(chip);
+	}
+	if (vendor == TPM_TI50_I2C_DID_VID) {
+		dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+			 client->addr, client->irq, vendor >> 16);
+		return tpm_chip_register(chip);
 	}
 
-	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
-		 client->addr, client->irq, vendor >> 16);
-
-	return tpm_chip_register(chip);
+	dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
+	tpm_cr50_release_locality(chip, true);
+	return -ENODEV;
 }
 
 /**
-- 
2.35.1.1094.g7c7d902a7c-goog

