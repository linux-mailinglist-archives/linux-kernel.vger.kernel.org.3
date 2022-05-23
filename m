Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55F530B60
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiEWIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiEWIWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:22:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AD2314A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:22:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id a13so1912431plh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+44BSSlN1XE65CChHOFpA2+bmaSayBXAi8yg7sU14k=;
        b=Q2TUZwWb3O8USHfgIO9tS+qDCKQ4aHCFf5zVdpZ4kZL/ae6pcScOhVImdn+XIsDcvj
         kF8PDjhYBd9Ql4uU/PgJb0rtPsN5CZTjI/FBvXaDrgt1BSctQlerLchZPIZ0UIVfPvWW
         gEK/YC/JXT+hRjEiaupO7Dk9pghVmeLndrcGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+44BSSlN1XE65CChHOFpA2+bmaSayBXAi8yg7sU14k=;
        b=T2aGcTjrZ56dnLRhYr1aUZaVlAtuEf1sb2q1PpCecARS97leJKG59TzSR448oaWwmO
         ao1vPScnvuXqWxUZRh+hYVfxveGLBYuIxRxIZLnux2DAYjugQ5rnUvhA/PHbsJJsPuxf
         w2Pr8MpGPOhhxmBBbAOME0mDeUhr4kENEa+I8qTOGJcpXm5jSp5nzMGvduqa9eCpmDL5
         nGuPFqHIzpRtTbqpI1VdUY2MscWzLjFYF1mE2+nbuo8VaZR0kvUP7Q2E9mNCcJf1i21O
         HG7KgZHVyZuaX37lTxpucBEuQ20uGwWR01BGtTOoleC/QUt4UEmT5mzXWAVloylcNhb/
         ewFQ==
X-Gm-Message-State: AOAM533rJl3EM6MCAK1uHBfmsfEs8ipP9Mxy8+soYA7ccAixLpzeK69Y
        Mxkf7AkGB5LXSxHc/kdqNs2MMA==
X-Google-Smtp-Source: ABdhPJzHXp4n75/dUnjS1z28pKIVVr4s/o0CZ70SogSxK0Bf83YapNMXVetV8ByWrj7BP/CYF/FRBQ==
X-Received: by 2002:a17:90b:1808:b0:1e0:4dbc:8781 with SMTP id lw8-20020a17090b180800b001e04dbc8781mr4230775pjb.58.1653294169493;
        Mon, 23 May 2022 01:22:49 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:1547:329:6bd:3965])
        by smtp.gmail.com with ESMTPSA id t13-20020a63b24d000000b003fa321e9463sm2277982pgo.58.2022.05.23.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 01:22:48 -0700 (PDT)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Pin-Yen Lin <treapking@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2] arm64: dts: mt8173: Fix elm panel DT node
Date:   Mon, 23 May 2022 16:22:39 +0800
Message-Id: <20220523162235.v2.1.I8f6449d46305a0e89845cf191e10c042736a1688@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the panel DT node under `aux-bus` node so it won't use the buggy
`ps8640_bridge_get_edid` to get display modes. Also change the
compatible string to "edp-panel" because the predefined
`lg_lp129qe_mode` is not working.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
---

Changes in v2:
- Remove the Fixes tag because this change is not compatible with the
  old kernel versions.

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 26 +++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index 9c75fbb31f98..1e0802a6f6d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -90,18 +90,6 @@ volume_up {
 		};
 	};
 
-	panel: panel {
-		compatible = "lg,lp120up1";
-		power-supply = <&panel_fixed_3v3>;
-		backlight = <&backlight>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&ps8640_out>;
-			};
-		};
-	};
-
 	panel_fixed_3v3: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "PANEL_3V3";
@@ -282,6 +270,20 @@ ps8640_out: endpoint {
 				};
 			};
 		};
+
+		aux-bus {
+			panel {
+				compatible = "edp-panel";
+				power-supply = <&panel_fixed_3v3>;
+				backlight = <&backlight>;
+
+				port {
+					panel_in: endpoint {
+						remote-endpoint = <&ps8640_out>;
+					};
+				};
+			};
+		};
 	};
 };
 
-- 
2.36.1.124.g0e6072fb45-goog

