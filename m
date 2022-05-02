Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2C1517851
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387433AbiEBUnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387232AbiEBUmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:42:52 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E168BBCB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:39:22 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242KM59O023745;
        Mon, 2 May 2022 20:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=LsB/OdK8DRxpU2q81q4ChNAakwpLfxSKrnloKeVwOx8=;
 b=Y6ttd3YiamiDZrevMq+Jfkf4pFF3KdTxAAsmed/GlZw8z/hverR24jO9iFh2aB/T6bFW
 KMllk+JC34lxG/7IiQ+M40uczy1TmXvzTJsbjUNS2oKNpYgAKAI6KWFasS/UgQ2n2jW1
 0iA2P19QitlOGRCSJZN3uqrynjS9Pd0RPMeJIznBMKYnqPpis6jGJPCtmRfdlPtFw0E0
 MZX7ShoFZVi4EK98uc3FjuYBbnYEKObRjlE7qhs/ziPzT7VJn89LPpbl5+Mh0QYus+DU
 X7VkFYnNM+1zxUfDrF+tyX9mrKeiiNl4z3/m1eUpG5aQdM4XO7dg1zfuq9bhsDesGPAN zg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ftkrc9n83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 20:39:13 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id DF51157;
        Mon,  2 May 2022 20:39:12 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 8F30B4B;
        Mon,  2 May 2022 20:39:12 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH v6 2/8] ARM: configs: multi_v7_defconfig: Add HPE GXP ARCH
Date:   Mon,  2 May 2022 15:40:44 -0500
Message-Id: <20220502204050.88316-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220502204050.88316-1-nick.hawkins@hpe.com>
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: Qa7HMg8LQ0mZWsPBAW0ETnByn9fsEdmB
X-Proofpoint-GUID: Qa7HMg8LQ0mZWsPBAW0ETnByn9fsEdmB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_06,2022-05-02_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=846 lowpriorityscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205020153
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

