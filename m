Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292E657E95C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiGVV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiGVV4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:56:09 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297ABA276;
        Fri, 22 Jul 2022 14:55:51 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MOgc4-1oB8jj174A-006Ayo;
 Fri, 22 Jul 2022 23:55:25 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Lucas Stach <dev@lynxeye.de>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/12] arm64: dts: mnt-reform2: don't use multiple blank lines
Date:   Fri, 22 Jul 2022 23:54:44 +0200
Message-Id: <20220722215445.3548530-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G3+JMN3SZGP97z7eS2R/aoA1WhKt3qcD5lFrLjPWN+s3aByzbu5
 wuFYvKnDx9h5vY4oPlVbwvp0JABucI63DgMOP3jUPJSV2wBa8HLlrJIH/wpWJSI8JFa5r4T
 h4IQvoXYs+9mVBMJeWbfvTGo/mxYuCf5D3HcCaM1uYeAAO0qw8cd+OzZQtc6JqpN6VqhcGP
 n/9UU2Uq81RYSuMO2PYMg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0bX20icuGnM=:60x0zKxl8KTgAbUnisWPo+
 VnNJQnCbPQ2Mk+/4GBG6OMXUCqtuDtymVE6RGYCcqSKPfAXmgC47ZvJywopP0fAuQSKne59ol
 aM2z8ixc0JhZKBSLdCOXciJOzviPqxKzoRUc0qQaaCgGxNeR+nPNn7K7MZYuYilCgw4fV5t3Q
 8nUvMz3WKHyFL3J1nNrtR5+bOB7A4EBDYA3tz9INIA6WrQfSJJYQ1QDKJa3uM9r3x7RrCDtJB
 ovwquGdFJeQg9Rz/lXGI05M4PmJe62GffuS/j0sN1+rmXO9ylXZi+gaoboqk3+esQZLjfX581
 AfJYYgjnDWj4PkfTHZGFpk8k1q96y/K4qDkbF2RoLnbHkgCHq3OC13Hvt5/FWLJ7pKZcM3HPB
 8OSdZmD4ZKmXxee1nA80+NZkdc/V0tU1bk0Fef2/2BNcnI8fiVidDJlCR61eOoKz7kmi0Eedi
 b4bF6fBmxWCRqBOoiYJi2KmUt/ESzngKaHrz6zVYo/ndV43ulCQExT4yxL+rT8CmYyfc/6lQZ
 JD7DY99AGD2GLafAXBzJBsNY8r26xqWQEm0WzKm8mETmtogd0vf9pcwoS7Vrf/GGXOdokrE4T
 lIAqSCS6f99YQM/3aBct9KBNks7+GeTYvMkCwPZOrI//C3b/jSM2NCt20wbDjP/gSHso7gzmR
 uL/zJa5FYa29cUanM+MbTwSLy5Nq7lUDur0cUCnGYDGj1FsiID7XDpHxaGxgiW93WsBSbEsV8
 0TjoMarpTCXgalhSJI/c2l9aaQ7zCCuy48ZHsisJ6zVIgYSXYVfiiimjjWQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warning:

arch/arm/boot/dts/imx8mq-mnt-reform2.dts:213: check: Please don't use
 multiple blank lines

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Acked-by: Lucas Stach <dev@lynxeye.de>

---

Changes in v2:
- Add Lucas' acked-by. Thanks!

 arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
index 8956a46788fa..055031bba8c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
@@ -210,7 +210,6 @@ &pwm2 {
 	status = "okay";
 };
 
-
 &reg_1p8v {
 	vin-supply = <&reg_main_5v>;
 };
-- 
2.35.1

