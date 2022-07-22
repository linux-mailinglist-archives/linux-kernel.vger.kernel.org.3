Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DBF57E912
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235960AbiGVVsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiGVVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:48:25 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA587AF94F;
        Fri, 22 Jul 2022 14:48:24 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MK9lq5027459;
        Fri, 22 Jul 2022 21:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=xZzO3Ro6sxExQwjZ9ZijcxoiKQx1aXqdy0iUwz2jxhQ=;
 b=gDzuk6LCWMMPsDkhB4IJM6BKqGC7eRVLLhL0wj6XV+pUj8KH0YhQbpt0/qO9RRKbkwoo
 wuxw010PwGPKy38ECPsaYgEn2U3PTSLJzFoiEL2qVyTdM8bFk03tq2nRV6MVymxRLgft
 VSNdEFyFl+5aDH0fffkArrBnVS3tCt9wf/a2cutklUuBzx4RFQ0/6kAC7RQfMaVx0Sr1
 XhuJjxqC1d34Cms1z8cXr4b72t7nuPVkE9HBz/jJK4h0PWRj16pNiBVOKoMCxzVW07Mj
 dJaSbNToXOa8ja4HJC7QgvBRVjo2KI/2ykkddhAsI39K4/5BPYG4ry/U4t0mgHnH/PCY TA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hft5w4mtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 21:48:10 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 338E1804C87;
        Fri, 22 Jul 2022 21:48:09 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9ED658032AD;
        Fri, 22 Jul 2022 21:48:08 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v3 5/5] MAINTAINERS: add spi support to GXP
Date:   Fri, 22 Jul 2022 16:49:20 -0500
Message-Id: <20220722214920.40485-6-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722214920.40485-1-nick.hawkins@hpe.com>
References: <20220722214920.40485-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: ujbAZajTf4R08ysvh-Uml_749YqpLgB_
X-Proofpoint-ORIG-GUID: ujbAZajTf4R08ysvh-Uml_749YqpLgB_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=949 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207220089
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add the spi driver and dt-binding documentation

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v3:
 *No change
v2:
 *No change
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

