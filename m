Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6656957BF0F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiGTULX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiGTULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:11:15 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCE3138D;
        Wed, 20 Jul 2022 13:11:15 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KJOQGx012116;
        Wed, 20 Jul 2022 20:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=M7oqZk9pIMb0OzX4meUfieagzMg+2ujqpYSxOVaae4o=;
 b=gS+IKlgBhj2ltBFivKiuhnzPC+tR3o82QIHpwQobD3Chz9a+WemmXO5zdI5uz0SwgB9x
 R6wRZpk8NxZkEYu5RvpwR4bwxjixNnO6/BVoezDve+y7A5IfV8mTwcftkhXgeTWZCqZ0
 GHEcHOG/7DKguvukItizAliuNFNQZhKr7sxvb3t7ZSx7Fhf3ZJ6jQmuxRRTF93LL+JeB
 uOhe2gd5zeW3DXoHq0zQYXrbqinMmx1almvdkTXCSjLXtDzTtxSMzpK9O4yCsDBr6cIJ
 u2HeRIiXbq36myJIet9fBR0wkqdYHxzuFuND5c2lkWJpzheHSgBkA703UuwdLbvlfldJ eQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3henjmsdcq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 20:10:51 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id BD1FDD2C1;
        Wed, 20 Jul 2022 20:10:50 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 31CFE808C08;
        Wed, 20 Jul 2022 20:10:50 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v1 5/5] MAINTAINERS: add spi support to GXP
Date:   Wed, 20 Jul 2022 15:11:58 -0500
Message-Id: <20220720201158.78068-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220720201158.78068-1-nick.hawkins@hpe.com>
References: <20220720201158.78068-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: JffD7m1bD6H-YEVNt3XlTPnsXeJ0ktDq
X-Proofpoint-ORIG-GUID: JffD7m1bD6H-YEVNt3XlTPnsXeJ0ktDq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_12,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=931
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200081
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the spi driver and dt-binding documentation

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..f87728549ecf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2140,11 +2140,13 @@ M:	Jean-Marie Verdun <verdun@hpe.com>
 M:	Nick Hawkins <nick.hawkins@hpe.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/spi/hpe,gxp-spi.yaml
 F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
 F:	arch/arm/boot/dts/hpe-bmc*
 F:	arch/arm/boot/dts/hpe-gxp*
 F:	arch/arm/mach-hpe/
 F:	drivers/clocksource/timer-gxp.c
+F:	drivers/spi/spi-gxp.c
 F:	drivers/watchdog/gxp-wdt.c
 
 ARM/IGEP MACHINE SUPPORT
-- 
2.17.1

