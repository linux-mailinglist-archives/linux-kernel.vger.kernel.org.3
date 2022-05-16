Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60404528472
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242428AbiEPMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbiEPMsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:48:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B323968C
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so18182645edo.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XA6Fn2c7ipHKeYPFo/UF4+uHyCP29TidKb7wIkVA+WE=;
        b=c6tteehKzLJsM8ihzkAeFIUvBFS5ogo6Rz9iHGrpL4anCR1ROSEjxfwzaxZtASCR6Z
         qWjLHPdyiq8tQy+4XB+GYMlwfyoHPsssb4z5eyQmH/X//jrSSlr/Q9K3KC+UYAVxg+1d
         orxZZqxtWupRq+heLOdF94HIKRwerXOL+kRdx0vYfhrmI12HXueU5oexCWCLdeB4GaSr
         Uda157IVyuRW8nlHpqqJB1FhMzWEFzaKanQbhHJOEZJ4WPcrgAHYIHGalzey/upPICak
         Q6rZohGkfQYIn/yVUj79J04YX5deKSEEez9g+ahBWwtQBKkm6kWVaN3lIjOi8LgAZUR+
         zQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XA6Fn2c7ipHKeYPFo/UF4+uHyCP29TidKb7wIkVA+WE=;
        b=BT679nL1udwUrsiOEXG+CPw35hwLdeQEReP++I4R9AO+T2KS0p2cCnC7aYekhcOTuh
         k8o7FyM8S8QvtZE2yCAGHcetJCH6/sRIz/dZ76KlQAEuHw/I0W+V/sE+D11EkTOT1UVg
         j1AZI7hhgNN+OcIk1RqyA0Mhax7w1A+d6+viq//H/7NBVHChammqP6uwJcqmjJqOMt4V
         WAUreIpjALOVOXAlRmKTV40lHSh0dPHz8aE509xK+ef/dAeWT+3FTvSsSZ32PNZA7s/d
         XQJ5N+ITetypDkwsDIQrX/ekTrLWG09bzHfMwlEak8ROziifC52L7Oh3ppqUPCDrpFby
         2YKw==
X-Gm-Message-State: AOAM532kVazybQ4dfJ44G35iTVWmAM5uPykUmS/SkLs0KCwWmdrZTERe
        5aORtn/OgHjTJ35o175/3KZKEQ==
X-Google-Smtp-Source: ABdhPJy7BcdZ8TfXT/RNfwSwm8Y8CT3U5AfHV0hy8AIESmfwvjEOhcTuiwmbrQkjU7QwukfdfnMnBg==
X-Received: by 2002:a05:6402:1150:b0:42a:9dbf:8860 with SMTP id g16-20020a056402115000b0042a9dbf8860mr10543859edw.350.1652705331475;
        Mon, 16 May 2022 05:48:51 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402330a00b0042617ba6386sm5093331eda.16.2022.05.16.05.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:48:51 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 09/10] dt-bindings: marvell: armada-37xx: add Methode eDPU compatible
Date:   Mon, 16 May 2022 14:48:27 +0200
Message-Id: <20220516124828.45144-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516124828.45144-1-robert.marko@sartura.hr>
References: <20220516124828.45144-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document compatible for the Methode eDPU Armada 3720 based board.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* Alphabetical ordering
---
 Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
index cd7a77d1fdc0..6905d29f3108 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.yaml
@@ -20,6 +20,7 @@ properties:
               - cznic,turris-mox
               - globalscale,espressobin
               - marvell,armada-3720-db
+              - methode,edpu
               - methode,udpu
           - const: marvell,armada3720
           - const: marvell,armada3710
-- 
2.36.1

