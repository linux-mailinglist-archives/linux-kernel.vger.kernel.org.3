Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3005119FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiD0N4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiD0N4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:56:47 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A6B1C1;
        Wed, 27 Apr 2022 06:53:32 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A2E3883E9E;
        Wed, 27 Apr 2022 15:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1651067611;
        bh=lRN//q0RUoYn1Nk0c/CSAhY6Ns1dN94oveT7N6gNYOc=;
        h=From:To:Cc:Subject:Date:From;
        b=UKD7v97iqQW00zjNHA2sR5ASMdAL5Pis2HZldKuWw8fS79MTIz3/kYJg4FoNNDhfu
         uXv9aomSij7K7HMzc2weVwLxVC137NT1maOSz59xzRfTzw5d8A83Jn/8mvQYom2x+0
         78j83nAVwgcmli2rXyoyIIhzu4WGtDU45TwgM/2XGi1vTHuuZTjXxF9K0l+fZ/G2Sy
         CtylI4309qJrr84zbQGIG1B0GRCUsf+e/YDNEMuOHXMvF+OCp70aP6pUF94uJEPsd9
         9lslKFWQGnh/DURkAxTICPOnFnwYIviZCEr1SjDkFE8UhS2gu6E0GnV7oBVZ92hBuJ
         EF9mvcHZaZMdg==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 581D6A01E1; Wed, 27 Apr 2022 15:53:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 73C3FA00A4;
        Wed, 27 Apr 2022 15:53:17 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id EC9F83E0398; Wed, 27 Apr 2022 15:53:16 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: [PATCH v3 1/4] dt-bindings: display: simple: Add DataImage FG1001L0DSSWMG01 compatible string
Date:   Wed, 27 Apr 2022 15:52:27 +0200
Message-Id: <20220427135229.2339865-1-pro@denx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DataImage FG1001L0DSSWMG01 10.1" 1280x800 TFT LCD panel compatible
string.

Signed-off-by: Philip Oberfichtner <pro@denx.de>

---

Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: matthias.winker@de.bosch.com

---

Changes in v3: new
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 1eb9dd4f8f58..a6db3eff3b1a 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -105,6 +105,8 @@ properties:
       - chunghwa,claa101wb01
         # Chunghwa Picture Tubes Ltd. 10.1" WXGA TFT LCD panel
       - chunghwa,claa101wb03
+        # DataImage, Inc. 10.1" WXGA (1280×800) TFT LCD panel
+      - dataimage,fg1001l0dsswmg01
         # DataImage, Inc. 7" WVGA (800x480) TFT LCD panel with 24-bit parallel interface.
       - dataimage,scf0700c48ggu18
         # DLC Display Co. DLC1010GIG 10.1" WXGA TFT LCD Panel
-- 
2.34.1

