Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466E57E910
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiGVVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:48:25 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BCE89A46;
        Fri, 22 Jul 2022 14:48:24 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MI29hB013167;
        Fri, 22 Jul 2022 21:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=vVcjLOV0X9n814WVE1DuxvMHGrqOUt4RpnwROXxQiUk=;
 b=YWie7hn6UQ62Fogj6zIspJdeeqjYpTEZUVoctwxYNx+PgsL4dOyu1xuKCncgSlmgnm1L
 Ws+0z8Rd1jDf9fB70ONxDmp/9l4ThLsAIvYP4F/9XL11yhkY/BR9+XldnACjM5g6iIYd
 UrWdOKF/p2kPZPT/HO9XlCoLN6dspe7W1MTER0NvV/uGJGoeurOPJ9d8hNvDHu0Qatgv
 ENZUysMAd1/oQFtf6z2PoaWs4eTcZTFhloI3gnEnVesAtPJ0sTGofhXGLo0u+r3tqMjd
 Sdy6PrbjXX6CN4NWimWi2WNZhmLtXBPH/PjpLh2t6GKCsgKYfAtLfC2zq0qHhXRVNPNs 5A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hfsy3cs1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Jul 2022 21:48:09 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9651A1479E;
        Fri, 22 Jul 2022 21:48:08 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0FB7580A0DF;
        Fri, 22 Jul 2022 21:48:08 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
Subject: [PATCH v3 4/5] ARM: configs: multi_v7_defconfig: Enable HPE GXP SPI driver
Date:   Fri, 22 Jul 2022 16:49:19 -0500
Message-Id: <20220722214920.40485-5-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722214920.40485-1-nick.hawkins@hpe.com>
References: <20220722214920.40485-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: qx2a06wOLAoqigyz67dstFJ7Zz22LybR
X-Proofpoint-ORIG-GUID: qx2a06wOLAoqigyz67dstFJ7Zz22LybR
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_06,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=675
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

Enable the SPI driver on the HPE GXP BMC.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
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

