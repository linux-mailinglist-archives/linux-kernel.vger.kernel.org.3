Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C314EDC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiCaPTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiCaPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:19:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C56211ECF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:17:19 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VEnE7o030446;
        Thu, 31 Mar 2022 15:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=eDn/hZvyGQJbK0stDIdeIIFUgOjbW7Z7dEf1Ep5O2tk=;
 b=VI8IIy84+GjLP9jaJFj5LuHqjqgZE0T+/xMbiyEJ3ihfLyS85/EjM0GpGe89wpI8/bqB
 1ZbYob1k4J4piF0Vu/5DFn2NrGgn0N0bMXOwOXFp0nlRuOCEoH12ycDUgg4Hv8HZkLJf
 ugwLMtZYgVGGh5UhzoUxeFAvB91hux3MK484dDu5hxJKBwrPLcMLUHCBSs2gD3b2A53z
 fRWcSu3p4A/mn6gK1JauRnggR2zlennlSecbDHjTUs1FWgc/6CdKRCpnSeGt/ZbgByw6
 Q6uZr/+jMBcMMANc3+LWiAwJsOu+pW8+cSsboq+uEPO9nIVXusi2wz9wh1LNR6vDsGhU WQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0mp8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:17:15 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFBKKm026135;
        Thu, 31 Mar 2022 15:17:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s94y0f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bAzzxzAtyTGyGkgtVR/Oo5lcosJ/pinrkr5vR7YLoApMHJC6m+XzG1xDTZ38YsRchwxpOf2lJm+nn3h3knSXc4EmWfLroJjqxuxMzPR5t5BS9gwXekmAXmT/1fB95Uw5v7Q12PmclbyTGDkgYeJ7thhD6eRgzLJDW6+jVZoWkzxkjh3CSzwGubOjdUD1BIhvn06Gh/Z7iUrUympO1W3zNUTG4TjJzLZ62pUaxCkxDJ/V4v4qpi3SJ4vdO1K3Pkq+eWlxqMfUOaagwv7BTGZbAWcrWrFY0xLZmvUwAhRtFXhKSawpiecZGEvRXKgwmXJM9627k9U4KOhrxzv1VjEgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDn/hZvyGQJbK0stDIdeIIFUgOjbW7Z7dEf1Ep5O2tk=;
 b=ZXZQBn7BFeHmYRswbCrEVCKSL6Qvzkj96IauDYr6nqOUROw8yDSwcTN3HkxUOvIci+YYzTEnHidUJRJB2eixCjl85EGTyjWgS0ekclI7Wd5lKkSfPim2QZkXz9BruSyGJpGHFrlkwNW7Zd2vpCQPNdmmOuDBm7XqOiBj0FyOYZzfmgcp8AEDzVO2n5p/MOt4c3igDOBC+aj6UVrhe7L/0I1RO8aAI68aWkSZeGe+Y2qEPepxuGwqlPUSYUqenLvQH813IrnkZmOFNU1euuGM5ThU/ueH1RMWbzJw68SR3e9zACAa+w1BCvE0AGxBHyqZIQLqXdL6DNRPTMuYIn5atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDn/hZvyGQJbK0stDIdeIIFUgOjbW7Z7dEf1Ep5O2tk=;
 b=TzR5DDx7/jnqt+j/p7Z1dtn56HqFGsGLnhTLWVyDK9ih2G3Yzuztw/lQw+Q5qGjAKnQNaMC+28A3U0ULNLIXNvh2gy+3OqJASBvUOP99K/XzZrv3ZgHxw4XIRzTT5c1//OgGY1Pc/5SKFU8ceuDVbNxelH749Pvv2oxPUG4yme0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5067.namprd10.prod.outlook.com
 (2603:10b6:610:da::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 15:17:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Thu, 31 Mar 2022
 15:17:12 +0000
Date:   Thu, 31 Mar 2022 18:16:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: place constants on the right side of
 tests
Message-ID: <20220331151652.GS3293@kadam>
References: <20220331121550.GA429809@euclid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331121550.GA429809@euclid>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfbfc4a6-1035-4335-d17a-08da132987c1
X-MS-TrafficTypeDiagnostic: CH0PR10MB5067:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB506722CD253E2182D4ACAC468EE19@CH0PR10MB5067.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PCeDn5sDj+jBMH/4T+Qdr6Mn57yAAmqSBNB2MfS0w+NQEAV+bA/TgNDf5w93eNXL3ddlf+15Ft6SX5eO0OGyFf661ONLjSPx/PWt6kOOGmw9LUOlLR8c1UFs+x7eafyn8M9yeZTw2moiU+ZvpeY1VKZU5GtwdTKX4c7/wd1AiITHW7JznzSjE04Nh46bULjU7aIPDiVuG6Y/OpZobME/ipV8NinnhZUEfZK3lbQpkwwjyMg4h9OswaeVYXUrL2K3B3JEHh7CTkWbesKTx4tm7IUUEhoKCj5+pVqXw16AYhuX2lNMjtZlLj5xUazostaYeBesWK6VkTaigMquU9DBMOZSzrjeQBy7yrI589tc86sUHho3v1R5OAZSo8TfJJu9NNSP0weqpsOdld2bdTp0a9LZMCbhCAINVzgaQwDP0pkSKIRtU80Z9Ba6dYjEXdMCDvz25bi9dLp9/IH8LV/8Pi03xYv+n3ZxENiVwl6v1rGoaQ9BmPzZ6EziVm2O+OjlMabbFQdIHF3HX6j4tvx1M4Co3BCpXggBIEZUYzosQcgSwnCqkkuvUl2YE2x1nxKoP/kEZY4GO1WyLwpblYpMVnuGTBHylMHXRUPhxuS2Zoyqbe5fu1nDG7GKtHxfVqNTeImk2U90B0xKJ07YApzJaxYPjBWIotcx3hM0OOYQuUTJ2IfC8LME3/tsKqlM69aUui3HCaR3a1uEOTVeAm5ntQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(6666004)(2906002)(6506007)(52116002)(5660300002)(508600001)(44832011)(6486002)(1076003)(186003)(26005)(8676002)(4326008)(86362001)(66476007)(66556008)(66946007)(33656002)(8936002)(83380400001)(4744005)(33716001)(6916009)(38350700002)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NRtRwyToUTu/Nh2pSndtMRpohUGBFGuh1WVa9ChzXuPpY0J53VhOEBwhDG2Z?=
 =?us-ascii?Q?qGcfo64P7/1ghMyvrCG1iMeMS9MIGR3Pzp2MY8i5H9TyJ3sy8VqjvSd4psT7?=
 =?us-ascii?Q?AGjIS82L84DcDbeXvi5/9uoauVaqGG6dUSvFLFnH56gg7EaaV6COeRLfwqBk?=
 =?us-ascii?Q?tC0nTuq8rWQR0LQ1Sp5cB4/vXMIWhkTtuPoAwqVUiO1WzC8fdWTHxazIxC8M?=
 =?us-ascii?Q?buJ6TgFH5Awt+Z+aLndxfSKSRjq6tPlFpVuccpabBKuxq4czHtz0KgVY4zuC?=
 =?us-ascii?Q?A32iSil11U6XyLlWeY+Dj2XYyOJIfAYu0gjp9muEbF0jsAR+TA8lWQLy8Hke?=
 =?us-ascii?Q?xTRx4H4tCLHdlsGzJfOYuBdgcmz4jVpOikYqnjLvXS1gZd+ka6Sj/qcnoIwb?=
 =?us-ascii?Q?6OLO8gFIYXMhOwvHFDUuG2gkar+tw+huTd7uP+WhJ2W7QudYUsSpN10PXGPd?=
 =?us-ascii?Q?cHr2bFTvd00aCT7oBpV0FUmxRv2gxhDnz8GMylNL/jXFAyWFRQPNGCJpEeTa?=
 =?us-ascii?Q?8ysgHjhYBX+wzbBPby8FbdDFMZ9gpbzkI2cverasqw3mQ0cOMaPOZ31wXOND?=
 =?us-ascii?Q?2pM4K+nnBse1eParBtUengFPA3WXUsrlW6kYjtaQ5Lf5FrxSzZsG0ck8w42r?=
 =?us-ascii?Q?Eeym+uo3WRrxxgvlAt7iulrw6EVtrbp4WrCW7epXdF77uoABpdRq7vCpyIgT?=
 =?us-ascii?Q?j6C08x5Avo9kMCyOxut/UZmIaeuqYyfGFqwZdJi5CXYN1aW7PtBcZx/+wrGA?=
 =?us-ascii?Q?HOkw8LJEN/91ZkRO2MINU5MeUYxOG6Yen97/P69YoVNo4vom0vkatcA4W7+q?=
 =?us-ascii?Q?Z+eXYT3oJVI+sGFb9WHpAbq1C5RkxxbgnmkwvddmBCtyRXWo3hzOhQYBkwrG?=
 =?us-ascii?Q?yIq4ahEFeWsA8hkxLP4SIkxyYkJKElmnkHHZdaPhFVsLVM326GRqaSOrOJYO?=
 =?us-ascii?Q?wV/IZgVNzQbl8Jeh3Zwe5kmbzm6VS413fqzGtQiwSaxtYPlXq+RHaDkQ3MhI?=
 =?us-ascii?Q?l8p+Bm9QrMxxLexkVZlQHsthcnfaPleSTc+e8IupobzV3J3cfRM/bsg7kKch?=
 =?us-ascii?Q?xx+9yq4LoxH82cLW2E0N73JXrlxcVpS+MWDnppUQ0Wc09gwSKM2HloJw011E?=
 =?us-ascii?Q?v8l4sXn+1maW7tDu+mlS79zFnv56CageM/O9D76YiJgeC/TiYOyXbCmsfdGO?=
 =?us-ascii?Q?5MZ1fbqSHkmhDftlCogAcDzxSKp4i6qDkauAvcFvqVnzDJsc/8Q/ns4xNjkF?=
 =?us-ascii?Q?HPkPLzeZp2ryskfhbl78ZTybRbmmH2r784GK90JUX96Uru2WJ8VczPP6C4CP?=
 =?us-ascii?Q?vtpilTSxdf6IzKHAJVmN+8te0JkCnk7wGvXfJ32OxbyblnZc/My6KPjRfTS7?=
 =?us-ascii?Q?GRYAHEUg5jGg0CEHmrZ8SPz9RnJOa5NV+Hr7yjYXPQ2ezg7ahGihvGwRcsMH?=
 =?us-ascii?Q?ApI+pKlScjzMjrFqtLTdTslOcGFjqA3AKJm5P3BRmvUOp5/80DYsHr81kNWC?=
 =?us-ascii?Q?sQdtJbeN9UyYoCzO4R8n9mNyqRJnoTloxNGq0udyYdvAHC9Q2N9oojWZIkxU?=
 =?us-ascii?Q?KTpG9bQPIAbag7DkwX8WhIP+qvGlxzQGKKLmUTNaKPuob8uHwGueVZiK4wlU?=
 =?us-ascii?Q?2q9QyWsCl9Cv1tSZUtK878eL+WN8DU21acbsD2T4bEnByqhUHuzdxT0XEjNM?=
 =?us-ascii?Q?C9m/h2z8odm7u0QGyTLA5KJLu1ykMnuZtHH7iJ2lf91YW75c5v896i1sFU05?=
 =?us-ascii?Q?4xlHgSzwbVaWquXBONwissXIM58mvWI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbfc4a6-1035-4335-d17a-08da132987c1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:17:12.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ofj8B9zwTUFrhn62NHXbSwyCkl8mXyak4m2wx8mG36pIjrfwRTVXNdQRjeFQTFyPWcBVqyLyhOSP6lt2EvQwf8/qNB4sH7VB5nQ+MampAhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=774
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310085
X-Proofpoint-ORIG-GUID: iPjdI24OUIIwPzN0Zx-h43iA5NU96zWB
X-Proofpoint-GUID: iPjdI24OUIIwPzN0Zx-h43iA5NU96zWB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 08:15:50AM -0400, Sevinj Aghayeva wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>

Hi Greg,

Don't apply this one.  There is a later version that does more cleanup.

regards,
dan carpenter

