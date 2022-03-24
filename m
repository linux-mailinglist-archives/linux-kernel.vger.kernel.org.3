Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90A24E6393
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350292AbiCXMqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350271AbiCXMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:46:02 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7DC39827
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id m22so4650297pja.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMLkcxx+n1ArS2RqcTBzK629rFDC4Wj9OjjlSjnYeys=;
        b=TokHDTdXWsgf05xnA8MYSVPp7G5Lzf+SJZt0QibiGJOAYLYCIcGmjK1uLCSRNecipc
         ZRwI0W2W8QtfWWYJVRmBCdYL4BKx/3czhJDLsRAj22xBPu2dK/lhTHcR9HAarFkfaoDx
         ARy/sd1AgCWOKhfu2ix0doMBpL212yCzvirB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMLkcxx+n1ArS2RqcTBzK629rFDC4Wj9OjjlSjnYeys=;
        b=2Y1RDkKKySk29jswaWCLeKv/kcl5jUZHSBJEJoFhIx3UA0jAq3bSfIsKSYw8PHzVTa
         ECwBfzpBAX0XLAJWo8FFzl2uCFkaKeab31z3DjCAZ0FiDVZybX82/dv1MaFKIuyj7aPe
         roH5RE8CF6dThYN0AjtsDSLyQ8r1MVZwQRxFNo0fi7a20ZWZM2Axq2zWXVHP64zua/qK
         BQajTYlkWbOsAe0cOvNNMyVXVYoVfKsDBvK4xa9BN4ixPzRqKvWalETe879X0/gctw9H
         MBd9eHmu3ZsKpLbG6xwxgabEH4L4G3uYXIAqb+7Q4ITpZ7vif33H9IzU98gsPSpLP94c
         WgCQ==
X-Gm-Message-State: AOAM533FIZMVkUNtyj42VeLXC0X/ulKY2CixUcNAZBL2U3nK40cpQCm+
        naY2y8QDE3Kc9pQrLU6EVpP4LA==
X-Google-Smtp-Source: ABdhPJxR5oI994cwYDr7DiON56A05ru42hSIYYblDm7LVcmMi8P8kvbt2WLe9fswPW8g+j8z9VdW2g==
X-Received: by 2002:a17:902:c40c:b0:154:837c:5b2 with SMTP id k12-20020a170902c40c00b00154837c05b2mr5779342plk.46.1648125869833;
        Thu, 24 Mar 2022 05:44:29 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id t10-20020a056a00138a00b004fa9c9fda44sm3786924pfg.89.2022.03.24.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:44:29 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        romain.perier@gmail.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/4] ARM: dts: mstar: Switch pm_uart to mstar,msc313-uart
Date:   Thu, 24 Mar 2022 21:44:01 +0900
Message-Id: <20220324124402.3631379-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220324124402.3631379-1-daniel@0x0f.com>
References: <20220324124402.3631379-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UART used in these SoCs is actually a variant of the dw apb uart.
Now there is a compatible string in that driver to handle the quirks
switch the compatible for pm_uart over to mstar,msc313-uart.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index c26ba9b7b6dd..8464a8f1b136 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -175,7 +175,7 @@ gpio: gpio@207800 {
 			};
 
 			pm_uart: uart@221000 {
-				compatible = "ns16550a";
+				compatible = "mstar,msc313-uart", "snps,dw-apb-uart";
 				reg = <0x221000 0x100>;
 				reg-shift = <3>;
 				interrupts-extended = <&intc_irq GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.1

