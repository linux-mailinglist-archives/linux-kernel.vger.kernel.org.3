Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0EB50FF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351128AbiDZNpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351059AbiDZNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:45:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B348D3CA58
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so25559643wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WiMjqWr2rsQkaBLMdtHZGm9iFmjCwz/X0cFtlbeMbU=;
        b=mMT97IDgEHYlbhiTTxwI72dtKJRNNtraEazEdhQ/1+YombRbDcfLnDCwnj54oiuFZM
         FovrX6lSuitpqUzu9jUJ7nsCKE/ZVtOBg/LFWmB33MskN2xoLOcCbAYUUHhBLf2bEVjt
         8TsMe1h3/CgL0gRVqs8VWprUHUtA4OE/YQdHxfoIKwhQYdP6vg328RtAtADmSoYcFM8I
         i0PYbWuSXY8crl2h6fYDPA+CDIfDFhVFA5V6OXhMOhQWl2dX+npfWyC8xS+MjX0ONbRu
         w1Elkgp5YYWIaK1wiJypr/20J6ugzWkTVB43oXyomvH+CZbmIgEhpY7dTM5v0c+xDDud
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WiMjqWr2rsQkaBLMdtHZGm9iFmjCwz/X0cFtlbeMbU=;
        b=yJ8eXg6UDcJ9J5Wu31Ktq41k4VYhAkV3rltx2WggjaHdEamK3GtmeAl3zgLaVeQtcc
         9LtrswcYq4Jqvw6TSEgI1F3nw8HdWbBONd6ul1fqdg1NetAcxgUaPRgO3ESZP0T2PBSR
         mszio+U2XsAghWK6XxuqQTCk3O+SpqEyBspo0u/lhrxoPqFCNNpSSCgrQYTdiodnAA2n
         +Pw6qSNTZwPTF5EBJZdKEXwOordxk+TIcIecJyuUOyrwYXDQGf2wZMhCKsrJ3TSSl3+r
         nEMSFO8O5qTJzPo4JSHUOoci8EcJtHsbIOJVZiiSJniIPZwoDgJ4m6xAJNZJcXWDtJJ/
         8U/w==
X-Gm-Message-State: AOAM530Dqtjk7TS0gSmZdn21L3kGFRN36m4+PAEGVScWh/jNx8SDUGHg
        RWJHVZlFjhZD0fdCgQEJFYLDIg==
X-Google-Smtp-Source: ABdhPJw1ZH7IdVVddcYsXC8gaDPJgCy1xQQ7ICVPpYhMiOh4ni1tkFYXXnPGKsa/Iahi3/JTftqvng==
X-Received: by 2002:a5d:620f:0:b0:20a:d560:9996 with SMTP id y15-20020a5d620f000000b0020ad5609996mr12288405wru.471.1650980510326;
        Tue, 26 Apr 2022 06:41:50 -0700 (PDT)
Received: from radium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id b6-20020adfd1c6000000b0020aac8a9946sm13628475wrd.47.2022.04.26.06.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:41:49 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Biao Huang <biao.huang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: mediatek: mt8195: add ethernet device node
Date:   Tue, 26 Apr 2022 15:41:01 +0200
Message-Id: <20220426134106.242353-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426134106.242353-1-fparent@baylibre.com>
References: <20220426134106.242353-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biao Huang <biao.huang@mediatek.com>

This commit adds device node for mt8195 ethernet.

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
This patch comes from https://lore.kernel.org/all/20211207015505.16746-7-biao.huang@mediatek.com/

The differences between that patch and this patch is that:
* The EVB dts modification has been split into its own commit
* The patch was rebased to fix merge conflict with the upstream mt8195.dtsi file
* Re-ordered the node to be correctly sorted based on node address

 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 70 ++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index aa05071a80b8..a58641d1cab0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -912,6 +912,76 @@ spis1: spi@1101e000 {
 			status = "disabled";
 		};
 
+		eth: ethernet@11021000 {
+			compatible = "mediatek,mt8195-gmac", "snps,dwmac-5.10a";
+			reg = <0 0x11021000 0 0x4000>;
+			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupt-names = "macirq";
+			mac-address = [00 55 7b b5 7d f7];
+			clock-names = "axi",
+				      "apb",
+				      "mac_main",
+				      "ptp_ref",
+				      "rmii_internal",
+				      "mac_cg";
+			clocks = <&pericfg_ao CLK_PERI_AO_ETHERNET>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_BUS>,
+				 <&topckgen CLK_TOP_SNPS_ETH_250M>,
+				 <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+				 <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>,
+				 <&pericfg_ao CLK_PERI_AO_ETHERNET_MAC>;
+			assigned-clocks = <&topckgen CLK_TOP_SNPS_ETH_250M>,
+					  <&topckgen CLK_TOP_SNPS_ETH_62P4M_PTP>,
+					  <&topckgen CLK_TOP_SNPS_ETH_50M_RMII>;
+			assigned-clock-parents = <&topckgen CLK_TOP_ETHPLL_D2>,
+						 <&topckgen CLK_TOP_ETHPLL_D8>,
+						 <&topckgen CLK_TOP_ETHPLL_D10>;
+			power-domains = <&spm MT8195_POWER_DOMAIN_ETHER>;
+			mediatek,pericfg = <&infracfg_ao>;
+			snps,axi-config = <&stmmac_axi_setup>;
+			snps,mtl-rx-config = <&mtl_rx_setup>;
+			snps,mtl-tx-config = <&mtl_tx_setup>;
+			snps,txpbl = <16>;
+			snps,rxpbl = <16>;
+			clk_csr = <0>;
+			status = "disabled";
+
+			stmmac_axi_setup: stmmac-axi-config {
+				snps,wr_osr_lmt = <0x7>;
+				snps,rd_osr_lmt = <0x7>;
+				snps,blen = <0 0 0 0 16 8 4>;
+			};
+
+			mtl_rx_setup: rx-queues-config {
+				snps,rx-queues-to-use = <1>;
+				snps,rx-sched-sp;
+				queue0 {
+					snps,dcb-algorithm;
+					snps,map-to-dma-channel = <0x0>;
+					snps,priority = <0x0>;
+				};
+			};
+			mtl_tx_setup: tx-queues-config {
+				snps,tx-queues-to-use = <3>;
+				snps,tx-sched-wrr;
+				queue0 {
+					snps,weight = <0x10>;
+					snps,dcb-algorithm;
+					snps,priority = <0x0>;
+				};
+				queue1 {
+					snps,weight = <0x11>;
+					snps,dcb-algorithm;
+					snps,priority = <0x1>;
+				};
+				queue2 {
+					snps,weight = <0x12>;
+					snps,dcb-algorithm;
+					snps,priority = <0x2>;
+				};
+			};
+		};
+
 		ssusb: usb@11201000 {
 			compatible ="mediatek,mt8195-mtu3", "mediatek,mtu3";
 			reg = <0 0x11201000 0 0x2dff>,
-- 
2.36.0

