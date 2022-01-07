Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C44E48720C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346145AbiAGFNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiAGFNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:13:42 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32547C0611FD;
        Thu,  6 Jan 2022 21:13:42 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id l11so4896406qke.11;
        Thu, 06 Jan 2022 21:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnX2c/AivJPvE3M4KgpGz9qCvVjWTtRZpCLeFLJb/64=;
        b=jhcH33f2rPJdslRUlsnQb/mI5egx3yjh1XRyMm1WHG3iNkzWWKLPWiwt1LvxANMrm6
         +wuTlRzzaEJAHEnGVYo66bULDqob6E+XP08ruvluHzgCCyA9uaGV6lcQNpSkZcxPmHjC
         laOvrBhyfeqEQW3rMlEiVYEWA49a6HrO+2RoScWGyP0sOK4A41q8iuW009sz8vN6oqNY
         RGc5zybzvtgFd4MxIhYKAWU5RsjqqThBSNxNdHqW4nRrEv/l9re1/JyFT8Mk0t27stSa
         nMZiHyg3qsS44wioLnKqSpvb1w72tzbUvOUzDp/c4Q8rTI47dNCm3BhEASgiYLrmLGpW
         hJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnX2c/AivJPvE3M4KgpGz9qCvVjWTtRZpCLeFLJb/64=;
        b=en8iMBU5x6I+RWr31o4BvDWGruTTp9k2/kUfFkJAD5JZ+xw8g3ZAdm2GF0uLFwUxDQ
         RKFrubZQcs+PMW52ES1QqIDKc615oSqBIBnLGgNvHhO7gZvZNXbzVbBRHSz+BOAd+oR9
         basjNx76PJmQFFuPYSwLgwEPgWjUAHjx7N6IMsg/FnXHB7w7IUL+9bjkvlwTCvuwgEHL
         H/KNn5eMUGujZSqUlr3OgZYFKvn12IZdJ+UIJIA4KojSs+scpRXFNoC0w2SbbPx8APkI
         71X05ZaVJJtBM6uDOHavk4fwojfqLgKW+H4y5bzbujIVQcxfijTpPCKbNrpWlAUuvy/9
         HMeQ==
X-Gm-Message-State: AOAM5333/OTw6X5OMC6H5orjRd5Nu2mOA3pdHiYL4JE/C0dJlhudE4Ig
        8Eyyy6OSwmBIltsJan2S0w4=
X-Google-Smtp-Source: ABdhPJyxvYrqYFDlkIi0IZIQpBfxEsFe8ZBlx2sEOe9KCyROC7cqYGRV1dzISY18pXdzDCCbz24+YA==
X-Received: by 2002:a05:620a:25c8:: with SMTP id y8mr44783504qko.455.1641532421366;
        Thu, 06 Jan 2022 21:13:41 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id d15sm1651461qka.3.2022.01.06.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:13:41 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: rockchip: enable the pine64 touch screen on rockpro64
Date:   Fri,  7 Jan 2022 00:13:35 -0500
Message-Id: <20220107051335.3812535-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107051335.3812535-1-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the touch screen, backlight, and dsi nodes for the Pine64 touch panel
attached to the rockpro64.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 158befb9a48c..f6c36fcd6db3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -26,7 +26,7 @@ backlight: backlight {
 		pwms = <&pwm0 0 1000000 0>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <5>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	clkin_gmac: external-gmac-clock {
@@ -594,7 +594,7 @@ touch: touchscreen@5d {
 		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
 		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
-		status = "disabled";
+		status = "okay";
 	};
 };
 
@@ -633,7 +633,7 @@ &io_domains {
 
 /* enable for pine64 panel display support */
 &mipi_dsi {
-	status = "disabled";
+	status = "okay";
 	clock-master;
 
 	ports {
-- 
2.32.0

