Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5A57D495
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiGUUGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbiGUUFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:48 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55A7AB2E;
        Thu, 21 Jul 2022 13:05:45 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MjSkQ-1nmPPR1kra-00ksye;
 Thu, 21 Jul 2022 22:00:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/12] arm64: dts: imx8mm-venice-gw72xx-0x: blank line at end of file
Date:   Thu, 21 Jul 2022 21:59:32 +0200
Message-Id: <20220721195936.1082422-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GqaoRioTEcIvo6dSM/1jC4iz4Jq7OV40cbLVdTPcSSKUkRGz9aJ
 4epxJeao5C57e+PlYYo0SO99t8Am52yO1GtgJPlAHGr+Hdd2LIxdlqa6n1mKHT0uXqP+M8a
 1eI0pO2ik4QoFZZC2AmlhKVf2oLpMaW/5910y55XmrvZzWD/nHvIN8iEXoC7qtt4QwTIuNx
 69CV1bUhioikILvPL+Eyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Tio/VME0f4=:l0u6SA/9XCB1CQx6zGcvCz
 u4xpoqSkuYk752O5s96RN5HmYl0cDOGLg5kw5/1ALkFBGuM8fENqIDN1G+ZL/NN5t8yU8dIYa
 tFCJY/+h94TBL3I8HK/rqkVHiuVj39S1Fjgofjw58ZPd6jIuG7qsBGyJg90zwxY8Wej1tBmlF
 FG7UJpm/VOsz9tuDjx+r1WS206tsyLm7wYneWk+oLdO7aXBRuSZoU8M8gT98+Ey40ZHGe7BVC
 BLp37ygGjpFECINvc4quENbNUntLcEKmONJI8cmAUXKnhFhzxeeOGxdYKjeuzYi6+58V+1ogY
 MyEpabOLXub0hJPPwFmz2ruYL8EhySRELxJ0Lgrg6o+cXJ7H5gW5d2ZyT/aMdsWuRyl50yGKG
 x4wipTeBn/NRMMVoGvMLBdyyC3M0tI0SPhVomLHHjBQn0dqKDPfgImZXaxNlsKXb8X9YOMyhy
 3U8H8+qlpMfYiZ+d2/gQ3m32tClVtacqXq2KsICmnHZlHDSb0UmRscUWV2KT91eooEqIEDDj/
 pdfMiNgapcD/PSbYdJS5dXox80Q+fLDog/37Wzt3g5TOTiqHe/7DaHULS6PHYbv8S60CMR+FO
 umg+FOh4FGgu+Gdk24m/Tb6AufwS2h0J/q/iiBPKZ+8NZKcqSwMIEtOnzcfyw4zOKuJAKUsFx
 w0kHpF8b6q95h8vEzLJMuYOsBM6rffEjkQklZNunE5Kr/PSa37P0qtiW9p8r3CDi7+khEEHCC
 F/qva5KHMnvujosYg2NFnlee7dDgY9g8fMz8TrfBf54HR80jVConTO0wHeU=
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

Found possible blank line(s) at end of file
 'arch/arm/boot/dts/imx8mm-venice-gw72xx-0x.dts'

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
index b1e7540f0281..641be3af989d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x.dts
@@ -17,4 +17,3 @@ chosen {
 		stdout-path = &uart2;
 	};
 };
-
-- 
2.35.1

