Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2449851FAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiEILEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiEILEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:04:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D12222411
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:00:35 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g20so15812049edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf42AyRLj9ezHOycAE5i27vr8gxZcqJtgnUheMPg1+A=;
        b=i8a6tbbrKIDyrwUul2SdCdPIlT2gGtoU+Wx7rhVu2CSx91gfRyeqFwZsStWCmu2W0T
         oQ4D4eM59L0XlTJWDLhj5RuyiaPFBN+rK6zeiccFGNcehsN++urUXCpjPT40KrtOX9eh
         D7+YfOlekj1O+TP22sW3CT7AvsOOLf9fTpZg2M2jzSslDb3VqfAqA6tYv9UXJDrbHS51
         TTVzkq6czk4JrKv+OmBRupOXrhMnFXru5XdBbVv9u49J4ffd4AuAmI6vxfVWSDnIETtd
         /ZjcniJbWJTWyZquh0UcAzkMghquoif0Q/3mmutvzTpkLuIll06MtVgJkRTeCGvnpYNY
         H9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf42AyRLj9ezHOycAE5i27vr8gxZcqJtgnUheMPg1+A=;
        b=Hu7gd1jRDz0V6n4elVCCTjvm94jrlDVNMaSjIlciYFLeiZ6rhL7hw6RMT5pqGag4/c
         w0IFfKFbUKQQq1Z+nMgBhNd0a8k36apfNkWmaPX3O9Rgy77mMQH9qLAUy1yVtXcAjoYN
         Kk635NEnAXGz0GC3QpdBpCIrQwUXRWAEurJqXuKwC90pf6r3oHISnHhTmQnOZcRmcRL5
         LJXdKBc4YXD77yGjAMzbm1msNU5yubKvnQwiCzaHV6uB0LFU01hs14/xUSoP1mPNQS13
         tzGJUQ2StTs6t05N+yWynO2ZzMleg4660X9FzhKe2IW3+FwEm5+JezlrbzQu8RygHlFU
         TmZg==
X-Gm-Message-State: AOAM530sSXIzIzYwwDKYbzU3fSeaKXcjOiqkQK4d/hFauuZbcQmULbHA
        +UaMaKk49nLnrXl4angK4Z2OnA==
X-Google-Smtp-Source: ABdhPJzT+yPGdXIkkLR4DHE771vRbCE9ujGxJNlacbE/Xug2f9v2LVa/yYkJ5ZCp3TfpxqSkWZvvdA==
X-Received: by 2002:aa7:c3ca:0:b0:425:ecfc:4258 with SMTP id l10-20020aa7c3ca000000b00425ecfc4258mr17007599edr.266.1652094034469;
        Mon, 09 May 2022 04:00:34 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e73sm4963822ejc.217.2022.05.09.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:00:34 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, shawnguo@kernel.org,
        linus.walleij@linaro.org, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: add Methode Electronics
Date:   Mon,  9 May 2022 13:00:27 +0200
Message-Id: <20220509110028.144226-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.0
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

Add vendor prefix for Methode Electronics, Inc. (https://www.methode.com)

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 01430973ecec..e5ec476f54cd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -764,6 +764,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^methode,.*":
+    description: Methode Electronics, Inc.
   "^micrel,.*":
     description: Micrel Inc.
   "^microchip,.*":
-- 
2.36.0

