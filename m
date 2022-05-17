Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCA52A286
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346911AbiEQNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347125AbiEQNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:01:19 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AF34EA0B
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:59:30 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220517125928epoutp048f23a4762ffae30eeab41a503051c4db~v5ecOqgb11581615816epoutp048
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:59:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220517125928epoutp048f23a4762ffae30eeab41a503051c4db~v5ecOqgb11581615816epoutp048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652792368;
        bh=hIUv0YD0Ok04tV8sxzxfdl66nzpWPWtDN0YIwNoEv68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCz0/hjNTax4HFnX6Ha4ZHYExOi0aYHETyBmCYkWiNWs8ihZbOS5AAkNTijwuqadh
         9HWeijJ3I4V257oYPZpdMDXsl5Od0QvPgBfmHHzCLdPtuWG4xADn6DVueJJFWujSv+
         mq3+vdMKHpbWofNNK9Km1bS22w6+6QxkDPWb9Q6M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220517125928epcas5p3e0a1b3f897bd2f4b7a03c9278d8076e4~v5ebn5xiO2692026920epcas5p3F;
        Tue, 17 May 2022 12:59:28 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4L2bmX4GlGz4x9Pw; Tue, 17 May
        2022 12:59:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        81.5F.10063.C2C93826; Tue, 17 May 2022 21:59:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1~v5cOSU-2E3158031580epcas5p1G;
        Tue, 17 May 2022 12:56:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517125656epsmtrp16637860bd110af4c05febca50c55da6c~v5cOOBgLJ0134401344epsmtrp1I;
        Tue, 17 May 2022 12:56:56 +0000 (GMT)
X-AuditID: b6c32a49-4cbff7000000274f-3c-62839c2ca69d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.46.08924.89B93826; Tue, 17 May 2022 21:56:56 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517125653epsmtip1a84433701a1f5c55cd2f37c81421e3e5~v5cLJBSfR1799717997epsmtip1Q;
        Tue, 17 May 2022 12:56:52 +0000 (GMT)
From:   Smitha T Murthy <smitha.t@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        Smitha T Murthy <smitha.t@samsung.com>, linux-fsd@tesla.com
Subject: [PATCH 19/20] arm64: dts: fsd: Add MFC related DT enteries
Date:   Tue, 17 May 2022 18:25:47 +0530
Message-Id: <20220517125548.14746-20-smitha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220517125548.14746-1-smitha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xTVxTHc99rXx9sZU+EcGUb4IvE4ABbhXIxwGAY8paZjcy5ZThlD3gp
        DGi7vjLBZJECwmRDJ8yACDihjAQU+U1F3AoUEGfYBATMLALO8GP4I3QsIAhrbdn++9zv+Z5z
        7j33XhJ3HifcySSFhlMr2BSacBS09fjs9PMty46TnFvYhiYr2ghUtTyDoQdVZgHqbm4VoZaR
        Cziq6TcI0UXjoBC1d00LUOOsJXrnvEmAZi7WAzRXOkGgpoejQjQ1/wka7igj0HcNrUJ0xWgS
        oeqxOxj6qWkNQ5Wtf4vQyRtGETJ1tgGUk2vEwt2YyxWXAaM36QAzplvEmWulJhFT1TmHMU21
        pwjm/mgnwTTrTjAne58LmNMttYBZzyoXMfnGMYIxN3kwt5bMominmOSQRI5N4NRenCJemZCk
        kIfS7x2MjYwNlEmkftJgFER7KdhULpTefyDaLyopxTIB2usrNiXNIkWzPE/vDgtRK9M0nFei
        kteE0pwqIUUVoPLn2VQ+TSH3V3CafVKJZE+gxfh5cmKH9hpQFYnTDY+WsUzQ55gPHEhIBcD6
        G214PnAknanrANYPzgNrwJlaBHC2cbstYAawdWJduJlh+OOewBbosJhylzDbIgeDpoVs3Ooi
        KF/4z9NfCSu7UFoAH36jsTJOreLw/IiHlbdSkfDM1CxmZQHlDe8vfPsyV0ztg3UvjMDWzRPW
        NRgsOkk6WPTy9SM2eYOEukn7EfbDq6N/2e1b4Xx/i8jG7nDuTK6d5fCBOdvuUcHyzBbMxm9D
        w0iZwFoep3zg1Y7dNvlNeO5WPWbbsRMsWP3TbhdDfcUm07Dy9k17eQjvPm4VWstAioGGSpVt
        IgUArqysCb4HHqX/d/gRgFqwjVPxqXKOD1RJFdyx/64sXpnaBF4+8V3v6oFp8pl/N8BI0A0g
        idMuYkl6ZpyzOIHNOM6plbHqtBSO7waBlumdxd1d45WWP6LQxEoDgiUBMpksIHivTEq7iakN
        bZwzJWc1XDLHqTj1Zh5GOrhnYmUzn66TxxPxrEdd01Gu2jfeKbytK/Icjc4o0n90s2at7vUj
        oYIr7ZrDvnmrYaWS4GG3U65ff+i9TjZeIDKKgjt9xv2inh/qkRw+ll+4oytoY1ma9VnhgB7r
        2Zuart2uM025uEXg/mFHN2DQgSFqaJo9vVo/sdT7+HoGX9f186Enz4abX4vMvBszGHfpi97q
        j3854f5Dlk5YFD7t/VZ1yVBfjjxvcgdZ3e/ZHm9+UdXw25ZXY8bze8MXDqa9H/g0+h5ycsoq
        udSv3ZKnX2TF0xEuNR8UpLsdjZhJ2DM5EDIUNMeUTA0U7ywuHnllsOfsE+Pv+i9lVHlVV2jf
        2EpFTEh5GJFMC/hEVroLV/Psv4PCMr5rBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSnO6M2c1JBqv/8Fo8mLeNzWLxj+dM
        FvcXf2axOLR5K7vFliuzmS2WHz/AajH/yDlWi+0HH7FYbHwBlL048y6LxfP56xgtXs66x2ax
        6fE1VouHr8ItLu+aw2bRs2Erq8XaI3fZLZZev8hksWzTHyaLRVu/sFu07j3CbnF3zzZGi5a2
        I0wO4h5r5q1h9Nhxdwmjx/Uln5g9ds66y+6xeM9LJo9NqzrZPO5c28PmsXlJvUfr0V8sHn1b
        VjF6/Guay+7RdeQ6m8fnTXIep75+Zg/gi+KySUnNySxLLdK3S+DK2NW4k7FgMm/Fgac/mBoY
        j3F1MXJySAiYSBy4fZOli5GLQ0hgB6PEyVMHWCASEhIrf09ihLCFJVb+e84OUdTEJHH+RwMz
        SIJNQEfi2/vTbCAJEYFWRonrKzuZQBxmgYksElOu/wKrEhZwluh/+IIJxGYRUJW486YbLM4r
        YCWx+u8RqBXyEqs3HACKc3BwAsXn/osFMYUELCWe7reYwMi3gJFhFaNkakFxbnpusWGBUV5q
        uV5xYm5xaV66XnJ+7iZGcLRpae1g3LPqg94hRiYOxkOMEhzMSiK8BhUNSUK8KYmVValF+fFF
        pTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwBT97/puja//B2eF57Huu6rFF
        PDi7fGVa9mnxiNOnw00meB3KOuEbPWVG38yjSxZmOS7h5lRmuMG6cr2CafdCN/NVEqHnTRcJ
        OHA0TSlbcHrNDYeWW5KOjj+NJV/aerW0/vCr4s/3332sYrs316eCHSfOFMtyHmi7/7xCd4Jd
        oqxu/86l5y9eMeqawXPpy7bDOTr6O+6XPdl3Ss7yYJAWG1OO4fvl1zw5d/BFv9OSSnAzCbvc
        WHPq6BvvCcYGrdHxCrNchRQPPFSf6xJ768SCM02xR8Rclyef/shyZ/uZq1Pn/o33bjsucDE3
        zS/Y9muAG+8fpxNLrrRL/Hp+69nzu1mqE1I9VR6bGbeVLzq3RomlOCPRUIu5qDgRAGdvc7kl
        AwAA
X-CMS-MailID: 20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1
References: <20220517125548.14746-1-smitha.t@samsung.com>
        <CGME20220517125656epcas5p1cc1296b200ff8801f24243aa47de8fe1@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MFC DT node and reserve memory node for MFC usage.

Cc: linux-fsd@tesla.com
Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts |  8 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi    | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 5af560c1b5e6..36f6b013ce99 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -37,3 +37,11 @@
 &serial_0 {
 	status = "okay";
 };
+
+&clock_mfc {
+	status = "okay";
+};
+
+&mfc_0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 9a652abcbcac..434ae75421d8 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -249,6 +249,18 @@
 		#clock-cells = <0>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		mfc_left: region@84000000 {
+			compatible = "shared-dma-pool";
+			no-map;
+			reg = <0 0x84000000 0 0x8000000>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -748,6 +760,16 @@
 			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
 			clock-names = "fin_pll", "mct";
 		};
+
+		mfc_0: mfc0@12880000 {
+			compatible = "samsung,mfc-v12";
+			reg = <0x0 0x12880000 0x0 0x10000>;
+			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "mfc";
+			clocks = <&clock_mfc MFC_MFC_IPCLKPORT_ACLK>;
+			memory-region = <&mfc_left>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

