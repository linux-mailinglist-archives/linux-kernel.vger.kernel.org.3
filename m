Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61A58F000
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiHJQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiHJQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:03:46 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AF865557;
        Wed, 10 Aug 2022 09:03:45 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id q124so12510996iod.3;
        Wed, 10 Aug 2022 09:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gUFodgoC2lqTFaNasV7YrZykU95cfxFWACtBt8544i0=;
        b=lNPXpJjAlH+kfbNsc/LmCL00cz91ASc3DmizDNEC6o/JhnHemB29GwnpVDet95lYKM
         Rrc/x/l0dwPR3Gw0cpR3HRzaCpcz2nIHLTT5UUZlhssMHyfCFfuQhYE0DjGRKGV9mf5H
         QTIWe3v2OB+UWJ1F8fpvShOhX8F1Z4sq1aP1ixeIliPLKco4u2pafU/puIafL2DHiNeX
         P4OAzOJ7cUHrZI0pOibtBxTTYITuZyI3uCYhC5MadDySMpgp77BvoN9tnarg9mDu5na7
         yzNs7oLGke8ba52hIx4iXIlyJ3vgD/qcFxiQyurmakg189oZnpwi1Un9MKGVcaBxwe5B
         6CMw==
X-Gm-Message-State: ACgBeo1IcjUIqQg3/Jqtq5l9Ytr03IIJhD8NO8jTsSgO4oqA6xnOZ7Mg
        pHNHP0N3MQREZo41lCTO4p863hXwug==
X-Google-Smtp-Source: AA6agR4B7/p6u94ML83YbYJrjwN2UKytsOAzrt31dANpFxXzc/VXUvtvEbBrHLarP+5xG25DICyg+g==
X-Received: by 2002:a05:6638:2504:b0:343:38c9:eb27 with SMTP id v4-20020a056638250400b0034338c9eb27mr2808124jat.92.1660147424916;
        Wed, 10 Aug 2022 09:03:44 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id a27-20020a02735b000000b00341a215d3cesm7617629jae.63.2022.08.10.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:03:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: arm,versatile-tft-panel: Drop erroneous properties in example
Date:   Wed, 10 Aug 2022 10:03:40 -0600
Message-Id: <20220810160341.51995-2-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810160341.51995-1-robh@kernel.org>
References: <20220810160341.51995-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'arm,versatile-sysreg' node in the example should not have
'#address-cells' and '#size-cells' properties as the child node doesn't
have 'reg'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/display/panel/arm,versatile-tft-panel.yaml        | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
index be69e0cc50fc..c9958f824d9a 100644
--- a/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
+++ b/Documentation/devicetree/bindings/display/panel/arm,versatile-tft-panel.yaml
@@ -37,9 +37,6 @@ examples:
         compatible = "arm,versatile-sysreg", "syscon", "simple-mfd";
         reg = <0x00000 0x1000>;
 
-        #address-cells = <1>;
-        #size-cells = <0>;
-
         panel {
             compatible = "arm,versatile-tft-panel";
 
-- 
2.34.1

