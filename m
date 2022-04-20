Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB0D507D35
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 01:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353379AbiDSXkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347450AbiDSXkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:40:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5F13CE8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:38:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id n22so315079pfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAn+Q+XpQGMqwQvxfes6OD+qA6frjtwoSRhNwJOqLuc=;
        b=Rgew3kMAegk7IV1YBFeSK+E2mHNsZpVQnefRw1IKrQg36jefIn/ClGNc5mVKw7aLFm
         HFSxBtQrXSSulCLZLNIb1ie5hi/ittyV1xGLDg2oLuN0LsunaPnseKzmyieREuNDwbfL
         T2MPxYwsXhJ/ZY1h6EbltcxNXooKqauLf6JT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bAn+Q+XpQGMqwQvxfes6OD+qA6frjtwoSRhNwJOqLuc=;
        b=ZOXtvCLKWxmC0t5X9e3K2eDmlzOeDlmqXPZtoToH0d/63YNLLS6/pVXk8vJZnOWlSh
         St5gQSqi2gl7TXVzoTn5tg4BCrlj3XHSGL24zDHtmc0GOwQdRscoRWV+qeN2DNFpxfuu
         JnGzEr4/EhNqE+zpezl9ovBbDL+x5jPakDH5yhaZNKb0qfF64F7n+3pOzAmVuO57PcAu
         IjtNf0iH7VqAQkPDSDH3xwiqlA6t07D6PIcRYDnThFD/6vqfgTgovhSLRGoMHkt2eiQ/
         dEYLsI7kSqrUolo9KRkBB6Q8HgcYCB0WTy3CorkkPMOVwP3jE9+8hUKt6pAL357/hBPK
         ZQrg==
X-Gm-Message-State: AOAM5315lIvuguuHrzC7ttp3CgfEbgk9uEy3+zt/Jor3q+sXN3xhL/Mo
        xrmCtL0nE54F7//tkaypaCMDgA==
X-Google-Smtp-Source: ABdhPJzcuKQvFrTwyQuJ0B2cSyDjcSLL65/RyfnklhmypJrDUXGf/aJg2gnDhHHV+m1frj9AIxlmtw==
X-Received: by 2002:a63:d747:0:b0:39d:8a17:7ce0 with SMTP id w7-20020a63d747000000b0039d8a177ce0mr16563099pgi.245.1650411484681;
        Tue, 19 Apr 2022 16:38:04 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:4550:a7f7:353a:aa7])
        by smtp.gmail.com with UTF8SMTPSA id 19-20020aa79113000000b00505d5d15d80sm17609207pfh.14.2022.04.19.16.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 16:38:04 -0700 (PDT)
From:   "Jes B. Klinke" <jbk@chromium.org>
To:     linux-integrity@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "Jes B. Klinke" <jbk@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: cr50: Add new device/vendor ID 0x504a6666
Date:   Tue, 19 Apr 2022 16:37:57 -0700
Message-Id: <20220419163749.1.Ica39bd8d1494f750a70a668e5929f6e5e63241f2@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accept one additional numerical value of DID:VID for next generation
Google TPM with new firmware, to be used in future Chromebooks.

The TPM with the new firmware has the code name TI50, and is going to
use the same interfaces.

Signed-off-by: Jes B. Klinke <jbk@chromium.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index f6c0affbb4567..4ddb8ff3a8569 100644
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
@@ -742,15 +743,15 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 	}
 
 	vendor = le32_to_cpup((__le32 *)buf);
-	if (vendor != TPM_CR50_I2C_DID_VID) {
+	if (vendor != TPM_CR50_I2C_DID_VID && vendor != TPM_TI50_I2C_DID_VID) {
 		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
 		tpm_cr50_release_locality(chip, true);
 		return -ENODEV;
 	}
 
-	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+	dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+		 vendor == TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
 		 client->addr, client->irq, vendor >> 16);
-
 	return tpm_chip_register(chip);
 }
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

