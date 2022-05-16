Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8A5285E8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243902AbiEPNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244061AbiEPNtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:49:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4E73AA6D;
        Mon, 16 May 2022 06:48:54 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MCKl5-1nzhtN1EGH-009CKI;
 Mon, 16 May 2022 15:48:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] ARM: dts: imx7d-colibri-emmc: add cpu1 supply
Date:   Mon, 16 May 2022 15:47:23 +0200
Message-Id: <20220516134734.493065-14-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516134734.493065-1-marcel@ziswiler.com>
References: <20220516134734.493065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:l+yk72S8bzPSdUADeEi9Zp+HG4TkeX/JRomRgvBrEWZQyxG+nX2
 T4QdwMPgHj9NIs717sinS6pmBzxIrSpe9LR5C+vyYMdF6/zRkmIEvsn3P6IEWCV26DS52b7
 73wyLENNTmjiiz0nv8btIGtBxkklyWU+cC24k6jln/JmFVdsrgFsxJbaQgIdihKrjhm89QV
 vlELvsqAr1Or/q9bE0VMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JCmllpc33FA=:4kpFrG4I112Xw5X/XyTMCN
 BuhV5sOcnS7JalOOee3oIH7ixo03WLD5XoCjxzvrWi+ODU/Y7N28pMMtgio3AdkYtaNIfQb95
 ZNaliq4Ep6SI8yH3xWelZx6wRRbpLcpyz2cRiqaAczggB5iMcXq4yu7ejGEoT2ug0n/KOScXD
 XGaZhvyuod+UYDCf70iiNjS2Y7l6M8T0BUkNTgDiqPC/e7+7Q5iKqSciOlUKoZnvYHcu7cz7Y
 0ztLztW+JNs0bOHN8XKSJm2eJqdCg5m1IFkHjybPz9uzlC99NAYF88DZ0BFrCYLOSdB4nTbFb
 TFj6FdEc4F+hbPNdCKMxgKBwCfTrRw8vsIxLmcA/bSz2V0XA7m6Ut1KPpapxGV/DuqOk8QDjb
 OdtmDwZDE00HEc6WXYAlMXM/TkS4fCuLXmAFFRobgkVlYPHHKmvXrp5Oi7Ta6uItylLPI1vBZ
 netA0BLkshgjJEBeMJS5VI7c4ONrVNE9U/VNZFGGIQAyw7MyqaGZQzzMRVPoWo9zjzF9fDC/m
 bx8gJlGyoSxFzHJenNkiLZiv843wG0JH2JjEmRN9p6tlh6NNgC91zxxRO0VEmHn7KNqW+hDg4
 oEFfWAfyIs3CCL70VDLkEf2UsaJOv2LpGhTllvDScIf6LpJPhXTTetj0OQ/YDIqy1z5cMhgEg
 Qt9YZ491cJg/VzS8C1VKEFoSH4+pLZhAsQjQiFjNhW41Lw6NZ/gFa4Fo0sWKaZfhlTyA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Each cpu-core is supposed to list its supply separately, add supply for
cpu1.

Fixes: 2d7401f8632f ("ARM: dts: imx7d: Add cpu1 supply")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 45b12b0d8710..2b4be7646631 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -19,6 +19,10 @@ memory@80000000 {
 	};
 };
 
+&cpu1 {
+	cpu-supply = <&reg_DCDC2>;
+};
+
 &gpio6 {
 	gpio-line-names = "",
 			  "",
-- 
2.35.1

