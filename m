Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677A549B0F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244019AbiFMSFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245222AbiFMSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:02:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F819C749
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=npWjvzhsC/I+KDz3b5Enp28V0QP
        Y/tcnzIoOp9yAwTI=; b=3pbk5bzXIwJ4Fo+lYWHScCMXRcasByP0u2JjaH+mdcT
        PLnzj4DOJncnwbwT8VwvZXtte3HZrcOwtROk1QrDfqmMEK3VpdWaPlfLUzARiHUH
        uQKUY/CRz/23IyvcIUmiFWQvMP0pkpniZymPduKkONCnZLE8w+DLPgEXQYGaTbHQ
        =
Received: (qmail 1316216 invoked from network); 13 Jun 2022 15:49:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:49:18 +0200
X-UD-Smtp-Session: l3s3148p1@zD7sjVThX2pZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: renesas: r8a779f0: Add DMA properties to SCIF3
Date:   Mon, 13 Jun 2022 15:49:12 +0200
Message-Id: <20220613134914.18655-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm64/boot/dts/renesas/r8a779f0.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
index ebc4a052207a..c872030ec4fe 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0.dtsi
@@ -314,6 +314,9 @@ scif3: serial@e6c50000 {
 				 <&cpg CPG_CORE R8A779F0_CLK_S0D3_PER>,
 				 <&scif_clk>;
 			clock-names = "fck", "brg_int", "scif_clk";
+			dmas = <&dmac0 0x57>, <&dmac0 0x56>,
+			       <&dmac1 0x57>, <&dmac1 0x56>;
+			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
 			resets = <&cpg 704>;
 			status = "disabled";
-- 
2.35.1

