Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1587F50E889
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbiDYSsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244515AbiDYSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:48:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809012183;
        Mon, 25 Apr 2022 11:45:20 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 94EF21F43001;
        Mon, 25 Apr 2022 19:45:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650912318;
        bh=eTCQfIcIP5R3rqMwABBjjXqfLJPdf96Z64Uo36McT3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzAEo4CyRwc5ubpWR2DEkfMRLzrnj2G+ZgXJE4kKIiTeW+iZtEBJP6rJy2E2ONYET
         g/xlzVBxm99NYRjWHtFzaB5U7susvC3oxlVAjmmq3Q6XB4D2YfRfjPrl2UkxMmK+Sx
         mjx93EZ5d5SFq8kY8f53RG0Zjxnygbrj0IhL9DFacFmMS9tNZ30Mw2ltz9o/RMO48N
         4hQ8x00FWICkbi1VHyyfIx4znKrhaVKpQ4KDsWoJqpI8TWgpQKHjIkObUYnRCUcg3y
         xo6Rw9gqjIBudMrIYGhoEKvbXSe/nwRT5pe/l5Q2C6IdrFD6wgouZMfIa3Pk6+cKoS
         NyT0qMJalT+Gg==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v3 1/3] media: dt-bindings: media: rockchip-vdec: Add RK3328 compatible
Date:   Mon, 25 Apr 2022 19:45:08 +0100
Message-Id: <20220425184510.1138446-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425184510.1138446-1-chris.obbard@collabora.com>
References: <20220425184510.1138446-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the RK3328 compatible for rockchip-vdec. The driver shares
the same base functionality as the RK3399 hardware so make sure that
the RK3399 compatible is also included in the device tree.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
index 089f11d21b25..3bcfb8e12333 100644
--- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
@@ -18,7 +18,9 @@ properties:
     oneOf:
       - const: rockchip,rk3399-vdec
       - items:
-          - const: rockchip,rk3228-vdec
+          - enum:
+              - rockchip,rk3228-vdec
+              - rockchip,rk3328-vdec
           - const: rockchip,rk3399-vdec
 
   reg:
-- 
2.34.1

