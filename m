Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65F1479167
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238448AbhLQQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 11:24:56 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55852 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLQQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:24:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 98C6E1F47153
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639758295; bh=lxasgzjqebm4cr/bK1kNdQ45q5KLqEPJPyvYbHtTlFQ=;
        h=From:To:Cc:Subject:Date:From;
        b=euyMke+SvnYfzlw2kOqY1FNW/qVCRuXc8fCZytMr9lv8sLexs2XL9Wjo9/Gag9RPG
         +bmx9rP+zQ95khHvZVGRRmuIgVD0okN1G192s8RGwzS2qlON+5KQNdia31eN/Zqq5/
         W3G0FT3lv6w6ZR4pwmr4zi5N6uNR4l2M4JBlGYQE+viM293uTP97louo5jnjiudwlV
         HWFzpfSVHxaFw2CGVE8KgVZMF/YCkZsskSW4p1SxJ7LEX/2wfWfy5lRG1qqHhJA8Fm
         OvYu7b7UygZVxhNA3B0zx9GxgJJWXUq1HdOoePRBicv9jPBKAX0qXn3C2dst4wNvzQ
         ZtjgpS6x7W8cA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH] arm64: defconfig: Enable MT6397 RTC
Date:   Fri, 17 Dec 2021 11:24:45 -0500
Message-Id: <20211217162445.876034-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT6397 RTC is part of the Mediatek MT6397 PMIC, which is present in
the mt8173-elm base board.

The driver for the PMIC is already enabled through CONFIG_MFD_MT6397, so
enable just the driver for the RTC.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f2e2b9bdd702..76bd34223277 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -927,6 +927,7 @@ CONFIG_RTC_DRV_TEGRA=y
 CONFIG_RTC_DRV_SNVS=m
 CONFIG_RTC_DRV_IMX_SC=m
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_MT6397=m
 CONFIG_DMADEVICES=y
 CONFIG_DMA_BCM2835=y
 CONFIG_DMA_SUN6I=m
-- 
2.34.1

