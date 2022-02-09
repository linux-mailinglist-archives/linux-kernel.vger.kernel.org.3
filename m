Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3AB4AF751
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiBIQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbiBIQ5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:57:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0889C05CB88;
        Wed,  9 Feb 2022 08:57:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id D282F1F44C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644425876;
        bh=3ww5JixqnqYDOM7TsH5CYSgQoLb3Ym1w7KoXmSWaMCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSpkmtjT830CKj9RrPFrf0K15b4gX6nkX8sFFfjI6/UbCBgrRz+20bubSZG+d29Tn
         +NNkGRm88bI7A20qLlsqNjYexiKGCNWa3mPvoweHlnrr63A+pa8yu96lybubLwdf2N
         bXnxT3BeTDTimOCBKQzYAgBflzxH3iOptt/vV6bopFSiFulsgieag/FZmQ4b+OTNIK
         2NLDErkJC6VvX60cvLnDZeClTJdoZdXzNY51K1p7O1WMPMHS2kk+h8JR9Ry/sqtPnd
         0CWu60WiimxRE9YUuMKgZOsJQZ3nYYeQsFNzoXzl6ZgoIVwNCV9wj8DYNec7Jt+hKk
         HBSSveFmLZTUg==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/3] spi: amd: Remove needless rom_addr variable
Date:   Wed,  9 Feb 2022 13:57:32 -0300
Message-Id: <20220209165733.43134-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220209165733.43134-1-andrealmeid@collabora.com>
References: <20220209165733.43134-1-andrealmeid@collabora.com>
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
2.35.0

