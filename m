Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD754EF26
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379681AbiFQCKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243043AbiFQCKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:10:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987AA64BCD;
        Thu, 16 Jun 2022 19:10:43 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25H0NxbX032726;
        Fri, 17 Jun 2022 02:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=NR4UCQCemJYUaKLG9/6pfJ4VrKJcZCgppyXTGopxheU=;
 b=SGX3i73fcNOwrt211kzx5rW2ggfuuvW8fgFO5d9ZpdY7gH4TSvtVDSnHvS+T9zvm4l3H
 rxkSueEcRRlKkZJx6W5ylULRfQDL4SkB94QUZcikceM1P/VxT+plqjY52EieRoZ/x81L
 uJ31vfpcemY4Lc81w2Aqzb2YluMkAUGInCvtIFjHxHM+3bNF2YReYfuPv7adXmlM6q5K
 0/CUHf2QS3ZA+SdgHNl1l8hzClhHrV4MD+RUEJW5lDRN2bKWEmo/SV2yI/1zrTaA/WcN
 Jqis3ZH7XleyZpQA30aLED7WTwHaevr+DBJhtDW3PfnuLj5zIYERlq0MchHwey5aVtAH 8w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2vupc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:10:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25H26JKp017830;
        Fri, 17 Jun 2022 02:10:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq320u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jun 2022 02:10:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhmD61Y5mZVMEDO2wFZngX6OgUH8JNWmglxqL4Mja5ZiuLqdEYPOi3DNAbb4FZy3/EFlwNB5ycW61eh8wNQoStRObK6yRqPCEsBSB6jwrFozn1M3RaXgDR3czOq4DIfDqZtmYlQD3a8D7FNacuAY79Y/RtNFT+pBRP6aa8h+NNvq+TymCcS7scIKHBxaapda30IFTYXYmUfuvuXP1INh8+22SB95EVuYjMBkdEsUGvxM3DcHWRNo5w8kgPuRJVOqMaDY48ADQvF85P+wNiK5Bo2BvBkwiWzHd0zsnT6nfXVfNrQpvoZ5hlw764pwZKvT64g+HggbWNUUEwdlX9xARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NR4UCQCemJYUaKLG9/6pfJ4VrKJcZCgppyXTGopxheU=;
 b=DIbo5W7ONfGX3EDr0xXxPRo6DQKGkDjzsg9PU5Rh52m3gm5N31qIsYznG2iTLsp5g1dnur4DKM5L6JFy/y6qlPOHFQJSTAf3lMPVUXvD/rwnltLYtJPyBLY4iTACLDQnRj41HwlEhwFVEZeJXQe3s779jM12rqPn41CPdZnvgXiPyMO5Czu1cyDHP69pcUgGdlSZ3PdkbHVZ84tGR+nKHDWxFrPSqskoQdvOjJNobPx+gYRqX0kog3JY5ajTcvd1k0FM9BnTshvWce3u6vhsgjrEIzwVtcnwdv8LbpuhHKVRFIlptO7bJVeNwC7KmXbI0NbQmRFD253ckIgddWdyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NR4UCQCemJYUaKLG9/6pfJ4VrKJcZCgppyXTGopxheU=;
 b=l8KXZ6nSy0cG5Q28jQI9Mo0aghySR1e7qkvi8MmmHp9t7naVtQQ0sYKTnfAbXLq9dLpvF2hNvAJxoG5dBO4e9CtRql7x8V9kbb0l1p8XkRd9K3GC3SPPYukr8jpmUOuyoLcV+VyQaouNq1ooPpLsn/HQqwvvMKnQJNmZRqktt/o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Fri, 17 Jun
 2022 02:10:31 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5353.015; Fri, 17 Jun 2022
 02:10:31 +0000
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>, <peter.wang@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <alice.chao@mediatek.com>,
        <powen.kao@mediatek.com>, <mason.zhang@mediatek.com>,
        <qilin.tan@mediatek.com>, <lin.gui@mediatek.com>,
        <eddie.huang@mediatek.com>, <tun-yu.yu@mediatek.com>,
        <cc.chou@mediatek.com>, <chaotian.jing@mediatek.com>,
        <jiajie.hao@mediatek.com>
Subject: Re: [PATCH v5 00/11] scsi: ufs: Fix PMC and low-power mode on
 MediaTek UFS platforms
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r13onipf.fsf@ca-mkp.ca.oracle.com>
References: <20220616053725.5681-1-stanley.chu@mediatek.com>
Date:   Thu, 16 Jun 2022 22:10:29 -0400
In-Reply-To: <20220616053725.5681-1-stanley.chu@mediatek.com> (Stanley Chu's
        message of "Thu, 16 Jun 2022 13:37:14 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bf2d0f1-19c7-4a07-b8ba-08da50068e76
X-MS-TrafficTypeDiagnostic: DM6PR10MB3580:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3580C442D655CEB7EAF58C288EAF9@DM6PR10MB3580.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMEu5hux/8rNHe0KoTLXzZ6b8fNAQOFKf/mTKmG1n/ozPZjpmyY4w9AwkXFEbm6XSfJo8O3fKZ+FG1xHxOh7UpQkOYicxw2AEE3T4wCO6DhRDLCwllMCtUfeiWVF41hTfsDmws0qDim06P9NJIufqGHhqdxxfi78bkEvIZ0PDW1VTZwCLErynF5z/WPxD1Wr0oskfsovLctfTkvwYQq+DomdvYlKk3VMASfkXv/7EP/X/Rkbwb3T/Pu2MQFPZ6CzaWSrnvNlQ642GJshe9xTdetk3vGSP7eBzOf6C2DaB9K7m7nbVFDiV7AzRXrIhIOPeQu/jo/MSyf1gXKiBNET+TdVix9Wf/I6bvEkEJ/5R9jqw7wFK7Gihg7a+61wY0mKn3lljY8wn8gvaVzJgsMuMQN3MrtiXJu3N4fXFdZalvSe/JyM0xjkWhO+vt3aeCjtuXLEWpH0pnpD1GaatbVqqiTyKE5mcmy6vzgPSSxpyN+pxisc7XkVCsPD9uR14cbe+i7NRE2Tim7E56XTEynm/CJF6aLT+ETf0i1oipffT4GnDyKm8aF8zBwTDwVsqlzb+00FKavNJ+qd/MjMxGKESjaR7R83MQpsnxJnZJ0E63hYe7MbsLBbWdMs9w8STmrAV8XjECkiXXhwRq+MuKX3b0xZz70+VwspkOaPWHNmmFzHerFdCEvxyFLb8QLb/C/SsfFJF/Xu0uJY1h0XuNehog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(86362001)(558084003)(66556008)(66476007)(7416002)(5660300002)(38100700002)(8936002)(38350700002)(498600001)(186003)(4326008)(8676002)(6486002)(6512007)(6506007)(36916002)(52116002)(26005)(66946007)(54906003)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOJFIsJLov2C7ecuFSSfY6CawABSsZAdRjVrA6wVtQ01FGw7YpllkEbm2CVn?=
 =?us-ascii?Q?pIY6jqU4JvOaM76IEwhJPRvQ1C7TqDOjkxRqsdXX13j27o1nAj3qXr+44ka9?=
 =?us-ascii?Q?cmk/vPm/X1WCNpBYASEhMKvgbZrp+JWoR7xelD2FRxU/zTUTbuCYcDTTWV7S?=
 =?us-ascii?Q?QFVLFZkWKZ29LeNXngfnLDVhcFVPkxyNAuYLtYiCn/IWK/+YuhxUaAf0PzMU?=
 =?us-ascii?Q?iM9pZxOS6Mn80DRQXJ0ExHAra/loCSGi+/bIdASRzm8oNCTREYyCxTRRltNM?=
 =?us-ascii?Q?vCoXYCxRcIo7V07Lis998RQcjMB8/bb0lFbmU4tyxboA+f2qM5dmYAK/4Muo?=
 =?us-ascii?Q?vrxgDjBR6niPPsuDApjTNN4Jwf5zCRQliDG4SxPUfe5n0wd4qZ2BkV2NLRCU?=
 =?us-ascii?Q?x0q0ggNCXOxBmBqHuoK+nO/ofetyf3NqClh8KCn3SYfYLemqXh5HWF3qk9n4?=
 =?us-ascii?Q?06Mwx5MZLgWKUF+NKsluO69JJOzHJAcNW57K6cGLRAX1s0+SzAct7UBozsR/?=
 =?us-ascii?Q?R6uQBHbhlk9EA/4m8c7TviVppwHEUoxK8bC4HdD9UPbfjj8FT5xdJQwtjbWX?=
 =?us-ascii?Q?ZxCSqEEd7oWvaoWRz9tUiXwNu8YqoZ9GNxweCCIm7vLaCwqkDpYRUAZX6iBl?=
 =?us-ascii?Q?D3IutvoLmRFwOVZs+oIax3iG/P9Ts/toN2zsjRzSKCDVpEZ4e3uzoRXRWCHZ?=
 =?us-ascii?Q?sjFz4epCupusqmVpasFH0eDwPWSJtjJaTEvIHl2tkO34eybCbyAj8FACiDuH?=
 =?us-ascii?Q?zqE/3d5yPrOaMveMzCFiyqu3IlsZCu0DynuN4a5VLVBep1ludZFF/LgXS4S5?=
 =?us-ascii?Q?exrsf8qUCAAljRWJsQF7ux7gQT8cRYuJKYqLAmGOrwF2mKXmeSWOacNUdGSn?=
 =?us-ascii?Q?BmlRlqguJoRDl8XGb9Ao50HkXN+TzvKUX4O5rdC+ZikuwgMvbOpzZEFQ5edW?=
 =?us-ascii?Q?GeVNs0XKPimh1hkSREnFGp+uBfHfRHziHs6taoaJ3E5KGu0K0JonozvqXsG2?=
 =?us-ascii?Q?+UYXUoCIBqo0g7NrcebuN1uGC+hQpRo5awNty4eJpPSzlozw2Vk7hWnpRabx?=
 =?us-ascii?Q?zNRlidrfthas/FXc5aA4vpNhYwWyCHPWCb/X9bPHj2H/HBqfFjm139+EF5dG?=
 =?us-ascii?Q?MxsSf8Y3fnAIlVH4+SsnkmUTcUxV7W+tz5aJEFLKX6dtJGmo3vPYJ8swfEVb?=
 =?us-ascii?Q?tPnIEu6mpAVon1SniqWFZ0gr9TM5NUOdM2JzsP2sd3PmJVtycSp2QhogXTTE?=
 =?us-ascii?Q?posoiOIYT36/HxJ8sFOdZwMbF/9X7ZD4zQS+AnnB2VNekQbtm1MGf56cXpLS?=
 =?us-ascii?Q?a3pPYhitw6SIPGa3ZcU+qolGZ4SpG1WWk7+Ku31V+hutDqBHMszaJQNNz0se?=
 =?us-ascii?Q?yv4y6+r9DjlwSuu2hSHSQJn8zU04engzV7msRcLdxzv8qV1kDf4vq1NvLhgH?=
 =?us-ascii?Q?zXoQ6VL4Xz0awlpNq+Jt2OC1fRFiXwXNSMvPeH8yL4V1rO9X+/w2N6gkA150?=
 =?us-ascii?Q?hwaZEM0rtGVMOOrnXEUAnmXFTb/9UQe0syT7YFIYcZrWjBEhUhGnWxATEtpB?=
 =?us-ascii?Q?W/0fEq0Dw56D58SxKoHp+aPdhdU0talqp+TDwOK+fBBOxyI/7UcJ4zvDST2O?=
 =?us-ascii?Q?TDG/1xLmlILcfMbGNkhP9KY/3UqcDIujr85XomD8Ew8FNtZoxlMbybcXki5p?=
 =?us-ascii?Q?+BmPJgiGWCuWXuqKbC1TF6pfEjm6v47gUotnkygl5iVOyXo7bpB0LkjxaLe7?=
 =?us-ascii?Q?39uGuFms4h5aJ7OSNiNPlBnmjAwW58U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf2d0f1-19c7-4a07-b8ba-08da50068e76
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 02:10:31.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: arncSB0RLdkjN9RXZmEQkRMcVVjHx34eAS+8luXcZGCmLN+svj/rfbJm7oBzHsVBVSRAYDFaV7DMRYb+GlQAwNBrU5rvf+cZ1LKwOE1DSx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_18:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=690
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206170008
X-Proofpoint-GUID: qJdSilZr1u2s-cxkBfBBId9zviBzBQC8
X-Proofpoint-ORIG-GUID: qJdSilZr1u2s-cxkBfBBId9zviBzBQC8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Stanley,

> This series provides some fixes on MediaTek UFS platforms, please
> consider this patch series for kernel v5.20.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
