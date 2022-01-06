Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE744869D5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243019AbiAFS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:26:02 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:41608 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiAFSZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:40 -0500
Received: by mail-oi1-f180.google.com with SMTP id j185so4885433oif.8;
        Thu, 06 Jan 2022 10:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNd0yX/eMqLTp7SQM3Mb8ivKu6Zp4HcxMj8tE/O94/0=;
        b=aczFB4dnGsMt9Y3SGOhxMzZKw7abB7r4tkZrovHq9EKtYswwgLT3iCIeabbyDOZ06c
         oEViA6NWIGjbB3bayBOAYtVVci9bhGD1jnLutschC0p78498ctiISLFcmFHvx+CiMJg9
         hL00SPjgMkHVl1XAdHcAx4QJTLsfsZ7ACd3/pfqBXXJJs4toq21estgOYRFL16nKUc9A
         UXMypVjhMJXLYkHTVMjLR+ahu+ucVz0usQtGcLs5pJ7ElUnDMZ7LgSQXmcmgSbpxrAUK
         6Lfu5i3EBIb9VSN10DzdpFBaGhVyISO18OdiNGIB0kpHmyT47OaVTs51pISN4Gf8/8lC
         3iWw==
X-Gm-Message-State: AOAM533OomQGroLlT87OTT2CkN9iQxSE8enqWmxB7wRu77mWhtSyVm3b
        mSVfY58c/+6suEwrPaEhNg==
X-Google-Smtp-Source: ABdhPJxma2BhQyJhOIcE9VJ4imQvWZ18uqwZtw6d3pT5EmqAKuK+QWuVszmPcgCB3vD+YwhKi4+WGw==
X-Received: by 2002:a05:6808:1914:: with SMTP id bf20mr7192851oib.7.1641493539303;
        Thu, 06 Jan 2022 10:25:39 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:38 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: mediatek,spi-mtk-nor: Fix example 'interrupts' property
Date:   Thu,  6 Jan 2022 12:25:17 -0600
Message-Id: <20220106182518.1435497-9-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A phandle for 'interrupts' value is wrong and should be one or more numbers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml          | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
index 7393f30535df..da43a545614f 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
@@ -72,7 +72,7 @@ examples:
       nor_flash: spi@1100d000 {
         compatible = "mediatek,mt8173-nor";
         reg = <0 0x1100d000 0 0xe0>;
-        interrupts = <&spi_flash_irq>;
+        interrupts = <1>;
         clocks = <&pericfg CLK_PERI_SPI>, <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
         clock-names = "spi", "sf";
         #address-cells = <1>;
@@ -84,4 +84,3 @@ examples:
         };
       };
     };
-
-- 
2.32.0

