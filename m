Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1958F57D491
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiGUUGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiGUUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:05:40 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD3574379;
        Thu, 21 Jul 2022 13:05:36 -0700 (PDT)
Received: from toolbox.int.toradex.com ([81.221.243.92]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1Mzh89-1nJ3s91bcH-00vjpT;
 Thu, 21 Jul 2022 22:00:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/12] ARM: dts: vf610: no spaces in indent but tabs
Date:   Thu, 21 Jul 2022 21:59:29 +0200
Message-Id: <20220721195936.1082422-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721195936.1082422-1-marcel@ziswiler.com>
References: <20220721195936.1082422-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TYNIvucj2ssF0JConM2xsCyFuG2JRsH1x7YubCEtaz3nW1KEALt
 sioU+3Udfsq+ljrF9+5GIDDnVPHBSdjAuX9gnHkZrYNF8IF+La9xMgErKV5OKd/PN8RdG2z
 wRbZKOAGNnj30zOs5o5Fo0D+v2Does8GNS2eNOWa/iF8320xDjKzjSzJa2Sb1xsSeDfqrkV
 kMlPJnbL9l5k7i/qOSjZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9W3/ilRM9Qw=:DSvuVcV4OscEHmM252h2hu
 J8X0pOoMa16vJAYKIDDLIGZ5os6fMFovNgNA/Qe4JjgrQqC1oGocZ+5jNvY5pQJlih2OYaXaa
 oTQEGVzwFxA37XC7unQr9qsRKQbdWlOAZ5If6vfWhpvIu/cRKxf2pnYeJqDGTlkXKM/hehA9v
 DmJwtpx9rZwZdf1lcNPdJiL0vCQKqNsl1odad133ouUDdLa2jvNMZpBphMOH1J+JxundU6MjY
 pqHL+IA/qyzR3dx83dH1qAgveoBAa21WUFDk4uj82dVOqLI4aD5MFyjCr+6JL2aOBn4gLwjlx
 K8gJR/AfZ5+DFgILNIqfzXo7LwMt4rt7hwrV44rIefF8aBFkbmQBsqYZVhcvqCiiH+XBCocch
 OlCAbJ6AnSnZNvwxxAi63ivrsQIrablnfALdK2BeZ/LFY6nQDY+0dfKG082VYoWzy46tjU54v
 pa0WCKWbPIO0p8KMPcmlUkrNxnDzg4ZxuRA5JZXWK3aIGrXheBAqcaGadr28NdndBF1xEJBUr
 76JdCq7nkH7uAW1TWJLJWXpQ6cQDi+Kw44/bwNDIhUsiHx7pp/jxD9HmFga91qoqBD/Nl8dPl
 gjOzo8NY1qO7wfdWoVVgDuo3usrjnYfoVcH75TqMLLBQzQTNJUbr9kQ3jgaTxMTs5DTBI4alL
 zE+ZIi12lep4OWpyioiwTHngc6WxPAsByzMPkEYYNf6yUKladzoIt8+NlRB3cvuHnUEP4Q0zq
 iqs4Z/H+Qjn7QTxLdzl4QEi33FCmHM9YAyqFKA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid spaces in indent but rather use tabs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/vf610-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-pinfunc.h b/arch/arm/boot/dts/vf610-pinfunc.h
index f1e5a7cf58a9..8bb970b0dff8 100644
--- a/arch/arm/boot/dts/vf610-pinfunc.h
+++ b/arch/arm/boot/dts/vf610-pinfunc.h
@@ -420,7 +420,7 @@
 #define VF610_PAD_PTD29__FTM3_CH2		0x104 0x000 ALT4 0x0
 #define VF610_PAD_PTD29__DSPI2_SIN		0x104 0x000 ALT5 0x0
 #define VF610_PAD_PTD29__DEBUG_OUT11		0x104 0x000 ALT7 0x0
-#define VF610_PAD_PTD28__GPIO_66	 	0x108 0x000 ALT0 0x0
+#define VF610_PAD_PTD28__GPIO_66		0x108 0x000 ALT0 0x0
 #define VF610_PAD_PTD28__FB_AD28		0x108 0x000 ALT1 0x0
 #define VF610_PAD_PTD28__NF_IO12		0x108 0x000 ALT2 0x0
 #define VF610_PAD_PTD28__I2C2_SCL		0x108 0x34C ALT3 0x1
-- 
2.35.1

