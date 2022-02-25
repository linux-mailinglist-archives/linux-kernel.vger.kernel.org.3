Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7364C4803
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbiBYOz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbiBYOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:10 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C3225592;
        Fri, 25 Feb 2022 06:54:38 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id q10so2601376qtw.4;
        Fri, 25 Feb 2022 06:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y4cNWerRUjMHmiNUNzXBZ2mcrLA/Vini3LuGLiQPleI=;
        b=PgAb9Vvnd5VqlaSdbhbbFlCyY+VsHxaTb1cP3kGo+tTyJEzkdzxqIDlzpIjw0LxkOP
         jxQBmBAchI8onMnqvU45qs8To31xUP/Mx/UgdBsK5YU1ZXRDYvKGjR7O+7M5Rgk02l4r
         QUM/BdtfgwylJE5VGtpa292BB5fWiLWi79x6jaMizhhHReJ/HdlKQPZ4IXhNwMaUr8jA
         kMKxB8Tk/DUPsaX8ga0GuL3s2UkhESHM9anKsf6loE29gKDqSUe12KEMNjzPYQRp6e44
         ha2zlE/c9PWNAr0zdllfa4BzLnWntkWfbHlwCRKpqomzgi2FHStpJR1NghxuUdw9I3Bx
         0c7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y4cNWerRUjMHmiNUNzXBZ2mcrLA/Vini3LuGLiQPleI=;
        b=XTBcqc9A+45cMmha9MG7/hEmPH3fpIWoBVlJP1Wc1qKzqpZyK90w+xJgpRcd14EQ6N
         VBE470FZYc2qvf0QHRcricsKZhNEpncBgX1GB7538EOxYgDDJ784d8pWgwaeo4qokjWz
         5D81x/DGuYOxGuWLzR5cmfrgZ0xDXBU+JRvwPKQOQFfL9ISr9WSoJAfgfJchuk+B222U
         2LgbfT7qE378B9uAlXkPnOnDy1Cq9xv5+U6qMfMJ0R8EW0nhDE3KrqZQuxe2I06t2isF
         olz7wq+XWL7Le1oLMuD3btVM/EIPkuVPC03tI5X1OO457zOFWStgcNFaTb5O9ahu5SdI
         5E3g==
X-Gm-Message-State: AOAM530yoJLB7qc9fSE83A6dQLeI0qxZ6Z1ylldSqG2+seXDz9WR8qdx
        wvw57G7ghgJpoSE5mVIxMDk=
X-Google-Smtp-Source: ABdhPJwDmobbs+ADlqr7QCTKzhyLo+hHpMkIwplNNKdf8nURBCXqkP1dSLivP770Grqrgf6Ba9iSIw==
X-Received: by 2002:ac8:4e46:0:b0:2cb:28cc:2157 with SMTP id e6-20020ac84e46000000b002cb28cc2157mr7131031qtw.167.1645800877716;
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] dt-bindings: usb: dwc3: add description for rk3568
Date:   Fri, 25 Feb 2022 09:54:25 -0500
Message-Id: <20220225145432.422130-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 dwc3 controllers are backwards compatible with the rk3399.
Add the device tree description for it.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
index 04077f2d7faf..e3044e81cc72 100644
--- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
@@ -30,6 +30,7 @@ select:
         enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
   required:
     - compatible
 
@@ -39,6 +40,7 @@ properties:
       - enum:
           - rockchip,rk3328-dwc3
           - rockchip,rk3399-dwc3
+          - rockchip,rk3568-dwc3
       - const: snps,dwc3
 
   reg:
@@ -75,7 +77,10 @@ properties:
     maxItems: 1
 
   reset-names:
-    const: usb3-otg
+    items:
+      - enum:
+          - usb3-otg
+          - usb3-host
 
 unevaluatedProperties: false
 
-- 
2.25.1

