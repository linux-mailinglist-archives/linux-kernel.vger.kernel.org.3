Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC37542235
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiFHE3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 00:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbiFHE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 00:28:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971B38558D;
        Tue,  7 Jun 2022 18:58:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25806CkN010581;
        Wed, 8 Jun 2022 01:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LMS5+jmGOMU+IIpc3hAlR7tTB96gOLA9Smex3vfXoR0=;
 b=096mEbwm1qtItpDqR3EdTnsyzRPFB948NHgJAPZgtoPI7LZl6lxM/fjRn39PF/lvYjsh
 quGxEYCpIbfvNC1GzHwy8vU3ubi9iOTnFcyq7eXcqFTIoPW5UlMiTeByQmVo44Wkevvk
 vUiIc2hZ1sNKBMuA5Dw+yIpbkmnLeOvObtuvdqDaWNjNqFRCO6m9YqmF0O7zGHxgrQoH
 MBwRPr2s0zd/0uLuH5+xX45rjcRrG2LEDvIC2/+i77TPPuo74/14mmVbPYvD2ZJjIQ0k
 u/8aBbfA7meXE6lPYbS5Wy0kNFa371StqjlWdqILopXH8UhCUGxZrx7oPQKq2S8Z5GyB lQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ghvs3an30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 01:58:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2581uXea019306;
        Wed, 8 Jun 2022 01:58:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gfwu33qhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jun 2022 01:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmL5HvV7KZwZItJs3U/EhnY2CYhKCxG8VOsZ7mwbKzAo7Z5x0gBeufaQmp6JweqjWXninoac/lw2l5Nqns32mphYs9oO/6qnlTJtAz+81fgnGNKxxZE5qmE0NuUtHne5xi8oYclSeC53qVASU7VrEW4i8vdGHcYhMnPQo3eQcHtS1t99fwyFQ7X/lrcXU/ONBGDEC+qiES1GyAEpZF2HM/tHAWx6GrNAs2EHTwyYiEX9hbOpOI3OGfUajUJcMxyx5S1/7N6/JnGM/gu51TSGofHMRgsmm1o1dZYmO+eGQPcHtnraDHdbvA+aChpODNuRMe07UnFYaAmGvMzJp0VgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMS5+jmGOMU+IIpc3hAlR7tTB96gOLA9Smex3vfXoR0=;
 b=W2D3g1dduCaNuto3ovwVt2TyCid59f66FBBhhXwvn05SnxZQZg7vbOlw+oQRUIoXuhUmvm3N8mTXxhXr11yn+W3+ReNz/Iagrphp2Vek4x5dydn3ROTpprw+KuPIvNtkaIuG4HRG9koCMjyMeJ2E5ErpLve0PWKHy8pQOC7hFesLoZhjQqOqFBlDu5yQjuyQkjYoc90xdKJlAa8/E3zxAOTLZHg61dscIYUKtv7eUomVJFU+Lvu5A1u8Og/1KSnIu6iPwr76oMu1J/jt6Hi2wxMb/BqmX/43dYEAi5rk3+OZgvVFdgiVk4BS8KLweW6ogquti43YBdDUSHRk65g0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMS5+jmGOMU+IIpc3hAlR7tTB96gOLA9Smex3vfXoR0=;
 b=KAh2Zr69l6ZJIaPVdIbOS9xOu+gg1uTqEFtXwrq8QTGmSN8JbI8Y4MUGcSC69CUh/+BcP9f1W9f9FkS7pLXpCgIQMl4GZWRa3rdTTTUzfCxEGO2iR+16sEXWLvHmdC+XbiV9e/TcggiK9ZhMhab94m1gH+9ak4Ss4PbrpwtQGlw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:ac::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.19; Wed, 8 Jun 2022 01:58:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 01:58:22 +0000
To:     keliu <liuke94@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lduncan@suse.com>, <cleech@redhat.com>,
        <michael.christie@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <open-iscsi@googlegroups.com>
Subject: Re: [PATCH] drivers: scsi: Directly use ida_alloc()/free()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8tbykzw.fsf@ca-mkp.ca.oracle.com>
References: <20220527083049.2552526-1-liuke94@huawei.com>
Date:   Tue, 07 Jun 2022 21:58:20 -0400
In-Reply-To: <20220527083049.2552526-1-liuke94@huawei.com> (keliu's message of
        "Fri, 27 May 2022 08:30:49 +0000")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3039eb0-465e-4368-a309-08da48f25e09
X-MS-TrafficTypeDiagnostic: DM4PR10MB5943:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB594380E054A2C4771D5F0CE58EA49@DM4PR10MB5943.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS1HgI+QW71DukY5zuCp1C1fQEX6pIyux4iLwD7HXG1d12XVsl1QFAP3iD9j8U3M7meN6H/x8V0s/sAXu0pBrAjzNqvTLHQg68d3cf99akqYuLPSAedRCzbtJHQEVVq8CJAIeLU6lSMr3AjdF/uRxY9V34gQPeEyvCKHsjfbmGaPQK12kOW+bG2uKatbQwkNHGsminMrBb8fhdvr2zqRbKedhaN7TVGvWn8XxWKWrbMd02TOiNDls22Nxb+7OqQ6Y5HgVFVRsP3wQ8hXAiUK2VYETEW5WzjBMV3MAxBd99kcQPcrzULP5ifW7QMpnvDEqgxgxlCJfpH4zSip/HHAWwAXQW9kIlpH1DP8sivhWdBNxnFmxP+/QEtNYLR2TYAJ0mKLzRNg15mF4VNMnFQY+TViRld8A7x5kImq52AGf0PqTy9w2bFhK8NQSpSi6tEmT5OaUk1MK97O9EVRGGDnWA9NXSIk0QNnq7gwgafyZTlDPpoO9xJubu8KhxRYLyBRgMfYOMTmNNpdzuDd9472ZSlGB7EpVpxGDCIDou4OFY6jLqFMHq2CDa5budUHaO032AXJjmxTXCI3Kxt3e0VyBTxs9Bf27MFWPoqwo6DLqJofT3829SyfTKsaTzH85/p+CFd+o+1m7FGKUIwkVs3Cv0+E5C/O4OYwJo28iViJa51cFNPZ+8aM+V6KOurgd+mQA03wPSaH1UtHFe4aaQMnCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(26005)(66476007)(4326008)(5660300002)(66946007)(38100700002)(316002)(66556008)(8676002)(508600001)(186003)(558084003)(36916002)(8936002)(2906002)(38350700002)(6916009)(6506007)(6486002)(52116002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bIpmiyI+9XOJ4Pat8+nMG6SdPl9fwpMqFya64UKMf/zeNnZ1aBnoHoglNbxX?=
 =?us-ascii?Q?4j/Ios4GOBtkXIrTmkV09TnRexoRbCi8XCrfW2O9Uqt+qujcd1vv4M8LTPfN?=
 =?us-ascii?Q?/3BuN1CO/w5PGAxcJVWBif/poFocjtbaXtAy6+g5vhiOemrjVY5qvxbm5DPi?=
 =?us-ascii?Q?PQuuWWhCm/TKo8PzfilNm940crt9/HeIhucRz6rdfY5E875UvZOOb0A0MQ6A?=
 =?us-ascii?Q?tNc5auMIaZlrqq8s8WoBiro/ugDBq2mWVBcZDFPOprwRHDhZLugjvogXTGrB?=
 =?us-ascii?Q?yODXNsMTIC3/eFWRB5uMCCQw07jwX8Y9UK81lV1H9DZqfEYGt3EfAtUjmwfP?=
 =?us-ascii?Q?9xKIKGmq2B69SPIUNAhFj0cWtPMhyK2JO2q0JDuB7ThKyp8pQs9ZPy6I9gVP?=
 =?us-ascii?Q?E71MfB0cg+dPlsHlabsi6v3IhdPYNhdZfRGt4W+AZW8LjBIjVD1X6WKXGjcF?=
 =?us-ascii?Q?fxevFk1szaIXs4y0vVDjoCWXUkfK2Vihb1J3wSRSexJ1dXo/8kdyL0eceLc0?=
 =?us-ascii?Q?apv0mseJhhsR5AspcL1kOtV1EBZUFfN8AcwoYId3RohOM9QU+Hg75uOrsfyr?=
 =?us-ascii?Q?Eacf3lVMAK+yX+sBz+voeA+ymuZnVrNYu3NCFHqmOENkIuZTcuog0zIEMQ2E?=
 =?us-ascii?Q?44bxLqtQC6DINTb9+dW4g5hLKYuJHipFurBRgp+HOToyeGj+yp3P9KFwYVtK?=
 =?us-ascii?Q?promNb0pmnuqwuOlBKnhN6lcBgu4OIm3N6iryACNHrrSgmx9YFfv1PePK/Jn?=
 =?us-ascii?Q?hcPiBDeKK9hDmymfaN7Y2TUZ45w3h63FYDOAPIdqBKX+nApnefps4xWZo0iB?=
 =?us-ascii?Q?xQ3XQy/x2mYREwuLwLPdpvSjOMoWBLgV/VXgVCo98BiCIyz8dycmSzre6X2x?=
 =?us-ascii?Q?P+8fvKdgid7oCUbrdYQRdOJUQ2bELF1+szoIFMZywRFzC6WwWJ/A3BqLTwhC?=
 =?us-ascii?Q?m05tbrLHe15HIKUXlWB/WcV9dfauEHKrSGQwY73UR1OV+xMi47Q58LylES7y?=
 =?us-ascii?Q?n+Tn+nGjSH5MPmACXc7C8UVffkNkem9ZepartxOklXxrMqi6WLGjwrVnSVrl?=
 =?us-ascii?Q?Lj9FMx/HMxCH1epJYSdM5S7Vl2dJ/v3hMhmQqD3/jDtF6dgEIs7I53mPtY9x?=
 =?us-ascii?Q?HY/Mk4xy/7O/6s3V6s6nz27iNfG+z4BqHo2eDC1gtSd7nhapUkpKfnhwFvW1?=
 =?us-ascii?Q?DMoHfLTDqPyqoSpazaUNKrzlz/AUW19UcLnz8axAOpgD/jrSNf2BhcMq5InT?=
 =?us-ascii?Q?XksEOOZI594rJZ1haVQFSPQpvduSej2lMfm7zQJe4cvTbbhPQ5TQ23AaLm/K?=
 =?us-ascii?Q?0UtPjJg5yfe7leTLooPJ4Aksrj66NRr8KSBJeQhc6p8qekPg2b6euHzZjZ1o?=
 =?us-ascii?Q?LZkFGbKzuW0NbwZiYKiRT3Y49MDbzRzoU6+HfvU/uyWYEBgaPDSEocSeAOCL?=
 =?us-ascii?Q?hST7OmXasygyCezAF98UviSknLZZtV3Hw2VvCfP8xkKVwBwKR5FozdEjvaK+?=
 =?us-ascii?Q?FtbmEYUORQFTwXGAtjdO9pra5u3G2uA+Yuhd/IDNAUJxUAj4sPQt2pw7E3jD?=
 =?us-ascii?Q?hbyQ41x96nKo+upVaMezGgDSLfqMA85r+Skrw6rkTO+nOKwppSwkiYm4Ynpz?=
 =?us-ascii?Q?ACBnT2uvdEO9ObY0YTqL2jBLv0BVfWMN0fy7tGkSW4E5QV2fk/RgNWdofwd5?=
 =?us-ascii?Q?mIZ7NuA8zucoKH+Sb3KPahUMx3Kgn6pWum4Rk0F6JiEjiIbpYq5ufHKgOhXV?=
 =?us-ascii?Q?LRcft1p69OW50LLKf9O2rmH9fIVZ83Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3039eb0-465e-4368-a309-08da48f25e09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 01:58:22.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YguiMJIYBuZiToofWBto1OwJpqzYVGq67W4lUHAASSYCKgffHkFxIOPmq+liVWU7COBabnto86g43IevBtS11nISkfc4xxE3WmNsvbibxe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-07_11:2022-06-07,2022-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=303 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206080007
X-Proofpoint-ORIG-GUID: WBO-A4piivP7fcQ3y2Fwq1v2nVjYPsKC
X-Proofpoint-GUID: WBO-A4piivP7fcQ3y2Fwq1v2nVjYPsKC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


keliu,

> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
