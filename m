Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445C857A962
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiGSVun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240590AbiGSVua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:50:30 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4A0509DC;
        Tue, 19 Jul 2022 14:50:28 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id h14so1203997ilq.12;
        Tue, 19 Jul 2022 14:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b/6qqdLKDCz4qVVwN3wNPEiNzz8gdLtHmJ/VBRGVsnU=;
        b=GRLCb92FFCExl0Fj7kLdThjyIS/ctQgF4JKd4rwRBV+JAPP4efO53jtUp+obPNkFZi
         ltFIXft5QcuvD+avbx6KjBc7gV2p2wyClEHZMD4K7SE4K/Eac5d7Z5oppL3/hQHjtgxS
         0Lz6nsv/7VMOx35tT30KKsviSDQedjnFPeuO/paTmPJn5nnvTz5oDlOpsi/i5fCRiNXP
         0SWw9Zimm3G9ZYFvp/TAIMDjN4m8zquY4NPNpKrkz/viqGN44WVOeNoQ5QNKH+UBn0Kf
         aMRGEo/fjqDI8xNuPm5+cVc9Q4hVi02KncIHIIWl77+QtKoePVXp9lau8nDNR+2TJza0
         3cwQ==
X-Gm-Message-State: AJIora/pwCutN8kFrK61sDrMTERn1ntczLNJIeCSvXV2fgk1IwE0mT8g
        GIEmXhK9epI9aRMhLdq7A275tZw2aw==
X-Google-Smtp-Source: AGRyM1vFktTAsRljdCUDCqELagF4GuBcs9YxBJi7gM9cENE2swk4+neu0JxbxDI+jMfJxzqUTNFNDg==
X-Received: by 2002:a05:6e02:178e:b0:2dc:8f6a:8c41 with SMTP id y14-20020a056e02178e00b002dc8f6a8c41mr18015349ilu.202.1658267427997;
        Tue, 19 Jul 2022 14:50:27 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id i27-20020a056638051b00b0033158c4a312sm7073921jar.55.2022.07.19.14.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 14:50:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: power: supply: charger-manager: Add missing type for 'cm-battery-stat'
Date:   Tue, 19 Jul 2022 15:50:16 -0600
Message-Id: <20220719215017.1875530-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cm-battery-stat' is missing a type definition and is not a common
property. The type is boolean.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/power/supply/charger-manager.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/charger-manager.yaml b/Documentation/devicetree/bindings/power/supply/charger-manager.yaml
index fbb2204769aa..5af1e0beaf29 100644
--- a/Documentation/devicetree/bindings/power/supply/charger-manager.yaml
+++ b/Documentation/devicetree/bindings/power/supply/charger-manager.yaml
@@ -50,6 +50,7 @@ properties:
 
   cm-battery-stat:
     description: battery status
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum:
       - 0 # battery always present
       - 1 # no battery
-- 
2.34.1

