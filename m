Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0D53023C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 11:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbiEVJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 05:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbiEVJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 05:54:43 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3AB3B565
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 02:54:36 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220522095435epoutp033468042b24a3e468bcd46b3e3e06e61b~xZLbuK38f1239312393epoutp033
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 09:54:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220522095435epoutp033468042b24a3e468bcd46b3e3e06e61b~xZLbuK38f1239312393epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653213275;
        bh=6EZLFpcIcXAcnbtuz8KzWE4q/yNrSXTZ39BdCObJjg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmf7X5Ro39Scm3ucrRrGxUhfbY3lhXtnP5LcRx0q9EQH8bNRjCq7WufZMGQ7GJ1IQ
         ILRCPcMyQDduBxC/sQhpVAjz0pYj+DwEXARaww0Y1LPgwSP11N0ABPIfolun45WB4I
         nMHEfRGWlZ5BjO/whVYWY4JcNkcOHX6gy80EV/Sg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220522095433epcas5p4368005cc2e7f431fa9f3c42eeeda64e4~xZLaspYbb2175721757epcas5p4S;
        Sun, 22 May 2022 09:54:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L5bQs6JTtz4x9Pt; Sun, 22 May
        2022 09:54:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E7.EF.09762.5580A826; Sun, 22 May 2022 18:54:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7~w2B184iYh0456204562epcas5p29;
        Fri, 20 May 2022 14:58:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520145804epsmtrp138c753df21232041dc3c99f929bd3ee3~w2B17_O4k2887028870epsmtrp1x;
        Fri, 20 May 2022 14:58:04 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-40-628a08557b85
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.E2.11276.C7CA7826; Fri, 20 May 2022 23:58:04 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520145802epsmtip1f086d24ad2527b24530cf258e000919e~w2Bz7o-MV1683316833epsmtip1A;
        Fri, 20 May 2022 14:58:02 +0000 (GMT)
From:   Tamseel Shams <m.shams@samsung.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     geert@linux-m68k.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, alim.akhtar@samsung.com,
        paul@crapouillou.net, linux-fsd@tesla.com,
        Tamseel Shams <m.shams@samsung.com>
Subject: [PATCH v2 3/3] arm64: dts: fsd: Add ADC device tree node
Date:   Fri, 20 May 2022 20:28:20 +0530
Message-Id: <20220520145820.67667-4-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520145820.67667-1-m.shams@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTQzeUoyvJ4OgTI4sH87axWcw/co7V
        4tmtvUwWD5pWMVm8nHWPzWLJ5PmsFpseX2O1ePgq3GLekXcsFpd3zWGzmHF+H5PF3dbF7Bb9
        iy+xWLTuPcLuwOex+lI7m8emVZ1sHocOdzB6bF5S77HkzSFWj74tqxg9/jXNZff4vEkugCMq
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6GwlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG
        x/kfmQpecFfMuJ/bwHibs4uRk0NCwETiYfNxpi5GLg4hgd2MEuubXrNDOJ8YJb5OOsAG4Xxj
        lNixdikrTMvc79OhEnsZJX41drOAJIQEWpgk3n6U6GLk4GAT0JQ4fp4bxBQR8Jfo/OsCUs4s
        sJxJ4vS6aWwg5cICjhKXV8wEm8kioCqxoekCM4jNK2Ah0fxrJyPELnmJ1RsOgMU5BSwlvv5s
        YgQZJCHQyyHx/e58ZogiF4mmOedYIGxhiVfHt7BD2FISL/vboOx0ibkPe5kg7AKJZbu+Q8Xt
        JQ5cmcMCcigz0M3rd+lDhGUlpp5aB1bOLMAn0fv7CVQrr8SOeTC2osT/3f1QY8Ql3q2YAg0f
        D4mOKeeg4dPDKPH5126WCYxysxBWLGBkXMUomVpQnJueWmxaYJyXWg6Ps+T83E2M4ISp5b2D
        8dGDD3qHGJk4GA8xSnAwK4nwbk/sSBLiTUmsrEotyo8vKs1JLT7EaAoMwInMUqLJ+cCUnVcS
        b2hiaWBiZmZmYmlsZqgkzivwvzFJSCA9sSQ1OzW1ILUIpo+Jg1OqgWl57roFm/7/Wrpvbvsh
        pWjzPq4nXZfyixpPnGJ8s9Ju1U7FB2+27r2h/3wOW4lLr3dc/j7PGXGuif3f3kosZJH2PHaL
        tS0l5LvhJwctjS2ru1Z8rnjrv7RmZYHRG/fco5IxGlIvnlgIGCvtTtwhIN9vm3J9rs/6WRsF
        z5hskclPMpHU/6N3YipnkcTWmJVT7/uJpnxNTlz9Z6EsC+ebqPuVN/sKu9JTTmp/M+TKcL3r
        wnFwxcvoqOent/pKrr3JG5lYXB/vdmXD7fM7fp2s5qhbn9hczta82GTG70e/1+ta9ZunnE9W
        XT4vc/aW4JW1K6MtrBbvCfMy7ufoup7qcOugg3ltc0eOAQ93j6RSixJLcUaioRZzUXEiAIhz
        Gm4hBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnG7NmvYkg4MfBCwezNvGZjH/yDlW
        i2e39jJZPGhaxWTxctY9Noslk+ezWmx6fI3V4uGrcIt5R96xWFzeNYfNYsb5fUwWd1sXs1v0
        L77EYtG69wi7A5/H6kvtbB6bVnWyeRw63MHosXlJvceSN4dYPfq2rGL0+Nc0l93j8ya5AI4o
        LpuU1JzMstQifbsEroyP8z8yFbzgrphxP7eB8TZnFyMnh4SAicTc79PZQGwhgd2MEpeaZCDi
        4hLTfu1nhLCFJVb+e87excgFVNPEJNFyu525i5GDg01AU+L4eW6QGhGBYInFhw4zg9QwC2xk
        kvi/u4sVJCEs4ChxecVMMJtFQFViQ9MFZhCbV8BCovnXTqgF8hKrNxwAi3MKWEp8/dnECHGQ
        hcSKxm/MExj5FjAyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECA5pLc0djNtXfdA7
        xMjEwXiIUYKDWUmElzG3JUmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakF
        qUUwWSYOTqkGpsADZgIz/5/+tKliblbhfc7KwCArY4bEpY7vu+MvrnC9JKBUd6sqeXXFJpGT
        6qUnrZZr3Dlhs5hTPTYzyOHQhvCYULYzPH/OHBQ2nCiw66Qiw7ztc3YkPniXfCH2R3ux9RSd
        15avMj+0WrpMbTvhszLw01wdlt3uy+/Ni3437+PbBYJ3NikEtC9Nun01fTEPg19Endav6x1b
        dlqzL4q4KJslWfh/Qud+wSUvtZ/sYvysWquaY+F6lLlbOkDr//XlEllVP4XvBn19UxhsblGX
        e6mylTf6idy7CV2fDBi9hIWCJ+4ufShZ6Ff9woRtq+jU/2qMplmTFlr+zLMUjbz40DPg/JUo
        KZeUvU/e1eefUWIpzkg01GIuKk4EAP29IITYAgAA
X-CMS-MailID: 20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7
References: <20220520145820.67667-1-m.shams@samsung.com>
        <CGME20220520145804epcas5p2925e66d30b18378fc62c92999ec269f7@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alim Akhtar <alim.akhtar@samsung.com>

This patch adds ADC device tree node and enables the same
on fsd platform.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
- Changes since v1
* Addressed Krzysztof's comment for corrections in dt files

 arch/arm64/boot/dts/tesla/fsd-evb.dts |  4 ++++
 arch/arm64/boot/dts/tesla/fsd.dtsi    | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 5af560c1b5e6..63f26a85053a 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -34,6 +34,10 @@
 	clock-frequency = <24000000>;
 };
 
+&adc {
+	status = "okay";
+};
+
 &serial_0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 9a652abcbcac..f63624f2f414 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -748,6 +748,17 @@
 			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
 			clock-names = "fin_pll", "mct";
 		};
+
+		adc: adc@141a0000 {
+			compatible = "samsung,exynos-adc-fsd-hw";
+			reg = <0x0 0x141a0000 0x0 0x100>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clock_peric PERIC_PCLK_ADCIF>;
+			clock-names = "adc";
+			#io-channel-cells = <1>;
+			io-channel-ranges;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

