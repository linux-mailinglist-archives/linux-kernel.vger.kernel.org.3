Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C47474F4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbhLOAcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbhLOAcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:32:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D8C06173E;
        Tue, 14 Dec 2021 16:32:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 1D5401F45355
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639528327; bh=Vb5Bjd+fXKA+b0blXOHq5tV616m7oKW8StxQz1eT4Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQw9I+DGoI/Y04qnOn9Y4lTCngwN7KdIz36Rq1/+RLYDFGa1aEDv3IttSuIhYcH1E
         3Rto0ZxrRbC6EOAfR+uOI51qVg3Be4vYXGr2ZZ9yZH+3/l1/DtPAN0KSMl2uny4uQ6
         hmnl4Ar4hRKAIVof5DGlU3S04zUOh330kSnyyL/mZxg0UeJlh62MP67uqW4MBcBr94
         1N1pEj1Og/X07TaAdTP41qdtPrS13RZRCeACNKIyHdRQear8jClaZ9ZnyXNrkBmt00
         O9h1DhAIlxEJn2aXJot/Gn7tTssGy9G3hiy+JlfITVUee7WWjAHBBXLjt3brRHekAB
         Pm43TLtmcUjeQ==
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
Subject: [PATCH v5 4/5] dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board
Date:   Tue, 14 Dec 2021 21:30:49 -0300
Message-Id: <20211215003050.174125-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
References: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for BSH SystemMaster (SMM) M2 IMX6ULZ board.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d49c4b786f09..461b9888812e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -632,6 +632,7 @@ properties:
       - description: i.MX6ULZ based Boards
         items:
           - enum:
+              - bsh,imx6ulz-bsh-smm-m2    # i.MX6 ULZ BSH SystemMaster
               - fsl,imx6ulz-14x14-evk     # i.MX6 ULZ 14x14 EVK Board
           - const: fsl,imx6ull # This seems odd. Should be last?
           - const: fsl,imx6ulz
-- 
2.30.2

