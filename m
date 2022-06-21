Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353AB553DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356329AbiFUVjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355330AbiFUVi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:38:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8311834
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 14:38:27 -0700 (PDT)
Received: from localhost (unknown [188.24.177.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 277BB66016B6;
        Tue, 21 Jun 2022 22:38:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655847506;
        bh=c0/1Nx2+SJOqTxjeNE/IgDqCaF5b6QxFOepQbDtHEBI=;
        h=From:To:Cc:Subject:Date:From;
        b=Ve1YiwYiqWVd5Wun/9g53AmO4CIFM6hUAHcuaNSCEJjGmXn8o2uYT8K3gZuFXCoE5
         reNmP4IiKGX9LSZGB/WOM+pTL1Y4586GGczllQ2T8yMoxyGNa4dkE34N8ac/sEPHi5
         RXcAFd3q3ShQGBrzhXXmM0VXrCWv5t+pxt2fzUsD9Lezofw/OawLN5VVdHkSy7yEvt
         ZPcurHBcRnmKgZSI/Ue9pFgZ/hGLBnmTQFUcMBWpfzyWYycnmtAhtBTQws2CPwDLD0
         E1kqMQWmyV6+F8c0qm4ResWDS/u6yquaXaLf0hwhi66qnfSA9inWEpYHUY5LovRjHA
         GxuB+Pvph1tmg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH] ASoC: cs35l41: Add support for CLSA3541 ACPI device ID
Date:   Wed, 22 Jun 2022 00:38:19 +0300
Message-Id: <20220621213819.262537-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.36.1
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

Add support for the CLSA3541 ACPI device ID used on Valve's Steam Deck.
The driver is fully compatible with the indicated hardware, hence no
additional changes are required.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/codecs/cs35l41-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l41-spi.c b/sound/soc/codecs/cs35l41-spi.c
index 9e19c946a66b..5c8bb24909eb 100644
--- a/sound/soc/codecs/cs35l41-spi.c
+++ b/sound/soc/codecs/cs35l41-spi.c
@@ -74,6 +74,7 @@ MODULE_DEVICE_TABLE(of, cs35l41_of_match);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cs35l41_acpi_match[] = {
 	{ "CSC3541", 0 }, /* Cirrus Logic PnP ID + part ID */
+	{ "CLSA3541", 0 }, /* Cirrus Logic PnP ID + part ID */
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_match);
--
2.36.1
