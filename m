Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB3D4DA503
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352117AbiCOWHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiCOWHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:07:08 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803724839B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 15:05:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A74172C0A8F;
        Tue, 15 Mar 2022 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647381952;
        bh=shAvVAo4zZnFN8Y1h8zTgPxTI/jOM/JR1c6ANtqej8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UBWQQe9L6SmpExPvcCXuHbeM73eij0pYLeWTuarC+eyQImOh7Od43h3s+ugVY+j9n
         qdDub/ZoJYgGDAUc7JIzAwrmpF5aiLnJyOxzSrcafYpjx0o9J5zY6VTG/uoq1s1P2N
         NZ8VXXOB96pUBdohPE+8A8mn2esQDzx1Zf+HVcbWV5mAjM8UZpteJ0xecx5hTmwyr5
         Ez2NNLfBjFE5VL3DgtPEgxrPaX+fGweALYvRtY0Y1JUBHZ0QRwtg1j+ONa3tITeKAT
         da04wEBxBZwCSTZsLuAHTut+O0GEgfl4qvVnAMNTNjgm6MWdDTnXTKCtZU7kc/JbxX
         7LJ0IqCDCMgPA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62310dc00002>; Wed, 16 Mar 2022 11:05:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 5BD2613EE3F;
        Wed, 16 Mar 2022 11:05:52 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4518D2A2677; Wed, 16 Mar 2022 11:05:51 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     huziji@marvell.com, ulf.hansson@linaro.org, robh+dt@kernel.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] mmc: xenon: add AC5 compatible string
Date:   Wed, 16 Mar 2022 11:05:49 +1300
Message-Id: <20220315220549.2749328-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
References: <20220315220549.2749328-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=UvibhkeALEyMK9IFLgoA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add marvell,ac5-sdhci to the list of compatible strings for the Xenon
SDHCI controller. Currently this is functionally no different to the
ap806 but having the compatible string will allow handling any
differences that arise from the controller being integrated in the
98DX2530 switch chips.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---

Notes:
    Changes in v3:
    - Split from larger series
    - Add review from Andrew
    Changes in v2:
    - New

 drivers/mmc/host/sdhci-xenon.c | 1 +
 drivers/mmc/host/sdhci-xenon.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xeno=
n.c
index 666cee4c7f7c..ac95d16809c5 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -692,6 +692,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[]=
 =3D {
 	{ .compatible =3D "marvell,armada-ap807-sdhci", .data =3D (void *)XENON=
_AP807},
 	{ .compatible =3D "marvell,armada-cp110-sdhci", .data =3D  (void *)XENO=
N_CP110},
 	{ .compatible =3D "marvell,armada-3700-sdhci", .data =3D  (void *)XENON=
_A3700},
+	{ .compatible =3D "marvell,ac5-sdhci", .data =3D (void *)XENON_AC5},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xeno=
n.h
index 3e9c6c908a79..451b41dd3447 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -57,7 +57,8 @@ enum xenon_variant {
 	XENON_A3700,
 	XENON_AP806,
 	XENON_AP807,
-	XENON_CP110
+	XENON_CP110,
+	XENON_AC5,
 };
=20
 struct xenon_priv {
--=20
2.35.1

