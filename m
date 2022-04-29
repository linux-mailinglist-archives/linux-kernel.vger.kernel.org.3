Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D45155AC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380785AbiD2UeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380746AbiD2UeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:34:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5CC57984;
        Fri, 29 Apr 2022 13:30:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 34B901F469DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651264254;
        bh=WhBscFKU5VQm6TYc14qc9KQvHxuRNZWGVfBdWHdQHXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzrNWsSp6JZEP7EJUXWhPnsMk9MF6vL/DrIUeXX8sAUc7eTH/ttqpRkuUwOpCoBgw
         O5N9OanBEMtqznT8pilVThDDRbI8bluWX3FCxZH40EjMhAGCM6QxgBduuLIHxCSQOy
         ufYCw801a3bIomSWdEqqjw9F3GN9XkZzTSEaY2IUCOY4DaNkG5ybamBrF5YaUpctN9
         5/sUKNOZX3FlSyGf0iBJ1FzEEpUafIhvmMJhVCWMFu+NZWVAz/8Hh8fzqZVco9vFl5
         lHXKzVHbuljWmzpF2qEn3IdVe84Fl6u4jKFHW0PSnjdp+OieSrmOt25FDlzeHhynHE
         0LY1b2ELlZ31w==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ASoC: dt-bindings: rt1015p: Add #sound-dai-cells
Date:   Fri, 29 Apr 2022 16:30:38 -0400
Message-Id: <20220429203039.2207848-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220429203039.2207848-1-nfraprado@collabora.com>
References: <20220429203039.2207848-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt1015p codec can be pointed to through a sound-dai property to be
used as part of a machine sound driver. dtc expects #sound-dai-cells to
be defined in the codec's node in those cases, so add it in the
dt-binding and set it to 0.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
index fdb7f295ef2d..1d73204451b1 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
@@ -25,6 +25,9 @@ properties:
       0 means shut down; 1 means power on.
     maxItems: 1
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
 
-- 
2.36.0

