Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636AF58B2E1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241836AbiHEXot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiHEXoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:44:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2B6D578;
        Fri,  5 Aug 2022 16:44:42 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A26F5C010D;
        Fri,  5 Aug 2022 19:44:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Aug 2022 19:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1659743082; x=1659829482; bh=0dQ5sBGNY8jDm8tF1pEhh6RL6mwkEymxNsl
        3o23Kxbk=; b=YpaCZmLOBjoAzzRmyNghk7UYTV8SN66kdCZZaPO2UEimHA8JwHs
        I+EKQL/bw6bDd/CEQI53rHZj/vqPTLzCU3WVw0+70Y6iENFh6/ULObfClFNJ9Srk
        Vp1F1nAnjIiIFillr+1zZVe+DD37OLEoY/NcY8zo7t0OXrIb7rxzec8d0veiBAYD
        MGx6jA5LO4Zf7uDWuL6sEz0Vgrkk6KyBx334Y2cVmcygGbzSPLU5tOQi7mqswnfZ
        tdhWFnuZzFi8ma4rOB1GpuGffes7nR7yZK8hmmtZRP2P8wPUAuaAET7pPw2akakK
        HdFsELn16vGkk3FMRYmhDlr0hxdwc7QBtTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659743082; x=1659829482; bh=0dQ5sBGNY8jDm
        8tF1pEhh6RL6mwkEymxNsl3o23Kxbk=; b=DrDuQXw6Wzcvao6TxmsfD4PlvEM5b
        D85P5lSMhCUoBzF6xuC4XntkWOwIPFWNQDIjCAGTQnvUSdukNigqypLThYXtwQjh
        tK1lKGlr5oVKyULP46DFmsuQrNqXvQbfSe0lJtb+8dMg3Q2zZu9jvdiS8APU7NAE
        vqo4w8nQT8ijzsRCTyDOxRURk0i6+dl3tNr//5dsht4aN18+bHJWRwGPxlcrpQpc
        AEOIBywJrU5C8zaIEvKuSK0ug0iBFiu52NH3YOE0i+T5Zo9608EOOF1qqvbrgIHf
        OzOvIoKNadmzayGx1VMLC8eOOBTlQkGcKxWcgbF5qBQ3iIYoqnQ/dLrHQ==
X-ME-Sender: <xms:aavtYlQNZ0lTNeFLXJ-sRMSO0XN0IKGrSVVSghO_8eSjj4wPlgZi1A>
    <xme:aavtYuxAQEB1TnqFnJ4DmlRVLwLBl0EGWgoISgJESkCky_1IyGMbuRutNblrxorYc
    -Hv7myYIMiFViKXew>
X-ME-Received: <xmr:aavtYq0EoI7SbJvFKmcOHU1WJuOmkMzvNstyn5IBCdqumS9VHEHSxSl64jRlvEfQtKdVBaDjyLR4MWFEPKv5eo7wnJQRzDXq6Jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefvddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeefgeejteevgeeilefhgedtteetvddvgeekudfgtdeujeev
    ffefuedtjeejlefhfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:aavtYtDXtBiYyzEU9mKHQgQg3emn5hSulYmBfKUM5pB3klV2emY4mw>
    <xmx:aavtYuiH6I5jSG6YjTRhyryzWLjQlvU9SDntdyAfzAOKVPddAngJFQ>
    <xmx:aavtYhrq4r0OJ5t-cGepdZqcjwnGejVsT3F3C3B2k1Duh2qs9So_lA>
    <xmx:aqvtYu7U2Rv3Gjovtu6dvooVvLg58KODCrVX14i17rAoFZ0htzbLKQ>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Aug 2022 19:44:37 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de
Cc:     tom@tom-fitzhenry.me.uk, megi@xff.cz, martijn@brixit.nl,
        ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Dionne-Riel <samuel@dionne-riel.com>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: Add RK3399-T opp
Date:   Sat,  6 Aug 2022 09:44:09 +1000
Message-Id: <20220805234411.303055-2-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Dionne-Riel <samuel@dionne-riel.com>

These tables were derived from the regular RK3399 table, by dropping
entries exceeding recommended operating conditions from the datasheet,
and clamping the last exceeding value where it made sense.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 .../arm64/boot/dts/rockchip/rk3399-t-opp.dtsi | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
new file mode 100644
index 0000000000000..ec153015d9d13
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3399-t-opp.dtsi
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2016-2017 Fuzhou Rockchip Electronics Co., Ltd
+ * Copyright (c) 2022 Samuel Dionne-Riel <samuel@dionne-riel.com>
+ */
+
+/ {
+	cluster0_opp: opp-table-0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 925000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 925000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <850000 850000 925000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <925000 925000 925000>;
+		};
+	};
+
+	cluster1_opp: opp-table-1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp00 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <825000 825000 1150000>;
+			clock-latency-ns = <40000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000 825000 1150000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <816000000>;
+			opp-microvolt = <825000 825000 1150000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <875000 875000 1150000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <950000 950000 1150000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <1416000000>;
+			opp-microvolt = <1025000 1025000 1150000>;
+		};
+		opp06 {
+			opp-hz = /bits/ 64 <1500000000>;
+			opp-microvolt = <1100000 1100000 1150000>;
+		};
+	};
+
+	gpu_opp_table: opp-table-2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <825000 825000 975000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <297000000>;
+			opp-microvolt = <825000 825000 975000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000 825000 975000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <875000 875000 975000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <925000 925000 975000>;
+		};
+	};
+};
+
+&cpu_l0 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l1 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l2 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_l3 {
+	operating-points-v2 = <&cluster0_opp>;
+};
+
+&cpu_b0 {
+	operating-points-v2 = <&cluster1_opp>;
+};
+
+&cpu_b1 {
+	operating-points-v2 = <&cluster1_opp>;
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
-- 
2.37.1

