Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C16534827
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbiEZB37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345639AbiEZB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:29:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF71A0047
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:29:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0A87A2C03B6;
        Thu, 26 May 2022 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1653528590;
        bh=I3hiIZVzx9XmT7pHq9qeq9MxM8PBXRaRGr/SMziszck=;
        h=From:To:Cc:Subject:Date:From;
        b=xZcu7Qs7yUErY+Pg0fEDK8JQtGYct7XbAzIAEdi96sFcCDryDLF4Kj/4+GrCrPQb0
         iLKCSy9dA80FnWIF1hF0UqyVUDkxrBzS5brGRBuTil5aQiKoiZcJO0hEphFOiH2uk5
         zpxE16EwOoXezZHIko2LTJ6WsY1gTAbN+fi6J/l4EFzn2zWlJeTJC9wPppX0HVK4OY
         Q1dTLOadvoyj2i2IllnymYRiTfRC6MpN06bz+onND+rUMEbwcq8o4WJiVa8sB+1e66
         qKmXmoJe/kCd8YMUgjFZntp/CTtTsLcyKsf2FPQndnsNAjbSo99E2GJ+U3OdrN7eQ6
         aPgfdCHntyq0A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B628ed80d0000>; Thu, 26 May 2022 13:29:49 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id C648A13ED7D;
        Thu, 26 May 2022 13:29:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C37682A0088; Thu, 26 May 2022 13:29:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 0/3] dt-bindings: gpio: gpio-mvebu: Convert to DT schema format
Date:   Thu, 26 May 2022 13:29:43 +1200
Message-Id: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=ajDLYV_rHKUppMWaFfwA:9
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

The 1st patch converts the old binding mostly 1:1.
The 2nd patch deprecates the unused marvell,armadaxp compatible.
The 3rd patch documents the existing usage of the offset/marvell,pwm-offs=
et
properties.

Chris Packham (3):
  dt-bindings: gpio: gpio-mvebu: convert txt binding to DT schema format
  dt-bindings: gpio: gpio-mvebu: deprecate armadaxp-gpio
  dt-bindings: gpio: gpio-mvebu: document offset and marvell,pwm-offset

 .../arm/marvell/ap80x-system-controller.txt   |   2 +-
 .../arm/marvell/cp110-system-controller.txt   |   2 +-
 .../devicetree/bindings/gpio/gpio-mvebu.txt   |  93 -----------
 .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 146 ++++++++++++++++++
 MAINTAINERS                                   |   2 +-
 5 files changed, 149 insertions(+), 96 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mvebu.yam=
l

--=20
2.36.1

