Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34FB4DC542
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiCQL65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbiCQL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:58:52 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275BC1E6E97
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:36 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 042DA3F798
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518255;
        bh=rkZlJ0igM03Y8VkMiNizWzNDbnqGn+aUyjhq4DWqgik=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Xjvdv+OkUwW7yZJeLNnCKGE5WEwOL7LyvwphAhGFP13EzvIgbkiWZ4LuPozL/XbSm
         hW3Svg4KotzhuoRm1WOGeH6/gG5fr+QSDloCh5N4bzrzAUTqJHEuxNpgI5L+trQOKd
         Ug99Ipse3lNuAnXjJtPpBIsxCROnvwXQN1ZkEBgWwWQrpR88Zth/pTrTRiFxqoWjEh
         H1Tj9qDn4neRqMdknlOT7mfrs1NpDqN88u3tPIyAZkkv7oW6T8EAfIDmxqJE85xDuJ
         RonMQowSEQWFA9M4wC52vld9Zb8OI1tA1HLxTaF3nzN2uUe90YIK3y6gg97VfKQd7F
         fFNYM6dbtNcEA==
Received: by mail-ed1-f70.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so2989796edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rkZlJ0igM03Y8VkMiNizWzNDbnqGn+aUyjhq4DWqgik=;
        b=0HSNjCHnfx2D0KxH2VObIytaF6J5QO0dY6O0HpxYeZxroCYWDeWGEIzSmEgh02EOjK
         aIWShIEm2oClHsDiOKcuFORpZx6746BbqVYDXZwyLJex6y8oVXpO6nl1cqw/gg/xfXfP
         9Aq7ot358VGwtAj74UxLPmZl0T5CxkFGdtwzxa0CE5bhQ4Wj21wbtTTHoyM97nDEj3uD
         1wu70fkH+q5FRbsqF2e1OzcLtEnbC3bMBFh4NzKXD4WK96QttGcxjL0+i3QYt+tL3jZm
         9kRUIzxEy0rxLNbhWIXOTOv3Kw+zGMgn7M6ZpqxMbaucDSRR5c7774P1gme3rDPZMsm6
         wn9g==
X-Gm-Message-State: AOAM5339uYwGz+z1tzKJNTDbRWEvs/E9cE/vd9VvPBL747z/BwC70C+D
        fzeEKZ/FN79qNSwH6ESAoOQ2lwOsO7AZsR50z2hM3aDBdyc2nJUk4j/TiRmmpgGM9kzFoqH4Lkr
        zMir4McvLpSqCu3Xde0p7vKa9nw1mJ8CaAnK6a0RpJw==
X-Received: by 2002:a5d:608e:0:b0:203:e8a3:36f3 with SMTP id w14-20020a5d608e000000b00203e8a336f3mr2822206wrt.176.1647518244237;
        Thu, 17 Mar 2022 04:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPfOj+UeHfKmqSbS2Hx8bnxirl/NYvL3z9HsIpNergGiYK9EsV7ImtjHZaqXnE8okb/mRUOw==
X-Received: by 2002:a5d:608e:0:b0:203:e8a3:36f3 with SMTP id w14-20020a5d608e000000b00203e8a336f3mr2822186wrt.176.1647518244048;
        Thu, 17 Mar 2022 04:57:24 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:23 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 06/18] dt-bindings: irqchip: ingenic: include generic schema
Date:   Thu, 17 Mar 2022 12:56:53 +0100
Message-Id: <20220317115705.450427-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic interrupt-controller.yaml schema, which enforces node
naming and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/ingenic,intc.yaml          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
index 0358a7739c8e..74597a98f86c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
@@ -9,6 +9,9 @@ title: Ingenic SoCs interrupt controller devicetree bindings
 maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   $nodename:
     pattern: "^interrupt-controller@[0-9a-f]+$"
@@ -50,7 +53,7 @@ required:
   - "#interrupt-cells"
   - interrupt-controller
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

