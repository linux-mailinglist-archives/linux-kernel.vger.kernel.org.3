Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5454659CFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiHWDnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiHWDnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:43:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1DD1C915;
        Mon, 22 Aug 2022 20:43:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNx5Bx029415;
        Tue, 23 Aug 2022 03:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=U+dxtqLWbP67686tNP2V2I07aXhLC6vlvFR+oY46X6s=;
 b=CFrh0l3DRZ3Gg2EKho9M5Ha8FuBcfuiiiI24PFtgZaU6gDYv8Ehz5H44xKPWrwxYaqLO
 b+Nmt/7/xPj8+O/YThRxsYMgmIcYVYZz7HpbUCdBm8lTLP/akZekCtS5TIX43kit2qca
 h58CoHhYEF+4GIn+SrURBSN/JcdaDPbpQbpRIyXN01y7rxpng+1wEbD9vXdIUX2Z7qpv
 d9pNSYm7lSGmdfAyUJnbfLWjdPggDxHgxUoSuS+FDHfaACZACgAjQjpF8H8agq9SD+fp
 tYwLTnRoDHMB09qW6JIG0WHG6ooaYYLpiad2+djUw7WVr8L82TRxAgp1lk1bATrY6BIX eQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8c116w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:43:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MNr0pD025341;
        Tue, 23 Aug 2022 03:43:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn2e8pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 03:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS5znNeNmAMHkyzqNQPu8LCzNHymM75G17E4VQ94WBtwaXgwxJWOWcRqud+/abiLayQ+W+2kYRzw16/pBpFU8fY8TQIldIG+T6R4+JX/BYhnCwUA0Dr2QP6AjXBE8u1HNq+LoNV/bY7NbFKlPP+agbanC4RyrKobQ2WN8A1cdRF/aOlX/W8S0HhTO3IaGVYTCaRKlBsClX0jtw8c1ydafd83f3GWik3/9Dd7rGOpde9wHjlTcEG8sqQHWBcOLUh+gJPMMmSJBhTshd5xNtNTSuBLJeIJE9vR2safV39HK22vYsSYcffQCpSh9xhEMJo3ULmPU0A3ZtsbPzEhiItjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+dxtqLWbP67686tNP2V2I07aXhLC6vlvFR+oY46X6s=;
 b=b6nDpIMhg9wvCt+c5DFyAdFOCRMVOSZHXKKkfFVSn7DMpFlrneG5yrmGd6PR4nlXXrp3QpvetT0LzKf+K9/LXwBT3RLJa2tO8rwNZ0C/2MA+kb0X08LkDIHYb0KhukpPmEEhZWIhDfPVAnOzgKDUNe7aeDU2N82RxV7F/BRPt9Zt67ormKlS8j/GKCf99NIai8vObCbZVRuRdx+Qtbx757Qlax3GSauMyoybd8An9pw3PZjzwTUkqu9ifW56y9boqzqk+r/KQnYpmzXRd78yKnLACdpa0TP8GuapibCpK/HfGhAK2xz6uMipakj5CSZtuaFPAAI2g3QuNjPOQmtP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+dxtqLWbP67686tNP2V2I07aXhLC6vlvFR+oY46X6s=;
 b=uoOEiVQ4cCjx9Mv60r+FdDtI5IvSd8b/rpb2wV6ukuYMqXi8DDfY+F3wNyvzI86EZv/4QjU7N39kv2x01l+2pYQloxVcSSkDwHN7ni/xeiapCHTHccbMBxPnD/Zzm/14sUD72FgAvaWTWopgnjPav5P9nYSMmgb2XvBakoIQk24=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6130.namprd10.prod.outlook.com (2603:10b6:510:1f6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 03:43:28 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::89a7:ad8f:3077:f3c0%8]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 03:43:28 +0000
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: initio: remove redundant assignment to pointer scb
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czcraalk.fsf@ca-mkp.ca.oracle.com>
References: <20220805114100.2339637-1-colin.i.king@gmail.com>
Date:   Mon, 22 Aug 2022 23:43:26 -0400
In-Reply-To: <20220805114100.2339637-1-colin.i.king@gmail.com> (Colin Ian
        King's message of "Fri, 5 Aug 2022 12:41:00 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:806:22::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3884b2ce-d266-42bb-80e1-08da84b9a40e
X-MS-TrafficTypeDiagnostic: PH7PR10MB6130:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IH1qe9IwTQAlr4yXvw2/WeKn443wELPQlDF+Ocw+pdN+fDmXRlw7u4F1+vTeEF2EwgEvPN4x5f1RUIe9j1yZuzA9TnbyxGadDz26aIhgaiRkNwBSiJPR7XWsN+0euD2zMRWptwtnyr7qQu0xFW2f805Gk1oJ41MJk7ySmH6HJxBfPvBDdFJNj6ahDQDqmnnIGJY6r/LHNQCPw8QeAQhVqZpHlkpdhKYGNrIPvysJvpnlqPYoxjDgaybwD+7pLMONavHlbJj/mZTRvwEf2ayORcsTimgvk1Ef/eSk0FYZgC/yPlkU9GQxIWWpVsW4//w6N9H/UlnfMWnRYL+cjX44ZAiKtnfQJX2zBk5MgGmXVfWqequn3y56GS4kSoWpZ8fRxmFJfXjAvEMtYjh6X3Z7J+2ume8jlTAEBTp2sTp+pxTUKSG93mtAUV6hKlhAUslWCKnsWOtV0+gWByD9ZiO0a5FwSQY+XIref1SIJepOy2gOO0lUbUfx3MMu7Elv/CCoye2h+n2apxuYszilG7ZWoMeIM4vOSJ0D64eaMqJHzbE3jRANyqQ2jIABb6WopgS9HiN+dg5oJpMfnTu0mSBrZM4d0x24f+XrDAEqwyQqXL19Y1qVOFtUBztdjf6Z6tZaFCQ430X6YDqLCv356kizBrZiCelybgiKL3f4qIU/rUvsipNGP+IHxTEPzG8bqeq1ynzak4NuduMshHNkafFhk+zPAsnDkmIufMa6+M+ikLsDawGMvOjPyJiqRbjyVk6O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(136003)(366004)(54906003)(2906002)(478600001)(316002)(558084003)(6486002)(41300700001)(6916009)(52116002)(26005)(38100700002)(86362001)(66946007)(6512007)(186003)(36916002)(6506007)(5660300002)(4326008)(38350700002)(66556008)(66476007)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?brZ9lYJpXHdnLOwhpH+d30ofsBDxutDovVSjI10l1tqMJXkDoTH9+V/3Osij?=
 =?us-ascii?Q?cmL/jxmSn4A2ZbbrLRvUN9985ITYFo3LMjDk0Pg2nXKEehQ7tkfycDWwEd/U?=
 =?us-ascii?Q?DOc6w1S1xx9hnxZqurWaoUX7Nsrn/Af30ppRDuyBou+qfqdjPlX/N+kBFJRa?=
 =?us-ascii?Q?8kYOe8+2on72MdIQsngPi9SkLuraVTzBvjR3J3vnhYxwiTeoELu1n4NP3X71?=
 =?us-ascii?Q?gsIAkB10x4aurAquaGjBJzFY0KNdDgkbjYWyhOpGjdWBOj8D5TnsAQiUMPNw?=
 =?us-ascii?Q?Pgt+Wiz594Xxgz9QS4nY3A8ceXcPvBJcICSxTKHTA38UekWZBzp5anhhvJno?=
 =?us-ascii?Q?2hinn4f4DjLbAbKQfqW795ox5wDsCwNIrfDKyp4P2s17i5J8H8BpKS6sYjI3?=
 =?us-ascii?Q?42FsLE+WwfH5LgUvSMLWd/JV17RgJmVFN+KT9rr1akTU3ugMYamCAR8ydeEr?=
 =?us-ascii?Q?f+56rWS7pQL9znb2ngCdCEWG+ARTPqizIo8Ipn7xGK8DVWUssY2+T1PQzwVw?=
 =?us-ascii?Q?/eezDLGsoZD9nwgIEM8DJ3+B5dR83H4YzjrDJZa6Juv1Gsq+xI6TZv+5q8PI?=
 =?us-ascii?Q?QtkpMWu8Nkdj/r9AyWvCz4At/gJQiYOVVWIkqxlogJgqJkVmMHjr/OphiSe7?=
 =?us-ascii?Q?SEV+RGdtcfBfVZL2s/eQBeYBn0mSTT78MoE3ho6nEpYIF6EEXmiwi4WpXkV5?=
 =?us-ascii?Q?CZNXdgLvC923ifWs+wkyUH17q6se0WWaZO8fUFQTwgeSKnFA9O7clW5Jsmnk?=
 =?us-ascii?Q?xY5+YAerySNJtnEWrxORJi9pq5H+fPGpyAnrG0vgcZMtgE/N6MbG3blsae3g?=
 =?us-ascii?Q?IkT7QCKju9CJ9neQC6qUEwAZi22tN9m8OKi+gMCi7Pe+Tc+22CYKE+kNPC8Y?=
 =?us-ascii?Q?JruXYBddpNa8K9VJPgBxIZLwzsETNTsA1n7cxmzt1ZOSUGCwpVrHZEMRnFmR?=
 =?us-ascii?Q?OQRD+J6CK4isRHauFdM0hKqsD2QCpKlwnFE5wVHaMD3oPgc9xFdVWXBQIoDH?=
 =?us-ascii?Q?rVjHPTng7EtiU87imUK328jK1YBWUQkYPR21F49zHwoDxYB9GckISUVBPbIr?=
 =?us-ascii?Q?QfzDSDM2TLDr//VTWcjRoybG/6xB/iBzN/CtypSXb1ss9ClwagCMD+h8h5J5?=
 =?us-ascii?Q?AdrVZvmGi+f+VUh4WrEdE9j7Ut2uf1MVZV/J1nGnqKNEGklA00ZbyM0bpP3h?=
 =?us-ascii?Q?pNW7SH8JNx5ginHoRWckO7g9gdok8HFHmkGNcGRsAeMqhWai1fY63vTBWNMC?=
 =?us-ascii?Q?7pLGLbdylYj3411hrjSWUvPUNRvfdkXHRY7KEWr3GjdNEJd5QeUgzNI5XfB8?=
 =?us-ascii?Q?4ggiqqQ7x4RHfbR+owSlkXRP55o7S9sOwkhzplx3fHtk6PPIaR5TUu1H86SG?=
 =?us-ascii?Q?SNVxOOtNnNiBMfFvR3p/9KF1+zNS0IetrwRyOcHxScYyALNBi8jQLQLVI94H?=
 =?us-ascii?Q?jHa74uscoSZuv+yp6dTSETBgpMLlTwLfleyQnema8j1ZqzJzomBK6Pe4EuOI?=
 =?us-ascii?Q?hO17N1PjGnOavgiGTOwdXyNK/YYfcs8FmeBRvNrZSz8PYa3N1yags+prE71I?=
 =?us-ascii?Q?+IkQbuy8CH/NNPXHWGNngkBruNkzXWPGN1qF/zbBBil0ifgmDMs4tzvWXt1R?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3884b2ce-d266-42bb-80e1-08da84b9a40e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:43:28.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcj3eU8QmRr/RVi571FOb77i1/J/8EN6ODzDTsbLOJKv1GlYOO//vMGjGwpJo9LimfIEZ98Ye+tVSXLRNJMN5WKqwRA4kwbZLoGWVrBY/Mw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6130
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_16,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230012
X-Proofpoint-GUID: lAQ-1R3MTD9hOBCmKNy_CKCcFKBWRRQg
X-Proofpoint-ORIG-GUID: lAQ-1R3MTD9hOBCmKNy_CKCcFKBWRRQg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> The variable scb is assigned a value but it is never read. The assignment
> is redundant and can be removed. Also replace the != NULL check with the
> more usual non-null check idiom.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
