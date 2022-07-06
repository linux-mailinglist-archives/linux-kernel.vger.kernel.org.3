Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D395684BC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiGFKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiGFKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:06:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AF3252A8;
        Wed,  6 Jul 2022 03:06:56 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E2ABB66019A8;
        Wed,  6 Jul 2022 11:06:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102015;
        bh=0Mp3rHQ9jijT39OI8RMdTMOQmr91ofvOGZwnNCt8nFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPV0/Vu5urmVm10fjiVkxWNBk/0R8QlN3aAu3/LZgk11NcgE7NKzaBpEgmL9LcpKb
         pglVu3Byg2MM5/KPTGnLa9Z4NqvcycglVpMzJNE4zA5eYZY8LvM5O716GmjW3+WC3G
         5by7/lromGDL7IFm5YfJUYnlIDlXDeRkgStD/k4D2zpmuET1hqbczHJIvZ/+6W0mt9
         x51WtQjxU2KKh64ZeKcgBLoacWgB7BydFaRh6fa2nadHwK+uSnq6F6dr2K28jcXKiO
         3YEShPZATRepJICflZvkgJ5sRdItZ7krewEo0e9Lto5blWiI7RAlgjOiFXq+fvDJcT
         3Gf4W04moraSw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Anastasios Vacharakis <vacharakis@o2mail.de>,
        cristian.ciocaltea@collabora.com
Subject: [PATCH 5/5] spi: amd: Add struct and enum kernel-doc comments
Date:   Wed,  6 Jul 2022 13:06:26 +0300
Message-Id: <20220706100626.1234731-6-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
References: <20220706100626.1234731-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide documentation comments in the kernel-doc format
for enum amd_spi_versions and struct amd_spi.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/spi/spi-amd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 6eddb950e1ad..08df4f8d0531 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -40,11 +40,21 @@
 #define AMD_SPI_XFER_TX		1
 #define AMD_SPI_XFER_RX		2
 
+/**
+ * enum amd_spi_versions - SPI controller versions
+ * @AMD_SPI_V1:		AMDI0061 hardware version
+ * @AMD_SPI_V2:		AMDI0062 hardware version
+ */
 enum amd_spi_versions {
-	AMD_SPI_V1 = 1,	/* AMDI0061 */
-	AMD_SPI_V2,	/* AMDI0062 */
+	AMD_SPI_V1 = 1,
+	AMD_SPI_V2,
 };
 
+/**
+ * struct amd_spi - SPI driver instance
+ * @io_remap_addr:	Start address of the SPI controller registers
+ * @version:		SPI controller hardware version
+ */
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	enum amd_spi_versions version;
-- 
2.36.1

