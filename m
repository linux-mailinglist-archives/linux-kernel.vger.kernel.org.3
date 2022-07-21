Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C658357D4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiGUUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiGUUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:06:23 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF848F50D;
        Thu, 21 Jul 2022 13:06:00 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MSLIq-1o3f2i3yEi-00SfP8;
 Thu, 21 Jul 2022 22:00:29 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stach <dev@lynxeye.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/12] arm64: dts: mnt-reform2: don't use multiple blank lines
Date:   Thu, 21 Jul 2022 21:59:34 +0200
Message-Id: <20220721195936.1082422-12-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wxRnpcaJD/zbR5t7o9St5KORsLb+1z2B/9t6M1zzcvJfQdSNaPP
 CoD3p+JqZ6tEJ2yk7cr3rxfzatrfo7JRlqB8Z/DDByzw/IYfIhIWUEaqufRsB2Ae6y68fOn
 acJJ0YleonMnuKJ1r763KxUy1CNiGufDFF4Y+vbK73Bo7oliGAyEibGXA6SDdVdwk3tHCJ3
 ACm8Uda608ao4keH06moA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uc6Re+vp0k0=:/D2o+Sn7IZW6EBMG7/MASN
 vulUL9DSaQqL0AYlvTOS7S7IOE/kOyOOaimswRPENDnSNoJ+6pjfC1EGxUKFNQpWbB61ApVdn
 df2TAEh0jvujdR5TD4wnLd5HSMItliYRoIJLepMX6BB9mYmUJ6CbjX5w9jv1dqW71ND6xSlUv
 bccOaLYHC5W8HcTxalwH0OthoT/zyx2osJWWThpV6c7JWElhienguhH1LA0qd8nvQv0OD5vt2
 gmf5RBu5K4DhoeHQAqpvmzbwQd6Tz77Ktw83XPLCEgoNKQCHokghWIPCXeLRhpWmLCI5iNEJe
 ZT9HE3gNveaGrR7GXJOaJlsI9C0lic5wHQ0PZlv84UNCQdD2D8dVR8rWSQfXL6wVTqIiRZWiR
 wdNGXJpeEDXRWBXBrDJOhZsPk1EmJtOZMorE1amxNEJJxYoL5+uHXFp4eDjjMoo91tAxQftlT
 TPm33UbRrRFKeXJgHYdTsKu31zJceooDg3QQio34wCR9RwQNeknIfuJ+WHiY5DKWza5/WBeIK
 rsuQNVX8y0/YP13q/VyQz0Pk1rqUGr5AZaL34Xy65cZPOSrWgd03MkoLrslZc86S/DpGx6N1H
 M2SvaqN93u5VGFnbwPLTgffXRr8oWiqYEIPaD6cbhcyxjtUZZCQg0NvDOdguQEUZfNCKoqVIm
 AEcszZg0bHDkiyl4VK6tYL3vQLxFgpmNsMJJG2eTSN/S/ekXmnH6qusxpf6eFOKK75K8kmvJh
 kmN5XUhhRznGncDEgNai8cmK0PJ59FzaxeMIOk1lT64+5qu+SPc6ds8NQDYuGKkOrYGKitqXQ
 hDIGPJZf2u6o7YR1B9dQoJOqNaPVRF7tUIDugOVwn7/SxoAJopQDybOfGdEGMqQCgDWR4Zf
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
---

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

