Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC6150E87F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbiDYSse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbiDYSs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:48:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C02187;
        Mon, 25 Apr 2022 11:45:20 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C254B1F43008;
        Mon, 25 Apr 2022 19:45:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650912318;
        bh=ZflrCY90qDvsRTN/89T+MYpE5uYdGwBIfCIw17JRHS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNUGDF8zSp/x29xQ3kgPbHSYcmms/sNvtoaNvO+Zu9wh7RigElOutLh5cCi8QiVMp
         mEn9qYSyNPJ7HdVNsGrTrVZfgnXft1bsTmWtMxklAC4LilSUJ/gyAObAECxgfd5tbx
         y8Pa+FvtdQV6/BLqS76YkPS75gyYH5vg8ZLSRS9B5AxFCCJLJoRrCx5SoZLWwSv3cg
         of4k7AwoxhRB4RU1Sgd+uuuze2i2oEFSQV/PgNmxz7pIaLnnL4MyNcNu6EHA/13PJp
         iqTxAoXvh3j68xHOjpxivTSiXWMTXnBueB/cBLvszbYL/FtMapr3HYDIIZRJgYyjNS
         pzgbVK1EsuzQA==
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
Subject: [PATCH v3 2/3] arm64: dts: rockchip: Rename vdec_mmu node for RK3328
Date:   Mon, 25 Apr 2022 19:45:09 +0100
Message-Id: <20220425184510.1138446-3-chris.obbard@collabora.com>
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

All other rockchip devices which have vdec nodes do not
have an rk prefix. Remove the prefix from the (currently
unused) rkvdec_mmu node for consistency with other
devices.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc7f1..f8ef149fedad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -660,7 +660,7 @@ vpu_mmu: iommu@ff350800 {
 		power-domains = <&power RK3328_PD_VPU>;
 	};
 
-	rkvdec_mmu: iommu@ff360480 {
+	vdec_mmu: iommu@ff360480 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

