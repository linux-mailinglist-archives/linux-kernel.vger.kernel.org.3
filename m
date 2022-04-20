Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB675508B62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379863AbiDTPCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379901AbiDTPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:46 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993755AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:59:58 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KEWx6T032267;
        Wed, 20 Apr 2022 14:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=Ykj4cszWHOqas1sdtRsDOMTT3R1YCNKROtLHY70yCAM=;
 b=LytZaCIr3MEGYIk9Qlg30pk6Jp7L2vQ6UdAvw74nQmmtC6ldho40lltQUU2OufntQaKU
 QHtc85vN+btdJcQRGLImHbZruTBYaXwLq3gdW/UDFyCRwipq9PQqQ2S/AwOXFA5OLNZi
 +GxQWkD9g09Q0jD+oYyT2h3Y/TFWFa6jz9OI6GUA7lP8TBuNwD9hdjOtgbuGsjFn7hXC
 GWGDBEN+UVTqRUb3x5xoYV8zHsmS2sr2THFH0hRnu86xTj++nNbZNCRuLPmLX5//FZ0X
 vxOAgQIn0Om0nqqpvV+36CNjbka7bogK5p51Flo4SS73H4NiJ4YiHsIVyDS9HSBACs0X QQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjbb0nc2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:51 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id CBD8881;
        Wed, 20 Apr 2022 14:59:50 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 8C1B536;
        Wed, 20 Apr 2022 14:59:50 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] arch: arm: configs: multi_v7_defconfig
Date:   Wed, 20 Apr 2022 10:01:46 -0500
Message-Id: <20220420150156.47405-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: RSP2_1RMrafPKPNhXzowOTEc0BkeDqQ5
X-Proofpoint-ORIG-GUID: RSP2_1RMrafPKPNhXzowOTEc0BkeDqQ5
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=584 clxscore=1015
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200089
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

