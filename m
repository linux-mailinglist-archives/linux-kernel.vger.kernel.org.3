Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E3528A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbiEPQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiEPQcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:32:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7B3B3C5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:32:14 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GDemVf001086;
        Mon, 16 May 2022 16:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=U6iT65ESgj9xzT9FPRXtWt9FQhbGzgoa/PB5GErlu/A=;
 b=e2I5X9vPZTDG7G/kLXQSR+TRHq5GmqSF6qNJM4nwlQfBC6Vm0Ur3pYKWZHFnsDX5u+Ts
 Yrbwt0EsZNqWG1V27xqeFIwhiQ2JOgNCukWsAEIIIpz1BLQDOfwGNmOEbhtgtJliz6TF
 da+IicWndzC7QxrLh1vL+2IzIIakj76aFhTEZ4ADfTasPOAjElPCGX1YR86nlhR5VP/1
 na0NvZgEYNzabbvB9wgu87twSUZGd5tXmk6YEdx0fFWAsYDK/19Yac07JU8XMbNqmvvg
 +wQ2kx/nowZPwIwhWsg9JrdOK8JPYRyQq79WC1tcArxvyiDZw2+/yqyMqVmDHavAA8S2 aw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g3qq6a9c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 16:32:03 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9084454;
        Mon, 16 May 2022 16:32:02 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 2F1FD4D;
        Mon, 16 May 2022 16:32:02 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>
Subject: [PATCH v8 2/8] ARM: configs: multi_v7_defconfig: Add HPE GXP ARCH
Date:   Mon, 16 May 2022 11:33:40 -0500
Message-Id: <20220516163347.44890-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220516163347.44890-1-nick.hawkins@hpe.com>
References: <20220516163347.44890-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: YXiORmkdndk2cOF8DLGPc6o0we7Zri1V
X-Proofpoint-ORIG-GUID: YXiORmkdndk2cOF8DLGPc6o0we7Zri1V
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=895
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160092
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v8:
* No change
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

