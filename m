Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856675472E1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiFKI0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiFKI0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:26:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FA175A6;
        Sat, 11 Jun 2022 01:26:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B1Vc08004508;
        Sat, 11 Jun 2022 08:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lysrg734wB7RS2INM+3g0qki3833qeEPYlKvwjpieEI=;
 b=KolJWigLPNT/5w7sds0x3Na+JTztlZpVWo6yjdZlJUAPRKHRmfRLjjIN7FmSC4F5MzCD
 X4B1mzf36SoJY5FqXWs1nBC1GKMPdbJMmI7nnsI01Vsw+ckh3NuckBN2PBnJbVfnXyc5
 +vib+Hpfz6kocPISJkphogCZ0WHOV2FvQvjZtiU9B6/uSpJbxljobqKgB/OSAh/uV5wa
 qxFa/QXwqawYuqZIeW6rrhuMkvrvHkuS3I2TLniCqMjW7XJlV4cVFO6H8FNXiqaT6Ah1
 V6Fh38QYh8bje7KW9G6TeQw6U3kpYKxHQLzCH7XFC3Fs5kdt09SRv6/6B6DoPRtHK1EN bw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhfcg8vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B8BWGY022098;
        Sat, 11 Jun 2022 08:25:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg6sukc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSLzKgzxGiuCyGyaOQS1q9k23ustqEWSAlG8HAP/7ldP2IbmRaKJrghCifbLZ4Fnb9+gw935PyOfXOjpLLhnQ/waf5CjgzTCRbAJOyNtrh4BgT33X0h1Aim1pRlCKiG7Sfz7Qi9+ystXLp2YW6hYmOyW58avSn9zRiWRHebF3btaMSkQ4iPeSwpLpWl6S8yFll7fOzwYUtZ8K33rG+wy5Ylq3fraDcNNnOnfSvXUp1VW46Fn7BnDf4NRr2jdnOrBJHA65sqDA2DdE1/CQdstrwwaVd+1BEkyE+nvlG4AzDwqyM7bIdQQUX027KKi2nW+ykPW3hC8iGaiqvrIjvGOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lysrg734wB7RS2INM+3g0qki3833qeEPYlKvwjpieEI=;
 b=YxtZaMEDJdYjEoOE0L2ExyRJkEhLQXMwP9yTMJ6qSD8NxneiculxNDAAFfm1C6uxuL/xTRqwt/EX1kBpFbDBG6utvvC6q5WcvR/w448dAz9juUV/e7SeVQQWD6YrXGAzcMykzd+7pIx8mhjk8CBF1O22xOWK+0oaUlxt5xXl9ouxjiZG2Deu+fxnUEQCWzLm09+3bI0IQvVEq0h2irqhEPFXSZOemBYrNxYE6UoKkF4C9xyNm+Q3it6WvC9Ovmc/OSUTLOEictMDxf8QW2DsJaP42K2um//92DgNv5b2ijnKLFdwASG3A2hCV2d65nA8OR3r3nMUNysXg+fuyhQAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lysrg734wB7RS2INM+3g0qki3833qeEPYlKvwjpieEI=;
 b=eSerbLwf+cE7fD2ih56sZ4YTHxKvoA3W2Gv+CINCdCxVM6AcY+Nq09AKuy2YpDpxbzGBL7GrrxlsBfXipGWrHG8+tle34brDIMqn+V3vYApUGtcd0X/5WHwhzp8Bg91eA7siY7AgtFnN8z8si7Zz5m5BZj6HY7juTxD35H7u0qg=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL0PR10MB2945.namprd10.prod.outlook.com (2603:10b6:208:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 08:25:34 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 08:25:34 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: [PATCH v1 0/4] swiotlb: some cleanup
Date:   Sat, 11 Jun 2022 01:25:10 -0700
Message-Id: <20220611082514.37112-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfc09cad-c976-4b13-ead5-08da4b83f459
X-MS-TrafficTypeDiagnostic: BL0PR10MB2945:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB2945757631EB14393AC871A7F0A99@BL0PR10MB2945.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hYxgevPXQ8bTCrV0sqUNa1gVcWMkf8W3qnWqnNJWtxclxWZM/eTkAz11VbU3E4LncXdu5HB52MAzAk3Qf+mWllAgL/fa+x6nXlkQwBjxEqWJElvuEqAddaQOaDmGJRFHHeX4axBJF11JUkoFbbvLXgLrrN0CIkYf/k6jmsqFhwusBuxwpmuWg/FyhUv9cW7jpWAnnj8xBYxKNxtoWgx/599hCKUzzSGrZx4mfgwVauQ1+ekIOhKHm55L/9ZhDLR6sbuP3dGr0LpoUy/zCjg0Qd1JWPPkTKncDHOLiChFAiVkofeu4S8h7mgp/tfk5+Bq2WFSdjJfl3Zr86kVyQYjM+N2tVDkNbmQfRCU+bgCHpSpeOtCMXlzJ+dv/p5F9PIRW47dNvfgOCz57qhEAJ7qCk/TxIdQf/wK+xnxXKzOV8CHe6ribMSXUC3lHle9tzZEpYyVvWk3hA6O3nNXiMcWeCLy4CR4sdKbGmj5klwBbK1u96tVa5Rxs60nKc2qFcESxXKL/Y9ZuYnZmsB6k7tCLA6D7nZ/2t1XIPq59RM2qy4klaJROyJuk5jpN5wZ8s68d8igey+/fysQBxbzRz80YiKKJvhtA+LQakNcZeKK78m6wUQP0AM+96g4RPNwPqGQdWrfFkfv07jLqnQU2dIqCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(26005)(66556008)(8676002)(4326008)(1076003)(66946007)(186003)(36756003)(316002)(2616005)(6506007)(6666004)(44832011)(7416002)(38100700002)(2906002)(6512007)(86362001)(4744005)(508600001)(6486002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MK/X8bhlKgeCAvZbBypCMms2vtZpaJhp+nR7DgxIOd+pY16mqshBMQiydorg?=
 =?us-ascii?Q?WrNrXdzT85K8ta7mst0E+11agwi1+a7AfqQLj+u3wbu9ALVeHJsAnpMoC8E+?=
 =?us-ascii?Q?34Ff6wek+pM79S3NyOf4OakKEFtuHtpbuNXjQUcvE1Kr4/y+V8hEx1O/oPMx?=
 =?us-ascii?Q?WL5N31BLcSR6BizYfOr5uNkE675F9bg11d0vxvFM16GCHEw4oRgn8Inuppiy?=
 =?us-ascii?Q?uhWdeYVOoBWj17EG7tQDFE0xlYpoNIbeHUH/fz1jIVQy8RzwLdwdrOu+TF0m?=
 =?us-ascii?Q?7NkakMKHTEKVD2rsksUwb3j+z4Yp1pv4jf5N9fDAkIhSfsqqVylHp/Jz8DWz?=
 =?us-ascii?Q?naWXMIlujSpfQ0LNRNxwW8BhBT8XM/2GFlZymxKxY8Xif6WIReo3Ow/oxp/S?=
 =?us-ascii?Q?tQas86Cf8FdFroJ8X0VKdJDP0gt/IXcoAHUjVwJBYZy3Z7YjZJ6h1ErdXI9s?=
 =?us-ascii?Q?IRy1vgmsTPFhU/C+CTF42AUy/X18YEkL/bGIRGMtSximzslrvpAEVRIlpdcs?=
 =?us-ascii?Q?e27sreFbkFlgkmAW+k14+Tv0gxgOcvKhP6vasy3hGFE4mJ9jDkVek2a3u4w2?=
 =?us-ascii?Q?gPh9kBzNlLe1FJVicqMxGymQ3y7RVZOpjhTXGxI8bPda+2hojI3UqnLnqNN5?=
 =?us-ascii?Q?3VfAXx99DKA1esqHP/KgYi3IW34KSv+/kfco7miTyzCN9visjlA9QQv5ZqYc?=
 =?us-ascii?Q?IS2B10LjbSH1EgDEw09Tg6pqGAx0yHzW0XCKRAZ+TRfjwwPo+7UD4929m02V?=
 =?us-ascii?Q?Gv/1np657eMkkcmxzgtugxDqxfWEp30zyvH09OCJhPfdsOd8/R/7Zdpqg2P8?=
 =?us-ascii?Q?hMzmFCLnWf1MfXJ6i0It9o+h8O7IUnOV1mXcM2fxwFkbSmRFv4tEIHuuWNpF?=
 =?us-ascii?Q?txP+/CFg8NVFuT/+vO/UbmFDI/AB2MKlvlsL+qEgJ+xVGWQ9rWzzbpBMM6bD?=
 =?us-ascii?Q?OpX4KUIGafM2L5j+SgXmAytDFHtv+KBwYcled5coLbFobUj9qo2yoTciOaR0?=
 =?us-ascii?Q?IkcA8fa8qwvEUkNgzRIwxHvsifTfMdQW7tk5xgpg1wrxIV7Xtkl263NPWXO4?=
 =?us-ascii?Q?ZwV0MThdZx+TQjYksj6lmYC9HudrLJkVanfCziNN+wqvo97L/b8VlJ3rWSVX?=
 =?us-ascii?Q?CeEwvUyAVxW2xl1jLLCmgRYByTELLtrMUfiPCgCGJlmNj2ElEiIef/UIRYhF?=
 =?us-ascii?Q?X0mC649bvj1zVN0++ATvV7PoC+EUr8oxhk0DxYIG5KkMgDiS9L/T5TwwTIBP?=
 =?us-ascii?Q?OlsU0UUge55PAUNBQvqWm9HpXqFyObYxnaImX7kiOrCnql5DBm2fqztrFrKm?=
 =?us-ascii?Q?EiodzY8jBPGAHhbqXpiN6IDWLpgbD+378u5Rg3JAYEvTFkhbsyVJnx2CahXa?=
 =?us-ascii?Q?wG3n7jDyZWbzxVwARJB30cxZQWNfcvPEj3hq82m39DrO+1doSsgEPMYNF3Tj?=
 =?us-ascii?Q?pUKkMOswuYB3y6p8f50WfRGZfGomwkkxvrXmrOkUaUeAn0rz0TWNv/KhOUnW?=
 =?us-ascii?Q?MABB9uN49uYjo88JPU8zGcXykM15ydg8yY1DIQ/mfzNa6ssH0rlaXyNDgudL?=
 =?us-ascii?Q?uU4wPujP8I1jfdkrTnh1pkk9Ku7860579cbvPFPUlArUzqAOfULGIvPSTGTQ?=
 =?us-ascii?Q?Et8qBVWea7pFnZnz/Cs6+Jeh+2/4uVyR7t/i1JDTbw7LA97Lqw+nvUHRe3pQ?=
 =?us-ascii?Q?YRplLEhYnr1ObvGGs37rZRFziNwKOSOxjxNBtCOajb0rhxct+hJJ227Kpjh2?=
 =?us-ascii?Q?D94UGpekX3gsNIRcWtE6d9+NqEWE44A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc09cad-c976-4b13-ead5-08da4b83f459
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 08:25:34.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGCYrcvuuxeSK+n7GneK8TX364D/sxr3sr0adpNj2OqcnZv2c6DuBh/sZeLyB+hlX8A2KTu1oazolCWnX3ujhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2945
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_03:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=715
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206110032
X-Proofpoint-ORIG-GUID: L4gUHI16m3VbMmixwlqOLYoL6UVG4iAR
X-Proofpoint-GUID: L4gUHI16m3VbMmixwlqOLYoL6UVG4iAR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patch 1-2 are to cleanup unused variable and return type.

The patch 3 is to fix the param usage description in kernel doc.

The patch 4 is to panic on purpose when nslabs is too small.


Dongli Zhang:
  [PATCH v1 1/4] swiotlb: remove unused swiotlb_force
  [PATCH v1 2/4] swiotlb: remove useless return
  [PATCH v1 3/4] x86/swiotlb: fix param usage in boot-options.rst
  [PATCH v1 4/4] swiotlb: panic if nslabs is too small


Thank you very much!

Dongli Zhang


