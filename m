Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D9D505F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347896AbiDRU6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243733AbiDRU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:58:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7C4237C4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:33 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q19so21016588pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 13:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xw/vgMNofUgBnVmoZbEauz1tI3WPtVvKx2FohpHzj4E=;
        b=HdT/KW3ntQtQ70sw/QSrfqQEOauDt7wfRW60u38kjHx0VcbPZDEu0ErguTVWyGG8kN
         CD1fdPfvUiuuGvMO0lofZuJ4HOD+swuI0SfXUXNUpfrCRzTZ6Pql+13UUiQXgslnQ+c3
         3ZYlHgv576Gt7p+1vr6r7G0OdTaXKe/1T3of2pmEPwGHyjRkjtI6A0zqGxJN6H4vZgMY
         kMwhn7e7LxTVuVNBSL+HHB+/FEcOBZ9IDhHSNigMmsOYJHnVz5q9dLoJv52tgN+pWoZv
         7t5o9ppZ3Uf7AbnxaLqXpoUGjvAdZhqyRMrQqehkEmeekmxpal8GNJmLfa1eNVsoLHOb
         Z0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw/vgMNofUgBnVmoZbEauz1tI3WPtVvKx2FohpHzj4E=;
        b=zOjUy1vjZFIPec2wVa1mhwGRZM5fxvUUPxtJWjy7epdbDcgMSm4tP8XFRw5TG2BCX4
         kbDb4H4W+uOIErdPv9i/4h0e+1TvjVmxVsXSTeTvLAZStCMuIm+VQ+ETAB26IIj/gzo8
         EcDEABuWFI/ve7+K+bRmczg3T051/lEtDC0uvb7beLdY2lTaYV+76Q9h+IBEvFI/i3io
         A0pd9hHJgFTwHcfiLbLn7k0r6ehydAthC0lCV1e3KZ6a48rYc7eW/e2WBG23pvXHhaUs
         e1xNZBEg+cNij246mHcyXLLpTpTwrTx9N1O7cvrmomktxs6u5KjFJpsojFWXeltsHzzf
         IxEw==
X-Gm-Message-State: AOAM532QA/rWAC4Er5xQS0ZgjK3psMXEpCAcPGvzSoBO4n0HG5mc2QJ6
        dtbkc6f7BKJOHuwx1O7USkCu9A==
X-Google-Smtp-Source: ABdhPJwkboq8ZJahmcGcPyXzVJtjEalb/XDQsZZaBJsDaW8NxYg6dqDu8lEec23LWDaVnX39NogOGg==
X-Received: by 2002:a62:a50a:0:b0:506:cef:44f5 with SMTP id v10-20020a62a50a000000b005060cef44f5mr14154397pfm.22.1650315333072;
        Mon, 18 Apr 2022 13:55:33 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a17c200b001cd567fecaesm13498859pja.26.2022.04.18.13.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:55:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, vkoul@kernel.org,
        bjorn.andersson@linaro.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 3/4] dt-bindings: phy: qcom,qmp: Describe phy@ subnode properly
Date:   Tue, 19 Apr 2022 02:25:08 +0530
Message-Id: <20220418205509.1102109-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
References: <20220418205509.1102109-1-bhupesh.sharma@linaro.org>
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

Currently the qcom,qmp-phy dt-binding doesn't describe
the 'reg' and '#phy-cells' properties for the phy@ subnode.

Fix the same.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml       | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 411c79dbfa15..c553c8ad0d1a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -118,6 +118,19 @@ patternProperties:
       Each device node of QMP phy is required to have as many child nodes as
       the number of lanes the PHY has.
     properties:
+      reg:
+        minItems: 1
+        maxItems: 6
+        items:
+          description: |
+            List of offset and length pairs of register sets for PHY blocks.
+            common block control registers, such as - SW_RESET, START_CTRL.
+            pcs registers, such as - PCS_STATUS, POWER_DOWN_CONTROL,
+            pcs misc registers, such as - PCS_MISC_TYPEC_CTRL.
+
+      "#phy-cells":
+        const: 0
+
       "#clock-cells":
         enum: [ 0, 1, 2 ]
 
-- 
2.35.1

