Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0275C5AABA5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiIBJky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiIBJkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:40:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2A4B0E2;
        Fri,  2 Sep 2022 02:40:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q9so1492027pgq.6;
        Fri, 02 Sep 2022 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/4LAk3uTqvGQpwYXBuhG1O0peoQCPq2AEefysQGjQRc=;
        b=Z4fnFlP1wtCpjXllLl6jdpM/pCUu9ci9DggZdfkCuauBRFh1Y263ufXYDQZQMANDn8
         kC35C59KmhP5CwnNtONqnPugRozMbRmwARB5UQ2g72YsCIQDKf/RJ6rxDz2nDMJ2b2ZK
         JctO9PRxPUSxgdxSczBQBoxZA3zn5yxq6rEhdy0Kf5q9+tWE09D/hXgrIZ6bTHwMsJmn
         akgZwR75KdWbnZVIM1HSNOGE8KZQMVJLDkAPtWV04keyCXtExq+Y3BtbqngHNOnrZ7yK
         mhPaBmHpJHlYyr+2ap3RaC6ZaFnVaFzMO54KQL5cGkdoNBbSalLRzIvbVAkRZTpIXApa
         B4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/4LAk3uTqvGQpwYXBuhG1O0peoQCPq2AEefysQGjQRc=;
        b=TWObqLmGtJvUsdOLl0Q9j6a7tdxUkiKa/41V7XytkVtnJWUYzupBT6w7sHdEIa50Sf
         AEKQ/WRpjDGgql4Ug4Ny+f0V/dv4pCZrPeoQL1irJlqf0AnxArTIBOwEZDlBupBuoflT
         /k5Hc6TYo0OBqKO524o0rf8Jh5PserZS9zv22zuHYIeZ7lTIzteHq1aEt24P2v2hdgfA
         uOSiEty3mJ7HwEqimSn7aK2rvYbBExYcZeG2WrHFfP47euIacfX3x04787On/H16KEM/
         Uo1Xk83FyO7EXcCQVr620b4zW5FwX8WW+wsLCY+u4NaiWD/zPcsxNgeCjxFfdmI/JS8J
         YqOw==
X-Gm-Message-State: ACgBeo0zlTPuq+iy0v0szDwXkLWFrX03PBW9qyCqn19NMrTGEo2SzW9o
        dsHwatbJv5UHnZlLSh3iEYhTuhsIXsMWXA==
X-Google-Smtp-Source: AA6agR4Y9ZK1wGth99O7SoOfPgUpB07dnpWDUmvla7Hk0xFf9GkZl4lGar44W/B1O9rhiELk/71UvA==
X-Received: by 2002:a63:1726:0:b0:41d:b30:46d4 with SMTP id x38-20020a631726000000b0041d0b3046d4mr29870171pgl.27.1662111639261;
        Fri, 02 Sep 2022 02:40:39 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id z14-20020a655a4e000000b0041d9e78de05sm971855pgs.73.2022.09.02.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:40:39 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v8 3/3] thunderbolt: To extend ASMedia NVM formats.
Date:   Fri,  2 Sep 2022 17:40:10 +0800
Message-Id: <20220902094010.2170-4-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902094010.2170-1-chensiying21@gmail.com>
References: <20220902094010.2170-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch add ASMedia NVM formats.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
v7->v8: Fix the no_nvm_upgrade bit setting on suggestion by Mika.

 drivers/thunderbolt/nvm.c | 40 +++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.c  |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 878d705bd0cb..8393d82dd108 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -12,9 +12,16 @@

 #include "tb.h"

+/* ID of Router */
+#define ROUTER_VENDOR_ID_ASMEDIA 0x174c
+
 /* Switch NVM support */
 #define NVM_CSS		0x10

+/* ASMedia specific NVM offsets */
+#define ASMEDIA_NVM_DATE	0x1c
+#define ASMEDIA_NVM_VERSION	0x28
+
 static DEFINE_IDA(nvm_ida);

 /**
@@ -120,11 +127,43 @@ static int intel_nvm_validate(struct tb_switch *sw)
 	return 0;
 }

+static int asmedia_nvm_version(struct tb_switch *sw)
+{
+	struct tb_nvm *nvm = sw->nvm;
+	u32 val;
+	int ret;
+
+	/* ASMedia get version and date format is xxxxxx.xxxxxx */
+	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	nvm->major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+
+	ret = nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+
+	/*
+	 * Asmedia NVM size fixed on 512K. We currently have no plan
+	 * to increase size in the future.
+	 */
+	nvm->nvm_size = SZ_512K;
+
+	return 0;
+}
+
 static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
 	.read_version = intel_nvm_version,
 	.validate = intel_nvm_validate,
 };

+static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
+	.read_version = asmedia_nvm_version,
+};
+
 struct switch_nvm_vendor {
 	u16 vendor;
 	const struct tb_nvm_vendor_ops *vops;
@@ -133,6 +172,7 @@ struct switch_nvm_vendor {
 static const struct switch_nvm_vendor switch_nvm_vendors[] = {
 	{ PCI_VENDOR_ID_INTEL, &intel_switch_nvm_ops },
 	{ 0x8087, &intel_switch_nvm_ops },
+	{ ROUTER_VENDOR_ID_ASMEDIA, &asmedia_switch_nvm_ops },
 };

 /**
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 9853f6c7e81d..55faa1b5f815 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1417,7 +1417,7 @@ static int tb_start(struct tb *tb)
 	 * mode that is not available so disable firmware upgrade of the
 	 * root switch.
 	 */
-	tb->root_switch->no_nvm_upgrade = true;
+	tb->root_switch->no_nvm_upgrade = !tb_switch_is_usb4(tb->root_switch);
 	/* All USB4 routers support runtime PM */
 	tb->root_switch->rpm = tb_switch_is_usb4(tb->root_switch);

--
2.34.1

