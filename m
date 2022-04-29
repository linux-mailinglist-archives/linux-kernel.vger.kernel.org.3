Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48351563D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381134AbiD2VDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbiD2VDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:03:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4FED39BF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:59:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TI2XhU032179;
        Fri, 29 Apr 2022 20:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UoiiXccgcvoMQsJ7BfeO74ZDqOr/H9g0k0Z5+dd6l8M=;
 b=aARe6xNvwKBAz0febuAsnQ3Hs5DMVsld4tGCk90sq5fjd5/nz//vpu/6NRBrp9M4Et55
 HuvmOFseR1811uSyFBpL4XvDF9RgnjioQygJNXP2CXK5Ar9jg3/jzyK14dEt4ssjxbsR
 DNWq9bygm2NysrI8WlSe3qhmBTUzezGgwq5q539PTyVAxr4psve5aZC4VbpmncKe6fxW
 g6/KpSNxHBNIdzqGHPI6gxQSG0ARn+byvwlzaDjeymoA+gCF/t8My33yZtos7oAnCJ6R
 j2OcVNQ91AApEz2ytQuk9yTN8n9iHKmrek+XP7HYI8G/ZJV+oiabBInSyEcjn9jDXk3I Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1073mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 20:59:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TKpFib018451;
        Fri, 29 Apr 2022 20:59:38 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w8g8nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 20:59:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdWzF3pfCDg1gKwZiKUWaf4/UCZu3fd3nXXkEQE6Z/d7bhBCk7gtHS524JopKniQP9Njb7XF5hwYD7+4COKIXuNTXoiiOKK1ZFmVLXgmM2m6k+j09piEQD1y4zENHirgg8whZEcmPlISbIEN+axWIEnpL0cmgKHUrStdrPriRIOM48VN190A6/lbVt5VqR8Fi0OtR8M3TyZOSqqEP2WX5JiMgBHVRo3Omyps7F77Z6hQcQmoVWRL1Cj7074vBpGZ+J56b4uVwR4JlNhceRaC6NeDFxhfdv1ox+ZUQIHuujvYosmbfLZQb8LyZ1ILUzFuD1Fa1j0lbcitDNeea35tfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoiiXccgcvoMQsJ7BfeO74ZDqOr/H9g0k0Z5+dd6l8M=;
 b=H083oZb/vzsXURPp38klh86M07+yu+KgcFFSoQs6n4glnva8gqCXlLFcutHcBonWDkhpxuHNzg73NCzbYoH+hq9ElwaNI8dUKjy4K0plU2SZy0UU96DVvH0LJ6aC/jqWTVHIDanfIP+68m6LtCIBDqFGDGJo30FVEaPQn4tSZxT94Pp1Hmlvmz6nJCWvbKca30JG8omS0xJfxMTY7HEHzYRDavazs44nJLw8fjQJloH1w7v4bUWsv7GEPG+BEaPxKCLwaeXbINTDrUb0vtSsFwOPdbfZiqJLRcJaWqF6q46w/069yvcy8no4ms6w1xOw+s3IUZe6zoTzvj7qtipbXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoiiXccgcvoMQsJ7BfeO74ZDqOr/H9g0k0Z5+dd6l8M=;
 b=Ng1jYHJZihPx8Htsszw9/IfhV1l1NsDTMoyF6ZlyPPDKRyV/WMaX/9/OWb4+FxbhxCrBfPpcHS+PGI1iWomQT8Qd2mb65vElNEeeW4KPnr9Dlg0r9/j8qvaIFLfZc/Q3QpbrDRy+zSzOF8dRVQ2s0yvd9J1d1gkt3U7jZ8EBvho=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3985.namprd10.prod.outlook.com (2603:10b6:a03:1fc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 20:59:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::9d76:7926:9b76:f461%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 20:59:36 +0000
Message-ID: <152cb376-3793-0dd3-7d2d-d6197b8e014f@oracle.com>
Date:   Fri, 29 Apr 2022 13:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1] hugetlbfs: fix hugetlbfs_statfs() locking
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mina Almasry <almasrymina@google.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220429202207.3045-1-almasrymina@google.com>
 <20220429133345.d79af45fb107340c31655c8e@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220429133345.d79af45fb107340c31655c8e@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0199.namprd03.prod.outlook.com
 (2603:10b6:303:b8::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32190f39-a1f0-4b1a-0533-08da2a232b17
X-MS-TrafficTypeDiagnostic: BY5PR10MB3985:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB3985E5ED9937A77F5BF5FA78E2FC9@BY5PR10MB3985.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6XWVQm3M6Yn7uN44cUs9IFw3bmEtQi0FKlEF+PDtM83OQmlyxxZFZ8wp3OBLLnDbWh3ZLOodugZuuZMYjIC4wRIibD+BoUV1o2UycCpGpdvQ6NMqU6SHGQxJbOWYAeMf3RuK98WJrYGeNuUzSVZwUgfQ4wzuH0/5BuRHMAvfjfMmppgaMHQTAMtxthNQ4ep+lpefoRlcWLKsmOWUeFvck8bBzHiKrWzpuMnSgg94fzL7bogV14jBLcFl2WAJV+UuLCF0qjTBAD5mSs0H1ECpkoYuA/yO5yIvJueh9Jcp4UfmpopGNkWglTxrJVi1r93gfPuC8eUDAGspH4eoPYA8kR9DZmdaMMt54CHGtyZiSt9s0J1mSD71JnnGhcOBMws/QId08jsG+HuXOdkDLLqf+cKqjZ2AH4XIHvCM47AYdFqDn+dPS8fxoxTKKIn2bMrhPLekU5Km8pOB99szJ1semHYvoCA8+monX7+qpcREnEqsI2dEMm4MnzKgp+iind3ED2Wd06MJa/7ZfxoFGM7muDHPSGlpkYWtwjNnTSVXMPkn310mEy+TWwssUYxRVnYVzKVo6UTULuiIR6l6plJ1jKv7Uch/4v7CUqYKva0cjML0piDLNDN6W+rG3DPRWdasQi5Rvof/7b2ZvnxY+5dAYq0klMsOFZ1iOXEINVNrRseQKCWeRa7dBq1esI0RHmvxaVrEcWcLkGcn0djCMCIwqxgLCW11CU6BJR14fyPFWsC7cDkNn6rMKoXGy2Cu1OUnnT7p7+PYspUksb+wMyxfIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(6486002)(508600001)(52116002)(2616005)(31696002)(26005)(6512007)(6506007)(53546011)(38350700002)(38100700002)(6666004)(66556008)(186003)(66476007)(316002)(2906002)(66946007)(5660300002)(36756003)(44832011)(8936002)(110136005)(31686004)(54906003)(83380400001)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2c5b05aQ2F5RnFVVGJKUWFSN2NWZVRZYk1zYmRpYllySnNRQ2lBa245ajlI?=
 =?utf-8?B?M3libkJJL2xVdHZqSnRLSXJ2azY2K3NWTzZ0bHdCaWlnZFUrSFpYR0hVNlZW?=
 =?utf-8?B?UDhNT01oK3UyRUs0U09CUzUxMmk3L2t5ZHdIRmFlZWs5MEFMZy9mMXI1YTUv?=
 =?utf-8?B?YXJLSXBMbnNNMzdaUFpoRE1aQ3pDZU5KV0thMjdYSnhON1Bsd1lhQmJqWUR5?=
 =?utf-8?B?YjB2WGFtaFdiemYxNFl6Z0dsTTBvMy9WRDBvc094L0xDU09mdGNOeGd5eGsy?=
 =?utf-8?B?NDZ3dUgyeGJtN2V5eUM5Zm1PZ0RXKzk4NDM3UzRWcmNpeTJ2cmdSR2x0ZVIz?=
 =?utf-8?B?U1U0czVtQVZqci9LT01kbGQySllGTjlWNHBhVm1pVXRXQUVwcUdPMkNqQ0FV?=
 =?utf-8?B?WEVTNFBXRGhPVTZ3Ymo4aGlteXk5WGZJUXRMaG9aaEVEWVExUkpvaEVtMEdN?=
 =?utf-8?B?a3FERW42NkRTbEIzSU9aWlNuMW1oWUMrem45bDQyelhrMlF6eTZtOFlrVUlp?=
 =?utf-8?B?SEdkZHd5RlF4em9wSTNkbTVWVDY1ZXcyUEhNL21lazBYWTAyMGFwNzZKQlhh?=
 =?utf-8?B?VElvRnB1ZjNSQyt2MGlpWlpuR0xUcE9LU0pXZjgxWXdkS2hSYjZPUmJBR1Bm?=
 =?utf-8?B?MktLK2dxWVphU1BlU0hFTkFueWJjZGFJdEVYY2FUWG5RcWxvc080MXBMTGZ0?=
 =?utf-8?B?YkRVQ3lHMld1empCRzBQRlBVck14TlBUeG0wYTRJWG5hcjhsaklESmpOdFh2?=
 =?utf-8?B?by9iL1ZIMU1RT1dFcjlkcEhMd3Z6aEFmbE02NjhaTGM5SHdKZjRJczN6S0hm?=
 =?utf-8?B?dzY0RFBETmhlMWRmbmF3K1RyWFlTSWxQNDlXSUdRQ09VTUVzblcycERQNW1B?=
 =?utf-8?B?YWFvT3lzVHNPOHNBeG9jOUNsb09WemJLL2NyY1BTblRqZi80aVN1ZDhBeW16?=
 =?utf-8?B?czRDcm5GYUtXdzVvMEI0d01GMG5nMDNtb2Z2dWJrRzd4SzdmL01Zd1h4TmVn?=
 =?utf-8?B?cEQxK2hKY2E1NVZjU1kxNjFVWXQ3VGRjWnNSbXkyYTM3TjFmL1BkS3UzWDgz?=
 =?utf-8?B?aW5KWUZ3NUFEOFNXek1iZjRSdFhoMTkvZENhN3J4Q1l6Um91b3pvaFp5MmlR?=
 =?utf-8?B?RTJyQ3pGOFArWEMyR2VUVC81TXVNbE5xTWdjZWNKbUdjK3dQNXJPWXU1amxT?=
 =?utf-8?B?QjJnRGROSnYxanA0U2FFNWc2VG4yR0ZtNU4vOEtMY3RjY0FGZjh1NGxkR2pV?=
 =?utf-8?B?dSsvRzU5ZTRNa3FQMnFiV0FhWm9HUExyL2JlTFYyczVoeTFpMmQ1Z1NyaCtE?=
 =?utf-8?B?K1pQZTV6UWJDZFQ2OFk3OW5uU2UwejVHVnhkN08xczUwUTRtRVdpVzF2L0ZO?=
 =?utf-8?B?ckE3R1A1ejZGR3A3YU56b0lVVTRLK3p0cWpyRW1EV3JlMjVzeE10aHplOTM3?=
 =?utf-8?B?THE0Y0J1NnlTMk5EM1pJbEIwdXg0TEpYWktqeUovdDJFYzUvOXJFT3VtVzF1?=
 =?utf-8?B?WnZzcVhFcWhLZzFpWWc3VHZ0dDJSSjc1NGtZSzdXc2tyVzEvQW9jclhkUkJU?=
 =?utf-8?B?RzJhTlNKUzN1dUZpS1d5aTRsUDlqejZ2SnBpMzV4OXN5RTdTMGdPMUlNd2V2?=
 =?utf-8?B?VkRPanQ3RzFPbWwreTJEUlVqS1VkM1RjbkxjTXN6YkpRSmVGNWViMW9XUC81?=
 =?utf-8?B?NjZGaW81dFAzY3FHRkFYY3RIWXg4YTA4M1BRcW1ncVNDa3BIZE5zdUtKRy9o?=
 =?utf-8?B?S0JPV1lVR0JzbktiZzBvaWJJaGxCbU52WWdnaHJ6cXB1MDNYMDdwcmNrblJ2?=
 =?utf-8?B?djJuVDA3V0ovdnVZMFp1azcvTENpYTErNHZGWDNCZFFGcmFBaXBQMEJZNUFR?=
 =?utf-8?B?NFlBeHFpVmtWSEJ6TWdYeVczM1VZaG1ESmhvMk5aeC9jazRSSlB5Zm1VRHpq?=
 =?utf-8?B?TkhNNmNlUEFLUitjTXk1ZVJ3Z21BMy9ISTM1RHVFRE9MWk5qTERkVmthWHJp?=
 =?utf-8?B?ZkZqR0hkKzBTb212NlBEYjFkT085dVZYeTYrUndWRUJ2YTFOcTQ4dHdLdlVV?=
 =?utf-8?B?MFNsb2o5UmYzd3pvdVpHaklISkpNK1BzbkFMdCtjbGJOVDJFTmZSZ0ZFOHpW?=
 =?utf-8?B?cC9hbEhlbnNIMURzbFJpREJtdVBPUHpvK1czU0lwVHYyZnJGdSt0UklPSnl1?=
 =?utf-8?B?RnMyb0NaVG1rVys0TDFqaW9aS0pldFZrTHFaaHcwSDBGSlZaVFphOFJ3UHox?=
 =?utf-8?B?Y2QxSXAwaWVsV1g1MGkwaUtGM1hsbytMNmM1SXpZSy9iZDBWaHdRRGRZSC9G?=
 =?utf-8?B?cjhZZnR3dTcyb1R4alNMQUltMGFDMjlYU25NM3ZiaHVEZUI0a2tKN2UwL1N5?=
 =?utf-8?Q?tTgGtT8o0s6/vdH4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32190f39-a1f0-4b1a-0533-08da2a232b17
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 20:59:36.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUi7/YDmb8rGm6i4is4FJYEDjWGFAXYI9ThUYPqufmPg3MEObwxgSx78mWPmR7jPCDRpSmpbq1dStmQ8bxfxpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3985
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_07:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290113
X-Proofpoint-ORIG-GUID: nOlo8qVaYjsuL2JqDnsDfvsNtGKB0yrV
X-Proofpoint-GUID: nOlo8qVaYjsuL2JqDnsDfvsNtGKB0yrV
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 13:33, Andrew Morton wrote:
> On Fri, 29 Apr 2022 13:22:06 -0700 Mina Almasry <almasrymina@google.com> wrote:
> 
>> After commit db71ef79b59b ("hugetlb: make free_huge_page irq safe"),
>> the subpool lock should be locked with spin_lock_irq() and all call
>> sites was modified as such, except for the ones in hugetlbfs_statfs().
>>
>> ...
>>
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -1048,12 +1048,12 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  		if (sbinfo->spool) {
>>  			long free_pages;
>>
>> -			spin_lock(&sbinfo->spool->lock);
>> +			spin_lock_irq(&sbinfo->spool->lock);
>>  			buf->f_blocks = sbinfo->spool->max_hpages;
>>  			free_pages = sbinfo->spool->max_hpages
>>  				- sbinfo->spool->used_hpages;
>>  			buf->f_bavail = buf->f_bfree = free_pages;
>> -			spin_unlock(&sbinfo->spool->lock);
>> +			spin_unlock_irq(&sbinfo->spool->lock);
>>  			buf->f_files = sbinfo->max_inodes;
>>  			buf->f_ffree = sbinfo->free_inodes;
>>  		}
> 
> Looks good.

Agree, thanks Mina!
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

> 
> This seems to be theoretically deadlockable and less theoretically
> lockdep splattable, so I'm inclined to cc:stable on this.
> 
> I wonder why we didn't do that with db71ef79b59bb2e78dc4.
> 

I do not think it was considered because the "less theoretically lockdep splattable" was so rare.

IIRC, the issue of possibly freeing hugetlb pages in IRQ context existed
from almost the beginning of hugetlb.  It was first discovered and 'addressed'
with c77c0a8ac4c5.  That was not cc:stable.  Then it was discovered that c77c0a8ac4c5 was not complete, so db71ef79b59b effectively replaced c77c0a8ac4c5.  That also was not cc:stable.  I guess we could cc:stable this.

Mina, did you find this with lockdep or just code inspection?
-- 
Mike Kravetz
