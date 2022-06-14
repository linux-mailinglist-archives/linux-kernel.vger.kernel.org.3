Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98854A951
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348887AbiFNGUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347783AbiFNGUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:20:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFF37A15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:20:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hv24-20020a17090ae41800b001e33eebdb5dso906024pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZf8NG0o3MSwo7SVn9U97DhVDIoNKKGH9DIvsvOO30w=;
        b=qSclY96TdaMyMla1x5WYCnk5LdrFesk+Ce7Eu0ynlhOK/aWfRPF/1Si9YLJ8pcAfdB
         HK6IsWYSP1PsNSi2y34UqDb48Q0DNAZR+RQA6JOKN/3Mh2uFaoQYGi5lcbs8DoAlxRpV
         86qub/JeCUTOwbTJPSDmFSmR4t9UyWUZh0Qqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IZf8NG0o3MSwo7SVn9U97DhVDIoNKKGH9DIvsvOO30w=;
        b=APZx3xmrPuFoZ9FXdlhUFMk5RLbPOo9U6F2fX54WiZ0s9krrh6xjVtBSr5LCTpQtAo
         3jaFKIqmw0pk8vLCxfPrTKP3Lt772A8xbMHtA641YpilSRbVYyX9/rFkBh6ji9y+ISIK
         n8DTkxj/xAOI+L9ibk91zwbMpiMBhzuzJGjJgSZ/DowDMDOCwz6y2odgCC04+IIBsxiY
         FPAndat4eLNNxtWoKcdb8WkgcjOG1fXRIg5P5pZF/SwocFDa31L5IgGf+U/aQQ+EiY+h
         9rwjzaQUcPeShgkvKjyFVQtQTZcN7HdgDJunDuqoGGmCxJtdudMST1G9sf1jRPr1XLpf
         K+RQ==
X-Gm-Message-State: AJIora/NovzHdCX8XRW2YfCbj4bHkDrhDMEhE9prUMdPUPAwW56ig/Oj
        Z5dHx8rT1EQ9M2WiY5l24x216A==
X-Google-Smtp-Source: AGRyM1tfPOGZfsAnVT3J1cfIlPAO7JiAHfSJUISsHzN+lRvgTYKii6jON6J2I2dXRNYxkxxgJFCCLg==
X-Received: by 2002:a17:903:245:b0:168:e1be:f1b6 with SMTP id j5-20020a170903024500b00168e1bef1b6mr3060841plh.19.1655187600501;
        Mon, 13 Jun 2022 23:20:00 -0700 (PDT)
Received: from localhost.localdomain ([124.123.175.49])
        by smtp.gmail.com with ESMTPSA id x67-20020a623146000000b0051be16492basm6531216pfx.195.2022.06.13.23.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 23:19:59 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Christopher Vollo <chris@renewoutreach.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH 1/2] dt-bindings: arm: sunxi: Add binding for RenewWorldOutReach R16-Vista-E board
Date:   Tue, 14 Jun 2022 11:49:45 +0530
Message-Id: <20220614061946.276898-1-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the RenewWorldOutReach R16-Vista-E board based on
allwinner R16.

Signed-off-by: Suniel Mahesh <sunil@amarulasolutions.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 95278a6a9a8e..29c789969f1f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -787,6 +787,11 @@ properties:
           - const: allwinner,r7-tv-dongle
           - const: allwinner,sun5i-a10s
 
+      - description: RenewWorldOutreach R16-Vista-E
+        items:
+          - const: renewworldoutreach,r16-vista-e
+          - const: allwinner,sun8i-a33
+
       - description: RerVision H3-DVK
         items:
           - const: rervision,h3-dvk
-- 
2.25.1

