Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CC8501EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 01:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiDNXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbiDNXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:08:41 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6B8CDAD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:06:13 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 331F02C02EB;
        Thu, 14 Apr 2022 23:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1649977570;
        bh=QMOImhl/kNS0gQ0GSE27P0W8zdDKCfw1R+mRixl3y0I=;
        h=From:To:Cc:Subject:Date:From;
        b=r4jGRX3ZJkFx8A+XdSa8ISnr7i/IwMD9l0+WMgLdCLu2tuWbmPoMXvcAWSv/tqyHH
         l6TUQcUWhbFtpnIgCv9SlvB9UoZHseQNx3whoYz1lcIAELg+t4ZTe3xUf8MKh9yBaJ
         es891XOjEnbuOLjOnUf/ps1dQ0phRJBFeIS0KLOyo6XT6eVgFyImv5dGgZOfeTh4Sv
         bNiHpK7nkPlvzsyinDDutsHrNDc5h2ddqCd1UlVXfJYauzxoxT9g1HEXvk5Ig3B0OV
         +7k8jTafBExDuSyX1xnWo8Apzx01QeJ+bfx1KHvD3RDz+lbJuXdkIaAZvOq4qZrEjS
         yt+z9lkCtM6vw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6258a8e20000>; Fri, 15 Apr 2022 11:06:10 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 0778513EE37;
        Fri, 15 Apr 2022 11:06:10 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A5A0A2A2679; Fri, 15 Apr 2022 11:06:06 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/4] dt-bindings: mmc: Convert orion/dove bindings to JSON schema
Date:   Fri, 15 Apr 2022 11:05:59 +1200
Message-Id: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L59jvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=z0gMJWrwH1QA:10 a=rAFvr4r3g9_3rt3GYfIA:9
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

This is a small series converting the device tree bindings for the orion =
and
dove sdhci controllers to JSON schema.

The first 2 patches update the dtsi files to use a node name enforces by =
the
schema. The next 2 patches convert the old text binding to JSON schema.

Chris Packham (4):
  ARM: dts: mvebu: Update mvsdio node names to match schema
  ARM: dts: dove: Update sdio-host node names to match schema
  dt-bindings: mmc: convert orion-sdio to JSON schema
  dt-bindings: mmc: convert sdhci-dove to JSON schema

 .../bindings/mmc/marvell,dove-sdhci.yaml      | 38 ++++++++++++++++
 .../bindings/mmc/marvell,orion-sdio.yaml      | 43 +++++++++++++++++++
 .../devicetree/bindings/mmc/orion-sdio.txt    | 16 -------
 .../devicetree/bindings/mmc/sdhci-dove.txt    | 14 ------
 arch/arm/boot/dts/armada-370-xp.dtsi          |  2 +-
 arch/arm/boot/dts/armada-375.dtsi             |  2 +-
 arch/arm/boot/dts/dove.dtsi                   |  4 +-
 arch/arm/boot/dts/kirkwood-6192.dtsi          |  2 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi          |  2 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi          |  2 +-
 10 files changed, 88 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,dove-sd=
hci.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,orion-s=
dio.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/orion-sdio.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-dove.txt

--=20
2.35.1

