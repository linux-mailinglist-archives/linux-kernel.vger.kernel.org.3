Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4646DC0B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhLHTZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:25:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239598AbhLHTYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:24:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 629151F461BF
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638991244; bh=CJhjsCMyqEP65R/Xg2NhSIIrFMgqoU+gWwEZab6mGv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge/PV3SPI1DCqhVLLcchbqWiloDaYCbzc3PczmSfEUanyF6JL6k79tQ05k3klRxXJ
         PwpPt7B8/JsyYFhJX3e+zqgzrdG/xYFCkIKr0MJdWuBQ40PzMW9iArDbkmLQTFfF6z
         RrmBwdg21x9+55Y7KJcK512eT1KRjti2vhK4WHIbRZkUh6EPpiNBnZgp14za7zV7Kd
         YkNF4HJqvPEhc3EOnU/w+0EhfiEDjPH3lCEJFJNcLMVFXPmP/Eau5bjfY4YrlIOUjW
         TMUGqQRLyn4X+VqzffgxRLW5Hv4d1DiFiB5sij8EGO6Hm7lfQ9Mzm5XxR8g2sw3j2x
         mcrC6L0S5MaHQ==
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
Subject: [PATCH v3 2/5] dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
Date:   Wed,  8 Dec 2021 16:20:06 -0300
Message-Id: <20211208192009.322190-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
References: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
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

