Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E39508503
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377235AbiDTJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353295AbiDTJex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:34:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E53ADFE8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:32:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23K8ea8w019412;
        Wed, 20 Apr 2022 09:32:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=OE6wDqOwxtm5ZZe4IBp1HiMiwZ5FDTLXjzf4Kp3jxFc=;
 b=EG9Ghq0/DlKahhRtxnhRQsulRH7z8W2uFz0rTOOlqo8x70bS5jroTuKses2nC6QbBuSf
 GUVz0jp0BrV3TWbfjOk5G40SXOLkgv6g4OVtuNmp5Zv8V5D0NnkK9CvvCDrfNdPdbBXW
 Sa5lMxBTVeUcU2GHgz4Gfw9novfyoUgeYeABAnR29ttonWRR1xzjHLFYkkzB6mdNp/l0
 OgkYWyQlCGFUI03e695DCrMDYY2gWbKqazCUNRcQGTuUPCZGCiTJ+oivzl4iViqtJLf9
 4Satzx5KveM/haJOY6s7Uz/OH0HKdNoFMqMV3RlSn9KQGdcQ7Sh7frXDcx4yJVtxDzbX tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7crca6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:32:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23K9W04G026317;
        Wed, 20 Apr 2022 09:32:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2044.outbound.protection.outlook.com [104.47.74.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm84y4yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 09:32:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeMXJVqPRPZhL8iHFSFIwWbMrDq7eN7ek4Vm45L3JuqwiWJ76jTv3gm3Hb6QMCr+famx59+WQAuRdcmK28zqzPB1xM7Aj4w67isb5NetJLVD2MNel8wdE44MVwVOIxJOh7og9aZrDEp5Ni636h2p0kg2dVFeL7mD8vw+DLO8vsJ7xyTxEMcVnAWvyVoR0JskJZoKMxCLOcuzrTr+t535Pdu5K1FLtwDTxS4Do9bbWRUSeK4oaIPgEBuyWusobs6zQYgb9X3iDzyQcjpmbBE6S8pwkSLG7sGh5u4pOO/Y+m4mglGdG74RXiDYtCFRMyg9M8KfR4FC8CyzC19XWg1Mjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE6wDqOwxtm5ZZe4IBp1HiMiwZ5FDTLXjzf4Kp3jxFc=;
 b=fh9u45UW+vHDSBKfkOJeWZiFPhifnJRh6kkcF9ZfebsQuErtYfL1JVarplfn6YJI3XAnM9aKHw2s9mnRKEX+8LDJwyTq8IMJyxVEr/aYlfrUMb9KoOZRFXhe05ro76CXLvqgIHpfOxnF3h2CIRbPeIQeJYp7WWEdN7Qsrv7HMc2Z6Hv9yslaMbFE8JSjfgY7ioJmJ0SY3R0VQTgHXw2RZigqtYjKFeJDHxCRldJKc5iJTUT4D4UWM3zz5QDCHpZ/YbKTmrPBM/CIQfAGB1LocArbO9PxJDV8m/0MHOp6TJki7zRwVLhRzdQ81pUYr8RfUruwHUKzPdKuSGynASUYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE6wDqOwxtm5ZZe4IBp1HiMiwZ5FDTLXjzf4Kp3jxFc=;
 b=I8WCj7rGDUiNwqTraIeh3otzDKarqLP9Bii8dbBUUREJgx5T4dvNxaKViu1+wRRsf5XxRTwQvFlAFaZX+sLOQIIDXRUyi9U/MBXKkKKEKasQn3PdTKf9JIE0h5r9Bv+mrHeFsnyn7emEGhu9QGm9zPYtmC/ACz0rexYgOTDFo7w=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4749.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 09:31:45 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 09:31:44 +0000
Date:   Wed, 20 Apr 2022 12:31:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Atish Patra <atish.patra@wdc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn:
 potentially one past the end of array 'pmu_ctr_list[i]'
Message-ID: <202204161940.BrRZvzdD-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0109.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:33::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63837b1e-77a6-4a07-6b9d-08da22b095b0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4749:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB47491A4446A5DCCFA7EB75E78EF59@SJ0PR10MB4749.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YG/8oA9+3chQCojdygs7W+333mX133z2xtyExKfaif8LS3H1wKm/AzpJeu+pMM//Uddgk2draOoqOMq/7SwmRkyWA50t3WlPWxINDqsWualrsHV2hCKu7J9LGeSeGoqa2o0A29P2ZcUEc13+NIY0Nuro4El8Gt74u6d3aAisTMGBoHqb5WkHdelm9Ue1OGwE9LgtjK31FP0OCfaAbsYdHlpRvZS5jAyhkQU1sKja7phNh9gKpxwxKRmS048eDZgxBjWUoMEwOrtRPSOKsJMK59EIo/dtGQVGwbfrxMp6/PrL86l9znCNeDRJCJ5cuJe6Wt93xGx0ifk8c+o/0gig4jgyuvN35GcbAwZ1YwrmMdOSE/zth2gbN5zYDDhYNoOKsRRLR1t7dngKQcZ2MrOH2l1O6yrxvI5pmvdUaflPmKNK5H+tc8wv+qkU33lH1j37jqLqWZ9ECbekOOByhGDNyiCZzZDmK+DS0EcUzc1xEnRXh1Pbdzs7nIDtP9BwhODooN+YzXkgAh0UDcNYbHYKP7yvBN55TrXO8nDOCIZKI7fgPtpIlzTGUMOH551tWcRcOdE5ZPRq+wnwiTb3QWvWoMU1gn3F0d7MeCL2m7U5aQhE2B42gUH3XjJS4df3lxGK/Wzt+30TTsbbTwQzKv0FOhrhFe+GfBHe4YZeG8xWPEQMVcdHsgx7FKAv9gU+CjQdJre93kVrWaNKbKSNCZ9VhzfjhLy9YjZt5zeo6xdReHuPxMRhSmgAdJ08CSd4+46Kr+u5Zm5nf7Ttcut7q5xj2bhuaqeenJIuN93F08S4E13lHQrTcrlhHjTijLRZ8s90+j45w3p0CKwrVkaLz+0yLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6506007)(83380400001)(26005)(186003)(9686003)(6512007)(1076003)(8936002)(38100700002)(38350700002)(8676002)(5660300002)(66476007)(52116002)(36756003)(316002)(6916009)(4326008)(66946007)(66556008)(966005)(86362001)(508600001)(6486002)(6666004)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lmOITkIg4y6faAuxTzF27qGSkmF5n4xqAMQoXkNvFEyli4Z9VOPMk+At59kc?=
 =?us-ascii?Q?N6GZjA6yNqKu0S406NhTFVpXwrVIu66BFZMHNODlA5r/XcfPbTuXeO5skBpC?=
 =?us-ascii?Q?yZNckVYXaRYZUaWx0T6zUk/aJnMhWhHOcXXAIqq233XkR/abZGu0UszT3sk9?=
 =?us-ascii?Q?5RVHkds0xK2Xmiae77Kpz8mdgcFDIbO+NoS8jBnipgNdomIG1kp6cFaVGjIZ?=
 =?us-ascii?Q?RLfnREHW4Ui36BReHU1DkqOF6BDgY2We0+5wsX1CTXcCSthY/+ZbrWcpo7S7?=
 =?us-ascii?Q?hja/RyiSsC9KKvocjcqBD64YZ0cuCjZa/tabT5LsnKnHFRaM8/6ZL+GEOW6C?=
 =?us-ascii?Q?vwbUHeR4HJs70r3b1OKzam+VjcLNvAxQrEWK+FnriIQc3q8lzOOUinEPjyvb?=
 =?us-ascii?Q?4uEmP2u0cNbkAVxbN2zxaRAxW4Uou/S9+rwB2XmriFSBwHGJJGlHHCnLaRcq?=
 =?us-ascii?Q?dIE5efvsUu29foNywtwy2A0fYyUQ0Gy6k2dInQImrxYeEK4Y4iJ0WPIrlZCS?=
 =?us-ascii?Q?uNygh2xRbuuBRc1mLSBp7lu5ZTaSLn7/wmL9sTvFuNjzm7kyHtmhShAT2ntF?=
 =?us-ascii?Q?9kvBdUzgd/TK8jWUtieBNaO7Ab0AMMqiQnDOxaidYLRwOTFJKjl08oLmTjja?=
 =?us-ascii?Q?MgibmY5Mq62qvFRwpY9K/JkHI4cqWI3gRl7ZyS3HpnKO1TRI8zFtjODpNl85?=
 =?us-ascii?Q?lTUHNTBKZYnqcwRjGi6D+PDtBlzvF9gc0lNbTC6e+uL3Y1lm6Oti0KdKdSCW?=
 =?us-ascii?Q?mnWcvtNtaaaHNqgp3CYwuT6uZobsv1oYSKJDFqAP8caRon1mvz4Ax2RVDl9N?=
 =?us-ascii?Q?BPl5XW5c9BT1KtKB5U05rxZ+5lmj+Pz2uWSaJPW28c9YOBb1xpSNp0T6t3yw?=
 =?us-ascii?Q?C6VWmmhGqU2MQun5vepre6Lb6GukQ3y7uOoriua/E9GPbATNqfkcT1hH0ysz?=
 =?us-ascii?Q?0Wl5whSF7YsczUFi6cX8L8EkYwjc0v4S4asnlEojkENEII6VTim+bEMUH2zr?=
 =?us-ascii?Q?LjHu43AKOGL8jXW5pM7/M4uFgJ+QAfvC8JS0dlUATjnteZ9Y5+g4w74SAhDy?=
 =?us-ascii?Q?c4O9WLaoC9d9N4Rdvl1sNT2FdfQSY2+HjGstOV2E6L9PRoKVgqz81Tma7jMg?=
 =?us-ascii?Q?DKUML610ZJRvgGg4/Kmkk0KRhVX8JkEx9/DNBVh2dq02M2xNevAdttAkFO2I?=
 =?us-ascii?Q?RjsHmc6GUCJnwxCiaxYjvwpwMRi76621D5Pe+TCGhzXX20bNVYLfzHmbAPp5?=
 =?us-ascii?Q?wi7BIbGdKQ+e9EIpfcaSytI590CVNxhJF12E7HUNQPFzKRDVi7QATOdDg98B?=
 =?us-ascii?Q?k1LDrCQVlJuY6gUgeFu1aKmqqTHaOOBuoRfeHeWwD/3B6GyrbmVvNDqylIPG?=
 =?us-ascii?Q?YyaIto7abH7ad0C4KNx9+aRrDNI8n5UME/ZaaZf+EAjQ//+ZrwkQyoftD6yf?=
 =?us-ascii?Q?QLY8VkLIoiTY1/VZW6Aua2HAg2lmzsNOBwRxjPphnaP76qn9yf2GrUJnKll4?=
 =?us-ascii?Q?qakIBJWiCCZZxrV0Y9l6v4Wg7M+66B2m/goKxDVEsaBuQHBgSrIOOwDXHQAP?=
 =?us-ascii?Q?uZ7LuWnzgNyx4J5ZWyYhoJYDZTIYp2d6ZbM05rejSq8mnEiUOjjCK60UTWXj?=
 =?us-ascii?Q?5fRcCORrSVrlly98nA06wja8fx8s0mXZ0BlBHMIUdHjoq9OjYyMZ/7fU+9ke?=
 =?us-ascii?Q?4kiyuJz9ukSz1OfLVVZoS+nHEeq/J6BPrRa8plBTtpv82qznr/AsuHBGZLrp?=
 =?us-ascii?Q?yFTLL7VAhJ6SXs+PrtQ/ADIywHyB6Yk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63837b1e-77a6-4a07-6b9d-08da22b095b0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 09:31:44.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8J3cr/gfNUoQL+YWoTvb9BYRCtqz5KSXxa8LXsz1gveSt1pVD427EFw1eZlJyqKyflbHd/8CDu5erw5fNN1IQqR+4waT9gvrrN46S/zNO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_02:2022-04-15,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200059
X-Proofpoint-GUID: PIfUOi_T2reO2TTWSqd7Wx6zk42mB_j1
X-Proofpoint-ORIG-GUID: PIfUOi_T2reO2TTWSqd7Wx6zk42mB_j1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59250f8a7f3a60a2661b84cbafc1e0eb5d05ec9b
commit: e9991434596f5373dfd75857b445eb92a9253c56 RISC-V: Add perf platform driver based on SBI PMU extension
config: riscv-randconfig-m031-20220416 (https://download.01.org/0day-ci/archive/20220416/202204161940.BrRZvzdD-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'
drivers/perf/riscv_pmu_sbi.c:464 pmu_sbi_get_ctrinfo() warn: potentially one past the end of array 'pmu_ctr_list[i]'

vim +464 drivers/perf/riscv_pmu_sbi.c

e9991434596f53 Atish Patra 2022-02-18  444  static int pmu_sbi_get_ctrinfo(int nctr)
e9991434596f53 Atish Patra 2022-02-18  445  {
e9991434596f53 Atish Patra 2022-02-18  446  	struct sbiret ret;
e9991434596f53 Atish Patra 2022-02-18  447  	int i, num_hw_ctr = 0, num_fw_ctr = 0;
e9991434596f53 Atish Patra 2022-02-18  448  	union sbi_pmu_ctr_info cinfo;
e9991434596f53 Atish Patra 2022-02-18  449  
e9991434596f53 Atish Patra 2022-02-18  450  	pmu_ctr_list = kcalloc(nctr, sizeof(*pmu_ctr_list), GFP_KERNEL);
                                                                       ^^^^

e9991434596f53 Atish Patra 2022-02-18  451  	if (!pmu_ctr_list)
e9991434596f53 Atish Patra 2022-02-18  452  		return -ENOMEM;
e9991434596f53 Atish Patra 2022-02-18  453  
e9991434596f53 Atish Patra 2022-02-18  454  	for (i = 0; i <= nctr; i++) {
                                                            ^^^^^^^^^
The <= should be <

e9991434596f53 Atish Patra 2022-02-18  455  		ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_GET_INFO, i, 0, 0, 0, 0, 0);
e9991434596f53 Atish Patra 2022-02-18  456  		if (ret.error)
e9991434596f53 Atish Patra 2022-02-18  457  			/* The logical counter ids are not expected to be contiguous */
e9991434596f53 Atish Patra 2022-02-18  458  			continue;
e9991434596f53 Atish Patra 2022-02-18  459  		cinfo.value = ret.value;
e9991434596f53 Atish Patra 2022-02-18  460  		if (cinfo.type == SBI_PMU_CTR_TYPE_FW)
e9991434596f53 Atish Patra 2022-02-18  461  			num_fw_ctr++;
e9991434596f53 Atish Patra 2022-02-18  462  		else
e9991434596f53 Atish Patra 2022-02-18  463  			num_hw_ctr++;
e9991434596f53 Atish Patra 2022-02-18 @464  		pmu_ctr_list[i].value = cinfo.value;
                                                        ^^^^^^^^^^^^^^^
Off by one

e9991434596f53 Atish Patra 2022-02-18  465  	}
e9991434596f53 Atish Patra 2022-02-18  466  
e9991434596f53 Atish Patra 2022-02-18  467  	pr_info("%d firmware and %d hardware counters\n", num_fw_ctr, num_hw_ctr);
e9991434596f53 Atish Patra 2022-02-18  468  
e9991434596f53 Atish Patra 2022-02-18  469  	return 0;
e9991434596f53 Atish Patra 2022-02-18  470  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

