Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222DB4F0424
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356731AbiDBOjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356627AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984A11834C3;
        Sat,  2 Apr 2022 07:36:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so4264419ejd.9;
        Sat, 02 Apr 2022 07:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzmU0Dp6HwdkT8Z3OuirJmjfQNObHAqgJgTjMG47n0A=;
        b=aAJvmM6ItjEgWTXZGaCViiqDWjBz6+wHVzQdkA8YZcefaus3pcCVmi4hu/yGogWBMw
         NsOpU0o/vLInsxt50G/p7LyhyeTXAyCL7VE5KLYddZ+YFOjMgt6uENIlXUmDioFAATtU
         /oA6PV3nNuyQpf2qD8dO0hTlLwIoi6Gve0sFXpZf1B50xqKSFG3h/INH4EU9+EuSRTYw
         MNRtw5w0g7/FhQL5TS133sS7PxJsG7+NDwKAbTMuv8l9fSdLyeoLUd0hiyZvJTdooMre
         CuaQjr41QjhVOcQuxc7cVKqRgt+zisakKkkqHQtyVjK/lQV8iFZnnhGVgxLBuDNqAJEc
         zLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzmU0Dp6HwdkT8Z3OuirJmjfQNObHAqgJgTjMG47n0A=;
        b=mj7hCngPSdL070cgFGJZWtfcNtDLlKG/8XZdVeCrr5cb02485D4IIoIx0NAiH5Z5qB
         uC5VTwrHd/cECaxu2SHrQYmPhkOZAwGPgh9p1Aj43jUSCneAy9oiUYM6q5+ndBwgsmSS
         +rtTgRp9r2t5Szz90eh6UvH+S0k5JkLNNDJLaNUDeI3w4CP8fAiGYn9WDjFu3+UjVOll
         q9D3Gb+nlxiehGVprKiIOulS7m8Qn32oXR635Y2UcUnjpD5JAquYxZqByapu5br7Nl6J
         Kt3a226+xZOxtwVGoz1TK60mBXT2t2Zqcmq08uZTW2jo/0EYA3f/EeAQVAWul5GNqq9K
         NBnQ==
X-Gm-Message-State: AOAM531+12eIcy6Pd6fwk1+2tvzYt/h3l6WWKfu08JUvdcA+PtsW0vgV
        HuAypTJ3hwpDw8B3iTPwrDE=
X-Google-Smtp-Source: ABdhPJy5vDCSDA33e1YaTBNZjVAxvQmIg2J1e3ERyi0Y8CcCnlsMLUqoBKYkj1aRKQ+EF8csYeOy3A==
X-Received: by 2002:a17:906:3918:b0:6e0:5bbd:bf33 with SMTP id f24-20020a170906391800b006e05bbdbf33mr3920592eje.764.1648910217228;
        Sat, 02 Apr 2022 07:36:57 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:56 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/16] dt-bindings: clock: use generic node name for pmucru example in rockchip,rk3399-cru.yaml
Date:   Sat,  2 Apr 2022 16:36:35 +0200
Message-Id: <20220402143636.15222-16-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names should be generic, so fix this for the pmucru node example
in the rockchip,rk3399-cru.yaml file and rename it to "clock-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
index 5ee686938..e91147c84 100644
--- a/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
+++ b/Documentation/devicetree/bindings/clock/rockchip,rk3399-cru.yaml
@@ -77,7 +77,7 @@ additionalProperties: false
 
 examples:
   - |
-    pmucru: pmu-clock-controller@ff750000 {
+    pmucru: clock-controller@ff750000 {
       compatible = "rockchip,rk3399-pmucru";
       reg = <0xff750000 0x1000>;
       #clock-cells = <1>;
-- 
2.20.1

