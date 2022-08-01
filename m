Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABBD587490
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbiHAXwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHAXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 19:52:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2FA2654D;
        Mon,  1 Aug 2022 16:52:34 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271NnpAm030714;
        Mon, 1 Aug 2022 23:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0l2JK4Xxe/FU/AqaB3HeM+oP9w1gR6GO3VyWB8JQM0k=;
 b=Gqf8Idc9ijpMzK35DKpVJmsmguuPhgIu9GIcwG6zzzbDYVw0vSPvvTR++YtV15PmbdRp
 mu0qJSPqyOrS4SmDiaRqLbk165D6ggOOLVva7l6J2XMZ3ucPwIG1gNxOjB5UHGUq4TH9
 IIm4Ron6OmHVSX4mFRC9kUiZQsRHbjZ6fNTu4jb9V+BQC9IMOqxQD4bGMXf/IyElr/bt
 BR+vPxCM7PgRtWevldvJ8A5Wyiqyl3qdEqajGI4juck6hP+eujbrCGRor3WAWqq+O0f1
 7XWmxQwV6s0Vb0lo1BCudn0MRIAPXZjR4Srxz60nhOXsf2KbSLE+7Xs4C7l75Mkz9Umx gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu2c55t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:52:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 271Kgqgp010963;
        Mon, 1 Aug 2022 23:52:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu31qy3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Aug 2022 23:52:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE5wus0cuEqUO3MzKGBuiVfOLQNiNmwCTHqT6O2SuSCLn61PoQEn6WNOQShU5BdiVuhA1MR9blxr+T/7susDu5Pyg4lsKc8PMlZ8KMSLVzXNqZhmOYGdoDQKLZWlxYyZwJ+D6r/U8drfLIUw0P0IpSv9XdXZ9RaK/or53qj91dtiSjSfRynrClxIg9/w9HhiZgNVx0yWSrMAlNuA++sB8RU9+Clcni+riouyTp82PehaYBfqTPpQNtZloYmD/D/paLcZLnqnu9SuIpY6cxcpSSlDOiJLd3Vs0UKtI0zOGZXjWstY4H6MHCQJq6nq0jQN5D6EB865Z+ri4F0OSZq3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l2JK4Xxe/FU/AqaB3HeM+oP9w1gR6GO3VyWB8JQM0k=;
 b=QVulDWXE3/gBN1pJqhrGVJCrBiJFGs2d9HoUlafzMF2Shuh0Yvg98BUwS+MneXZiF1Df1ludigIBZEuz90JLN7oI1xuJ2HcSJfsvqe7x1IR2PYbdlzGNJ5IDXQkn17QXS2rGVx+Dq/FZg6/d3fz7/my+7AZZp4l24m2TvmeboThZuWmZZZg6tFWSFOR3gxrKsJ9cMe7ViKs0SvGLzLHVMrc+AE9ZtYEnCCFF2o0zI1CUc5rrdeDQBcKOaSDrrckn5dDcafvTDrG2c4WybEZrlG8DxhmAqlWI1rVyonmoB2s5DuwxgGyWoib33GoNW9u4CvAbz/8MTKIpOc6r2a4z4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l2JK4Xxe/FU/AqaB3HeM+oP9w1gR6GO3VyWB8JQM0k=;
 b=h7YryXlKKCHYqUVQPh0KinE0gcHMRrOlwg+lvymIsP1d2NoqziOoEoRVOHAjuZK5/GfiX8+5R0JLa/oHtmcVa2oPzgNG8pHBjszM0hPNVS8uOslq930ZcLwrTCQRVTSJpWJ7gbXTatUr964BmgxJylOue9+4HDALYCpDyfS3n/A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY4PR10MB1608.namprd10.prod.outlook.com (2603:10b6:910:9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Mon, 1 Aug
 2022 23:52:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6516:e908:d2bd:ca45%5]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 23:52:28 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: FlashPoint: remove redundant variable bm_int_st
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8rb34k5.fsf@ca-mkp.ca.oracle.com>
References: <20220730123736.147758-1-colin.i.king@gmail.com>
Date:   Mon, 01 Aug 2022 19:52:23 -0400
In-Reply-To: <20220730123736.147758-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Sat, 30 Jul 2022 13:37:36 +0100")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:208:23d::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9090876-eecd-4883-3e49-08da7418e3fb
X-MS-TrafficTypeDiagnostic: CY4PR10MB1608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 835QPZf8Vf5nKSJDekK0XAxO5mNH2bk9TWoZVcPnvGoCJJjUIuciJGZCXrnd+VHSdkQm4ZCmFIbkA4WnYQpANiU1UqyZNcaMDsbM1W/MGhMXY2rnekYhtr5ykwUf1bjqzUBt7Toj00aJOWtaZa/QpyyXhCLACO6BsQY7tx6GllKnD7NnaIl1Ams8xcMI3lIUYs9gDg1Lge39KwCq0l/1FqS2TmjyZeOZo4Ew0/eA3KcIVseYx+BFY/em5K9tC0yN0rU+dk/gCwZcmFlfyJ1t/oyMII6DgHjNA6GfjwR9ClRiRxRkFH5vq/UZ84biwl8z4NSK1cs5LJY679Iu5vrUu6Kl+kBiENcuFdKoznqcNpNaMSI+aBhMtIv3EsYXWY14fZS/PG0HRFQZp6Sm0/MjqzK8V5q2OSJ5NvY+NT7eZ0OISslIJ5GII/i8DHJ5tK5P8J0bK1P2/+tbAtRn0qzou2VxeCE3LtcUV7tFm2L/3b+Kgr2QdTzWY0y7ihDJM6ek66fMXZ1KjrqxlCLapEHps/A+6ITCGjTzYG/llgYoUFQpHe/gRA215k+fvulkW5cqG6mnVey31NMFVJYzvC1r5LG4TY0PN5V8CA0lXTBhLzbd8W4BGl7LmoiP3biA19I8TN5tt5KD3dJ8/kKhe16dn1Azr0tOtMgvEuZSLUbxPIP3sX5YCqIMoxKvYA4WuMFndQccwEIZkuwszqOwLuvyIcYt3HYS7K0DKfeDnjeg1mTbtKeE5oQScKSJ4C2Z6xtSNgQl+sPS6g/UAcfgqHlE5TQodgvvqn6St5d0XCVKUkGsbKwZy7lh8rRdvWhrFdZh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(366004)(346002)(376002)(66476007)(478600001)(66946007)(26005)(66556008)(6512007)(6666004)(36916002)(8936002)(6506007)(52116002)(186003)(41300700001)(316002)(6916009)(6486002)(4326008)(8676002)(54906003)(38350700002)(38100700002)(558084003)(86362001)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52lxJ5ot+/TB8y0K0MJvnsY5z8FlX3+3oxsgjNLSKBbGWPt3/smdwE4z1q4Q?=
 =?us-ascii?Q?c+06p20GdaC1uJcQZn6yZ3W1mygxXQVlTpEvSbpegLmTKkt8g9JbXuen2/O3?=
 =?us-ascii?Q?0cbPzzfD8wCZ0NMvqZIgPceTxsAptUIYpTQkxCPwWe2TusNGHpIsIDpvgiHk?=
 =?us-ascii?Q?NCnGHU1qaqLFBSZxNcVXJzXP0fDKbrCX/JW6I20mhBhD+WL/Oyw/EEZYAeS0?=
 =?us-ascii?Q?pMJkbURRFursPcXvkyXQz85korMfOpnzpFV9/sipMPaw/RwDa7PZ26VY38qg?=
 =?us-ascii?Q?p8RNQh7GeFlAWv7ldQzFkntVkeAt44Jxn2w+OE6pVkXzJIV+P5V7DIMK+d6g?=
 =?us-ascii?Q?X59Dm9dgp77wXWE6+ylfMR8E2AmixJS2B0TXYNYOEwKCiF9her5WQLHHn6YR?=
 =?us-ascii?Q?Z1T+8ZAqiOYbuh36LRdjdg6IMEg+/IHEosGjFwcvMvnZfRvxO4tYnaCnQIzT?=
 =?us-ascii?Q?WQ7C95nwPdgBv1IW0OCkiU3/LprYIMWH0hT1x/IJinB7dNRevhExcU5iRISd?=
 =?us-ascii?Q?Lk2ZeCZ0gZ/U0VTyCeTJvlcYMqUeijKLsFTwea0OZ+RoSgFqsRzqRZdwcDAq?=
 =?us-ascii?Q?JjoeICS8W/SFzMdtPeHzrTBOrVv5PhM4zwRDYj6D+DhX6wlWWD6OExDV8tCY?=
 =?us-ascii?Q?e1ieavzybZPgeOH32KZgxfetrThWTe26fdNzRFYwWS+RyiLqppj+5xQVRUj3?=
 =?us-ascii?Q?Nw7HOUqr06lN6ZnKf7e650WQAkSqZ7GGWUgPi6l1LcC65E8sxbgoODurF8bP?=
 =?us-ascii?Q?QGyGrhnf1kwL6OYTwhbkBsrMrZSK0e9zt2zwm46RfEKoYiv9jajwTsyZt5/J?=
 =?us-ascii?Q?d/yzG9skQVZPILPO2f45m8ywWjI3TFYEqfVMTa9/AqFR8FgtD2gLsgLcpzje?=
 =?us-ascii?Q?rScu/2vbLlMYZR9C+WEqJTPf9D0k1YkfOLqXTBdReYmVolvYvT2VCEV2cRE3?=
 =?us-ascii?Q?4ain3LqqPsXymMtx9gdYYLx+ePPNDYMYQOf0LP6RaZ74W1rqXMmL3OTr1+k0?=
 =?us-ascii?Q?fAbm10o4eoDTCR6t/ClK9SLF8gg88AZ3uN/lH9xWqYyUiMldFLfqaHqIABHS?=
 =?us-ascii?Q?IYpi35bmvnr3OIHu4GxY5KsSVPi++qif7tPr3lgwu5ujZVWTVuW9dcc6bjcT?=
 =?us-ascii?Q?fUFsb3mqZMxly0oOJu6Z/A7FHFqIVWyeoqv4umGXavd0BayUZGBuJ3tnlzH4?=
 =?us-ascii?Q?ET5l2HsfnT+SnN6NtqDBh3/Z8r0MrIX8o8Jak72o5HFP5XoWyD/0wbRt33Ov?=
 =?us-ascii?Q?6BUVQ1I9PMXHv7yow9mnFtUFiyG9Dh//0+B9fNkJD9OiMVI8R7BfjD8HnR9Y?=
 =?us-ascii?Q?z/mZYUctp+M/t83zUYqjIIgO8v6p5UaV/SJf21a0XiP/K9+qJEiBLSU5IwRO?=
 =?us-ascii?Q?ECK641Xa+VRUivpcoNiW1Z49qqdhaEOAnc0dYO1f9K+m2Bn+J+55gQofy3YS?=
 =?us-ascii?Q?mWNVaDeoQkIB8E9ULh8Ic5fLTbJQePEiGBhZpp1LUaIfspkUKXUP3jDy0RXo?=
 =?us-ascii?Q?P1HPZFd1nQtai1qOYGKpuS348xMR3dUPni6yixVhmCHFGqLhKhI3HgVYxklb?=
 =?us-ascii?Q?Z7arQlxKn8BJ/wMrSPtDqnPZWjoiGCVlg4M5Zkh6zgdHehrvPIEtNzL7BnAM?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9090876-eecd-4883-3e49-08da7418e3fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 23:52:28.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2JLAlryJK7qnAhvfOpdlb5MjR4EBQVRXRMgscEKqBKhs4WoDWXCsFxYtCDk4Z/PDhWLgXytYM+CrRc1cdwUxpvO1mzcJEvBUMuxY4T4BHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_12,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=924
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208010119
X-Proofpoint-GUID: JWAxH0nDfiPG_kgfQaBhoMcynxcD6Ayd
X-Proofpoint-ORIG-GUID: JWAxH0nDfiPG_kgfQaBhoMcynxcD6Ayd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable bm_int_st is assigned a value but it is never read. The
> variable and the assignment are redundant and can be removed.

Applied to 5.20/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
