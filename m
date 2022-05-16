Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4CA528A7C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbiEPQdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiEPQdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:33:02 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA43B3D5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:32:44 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GAVxAL031916;
        Mon, 16 May 2022 16:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=ZtJJg0yXTQwmrw5bLqDBaOvIBYz078x224mjTlaSgZM=;
 b=V3eY3Tuu8ERT098AbGWYpyeGSJLbl4dOhge5KmQpKvce5bH3haYR7JOUMJMcMNBRwuas
 Zy/nxVMuv+y4TH5qEbxWXcmZFBPEe6nhzcss0ql0snhOZ+oUpsxaiAU8AhUKWXg9P5qF
 0cAsYC8Ph2BSzQBog1LgPQujcefYMptIAWRJm+UlPyhrJtvlUjyI7GJJY+SBwZCK8yqi
 p2nl8QqSTlDMk3y44JD5bXrOxAxqKOPv4ZuMdljHbeI2uWuTR7qHjtMofkhBOd4Uz/fD
 Hk9ok7BwXKIVIX8zlVWGkzUyZohEGPVijS5KVdawdaWsry3Dvf51eMVHzo57wB96Ep76 Pw== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3g3knfng43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 16:32:39 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 668F657;
        Mon, 16 May 2022 16:32:38 +0000 (UTC)
Received: from hpe.com (cigateway-dev.us.rdlabs.hpecorp.net [10.14.73.30])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 391C94F;
        Mon, 16 May 2022 16:32:38 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 8/8] MAINTAINERS: Introduce HPE GXP Architecture
Date:   Mon, 16 May 2022 11:33:46 -0500
Message-Id: <20220516163347.44890-8-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220516163347.44890-1-nick.hawkins@hpe.com>
References: <20220516163347.44890-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: NcMD-MjuhtVg0KxRD8hZxKp03CnFT8cz
X-Proofpoint-GUID: NcMD-MjuhtVg0KxRD8hZxKp03CnFT8cz
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_15,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Create a section in MAINTAINERS for the GXP HPE architecture.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---
v8:
* No change
v7:
* Changed arch/arm/boot/dts/hpe-bmc-dl360gen10.dts to
  arch/arm/boot/hpe-bmc*
* Changed arch/arm/boot/dts/hpe-gxp.dtsi to arch/arm/boot/dts/hpe-gxp*
* Changed arch/arm/mach-hpe/gxp.c to arch/arm/mach-hpe/
v6:
* Fixed subject to match other commits
* Removed hpe,gxp-wdt.yaml from file list
v5:
* Fixed commit message to list all previous changes
v4:
* Added ARM/ before HPE Title
* Changed MAINTAINED to Maintained
* Renamed gxp-timer.c to timer-gxp.c
* Renamed gxp.yaml to hpe,gxp.yaml

v3:
* Removed uncessary files
* Used proper patch-set format

v2:
* Fixed email address
* Removed multiple entries in favor of one
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..ce28eb2843c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2130,6 +2130,18 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	arch/arm/mach-sa1100/include/mach/jornada720.h
 F:	arch/arm/mach-sa1100/jornada720.c
 
+ARM/HPE GXP ARCHITECTURE
+M:	Jean-Marie Verdun <verdun@hpe.com>
+M:	Nick Hawkins <nick.hawkins@hpe.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
+F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
+F:	arch/arm/boot/dts/hpe-bmc*
+F:	arch/arm/boot/dts/hpe-gxp*
+F:	arch/arm/mach-hpe/
+F:	drivers/clocksource/timer-gxp.c
+F:	drivers/watchdog/gxp-wdt.c
+
 ARM/IGEP MACHINE SUPPORT
 M:	Enric Balletbo i Serra <eballetbo@gmail.com>
 M:	Javier Martinez Canillas <javier@dowhile0.org>
-- 
2.17.1

