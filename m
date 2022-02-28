Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE514C7D29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiB1WQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiB1WQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:16:35 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366AE1B74;
        Mon, 28 Feb 2022 14:15:55 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso20406279oon.5;
        Mon, 28 Feb 2022 14:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OEmvWFYcUlvLI2qOQZZbyye8qQFK9MgvtHyOAXPOp8U=;
        b=McxFFoHj1F6birwbR/G2gJwMs0PBaVuXV4Or9FFpGHcFpVX5nMgUU/lKRpidfCALrc
         jNDnSnjHShUodESImjwyrG6ceUEHhPKW+lEgJEC9wbozS4ZOc6KV9ASke925ljnPIHLV
         Ft22CVrP1+Yer0ZAUhz6O2UjpC9Be+QMT9heKyjzbCeMbisk7Npnr9kDlbth4xUt7PHk
         nRzpzFGCyivVliZ+RV20oM3qfCLNi0sfgmWsFY9stRSLKc0/dUyXM7cKilhclXCjefhm
         laJRJu2Zs8AOtW/JHpUiW3jlzpNNJFcsv7WqIp0Ciw4b2I5ufhGAroNSeZ7WoYy07RdU
         8R2Q==
X-Gm-Message-State: AOAM531naWdDGpfUzE9ldGgU1jtA7imrpYygxkay/wMZn0kxof9d+CrA
        b8YtKK7xR4Umtphg44Qj3w==
X-Google-Smtp-Source: ABdhPJz03WhL44Cw8TDPnrAAhE5YNR7G6nXVzt9q331dU3Co2p6qYpvGwJfUqyb2mMaeRoSteXVOaw==
X-Received: by 2002:a4a:db95:0:b0:31c:23c8:554d with SMTP id s21-20020a4adb95000000b0031c23c8554dmr10094963oou.64.1646086554672;
        Mon, 28 Feb 2022 14:15:54 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id t1-20020a05687044c100b000cd7b642bedsm5027977oai.14.2022.02.28.14.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:15:54 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: Add compatibles for undocumented trivial syscons
Date:   Mon, 28 Feb 2022 16:15:37 -0600
Message-Id: <20220228221537.1700071-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'intel,lgm-syscon', 'marvell,armada-3700-usb2-host-misc',
'mediatek,mt8135-pctl-a-syscfg', and 'mediatek,mt8135-pctl-b-syscfg' are
all used in DT binding examples and/or dts files, but are not
documented. Add them to syscon.yaml as they are all trivial cases.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index eeac1cbc5a17..29d4a97f7108 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -44,6 +44,10 @@ properties:
               - hisilicon,hi6220-sramctrl
               - hisilicon,pcie-sas-subctrl
               - hisilicon,peri-subctrl
+              - intel,lgm-syscon
+              - marvell,armada-3700-usb2-host-misc
+              - mediatek,mt8135-pctl-a-syscfg
+              - mediatek,mt8135-pctl-b-syscfg
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
               - rockchip,px30-qos
-- 
2.32.0

