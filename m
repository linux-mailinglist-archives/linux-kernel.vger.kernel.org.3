Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F765A4E58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiH2Njl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH2Njg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C89915CB;
        Mon, 29 Aug 2022 06:39:34 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:c9c8:35ca:a27e:68d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED35C6601D96;
        Mon, 29 Aug 2022 14:39:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780373;
        bh=cY9ao7LclpjngWgl8bSM/LP0G2Y94kJ9IBgEszQo58o=;
        h=From:To:Cc:Subject:Date:From;
        b=Dt+C2zzhrbQbvfUwmcSJ414FT96MwgGZcrDOO248RmY4tS8Hb6AEvaq2uzTzdgGau
         JJjJ3TYzFpzqAh0S6rvO4pRGZWA20AG8lImJA312hC8hUpA1wKKCCB/mf4akCO/6in
         UHSoY+Ylw6AMbpDOu7Hw4/XEeDfW3OKK9P1Ljgp8xXfCAcSDfOASie5aAowHcdxwRi
         3i/rg6dukZeAZCRoBYNQ4pPp/WbMjkoeLyUmwc05QGU9P1k+v4CnNNQixvVueG4u+X
         3F55xYqicpIYy+QfGtyKIVjhOYj2qUpqW3RMZcgqUFdJFLKaAM6mhLQkeHaeu2ffcN
         TMnQX89/P/fFg==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: vendor-prefixes: add Diodes
Date:   Mon, 29 Aug 2022 14:39:18 +0100
Message-Id: <20220829133923.1114555-1-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Diodes Incorporated is a manufacturer of application specific standard
products within the discrete, logic, analog, and mixed-signal semiconductor
markets.

https://www.diodes.com/

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
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

