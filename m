Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE08646489C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347787AbhLAHei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:38 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24279 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347612AbhLAHeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343840; x=1669879840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1QvJ9gWzq0yxFwUpcASaqd+k6y0FCM+T2SnpPho/+Y=;
  b=LHGH5evdbSnyg+yDvuJkLnRrni/x37HPzE8eu0IlBCv+VhCE6pLSEkxc
   nfDdjI7FQuCzcJzkkoTW1tZBy8QtefANpXY9tbuu3DTBf2n2Gy0jXDN/k
   FDIpwX9f+8/zLO8cTNKAGkqiz91MKn6CP74c6cUhdU5yjjXGBwKMZqpjg
   QKpA2822f8PAWNXgDtO6/P3BoenpfIlDVjB7XpWCX6KMbzG3Ik2wK8vWE
   Q7QRv4AIt9fKEG0z0S7pdsReoPM5zo/mYKi3ZsWhREymU1xpJ2zwXH+b4
   mwU3KCPw/Ygb0RPD4mnEgEDXAilMf09a8waeBKSRIns304KV38SsTpeol
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773249"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:05 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:07 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343807; x=1669879807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s1QvJ9gWzq0yxFwUpcASaqd+k6y0FCM+T2SnpPho/+Y=;
  b=kQTCF9YUM/9GtYm6fIGUiOfMa4O2kn2HdraAEGHdVEPIKcM3iCnp7XoX
   p8CTNzCC+s/nsGhqZVXoo4SefBBMLyl3EAnA5OygkNAh6BNUYMmJGxFO6
   kjBP9mE+kqY8gUukjteoeYkfi8YZBLaL2QsYS9AJRKUdHYH8wAQUlL8Qj
   nepp0+WsssbTldQNILsEq4RJZRi4MAXy4jFA/B3BL+H6XpetG7idaNqNR
   SY/O2SPya8njrVW6F6GP51rrsAGq7kLfleQr0+5P+eiIMytYcON307+OQ
   BMSNpXuGFhw9VKNad1OVk3uf1BXlL6DmrJpv/KIltV4xI1CHbdDLgB401
   g==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773235"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:04 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id EBA5C280065;
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
Subject: [PATCH v3 6/7] dt-bindings: arm: fsl: add TQMa8Mx boards
Date:   Wed,  1 Dec 2021 08:29:47 +0100
Message-Id: <20211201072949.53947-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TQMa8Mx is a SOM family using NXP i.MX8M[Q,QL, D] CPU
MBa8Mx is a evaluation mainbord for this SOM

The SOM needs a mainboard, therefore we provide two compatibles here:

"tq,imx8mq-<SOM>" for the module and
"tq,imx8mq-<SOM>-<SBC>" for the module on that mainboard

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
* None

 Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 145f529ffc45..47f91b43f74f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -827,6 +827,15 @@ properties:
           - const: purism,librem5
           - const: fsl,imx8mq
 
+      - description:
+          TQMa8Mx is a series of SOM featuring NXP i.MX8MQ system-on-chip
+          variants. It is designed to be clicked on different carrier boards.
+        items:
+          - enum:
+              - tq,imx8mq-tqma8mq-mba8mx # TQ-Systems GmbH i.MX8MQ TQMa8Mx SOM on MBa8Mx
+          - const: tq,imx8mq-tqma8mq     # TQ-Systems GmbH i.MX8MQ TQMa8Mx SOM
+          - const: fsl,imx8mq
+
       - description: Zodiac Inflight Innovations Ultra Boards
         items:
           - enum:
-- 
2.25.1

