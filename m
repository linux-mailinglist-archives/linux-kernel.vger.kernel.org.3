Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603484F9CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbiDHSkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235715AbiDHSkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07A26118;
        Fri,  8 Apr 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443084;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=EFw52lCBcI2KDTGrZml+fv4y2JrmRJllmgb/pW8/4Ag=;
    b=PA+AdsVH/an68XDIz+s+juD3WA6jlRfOi/tT7DPuw1DCPrt7QQmpZCgPS2W+gvZVzs
    yxVdVgC+/BFy9xgIfjn/OMi/WXhR1UT/wPbZI/3mNs2nPzIs7vWZHfs2xqdpyWLnKhU3
    5LN7bJaXoY66WmBgcKZ7F/jXumsEE6lolBQ192E94FbYzqZqfH2trfm5t/xEohzPe21u
    k3gFRVludb2YMK+z7nhYLYlw/x/ReiLacbAubOOxRqFqyNgIgbhbhT/FugS20NAhfqhK
    TcYjPyWa57/wK1bD7aua65+Xo6ftixikIfPUkW/zJI6VfVgPJJGF68W8cIGF1B8z3Qag
    0Flw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic4snx
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
Subject: [PATCH 06/18] MIPS: DTS: jz4780: fix rtc node as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:49 +0200
Message-Id: <5b4831407a68c22fbc63c7d29dd608ebfdd4cef2.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: rtc@10003000: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4780-rtc'] is too short
	'ingenic,jz4780-rtc' is not one of ['ingenic,jz4740-rtc', 'ingenic,jz4760-rtc']
	'ingenic,jz4725b-rtc' was expected
	From schema: Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b5299eaffb84a..2021836983c96 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -145,7 +145,8 @@ ost: timer@e0 {
 	};
 
 	rtc_dev: rtc@10003000 {
-		compatible = "ingenic,jz4780-rtc";
+		compatible = "ingenic,jz4780-rtc",
+			     "ingenic,jz4760-rtc";
 		reg = <0x10003000 0x4c>;
 
 		interrupt-parent = <&intc>;
-- 
2.33.0

