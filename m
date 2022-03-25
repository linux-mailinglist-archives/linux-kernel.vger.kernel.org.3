Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5B4E6B75
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiCYAJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356823AbiCYAJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:09:31 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B96BBE02
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 17:07:57 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0D5682C0A90;
        Fri, 25 Mar 2022 00:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648166874;
        bh=aYjeFGv6acnlGqYDx9smCRVPVxIhi92QWCR4UE4tuMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smdjxlwI8752LX6sLQi1zIRo5tZcmkNybwWGJzHl5Br688TmMAtt3noYpCJ3Q0G6n
         BYsnSruBqzuUHz/nOtD+NmiO7FsqN+E0or9pJnrpjDAlNNsvVCUOcMUQsWPLKqeGfB
         ul7Dxqukx5Tg01YKdSF0d4x2Gka53Nr2g6MVnt/oB8CHwBSbDT5SSEwZmmWf67bO+e
         zBgrEbLhM6U6WzNbG94hJ1ujmks4wBhFd5H6JCn42PIuudgoRZRPFYMYnlxX01VnuC
         jXnRtEVfKdi0+jZc8YZNTXJnWjMnjngrX3Zw2cZoEFJ1DaURDrVEhPbluOd8mGCD9m
         2wFXIGIZ5rhTg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B623d07d90002>; Fri, 25 Mar 2022 13:07:53 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 9FB9E13EE9C;
        Fri, 25 Mar 2022 13:07:53 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 96AB92A2679; Fri, 25 Mar 2022 13:07:49 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, huziji@marvell.com,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 3/3] dt-bindings: mmc: xenon: add marvell,sdhci-xenon compatible
Date:   Fri, 25 Mar 2022 13:07:45 +1300
Message-Id: <20220325000745.1708610-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
References: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=o8Y5sQTvuykA:10 a=khTjyptZaKf2Ay8TfSgA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The armada-37xx SoC dtsi includes this as a compatible string. Add it to
the dt-binding.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - new

 .../devicetree/bindings/mmc/marvell,xenon-sdhci.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.ya=
ml b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
index 326ac3fa36b5..776bed5046fa 100644
--- a/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml
@@ -31,6 +31,10 @@ properties:
           - const: marvell,armada-ap807-sdhci
           - const: marvell,armada-ap806-sdhci
=20
+      - items:
+          - const: marvell,armada-3700-sdhci
+          - const: marvell,sdhci-xenon
+
   reg:
     minItems: 1
     maxItems: 2
--=20
2.35.1

