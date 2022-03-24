Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4914E6675
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351493AbiCXP7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351435AbiCXP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:58:52 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A7FAC910;
        Thu, 24 Mar 2022 08:57:20 -0700 (PDT)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MxVGn-1oHoJu1LMv-00xtK7;
 Thu, 24 Mar 2022 16:56:59 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 00/10] arm64: dts: imx8mm-verdin: minor updates
Date:   Thu, 24 Mar 2022 16:56:39 +0100
Message-Id: <20220324155649.285924-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hj0JNt6MAlDJZ4F4OH4YaGZ4iTItU7lC0mZqFmi+qzdW90QVSmq
 p0+M4gFt6cQfHMVWUXfLMlAinOPlHrMd4km3K0NZMUMvsp6DmgBaA+DFNWw0UHe1mmvDu0x
 hQ5H6X5XldBNgeLLUFCrm6ZyzVSzOlIHkVbGkYK42EOCltbJ+UUjncXbv4Q4c8mxJBGFuvI
 S7IOZhKLy9Wzr2vtrrA/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bswDM/m5wYE=:ToSqmZg4gOr64HQc/gUuzo
 9VuRpfzcOXJx8XjcGJ8Z6H+7KkRa3y7fKAFlFf9LnoQWDMw8sGxC95v2eRBDzjnW0D8xnBVVf
 yQlczLiejRfbhHQAaZaVHD1q9jiYuBe+ysQxDKgvF0c9adz54Jbht5zo6LxjcFXGwhEOL3+N6
 jevhdnSCuUvXA2F07MUR1g1XNs8WruShBgJfcTpMfgeY3/HANxBQKUIDou14ZDCCA2oRYxi+6
 Zfvp7x8X7GNAgYsRuCimF1vpEJ7weue9XNuyKPUtB3eal0cCAsPiwmtJt6raeBIcM6VP9k5dN
 VTrgeSTDG7sZLGgy1pGAgIclYzWDQ3tU+VdCh/oTc+UK9LSxhT7KsBfi0ciNKeLuiXNNpPmeO
 JcpPUEI09QlNVRtBgFL+UhryVI4BITD/XnIFFqXs8sHQAmA7dqwEdqAvgHExAkvzo95JooKvS
 6dFH5Mf40VI2U9uuX2bg1434xCibdIh4zgKsTyTU4bxwBrhc1m4qrZhG5eL2OFaIX2Ol1RtkH
 0g8gDkaXGy5ZgYyAuUhieJS0DscpCZJggD+uRTJd0m4+Nq0O1bieiAwOigFU9onYIEb/2KNqQ
 Fwr528GtTNWlx48xur8d1HhCY1tbYEKGfm3t4bkWd50cd9ICm76r/XY3vM8mbFA8B49648fjs
 mp837clS9mKhOdGDp5A6r8u+8P+ShsvSbHPhwzKJGZX8ypY3qDkUfWsizfUYuHtK3XMg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


This patch set brings some minor updates including some cosmetic
improvements like comments, names and node and pinctrl group
re-orderings plus functional improvements like an SD1 sleep pinctrl and
an updated fully validated IOMUX configuration.


Marcel Ziswiler (10):
  arm64: dts: imx8mm-verdin: update regulator names
  arm64: dts: imx8mm-verdin: multi-line comment style
  arm64: dts: imx8mm-verdin: alphabetically re-order nodes
  arm64: dts: imx8mm-verdin: only dashes in node names
  arm64: dts: imx8mm-verdin: comment about i2c level shifter
  arm64: dts: imx8mm-verdin: update iomux configuration
  arm64: dts: imx8mm-verdin: re-order pinctrl groups
  arm64: dts: imx8mm-verdin: capitalisation of verdin comments
  arm64: dts: imx8mm-verdin: note about disabled sd1 pull-ups
  arm64: dts: imx8mm-verdin: add sd1 sleep pinctrl

 .../dts/freescale/imx8mm-verdin-dahlia.dtsi   |   2 +-
 .../dts/freescale/imx8mm-verdin-wifi.dtsi     |  26 +-
 .../boot/dts/freescale/imx8mm-verdin.dtsi     | 411 ++++++++++--------
 3 files changed, 235 insertions(+), 204 deletions(-)

-- 
2.34.1

