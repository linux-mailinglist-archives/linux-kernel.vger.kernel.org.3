Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9F46DC0A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 20:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhLHTZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 14:25:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbhLHTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 14:24:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 63D241F461B5
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638991236; bh=ouExUklyMthcj79omiXop2ziTCGjMi7IGTTi+D1hVkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e95sdLly8i1z+KOY5ySNTJDfnzZuX8+zwgsBTUTsHL4e8TW7SXsIQEOk5epKsNLVv
         DjT9TuEhNBIzA/pwh0+uUwVdl/l10qcJuVPdpgiq46SCi9i5Eq8C89oxLE7bHVT8D7
         tGtrBIB3oYD0ov40lIOhIKeSacyGyP63G4KPdP21StUMmkuSIH1V+V4PeLbkTg7OaP
         OSex1acn3hLCw99fRec6uND073TY/uqU2UM8IGkNh6EnFk42jrRf3625OgyMNGk8Sz
         MmNiF/PsoJ+E8EuNel97OebVgaFzZ+RWbX+Eoxx5+U4s5B2T3LF7o/n7ZhRC364Kd/
         j2A01E0BqHRkA==
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
Subject: [PATCH v3 1/5] dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
Date:   Wed,  8 Dec 2021 16:20:05 -0300
Message-Id: <20211208192009.322190-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
References: <20211208192009.322190-1-ariel.dalessandro@collabora.com>
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

