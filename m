Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7BA149D48C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiAZVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:33:14 -0500
Received: from mx0b-000eb902.pphosted.com ([205.220.177.212]:43500 "EHLO
        mx0b-000eb902.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbiAZVdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:33:13 -0500
X-Greylist: delayed 1169 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jan 2022 16:33:12 EST
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
        by mx0a-000eb902.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QCEDHY006062;
        Wed, 26 Jan 2022 15:13:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pps1;
 bh=nlgMFj8DR7I9rDGvNrfInP42UeavYzJIDdkPhRBfySI=;
 b=kZISzbux4uXXK76cVSmF7r2EmlKx7CuvmPqdDVIXHDNehN/UpiRVs4ixbpPY+vYT7QnA
 04PVhJ+ncjXZCP8Thq6n3s8IorLVhU+1BTPmeh1eSeUYcN9/fX1kG//ElfsDpYOEPLrS
 YRyg4HPjPHIkpygiue4gsCT/m2jKNb5/au32ffcGq2uCT909DIkbxavlGxqqAI+pfo62
 qVoK9KZewdeW/4PBnZzizLhOQuGmKsSQlHopaZbFfRGTPh4S0+bdHzPlIkxOfcZZOYo0
 OGS9CxZsV5rZHM2MhAEbD8sQ5xS5aeWDUyFNiPXbcZseNhj+qKYS+Vc3rXiqSJxIqFR4 Kw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0a-000eb902.pphosted.com (PPS) with ESMTPS id 3du4bmrwwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 15:13:41 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPgiLVDh8oQdFPAaGxnVql58YKF9TFjZZY6/ZdXRFi6oBx8rgYUCo640gb9cezS4X/qALyiFCDnPMEg6eaV1uOpRx0Hfgr+b6Jh6AO4xYWcz7Wbb+BBuTVYb8S/oBrpBBaEwhKBn6MudQDxqKTl36qo+fc8jEgTVfeAv6NoUnx4aIa0HijSMvvbMw8zoRfMwmSHBm7A/CGq8FVvqeiHLdJScdB3sIe7T03pVq97HcCaIAFNXSMzNUln2Vh4F1EeIUkQ+F+hpNF5c0poOGI4D7nA69zuUsnS9YvyQA+1xwyvnZ45Y9hDGF24yg/WgDRlWMMmS9Q2uBBgWxFdTLMXuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlgMFj8DR7I9rDGvNrfInP42UeavYzJIDdkPhRBfySI=;
 b=NlrI7qiZ2NIE7hMJz/D+iBrxUHiUQSESOuSI9eHobGPQ0Uc4pQfIJ2iR0Huk2yMGO1q8n9IeVuE+NIco4XXsUpCqY3BiQfXY5uAHJ+hJIrTDRepmIXrW8GoBx2OuJDZGk6Y2r7Gw8aAItweCLjtNgcmgo+kGa5uAMFGFi7LWW7SHA9XtxiS8jkex0n6oQhCY35D8LpejUX6Cfl/1OP+GrDHHcnk3nqnEAGWUmLWL78iRIBUb/L6tdYa7MVUS1RZZElVsL6eZUdmwLuoZuiidlzmSTZEdjkpoOgwqoyy3YaxCxStSpJjPC7/sqjHxl4mc1MUWttSwWxeQN4f+vDDnVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 204.77.163.244) smtp.rcpttodomain=gmail.com smtp.mailfrom=garmin.com;
 dmarc=temperror action=none header.from=garmin.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlgMFj8DR7I9rDGvNrfInP42UeavYzJIDdkPhRBfySI=;
 b=ADsu7rO/BX52JlGprMBOUneHHe8uqPfmJ51GeRmzHDV07oCv9BfJ4tYtDm/w4eJLDtt0b8E3ItGnc2VtWqah9NrSsZIjbeIJP+U8NdxIvEvjWirrvsXLActhEtPkjT0JGaU/dqW4NY/AXiXw6L9WMaOCSoV0cODTJxCe3S1c3iS7zIWzpihCr9QfJ/qKjW1x6Zz10oQDqYTsfEJuRgYpOvt4Gd3MG/zdnNsspwDr9uubB0sqaANcBxFjHVPkOI1iBJBsaXPXZam3wjv/qogSziK49ivDIxH26Gn0WYTQ6aWim1mPRh0bYR/qDZM1vULQ4wbgOR85OPqk8MaxlEYewA==
Received: from CO2PR04CA0080.namprd04.prod.outlook.com (2603:10b6:102:1::48)
 by DM5PR04MB0796.namprd04.prod.outlook.com (2603:10b6:3:100::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Wed, 26 Jan
 2022 21:13:40 +0000
Received: from MW2NAM10FT054.eop-nam10.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::ff) by CO2PR04CA0080.outlook.office365.com
 (2603:10b6:102:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 21:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 204.77.163.244) smtp.mailfrom=garmin.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=garmin.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of garmin.com: DNS Timeout)
Received: from edgetransport.garmin.com (204.77.163.244) by
 MW2NAM10FT054.mail.protection.outlook.com (10.13.155.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 21:13:39 +0000
Received: from OLAWPA-EXMB11.ad.garmin.com (10.5.144.11) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 26 Jan 2022 15:11:13 -0600
Received: from cv1wpa-exmb1.ad.garmin.com (10.5.144.71) by
 OLAWPA-EXMB11.ad.garmin.com (10.5.144.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 15:13:38 -0600
Received: from OLA-DKH2RP2.ad.garmin.com (10.5.209.17) by smtp.garmin.com
 (10.5.144.71) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Wed, 26 Jan 2022 15:13:38 -0600
From:   Shelby Heffron <Shelby.Heffron@garmin.com>
To:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Shelby Heffron <Shelby.Heffron@garmin.com>
Subject: [PATCH v2] input: Add Marine Navigation Keycodes
Date:   Wed, 26 Jan 2022 15:12:24 -0600
Message-ID: <20220126211224.28590-1-Shelby.Heffron@garmin.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
References: <20210622235708.8828-1-matthew.stephenson2@garmin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40c26230-6b3f-49ab-7e6b-08d9e110b92c
X-MS-TrafficTypeDiagnostic: DM5PR04MB0796:EE_
X-Microsoft-Antispam-PRVS: <DM5PR04MB0796D136905D4D9FA366E71AF2209@DM5PR04MB0796.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECiFp5AZKEpw1OHw4JzTOpeYl99GJ0EtkUlWuhDRWgmI9aCdZ6SngwmSMsEqZy9TYG7D18hd10VBpsTOCUBA41KR4/X0dxlft0PVjrzQJI3PDDKiXwulaxibTIGRbdzC6dj9r9SLxHjfnXp66JVaFPe0SgG16KLIipvE3AZ0/prau3EouQ/RpGWdtSuO4CJJwtAovSx2NrQthsGTchJgWMXRo9Z5U/GSS+fiYMs0B66D51/Dvp4vb3DexNFFFhVundztAS+YjgwjFub1TdQsrCil0ryafzIkmSXqPGduA/Inac+gyMzSbobWdo4iDN7tv8kus2dUGcxFAc5eFpfP6oLxd7KRXzysjvHFp5362+osVOWb9VyL5U2pzY2qePXoK3ndD72PYXSyGaCEPkP75htFypNm5V7C8ThWhzGVt53bXNlY8BY1ABboJty26F3dzAIglzGICPN7o+VmWoXFlfMzVaMbMlfkw+TIIY/+XxR0IcEM47Rg2pHNH8LYChO+ojrWNklLEvuSNoEbIYpTOAJPvxq9L6NlVCwkZjo/bN7CJZjnyyrTChbxX/LgccmhofcKPxZAlBiKceaK8ciPP13q45UNhH4vy5gNEfSHCjutbPxRZV/03yaeUr0YHOk2Os/UClCVgQzxtx+gJd4yb0cu5uwmRa4IR+o0iRoDH0MNta5y9wFaXS0IJlgCAOEdPMI+wPVqGwIRVbnAab5onPp2OMJdlyBNmwvPpUhv1ulvuholtZFwMpYHgQ34xrCJZ3+dM3I7jDqKb07K/bWqFw==
X-Forefront-Antispam-Report: CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(46966006)(36840700001)(40470700004)(86362001)(63370400001)(7696005)(66574015)(36756003)(336012)(36860700001)(2616005)(82310400004)(70586007)(426003)(356005)(47076005)(26005)(63350400001)(6666004)(8936002)(7636003)(2906002)(8676002)(5660300002)(107886003)(1076003)(40460700003)(316002)(186003)(110136005)(4326008)(70206006)(508600001);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 21:13:39.0656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c26230-6b3f-49ab-7e6b-08d9e110b92c
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM10FT054.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0796
X-Proofpoint-ORIG-GUID: 1i4T5CkZvpbbqCipgvyV2vAgxohEmMfa
X-Proofpoint-GUID: 1i4T5CkZvpbbqCipgvyV2vAgxohEmMfa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=720
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add keycodes that are used by marine navigation devices

Signed-off-by: Shelby Heffron <Shelby.Heffron@garmin.com>
---
 include/uapi/linux/input-event-codes.h | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 225ec87d4f22..26b6a2f482ab 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -660,6 +660,34 @@
 /* Select an area of screen to be copied */
 #define KEY_SELECTIVE_SCREENSHOT	0x27a
 
+/* Toggle the focus in or out */
+#define KEY_FOCUS_TOGGLE		0x27b
+
+/* Move between highlightable items */
+#define KEY_NEXT_HIGHLIGHT		0x27c
+#define KEY_PREVIOUS_HIGHLIGHT		0x27d
+
+/* Toggle Autopilot enagement */
+#define KEY_AUTOPILOT_ENGAGE_TOGGLE	0x27e
+
+/* Navigate Displays */
+#define KEY_NEXT_DISPLAY		0x27f
+#define KEY_PREVIOUS_DISPLAY		0x280
+
+/* Shortcut Keys */
+#define KEY_MARK_WAYPOINT		0x281
+#define KEY_SOS			0x282
+#define KEY_NAV_CHART			0x283
+#define KEY_FISHING_CHART		0x284
+#define KEY_SINGLE_RANGE_RADAR		0x285
+#define KEY_DUAL_RANGE_RADAR		0x286
+#define KEY_RADAR_OVERLAY		0x287
+#define KEY_TRADITIONAL_SONAR		0x288
+#define KEY_CLEARVU_SONAR		0x289
+#define KEY_SIDEVU_SONAR		0x28a
+#define KEY_NAV_INFO			0x28b
+#define KEY_BRIGHTNESS_MENU		0x28c
+
 /*
  * Some keyboards have keys which do not have a defined meaning, these keys
  * are intended to be programmed / bound to macros by the user. For most
-- 
2.32.0

