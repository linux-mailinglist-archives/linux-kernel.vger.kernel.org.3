Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBBD48F63D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 11:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiAOKFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 05:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiAOKFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 05:05:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F2C06161C
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 02:05:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso12038428wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 02:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnbSOHZabpTh0sjxu952a7mwBfFZ+I27XVWWNUBKhcc=;
        b=UAXx7nHy4OHwH37ElrRhVy9WBbIXadGWmR2ZFZm199AmRBfOnGcviFLmwzhZtNqWt5
         DrZyylV4Zgq+n4wEMAe6U2aoZe3z1vBSzpDvTI+5IwfDX/Ft+4EZspcRpgdCg83Kyi3T
         uI+dpXPF1sYJfdCkLXiPu9xzPXaBuE/EzT/Vqo/di9au26EaAiLNf71Cv+t3aS2l8o0t
         hMrckVwgGOQUHqpwBAP3x3eRuWpR6h0isCaE/7BcRGJs6Bq4dyfxQ0rvF65QbugG7G6f
         U+/wJTinXW7lZU9fTZq1G9O+YsPhuKyau7/wB9c25kSEBZVqRdy2w6ZvEEOqu67o/9I8
         i/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NnbSOHZabpTh0sjxu952a7mwBfFZ+I27XVWWNUBKhcc=;
        b=OHQ1uZdSiTBZhbsBoLbjmidYbQLt6CuoYsiSfKDgOdxfiTgWJDIeCwRsvaQLdqN7gz
         qejQC/EF5s10Z92VDKh02QVS/OqVP21Mt0OEQOlxzEyBWVG04ICBodrMFBASCX30D8Tj
         RZK2PxH/dzNecjvP+ptHXSa92D1BjarULJ2ZU507/uQ/N+ysDSzKzH6t0Gqt49UlCKpS
         sa0klngXw9esSJ0pu9i5+FYQjhmBufErf0KNUM57YpR7Cnd7fbRH1JE0jX7lJV8bGGtC
         O8/Js0gA94drwcVXFdNUfXO5MKKpQcqgAlmSQvCUEUN4izVKt4pkSwXtB+6EGfpcxJfV
         DynQ==
X-Gm-Message-State: AOAM533kNc2QnP6Uh2sFaaXHCEHgaH6+B/O/mwpTO+TX83PmFGb+6+1M
        oS28iV8EnetKyaApkt2DWjwZAQ==
X-Google-Smtp-Source: ABdhPJyXV18x1rvLhfkIOIqMPDeNofot0UMca38/deDL4nXSi9BbfoF6NvgOmV7P7anBg+zWFHZsrw==
X-Received: by 2002:adf:ed51:: with SMTP id u17mr9592004wro.104.1642241099104;
        Sat, 15 Jan 2022 02:04:59 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n8sm9110356wri.47.2022.01.15.02.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 02:04:58 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] ARM: dts: gemini: ns2502: permit to use gigabit
Date:   Sat, 15 Jan 2022 10:04:43 +0000
Message-Id: <20220115100444.3014823-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believed that gigabit was not working due to some unknown missing GPIO.
In fact, gigabit worked when REALTEK_PHY was compiled out.
So the problem was due to PHY delay and we need to use rgmii-id.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm/boot/dts/gemini-ns2502.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/gemini-ns2502.dts b/arch/arm/boot/dts/gemini-ns2502.dts
index 37e5debb693c..c759c4c732ab 100644
--- a/arch/arm/boot/dts/gemini-ns2502.dts
+++ b/arch/arm/boot/dts/gemini-ns2502.dts
@@ -39,10 +39,6 @@ mdio0: mdio {
 		phy0: ethernet-phy@1 {
 			reg = <1>;
 			device_type = "ethernet-phy";
-			/* We lack the knowledge of necessary GPIO to achieve
-			 * Gigabit
-			 */
-			max-speed = <100>;
 		};
 	};
 };
@@ -50,7 +46,7 @@ phy0: ethernet-phy@1 {
 &ethernet {
 	status = "okay";
 	ethernet-port@0 {
-		phy-mode = "rgmii";
+		phy-mode = "rgmii-id";
 		phy-handle = <&phy0>;
 		mac-address = [00 1F 1F 8E 65 E2];
 	};
-- 
2.34.1

