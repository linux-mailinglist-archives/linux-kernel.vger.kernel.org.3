Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A0474F49
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238532AbhLOAbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:31:49 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55304 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLOAbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:31:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id E8A051F45355
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639528307; bh=CJhjsCMyqEP65R/Xg2NhSIIrFMgqoU+gWwEZab6mGv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgUd/CFFdR9ilWg1XVKaucfvC4rx4etQ4M9scVg8LVk6OImNH0gQOkd5h7RLyV6Wm
         9CLw8Ws5JzHROtqnoInXOiSSCBrSbA5om4dVAVBYI5NHv45jDHcyBl/2BdhvX+Ugqk
         Zhh/mCxiPZRE/BGTDUu+NprW8+e1Fs0i8Vyrosiyeh9eUsmVT+KqItqIloqKfz6TI6
         fcYAopVy4hl26dqm3bji17IDb3gRISMZI6Kryfqex3zvbk3wWPmaqdG4W5HtypdLLq
         RzbgWQ2XPnlpVU1O31xF5pb5Yu2aqHYn2h5Av6SUEfTo0fRGT55ftl9KDsmTmDZb8M
         sUYRCQIbyh9QA==
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
Subject: [PATCH v5 2/5] dt-bindings: arm: fsl: Add iMX8MN BSH SMM S2 boards
Date:   Tue, 14 Dec 2021 21:30:47 -0300
Message-Id: <20211215003050.174125-3-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
References: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
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

