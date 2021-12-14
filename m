Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2294748EE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhLNRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhLNRJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:09:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3045C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:09:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so33596196wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkNwF15RBseK9khy85vK87nkOiqoYCbtsYE+4WPYdvA=;
        b=LTEzOvDI5uiHwEiGffXqMAPXC/qxrYBIePgNS+zO4BuZZJoih2CLutVL6PSvWMj60L
         vjLZ6cTrjy0hVB4Yz1bCdMUIJbHUaLERH0ur2mB+VPsWpCRTsvgIrnXlBCEkkjCL0tKH
         XYhXNDo7hps8alzZ5XcGWpKBrzJcXn/h0YwhuxTWD3LHYAwGx5exBeC6jmkZE37QbOnG
         mu/vF03AqiDVFu8viIGHzmHARKrNUE/q15p6XZuikX8osgK6T/M3a00AIQGXWG5Rln70
         045iiCLfU9wrmae6FJYFa/efVPq9xk6JHaPPCaU8jREJMqENUbEOV4DMgRLe0VXY9TMO
         nZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkNwF15RBseK9khy85vK87nkOiqoYCbtsYE+4WPYdvA=;
        b=ketV3YyzBEJ5JUHhJ2jbgX2NNrO2LkZZyyNy1WRZYdSHpNUA56X9uZ4qtRt0gV10jz
         Kc8q8sLyPoaLs57O/szQDESkcXpvz5Jy4+Y0lPRVUEV2pB9ubyG3XnBfRftngFSYSyRf
         6eLcty6lKbXVO5Iu+En1vk2AjxMPI7NtGutPMu+NWcXNtua32E0DIasPOBBDTS6obVY0
         AlFaPn19PXVeCs2E01EAk2c2ljvUTeR0pnsXJPFT9/MjEq/LssqT9GHRvyDZGRxHk0SC
         W3uh6Tb388PeWlQJUV7Is2h5n9Eu6YFXWkveEkvewy725BTtn/4/h/Wv6IwJY5W5qkC5
         ltEQ==
X-Gm-Message-State: AOAM533JHashg/9QHLVcjROJQXTd8Rac181sC+0gHidRNtl2Ovlu5IWq
        8FLrLCuKddRy/pZaNGVKNIMUHg==
X-Google-Smtp-Source: ABdhPJwbbeKRaevdBJwM/1/TG57QVdufp3g79ECOj1YGEP4RB0Zi9h9idiAqsU4q8JdHgtx24vAXCg==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr252850wrt.672.1639501766313;
        Tue, 14 Dec 2021 09:09:26 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id y6sm2688224wma.37.2021.12.14.09.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:09:25 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: samsung: Fix I2C clocks order in USI binding example
Date:   Tue, 14 Dec 2021 19:09:24 +0200
Message-Id: <20211214170924.27998-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that HSI2C binding [1] is converted to dt-schema format, it reveals
incorrect HSI2C clocks order in USI binding example:

    .../exynos-usi.example.dt.yaml:
    i2c@13820000: clock-names:0: 'hsi2c' was expected
    From schema: .../i2c-exynos5.yaml

    .../exynos-usi.example.dt.yaml:
    i2c@13820000: clock-names:1: 'hsi2c_pclk' was expected
    From schema: .../i2c-exynos5.yaml

Change HSI2C clock order in USI binding example to satisfy HSI2C binding
requirements and fix above warnings.

[1] Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
NOTE: If possible, it can be squashed into "dt-bindings: soc: samsung:
      Add Exynos USI bindings" patch (already applied in Krzysztof tree)

 Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
index 0af4821fae5e..273f2d95a043 100644
--- a/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
+++ b/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml
@@ -152,8 +152,8 @@ examples:
             interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
             #address-cells = <1>;
             #size-cells = <0>;
-            clocks = <&cmu_peri 32>, <&cmu_peri 31>;
-            clock-names = "hsi2c_pclk", "hsi2c";
+            clocks = <&cmu_peri 31>, <&cmu_peri 32>;
+            clock-names = "hsi2c", "hsi2c_pclk";
             status = "disabled";
         };
     };
-- 
2.30.2

