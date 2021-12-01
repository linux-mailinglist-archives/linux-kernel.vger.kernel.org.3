Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D95B464894
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbhLAHeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:07 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24279 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347522AbhLAHdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343812; x=1669879812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZTtZvN4r77ekNq04z0cDsPv+Q//rqhUvVF12fGMDlo=;
  b=nZiTULhOxETUIc8dn/wviRV7P/WG/HZbhDT/RcyUuy4FGtYv1yi+8lyp
   DT0UZXLerTYrqwLPZS5PMwzCJu7kk9RwLlIvfhHaQwedCVngupjIbYXz7
   ohzYcFpMSXmC3iB4ohYK7g/VITRgoYM2Xj/LQFlo/rEX72MYsZe3sgvdX
   Y+uHAHespMgYY6uMGFSndpgSIMki4nyncN83xHDMFaJQ4/+i2kBBlSjSM
   aBNIoD/7TZJ4b7+VQmwMXraCSe2PRuIVArQc34V4Oe5sDopixA703bnvn
   slLFJlvpZCp97m7T5Usghq+BmRcWw8aXL3JgMvvVbLithgo66afj5Jf9W
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773240"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343805; x=1669879805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eZTtZvN4r77ekNq04z0cDsPv+Q//rqhUvVF12fGMDlo=;
  b=APZlQrWvs9ShddzoEZHSfW5i3LbP+PoQy2ih1dWm9F9rEULHXOmQqvU5
   k10F1TqWRlXlp0QWH1ooxVxQmJ6htKTIlPn4tKabkcf16Q3coXN2H1XKk
   To80UQed1f3d6TcS+ZlqFE3J3C497E1rXDLkb9PcXyi/bo2/A34vXF+e2
   HKCymg+T3b7SUN5ws7bKJfeFcVawfEk4PnTVhcs623vX+XzqeZLfkE8s6
   qeyw/aeMUFAJBKRMhSQgpj4wAlW/SoSzrvO3255KcNNyreqvkOZiY3VMW
   DtSe89BUfwmr/C6bXu0MM/puvcsel0B9efKC/igp07AYS3Vbf/5RYfT+u
   w==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773230"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:03 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 834DB280078;
        Wed,  1 Dec 2021 08:30:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/7] dt-bindings: arm: fsl: add TQMa8MxNL boards
Date:   Wed,  1 Dec 2021 08:29:45 +0100
Message-Id: <20211201072949.53947-5-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8MxNL is a SOM family using NXP i.MX8MN[Q,QL,DL,S,SL] CPU
MBa8Mx is an evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mn-<SOM>" for the module and
"tq,imx8mn-<SOM>-<SBC>" for mainboards

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
* None

 Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index abcf559e311e..145f529ffc45 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -780,6 +780,17 @@ properties:
           - const: variscite,var-som-mx8mn
           - const: fsl,imx8mn
 
+      - description:
+          TQMa8MxNL is a series of SOM featuring NXP i.MX8MN system-on-chip
+          variants. It is designed to be soldered on different carrier boards.
+          All variants (TQMa8M[Q,D,S][L]NL) use the same device tree, hence only
+          one compatible is needed.
+        items:
+          - enum:
+              - tq,imx8mn-tqma8mqnl-mba8mx # TQ-Systems GmbH i.MX8MN TQMa8MQNL SOM on MBa8Mx
+          - const: tq,imx8mn-tqma8mqnl     # TQ-Systems GmbH i.MX8MN TQMa8MQNL SOM
+          - const: fsl,imx8mn
+
       - description: i.MX8MP based Boards
         items:
           - enum:
-- 
2.25.1

