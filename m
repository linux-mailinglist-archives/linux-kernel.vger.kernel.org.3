Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A53850C328
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiDVW0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbiDVWZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:25:53 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAA11D1182;
        Fri, 22 Apr 2022 14:17:53 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-e68392d626so4843649fac.4;
        Fri, 22 Apr 2022 14:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hyQzhiKlkaWZxWD1O6avqa7n3KAQtOMS3NT5kofLOHw=;
        b=tCcmIFlmLN9+hSe7daLx7BP+txqBNnJumXNsF6FzK7pa7IPFIvbHQfVZbZzixorNzr
         AcXUfTAPA8JBTB0UJL7K4Q7OTq5QSlb0EO3PXDR4GZXFWwTYCYntHWT4Ny0sz/89+nXX
         4ZnY/7ZGeDlQVscrGclBKvBrrQieSGqGKQ+/rcdkB5QDi0OzNKYoH8MlFmYQCKBdrPqS
         /qcfycI091Yk2fRvUBZig++v4qEw3UJKktYBmmkhWDmcV/UY6+CTyngAEYXXv5dmpfP7
         ysc0BopdLJMqcNnE6W8MmqdZtk0MfbBEDA0uOChuoKiruqc/q4dG4t8MeWSzozONJTMt
         e5qA==
X-Gm-Message-State: AOAM531n3WjZUVX4LlfUhyWsRy0StT0duvMVIKHcATV+u3H54lJi3PZ/
        KsFfSqaHehKh2mIEzSTEeFW5sJT5+g==
X-Google-Smtp-Source: ABdhPJzraLj00H7QigmfLMJVZWg2j+VnUjRuG4VeBvp5ivyV/JjFzQ+GWydMwMXrzDgEtpfCtjpqcQ==
X-Received: by 2002:a05:6871:893:b0:e5:bfed:cf08 with SMTP id r19-20020a056871089300b000e5bfedcf08mr6776760oaq.25.1650655260843;
        Fri, 22 Apr 2022 12:21:00 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id i7-20020a9d68c7000000b006054aec0025sm1034946oto.69.2022.04.22.12.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:21:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: marvell,armada-3700-utmi-host-phy: Fix incorrect compatible in example
Date:   Fri, 22 Apr 2022 14:20:54 -0500
Message-Id: <20220422192054.2591093-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the example using the incorrect compatible string.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
index 2437c3683326..632d61c07f40 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
@@ -45,7 +45,7 @@ additionalProperties: false
 examples:
   - |
     usb2_utmi_host_phy: phy@5f000 {
-      compatible = "marvell,armada-3700-utmi-host-phy";
+      compatible = "marvell,a3700-utmi-host-phy";
       reg = <0x5f000 0x800>;
       marvell,usb-misc-reg = <&usb2_syscon>;
       #phy-cells = <0>;
-- 
2.32.0

