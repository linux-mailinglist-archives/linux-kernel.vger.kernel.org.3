Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE2508B60
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379878AbiDTPCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379899AbiDTPCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:02:46 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6366EB851
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:59:59 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23K8dPgt020693;
        Wed, 20 Apr 2022 14:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=okdmmBVzMoe5zexkeVH8AQxVR3ywQ2EOlHX9EfmGBRI=;
 b=A1eiNN4SVeIJ3qqlrSpgKfsGRBEzPIaeM7I15I9qVCTKQ6r7xZrUrq2g/lalqytkGuXK
 DrAnEMVN0Fipr2gpKXAuqF1ZxyrWesAvxmih3bAIpT5Vcn0fsrIm3wyQsz1zhoXkfWfx
 N5s4YxoDT4FWCB3f35hCYKxTcU0l+GZwbdz6UfScGSHjkVbmR/9LnQ4JPBeO0d+CrfQd
 F9+IZ91fclRNahj7szaunpz63YPMUFJS5GWN+RfwYQG7i/CpDuiAY16oGloqRJD877QN
 ttD17km1xeqV7pJvY1EnmnL2/OqpVLU3phW7aMd7FJhrY4zuzt90exoI3qDeXmDFULPx ug== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3fjeujkake-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:59:56 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 0510983;
        Wed, 20 Apr 2022 14:59:56 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id C69AB3F;
        Wed, 20 Apr 2022 14:59:55 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick@hpe.com, joel@jms.id.au, arnd@arndb.de
Cc:     Nick Hawkins <nick.hawkins@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/11] maintainers: Introduce HPE GXP Architecture
Date:   Wed, 20 Apr 2022 10:01:55 -0500
Message-Id: <20220420150156.47405-11-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420150156.47405-1-nick.hawkins@hpe.com>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: rjBHqp0LjC4TSuTES7FEg5HVbFpf2rBx
X-Proofpoint-ORIG-GUID: rjBHqp0LjC4TSuTES7FEg5HVbFpf2rBx
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=849 lowpriorityscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Create a section in MAINTAINERS for the GXP HPE
architecture.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v4:
*Added ARM/ before HPE Title
*Changed MAINTAINED to Maintained
*Renamed gxp-timer.c to timer-gxp.c
*Renamed gxp.yaml to hpe,gxp.yaml
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6db79f3b209e..c3164a527747 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2062,6 +2062,19 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	arch/arm/mach-sa1100/include/mach/jornada720.h
 F:	arch/arm/mach-sa1100/jornada720.c
 
+ARM/HPE GXP ARCHITECTURE
+M:	Jean-Marie Verdun <verdun@hpe.com>
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	Documentation/devicetree/bindings/wdt/hpe,gxp-wdt.yaml
+F:	arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
+F:	arch/arm/boot/dts/hpe-gxp.dtsi
+F:	arch/arm/mach-hpe/gxp.c
+F:	drivers/clocksource/timer-gxp.c
+F:	drivers/watchdog/gxp-wdt.c
+
 ARM/IGEP MACHINE SUPPORT
 M:	Enric Balletbo i Serra <eballetbo@gmail.com>
 M:	Javier Martinez Canillas <javier@dowhile0.org>
-- 
2.17.1

