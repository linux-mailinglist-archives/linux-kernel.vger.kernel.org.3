Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D82474F46
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhLOAbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:31:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55282 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLOAbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:31:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id CA0CF1F4535F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639528297; bh=ouExUklyMthcj79omiXop2ziTCGjMi7IGTTi+D1hVkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZO1I6Taw83BE661snkJpeh/2iNt5oIL2IOl0qFhxEnJukZElcrLhG9wbo+QVL7w3
         v/2XPuZeaEqGtpi+RiEXvh9xlFX6iAnAHzxQVehYaOX2urOJNzwM34hwVGl/b51PFj
         wwmNcFHn66g6c1autfPL0oWQyt1TQcP6HKf3nz7kH+H+MsgGf6k5oOSacxYkHHnGnv
         aA5geC0sOF/HiJy+4zCw3L1o+D/FzBzNxOSwSQQw3eDzniTKEkYET3V4zTwHesk5Gk
         To891sCx5iCVamYUp3IJaHYKKWQAyfaPgRuYvvNUhQ/EDHTg+FEz9oT6BFffkfDB3D
         yIQwDaxcM9iQw==
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
Subject: [PATCH v5 1/5] dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
Date:   Tue, 14 Dec 2021 21:30:46 -0300
Message-Id: <20211215003050.174125-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
References: <20211215003050.174125-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document vendor prefix for BSH Hausgeraete GmbH ('BSH Home Appliances',
B/S/H/) manufacturer.

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 66d6432fd781..5f35d7ad9760 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -187,6 +187,8 @@ patternProperties:
     description: Shanghai Broadmobi Communication Technology Co.,Ltd.
   "^brcm,.*":
     description: Broadcom Corporation
+  "^bsh,.*":
+    description: BSH Hausgeraete GmbH
   "^buffalo,.*":
     description: Buffalo, Inc.
   "^bur,.*":
-- 
2.30.2

