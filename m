Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC64B0096
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiBIWsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:48:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiBIWsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:48:16 -0500
Received: from mickerik.phytec.de (mickerik.phytec.de [195.145.39.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3530E019240
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1644445978; x=1647037978;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=slIfKGrVuz5t76T3hpjAzPyqInZyHHf+61nyzGh7cP8=;
        b=oJOyyG8wk/UCoWb5ZKD1WMBTcFkpOG6cAablNYVBN2hpuEjELiu36+cn9QI2EnXi
        kvHxaAB3opSnU+tn/U2JdsPoXyTnZnfuF8VmgsQk2KPZz7nJt2G4x6bbZU3HK9sp
        Skb5DLN/kM7EKyr1t0SH/xcHIqARWiKwc6TeocRzR18=;
X-AuditID: c39127d2-93d2170000002a63-b9-6204411a9c36
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 12.82.10851.A1144026; Wed,  9 Feb 2022 23:32:58 +0100 (CET)
Received: from augenblix2.phytec.de ([172.16.0.56])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2022020923325855-256538 ;
          Wed, 9 Feb 2022 23:32:58 +0100 
From:   Yunus Bas <y.bas@phytec.de>
To:     shawnguo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, devicetree@vger.kernel.org
Cc:     festevam@gmail.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 1/2] ARM: dts: imx6dl: Add a label to cpu1 node
Date:   Wed, 9 Feb 2022 23:32:57 +0100
Message-Id: <20220209223258.1672425-1-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:32:58,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.02.2022 23:32:58
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWyRoCBS1fKkSXJ4PALU4v5R86xWjy86m+x
        8e0PJovLu+awWbTuPcJu8Xf7JhaLF1vEHdg9ZjX0snnsnHWX3WPTqk42j/6/Bh6fN8kFsEZx
        2aSk5mSWpRbp2yVwZfy7spe14ANrxYf7HUwNjPdYuhg5OSQETCQuN0xi7mLk4hAS2Moo8fba
        NzYI5xyjxMsdexhBqtgEFCXO337LCmKLCGRJPPn5gAnEZhbwkfi17wqYLSzgJjH5xxywehYB
        FYn7L86CxXkFzCROrdzABrFNXmLmpe/sEHFBiZMzn7CALJMQuMIo8eDCN1aIIiGJ04vPMkMs
        0JZYtvA18wRGvllIemYhSS1gZFrFKJSbmZydWpSZrVeQUVmSmqyXkrqJERiUhyeqX9rB2DfH
        4xAjEwfjIUYJDmYlEd5T9cxJQrwpiZVVqUX58UWlOanFhxilOViUxHnv9zAlCgmkJ5akZqem
        FqQWwWSZODilGhgFj7Ty+u/ZqfbDWyF1Cd9v1bxPyvULJ9ltu2HRo/w331NLcm7T7qIdLqfc
        y151+Ud/XZ26dv/n0KWd1fd5pCd1uFycven6u4uTviepnt/ueqJeOKs7/s9u6bzC0+wFQVH+
        qrnv/q02bFZ8ntu+afYSXYczLH+spnKyftQ/7Nct8CB5doKIN4cSS3FGoqEWc1FxIgBn5x5e
        OAIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

