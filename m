Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F360657D49A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiGUUGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiGUUFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:47 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D387D78592;
        Thu, 21 Jul 2022 13:05:39 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MNLN8-1nr1z11Efy-00Os3M;
 Thu, 21 Jul 2022 22:00:09 +0200
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
Subject: [PATCH v1 03/12] ARM: dts: imx6qdl: phytec: no spaces at start of line, indent use tabs
Date:   Thu, 21 Jul 2022 21:59:26 +0200
Message-Id: <20220721195936.1082422-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VKXkMhIQQSDJrUgTBU2oMJUsgYpfJFpdVvRkZBy+iUzHC36v+nn
 oiuQTplGnnlHUwzR9Ba44htaqXYMTVF3izceUHyGYSBVHhojWz1aDGUtLiE1W6m+sSybFWj
 GbSr1GxNV4dHYBwyHdTixhxHMbHryt3IDVIPsDkYMmXHdYHgXF3bPlUKe5rhXQ9Cu13ktC8
 jUnVn6GHvJbeUaxaF2Cgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mh7BWPW+bCw=:VbwDoDros1uKCIHUNQuKsT
 x5AjM/QhGlOQXN1h2HMO9NjyDeTbHVVufxK8Kgj8wwtHgan1IRuSpDdBKWcnX0ifjvC++nqQ1
 FF78teNv/Tmb9GYQr8LeFeORZX3t+ptkbT6QU4zseUP5gDD9ZjvXObJj98V0n9wN9F0KMQtU6
 h+X2GIBOhoSz4nY7uDy92K0Oy4VqaHQuncdsY7Yq+9o8v5AXFrTA2GPJb/H3GkvoGSFd0hBCO
 CjsufRnZgTiQdjghjKBJ/7yIJYfOFA/ooBUaLzGyObmKq7c6AqroRr2PIZMV5qTY2IaXsOT0B
 Qg+BNuFNlst+O5S/5HPkLUnYC1PTQHopoj7rq9qWlh5daC/3G0rvhHESX1yydIbaK1TbEmpBW
 wdwVyykqkVvdPVZ8m9HOO/xEFiMJbVR3L5egI2jgBHkzrITXVYQmTslKc1wyQRm7/fIUxGy8R
 IY4DkvfLdUQ74hvwA0j0hQTE+5YGLYLJb8nCEmZQx2rDBLec9VhqKA9YWFGEP3aq9Ac2GLHEs
 iRjnf5cBwBKDpksx5aPcMd6M4ibn/PFQO3952BL7+uFj4sJuOVuxuH0pM2Lk1zAEGajKsi4mb
 /tfD6bz9WIvibR5ToP7up8dyw9Qq4XYyumjMQSOaN6AeFCQPGzILBAnfCipYqdLoCz2yLQ6q3
 NnIACAb5dM8nD+vAYLjeaqhLIHGadIdRREh1YPBIz7BKa3zsaFN6tDsOjaGigU49OpBBZPwLf
 6YEVCvMp70IMT5/sinaYctuhy62E/Est8S2/jMgVwZOVdUg3qvWArKUw/SDtNo8l/O3AqfDSd
 AGUKVuULtMnkDXZdLMTRCqqTUd47Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid the following checkpatch warnings:

arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi:67: error: code
 indent should use tabs where possible
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi:67: warning:
 please, no spaces at the start of a line

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
index 393475cb0f4d..0020dbb1722c 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira-peb-av-02.dtsi
@@ -64,7 +64,7 @@ edt_ft5x06: touchscreen@38 {
 		interrupt-parent = <&gpio3>;
 		interrupts = <2 IRQ_TYPE_NONE>;
 		status = "disabled";
-        };
+	};
 };
 
 &ipu1_di0_disp0 {
-- 
2.35.1

