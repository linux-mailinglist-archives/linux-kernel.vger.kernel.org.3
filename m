Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EC250E4BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiDYPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243020AbiDYPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:52:41 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D3911483F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 08:49:34 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MWj1Y-1nPCsS0WCG-00X6Jv;
 Mon, 25 Apr 2022 17:49:04 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     netdev@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1] net: stmmac: dwmac-imx: comment spelling fix
Date:   Mon, 25 Apr 2022 17:48:56 +0200
Message-Id: <20220425154856.169499-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mu9bK8rJ3RbONCPFleKxVm8y/XpyuFrUVOlp1t0I5GIjR1cPhEp
 JXL2fZSF7pPFx+xTLi+Aq49pJ3HiFN7lMVBI5Ts7TddFRGXvGB8ygr02VXUz6QVaext0RNv
 +0P+v4g9NVXW08d3j/ux6QoYDTiJxxLU3Q2TBwAn2swEts57tAooR2Xv62D0OE3jtmYwz7X
 cYO02AscjIs8qBwD4vRNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j2B6w7sRz5A=:H2LH+imHelZRraqcpsmDEw
 v5m89hm+aXC6XzB1O8wayiMM3nA55ivKxJUyt+s2aAmbwKYyZ5OVh0GrPJq3Jp6GUx+8B5cWl
 M78PYkteuFzVRqrt0YcNKS67xmxhYd4UozN+mTAlIjXfwAkIejjc8mduErb1SQB0FlpVZhOvx
 mVrONK/GyaMEk21QE0+oQgTLq04LdDjIQLFdmt4/8Q0Df2F0BsF4ZvOWdeoxHjgTFTdhIGf8W
 BrG4csduL28uXosg+PxhKhnnjMHrXmnhcTYiLnJHtIObCG7d7AyvfR4ZsMfD33fF07uG8WqkL
 uqSRr5lZVKrmHexSS5Wi5tmzDXYvZN5xfZ69/4WOEIzCqLNH2GrH955YQi77BFeHAOTtQxRNC
 p0NkQmjxtA2NylL8H0Qb9xbiVfhNDs4dS1sPC5Hvq+mBecA+0L0/VtjfX/fAj9am+7WNYU+WV
 60kr5AEaD6tMqbhpmreaAghgyT2VP0jEyo9S0Kj6nvapFSmuNoqWqHyRJ4ZI8OgavYbrnimUh
 0Y7SVjKBndSEuYENyfhIeemP3XIq5hHijW84t7VWisBM1tvMJPra9P6D0qjVVoZ+1UCmPBiFo
 hxzso2PpKA40z/uN9w+dKJfYXW1vg9YzgTj+kamkKhXsFn+uG/wChkODJqCK8FpcQ4ixTBqiO
 MwVc3AMVIYs8bRK2Ejl12lybChnAr9BWaTg3T2q8vmavxASnLNlQa43bjlOcWTGceo9g=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix spelling in comment.

Fixes: 94abdad6974a ("net: ethernet: dwmac: add ethernet glue logic for NXP imx8 chip")
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 84651207a1de..bd52fb7cf486 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -197,9 +197,9 @@ imx_dwmac_parse_dt(struct imx_priv_data *dwmac, struct device *dev)
 	}
 
 	if (of_machine_is_compatible("fsl,imx8mp")) {
-		/* Binding doc describes the propety:
+		/* Binding doc describes the property:
 		   is required by i.MX8MP.
-		   is optinoal for i.MX8DXL.
+		   is optional for i.MX8DXL.
 		 */
 		dwmac->intf_regmap = syscon_regmap_lookup_by_phandle(np, "intf_mode");
 		if (IS_ERR(dwmac->intf_regmap))
-- 
2.35.1

