Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137A1487BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348772AbiAGSEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:40 -0500
Received: from mout.perfora.net ([74.208.4.197]:42061 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348725AbiAGSEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:31 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mlvix-1mgDpQ3fbX-00izFg;
 Fri, 07 Jan 2022 19:04:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/14] arm64: defconfig: build mcp251xfd can as a module
Date:   Fri,  7 Jan 2022 19:03:09 +0100
Message-Id: <20220107180314.1816515-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:52SPNROfhDFzUawLl4TeZvubizEsY2HMPxY8e60xm5LW++X+0qa
 WPG8JBCDLULLIp/7DvQd96eEcoq60z4uWpfTmtVIzYKE1f3/ktuOgNrRRjRGa03HOD9VqoS
 gS3zP6QcMNqUGp/UuNW8d/4ffA0DH96ZM1EVDaiFeUl3266IWrZ4rumHHjguPl8XAJdcPfW
 jdzMl7ra7UcE7gOQMNzyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tc0ZAqRSmOM=:K/8/ndrZgW6SKtv7Otd/M1
 yH8mbbaEXqIXAHTXOlOv/A4TwqL9XBVwXS0ZWwVBeytEwffaMM9wDawySZ20POqmeUOwXfH7C
 LuU2DpdOH0lJT7sOtkwaRFi5ryADfxWxSsbn7UALjDN0RD2IiQcDRG/f4Q0N2jfNmPkEl3O5E
 wucTmKoT2gJ8Z+IdLe12soYPGcRgQ1tyGeaXhj6loxlxAsdYAXJ/g4diK5eOBMtqUsXhACXCI
 3Jk1/8VrcqVlxVRqIOq0wIKIMtU6jhhnddX7wvj8ngeqUvNEBQDnD2gCZ17QHjnUizohswfrU
 htA+0W+koevXxtNpq2gx4NKYrpq6nTfQXqexdxbLeRkO9dEmHMy07tH+SMwB28ZwnQFRleokc
 9bpifvzZnmspxzY+xV2FqTeRO0Y9Qop5Fq5hRJ8ViBSztqBuxh4XJhi1G9g0q6uczfzIfJBq2
 7ORmG389laU04xKdPDxOoBGOzUVuM92WyA2bJ1jFVYO8pOdWrEkxQeCna0Of/HyzE2HdG8B41
 JCerK9Z2XdX/3mcO/M3LgXIEjf76euz+G6TIxYiw1pq19Q/lo5HyGqhi/yZImXiYovjToT/x3
 zmYxGrPeRIfVN+qT5tYsEOouoq2T8rjmI0wdebYYkGyoblZV97OqTDxJVU1JWp4203YyahLII
 azuQ0iD8SymbUJ7Zy1JQ5a+4vV00OAkdgAsCjZkYK0Ipm1hqT2MfFkSWXbUpK8IcfeEs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Microchip MCP251XFD CAN (CONFIG_CAN_MCP251XFD) as a module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b4fd61fda35d..870404a1957d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -173,6 +173,7 @@ CONFIG_CAN=m
 CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_RCAR_CANFD=m
+CONFIG_CAN_MCP251XFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
-- 
2.33.1

