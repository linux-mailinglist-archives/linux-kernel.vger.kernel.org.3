Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECFE47017B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhLJN1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:27:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241706AbhLJN1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:27:18 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 1E98B1F4769F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639142622; bh=ouExUklyMthcj79omiXop2ziTCGjMi7IGTTi+D1hVkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRbA/pP9L++5c7RmHD4Q6VsAG69js9jkSNt22Pe9nMDu615CG8+bCI81EZqJPG48M
         yOS5HDZlyzN4DQ63eDNIuhH5fp1UaLRFH7X3JUpkLyOeBhuAok6aGeocM3pKJe8atJ
         sytt9/l8rKZXwfrhCM3+Y13Dp092Kamy9r/sNC2W8KjOyNAK3gUmYQW9ULluf7JzRi
         4Nqs5me/NBvpm8K5YVToU42N0QSreyf5ye23BdeWFzG5U78JYJatKOv77fX53LmZsy
         QnYd8Lg2MCQ9/Z1mrr34lnhLNIW22bRRDcXEeF0NpDEOt13DIA8yuYX6gomOhe2kZZ
         v4fSJff9oJF/w==
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
Subject: [PATCH v4 1/5] dt-bindings: Add vendor prefix for BSH Hausgeraete GmbH
Date:   Fri, 10 Dec 2021 10:23:15 -0300
Message-Id: <20211210132319.61196-2-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
References: <20211210132319.61196-1-ariel.dalessandro@collabora.com>
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

