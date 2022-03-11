Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693D94D5FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbiCKKiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348061AbiCKKhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:37:50 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11A1C2303;
        Fri, 11 Mar 2022 02:36:48 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bx5so7788588pjb.3;
        Fri, 11 Mar 2022 02:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5o/mAuYLG5IMWgMn70RN2QuqAgncnQ90ZzBLUUh9qxY=;
        b=U+hymCyAhgXFnk8xgy5dLL3KCAvx54rn7nCvaVOWj/nYtimizFEmhkkpu/8buXo0aS
         Vbe2RFJsMXPv7MMARn/HKrGk5NLr3z5w9wlAWH9XOEkbLs+JNeHU2mBK7nY/EszmbtaV
         kdjunWxBCtGGlZNEC8bvzgln6d2oWDtp99bw3BfrwU29TTWqDNGrj7GbQT716Gua5Gbs
         2nq4WiT97EoDMYp3+Nqd9EiATW3agaYnsJrEFn6xr5jsrnw2cyPhsPNrEP0QCC31IP4W
         o6TbPXRQzJmqh2f79PFAg6196P/r6MA4ehlv+KrxRHi0u184yJct9yawW9f87bbA5bg3
         wK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5o/mAuYLG5IMWgMn70RN2QuqAgncnQ90ZzBLUUh9qxY=;
        b=IsA9qTZQpQtaH45bOR7UWTSVPAX93LBlnyRjdSfh5yViAzARxfPwFDAb1/dHnVaOle
         rnYUjNEqRMSKE3+0DbiZhH4/OgF8JZ1i4vrXsfDivBobeoFt0hmNWiMzUD0xzolphw7S
         0Mjcl0BfLwFrZJ05wSInWQ87vG44Hkn2Ot37ZgEX93m2cIDJ58x9ld6w3Aj2WbVGxX1M
         e3VvOIJyR0tg1bO17DyVOg3dod0meIfF7ZmVdlpnp+Y/bSPVDQuijAK3Jj1QVpUuXHFd
         VbY39DKSg32+QIjyf47MbC4kebr/6S4IitWg1+VSW+jEayw4Eq9WmSN31v2yTeDmCfo3
         g83A==
X-Gm-Message-State: AOAM530dQ6+XkSVY0KpnzUdK4O0rrdkoH1DoskFxej6Ve3mzZw4fh/h0
        62L1p1R4Ak1xemp4BXqEzus=
X-Google-Smtp-Source: ABdhPJy4n5APmsURHBqMKuO6Z+RKDvd14uDSkIH1TrNb2AmEaTmBgQbAu3vKKx93EaD0/lkh9wOzNA==
X-Received: by 2002:a17:90b:3a81:b0:1c2:bf38:b57a with SMTP id om1-20020a17090b3a8100b001c2bf38b57amr5321384pjb.172.1646995007856;
        Fri, 11 Mar 2022 02:36:47 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm4445892pgo.6.2022.03.11.02.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:36:47 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM: dts: versatile: Update spi clock name
Date:   Fri, 11 Mar 2022 16:06:34 +0530
Message-Id: <20220311103635.39849-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
References: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
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

SPI clock for pl022 is "sspclk" and meanwhile ARM versatile platform
specify "SSPCLK" as clock name. Even though binding check don't
differentiate the two names, better to keep same convention throughout
i.e sspclk to align with other platforms.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Separate out patches for various platforms
- Rebase to top

 arch/arm/boot/dts/versatile-ab.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 79f7cc241282..a520615f4d8d 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -391,7 +391,7 @@ spi@101f4000 {
 			reg = <0x101f4000 0x1000>;
 			interrupts = <11>;
 			clocks = <&xtal24mhz>, <&pclk>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		fpga {
-- 
2.25.1

