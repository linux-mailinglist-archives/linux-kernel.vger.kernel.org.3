Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D629C53F058
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiFFUmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiFFUmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804EEC315
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256JupQx010668;
        Mon, 6 Jun 2022 20:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=DOjPtUnicS/yGBvgkglQQSNIzS9oMVReVWssGx1+fl8=;
 b=Xn3ivHJEr2fF9i1iW1yIXQS+7oqtsjy1T/vXnuPHn7t0Y7eMA7o+M+QXQk9EB+qThRL5
 mciHQsQHUfKVDoNsc6OKiz0T1WZijk919dD+tEWPEda96edValh+z8BUO61H7adVLAOX
 MAD/M1/VoUWDAQ2GpXjrYkJK1vt52F6n5zXxBqUfdL2vTbWe7krd5x+4cmn+nSIzcPsm
 HnoFyYg8WH2npLNxE7rHlqtNDtlrGFEpdI67mhCephS122S2xx2dtrLltF/8XjGkeT8z
 26ef3eiRZocmree9SDKkyPtK1yZJ51mERFa7HcH/dREc4n9M9+PXXUPPxyNLovZXeylV xA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gfyekc25b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KGODo037881;
        Mon, 6 Jun 2022 20:38:25 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu1uqjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEyeOt1yqx/m2DiDf+7BaIKokLEughZdzxpDqRQ7boTcQEILKJ+M1eQCZdF/RftNRIjeOYsFk7as8NGjPuccXGgQSdkC3wHUj5ZVsIDOfvL8vKWgCjtJWlbTYCdKF3RjVkuykr1Od5UGE3a3i49tKhvj9KD2FdPpuHmjRIoJDET5mmw9vKLLIanOzg6sSgRSKrGsAiMY3LdcL9eNIeur/M3BQJZhz3kKTYEOgnPtXkUcdkJCnpMJb+i1jx0cb9eKwT8kHWJ7KNdMhJlGvl+wVGIlbjh4vgcByd9G3HcJu7TUas1qnpr6nxVseWVV30pkWuzSun1zEhtbD+kyWR0p/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOjPtUnicS/yGBvgkglQQSNIzS9oMVReVWssGx1+fl8=;
 b=f4umnED4Qneu0VpOMXbg8unv1jxpiM9Uzpbv96cV3UR724vud469LdUo8ftaa8jWslGUpEhKKofv1Izh33BMm4VG125rUY/huAUA5icnbXSEiDt360tXWubpZpXnNOQDeepi5GdpvUwR+zE51hquoGpvk+gy6+sU1RIzUFsAlGnCa8O8SiA7uWPtD96RsNM/SqOT16hcRZGfThTuSaOA33S/YZzYMzZ+fvpked1ymaJewlI7AH8EllAAszItVSmOuvLhlEnPU/HlOuU+Nq5fFh7vwEWh9dziHckfIf9D1DA4Y6cK3gJGG8HBVuCUytGqA3gT6Rbmi6i2IfymdLQkLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOjPtUnicS/yGBvgkglQQSNIzS9oMVReVWssGx1+fl8=;
 b=sIHWEdFkBvJKr9W4NyhSBx3PJlBOUN8RMhcVg6ICbOQ8ighl8yb+FyFeQu1410hsg+Xl2k3aHMKMGbftrZ40nD6kQOaw+Q+/InMUWP3USMDg2Vqo+mdZFx3nV8d3GQnuUAATB8940RQW9kMWTBG9n5vyFswgZd1n9we5vZkLVS8=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 BN7PR10MB2596.namprd10.prod.outlook.com (2603:10b6:406:ca::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:38:22 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:38:22 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com
Subject: [PATCH v3 12/21] sparse: add address_space __incoherent
Date:   Mon,  6 Jun 2022 20:37:16 +0000
Message-Id: <20220606203725.1313715-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a770ac-82d7-45e6-7467-08da47fc7f9c
X-MS-TrafficTypeDiagnostic: BN7PR10MB2596:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB259604C7288C619832555CE7CEA29@BN7PR10MB2596.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WJ+HYBu178ymT2w+Ta6HCYV2dP2Byhh28RwOMr33ZpK7esQyYr6JRYxJ/t9Jr5D0D93I7k+cPjVkh/qxrVa2bNdl1uI4WJmTknNRzQNaBVvpDONtnt0AtxPg5JXRWcqbyxsc6Hu0XEqKMsk9Ru9TVDTMW3w+S9Yua/QEZmwODUBVjiDUZwho9/f2H5rl8yYODcvgy7KrU1lSc19EBtiwoJ0vWEHdU+6cfnv13BIAuX8Tx357HE14r3PP+1uPmUx2WhO90WTfODV6WfpUKeMl62eX2Ox1XWlRRU6ymqAbXrFYZ6CiGtBRRuun6EjSY10f7/B8wJ5XsUGho6K9yVTiSp03vjgu/gHa7pZH+a74awBcRIKCe4AHVA5dNHS5eNZKs+1kWhjh6MBWsTUb+XqmDDJT4pCKOMXOX8YsJbxTaTZc2M9L/UZp+H2HyAYYSf9wbyTu+/QZUN370O/sIPc6C7aGhNt5YS6g0juW/D+GFYMOXWdlFqAJba7G0ZNpc+tehVq9BLpnYYC1LNRAlYfQJaIMFyDVlW4BpY1tX6yHyTzdmjaDvjv8VqVaPEzQKEVzCAZpmyqFiS3Ip8QNvo48NZx3y0F9+SUBayqQfTzMf76QPlTZC4DNNxFWSZ5NdQEbJarJSUPsXQG8m+hOQzNaFoM/J44o54E5eI2DhOg5j47C4AGjhdvuvFh0Kl9K3HtucV1euQuziTtsuh8JP6h/Zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(83380400001)(66476007)(86362001)(4326008)(52116002)(66946007)(66556008)(8676002)(103116003)(26005)(6512007)(6506007)(508600001)(8936002)(6486002)(5660300002)(1076003)(107886003)(36756003)(2616005)(7416002)(316002)(38100700002)(6666004)(38350700002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQ3tlD/fcjkeidSBamAxSKtNmiDvG2098wLcdYBgM2CM7fxuJc5AAEmcEuVZ?=
 =?us-ascii?Q?3vXmTQsEWz34Xl13u3K/YL7z4lCaM68/iX93REDUXJMSS29rFlx/sxJ0Kik9?=
 =?us-ascii?Q?WwDivgd5tB6s30YQPZARmbejVbTrDqskG0ujwn+udh8/465maY/0y/fRQLBm?=
 =?us-ascii?Q?PUCseuqKmfzQQUFhbnmYbjo//JtKGNAQxiEgnebkFQqHDevmWtcZKjs1tuL4?=
 =?us-ascii?Q?PfWQhgbskAmnL/iq06+DXlJAS5N/fUOrbEd/wieszcDMRbLfOFIWTlf0bQT4?=
 =?us-ascii?Q?gyPquE0z2kmN7v8EwB+wSyzZmu4ZaRN2BcAX9Azhpjwd08gYOY4KSQpsFeCp?=
 =?us-ascii?Q?Sipbfe/vSZZtfNyW/gvk35xUGC5haBb3nMcGYg7GrBDlDIUl1T902neq2Zba?=
 =?us-ascii?Q?feaIE8pqBKLpkdekYi9Y4qduuVCnAvW2gzidoHwxiyXB31iZwiwewefYCisa?=
 =?us-ascii?Q?yvmJyu8boHD1iJsticxMDv2cfzcbDB6PmYZJWwZqNY0P5XO5DLMEp4jlekm+?=
 =?us-ascii?Q?Pml0BYQgCbr4OIu/zHEYDcuxRMgPt9KvaCOvDq7x62trEMfdU4V8qP3y9IHs?=
 =?us-ascii?Q?y8t3ZpwW7KRzATRiNLli0QIbUeEIErK7Z7SK6fJgchE8giXEXJQXiicHoLQ3?=
 =?us-ascii?Q?wVuFGOfCHdKvzZR0k4lESgQJhEJ5UUrHAnM69i92S8YLs58FBGMGiPiPRgx4?=
 =?us-ascii?Q?gmEuWtELMeZRXnYWbQUd6N/ZWi8y8gSitCkxQ8Eslr3OdALEVPyg2T9DiQ6v?=
 =?us-ascii?Q?HkeRha8Hncu82EPrCao8o2W/f+dwTFYq2V66Rfk6ZiyfgN8N+X5jPJokbRSc?=
 =?us-ascii?Q?PlsCUkFYVGFJwyu3TIz/j5C3b0gfEnahsYtAU5Dsgxok0AG30p4SKihr0MzO?=
 =?us-ascii?Q?y7q74wRFDHh1CXbewrjsUOlrTGozIRJdP0MkwcpdrKivV1VJ0hMg4nax2ZxA?=
 =?us-ascii?Q?+6yFJ13/yAPqviXjNEtf8TPiWUAKCcc/8AFmGBIdQVFXzEohGHDvg6vUNnS5?=
 =?us-ascii?Q?9/FDQXe+r7218x2CvZ7PAYWoxxjl2Rw4s22GUk9U6pIHSp1Hzma1VxhZctVI?=
 =?us-ascii?Q?gpH28S83QhMRw1wXhkRSnbESO4LbaYqNEE0O3ZVFtLRfPZlS10MpxmFOpkX1?=
 =?us-ascii?Q?gDhG8OTgM2HnH7PpT+waRUsJMZtPXyavP7VYLSU2aqUZvk3bk3A7ZzQzsNRE?=
 =?us-ascii?Q?MgnKUUbuqpxUj8TCjdHjUHYdFfoM3v8fW5LoI0T4cwj9O2AjAkQYkd3RrjyC?=
 =?us-ascii?Q?f21Lomw1ZIA2YBJYnW7WXg986p5jIhDtOKyp35b5DsB4vOgLl6O+mKtkS5jN?=
 =?us-ascii?Q?eC5m585jxUwERTnvILlWJ5L3shHgWzaLNLLPbh3ey1Zl2MgcnWKoVstC89fZ?=
 =?us-ascii?Q?QGTZT4Cc1/DnmtIoG0ZcwjBQE9/Qjg5WpKYeQ17LdLBhcpUNOGpQAkPm2qy3?=
 =?us-ascii?Q?3PeShVFD4kIwgN/5oyR7ko/YWf0SinO60AUznj0I7Ltyw3onRFRu7K46346P?=
 =?us-ascii?Q?ehgWPIEY8mj7j/lH6uvcH5q6GS9xbaWRuX4KqBdq/yXqeTyM8qiUtWaeK+7w?=
 =?us-ascii?Q?bfJpsfygb1RxSu4EOuqyW0d/UlTAnuH4P7QMNBeL2eylwF60odrMRdryxMBI?=
 =?us-ascii?Q?X1/hcYlPv+ddfFkBvuETgc7t3X4ZtU8lCsxWVfLlwSY8NaDS+YJL4H3xlPdu?=
 =?us-ascii?Q?sucBhhwYuHeXQTQ9g5nIfA2BjXkUxB3Or0h+KPy6/+k/I31OCBWUvL4LYh6j?=
 =?us-ascii?Q?hlZJOLVT8ZOeGtjqSlVCrF+IqLhC7hY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a770ac-82d7-45e6-7467-08da47fc7f9c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:38:22.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZSoAQjMiB36baOBZln7ysobSOj9M0lXEbL2CBYkAHHWsRFLxDGH1lat5km//6rs0wF5I17wIeouLhue/uQ43WlmQYFVV8T8h8kjwm7ZnDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2596
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=961
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206060081
X-Proofpoint-GUID: 94ZBBeZywuUSEb6fxQoQGBa827SWedSz
X-Proofpoint-ORIG-GUID: 94ZBBeZywuUSEb6fxQoQGBa827SWedSz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some CPU architectures provide store instructions that are weakly
ordered with respect to rest of the local instruction stream.

Add sparse address_space __incoherent to denote regions used such.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/compiler_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d08dfcb0ac68..8e3e736fc82f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -19,6 +19,7 @@
 # define __iomem	__attribute__((noderef, address_space(__iomem)))
 # define __percpu	__attribute__((noderef, address_space(__percpu)))
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
+# define __incoherent	__attribute__((noderef, address_space(__incoherent)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 /* context/locking */
@@ -45,6 +46,7 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 # define __iomem
 # define __percpu	BTF_TYPE_TAG(percpu)
 # define __rcu
+# define __incoherent
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
 /* context/locking */
-- 
2.31.1

