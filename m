Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913B4D5295
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbiCJTwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiCJTv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:51:57 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637A199D57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:50:56 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AFrEHR006153
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pps0720;
 bh=Sa1gUyFWh5sicRpLKEHW9i3iQGJspT4tSnvDEO4hTzE=;
 b=alcjw0CFpVY6+h3D0wyH3Qwy6ddEWHKpFXyOOwxwmWhsXGbeC7OXW0qjv41uJ3KBhaqB
 j7juGzQWCDmOhIOjXC1OMgrtj9AwXG5vtzwMjZ5Md99R6v9KypWfOV3t78p0cr/8F6HH
 ZYefeeBMKDV3EDsHHWEJpKl22FEiKASP9r4zKyyMJieQWv0rNmeEhq08rWy1ZHZz2cgd
 qAcp9MKU0qpckEbx9MHImMF9SOtvxBG8k2+7WvvKHt38lx4zSi1thDk3gT+JPo1qMs2D
 tw1eVaqBkbbVyKNTxBS5d87L16wEasIFwFoO8fUiSLa9jPz5KI4nbtg0lVwJ8fPjUdte GA== 
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3eqjfpk91g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:50:55 +0000
Received: from hpe.com (unknown [15.115.65.69])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id E4C7465;
        Thu, 10 Mar 2022 19:50:54 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com
Cc:     Nick Hawkins <nick.hawkins@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/10] maintainers: Introduce HPE GXP Architecture
Date:   Thu, 10 Mar 2022 13:52:29 -0600
Message-Id: <20220310195229.109477-10-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310195229.109477-1-nick.hawkins@hpe.com>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: JEsUgRydEmmd9UhQ_BaOwN6OaNBrfa4S
X-Proofpoint-GUID: JEsUgRydEmmd9UhQ_BaOwN6OaNBrfa4S
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_08,2022-03-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=783 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203100100
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

Create a section in MAINTAINERS for the GXP HPE
architecture.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6db79f3b209e..f227d76ec43d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8791,6 +8791,20 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
 F:	drivers/platform/x86/tc1100-wmi.c
 
+HPE GXP ARCHITECTURE
+M:	Jean-Marie Verdun <verdun@hpe.com>
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+S:	MAINTAINED
+F:	Documentation/devicetree/bindings/arm/cpu-enable-method/hpe,gxp-cpu-init.yaml
+F:	Documentation/devicetree/bindings/arm/gxp.yaml
+F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	Documentation/devicetree/bindings/wdt/hpe,gxp-wdt.yaml
+F:	arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+F:	arch/arm/boot/dts/hpe-gxp.dtsi
+F:	arch/arm/mach-hpe/gxp.c
+F:	drivers/clocksource/gxp-timer.c
+F:	drivers/watchdog/gxp-wdt.c
+
 HPET:	High Precision Event Timers driver
 M:	Clemens Ladisch <clemens@ladisch.de>
 S:	Maintained
-- 
2.17.1

