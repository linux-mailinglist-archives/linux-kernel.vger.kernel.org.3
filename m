Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7235248AA06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349107AbiAKJAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:00:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57532 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349097AbiAKJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:00:18 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20B7PuRd017779;
        Tue, 11 Jan 2022 01:00:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Wo1OAe5HbL3bMj+IgZzAYh27i4687o7hAmEL4J3X1o4=;
 b=uMf3btqlnKV6RtRc4fz/VHjnhJYO6r0RplKtnA4005P7UTiDmQX9Ww1EBmfogU9SaU5R
 ybSgRuLVUfHx0X4sL+B1meALBPUgkTPBVFQShkfI82euCoTVz0nTnxOl3fkgrPDiBNid
 iZOVnObMwSO9rwkOa6kWDXnV5RrQ6hORUNxXdpGQ5/FcI1BrAog0RIZXnZOGV6FE3AwM
 3Xr5lxpn8PeHlhfSUPIOvnoMEN9sP6kOtK/27qSJFmCHaMwV9gJSiymK3RcrRtpsRUSl
 JRUuXQ2wOgkBDZoQZToIPqEGmuozuCd0yD+wOUR+wVSMKAh8YyoYg7tlKmnG5l88+JNP fg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3dgkxpkdd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 01:00:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km+DlYm+xiLHnY9yoL3h4rX84B6YrhT43+PQathBN8kYggD1jRLDO/dw7/Oc8swdK4VIQ+xDQ3p8oIUr+kr66L3O7zIA24+5plvLKw8kxQTpK4/cShiUZDPLBtXQetuXp1RSigAKq9Q8irhofyJAtxqT7upB1pfiMv6XXijIxI/XCbJ+11FTVO3DroWDhdJnY/uLf0LSiq2WTig0twSX2UPq7ivbLujQguacV5wOBCURitx4j+wxJbVtmxxaXgyp6U75AmPVc6ypps2fLfo1hDA2Yt8Gd7xkrKKgQXapiU9Na5lxOqRtEuGaAqESj7ezBTYFZOnPySS9/XzOR6xVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wo1OAe5HbL3bMj+IgZzAYh27i4687o7hAmEL4J3X1o4=;
 b=Izn52RPd5hItaoUiPJQ3sgRL6hNF1A6bEC29i1L16ePUvG4sue1Mq+zRtsZf6nasm+jekTC9J3yTwry+V5z+O8gsCxbkOc54hTUd8a+LUnOPmFcalttdUOQkh+eUuFADHudhf8zOnZCbloSmcYZnKvJP9RLsrlcomMDLi3nlVfnc67LjjHT6xqOMKXjs+k1I9hRUNlnbCW06uP5qmfMjOcNFGqEy6qZIHaHnFz3ptCaIYlqCt+hipnSO3zoHxhk8Sttfhw/OGt5TfPfyLeAPFx7kLQSptxWWJYnLT2Mhrf2Jn1iBq5mVMiJ5CeC5XCQ8Z3QbMlfUuOLaTQZDjjQHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wo1OAe5HbL3bMj+IgZzAYh27i4687o7hAmEL4J3X1o4=;
 b=GTsP544Eb6MsVGE6UbeFcbkzMO+m8LdjsJqRXiyf2u6tP2teas/uqbZM1nIZEHCwLN+fJYJDphZllntcRrVvIP4HCjgcKdD2l10uDQnjT4RRDVTAaOJaCPYyRbIwRmql+iZIMg2aVsFedMhxv7p7bG6V1O5sfAu0UIseprRzfag=
Received: from DM6PR14CA0046.namprd14.prod.outlook.com (2603:10b6:5:18f::23)
 by SN6PR07MB4911.namprd07.prod.outlook.com (2603:10b6:805:3c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 09:00:00 +0000
Received: from DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::92) by DM6PR14CA0046.outlook.office365.com
 (2603:10b6:5:18f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9 via Frontend
 Transport; Tue, 11 Jan 2022 09:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT040.mail.protection.outlook.com (10.13.179.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.4 via Frontend Transport; Tue, 11 Jan 2022 09:00:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 20B8xxoR075166
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 01:00:00 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 09:59:58 +0100
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 11 Jan 2022 09:59:58 +0100
Received: from gli-login.cadence.com (10.187.128.100) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 09:59:58 +0100
Received: from gli-login.cadence.com (localhost [127.0.0.1])
        by gli-login.cadence.com (8.14.4/8.14.4) with ESMTP id 20B8xwcS045498;
        Tue, 11 Jan 2022 09:59:58 +0100
Received: (from pawell@localhost)
        by gli-login.cadence.com (8.14.4/8.14.4/Submit) id 20B8xv0M045497;
        Tue, 11 Jan 2022 09:59:57 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: remove not used variables
Date:   Tue, 11 Jan 2022 09:59:34 +0100
Message-ID: <20220111085934.44844-1-pawell@gli-login.cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac4a75b-fd19-4781-045a-08d9d4e0bf96
X-MS-TrafficTypeDiagnostic: SN6PR07MB4911:EE_
X-Microsoft-Antispam-PRVS: <SN6PR07MB4911994168C5312F115594C0DD519@SN6PR07MB4911.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:132;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EX99mKS9lR5X332m9J+baMTA+sYTKfxJhZMUcVaZKnnjR5chCgByngYHqbPz5S/LpPIZ+vsEUvA0glJb2qzL2rpKOuVT3Q/OX73CCMjBKpZy04L6pbunImls7tmsG+TxLresJp6tInrfJErra99IaqFZA7HclF4TJT3wAquvfSCFGytuY/UUe2Eyby9MrCQDUWG8qsJBqt0wrZbiKJyWCetxtf7Qja7QMQClxh+0qKrX+ywEaN4zCY0671GWJ+vPm9wRjOo7A2CkIkRvwUzjGDENLEnOAlEYmF8EuIs97y6fu1It1CQiK+lANxJrv8YqgP/NAJxZ+JXcgzUgtLIii3Qlwkm4RX/UVqvkKgsf6rHC9PbZpMgn8ilzwJ2XCW9W6+HCyr7PoLrt6JvYq4EzyYtsUxbnLvOv4SICyPeP/DfFeAH68PP3fagHlwOhGNT3kbyJx+HLMkkdgBYr83ZHm1pGZrkc2fYn2eRsKAe+VqpkfToL/6DRsLT6BQcSFgIbeyp4MG29zDhmeyDCknM4u/NvRF1BmwH67GnpEm85c5MP/wJIEQYk3oxknTqp6lwdfJyCCmHr8cIzM9Whw7vauE9ZivZoJedbHoA+0Q70zBD+58lMPbZFsF+MWVmGCmu+zHnnEenCl50Ioe3XryGLJ5Rvuy1ek/53v4FKJ+RRmt/wmhG9qtJ1xcSE3Bd7rrCXkugAO78olI7n0Skvz985CLNUUcX12Mg//G2ZgRjxJVJf+PaPDYz//6bldpX8V11vQMM2ZmzP0KN0agGKBykQ/6IyyYZD52tB1LlRZKCGn/gVk10DTAW327UsFznXnMDWogWc4CeY2j59xWuMn4S9zg==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(40470700002)(36840700001)(70586007)(70206006)(30864003)(4326008)(81166007)(5660300002)(508600001)(336012)(107886003)(426003)(83380400001)(356005)(186003)(54906003)(2906002)(82310400004)(86362001)(42186006)(6916009)(316002)(47076005)(6666004)(36860700001)(1076003)(8676002)(40460700001)(8936002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:00:00.0740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac4a75b-fd19-4781-045a-08d9d4e0bf96
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4911
X-Proofpoint-GUID: P0Q-9CIoTjr3z994i_7XWvpwgOSUoF-L
X-Proofpoint-ORIG-GUID: P0Q-9CIoTjr3z994i_7XWvpwgOSUoF-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_03,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=990 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

Patch removes not used variables:
 - ret from cdnsp_decode_trb function
 - temp_64 from cdnsp_run function

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdnsp-debug.h  | 287 +++++++++++++++----------------
 drivers/usb/cdns3/cdnsp-gadget.c |   3 -
 2 files changed, 138 insertions(+), 152 deletions(-)

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index a8776df2d4e0..29f3cf7ddbaa 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -182,206 +182,195 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 	int ep_id = TRB_TO_EP_INDEX(field3) - 1;
 	int type = TRB_FIELD_TO_TYPE(field3);
 	unsigned int ep_num;
-	int ret = 0;
 	u32 temp;
 
 	ep_num = DIV_ROUND_UP(ep_id, 2);
 
 	switch (type) {
 	case TRB_LINK:
-		ret += snprintf(str, size,
-				"LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
-				field1, field0, GET_INTR_TARGET(field2),
-				cdnsp_trb_type_string(type),
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_TC ? 'T' : 't',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size,
+			 "LINK %08x%08x intr %ld type '%s' flags %c:%c:%c:%c",
+			 field1, field0, GET_INTR_TARGET(field2),
+			 cdnsp_trb_type_string(type),
+			 field3 & TRB_IOC ? 'I' : 'i',
+			 field3 & TRB_CHAIN ? 'C' : 'c',
+			 field3 & TRB_TC ? 'T' : 't',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_TRANSFER:
 	case TRB_COMPLETION:
 	case TRB_PORT_STATUS:
 	case TRB_HC_EVENT:
-		ret += snprintf(str, size,
-				"ep%d%s(%d) type '%s' TRB %08x%08x status '%s'"
-				" len %ld slot %ld flags %c:%c",
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3),
-				cdnsp_trb_type_string(type), field1, field0,
-				cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
-				EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
-				field3 & EVENT_DATA ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "ep%d%s(%d) type '%s' TRB %08x%08x"
+			 " status '%s' len %ld slot %ld flags %c:%c",
+			 ep_num, ep_id % 2 ? "out" : "in",
+			 TRB_TO_EP_INDEX(field3),
+			 cdnsp_trb_type_string(type), field1, field0,
+			 cdnsp_trb_comp_code_string(GET_COMP_CODE(field2)),
+			 EVENT_TRB_LEN(field2), TRB_TO_SLOT_ID(field3),
+			 field3 & EVENT_DATA ? 'E' : 'e',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_MFINDEX_WRAP:
-		ret += snprintf(str, size, "%s: flags %c",
-				cdnsp_trb_type_string(type),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: flags %c",
+			 cdnsp_trb_type_string(type),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SETUP:
-		ret += snprintf(str, size,
-				"type '%s' bRequestType %02x bRequest %02x "
-				"wValue %02x%02x wIndex %02x%02x wLength %d "
-				"length %ld TD size %ld intr %ld Setup ID %ld "
-				"flags %c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field0 & 0xff,
-				(field0 & 0xff00) >> 8,
-				(field0 & 0xff000000) >> 24,
-				(field0 & 0xff0000) >> 16,
-				(field1 & 0xff00) >> 8,
-				field1 & 0xff,
-				(field1 & 0xff000000) >> 16 |
-				(field1 & 0xff0000) >> 16,
-				TRB_LEN(field2), GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				TRB_SETUPID_TO_TYPE(field3),
-				field3 & TRB_IDT ? 'D' : 'd',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "type '%s' bRequestType %02x "
+			 "bRequest %02x wValue %02x%02x wIndex %02x%02x "
+			 "wLength %d length %ld TD size %ld intr %ld "
+			 "Setup ID %ld flags %c:%c:%c",
+			 cdnsp_trb_type_string(type),
+			 field0 & 0xff,
+			 (field0 & 0xff00) >> 8,
+			 (field0 & 0xff000000) >> 24,
+			 (field0 & 0xff0000) >> 16,
+			 (field1 & 0xff00) >> 8,
+			 field1 & 0xff,
+			 (field1 & 0xff000000) >> 16 |
+			 (field1 & 0xff0000) >> 16,
+			 TRB_LEN(field2), GET_TD_SIZE(field2),
+			 GET_INTR_TARGET(field2),
+			 TRB_SETUPID_TO_TYPE(field3),
+			 field3 & TRB_IDT ? 'D' : 'd',
+			 field3 & TRB_IOC ? 'I' : 'i',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DATA:
-		ret += snprintf(str, size,
-				"type '%s' Buffer %08x%08x length %ld TD size %ld "
-				"intr %ld flags %c:%c:%c:%c:%c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				field3 & TRB_IDT ? 'D' : 'i',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_NO_SNOOP ? 'S' : 's',
-				field3 & TRB_ISP ? 'I' : 'i',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "type '%s' Buffer %08x%08x length %ld "
+			 "TD size %ld intr %ld flags %c:%c:%c:%c:%c:%c:%c",
+			 cdnsp_trb_type_string(type),
+			 field1, field0, TRB_LEN(field2),
+			 GET_TD_SIZE(field2),
+			 GET_INTR_TARGET(field2),
+			 field3 & TRB_IDT ? 'D' : 'i',
+			 field3 & TRB_IOC ? 'I' : 'i',
+			 field3 & TRB_CHAIN ? 'C' : 'c',
+			 field3 & TRB_NO_SNOOP ? 'S' : 's',
+			 field3 & TRB_ISP ? 'I' : 'i',
+			 field3 & TRB_ENT ? 'E' : 'e',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STATUS:
-		ret += snprintf(str, size,
-				"Buffer %08x%08x length %ld TD size %ld intr"
-				"%ld type '%s' flags %c:%c:%c:%c",
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				cdnsp_trb_type_string(type),
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "Buffer %08x%08x length %ld TD size %ld"
+			 " intr %ld type '%s' flags %c:%c:%c:%c",
+			 field1, field0, TRB_LEN(field2),
+			 GET_TD_SIZE(field2),
+			 GET_INTR_TARGET(field2),
+			 cdnsp_trb_type_string(type),
+			 field3 & TRB_IOC ? 'I' : 'i',
+			 field3 & TRB_CHAIN ? 'C' : 'c',
+			 field3 & TRB_ENT ? 'E' : 'e',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_NORMAL:
 	case TRB_ISOC:
 	case TRB_EVENT_DATA:
 	case TRB_TR_NOOP:
-		ret += snprintf(str, size,
-				"type '%s' Buffer %08x%08x length %ld "
-				"TD size %ld intr %ld "
-				"flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
-				cdnsp_trb_type_string(type),
-				field1, field0, TRB_LEN(field2),
-				GET_TD_SIZE(field2),
-				GET_INTR_TARGET(field2),
-				field3 & TRB_BEI ? 'B' : 'b',
-				field3 & TRB_IDT ? 'T' : 't',
-				field3 & TRB_IOC ? 'I' : 'i',
-				field3 & TRB_CHAIN ? 'C' : 'c',
-				field3 & TRB_NO_SNOOP ? 'S' : 's',
-				field3 & TRB_ISP ? 'I' : 'i',
-				field3 & TRB_ENT ? 'E' : 'e',
-				field3 & TRB_CYCLE ? 'C' : 'c',
-				!(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
+		snprintf(str, size, "type '%s' Buffer %08x%08x length %ld "
+			 "TD size %ld intr %ld "
+			 "flags %c:%c:%c:%c:%c:%c:%c:%c:%c",
+			 cdnsp_trb_type_string(type),
+			 field1, field0, TRB_LEN(field2),
+			 GET_TD_SIZE(field2),
+			 GET_INTR_TARGET(field2),
+			 field3 & TRB_BEI ? 'B' : 'b',
+			 field3 & TRB_IDT ? 'T' : 't',
+			 field3 & TRB_IOC ? 'I' : 'i',
+			 field3 & TRB_CHAIN ? 'C' : 'c',
+			 field3 & TRB_NO_SNOOP ? 'S' : 's',
+			 field3 & TRB_ISP ? 'I' : 'i',
+			 field3 & TRB_ENT ? 'E' : 'e',
+			 field3 & TRB_CYCLE ? 'C' : 'c',
+			 !(field3 & TRB_EVENT_INVALIDATE) ? 'V' : 'v');
 		break;
 	case TRB_CMD_NOOP:
 	case TRB_ENABLE_SLOT:
-		ret += snprintf(str, size, "%s: flags %c",
-				cdnsp_trb_type_string(type),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: flags %c",
+			 cdnsp_trb_type_string(type),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_DISABLE_SLOT:
-		ret += snprintf(str, size, "%s: slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: slot %ld flags %c",
+			 cdnsp_trb_type_string(type),
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ADDR_DEV:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c:%c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_BSR ? 'B' : 'b',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c:%c",
+			 cdnsp_trb_type_string(type), field1, field0,
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_BSR ? 'B' : 'b',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_CONFIG_EP:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c:%c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_DC ? 'D' : 'd',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c:%c",
+			 cdnsp_trb_type_string(type), field1, field0,
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_DC ? 'D' : 'd',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_EVAL_CONTEXT:
-		ret += snprintf(str, size,
-				"%s: ctx %08x%08x slot %ld flags %c",
-				cdnsp_trb_type_string(type), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: ctx %08x%08x slot %ld flags %c",
+			 cdnsp_trb_type_string(type), field1, field0,
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 	case TRB_FLUSH_ENDPOINT:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), field1, field0,
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size,
+			 "%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+			 cdnsp_trb_type_string(type),
+			 ep_num, ep_id % 2 ? "out" : "in",
+			 TRB_TO_EP_INDEX(field3), field1, field0,
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_STOP_RING:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) slot %ld sp %d flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3),
-				TRB_TO_SLOT_ID(field3),
-				TRB_TO_SUSPEND_PORT(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: ep%d%s(%d) slot %ld sp %d flags %c",
+			 cdnsp_trb_type_string(type),
+			 ep_num, ep_id % 2 ? "out" : "in",
+			 TRB_TO_EP_INDEX(field3),
+			 TRB_TO_SLOT_ID(field3),
+			 TRB_TO_SUSPEND_PORT(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_SET_DEQ:
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) deq %08x%08x stream %ld slot %ld  flags %c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), field1, field0,
-				TRB_TO_STREAM_ID(field2),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: ep%d%s(%d) deq %08x%08x stream %ld"
+			 " slot %ld  flags %c",
+			 cdnsp_trb_type_string(type),
+			 ep_num, ep_id % 2 ? "out" : "in",
+			 TRB_TO_EP_INDEX(field3), field1, field0,
+			 TRB_TO_STREAM_ID(field2),
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_RESET_DEV:
-		ret += snprintf(str, size, "%s: slot %ld flags %c",
-				cdnsp_trb_type_string(type),
-				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size, "%s: slot %ld flags %c",
+			 cdnsp_trb_type_string(type),
+			 TRB_TO_SLOT_ID(field3),
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	case TRB_ENDPOINT_NRDY:
 		temp  = TRB_TO_HOST_STREAM(field2);
 
-		ret += snprintf(str, size,
-				"%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
-				cdnsp_trb_type_string(type),
-				ep_num, ep_id % 2 ? "out" : "in",
-				TRB_TO_EP_INDEX(field3), temp,
-				temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
-				temp == STREAM_REJECTED ? "(REJECTED)" : "",
-				TRB_TO_DEV_STREAM(field0),
-				field3 & TRB_STAT ? 'S' : 's',
-				field3 & TRB_CYCLE ? 'C' : 'c');
+		snprintf(str, size,
+			 "%s: ep%d%s(%d) H_SID %x%s%s D_SID %lx flags %c:%c",
+			 cdnsp_trb_type_string(type),
+			 ep_num, ep_id % 2 ? "out" : "in",
+			 TRB_TO_EP_INDEX(field3), temp,
+			 temp == STREAM_PRIME_ACK ? "(PRIME)" : "",
+			 temp == STREAM_REJECTED ? "(REJECTED)" : "",
+			 TRB_TO_DEV_STREAM(field0),
+			 field3 & TRB_STAT ? 'S' : 's',
+			 field3 & TRB_CYCLE ? 'C' : 'c');
 		break;
 	default:
-		ret += snprintf(str, size,
-				"type '%s' -> raw %08x %08x %08x %08x",
-				cdnsp_trb_type_string(type),
-				field0, field1, field2, field3);
+		snprintf(str, size, "type '%s' -> raw %08x %08x %08x %08x",
+			 cdnsp_trb_type_string(type),
+			 field0, field1, field2, field3);
 	}
 
 	return str;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 27df0c697897..ec8a0dc792bc 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1243,12 +1243,9 @@ static int cdnsp_run(struct cdnsp_device *pdev,
 		     enum usb_device_speed speed)
 {
 	u32 fs_speed = 0;
-	u64 temp_64;
 	u32 temp;
 	int ret;
 
-	temp_64 = cdnsp_read_64(&pdev->ir_set->erst_dequeue);
-	temp_64 &= ~ERST_PTR_MASK;
 	temp = readl(&pdev->ir_set->irq_control);
 	temp &= ~IMOD_INTERVAL_MASK;
 	temp |= ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
-- 
2.25.1

