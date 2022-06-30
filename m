Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82545621FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiF3S2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiF3S23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:28:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66F13F81
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:28:27 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHlT6G010777;
        Thu, 30 Jun 2022 18:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ciOpVkCf9Y0uc/7oOFyxAB++oj/xxCe1lmJhmKfwsis=;
 b=KWASNhhXHF97BEtRfLJFpCLlQ9bwGsSLOzo9K3myrVBZUyr/m4nPwg76FD8Z6uTGJbx6
 od+HljYVI2x2RH4YM4VaOC6HQyVXxYoOgZ1MsKwjvYRPSKk+3jJrkdQ0av7Dt7K1+k0O
 rmrATutq2rZ/qW/pahLPhqhVPwjiGUR5WDix8XsSPYUuggvnMd19u+7KWwse/KEPzL4G
 qLQv5M8jbmcx5mB1W/68BlSQAnQrMAf0t76vrBtRejjcaL7RbwaIx5merphU2g9nC7Nw
 ubpT4Uld7ICC7S8cTiP0q28UhFaiVlBEzcX6JNLLVnlHptA4caRr0lTwKbGfAfqrpH9h PA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscmxb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:28:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UI51oC040863;
        Thu, 30 Jun 2022 18:28:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4q9ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jun 2022 18:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhXzR/f5AH1e5a4A4VlLqhV7Ed1SUZ43h0V98rHWFWuSMxytipipIEewBhxyEJMO23l1k1njJ+ag7bh7k94tadSqZvuTd8Nzt5s1ZqdU0U6biXjF7V/PCmCVmCrOR3e9sBIpEFCm4MyRHeI6JPuXfEGlArq6CbXmsr8YPbMIAH7xvGcHSXrCEKs5xnsrpE9XYfxQITNOdolbHSy+vdwiCwd4TS7DmQFqZEyinshSNInSozMzVw8Eip8xdeP4rOw+3jEFe6TuLhLUgM20rXOqlsbkr7Ru9DLsriVoeCtCuKZ+03GxmDaF6Z0k9J/VjzNbJAxuXUNSTDK5lRAtpjDQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciOpVkCf9Y0uc/7oOFyxAB++oj/xxCe1lmJhmKfwsis=;
 b=n4x+P/iwcOcBCnonUXUJiuvffsWAF2h27g4o+ECP46z4nCI5AnXeVwZW3k6tFO/GGM5T132b1/zOM+u9BM7Xy1lIvq8dgBi26l+0Mkt/bwzkKmotPeeNC+V/EDQkZjWHhO0aM3nWMww9KD9axBTZIXlWbsyxe7rJzszskBqbOFszHOFmFhh0eaxQmncfjIGm+b28dsV773smcHBMFZNnl72Y8PGw3B1myE1S/kNqVXW2rui/bmsWrIZ+olS5ajk4Thw6Ov1LiYclgtHCPBS0F8zf1RtE+wXz9CN547ppya8iLmAisLcFZtvA/UtS+rch59fwNUUbaZ8ILcQw+VkxXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciOpVkCf9Y0uc/7oOFyxAB++oj/xxCe1lmJhmKfwsis=;
 b=nCEPk6bE6Y3P5u5M4gngjBC14z6KJt+z7+qWbttbGP5gyGXejF2nlc0S1s4MDMLlF22/S8fhhlM6k6Ds37WQkCyk5TK+N54KMw84JkeZrOTHtf8pNB3QUmcdVHw/O3GWM/aSRI0i0v8PEz5synSpKaVFw0ldgwRe/MyPEXnxDPA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 18:28:18 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::20c4:5b7f:ce53:eb20%9]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 18:28:18 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org, hch@lst.de,
        nvdimm@lists.linux.dev
Subject: [PATCH v2] pmem: fix a name collision
Date:   Thu, 30 Jun 2022 12:28:02 -0600
Message-Id: <20220630182802.3250449-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0115.namprd07.prod.outlook.com
 (2603:10b6:5:330::6) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e0f453-496e-4a19-4915-08da5ac64ded
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBYKhDMNQb2DhLYHs5w/nN23v9TORxCb7zXWSrZf0wtYRpYqjstwenqeHSpR3qXDscyFvB3Y2Qi9e1jdk3ehtY88drzqmWexaPWeU6Dls7l7VIJzJ3Il/KNS5vo3tSSFcnWva+Ya3GNk24H834QtVqvkIbMeVNu/PpIm0HnIFbxGr95veL5cj0GJPI0CPJPtYF9i3TxO8Fm1YBJe0cUAPvVVIOSoWGVyILwA+A79bAliOu8FMmEX6hRkM52IDWR+uzi8k9iSJqRyjCaJ4dQogmO1EMOOC7V2HS5u747yrazTPrHSfYd6FYFNP2zbsrAQ1/lgT/P0xkJk3EiYrLhwTKoS/Cq8Ker4lbgqgHmSNPJPBuvyWeSTJNR3uhtX82R72k9OHmAF3M5P1/r6VPOaQQP9amqfDyFzVwPVxFVfJXy86IZyTNS5vl6BSwL4ulgdNwMBmXCicDD5z2WJ0rG4iyU/l6oGqE04B/kDCa6hjAmRLwQw5aFavPLCYFHPm7xa4fotuhwrUuRL3oKaidy7rDFT36dH/51bvDB6HZ24ZOzGgIhEHNomj7ZDNHKW9g65y8Kh71Z98k3M91v4rUOOOAwgxr0jmCiVgMnOifzxYhNMgFPdqdPULySzEPh/CjKhWNwLvKSrTLDx6CKLCAFxep9JFlMIzQw/Vy8OZRPsWG+42Ssgp16MEJGoa4I9IlPciqF7PI/eD65URpzseP5o+OhyNHj/pPg6Exa/X9TSfHJFV/gdczJDVc/h0nvVnE/3DyyPkmOo+Sm/JmpkvJ7VDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(346002)(136003)(366004)(396003)(1076003)(2616005)(186003)(8676002)(8936002)(38100700002)(66946007)(66476007)(66556008)(83380400001)(316002)(6486002)(36756003)(478600001)(86362001)(52116002)(6512007)(6506007)(44832011)(6666004)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RcXkE6JjO/uVi2JdK4EdUSKMrIp3J5YWzOPbWSoN6K0gE/tCqaptIGpBfmXm?=
 =?us-ascii?Q?TzuTYbSSv+EUHUOmDrMc/oOBayORReiXx0LRwZMGNKsP46cockrNunOj8ynG?=
 =?us-ascii?Q?z72akJhFnTX/0vds3IqYMZoao7ZuQ+zrv+USA/d65mvLdcPhClhzUyO7ZiKA?=
 =?us-ascii?Q?6WOSeOzBaCuAfeZABki6FJtnHwxxpypEHZZCtOrbqtVNT16G2bTd+ToZmTh2?=
 =?us-ascii?Q?WaL5laZvakgX75Hj60hkWTwo+NMZ9hwKzIpJ/xXQgsctdtChXyz9jpk8Z8Fy?=
 =?us-ascii?Q?hyFROl7ZBr/PWtED1igaRKXRmH3MfGsEY5KfRbhk2oBrVJ76+gEMy/9zBaod?=
 =?us-ascii?Q?tQS593gP33sW7fEzV+bF9zEub+QUwNrKnwFLxw6+jmOrAtya7WxyvlZZ3+eH?=
 =?us-ascii?Q?UPp8CJG4SEZWvZoiHP1YNYaE4lZNbRJzcOaWerQpFuEIu5GHMZ5luvKrQhWz?=
 =?us-ascii?Q?agyyS7jMRyPHs0K5LuUspesrXyGTlw1c1aMwSMUsHsdF75BhTjBamBawXwRh?=
 =?us-ascii?Q?FSP2gUsjwHhRhUsZ63X8rql9r89dtxbp5AJ5x4VtDvhYnr7T7ajzdQnm2MQu?=
 =?us-ascii?Q?JnLK1lJWcMWuPUMsU1kqJPF+88Ghdc2RqVphqc+Eb4Kefo02HMIxeD6qRUl3?=
 =?us-ascii?Q?dkEaTSauWUcfsvXbKXBhzvdFCtrdFcLFdCGkx9i2nO0MYFvxZHLH5UTyxaw3?=
 =?us-ascii?Q?7rL16zKglOUUmLZGXnJ65XAIbsKsPWqkFrmbKE0Sgr5iTCk/RjxH48ss1qtH?=
 =?us-ascii?Q?5sKwZLY2trcaLqG6WIFcpQMZpKWTmO44tHYpWe++BRzXBnl1xxbsB7m4fIfP?=
 =?us-ascii?Q?XOVTi0FMb1uOJHeDRqx3o9gHmJFO1MERNZQ+H8QloVrvzRdG+mgx/zHeMY7Q?=
 =?us-ascii?Q?RchlcUkydf7haGIfDvtm8x+aTFtFiQkniDxhxTaUyDr3Ev1LaAieyJY36sqO?=
 =?us-ascii?Q?ZdGL4ZvrIUuZDYqsQKi18B1TAxXUhC4s70vObnP40E2A5DBXmfKAYh86kHaz?=
 =?us-ascii?Q?80EmvIUne/643X22F4p4OUARyy3PFByEYX90LJmSlshW+EpwYjjnHhROQb2E?=
 =?us-ascii?Q?7USLEPXbs0FlZjD56t4PFzKNW7dAd4veicgQIa7CgAtm8UOzz/kUiHZebxov?=
 =?us-ascii?Q?PpykPZGL57+Zvzc2R7JvQjMMRud67FOGNW5iIDsoq+KhhGMLWsek+gZ857eA?=
 =?us-ascii?Q?FnS2M1PdEoxsbE67EZUc7qF7fd2uCDUd/H5EUYM7l/PXdLDziUh8JQ/2fQh8?=
 =?us-ascii?Q?YRBRH2vk/vW87r+0EcIlYeVrdl5NZw8MdJgMA5cq+S6mEgiMwXl4hOH3kE8Z?=
 =?us-ascii?Q?/np8rj4pT23fpRf5iAvyXLfqstsQtg2NaT70HXXJsNqc8hESUouer+AoPtZ4?=
 =?us-ascii?Q?jUjyCGfiLoRgFFh2k7tysFLjTAmv0ftvxA09s7isZFHWQuLkXTNPjz3j7ZH7?=
 =?us-ascii?Q?EaW3gk0FosKtfkqKkAlWiiFnWOXXj8jNyH8sqTOyrPTtJpYDSpoWD/Fd80p8?=
 =?us-ascii?Q?pAYdRe+XTvM1AJtyiSwty2Ngce/eXmmk4RL0lebRTM8Ki+8CZHASbw36B8MV?=
 =?us-ascii?Q?ThEjpFfGba0g00BF2ua34rj0lBYFzY3yOAz+h4TbwSnwc9K3Q0qrmAruOre6?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e0f453-496e-4a19-4915-08da5ac64ded
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 18:28:18.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NM8eYYk5h/LmX5RQV4dgeee3YN6Hj1zKhdP/FzaIcovY8TuSoQeqotuuIRQM2qkknN1IeZzPv6E5ebs9Dm1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300071
X-Proofpoint-ORIG-GUID: 3CYGxftrNUuZyuXSd17A6K6LbczDWgTG
X-Proofpoint-GUID: 3CYGxftrNUuZyuXSd17A6K6LbczDWgTG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot detected name collision when compiled on 'um'
architecture.  Rename "to_phys()"  to "pmem_to_phys()".

>> drivers/nvdimm/pmem.c:48:20: error: conflicting types for 'to_phys'; have 'phys_addr_t(struct pmem_device *, phys_addr_t)' {aka 'long long unsigned int(struct pmem_device *, long long unsigned int)'}
      48 | static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
         |                    ^~~~~~~
   In file included from arch/um/include/asm/page.h:98,
                    from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/um/include/generated/asm/preempt.h:1,

   arch/um/include/shared/mem.h:12:29: note: previous definition of 'to_phys' with type 'long unsigned int(void *)'
      12 | static inline unsigned long to_phys(void *virt)
         |                             ^~~~~~~

vim +48 drivers/nvdimm/pmem.c
    47
  > 48	static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
    49	{
    50		return pmem->phys_addr + offset;
    51	}
    52

Fixes: 9409c9b6709e (pmem: refactor pmem_clear_poison())
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/nvdimm/pmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 629d10fcf53b..b9f1a8e9f88c 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -45,7 +45,7 @@ static struct nd_region *to_region(struct pmem_device *pmem)
 	return to_nd_region(to_dev(pmem)->parent);
 }
 
-static phys_addr_t to_phys(struct pmem_device *pmem, phys_addr_t offset)
+static phys_addr_t pmem_to_phys(struct pmem_device *pmem, phys_addr_t offset)
 {
 	return pmem->phys_addr + offset;
 }
@@ -63,7 +63,7 @@ static phys_addr_t to_offset(struct pmem_device *pmem, sector_t sector)
 static void pmem_mkpage_present(struct pmem_device *pmem, phys_addr_t offset,
 		unsigned int len)
 {
-	phys_addr_t phys = to_phys(pmem, offset);
+	phys_addr_t phys = pmem_to_phys(pmem, offset);
 	unsigned long pfn_start, pfn_end, pfn;
 
 	/* only pmem in the linear map supports HWPoison */
@@ -97,7 +97,7 @@ static void pmem_clear_bb(struct pmem_device *pmem, sector_t sector, long blks)
 static long __pmem_clear_poison(struct pmem_device *pmem,
 		phys_addr_t offset, unsigned int len)
 {
-	phys_addr_t phys = to_phys(pmem, offset);
+	phys_addr_t phys = pmem_to_phys(pmem, offset);
 	long cleared = nvdimm_clear_poison(to_dev(pmem), phys, len);
 
 	if (cleared > 0) {
-- 
2.18.4

