Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825D2563457
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGAN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGAN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:27:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C15675AD;
        Fri,  1 Jul 2022 06:27:20 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so1573611wmb.5;
        Fri, 01 Jul 2022 06:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiEsJL8yTGRaR6BypYru3DcmE6Hz88byGdoQrU5Jb64=;
        b=V9IFoOhb7HIcFf+VkX1WVn344401WuIlqq39BjlIME9VHDg6iaFH9OgPYbcH8B+mIn
         9mGoFE+Qi+0fvPdBQdHRafJ4MrmCo4oNMFrlYBHiFWXzIDMz9ClDO4jupwghv3Vdtkdp
         tiXy0VayfPt1JpUNfDRjvuLAJyvg6cOASGqGdlcvgTlEkPiJmABBs9CB2bwW5JaEaoXo
         dNoXFP5Jk4g5oxRnqWqf7JvFbbkn5uwrhOCyCftcVHTkDMwzhCHETLtNeWuL4E7m+ERD
         WvAuoCaoumPz+4FV/bVw1u8u+o+M1Ltcx8ABtceYkAXwMDdmfW6nMAlXHtGn9S5vRXln
         rpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PiEsJL8yTGRaR6BypYru3DcmE6Hz88byGdoQrU5Jb64=;
        b=tdmlVXLMYw8NSvF1TpnHYayMN4anlFHLUrVKIbLDBgIMOkURDpMsSMxOb2bqO/0bns
         wjipf/1UUEIL7FM8Dh/oLRal4pRKfdQVbntMkYzIr0Q86DMIFyxzoxlgeH8nW04cdXaj
         Z24PPw2A08yGGpSv7tKovsWIG1et/mXAKBk3XfM5v8RqO9x65pEwMj8WK95sagZhsQ7W
         10K0tr4rjN62FXRKY7XMIw7ckJ1dTBIfEFAah+w6d3kVYve8ZLZ/CyTpkz6zYPsuMnZp
         7EYKAAdCo7hECl2L4bdPjWi+0jsWg0flKXS5KWsqcchnDRNsFT66nZiQjxa+JBeorbFA
         iSUw==
X-Gm-Message-State: AJIora8Hov+QraZVy4vQ27/TR9p0GmZimIwpByinhdnHWifSduVdd1aF
        frMvt5X97Ro84kBGAcmzAk9YFqFq8Pee9Q==
X-Google-Smtp-Source: AGRyM1ubbohkRaNFj0nCZBBQzaIgjbfDgLDsV2OMNwfUG7xx4VNrgdDYLuGd1w4Fdyc8li/2GAfW8g==
X-Received: by 2002:a05:600c:1c27:b0:3a0:5098:c8b6 with SMTP id j39-20020a05600c1c2700b003a05098c8b6mr16904060wms.69.1656682038490;
        Fri, 01 Jul 2022 06:27:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c269200b003a03a8475bfsm6186456wmt.16.2022.07.01.06.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 06:27:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: Fix repeated use of "the the" in Kconfig
Date:   Fri,  1 Jul 2022 14:27:17 +0100
Message-Id: <20220701132717.365238-1-colin.i.king@gmail.com>
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

Fix use of "the the" in the Kconfig, replace with "the" and reformat
the text.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mailbox/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..15ecbede3128 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -66,10 +66,10 @@ config ARMADA_37XX_RWTM_MBOX
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
-	  Mailbox implementation for communication with the the firmware
-	  running on the Cortex-M3 rWTM secure processor of the Armada 37xx
-	  SOC. Say Y here if you are building for such a device (for example
-	  the Turris Mox router).
+	  Mailbox implementation for communication with the firmware running
+	  on the Cortex-M3 rWTM secure processor of the Armada 37xx SOC. Say
+	  Y here if you are building for such a device (for example the
+	  Turris Mox router).
 
 config OMAP2PLUS_MBOX
 	tristate "OMAP2+ Mailbox framework support"
-- 
2.35.3

