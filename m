Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565C04F9CFC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238865AbiDHSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238793AbiDHSkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:21 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3D62D5;
        Fri,  8 Apr 2022 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443085;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Upo1TA3bCbaFVnv0eAVT44wfRU9hzU6iWyYVIpYKZeo=;
    b=hOCZ0Xc7nYnlekB2MZVTVwo+ADis4WJAmdwXTpoFgutmyqTIWUy5HXcwbT9tjf1RJL
    jlVzUhefm2G9C/2XNjAZ8aHrO+1PuqiD8YxbtOE2iOHuUHai4rsV+UfgGYv/iFnhBeGs
    C6ZFYzkzuGtKYtBfjBQ3ejeomwCscyuF/tdL2jmpT0ZEJ9Qn6a5QUcjq5JZJkHe3ssab
    r2UgDotb/rE9yNXeTHmMiuiWko3woHZH+Nf2gEEaz2tNby8CKJw6gEvuGK/o810wMKBx
    bEKLCcjFZ6DDCae02JljeAoaAXpFgYT4er8susegr64BlZTkIeQ1cQYsMqP+AdmBmw4W
    xVgQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic4so0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:04 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 09/18] MIPS: DTS: jz4780: fix dma-controller as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:52 +0200
Message-Id: <fba7fa695369311dab9ed9b1c929a0c57a1e8f98.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: dma@13420000: $nodename:0: 'dma@13420000' does not match '^dma-controller(@.*)?$'
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/dma/ingenic,dma.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 8b95486c8afa7..dc88f9e813453 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -515,7 +515,7 @@ eth0_addr: eth-mac-addr@22 {
 		};
 	};
 
-	dma: dma@13420000 {
+	dma: dma-controller@13420000 {
 		compatible = "ingenic,jz4780-dma";
 		reg = <0x13420000 0x400>, <0x13421000 0x40>;
 		#dma-cells = <2>;
-- 
2.33.0

