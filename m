Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD265916C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 23:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiHLVjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiHLVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 17:39:41 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718AA9F1BE;
        Fri, 12 Aug 2022 14:39:40 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LaVlh-1nfLDD35Rf-00mMKb;
 Fri, 12 Aug 2022 23:39:13 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: verdin-imx8mm/p: fix atmel_mxt_ts reset polarity
Date:   Fri, 12 Aug 2022 23:39:03 +0200
Message-Id: <20220812213905.216065-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BvH86vIzHnF0Ev4yFtzt0ehaInOmIA51RxXGpGnqroqThlI+wKn
 HxeOrStKIPnchO3aXszf0pLsRZs5aybBKemSwIddaO7D/uoy6c+Y1vPRTOOGtiHcDBK856U
 yRecUMKM/8u7FVjPJKR9pBrsVlz2lcy7t4He/4Nc7ccaMUlsygVqhuRKiVxKMy2FOg4oApr
 EiExLrqu7BEZZanjiCdeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rMhfLbtZ3fc=:x/xuQtTJqRNgBT7ShyTz+S
 SwZw8VAZ7RZWq7yeIwCwYQtdwYIL1BVZuzHI6xWFRuXTZJxfKLsGi3ro18JEVaIKRc9OJ719f
 KSeQjnm8SK41YWMGWJkPFfEYRlYwgOPLjRgcgHl/vk5/bOJ2qpn96qLabmQ4AhKXFCx88XEGG
 dWrRWnN8i6MIcvGL3os5R73cL+ewfzhv5HNgn8U3WEp0VCeUAaYc50AOfROn89ibzvvCQYGOD
 8aSvQ1q38CVjrCKdiT/WdKIjCqAld0cjHADg5i0XTOekcJvM5Du/aM9vEJ8CDQFCVj5sNVnUd
 RneKeO7VisKYrmUqg78Ju4kk3LIhLC2DlJcF50UHLge+yG6ttoBeqDlt5tmNu42tnngdVrjSQ
 E2Zp60yil5VbFzg0Y9/D2F+xBR6Zi7I3kINUM9BuWC6ejP+y3g6jT9MGBUHX1ug2OBMMVcdLW
 f96hjm4e7D4qKr2hONoRSza1RlSLUo/CuUitawwUNMT/yoqZ+2US6hdrUEmzyNxz2e7iJLByv
 4Bq08P+el7MOiLd8Td7PkFu/bRLlwSbfm5jQ3MHVvXgrFppPtojZj/xEjVywN7DR+OD/WwFfw
 PmNCYyVJiF8M87aX0kLbgw30Du+F4ND7RPMZhDqaBkvZY68QQbkPyPdwDvBPNOBlUmqrQhknt
 tkrdUmbD3eqbXuU7orh8CVlolL+8cgvlIMLGhMc0mAac9KRSHOvN9Xh/qwgSNOYAYtHWezMAr
 dMOhg0tziu7QNl3E5nzRy3/1p5Tgc1rT94E6nGLPZBi/+gIK3Qvw5+GPMHM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


Unfortunately, I was not aware of this reset GPIO polarity fix when
I submitted initial support. Let us correct this oversight. Thanks!


Marcel Ziswiler (2):
  arm64: dts: freescale: verdin-imx8mm: fix atmel_mxt_ts reset polarity
  arm64: dts: freescale: verdin-imx8mp: fix atmel_mxt_ts reset polarity

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.36.1

