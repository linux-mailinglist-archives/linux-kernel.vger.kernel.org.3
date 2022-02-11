Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430934B2CA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352597AbiBKSRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:17:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbiBKSQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:16:58 -0500
Received: from st43p00im-ztbu10063701.me.com (st43p00im-ztbu10063701.me.com [17.58.63.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE60D55
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1644603414; bh=Xq55tIfvV+EWtdbVLQfyR97MpcKaPM59jblpvNhML3k=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=eYf6hBE+dCztA7sllk08UZWPM5nDQgAdmMiifLlWcnXVby7ulbYVCF8A1nIfVPfLi
         UswoHdml/65/z6zWq6jyiXW7x8SSV/f/GK4biYkVvTx58Yme+WhJfcu3bN+FR1Dgoa
         Ddh88/ap02PPfHYtaIhMTAhzEEonKHMcbzOiTECkgSey96I46IR+OsO7MZev6MYgbb
         xodV+k2Y41Z6LamTZybLpI+kY4gyB03dyEeEYIXlM4MPwmWF5oQkE5FH83wiw1mG9B
         RG9aKvNu4dnggv/Huas1bJTG0/MhoKIsCTpYYBrdaTgpSDKT25ZaE+0TKw2YTSIksu
         pt3z86j3NlK/Q==
Received: from localhost (lfbn-lyo-1-306-208.w2-7.abo.wanadoo.fr [2.7.142.208])
        by st43p00im-ztbu10063701.me.com (Postfix) with ESMTPSA id 0E7A5D00F87;
        Fri, 11 Feb 2022 18:16:53 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, avolmat@me.com
Subject: [PATCH v2 5/7] ARM: dts: sti: remove delta node from stih410.dtsi
Date:   Fri, 11 Feb 2022 19:16:12 +0100
Message-Id: <20220211181614.683497-6-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220211181614.683497-1-avolmat@me.com>
References: <20220211181614.683497-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.816
 definitions=2022-02-11_05:2022-02-11,2022-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=747 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2202110099
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The delta0 node within stih410.dtsi is identical to the
one already written within stih407-family.dtsi and included
within stih410.dtsi.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/stih410.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 6d847019c554..fe83d9a522bf 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -274,16 +274,6 @@ thermal@91a0000 {
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
 		};
 
-		delta0@0 {
-			compatible = "st,st-delta";
-			clock-names = "delta",
-				      "delta-st231",
-				      "delta-flash-promip";
-			clocks = <&clk_s_c0_flexgen CLK_VID_DMU>,
-				 <&clk_s_c0_flexgen CLK_ST231_DMU>,
-				 <&clk_s_c0_flexgen CLK_FLASH_PROMIP>;
-		};
-
 		sti-cec@94a087c {
 			compatible = "st,stih-cec";
 			reg = <0x94a087c 0x64>;
-- 
2.25.1

