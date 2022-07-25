Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA02158053D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiGYUN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbiGYUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:50 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990CC21825;
        Mon, 25 Jul 2022 13:12:39 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PH4Wkm005214;
        Mon, 25 Jul 2022 20:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=qw2gbBqpfH4JlnRCLSLr9CXbVgCzY043TzDZOJYMzXo=;
 b=V32CJo+jUnT2srUr+tpItdqJr0B1672rZLO+gH1qMaLkonRafVyt3pckeVNz4o5G1o1D
 jL2sBnwmuiogN4DPN8ZdiI/hQvbUg3DQclrZlOSq4d3a3KrLkSYtKVvlRwiACAZ9z64X
 FXJ9AtNtKkIuiXntaCWKKdU3UXxnmXGQCRCtBmfCrEKc6Azz8CIOKdeuQZjt/jx4anfE
 hWYpB90N4tfUNeySr+eVk4lKpFoFWrkNbNd7br2k9V/a9sj8uZevxw8LA5hxW3/ic5V0
 p1Ip3cIOyKdECuG3GrL8PAlGvONYnyEXtTxa9/NrmSMdvC0Lc6brEoj+9FBS9F1GH19m VQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3hhy8dsekq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 20:12:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 21DBF804C87;
        Mon, 25 Jul 2022 20:12:22 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 749F28038DE;
        Mon, 25 Jul 2022 20:12:21 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v4 4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
Date:   Mon, 25 Jul 2022 15:13:21 -0500
Message-Id: <20220725201322.41810-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725201322.41810-1-nick.hawkins@hpe.com>
References: <20220725201322.41810-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: 08GpxQYDH8IpGqQwEHpg-Yut1h8a4yBY
X-Proofpoint-GUID: 08GpxQYDH8IpGqQwEHpg-Yut1h8a4yBY
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 mlxlogscore=673 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207250082
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Enable the SPI driver on the HPE GXP BMC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v4:
 *No change
v3:
 *No change
v2:
 *Change CONFIG_SPI_GXP from y to m
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ce9826bce29b..ee8a730dabc9 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -443,6 +443,7 @@ CONFIG_SPI_CADENCE=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_GPIO=m
+CONFIG_SPI_GXP=m
 CONFIG_SPI_FSL_DSPI=m
 CONFIG_SPI_OMAP24XX=y
 CONFIG_SPI_ORION=y
-- 
2.17.1

