Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD22479B76
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhLROtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbhLROtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 09:49:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B53C061574;
        Sat, 18 Dec 2021 06:49:30 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so9773524wrr.8;
        Sat, 18 Dec 2021 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4dTIJ4LLWFdMS2XTO0tU1VpI6xwERc2lNgtDmw13Gqs=;
        b=AW+/l0FYGFXWf5eLENzL8c7j5Hi9eYjKH5VbXQuZyCqgctX1JmwF+DqSeIarao/xBP
         3aa9eKaeJNexu5PHJjNG4DIP6NRl24UkZrrVnrluVn2ZfBRdTmrhX2h8CF5+t8tlo/vc
         HEh6tiO/d7kMn3KXvdsHelgFXiA7ZsCzooA7HbCxmHBG7fOTY8Kmt5yBl726y6Y6w+Vb
         v1inmspnboQKMwzdZDH31OTAew6ForPjtQ54yuZs3y5qKafsu6q3/w6Bji2XNwsD9XMi
         6XYk7iiO5TgiEXMMYHnvPalugHo0S0csZnb4Yw5JEIg+y0IqYuGB2kf32qyegAJPEzs5
         v/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4dTIJ4LLWFdMS2XTO0tU1VpI6xwERc2lNgtDmw13Gqs=;
        b=CLoyt7KcoGw2S/V/ZKB8pkEXJDM0KFQWmUJMST54wKZcoKMKDa7wBj3HuGoqNCzbDs
         PfcGDzKuZh+zNivlBCFE0N8TObl/jFMrmwG5eMTpAJ1bt+9BcTfnRqSPLQnJYyf7CGw0
         5juQW5BMmBnNMi2tOPvtzdntjkTJQ7zdrrVQg1IcvyHduPXBSsfVWXZGQyeKx7B2UVLk
         dlquJde0PoztqWTFXh2CzD87ni6ENE4EtljXLYqH+vBo8SwoK3h+DiV7n8degtO6yuao
         TOz2xG+30mv8QGWYR+vh/apKdj/RmZ5uC3ZRqbzagk03AW8rtInM3eC3h5dulI4o9nB0
         LNig==
X-Gm-Message-State: AOAM532XVKkZG7GL3xooO8o2NYGxc/VU1+1JNAzLHdmYJaQMA4U3yQRh
        LSy34fo6SR5WO9QsdIHddcM=
X-Google-Smtp-Source: ABdhPJzU+oh70+2zV1gTmQpy7pPDJ5og6t5NewX/hUA2MJZTupAg4qJE9l5FPf94p2AdIctugJjkdQ==
X-Received: by 2002:a05:6000:148:: with SMTP id r8mr5993251wrx.333.1639838969101;
        Sat, 18 Dec 2021 06:49:29 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id f15sm12560572wmg.30.2021.12.18.06.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 06:49:28 -0800 (PST)
Date:   Sat, 18 Dec 2021 15:49:27 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: ux500: Document missing compatibles
Message-ID: <20211218144927.GA6388@standask-GA-A55M-S2HP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These compatibles are used in Ux500 device trees, but were not documented so
far. Add them to the schema to document them.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 .../devicetree/bindings/arm/ux500.yaml        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ux500.yaml b/Documentation/devicetree/bindings/arm/ux500.yaml
index 5db7cfba81a4..a46193ad94e0 100644
--- a/Documentation/devicetree/bindings/arm/ux500.yaml
+++ b/Documentation/devicetree/bindings/arm/ux500.yaml
@@ -20,6 +20,11 @@ properties:
           - const: st-ericsson,mop500
           - const: st-ericsson,u8500
 
+      - description: ST-Ericsson HREF520
+        items:
+          - const: st-ericsson,href520
+          - const: st-ericsson,u8500
+
       - description: ST-Ericsson HREF (v60+)
         items:
           - const: st-ericsson,hrefv60+
@@ -30,9 +35,34 @@ properties:
           - const: calaosystems,snowball-a9500
           - const: st-ericsson,u9500
 
+      - description: Samsung Galaxy Ace 2 (GT-I8160)
+        items:
+          - const: samsung,codina
+          - const: st-ericsson,u8500
+
+      - description: Samsung Galaxy Beam (GT-I8530)
+        items:
+          - const: samsung,gavini
+          - const: st-ericsson,u8500
+
       - description: Samsung Galaxy S III mini (GT-I8190)
         items:
           - const: samsung,golden
           - const: st-ericsson,u8500
 
+      - description: Samsung Galaxy S Advance (GT-I9070)
+        items:
+          - const: samsung,janice
+          - const: st-ericsson,u8500
+
+      - description: Samsung Galaxy Amp (SGH-I407)
+        items:
+          - const: samsung,kyle
+          - const: st-ericsson,u8500
+
+      - description: Samsung Galaxy XCover 2 (GT-S7710)
+        items:
+          - const: samsung,skomer
+          - const: st-ericsson,u8500
+
 additionalProperties: true
-- 
2.25.1

