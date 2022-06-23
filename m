Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1490D5578A3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiFWLYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:24:13 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FED64BBAE;
        Thu, 23 Jun 2022 04:24:11 -0700 (PDT)
Received: from janitor.denx.de (unknown [62.91.23.180])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: noc@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CA6D984343;
        Thu, 23 Jun 2022 13:24:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1655983448;
        bh=3o4Grvbqdsg3HB2LYvNqzR5lHAEkLUwsW4H/pOMCxAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=i2/40nSlRunAJhLBfN0mH35A+FBsuQSn2h/gIkYKnJxNS62XXQYBnScD14ptcKpt4
         zRu4kGQBdB7zQB4sdJNByYwsxTygzDbWSXPhUEKxxi0iAd2MVX9gVhGwWM2Smn3Y/k
         seNDRCwt6iMqCCl88IpT37BGy9CgHUV2VrSH0emh3S3fPA/lEJrwKfDshLk7D3XfjQ
         ycWIYgIaTr2/LnfGtZEtUu/zZBWc8mPHVvGigYjIR2KKJHrXGynWxZTKEvOPhiV5jY
         K41lFwaBkJvTcopusBpAPxM+G8NxT7ZH2jToacarPZUsXQFUu3voxk10q12GPyZynW
         9YMnMvYypvCDw==
Received: by janitor.denx.de (Postfix, from userid 108)
        id 65B99A030F; Thu, 23 Jun 2022 13:24:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from xpert.denx.de (xpert.denx.de [192.168.0.4])
        by janitor.denx.de (Postfix) with ESMTPS id 3F7E9A0050;
        Thu, 23 Jun 2022 13:23:54 +0200 (CEST)
Received: by xpert.denx.de (Postfix, from userid 535)
        id C47A73E06AF; Thu, 23 Jun 2022 13:23:53 +0200 (CEST)
From:   Philip Oberfichtner <pro@denx.de>
Cc:     Philip Oberfichtner <pro@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.winker@de.bosch.com
Subject: [RESEND v5 1/2] dt-bindings: display: simple: Add DataImage FG1001L0DSSWMG01 compatible string
Date:   Thu, 23 Jun 2022 13:22:56 +0200
Message-Id: <20220623112257.4178461-1-pro@denx.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DataImage FG1001L0DSSWMG01 10.1" 1280x800 TFT LCD panel compatible
string.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

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

Changes in v5: none
Changes in v4: Acked-by Krzysztof
Changes in v3: new
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 21ba90c9fe33..217ee448a51b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -107,6 +107,8 @@ properties:
       - chunghwa,claa101wb03
         # DataImage, Inc. 4.3" WQVGA (480x272) TFT LCD panel with 24-bit parallel interface.
       - dataimage,fg040346dsswbg04
+        # DataImage, Inc. 10.1" WXGA (1280×800) TFT LCD panel
+      - dataimage,fg1001l0dsswmg01
         # DataImage, Inc. 7" WVGA (800x480) TFT LCD panel with 24-bit parallel interface.
       - dataimage,scf0700c48ggu18
         # DLC Display Co. DLC1010GIG 10.1" WXGA TFT LCD Panel
-- 
2.35.3

