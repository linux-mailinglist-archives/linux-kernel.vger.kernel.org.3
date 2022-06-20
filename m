Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132BA5517D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiFTLz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiFTLzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:55:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4337F26DC;
        Mon, 20 Jun 2022 04:55:54 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p6-20020a05600c1d8600b0039c630b8d96so6360971wms.1;
        Mon, 20 Jun 2022 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am5xMYkn5ju4qtsoURmMkGdCrSP1fkjrG6XDnZXvhTc=;
        b=VdYcvoBGG1Q2lTNzlHp6tzbLLJNX5oS+z/1p2Zt0Nj+ejsttBBerQz5mxvfQ6AnDtH
         IhFQxGn9GJqWCJa+Htk6udZJYlSRIH1MMi6/TxngTM1pKOZuFvvEd8uMwh5+PFZvCR1D
         aALEDY3xwe52AfcJuLagSaZmWoebbrsxrFEURMs6MFRo7loJsIoq5qCgMXAc3PHf/J5C
         d2beVXXrWlvP/N6uiUxH32vgPE39fH3UDoHI0CROLQopgg62CHsXp2r4h8W6MrDe0yiu
         /tb9x7KNtVfnWYIFAe6DkFhluxxCjP4aY4gwolrSSjWern3ECK3jlLlwZSuO2eF8nVHP
         ykNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Am5xMYkn5ju4qtsoURmMkGdCrSP1fkjrG6XDnZXvhTc=;
        b=wM0EM/FrXng8oYUnd1oy3fG5VJdY4Cz9fKkoIAXo9DTET+Y5H58IMrJ1FyWxZfxmem
         qozA608tpCMftJHHRHPHq/CzNhKJjVjYGheso8+1HA+lCIEJf3uxW51pGjAmd5WrRLCv
         PQdmV3YW3vC34gW9pc0feEk+ktfohkeUtuk7B/le/VVc77WKU4dWdjhR08Uq5nH1oRQv
         L9NAiKmybqhRT16tY640AZiukVrHmYdhQ/L30K7rEfpcSZJAufkXatuyYF+NK10rsHPO
         D2LlcV35hiU2lX+IPixKDFSwbzI5yuKg3TLmcO+WsDuL9j+IGVQ7IVvSUKo/9w0FBRfq
         NxgQ==
X-Gm-Message-State: AOAM530LZ7aULrm+12O9/+RIvld+xOAr0M5cJkm8hDYiY4DYKmsuVaMy
        Z5m6TaSoydLk8KgTNTo1o2c=
X-Google-Smtp-Source: ABdhPJw3A6VGbMslJyKdy4iTFNkB/vUldHGTrHqLm/EmQLv7HlTnujXGficGtspKXibONcod6llshA==
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id j6-20020a05600c190600b0039c7f823090mr34741869wmq.152.1655726151676;
        Mon, 20 Jun 2022 04:55:51 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c4f4f00b0039748be12dbsm19816862wmq.47.2022.06.20.04.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:55:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] MIPS: PCI: Remove leading space in info message, rename pci
Date:   Mon, 20 Jun 2022 12:55:49 +0100
Message-Id: <20220620115549.39177-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an info message with an extraneous leading space. Remove it.
Also rename pci to PCI.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: make pci uppercase
---
 arch/mips/pci/fixup-lemote2f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/pci/fixup-lemote2f.c b/arch/mips/pci/fixup-lemote2f.c
index 632ff2daa338..790d674cd80a 100644
--- a/arch/mips/pci/fixup-lemote2f.c
+++ b/arch/mips/pci/fixup-lemote2f.c
@@ -80,7 +80,7 @@ int pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 		}
 		return dev->irq;
 	} else {
-		printk(KERN_INFO " strange pci slot number.\n");
+		printk(KERN_INFO "strange PCI slot number.\n");
 		return 0;
 	}
 }
-- 
2.35.3

