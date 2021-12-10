Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0403647017D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhLJN11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:27:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241719AbhLJN1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:27:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 448FE1F4769D
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639142630; bh=CJhjsCMyqEP65R/Xg2NhSIIrFMgqoU+gWwEZab6mGv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DaJYnoRuUgKh9JRaCDPUj6voFN40YfhG3kMvpP3Q0/PPESg3y1KS29LinWBpkE+xP
         n+rAIwQ2a3/IiEYAiB/lVjomvtVdvBe2DY42RcE0iusHgOddM7ZSKG8Dvy4KzxaPW5
         4mCh2wGl+c4ZJBW3VoS2R3SPCm+wMH89PsSLeotQklQM2jOao+3f9Kq9uhQAvUZKC5
         G3Js3w0PGDneSHlMbomuA2qx6GgWr9pSSpTUsX8djiv+/mrS6IRrNYyiIgqXWbcmVx
         JlDwaLMpEwVzsdTaDoS5oFOxENdYb22u3wBXD49rcxNZ6R13Yr+9lTwzIoq7dmnmJR
         qSU/QpZJM0h7A==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     aisheng.dong@nxp.com, ariel.dalessandro@collabora.com,
        festevam@gmail.com, ioana.ciornei@nxp.com,
        jagan@amarulasolutions.com, kernel@pengutronix.de, krzk@kernel.org,
        linux-imx@nxp.com, matt@traverse.com.au, matteo.lisi@engicam.com,
        meenakshi.aggarwal@nxp.com, michael@amarulasolutions.com,
        nathan@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, tharvey@gateworks.com, robh@kernel.org
Subject: [PATCH v4 2/5] dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
Date:   Fri, 10 Dec 2021 10:23:16 -0300
Message-Id: <20211210132319.61196-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
References: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BSH SystemMaster (SMM) S2 board family, which consists
of: iMX8MN SMM S2 and iMX8MN SMM S2 PRO boards.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0b595b26061f..d49c4b786f09 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -758,6 +758,8 @@ properties:
         items:
           - enum:
               - beacon,imx8mn-beacon-kit  # i.MX8MN Beacon Development Kit
+              - bsh,imx8mn-bsh-smm-s2     # i.MX8MN BSH SystemMaster S2
+              - bsh,imx8mn-bsh-smm-s2pro  # i.MX8MN BSH SystemMaster S2 PRO
               - fsl,imx8mn-ddr4-evk       # i.MX8MN DDR4 EVK Board
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
               - gw,imx8mn-gw7902          # i.MX8MM Gateworks Board
-- 
2.30.2

