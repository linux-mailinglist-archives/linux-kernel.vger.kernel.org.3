Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461FA501EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347458AbiDNXIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347429AbiDNXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:08:41 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA008C7E4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:06:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7F6EA2C03CF;
        Thu, 14 Apr 2022 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649977570;
        bh=+jEAtd9/X0L8ZwxOi+r7bwfD8ULH15cDP9fOFVDvLxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssrpdG88KbHlfqiyx+SidGEdsNseLKtEMr6mTlUUDyoTzwLejjFIDizHQ5SFTPGig
         w4abD5lffGe8r6M9eyOrwSc36JqE+zCOyrPLLiG8A7eX8HArKS1ioYbG+yO/C7lmTg
         zmu+Tc0Sx0DmMj75+myG1+vYtJyDXMSUidp5hW/8KHQyIZLEtv9B21b4QoMliZuiYU
         4n39A0VOJGDH7znIp4IPG8JIrMNl7IeshfPzzlMjyV/7wyKA8XJGMae0WjCtrFi+Sl
         +9HDYyBuvoJII8lMlRKdxbFFQaBYO3Jmfyfl+AJTjnIZ/3wgsZS0FKkUJjKfjilA3w
         u02+Pn3zg0sgQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6258a8e20002>; Fri, 15 Apr 2022 11:06:10 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 5DC2713EE37;
        Fri, 15 Apr 2022 11:06:10 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 09F2D2A2679; Fri, 15 Apr 2022 11:06:07 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/4] ARM: dts: dove: Update sdio-host node names to match schema
Date:   Fri, 15 Apr 2022 11:06:01 +1200
Message-Id: <20220414230603.567049-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L59jvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=9fF3QZy3S0T7Ev_h1A0A:9
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

Update the node names of the sdio-host@ interfaces to be mmc@ to match
the node name enforced by the mmc-controller.yaml schema.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/dove.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 89e0bdaf3a85..d81562eac7aa 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -337,7 +337,7 @@ channel1 {
 				};
 			};
=20
-			sdio1: sdio-host@90000 {
+			sdio1: mmc@90000 {
 				compatible =3D "marvell,dove-sdhci";
 				reg =3D <0x90000 0x100>;
 				interrupts =3D <36>, <38>;
@@ -380,7 +380,7 @@ ethphy: ethernet-phy {
 				};
 			};
=20
-			sdio0: sdio-host@92000 {
+			sdio0: mmc@92000 {
 				compatible =3D "marvell,dove-sdhci";
 				reg =3D <0x92000 0x100>;
 				interrupts =3D <35>, <37>;
--=20
2.35.1

