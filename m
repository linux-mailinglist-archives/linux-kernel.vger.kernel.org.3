Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8375A93D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiIAKCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiIAKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:02:26 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80291377BE;
        Thu,  1 Sep 2022 03:02:24 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LmrtK-1p1gSH3vqu-00h7wG;
 Thu, 01 Sep 2022 12:01:58 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] arm64: dts: verdin-imx8mm: display and pmic related additions and fixes
Date:   Thu,  1 Sep 2022 12:01:47 +0200
Message-Id: <20220901100151.1378709-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YxNIY3vGfTSY8XgjfEnFUaDQB0wWO6H+sLC9tyF3slwt5BVmXUa
 Tr5OHDrc4j9xjgjRz8iPphqxBQxLCy93ma4nHSOgWwDrBafi+80viRO9ZeFULQ7z488B03M
 6KzhZIoVpsYwGv/Yvzrcw2xg9MB5Dqgyj7whzhII6RtRA2soN/bM0cnm51xG6LgLi0kUZPx
 HPh8WD0F5svfZYna9w4zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nnjS14ueBVc=:WfBLSX+NPTxYwCQxjgBmrA
 JZPTu0q83Osnzca8q7RpCBH0ZxxmBlSqbOO3IfdDti1h24zF4hFnJibpcGzAqVvqxkqO52QeC
 TT+WYYTlnNKlR7Y1vx3UER/YMuyfWUsnKQiIxilOdYyq0oS69qXUJdZdqgfssiteKiCKRYOzM
 nSgO6JfOj/Rrwm+Mnx/FOM+6yvAUyNArsfWhppq44C6YyPaeEthKGqdgQRblfhJG/HjtHgu+j
 VtgP/dK4pTrVmDKrMqi4Q2rGYF/SLez3Dv1K9eContpr+YKL+c5QiN3vmmuDnZ+DvK1jEeGMD
 hx7NVpkbtxmUEoYX24fsKqrW42LHt4dd3FY2AQFlbXShI3gDIC3y1MeivtYT1B+R38DT3yDL1
 Pzz1PU5BDQZayt4mNs263nT2++E7+Sj4V/L8JZ4Vjvoc6bLI7d3WLSQ0F81jBPLnbhytWmhlF
 YJZblZDIELAqWkVVERu/FTkp0PthRCr/tRMO9WOg98IzHxnZkkat0dr2h/zOHarRZXnrLxnxn
 kCqWKkPXNtU0Huwmi7GRo6H395mzSlnwNw7RdPP/glZXLz9+B/7Xe57WesrxOCjgSpydw26wG
 RRHcJlB20rPYYJcGhSN3D9QMIkx4fZcWhXmFccveoSn6LgV5WAKzFsvclu/z37u/YVHYLjWlq
 qkgVxyp6K8GcyyG4sdND1k9FjSeIqoSbm3cMDJpB+xY3NYHX7bSwT12vCdmRx1f0+Lr542l+K
 MVd0x+Yfp2E84tnYDGHwu5wkDr4lZHcS/OQj26DuInGZaYLukSqy+3uEadISTD6r+u0ykUpFS
 meOzSrI
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This series contains a few display and PMIC related additions and fixes.


Marcel Ziswiler (2):
  arm64: dts: verdin-imx8mm: rename sn65dsi83 to sn65dsi84
  arm64: dts: verdin-imx8mm: add lvds panel node

Philippe Schenker (2):
  arm64: dts: verdin-imx8mm: introduce hdmi-connector
  arm64: dts: imx8mm-verdin: extend pmic voltages

 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.36.1

