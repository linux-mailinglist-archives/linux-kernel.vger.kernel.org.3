Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F377651DF88
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389773AbiEFTQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351716AbiEFTQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:16:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD2862A22
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 12:12:32 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 246F35Ov006210;
        Fri, 6 May 2022 19:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=hi5yJCawXXVR8ptUD7Z7ZDw+zFGSudHFhiOWqxAXZLM=;
 b=YRCEMM52pnm3etVtMEFA6xhCncW13GA2C/DA2p/qQpdIj2YjksI4LCwHEFClzjmpYmhZ
 Wi0Ad22QMKDSr78V9eHfTgT9uuZ1fNTX0OcuadLlDqrMELT82JAAU9D07nG9GbrgNzBX
 oZX7PvjYOECoo4n55Hrt36yutb4mrB9Q85yE5dEtszDHmqOMcKQwZmDCpzhYBhQO6Ol8
 iFLp+JeLs3iJ+lwy/Zj9ujUxtx+Dt7WVFNhFQ4d63fyQ3aPVAC/pk3+dJ/tItC0ONSgE
 OfL3+5Mg0mLJjhskM4A9XkTIIlDCofcd2I82EV1iIPNNu2NBndlAfrWD0ps/EYJGoDKl TA== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fvk3wb88m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 May 2022 19:12:22 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 815848D;
        Fri,  6 May 2022 19:12:21 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 435DF4B;
        Fri,  6 May 2022 19:12:21 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>
Subject: [PATCH v7 2/8] ARM: configs: multi_v7_defconfig: Add HPE GXP ARCH
Date:   Fri,  6 May 2022 14:13:33 -0500
Message-Id: <20220506191339.78617-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506191339.78617-1-nick.hawkins@hpe.com>
References: <20220506191339.78617-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: m8Io5bfpkeNKLKb3g7XZC4GzIt1o7adx
X-Proofpoint-GUID: m8Io5bfpkeNKLKb3g7XZC4GzIt1o7adx
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-06_07,2022-05-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=894 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205060097
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Enable HPE GXP Architecture and its watchdog for base support for HPE
GXP SoCs.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v7:
* No change
v6:
* Changed the title to match others in log
* Changed the patch description
* Ran savedefconfig to place GXP configs in file correctly
v5:
* Fix version log
v4:
* No change
v3:
* Put into proper patch format
* Modified the multi_v7_defconfig instead of creating a gxp_defconfig
v2:
* Created gxp_defconfig
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e0c8c19b35c..bdbb1c90e65d 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -42,6 +42,8 @@ CONFIG_ARCH_HI3xxx=y
 CONFIG_ARCH_HIP01=y
 CONFIG_ARCH_HIP04=y
 CONFIG_ARCH_HIX5HD2=y
+CONFIG_ARCH_HPE=y
+CONFIG_ARCH_HPE_GXP=y
 CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX50=y
 CONFIG_SOC_IMX51=y
@@ -562,6 +564,7 @@ CONFIG_BCM47XX_WDT=y
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM_KONA_WDT=y
 CONFIG_BCM7038_WDT=m
+CONFIG_GXP_WATCHDOG=y
 CONFIG_BCMA_HOST_SOC=y
 CONFIG_BCMA_DRIVER_GMAC_CMN=y
 CONFIG_BCMA_DRIVER_GPIO=y
-- 
2.17.1

