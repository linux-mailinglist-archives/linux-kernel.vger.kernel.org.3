Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DB6535492
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbiEZUiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbiEZUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:38:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154375A5B8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:02 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id f21so5023897ejh.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJhc1mTxQ3QecQnzHGouGfH+Ej90dYE0LGaajUy8Apw=;
        b=uiaFKSXxIGbdrU2GegXIqFhYHTBQl00Bj09Dpe5qx7XEzmarRuR4bgTIiZcO1Tb78y
         IjZhTvse19YdWDBRZX3UdREoLS5KcK5HSQQlzWkW7q2Ntbl57IjxeO3EditIt4Cu7jLn
         fM1Txe5w8rZ3YzaYWN3mvLtqnFR5Dx/qWb2sn/UhKJ9bOPmv9jnNzDeVjcQLfePGkYQl
         Xjo7eaeQ+nhoUZqFwEl5DBW5ZeZww6rWv867e8BdiFEbkodDkvsV5wb2sUAnKpNws34A
         bgEKWYiB55hOIz38IYPBq/V0xEjvbdNHkBS2IrB3mwkdQLSS/53KMNYpfylAkW14JlNj
         YhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QJhc1mTxQ3QecQnzHGouGfH+Ej90dYE0LGaajUy8Apw=;
        b=Y04qliXiOmMJ3GV1hu4DA4V8i3gtss0YEY5aAkgGJZ+Rx1pPci2RToacivEyAUwT+Z
         1HjbW4oCLFy71G3Bm3y3tZLg/WNux3ly6Bi3j70zqSEasNBplM8JPdNWU5kIOle613Iz
         TUMHJYgP+3vkPqvY4+icq17iKTUK0PagNVab1MXnFrmFQ9/k934dUHofo2sVt2lA8Rtj
         PMtWdqyVgX8Hoqk0pYrghKpY/+c2bqQbrv+0Ww7faY55+O/0378MVcKqBJ2K2UyNOMel
         1Io/8301074pWRBB8VgATQHl030X740oCbVGS6Z18Ug98z3mFtbhiLR7LS+Mk2oqqUrZ
         IBbQ==
X-Gm-Message-State: AOAM533X3hWHJMaL1voRMv6t0zy7Sbv1RPUg01CwH2Esya/LBagqbSQr
        3W2BewS54X41U49G3H0SG+u6eQ==
X-Google-Smtp-Source: ABdhPJwZZAaiXc9uQE2koBnbYin8GLwTlYJhIRWvb1Cu1PatIOvnAgDe7czOEGMB7VIIb30zWQrgPA==
X-Received: by 2002:a17:907:3f0d:b0:6ff:43e:bb1a with SMTP id hq13-20020a1709073f0d00b006ff043ebb1amr13600232ejc.52.1653597480679;
        Thu, 26 May 2022 13:38:00 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b16-20020a50b410000000b0042b5cf75d6esm1160381edh.97.2022.05.26.13.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:38:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: ecx: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:37:58 +0200
Message-Id: <20220526203758.831301-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm/boot/dts/ecx-common.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ecx-common.dtsi b/arch/arm/boot/dts/ecx-common.dtsi
index 57a028a69373..ce5221c6b358 100644
--- a/arch/arm/boot/dts/ecx-common.dtsi
+++ b/arch/arm/boot/dts/ecx-common.dtsi
@@ -9,11 +9,11 @@ chosen {
 	};
 
 	psci {
-		compatible	= "arm,psci";
-		method		= "smc";
-		cpu_suspend	= <0x84000002>;
-		cpu_off		= <0x84000004>;
-		cpu_on		= <0x84000006>;
+		compatible = "arm,psci";
+		method = "smc";
+		cpu_suspend = <0x84000002>;
+		cpu_off = <0x84000004>;
+		cpu_on = <0x84000006>;
 	};
 
 	soc {
-- 
2.34.1

