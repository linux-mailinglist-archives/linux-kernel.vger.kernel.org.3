Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA1653A659
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353424AbiFANwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347954AbiFANwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:52:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE933345
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:52:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q1so3899669ejz.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ek6pdeO0DB1Tm5mlcz1RuofuiBWoeBBusgfA8BxgA/s=;
        b=LSkJbr+iy1alMRbMgu9/LZ3vGR3Qm7OChQM2qhsH3NtSJQCjaH28qtAAURfD9sOCho
         EqmRJ3OazVa8XsRrtzqhYMl6MKqExGjA+TQrDZ+LXWp9byAJyO55kMxZaRFgjBTPZQ4W
         N1ma8mXg+0eEKdpXyBxjA+2/KcXLpXliIQ/cxFHpWqo32slgmTrvVLegolg1csZL/hYw
         gwgixwTCwQRUKJLviwktNacbTv6kocTGdcZjOdi9R+xDxvokD2xd98fdjkDhsQDg0u+E
         UgGTgdkLZQYCfo0ffxTO7atN0rpVvpNw9CvsZlumWxc3wtqxWm6lGXCTNLXOpXuxt5Id
         o7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ek6pdeO0DB1Tm5mlcz1RuofuiBWoeBBusgfA8BxgA/s=;
        b=iEmhaeCjNogaOytjAlrYy9okKIpPsLEtpKnlrcUg9hL+MWzXWSNcB/e2/GFDp1KxKR
         lXsr9qWgVAOVW04Rt7d9PSBCZgU8K2MSxUmndA11lc2TRjVyIxITtXbvcr/tUsQ7i6qF
         At/r03sQ2HgOQKqSq5IFcDJss29tJgab0mxpReApM728utpeyoh3xMOBpkrZfKmg0QOd
         FqmjmffsGUw7/sc0oZhxhToZsRQ7HZMW+kFWD4n7tCcOkubrrgboVnHVUbTcez3Nsu7m
         sku4tMwdmyQRyGLkAwzt/WL5dcUm1Pmm0+Clmu05cXYd3mSqH+6a9pP8sUx/f+LCSMNb
         S4Tw==
X-Gm-Message-State: AOAM530LRGhPKjGtR5mKRrE3hEl9yHA4XLwgLIjlzPupcRt85y+5+FX8
        09zN1KQ4uVNR+Mlv0vQGxPMlrA==
X-Google-Smtp-Source: ABdhPJzUUcAgrI+YNY0uHpRqZh3IJeveL77dKpHjyDMdSa25aTO+oKqZHM/pDVbAQh83xS/7W8GMmA==
X-Received: by 2002:a17:907:8a1a:b0:6fe:b42f:749a with SMTP id sc26-20020a1709078a1a00b006feb42f749amr52199639ejc.451.1654091550060;
        Wed, 01 Jun 2022 06:52:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id si28-20020a170906cedc00b006f3ef214e0csm753070ejb.114.2022.06.01.06.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 06:52:29 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: vendor-prefixes: document deprecated Atheros
Date:   Wed,  1 Jun 2022 15:52:22 +0200
Message-Id: <20220601135222.205035-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two old boards use "atheros" prefix instead of already documented "qca".
Document it as deprecated to fix warnings like:

  at91-gatwick.dtb: atheros@0: 'atheros,board-id' does not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Rebase on Rob's dt/next branch.
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 113ff50eb46e..cba1d02dfec7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -143,6 +143,9 @@ patternProperties:
     description: ASPEED Technology Inc.
   "^asus,.*":
     description: AsusTek Computer Inc.
+  "^atheros,.*":
+    description: Qualcomm Atheros, Inc. (deprecated, use qca)
+    deprecated: true
   "^atlas,.*":
     description: Atlas Scientific LLC
   "^atmel,.*":
-- 
2.34.1

