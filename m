Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E725A2FE4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiHZTXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245719AbiHZTXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:23:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8257BD74C;
        Fri, 26 Aug 2022 12:23:21 -0700 (PDT)
Received: from toolbox.int.toradex.com ([104.5.61.88]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M87rr-1pMlfz2dsn-00vfve;
 Fri, 26 Aug 2022 21:23:02 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] arm64: dts: imx8ulp: no executable source file permission
Date:   Fri, 26 Aug 2022 21:22:50 +0200
Message-Id: <20220826192252.794651-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220826192252.794651-1-marcel@ziswiler.com>
References: <20220826192252.794651-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sh6KleRrb2UHa8wuv4sGzRsDQcy20lj2D6lFqfPWV1QDBZnIu+S
 osEvmuW8mUhcL8X8+A104oSXLOH9Wv3JHiKZsjVGqwt3KfZ71tP7TZh0V+bijBqK0fqJYJX
 TmD3KnJ5haZL7rwh4MHXVDdtxlhczjJ0GHIV4Mr/Rea/caWZJqIEJ8R1hnhax8L4SEnEQPw
 F586kZf+dTJYH6zMJ2K2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SZRcq0VpKtI=:JIg8gD1mXJE1NWf/0ZUKwF
 BRkxlJg5aP94waAJ61py2j9LiG/6JBkkl+Ms6WOVH7koPg6vV8WrbxzMZ0cKRckUaezO1cXpS
 sCpnOAvVHJBsMf6uvxIrI8UL5zuMMPukNZunbAQqP4w2mcTP5lgH8LKOpksACPC7Emm6ePkFF
 NspTURhbuzo2k2EvVFU0qCRkt0OTHcMRuWAUTTKvzNylPjPGpc8+FtNqS/+d4njcK8/7K3v38
 v8TrsS6pGwp/1nyS8ZcuokNNT/Zld6B4mXhZ9Vn6w/m35uzA1YAzqzLCaJtDsaIIfj31VLynZ
 U/iVpnq2E/qFyyGc2BleFgl4ovpko4U+Dk2N+0WV21Y8dHBZ8V+30GJZRoiUzf71Wpos+hW7Y
 J926NHg9hEGHJ5hFkX+xZEpQWOo19BJr13poSML/tCembt6bs/oZEaJDMZvHpW/JFTt7K5IJR
 oQ1fVQGSF9/tOvuQ1uKquWcQwgVMFJVg5CLtOdKAMU7xjV2CFrIpFCzDsWH5uGeprG/g/7dRz
 N0giX4AHRSJsZ4txlgzh3ABJx48Y8ntJTjAgjGGcQeLjz0UCJ3xXOAOIzeWhNqs4daIIL9HtT
 qwhy2fOZISU8k1n9nqovqJelXqlMpsu+jwXA9vkfEA3oKGTrnH5Lsms/Ne0Ucp9ZVP08pOa6Q
 /cwRLPAtpdNyysJqvG5YkVFzqwGoXr0IH0zNSx/mZ1f9feYtG1U6jBbs8mDtRTiNU/1VJ3Fi3
 90f5s7hR6g90zgZkv/TKjd8247SDkSrAAzngjw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This fixes the following error:

arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h: error: do not set
 execute permissions for source files

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h b/arch/arm64/boot/dts/freescale/imx8ulp-pinfunc.h
old mode 100755
new mode 100644
-- 
2.36.1

