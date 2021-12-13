Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD154472C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbhLMMmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:42:23 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:64516 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbhLMMmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1639399339; x=1641991339;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=slIfKGrVuz5t76T3hpjAzPyqInZyHHf+61nyzGh7cP8=;
        b=F3fOU5wi+B18JmfxJzvzwGYpABpNSohPNPnE4wT0s+p8aYI372oDRK4mJ1zYcUWV
        wFoIAIEzUiHdJw8cg3KLAHU/zJj7Si0W8uXzM6hcblHUUO1Wu2e3uFWDsfsDy9gf
        lusv75YkpX6HuhUHHBvTXjPW7kAmtBoGknEAli09SAE=;
X-AuditID: c39127d2-4ef327000000426a-42-61b73fabbcec
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 29.E3.17002.BAF37B16; Mon, 13 Dec 2021 13:42:19 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2021121313421947-2360042 ;
          Mon, 13 Dec 2021 13:42:19 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: imx6dl: Add a label to cpu1 node
Date:   Mon, 13 Dec 2021 13:42:18 +0100
Message-Id: <20211213124219.3065974-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:42:19,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 13.12.2021 13:42:19
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWyRoCBS3e1/fZEgzW3DSzmHznHavHwqr/F
        psfXWC0u75rDZtG69wi7xd/tm1gsXmwRd2D32DnrLrvHplWdbB6bl9R79P818Pi8SS6ANYrL
        JiU1J7MstUjfLoEr49+VvawFH1grPtzvYGpgvMfSxcjJISFgIrH90EWmLkYuDiGBrYwSvx9O
        ZgNJCAlcYJRYeN0AxGYTUJQ4f/staxcjB4eIQLzEizfuIGFmgSiJD79WsYGEhQXsJSY0a4GE
        WQRUJd7Mns8KYvMKmEn86J3DDrFKXmLmpe/sEHFBiZMzn7CArJUQuMIocWDia2aIIiGJ04vP
        MkPM15ZYtvA18wRGvllIemYhSS1gZFrFKJSbmZydWpSZrVeQUVmSmqyXkrqJERiMhyeqX9rB
        2DfH4xAjEwfjIUYJDmYlEd6X1lsThXhTEiurUovy44tKc1KLDzFKc7AoifPe72FKFBJITyxJ
        zU5NLUgtgskycXBKNTAWfrnJJbN/bq+WbdfWFzkMm/1ZljjfPjvpdsCCfS8ar/028Etf3fbh
        4GfRvX8da3gXnVdaeyNPafu+HQHeuaH3MpdrW3IwiOn8mmZ/Uc3lf03u29caW/TKXp14tEDM
        hOvrzZcuBcosmzm03qW9/vL5EKOsTIitelCCNXO6Gs/0IN/bc/Xie6qUWIozEg21mIuKEwHR
        UMN7NAIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu1 is missing a label for further reference. Since cpu0 has
already a label, add also one for cpu1 node, so it can be referenced to
add or modify cpu specific properties the same way as cpu0.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index fdd81fdc3f35..d49a9b99f33f 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -48,7 +48,7 @@ cpu0: cpu@0 {
 			nvmem-cell-names =3D "speed=5Fgrade";
 		};
=20
-		cpu@1 {
+		cpu1: cpu@1 {
 			compatible =3D "arm,cortex-a9";
 			device=5Ftype =3D "cpu";
 			reg =3D <1>;
--=20
2.25.1

