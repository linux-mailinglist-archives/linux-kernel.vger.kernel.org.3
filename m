Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2771571CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiGLOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiGLOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:37:59 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 07:37:58 PDT
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE9237CB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 07:37:58 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7242241207;
        Tue, 12 Jul 2022 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1657635687; x=
        1659450088; bh=AaOui02YEi9Ip9b2cycfHTnE1G+dZu4PYyIF31Vbb5A=; b=R
        KFSZXqXSZEsbdWU2b8VjtMUNQWoisI4jpNNIdVUKssbvgYuSs80ZJHrYpE7UxvME
        lV0hbge3sDEa48iO/ZbFVRsu9qivQpSwN9ZWsn488lwiYQNYvyRvHe+sOoSwxlH3
        XPWJGLyNkI9tvFaK/g9bdZ+b9s+//NrZqFG5v2hZAQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Hjv7YybZuw8Q; Tue, 12 Jul 2022 17:21:27 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 6317941209;
        Tue, 12 Jul 2022 17:21:24 +0300 (MSK)
Received: from T-EXCH-06.corp.yadro.com (172.17.10.110) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 12 Jul 2022 17:21:24 +0300
Received: from v.yadro.com (10.178.114.10) by T-EXCH-06.corp.yadro.com
 (172.17.10.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 12 Jul
 2022 17:21:23 +0300
From:   Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
CC:     <linux@yadro.com>,
        Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Stephen Boyd" <sboyd@kernel.org>, Zong Li <zong.li@sifive.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] riscv: dts: fu740: Add PDMA node
Date:   Tue, 12 Jul 2022 17:20:38 +0300
Message-ID: <20220712142040.12021-1-v.v.mitrofanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.114.10]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-06.corp.yadro.com (172.17.10.110)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiFive unmatched supports PDMA but is not implemented in DT.

Add the PDMA node in SiFive FU740 soc-specific DT file.

Signed-off-by: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
---
 arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
index 7b77c13496d8..4bd670d8632f 100644
--- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
@@ -161,6 +161,14 @@ prci: clock-controller@10000000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+		dma: dma-controller@3000000 {
+			compatible = "sifive,pdma0";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic0>;
+			interrupts = <11 12 13 14 15 16 17 18>;
+			dma-channels = <4>;
+			#dma-cells = <1>;
+		};
 		uart0: serial@10010000 {
 			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
 			reg = <0x0 0x10010000 0x0 0x1000>;
-- 
2.25.1

