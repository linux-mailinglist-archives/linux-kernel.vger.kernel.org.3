Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDCC5AE286
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiIFI24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238730AbiIFI2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:28:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD774E2B;
        Tue,  6 Sep 2022 01:28:33 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:414f:4149:b474:40e4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB135660038D;
        Tue,  6 Sep 2022 09:28:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662452911;
        bh=qiTFwUuM7gcEZ1tKJqSdwW7m8ms6+bxXjhd4DOwYsaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CW4mUapDUeuDuiyYv0WuwTpQRdVgNl8uZQ+cUbpUwOxyby3aDMjtDdKE+kIRD9/0a
         q2R3FMgIe7omTZ+yH+nPt3QOVb2mMe6486avE9cbLMw2YTv30+4XHaL2aX99j27Ovn
         FoLVbuqNUdV25MqOjjcVFtQREYQrCVJEnodOI+PJZ34XKc1Um+WQ7vvX4pDLkyqi/O
         LB4TOfmuODMEvL1Kw6IuMjAO5oxUQBW7LfMZpgPp3chlNz2NDUEektDiAqSc5FfMGF
         BX1vqZO78cfAI0Y9yQUzJS9DjMbfOdC48fo9YMa/DfTFivkO4FcyfdtGYF6Ipyp5sG
         uL7eGFsS9fySg==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] dt-bindings: vendor-prefixes: add Diodes
Date:   Tue,  6 Sep 2022 09:28:15 +0100
Message-Id: <20220906082820.4030401-1-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

Diodes Incorporated is a manufacturer of application specific standard
products within the discrete, logic, analog, and mixed-signal semiconductor
markets.

https://www.diodes.com/

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
 - None

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..7ee9b7692ed1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -328,6 +328,8 @@ patternProperties:
     description: Digi International Inc.
   "^digilent,.*":
     description: Diglent, Inc.
+  "^diodes,.*":
+    description: Diodes, Inc.
   "^dioo,.*":
     description: Dioo Microcircuit Co., Ltd
   "^dlc,.*":
-- 
2.35.1

