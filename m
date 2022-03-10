Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86954D529B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiCJTve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiCJTva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:30 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E52143470
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:50:29 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AG1t91022382;
        Thu, 10 Mar 2022 19:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=Ykj4cszWHOqas1sdtRsDOMTT3R1YCNKROtLHY70yCAM=;
 b=DbCvb3YKLnbJLu5rfAFIl3MyQ00xDb7y4clRW+9PwaCR1fqUnLHyYCYqIsN1u9MUmGqJ
 fDOEXuQVyrD0hH2YApQy4Lm70lpOkJSaGoASiBlBAuoTrLgbeQS1TvUt51m1B5orl58R
 gnE1ucnmvvpanllhH/2m43wJgPuPSp7lOjYN8OY3fM5+UW0qQMXruA9Pjj4iPhvmA7Ki
 arwXVsrgJZgisrcMAt2+P4J2EvyIU+5g1EQHTxtylwl7Fa6V+A+DKaVNt0N4ePImb1LK
 bWjDWuWQ4cxHPCprqpqZryyhlsDmF+uto/R1wFKhxxn5Fw8swKFiXaV5zVSIz/u53df8 Dw== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3eqmarsyf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 19:50:24 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id 69B8365;
        Thu, 10 Mar 2022 19:50:23 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] arch: arm: configs: multi_v7_defconfig
Date:   Thu, 10 Mar 2022 13:52:21 -0600
Message-Id: <20220310195229.109477-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: osNuSt80d9MFPtaFrdYTH06WWa9JlW5q
X-Proofpoint-ORIG-GUID: osNuSt80d9MFPtaFrdYTH06WWa9JlW5q
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=541 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100100
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8863fa969ede..b93d213b7e60 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1006,6 +1006,8 @@ CONFIG_QCOM_GSBI=y
 CONFIG_QCOM_SMD_RPM=m
 CONFIG_QCOM_WCNSS_CTRL=m
 CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_HPE=y
+CONFIG_ARCH_HPE_GXP=y
 CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_R8A7779=y
 CONFIG_ARCH_R8A7790=y
@@ -1169,3 +1171,4 @@ CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
+CONFIG_GXP_WATCHDOG=y
-- 
2.17.1

