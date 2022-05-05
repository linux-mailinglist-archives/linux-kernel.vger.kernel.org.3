Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213D451C04B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378766AbiEENO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378985AbiEENOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:14:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECD186CC;
        Thu,  5 May 2022 06:10:37 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245CudG2026114;
        Thu, 5 May 2022 13:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=GFea5p2YtlQASVKQA/nIicg3XewRymCTPnPu0TdAcCM=;
 b=UqXfFEcK8er6nmBbb6nxcafImq9NX3SxKvdooy03EIIpMzwDaBTjLbUbMUzrq2Df9S1J
 kFSdw3EZc4qLVvn2Ipvar3/9p8GmLNZ3S+iwhwgxyhpG2zg/R2icaTns5CF2NeHbFnzT
 UFTBlwMG1oW2ykm70cHwfe1uNAgas1Z+CX52FF4va5+IJ30mAPQG1722qLu3WxoYINaM
 SeJbP+xeV1lC+MEYuxJ4FD+lxj7CrZZJliDw/Q5dRMbxapebxr+QzuQ5u0rrAUG2v1Im
 UIN0uZ5ULuk8NjJM9mPCdzMxHA+n19B7zz+al4JIJQLpIRu5rYi5cqnc5HzdWc/uBYxY ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcb3j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:10:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245D5P4e019802;
        Thu, 5 May 2022 13:10:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a6ybna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 13:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1FkDwSQJo3JMfJ0KMJfP0cjaAK3a1Rg32mZdsLbxpBl609pxVcz8nxBx1VxQYTcF01d82xr/wr8HOqjhWueSeZztDUef3zBk6GuEjH/32d8C8mSUHb7uB5Nh00XprN7mm6SL8NsGqKMke/l/MQFBnWuj3KgGSotJYzJfJZDL8aiPJgb0xq6eP7aZvG9wBZPjXZjMP6whcWEsH/pjboWwzTmgB+ft3dSpRJs4cN3L1+65xw1ujS32+fO/FF4dZRPwx6XcE+gpRp30+i7V+JCEZwlLgNYoi6s/v3vb3j+K3GqO6RS20El8P4BhtXCGp3qDpwvlfWEdkZgyv2Yuslr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFea5p2YtlQASVKQA/nIicg3XewRymCTPnPu0TdAcCM=;
 b=ihUnZFTQYjuFNL9tHrKxXK48Fq1+daQlNqL3LZMtgfEAJFQrRBV5zBe55f/dYMahFtHAq1GTGbA+4hge/DVAgwM3QDuwcsf1tFjdSEQrXhsWomyEx0whfzhksf1KRnC0HGavL8IZ+LSkOyuEyaVm//MHKfRDt6MWnQ+o1tbjzkfsxysrehcNXmEQDvn1+nyYiIrLEKyC9nXEKHNtteeWYUWuZ39lQB2hQAG95nJuSg54AyXARPpWEsteGHhokMHD/kSA0klrzkIL+gcIP4A+GhuEzPFBG9dG1WCNcStxos1DMz1gqRhu9gPmksSfHTfDDnA1gccwetyv3iMnV+WBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFea5p2YtlQASVKQA/nIicg3XewRymCTPnPu0TdAcCM=;
 b=WtO80uquOb8hWiLAkBnquyrfeDwWnLsmMDURC/0LuGrl7NgJg2APW1LVHCEQDj3aebC9om8+7Eq+Q3QrtcC82aqAXrJgkbkEj2T4lTfmO31DAMEdhGSiIESHdNCVZHiOCq/2cGzBBnAGk8Kk82UF0l7BsKMuemsc0NaBLgcaDVI=
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by DM6PR10MB4171.namprd10.prod.outlook.com
 (2603:10b6:5:21f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Thu, 5 May
 2022 13:10:25 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e929:b74c:f47c:4b6e%4]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 13:10:25 +0000
Date:   Thu, 5 May 2022 16:10:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     Tianfei zhang <tianfei.zhang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] test_firmware: fix end of loop test in upload_read_show()
Message-ID: <YnPMt/syJAqqOBh3@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0179.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::19) To CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 340a6406-f8ff-45ab-f5a9-08da2e989e46
X-MS-TrafficTypeDiagnostic: DM6PR10MB4171:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB417147BF5B06672D8BFAE4B98EC29@DM6PR10MB4171.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sAYNYS+TdtBiz9K8vcYaWwU6j2euBfk7xz5aMkpRZJ1qlnlchsFEXsiHuXF0IcoNSAyUIl3751kLF0qqBERxb87KlFJxKa75lLqe2Swr66znaSkFO6Vcm8OCIwSGwLmEr+sMmzA9ynASxfi0YokCxuFO5qzyqofd/ZWJfRUUo5SG7qwPF+L5M/MzRWZgyyZfk1Fcl/lwnI+W+wFGrFoEn9SbQOC+zh9pI7afVc3BmLcom2zEC8v97gFuncdU0JsngK+5DhRKQRHJuiF33wbsCLkUyA1Jv25lzof4htwUzsPFbqyNpPjfkY6tXwCNCkFXZdLKEbztsyzX+Fona6PmytRzunYuzuAYkwG1Rgm95IXtKlEWxoEkX3nqEuKpSn1hGrWr4y8aJ9WNeBk983Pt1eDCLUk0gcBdkCnMBOfIpUG/hDY3cd5yHFblMu76PEz9cSgKh4JrohY8HFffBLUuUqr/xxJgMV9RvSn7CaUtIOaGJ0oubQA1x+zjTeL8JMOwaByEfZiUXUxRfJ2sMPfmobmRAbtsqhBDHGbT8bkMSJiN96q2WrwkJn6VMTI0WK/EuW6P3GpgSYg6nG2JfNUHcZwF4QrM/fPoeo5kGYFG288Ixn8o91EQwuCEwXAELNzQJF5428qfpg7LOu/BWr0fbIiCCbPQ4wZ91k8kcX8RDrNbY0mbpT0ktrpV+1bqo0EtJQqQ4LOB++JV4kSXp1Lagt+IZphh5wLsb3h8R5KDKpav9cwyaZ4X+BFB0xYCaueF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(33716001)(52116002)(6666004)(38350700002)(38100700002)(66946007)(8676002)(66476007)(66556008)(4326008)(8936002)(186003)(316002)(2906002)(6486002)(5660300002)(508600001)(6512007)(44832011)(9686003)(26005)(6506007)(54906003)(110136005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CngwYnKqqGdHEWuzbgZqf/2tzYiBOG5m2zMSKWK7bcthOEEV8ZdN9fGl8tZW?=
 =?us-ascii?Q?5vU3X5A6o6HFAin5togeQ1EFJP2OTnX9FFsU7yKnT0vtTCRN//FI+wqbf7l4?=
 =?us-ascii?Q?pwvO9owOFcFT/mM7+3Wzg8TCNrGWYMDSZEMey8uObteP8R3jPbeB1BeNQ6zt?=
 =?us-ascii?Q?OzQOZS/TDjRHx9mERiM7OFQiuJSQXgj68SVyYhd3rSsaWu50eZybcfRTD6Nl?=
 =?us-ascii?Q?OOyEvz/MjLyGR0Q3vz4B21+i6EUF+/tvG5M7iciDSlvaFMm3e9nU4tQRXr2r?=
 =?us-ascii?Q?qhe0gAlu9Q2CKIXrL2WHZXz51Um2K86TCtyT+sX3GdVVjhrXVtkCAZKMtD+U?=
 =?us-ascii?Q?XNKNN5TSSKbnuu0e3DPyjft4bO2ggPbUvCzbBcHiuHlHQln6qjNFNiLEIVCY?=
 =?us-ascii?Q?6iQEQVFrtELhpqUmr5GiKzuHmGPT/fBjUSkGu2dZVPJWUB2ZS2ohOVc/kxz+?=
 =?us-ascii?Q?qewcciti7NKa1/YdqqzOqeDoxhMFxRhWEMsSuiht59nrVFSxPdsK3okuMh/P?=
 =?us-ascii?Q?yxhdK3rooHtAdwrtoKcvn9C8SAkKlTmn9GcdC8vgTuyt/3VBI54t7uuBN1AL?=
 =?us-ascii?Q?iBxE+l6EDjkBlFL+mv4UCDKgU161bwGrwN9CvL5TnMSBAQw/gB+l11tFRemx?=
 =?us-ascii?Q?XYjOeK1lmpyh7rJSr8lzdcA5v1xhzbIxYlHXYP5rU33R3h3w4nvftV/970ah?=
 =?us-ascii?Q?lOsuRz06RoBDkmNcbIydoRZgFKwB6B02RXQ/k8KqlHp5DOz5yFYZBK/D/es4?=
 =?us-ascii?Q?my+a/bk++1KA3PGh2D6HN37IKq66uqLLdGluTjk2lXjuTzUehk3g8JgSQWKN?=
 =?us-ascii?Q?OjLMijUZrsgQayCrYmPPp4wBFldn+/JNOlehKPHeOAhLUjHKkV7pHNRSgCvd?=
 =?us-ascii?Q?jpd1Iw+6J9+ruG1UO7vabYO1Aq8hB8DEcq26Z9Au2lHHeiPgetBwVk4byfrd?=
 =?us-ascii?Q?3a7ibaQrVepxCKjbcAQYK2n9cqWSF2eJtp+cukm/r8LIN/KVyVugBuS7E+vG?=
 =?us-ascii?Q?uqYWaSZa1mObQMPK2zVfZ3EEKnzoe3vYXnv7PE84UHY/G8SHyYV8GWB1qdlH?=
 =?us-ascii?Q?4kdBM7w2pgwfNMuaRD8t5bkjJNJ2qDN5NnZ7XicxdH8Rfci6R0y8Yhlt7lDC?=
 =?us-ascii?Q?tN4IQ3grQRieuLg2f3Pf+B4ScacednX/ceywM43qmDlx/An1hmyKr3xS74f3?=
 =?us-ascii?Q?ADzxxny+zi3y070JGaLYWR9stBWIb9u0nmojWuxu+y8qdfVFex09t6bFjgUo?=
 =?us-ascii?Q?qzxVCZ1UZFq0FS7I5icCaz3Q5MWpbqoBx51mEo077bs8DPs70WvWt2Yt9GWR?=
 =?us-ascii?Q?qIcLeyt2wUjzBpz+1IDlhiMFPeV4u9MCB8FIosFYT5WxjPXvwWEZ0dw2CdWs?=
 =?us-ascii?Q?38JVqrp0jLoPJWg+b3PiTJxb4Mpf1E6VuuZtonc9oedBqNS926r5G1IDjYxi?=
 =?us-ascii?Q?s7YrsowGtEoaN8KSkFEGggIwft8Dvh1rIYy7oFQUYB6WDMCaecFr379UD6lI?=
 =?us-ascii?Q?iC+pHvEaZrU6/YZKkwjTDjCL0XXypmpYUWyvh8xR3VFeDk8+3ipvPfVKZWEV?=
 =?us-ascii?Q?VGUIvFwp8zyXjHLl9K6RHVGSvCy0srH990/0XbtHbl++mQdPcWlhhv6XNP34?=
 =?us-ascii?Q?4p7oAc7uxXsroe16mRoCu58qkY8hKLL7Hezmnt5Z+zmGI33ct591GlqANrlj?=
 =?us-ascii?Q?VSI2lRF/8npOILGWbzVOOdGdfPyV+tXEXPL/buSCVDK5Xts8XAYGO1w6AoKG?=
 =?us-ascii?Q?EGG61hLbCca6DIcgREX8jIMESo56mg8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340a6406-f8ff-45ab-f5a9-08da2e989e46
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 13:10:25.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEQ31tl0OKHLy/vHJBh0yjTQ6LuJi6tmCUJ8k985OGUQKAT1z9EeBf2gkkxeBQ1m2clEJZMUp1yyB/SpoRB464SsYW55lmycD1bIvWjBAHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_05:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050095
X-Proofpoint-GUID: L1J8gUQQ25Br7BKsmGcFY4OBEkeC9my6
X-Proofpoint-ORIG-GUID: L1J8gUQQ25Br7BKsmGcFY4OBEkeC9my6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a list_for_each_entry() loop exits without hitting a break statement
then the iterator points to invalid memory.  So in this code the
"tst->name" dereference is an out bounds read.  It's an offset from the
&test_upload_list pointer and it will likely work fine most of the time
but it's not correct.

One alternative is to fix this this by changing the test to:

	if (list_entry_is_head(tst, &test_upload_list, node)) {

But the simpler, trendy new way is just create a new variable and test
for NULL.

Fixes: a31ad463b72d ("test_firmware: Add test support for firmware upload")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 lib/test_firmware.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 76115c1a2629..c82b65947ce6 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -1392,7 +1392,8 @@ static ssize_t upload_read_show(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
-	struct test_firmware_upload *tst;
+	struct test_firmware_upload *tst = NULL;
+	struct test_firmware_upload *tst_iter;
 	int ret = -EINVAL;
 
 	if (!test_fw_config->upload_name) {
@@ -1401,11 +1402,13 @@ static ssize_t upload_read_show(struct device *dev,
 	}
 
 	mutex_lock(&test_fw_mutex);
-	list_for_each_entry(tst, &test_upload_list, node)
-		if (tst->name == test_fw_config->upload_name)
+	list_for_each_entry(tst_iter, &test_upload_list, node)
+		if (tst_iter->name == test_fw_config->upload_name) {
+			tst = tst_iter;
 			break;
+		}
 
-	if (tst->name != test_fw_config->upload_name) {
+	if (!tst) {
 		pr_err("Firmware name not found: %s\n",
 		       test_fw_config->upload_name);
 		goto out;
-- 
2.35.1

