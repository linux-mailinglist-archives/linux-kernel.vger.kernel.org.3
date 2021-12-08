Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D616446DC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhLHTZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:25:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48734 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbhLHTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:24:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id B495D1F45750
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638991258; bh=Vb5Bjd+fXKA+b0blXOHq5tV616m7oKW8StxQz1eT4Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lcj6jny4eZqA6EXjyZEh79g091Ve8aq03/Q0CmZx5XJ/V6yzYy4rCb04J56+wgIbV
         H5fRBS4De/w+8466L5+z1n90GFL/0jfgfn5G2pQrjpMFEBZUEAPO7F6S22+CE416ex
         zAxTQmCoN3GhYNFFN2nCQy6N8vmKQXUr6k6NhySXtL6tqf0FrsTcQcckYGU9lPkF2i
         Bxj5NPb8rU6Q5xk50IEt+8mwpbfEIdHy5AUVuSg+YjnrmbI7XHqzX0DoYzRBkd0D/5
         RKarKr8MGc4/d27IdGZAPcCA1FmCepPpuRJnpyQmWgzOH8qJkehR/G90705zE+p7kT
         mumwt/EC4O9uA==
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
Subject: [PATCH v3 4/5] dt-bindings: arm: fsl: Add BSH SMM-M2 IMX6ULZ SystemMaster board
Date:   Wed,  8 Dec 2021 16:20:08 -0300
Message-Id: <20211208192009.322190-5-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
References: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
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

