Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FB153B9A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbiFBN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiFBN0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:26:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC21A28CE84;
        Thu,  2 Jun 2022 06:25:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPzyCXlM3BmiaQupQ2UEy7KdQzQKZAJKkYByqx/J6NzXZV9cnbFG+N1MvNhCLU30pSZqvzSMngNthiRBncbYRb9wxWnDuaL9bmx73fBZM1rUdJ4wZq1VkF+njdacegTnyP7NDmaB75sssrW14zOYZhEBXN/5MKjMW5pHd2mA3D6Ci34nKNToiacuyEBB8I3VMki7iS+xhg0s8iew7ST53GT+jb9DbZJIEZeiQkvvGWBCgHSPnZakLp+Sa2qcOhSM4HjKg2u+6ETnKu6Q/k2n0o2YzlTq0lWCMbW8PwBITjBPtIFH/UTxS5qHLyDuEa4VEYTgVs9wZv7jaQr6eahapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0yn7LcnAQenuZbXMMkAlVyheQfRtZkhhxqtiUKf0Bk=;
 b=SsMPNVMIUhOaEC0W4H78lWvaVc78Pt5l26qHKMCJEdXKnTG5REFOFzmUBVUwCFQcL0vpmwlj8hjQqXthR4Lof46VkAWhAdKWAGKUbmq/eyATxrStODvBOKHi6DI5rSRGnNcbKRDPiAkwFsSxUEEMZQ9kzaKfzDO4NplGmUi9ye1lrRmLhzRBP6HOxxB44OIstozY/Yy9v+3JhXTAcSf3VP80eYeM+WpaR1ifcbssJVtYkq8+G7a+w2EZfLF2rvOYhxjWydlxuskeH30A/zzZfr/sOJ4ScDw0mYS5z544YlShJmy4+Zg6R0R+h0vqEoA3ZtYh6eUeXUhv5f9ftr9psQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0yn7LcnAQenuZbXMMkAlVyheQfRtZkhhxqtiUKf0Bk=;
 b=DTD0rPAgvelDDM9bb9sLxvARuA3aVPqhDbtzcQC1JLwyKnC10q+rVdcOuUQkjQOKH0XnPysdCf8uSbtpmH2Y94ReQ4XPeLm0ZYSM88n5YUI2Nx3/POaADaL1J6zqHkU3vdzVAmhniWskB7FOctIwwtdg0qbRYBls03yKnJnhnw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
Received: from PH0PR16MB4248.namprd16.prod.outlook.com (2603:10b6:510:4c::16)
 by BLAPR16MB3681.namprd16.prod.outlook.com (2603:10b6:208:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 2 Jun
 2022 13:25:56 +0000
Received: from PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e0e1:6026:e3dc:5425]) by PH0PR16MB4248.namprd16.prod.outlook.com
 ([fe80::e0e1:6026:e3dc:5425%7]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 13:25:56 +0000
From:   Chevron Li <chevron.li@bayhubtech.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shaper.liu@bayhubtech.com, chevron.li@bayhubtech.com,
        xiaoguang.yu@bayhubtech.com, shirley.her@bayhubtech.com,
        fred.ai@bayhubtech.com
Subject: [PATCH V1 1/1] mmc:sdhci-pci-o2micro:fix card detect issue because card detect debouncing isn't done
Date:   Thu,  2 Jun 2022 06:25:43 -0700
Message-Id: <20220602132543.596-1-chevron.li@bayhubtech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0201.apcprd02.prod.outlook.com
 (2603:1096:201:20::13) To PH0PR16MB4248.namprd16.prod.outlook.com
 (2603:10b6:510:4c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23cccf78-a567-4dd1-b92e-08da449b6c91
X-MS-TrafficTypeDiagnostic: BLAPR16MB3681:EE_
X-Microsoft-Antispam-PRVS: <BLAPR16MB3681A30A5F6AE827556412AFEADE9@BLAPR16MB3681.namprd16.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fBmVCWxqwi/dD6hVDTgEdXJ9RJzIDGL7uaKalZA3Df5aaXXWxuo0Wcpd6uo12Y3mvjkcvn3om/SpkZJiJ/MLdvL7DKyzWP/9pVCAr/7FjGd9EzrD4/FGiGMJJxFZdvFieP/WxNAojwtInOXAK8xCudlkyqiQwCZs2GBmPylPFIYqKOZ8lrDXkGc5K8fbweS8pRT9lF2No/nkaPhEWks2vMLr+6h1nsnfHXvI/+EvTT9tN/DkwLQENHvcEGdirz3EVd7oAsq0wJZJ2DW23IiweTy71VR/y/f5IyKRUiBciRtcDKK1CyDeIYqknS4Nu/GUGCGU8hT/doj9wCT9/SMuO4a6wtlYK3rCqo6/VhyjrkNugwpDJiuYWVDFCNQkJnzIj5FG4PVR/zwvU96D3a6YpUAjIRrIcNPOm/qxueeL1ROh1V5UrZzgPy+wHwxRbNiiGPTPBx1ky2r6Vh8pEDaqtPMwhShU6Tdi4NFDyxx9v/4nSIOKKc1OA+d3Wb0d4gDnoFvGuUiVWFLbhkCfAiotE4hvDeZa+wt92jjpnhD13gtj8S+3TnrbeUUJSVMTSRdATxK4zW3GBn5Hy+aSA5JzchPjo6PpqsmlIYpCBnvX8vSWViRqUPy9YSYBhIvK4+NoOne8NxHdIA2NKoq/fDskCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR16MB4248.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(136003)(376002)(39830400003)(346002)(366004)(66946007)(66556008)(38100700002)(52116002)(36756003)(4326008)(6506007)(6666004)(8676002)(316002)(86362001)(6512007)(66476007)(8936002)(186003)(41300700001)(1076003)(107886003)(2616005)(508600001)(5660300002)(2906002)(4744005)(44832011)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7w3HvXes87AFUlCA9IeZBpEsgkVRH2jO5atFd8LHHXfYxg/lpueXBQhGHtc?=
 =?us-ascii?Q?fGxJNEGPsiRl6pnOVDA1xGDniUZhoE8Wz8xqDFFGaVgwwylyQpz6UD+wnckS?=
 =?us-ascii?Q?hi9tCqwymxwMkVdHfvGztq/4Bq1jgSQo0eDxQdbnkKmMq+aLwHsq9WraeAe4?=
 =?us-ascii?Q?wEB5As/gjfgbIu6aVK3jBVL/9Xqf/hLkjmMa7ThgozUOJmd4ssf7bHuMkI/Y?=
 =?us-ascii?Q?J9JvXZosw/ZWmhzCwopvk4d7T6WbygvAVY9EYjuv0TgIFaxkuqAt+w/gDQ1A?=
 =?us-ascii?Q?O2XSj4vVCBDsVZJYgAISV1vsGxRjirKuocdRdO45o2eGNEKL/m4+p+eZyG50?=
 =?us-ascii?Q?KMhjlIdpM0OcB0OEBRHowRyk4zRI6KP6knSnA3wqKAfbbjxOmpeJ3WRazXi9?=
 =?us-ascii?Q?wlD70N+CeYYlsfAnHSNA5N3r8+thmF3IkixTSgjpG5A+6m5ueYr8xyovHH5w?=
 =?us-ascii?Q?ZDRrpbShiHpZuXas9ynyILzyCyEtLvUaLFiZ/OYzeJaPrunf+QUgoRg/Ly2F?=
 =?us-ascii?Q?bluGmb9HaFbaOh2N7yKoJcibjTYvKFjc3VpeOSlsXMk8UgJJkjuNlWTU5IJ3?=
 =?us-ascii?Q?G1RySArOgj1XKem/Y0I8z6vPcg+ws4H+jJKZw86y0VloCSyCyrGlRGiLA76C?=
 =?us-ascii?Q?BQo02kE7WzK2t4l8Yv6d/0upYeXElJtX2TqKEnXbFIVGWE8cLsFQPGKEgTAP?=
 =?us-ascii?Q?frBrn5+ROuidAFyy6uF8tcy/kZIJBnbsEWtvzcaO2kxFqDpW1WBTVUTaX7Jb?=
 =?us-ascii?Q?iXjxLzwUhHKFAjDysvB8MvKJB37HTcZjbkk4jathSx57z78HfMqcp+XzDncc?=
 =?us-ascii?Q?M7kyMP2t1RuUINtM60M87ZAvrAqm0+2bibjPY6t++NttH7RE8eeT0w+htPHI?=
 =?us-ascii?Q?oh3fQ7DXRgFQ7gG8XiBeZ8EQ26sO4MQneQRwcNvOsQq7gkPcqqCs94hzK2s4?=
 =?us-ascii?Q?QZZKSwaZPi9oUtNPtP8meX8WBRDEHz++9sTATMnC4cDdtl0+LbXELmFuNOI0?=
 =?us-ascii?Q?DiFIqHRA15siWkkx7OhgXkM3hdyTaAPJX4l4HEn6R+3w1XA2e90jho0W+K97?=
 =?us-ascii?Q?DY1ImBu/5j+1MRl5gj8lrfvtgI+zPYwPabMVeiK3etFwfSWIp17K5F8GFUST?=
 =?us-ascii?Q?5/ObEZlMvY6jyziWzWFPz4NMfgl4m/h5jvPJPKecHyD2EHfiKA5bpu/85ji2?=
 =?us-ascii?Q?X+2faya5sPRx47fhuZTHSdYX/dQMRIToswrA3QNdAfbHQwKhsNqOX3sNGDZG?=
 =?us-ascii?Q?/F2RgLucNUY4q5ukxDiSijsZJJsk9nWc9ak6K2sz9BQnPHnW+JU13Az7t7UH?=
 =?us-ascii?Q?VSYv0VGUWUwQMmu+VOS9UHJ1OeGhQWvRmlC+IztnWzFRa2ht3n/psXeh1LKV?=
 =?us-ascii?Q?zHZC3br/l8nYoWWv0v/mg37dPrrMDpDcU1jv0YSS3AyLotRhdenxewuC1NMY?=
 =?us-ascii?Q?4YQgNuBmeowUSQ78+hY1SHI4lNo8ijMn3ZDPJpoPIYD/Xcn/cDOhnjmx+7FU?=
 =?us-ascii?Q?5g+6eQjDxarj/ciWgUUBpDNX+tCPL0cEKXz5smPuiNNeba0j+GZAiFLb8nQi?=
 =?us-ascii?Q?gaAMm4V40aR9Un8WLLKp8NitSqQFerKnysGc3I1kAFepbeB4QeTr1F+zA6qc?=
 =?us-ascii?Q?8k2SpL3pvqqlI+W8FUGH5ZIpr64Xnheme0QUF3aV1sy4zOigzxACSEgBk6dD?=
 =?us-ascii?Q?QbGB/G4D8qGss1EW+zZ/aTeSmjXqQm0Bnki1iOaAXXFkY8fc/ZgUzuTOOUgj?=
 =?us-ascii?Q?EeL0mqZen56sYIJk5s6lUvWGcxlGV/teur2FDxlAxelC50En2HltIWSQEvCC?=
X-MS-Exchange-AntiSpam-MessageData-1: 8hjg61+eX3tFvwVsbOLTtwt0yvQ9kEmBlVzryayYC7SeOWp6mbhY0kJq
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cccf78-a567-4dd1-b92e-08da449b6c91
X-MS-Exchange-CrossTenant-AuthSource: PH0PR16MB4248.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 13:25:56.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2trXap54wGcwaeI5pS5lHhy12poU8aIJj+P+rdd/2R7yQO/y81o1t+sjVj2gYCe1ktIHXsky8+1gx2aHSBd8nhJUYG+5v41RzOOXh3W5qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3681
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_cd result is uncorrect during card detect debouncing
we need to wait card detect stable before return get_cd result

Signed-off-by: Chevron Li<chevron.li@bayhubtech.com>
---
change in V1:
add wait card detect stable logical before return card detect result.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 92c20cb8074a..0d4d343dbb77 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -152,6 +152,8 @@ static int sdhci_o2_get_cd(struct mmc_host *mmc)
 
 	if (!(sdhci_readw(host, O2_PLL_DLL_WDT_CONTROL1) & O2_PLL_LOCK_STATUS))
 		sdhci_o2_enable_internal_clock(host);
+	else
+		sdhci_o2_wait_card_detect_stable(host);
 
 	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
 }

base-commit: d1dc87763f406d4e67caf16dbe438a5647692395
-- 
2.32.0

