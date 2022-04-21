Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5509B50A8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391591AbiDUTWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387596AbiDUTWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:22:39 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF764B42E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:19:48 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23LGWVnT011527;
        Thu, 21 Apr 2022 19:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=niYCdx3KmC+b8F2xSqYbMLX2jeyedyN5e/Xr0GdPYSo=;
 b=jmzAQ6dQqvMYTgWfV47Txv6AHBJYFkNcod4NPsrCvmDAI/cE2Ly+mGc7sgBpUvUbeCwH
 yWAgr76ttnA5NHRPH8RCvp73u7t/GLnDLaPtAXoEB263h6T1Q0Y++me9Gm/NPVC9fG/1
 nKBnGuJgtyLQ6K8Dn3LpJhuJgp5bCv8Fk4jw6U/25+CW2dk2H98Dsy/6VNtWZrqCKrWc
 SO2o7k6PMBRn8KIq/a4kwWI/+tubhjFiubWV2JpluaXARpXrMmgcK1OTatRsq6W3FuWu
 zM28dNAgOI2/VImLw+hOIBSOQvtg6fA4BnxNubUmvnxgZR5yo2e18L82JuN8Y6x5b90y qQ== 
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fk9c8a8u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 19:19:38 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 533FEA8;
        Thu, 21 Apr 2022 19:19:37 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1144748;
        Thu, 21 Apr 2022 19:19:37 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, openbmc@lists.ozlabs.org
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/11] arch: arm: configs: multi_v7_defconfig
Date:   Thu, 21 Apr 2022 14:21:23 -0500
Message-Id: <20220421192132.109954-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421192132.109954-1-nick.hawkins@hpe.com>
References: <20220421192132.109954-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: e7owwhqnL2Ew66ICbsEH-7Ad09w5qdBy
X-Proofpoint-GUID: e7owwhqnL2Ew66ICbsEH-7Ad09w5qdBy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-21_04,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=674 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the HPE GXP Processor by modifing the
multi_v7_defconfig instead. This adds basic HPE and GXP
architecture as well as enables the watchdog which is part
of this patch set.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v5:
* Fix version log
v4:
* No change
v3:
* Put into proper patch format
* Modified multi_v7_defconfig instead of created gxp_defconfig
v2:
* Created gxp_defconfig
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6e0c8c19b35c..d44988a708a1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1056,6 +1056,8 @@ CONFIG_QCOM_SOCINFO=m
 CONFIG_QCOM_STATS=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_HPE=y
+CONFIG_ARCH_HPE_GXP=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
@@ -1228,3 +1230,4 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_GXP_WATCHDOG=y
-- 
2.17.1

