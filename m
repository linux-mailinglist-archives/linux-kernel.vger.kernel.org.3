Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C2854A9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352475AbiFNGtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347970AbiFNGtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:49:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF33393EF;
        Mon, 13 Jun 2022 23:49:03 -0700 (PDT)
Received: from beast.luon.net (unknown [IPv6:2a10:3781:2531::8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sjoerd)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ED7E766016A0;
        Tue, 14 Jun 2022 07:49:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655189342;
        bh=jkDWtxylBKBy28k5wc72Q/jk9P8La9hOif7PAsiY5Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmfWbWWxi8uugrlBYYsFatlNc3TCiDlhfUZPSWpWur39G6F6CPs+06LMnBeEZ5t5Y
         boxJusqGuOPI9PPslMWFNPcjOfh1vCFPc76Q94dHrzrLlFNbv3VJotMe6wDGZsCSR9
         sILIwfzB2lRuvrTjhlCNdvTMzi4YETmvWivZMsGH+mL2EfJRfsXeyZEpYO169TG/jD
         EN0icKsaH6jXJQ0FrPkaUuVl4bhWU6B5zSGqE8LHHZlvj+EZa+kUXuNKDAuatj8aBu
         Gev0NHr2EChquJyLkpbC9gzy6HiQqvEn1OHrWGu0CwW0NidRqMFzn7woT9AtT97jey
         Sa8Hq+B468oWQ==
Received: by beast.luon.net (Postfix, from userid 1000)
        id 0085E4179E42; Tue, 14 Jun 2022 08:48:58 +0200 (CEST)
From:   Sjoerd Simons <sjoerd@collabora.com>
To:     linux-rockchip@lists.infradead.org
Cc:     kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Levin Du <djw@t-chip.com.cn>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3]  dt-bindings: arm: rockchip: Add Radxa ROCK Pi S
Date:   Tue, 14 Jun 2022 08:48:55 +0200
Message-Id: <20220614064858.1445817-2-sjoerd@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614064858.1445817-1-sjoerd@collabora.com>
References: <20220614064858.1445817-1-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for the Radxa ROCK Pi S board

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index cf9eb1e8326a..7811ba64149c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -554,6 +554,11 @@ properties:
           - const: vamrs,rk3399pro-vmarc-som
           - const: rockchip,rk3399pro
 
+      - description: Radxa ROCK Pi S
+        items:
+          - const: radxa,rockpis
+          - const: rockchip,rk3308
+
       - description: Radxa Rock2 Square
         items:
           - const: radxa,rock2-square
-- 
2.36.1

