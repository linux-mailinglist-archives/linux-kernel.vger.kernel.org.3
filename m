Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D3D4B8926
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiBPNSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:18:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiBPNRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:17:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCC28BF08;
        Wed, 16 Feb 2022 05:17:09 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 5B6CA1F42FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645017428;
        bh=wPRTwrW/9oXdUtF4klWrI7xTAnY4zRIdsMlSu1afU9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSwZmizvpbkhvyMHkmKvDRzV8xUnKQKDuVmJ2udmyRmScrBGucEWPpnpF/jG4rE4u
         nsrWi86Bsc6wMt5tKaP5OWItgrlxWQ21eqS2wgcs+5mCzQWzwq2v5fTWDFTYe3a7E6
         d9gTcfA78a32MzY4iK0HQ8a96pKxRl0KeYwRJuvHfUwWWPL4D1sPJwWD0P4J0xQV7D
         AG5ezVhseHhvstdcITvXV3N3Cn0ON6o5S1qA2r3baFKjqMK1zBN5/OaMpDiqpuJz/I
         YJJLxVB9g9vu3403/Fx5vZ0R77G8zLKQ/94GHYeLoC7PBTUWD0+fKO5bluWM3wlfR8
         ODyHq1cQl/Iqw==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 2/3] spi: amd: Remove needless rom_addr variable
Date:   Wed, 16 Feb 2022 10:16:37 -0300
Message-Id: <20220216131638.65472-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216131638.65472-1-andrealmeid@collabora.com>
References: <20220216131638.65472-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rom_addr is not used in the code, so we can just drop it from struct
amd_spi.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 drivers/spi/spi-amd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 899b8d90ff61..417ce14a21c6 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -38,7 +38,6 @@
 struct amd_spi {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
-	u32 rom_addr;
 };
 
 static inline u8 amd_spi_readreg8(struct amd_spi *amd_spi, int idx)
-- 
2.35.1

