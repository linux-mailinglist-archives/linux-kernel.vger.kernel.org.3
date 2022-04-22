Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7BD50B8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448100AbiDVNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447790AbiDVNlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:41:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39E7583BF;
        Fri, 22 Apr 2022 06:38:25 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7D8641F468B7;
        Fri, 22 Apr 2022 14:38:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650634704;
        bh=9+2KVQa3DMg7UKEVPJhPFKwJCmwX4dRKAtLwy+ze6F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XnKtwNf3WY0fiPd3LifbCPX1N0sVm2p03RmK4hbJ0a8U5dheIJJt5yvjfVUPi0kRX
         cRS3VBK5jOQZqc81e4NS+MzrNPCHq5awwoTDKxGAa1JJITeaw+5VoqtzdwFfVjhnPy
         8muWxfnhx7hnVZxQg8o8KwJ2OsTqSm2J0lmpL4Ac8248prOxTYAPgkKDvWa6iUCa6V
         KAksFJ8Cbj5BfY1/CZOkgM0DyeFxfnyCA+V7eNRBFb8/yJ+uLZfW3tsIbMYIPcDP/W
         K8C7OXp09M721cKh61CBfO/OonxkcIz5B8cJMP8ASJ+JelxFA3TsPUVHEjxkfWK99B
         GQMoTAT+51nqQ==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH 1/3] media: dt-bindings: media: rockchip-vdec: Add RK3328 compatible
Date:   Fri, 22 Apr 2022 14:38:01 +0100
Message-Id: <20220422133803.989256-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220422133803.989256-1-chris.obbard@collabora.com>
References: <20220422133803.989256-1-chris.obbard@collabora.com>
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

Document the RK3328 compatible for rockchip-vdec.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 Documentation/devicetree/bindings/media/rockchip,vdec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
index 089f11d21b25..23f9687d862c 100644
--- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
@@ -19,6 +19,7 @@ properties:
       - const: rockchip,rk3399-vdec
       - items:
           - const: rockchip,rk3228-vdec
+          - const: rockchip,rk3328-vdec
           - const: rockchip,rk3399-vdec
 
   reg:
-- 
2.34.1

