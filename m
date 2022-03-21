Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7A4E2E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351499AbiCUQyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351465AbiCUQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:53:53 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C01B176D1C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:52:27 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D8A853201F01;
        Mon, 21 Mar 2022 12:52:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 21 Mar 2022 12:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=ESszksCEES65bf
        hqx+u2sQyVlxPEvY4CKlsiAv1DpcI=; b=MnjD+VCawenSZyPsGTG6DQkUoHqoBF
        4K/AhJXs9FTJUM6uCDUaLrC6u/ZGu1fyb+riCwkazbTOYVXolXl1S3qWdb810D+F
        olCUQZjQwDS8CZYPznbMJON+u5/UNOAuG/R2pnJ1PsygpPLPfeGo2EjiXHTxuW9l
        79XHI1mTFoUcGALwcjYTHHS6UaW3m+ZYQiIGrW4Q7dO54K2WIn8mLYVI05L4BQpl
        4RSWWQbSFc43t3HB5tZ0h1J+hYSMcMQ9ZWeH1y5eNXFHLUWytW9rs7JH2Jwe8BBr
        ymrYwwZylrHNZoxqAbLx0r1EhnmWiT6K9D9xIP7KPziZfUgbLiU78iCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ESszks
        CEES65bfhqx+u2sQyVlxPEvY4CKlsiAv1DpcI=; b=i4uZGESsv9zgKKUfYbkePZ
        mbKl67WKeZYpLZ6J64ZibwH4h6TKuD2q8U0BKQdUe+RkzUNtlCjEI7XORqI8ExtS
        a9ctIlDquf4z53UNt1k67Urtj3M5RZjkuqmFQdHvTOfY6uE/rS3qcYhOO4aHZPow
        J2R+/oUhvUEweiniWHMNG3N3rZ9ZFKekNS4HR0UrYOTE4W+GsBgf0y82N17lWTRn
        AfhSYHEBucKSLBqsFHykAUp7iC4RQBSXNJ0+CmR8lzm5/a7G1RPbb2Dd11uC+87f
        +5T3e0w8ZuhCcbn9haMospKkkQrD1YTw2YL/B1yxWkTTI+HFeSpS/nKPR6rTCqGw
        ==
X-ME-Sender: <xms:Sa04YpoQtP8JD_Nzkm5BmD-KxD6wvftItSa2SNNAjZrnNlZJeF51Jw>
    <xme:Sa04YrqJg8j3XUPECNxa4oyJEWsP1dX2axymFjbJfcdBCa6mStmkw4AbO6e6ovhkm
    PJnweHHRv-n8nHDYTA>
X-ME-Received: <xmr:Sa04YmMYl8jwQXdhyK59BWZKHaqI09hYklDQ94JlgV3MKHpJ38EkVq-6s2ZfuMC3szc9fXRRJib4sBzvgsyTVfnSWddiZ3_u94kSEphYYWRj_F2LwiCglDDn9oabs5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudegfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnheptedvkeetleeuffffhfekteetffeggffgveehieelueefvddtueffveevlefhfeej
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Sa04Yk7AZcIWHED8uDSNdGtvSCHhK2FSfx4A-_o4QEbVy_SXBJgo8w>
    <xmx:Sa04Yo65RFj0WUlUsc-pC237o5NlUdBluJ6-i2Ve3--zbYuSxaV-JA>
    <xmx:Sa04YsgxxwfpWgvR09XrHWbfR2YD9VBmmH6nkRWwqB0xqrD-mc45oA>
    <xmx:Sa04Yoy7z88C30C364-vIiczR8zbSFjv8Ik1XU7tgqAMgwQeSIbtPw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Mar 2022 12:52:23 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 8/9] nvme-apple: Add support for multiple power domains
Date:   Mon, 21 Mar 2022 17:50:48 +0100
Message-Id: <20220321165049.35985-9-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220321165049.35985-1-sven@svenpeter.dev>
References: <20220321165049.35985-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

Turns out we really need this, as the APCIE_ST*_SYS domains really do
hard-depend on ANS2, at least on t6000.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvme/host/apple.c | 67 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a4193429564e..d89b4ab80169 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -29,6 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/once.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/soc/apple/rtkit.h>
 #include <linux/soc/apple/sart.h>
 #include <linux/reset.h>
@@ -178,6 +179,10 @@ struct apple_nvme {
 	void __iomem *mmio_coproc;
 	void __iomem *mmio_nvme;
 
+	struct device **pd_dev;
+	struct device_link **pd_link;
+	int pd_count;
+
 	struct apple_sart *sart;
 	struct apple_rtkit *rtk;
 	struct reset_control *reset;
@@ -1313,6 +1318,62 @@ static int apple_nvme_queue_alloc(struct apple_nvme *anv,
 	return 0;
 }
 
+static void apple_nvme_detach_genpd(struct apple_nvme *anv)
+{
+	int i;
+
+	if (anv->pd_count <= 1)
+		return;
+
+	for (i = anv->pd_count - 1; i >= 0; i--) {
+		if (anv->pd_link[i])
+			device_link_del(anv->pd_link[i]);
+		if (!IS_ERR_OR_NULL(anv->pd_dev[i]))
+			dev_pm_domain_detach(anv->pd_dev[i], true);
+	}
+}
+
+static int apple_nvme_attach_genpd(struct apple_nvme *anv)
+{
+	struct device *dev = anv->dev;
+	int i;
+
+	anv->pd_count = of_count_phandle_with_args(dev->of_node,
+						   "power-domains",
+						   "#power-domain-cells");
+	if (anv->pd_count <= 1)
+		return 0;
+
+	anv->pd_dev = devm_kcalloc(dev, anv->pd_count, sizeof(*anv->pd_dev),
+				   GFP_KERNEL);
+	if (!anv->pd_dev)
+		return -ENOMEM;
+
+	anv->pd_link = devm_kcalloc(dev, anv->pd_count, sizeof(*anv->pd_link),
+				    GFP_KERNEL);
+	if (!anv->pd_link)
+		return -ENOMEM;
+
+	for (i = 0; i < anv->pd_count; i++) {
+		anv->pd_dev[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(anv->pd_dev[i])) {
+			apple_nvme_detach_genpd(anv);
+			return PTR_ERR(anv->pd_dev[i]);
+		}
+
+		anv->pd_link[i] = device_link_add(dev, anv->pd_dev[i],
+						  DL_FLAG_STATELESS |
+						  DL_FLAG_PM_RUNTIME |
+						  DL_FLAG_RPM_ACTIVE);
+		if (!anv->pd_link[i]) {
+			apple_nvme_detach_genpd(anv);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int apple_nvme_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1327,6 +1388,10 @@ static int apple_nvme_probe(struct platform_device *pdev)
 	anv->adminq.is_adminq = true;
 	platform_set_drvdata(pdev, anv);
 
+	ret = apple_nvme_attach_genpd(anv);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to attach power domains");
+
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64)))
 		return -ENXIO;
 
@@ -1435,6 +1500,8 @@ static int apple_nvme_remove(struct platform_device *pdev)
 	if (apple_rtkit_is_running(anv->rtk))
 		apple_rtkit_shutdown(anv->rtk);
 
+	apple_nvme_detach_genpd(anv);
+
 	return 0;
 }
 
-- 
2.25.1

