Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49875472E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFKI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiFKI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:27:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3912AB8;
        Sat, 11 Jun 2022 01:27:13 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B2rQFK017081;
        Sat, 11 Jun 2022 08:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=7bjD1seZi9qZLm4fyCl2a+hr9lw4IFuUoiutXwQgWDU=;
 b=Gz6iaDna+WbgGeSKDvYjMv/9J3DfCDTCPayEKtSaEZUAKcZSFgbIo2XA60bxaSBufZUT
 xFB8vsIH08SGRd9W/gTbV+5vnfeGehiCJETqZ6IRguzH8cA+2OhNTWDKP5/aBceGdlMX
 8pJLZmwpVjq5jRAo3fAEJiqRDoZ6++p8nAix7sagd7i/D2ObiBoaDOv+yi3hYcKqYBp4
 vuQD8kbaqCQYg+bi9Hjo6bL2vWk5bs+hLb6oyV4L5WAxyH6svvRby8I5PtXjkyXa0UKp
 tDN49HLlanN4LH4a8hV5r3rDQc9h6pG1hYDAHm/UJs0JwXoSaIMM76rCGPSoVTFyRuth uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjns07dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B8A0x8009256;
        Sat, 11 Jun 2022 08:25:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg727n5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghohIVlZQqvM17oj95FUt8zaUavd+n7aq2bKCx9s2YI3yH4UbwujUcUyvZggZYux5CyMcIr5dCHirM7eT1An39wodQY25D4i8ei5FSR40ZQmRAfZTHPjgJPRjdm3VFtqTtaPR2+zRY5NzL6+VMTvvd6MO0UtON8r6/v8qaNyhVEna5+IFFdLtkQ8lxdhBi+uo8ZiIqFSrMfUxp+4pj8qVAgc4ebBCGoNaMg95iKkzXI7A4AlMhjmkz7VQGucRHSnpKTcz3SbT9/M97BmT7b+quKAH8DZO9JDbNRalE//0DlRnXrNHUS9N8Wsp++LU4ZHvo5biGVnQh7l/JyQ60Q2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bjD1seZi9qZLm4fyCl2a+hr9lw4IFuUoiutXwQgWDU=;
 b=YA4jyWOXd4dnl82EaXSiojJl1R99zqGOjCqlCfjexGgIYGSJYp6NVtuIOWv8M8hpOMg0cH8RSGwHVDQgGdWVfjcs3GRBM3TtczISJ193Aw3kCobZEQoLU1kW4JG/DCMdTwLJQ+1pWrlV5vB7ybzXegsbq63DZRcaptmwJ8hEZRz/M697J4qYePzcCMEbfqAD+aCFVZQRshypvzllnl+7tBkfI1R5Rp5UA4AEsDl+FuKHKfuOEmaoKBH2rLBtah8ML758ijLWtQQaW4SFdh+ysFMt0QWRdaFRkDnVBNkgJVaxFQveciqbD4/F+w6mCDA6biYFFNouaUMzVhE+G/ZRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bjD1seZi9qZLm4fyCl2a+hr9lw4IFuUoiutXwQgWDU=;
 b=r4IYLxBwk30iByn3XNTHZqlEpdNN3hEXtDN+Xi7RQeSQiZAn+nUV+KjdJySYdL8OsG/mTAU6w2KCdswf75Ybe9m8hFq0F/fDQMWVz0SbUGo8qa+zb5SD45+6sejzkksmMLecEuv4vGA76GAG1LE5xwW1egA5mpwf8udGB2eFgUw=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL0PR10MB2945.namprd10.prod.outlook.com (2603:10b6:208:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 08:25:37 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 08:25:37 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: [PATCH v1 3/4] x86/swiotlb: fix param usage in boot-options.rst
Date:   Sat, 11 Jun 2022 01:25:13 -0700
Message-Id: <20220611082514.37112-4-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::30) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e35599cb-bd87-44bd-78e1-08da4b83f679
X-MS-TrafficTypeDiagnostic: BL0PR10MB2945:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2945BD102B9385003B9352B9F0A99@BL0PR10MB2945.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4fM4jpJwTp92k/Icu9pdImtv+PGPgYCduJors9GOPAcvAcX9fcRWiX36++Er94oOc5WjASl1jE/JGcYD05em5J/YrVBAUKe78QVcRMz03CAwroCua3KEYdoAkIavlO5ES6dfsp3IQgBwRSt122IrsY7/RzOTIjBK+DlgwmovGunFdsy3l89YxteZpVyGIhMqaZPuAtn5mMIKXbS8x3mPV+YQGiEzMIkKovOlHpfnHGJvY3TF5d9IPA+nAA+E2sC0XyrIN13kvxy4f4qHDnRVXZ9n70NyK9j9mmnFwXa+DjJ3dKPh76NI7LoEpOpuIkmtNCg9qO5L79+rWHQetu+j+Gna8xbKMPxkLpztxBMO5p7J7POfXLHWKL22RoaJextjrkwcZn2MAH9Ry1cHNvKMH/hBcUEzae98B8s7PDHv7tsDFQXBWZJ4Iyun0Peb2v8Z8AUmrQhHwWCnAwQcLBOVW8bp2WypZp6YwDtBU4ps0zQuPcCWR5uz3Fm6x+GiiKHKO64zwa/cZBPnezfB8uTMWzxklJEtxE6qJYt3Bw2zUl9JeDWKprc6g59Zben6XXEJi4IVpGBLVKIzv6CEOGSXiWiW4JlBIiy7nep7uYZdfTSeIPvI0olQx3rVnDSDxsNkmTRJAiRnhoDYHmHXDTe4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(26005)(66556008)(8676002)(4326008)(1076003)(66946007)(186003)(36756003)(316002)(2616005)(6506007)(6666004)(44832011)(7416002)(38100700002)(2906002)(6512007)(86362001)(4744005)(83380400001)(508600001)(6486002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1tw1+TTMjg5eOAveYTlus5WOdCzWtukQeQ3OYjxyVIrok5LUAdyikG2Jyxec?=
 =?us-ascii?Q?0Q69mV9ciVZzMYJEXBz9iUD3zhB0zGLeDfRh+EENSF78F2GdJDju8jy/O8xF?=
 =?us-ascii?Q?vKdu6NHUJyL/NDp8Jvv+s0Dk7heL5e/xDSEEPXRT+wPR1ONWjFYjft+MufQ9?=
 =?us-ascii?Q?I3/Qi7T+xFYgYnWjYGC9818hDsozAltBfb5UIagjctfQE7ODiPdPr1PqBy90?=
 =?us-ascii?Q?VXNOmylvugnNxciTx86tfoNi8Om9D5H2BiCqAMCgFdbYCy3IWEl7YbPFjCvG?=
 =?us-ascii?Q?TKJfA8qzRzQuFBrvuFCPMlFUhpinmPvLLu+Zogxz2Jb9nlSsJdI4+pRyWZPx?=
 =?us-ascii?Q?KqzWzOfo5E6Ggf4C8vIKzANn32eUtPTeBR79RFalkvBHsLrA9hRw7qVJRrBH?=
 =?us-ascii?Q?e0H5gc9UWyWv6HJeK8MOgjuxPWSMKVJ23J+ao5a7RSrPGbnoGXgIbnx4sVJk?=
 =?us-ascii?Q?rSPyvF7hWGbKvqIpCYoI0BwWb87lU/pVCIP7l/FcHpZt5ndJ/mQFa3MUjmWG?=
 =?us-ascii?Q?IjttvvB6dQ8nnw1Ae+yQ2+e1sD4oU7390HkpDw4Zd6MOXrbvrVtshrQg7dA6?=
 =?us-ascii?Q?h9Q6TAm8fVjuwMeDC9CJsb7TlzM5aHNecUnWeLxE+wQF/lb3QToTMDwQnRYX?=
 =?us-ascii?Q?6yuHwm46voCpsvpDHCpSaqU9n93Hhz3dFaQz0pNHWRrl3qrUMMD+7tM7yXLC?=
 =?us-ascii?Q?w6DkSDlU45jyBowGeOtFUWV6qFeGE1cPcgLuTytEvRk1IcvQTUAlxNQT03rr?=
 =?us-ascii?Q?ip5AdLMTPbdwSzHei022/1jY96dU0Nfl9F+um2YouvGFgIocy7hAnbmG6oZ7?=
 =?us-ascii?Q?Twbz0dSyNFAx4TS7npQ65+4J9kV42tDZ3Rw0qcHDEp4f9aeq5/KOh1DPASqC?=
 =?us-ascii?Q?4kKTHFJxJ5B0UQOXctzWvoWsJqKLhOdtjNsC+9JAfuNnjBTdraKi99UEGySr?=
 =?us-ascii?Q?/8EPtAJnOw4UADzH2V/Cp6YWI/tArPrTpysKQNWiGUScu7kHUJJYWwc8kHrD?=
 =?us-ascii?Q?YBoBKtjL5VwwuG02cX5LGngixudezWJ90q/UgJAmfCi0T7QVNwui2y/H4qDZ?=
 =?us-ascii?Q?S4oif4hn8JZn4ogugM/WyoK/R8s5LfREko0rJIYCbqHCVvokwut8Ia0lI2QB?=
 =?us-ascii?Q?bS/yay2GMcho/wgSViJurDCbgFWpu6DL3GB6gusIzos8NDUhQB7kzhv59Fk6?=
 =?us-ascii?Q?PSDqEZ/ZL0xrIzp2hk55Stk3BLnINtewquFJpyMimyN9t85h6yskjDrN6rCK?=
 =?us-ascii?Q?HbQrPWOdwIUeDEAV2QQpTLwkCmbP9PQbScUkgM1E68+ME88lDEDyaizKM/c0?=
 =?us-ascii?Q?6Rt8c64u4dQ8+LziulwaLwVA/hLX1oWuPCydpY9omRfQ2Sfq7uKJ4yfUZ1Zg?=
 =?us-ascii?Q?+tB7FazbAQqgut5/qGFqYWnj7oN2sOJ0PI66YeRk79vUdmDpuubyApW5okC0?=
 =?us-ascii?Q?T90DBxzRgaTGChjd/8ty/TJc+tel6mTxQXGTpKRNt2OzXKXXWZXEa8O0q+uI?=
 =?us-ascii?Q?xdqyXLlGUQHtWQWEKlMnRkuHTj9SwfceLp0n1UCD/Ssl657lOx3HMGfOLn/a?=
 =?us-ascii?Q?cuNz3YyNMhJPVfvY0Fn6OZwRiq17xHFI84Yftrz5S3xWigHknZcygO0ImC6f?=
 =?us-ascii?Q?6Iy7niCWz4Anh9LwEhX17n0dvVHQH1O3HsqA824fcOp/DsHCh4FU9GIZIa2+?=
 =?us-ascii?Q?uN7jR0F6my5ALUb9KGOmtkqsSjr3uNgGbj+V169V5KI4hdhGq8EZ/5svn0Th?=
 =?us-ascii?Q?Q9zU0QX+Imuzi7r1DHj/3RJTU3gvc4k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e35599cb-bd87-44bd-78e1-08da4b83f679
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 08:25:37.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6ZTfGx63pjQkcUMLyVixUiipLcXvNPXsgdLlY4aiDqDGUQTViMquf0Vg7J4Q0Mk554hwTk1FToI1P4j8pLTug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2945
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_03:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206110032
X-Proofpoint-GUID: QlmCXfOt-aUuef0hK4KbGk4YzcyZQ3EM
X-Proofpoint-ORIG-GUID: QlmCXfOt-aUuef0hK4KbGk4YzcyZQ3EM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the usage of swiotlb param in kernel doc.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 Documentation/x86/x86_64/boot-options.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x86/x86_64/boot-options.rst
index 03ec9cf01181..cbd14124a667 100644
--- a/Documentation/x86/x86_64/boot-options.rst
+++ b/Documentation/x86/x86_64/boot-options.rst
@@ -287,11 +287,13 @@ iommu options only relevant to the AMD GART hardware IOMMU:
 iommu options only relevant to the software bounce buffering (SWIOTLB) IOMMU
 implementation:
 
-    swiotlb=<pages>[,force]
-      <pages>
-        Prereserve that many 128K pages for the software IO bounce buffering.
+    swiotlb=<slots>[,force,noforce]
+      <slots>
+        Prereserve that many 2K slots for the software IO bounce buffering.
       force
         Force all IO through the software TLB.
+      noforce
+        Do not initialize the software TLB.
 
 
 Miscellaneous
-- 
2.17.1

