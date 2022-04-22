Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622CB50B9B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448477AbiDVONO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448398AbiDVOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:12:27 -0400
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D55A595
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:09:34 -0700 (PDT)
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id A673421130;
        Fri, 22 Apr 2022 14:09:33 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 4959F267CE;
        Fri, 22 Apr 2022 14:09:31 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id A9B822000D;
        Fri, 22 Apr 2022 14:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id E9A782A389;
        Fri, 22 Apr 2022 14:09:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id liAEvKaL7d5P; Fri, 22 Apr 2022 14:09:27 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 22 Apr 2022 14:09:27 +0000 (UTC)
Received: from petra.. (unknown [113.67.11.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 646C240645;
        Fri, 22 Apr 2022 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1650636566; bh=EGPX2hZjigm45jxdQRkqHwlnDLdYXc0XAIoGchu2uro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6JeP14+TpDyNgY+szUNQrXCQ+6kYyUJP467nyPIDfBSr9u86jY3FHh+g8mk0E34a
         tLIyyVh1C6lwSvIv3RmrWtKPy9tMPx+sGLIOIsJJUuJspo0WlY4aq5kLr1KmDqNfhb
         /ss22DZead45B34VP8aOd7yIOXsg0jfHzbBcbEdQ=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 01/12] dt-bindings: pinctrl: document Allwinner R329 PIO and R-PIO
Date:   Fri, 22 Apr 2022 22:08:51 +0800
Message-Id: <20220422140902.1058101-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422140902.1058101-1-icenowy@aosc.io>
References: <20220422140902.1058101-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R329 have two pin controllers similar to previous Allwinner
SoCs, PIO and R-PIO.

Add compatible strings for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index bfce850c2035..3fa7891381e7 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -55,6 +55,8 @@ properties:
       - allwinner,sun50i-h6-r-pinctrl
       - allwinner,sun50i-h616-pinctrl
       - allwinner,sun50i-h616-r-pinctrl
+      - allwinner,sun50i-r329-pinctrl
+      - allwinner,sun50i-r329-r-pinctrl
       - allwinner,suniv-f1c100s-pinctrl
       - nextthing,gr8-pinctrl
 
@@ -190,6 +192,7 @@ allOf:
             - allwinner,sun6i-a31-pinctrl
             - allwinner,sun6i-a31s-pinctrl
             - allwinner,sun50i-h6-pinctrl
+            - allwinner,sun50i-r329-pinctrl
 
     then:
       properties:
@@ -205,6 +208,7 @@ allOf:
             - allwinner,sun8i-a83t-pinctrl
             - allwinner,sun50i-a64-pinctrl
             - allwinner,sun50i-h5-pinctrl
+            - allwinner,sun50i-r329-r-pinctrl
             - allwinner,suniv-f1c100s-pinctrl
 
     then:
-- 
2.35.1

