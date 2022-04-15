Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A4B501F67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347878AbiDOAFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347938AbiDOAEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:04:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EE9BC85D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:02:13 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EKYWjZ028126;
        Fri, 15 Apr 2022 00:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=10yNnRJLVy11ekVz5vZaKBIk0SLrBO1X0UUVSNzQRJg=;
 b=PiDCsy2O3K6NkX1U7irEi3zyPfqrSiI2ceTJxK1APfpelLgE2URdLiXLycTbyfzb574E
 OnuaxJ/ETk6sIIUXS/ljfjyr0pRhOpaSeBRWHc/cECixrX25h3tYr/KvRTqismO8ZUJr
 7BTpB9PDpoaUUv2Qba82n6qV4II1Ej9LNH9bQ/cHZpqSzMsbG8TQauKxzuTUNSreZ+S4
 Q4cNGGN6dzaCbnYssLEuneylbXp8A8pbrIAtfttvmwahdT0VKxpN977+F0KxGOJrCeR0
 Cvh5BivJEn+GoVJ2KDhjd96FpfOQVfP9NNvpldgsRNwuLfKLs2fOF6rncLlKoi0/Ajh9 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb21a5qb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 00:01:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23F01taK015006;
        Fri, 15 Apr 2022 00:01:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k5r0sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 00:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/Df7vxvvMf0/0XrTSmpjBzV6Ph7PJj9PvIiTRd4wDVBX6LxbS43WGCN7YTjowPVT+ySAMOqDXjXRmfRcOoDXLFkwqjZpiY5J1K8vsejTU8f9cfzMJQpFfNx3cZMxoLh2wEDZwytARXdVV1bd2E+RRAdk7s8jUbjYZxPu0qFDoH4vhX5PEViqyYTu+u1R3x80xlBhrkULtaCSTxXqBYZU2VljkECoV+jIGX6uyUAeNKAYy5ESeaq1lra4AZkjU5gEJj7nubn+BqyC3Z3+DenCLPZKbgawLQlNplQxK5ajEMHXUY898JStuwbG0/S8OzfxGwBAoT9eAkk7PZLyvbKjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10yNnRJLVy11ekVz5vZaKBIk0SLrBO1X0UUVSNzQRJg=;
 b=IPexuylg/vSfY9XI0Da6YZxKorpaHky3XdbhacwrDHClrwdXVSGwOpA0FC9hVkCpTM5iNpTV7zupYZgvWsKjKckYoSxTabnOmqEWuffQpOcxf0r3IB2CHIbob8DANKlNZyBC5qk5IVRCYUXNdfG6kggUUjNstCc7t6cwRbQTqyOrHtgDmcoaR/4qGNgP9Sndczj17GL6nyLB08z40T88PU3bfcVcUWBnQi0eYrRD4bOGusWDV38DjezPOy1bZR0Y9Zhe9j/LxLXjQmgSoSEo8e63tlYiy3DlAqk6l+3/LV+AaOht/zVii1U8CiZ9SVbFYGBS/7V92tV8n2GGzUaU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10yNnRJLVy11ekVz5vZaKBIk0SLrBO1X0UUVSNzQRJg=;
 b=upxULbpRMQoNrqtIEAzS1CVr+GgqmVirOMH3aEM7LMw8sj6Cqtod2+HiEfbeKx9VTDzlJCYg/1MzjlPY4G4PqE7XFSq3jYWop+GmiA5p+ftK92/wACqBPb+QD+OqtwMIJglf37uaAvmLUqnBCByDyLW+SvIyVUFeNEoLYcqaAzA=
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by SJ0PR10MB5423.namprd10.prod.outlook.com (2603:10b6:a03:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Fri, 15 Apr
 2022 00:01:46 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::d9e:d013:c6bf:3635%2]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 00:01:46 +0000
Message-ID: <4fe61809-db97-adc5-ce5e-ac5bb99c84ee@oracle.com>
Date:   Thu, 14 Apr 2022 17:01:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, songmuchun@bytedance.com,
        liuyuntao10@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220413032915.251254-4-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1939052-c03b-4160-622c-08da1e732198
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5423:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5423302B79E795AF9E9F585EE2EE9@SJ0PR10MB5423.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W8rw8JYKWw+XVgCikqv+ocubMk9uIk3t+Un37GQMF1WrFcxNklUWeGQXsvT1o+Tnf+6a7hf+hMkUcGC2fuBU61akkKMPM33o3wzJI+phHulORBSu4gDWluSO6XCSw7wJ2FRLl5R1fXqCokb9nJasDqzK0W2dsnOx7ftKKGka9uhU2XvtMp4z3LRU2x4YE+YrSasS4IOCosn2bRQXdgOpON50hOIiB6crf9hydRAgh+qwqvrNIoqeV17Bdq/9Quuf42djmgaocrFDrsmraxLAGvqxI4torU6dyHze6RBBzpYtxi+pQfSXXgZqwB+KLiTD3AiXIhsy7QboFk1k0pDadlcrHx7gl7pzmcfhFYhMP3d44LxAjQBAqJEW1vkbQtdIvkO8fBV3LPCGULOOi8c5c8rPZTx6x8Pm95YPr6d4/zm5Gj1EW5prUemUBFYrM4IMkW7K31dFOxkDJ5Qsl/8vaP1mCQqdqWV9D3S1TcpsQcYszfNbe9g+QueRRlHGah2uJ+CicbZWGDrqpeZ5TVzPkIRA2wRYNPZZI+g1nk5kelJ+9XLf0Au/jhqIUes7qTAjlqGQ8cBFMmgk98J7wno7+8MqyG0LXM+8LWYbnEr6ne3kXvAKdxFfq04kqVxKpMpp+Z2PFg9F/yKz5aL+LGPn65U1NWG1ANxuCu8+tR6TWa7V2r2Tw9RSEvWnVMrOOZZR23Fcv4fCKvf4NoK0vE1n6IM2caK9pjBZJ8mmXRY5PEEaFTwoqnuol6t8pZh4x6ln86SCbgu4W067nenXBcCy9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(26005)(8936002)(31696002)(38100700002)(6486002)(66946007)(86362001)(6506007)(66476007)(66556008)(44832011)(52116002)(6512007)(2616005)(8676002)(2906002)(6666004)(53546011)(186003)(38350700002)(5660300002)(508600001)(31686004)(83380400001)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFnd3RPUS9BcWZ2dVIyQ2xCMmxWMHpuTGEyZ3padlFraHpZMzFwS1NOWEtt?=
 =?utf-8?B?Z09RdzlML2t6QjU1MG1kVGVKODlIRHRyZERGUUN1OFlqa1B5OUxrQ2x4eHBZ?=
 =?utf-8?B?eDErWW1mM0pOYnY4eU1La3p2djY2WU9oeHRMb2RBOVp5NUxyRWxoQnN4TDhJ?=
 =?utf-8?B?T1lzSUdveUFmQ042YzRNcTVyRGNqcnpjb1Y4OHBaazFSWU5sM2ZiNnNKNkd4?=
 =?utf-8?B?M1hITUV1ZUo0M3FPL0ZzaXZFSHpIY3pyRkxCbVEvNzRScEtrYXpKTjFoNXJE?=
 =?utf-8?B?WEVpV01oWmFrY3V5WDlsQW5pb09BWHVKbWNiUTBXSHRwT1RXanUyNkNTeGxL?=
 =?utf-8?B?OWZWam1Vcm5naHdwc3M0RVdiOTJ0VlNaMjI0NFVJczV6N2hwOXNUbmR5dFNB?=
 =?utf-8?B?aGdVRklsREo3SW1QQ1FjY1RoWUorVXJsOEtmbGY2dmgxK2s5bnM5RnI2WkVI?=
 =?utf-8?B?UXhFcFVHSFF5dGdkVGxkV2hkTGJmejBkRTZPM1lIZEhKU00rNjFmc1BzVUdu?=
 =?utf-8?B?dTFBUkhSZjFUbHJkdlVGOVFxeXFGWmZrbGhYQ3VWUG1iRUNZWE9TbkVETlUx?=
 =?utf-8?B?emVpWU53QXhIYXpLb2luNWhOVktldU1uS09MSTFWQnc4Q3VkaDVoeGVWTUZV?=
 =?utf-8?B?cHpacTc1djVsMURITHJDekN1TjZ4ZUVFdzljL2hSWllxSlEwdDdhRTZnU2hk?=
 =?utf-8?B?TWFSM201ajdUVCtPYUgyRUF4N1FtZkZobGVJV2ZvT3RpcEtYNUVxenFJTTZ2?=
 =?utf-8?B?eFY0SExSbi9DdHJXcmt4OWNqWVlkZlJCOEN2Umc2N1VWUHNCYXl0a3hvQWh6?=
 =?utf-8?B?V3lpVlNmZis5dEp5TiswUUNOZTlxczQ2WmVSRGNmYTFTaGZrckR0REZ4VzhT?=
 =?utf-8?B?ekdJeUxhYVh6bE9LVExFclA0ZE5tQURNS3dMdXhTZkZsSUh3dE15NS85ZHR6?=
 =?utf-8?B?UldtNUJBUDJiejlPNDZNTlArL2N0dnFEVWRKbGNHRzdLTHR6eXl2YmxKV3g2?=
 =?utf-8?B?Sk1BRHg5aWFFK0NhY0lXNmVpWW9iL3U3M2xxUmtLK3NTeFc5eG5JWHMzZkFt?=
 =?utf-8?B?d0llTDVLeTZaV2N4T3BHdmJzdUNEQTBCZElFTmplM2U5dThFUmJyczNWZjUz?=
 =?utf-8?B?dkFyS0pJZjRzY3h2ZE9ZanZ5RUhWd1NGblRDdFlZL1ZKLzVvakt5a29USFg0?=
 =?utf-8?B?YUZlQXR4cHFtUVduM21JNkpScVlzWjh2YjJEN2dBMFQ3bFlsZE5JaTIzZ3Vm?=
 =?utf-8?B?dWVra3FGbkpZNTgvZEVhWSsvOXdXa0NnZDlyZWV0RjNYUTkxTXZmTVFZc3I5?=
 =?utf-8?B?eVk0VzBWMWlaeEU4Qmw0YnR5OFYyRmYyTTlweFVYYW5vV085bU9RYnMvQkpH?=
 =?utf-8?B?bjZHR0p6eDN6MnZKc0haSENpcHpWQlFrY3RxTmlOZm9qcDU1Mzg0TnRDVExv?=
 =?utf-8?B?aWxDUXhXSUVUREo0VlYwdDh0SzYrdkttZFlUS3pFb2xBVjJadHUyeXRMYlVO?=
 =?utf-8?B?dzY0ckVzN0xDVTQyQlgxMSsyd0RjdVovVjY1ci8vZzZPbU5vS3h2TUVmUCtn?=
 =?utf-8?B?R3RRUDhudk5VL2U0TTA5bFRtemhnN3lOdFE3KzNCbkRhYjROanlpaUMwTUtG?=
 =?utf-8?B?U0NraU0vcTZCSnRGSGpWMkhBTDIyVzFVVFpGY0M4TXBkbzJVaTZUbDRsM3Zx?=
 =?utf-8?B?dVpHbFFDTVk0MHNTdmpNbGMzREZVdGtYTkJNakRCMklkK0t4ZTRmLzlqY29I?=
 =?utf-8?B?ek93TFltS1lwdWo1YWc4UUUxUUU5bUNhTHZxa2ZyOE9JY2ZTT3dhc3crN0VP?=
 =?utf-8?B?SDNXSGFabGZManVRQXM1TTcwNjdRbDlENnRBWks1OWpUQlFINGkybElvc1FT?=
 =?utf-8?B?N1NnMTUrYnpSYXJMN0psOW90Q0NFM2kxM0ZPYUYwVURqYm01WUlFOVVCRCth?=
 =?utf-8?B?cVB4YTJXbERpTjR1RFkzbmZCMnVSQUc5eEI2MmVZUjZ5SHVOWlNDZEZRU0dX?=
 =?utf-8?B?ZlNqSFlkczl6czBjcG1jaDJkUmFtbUtsV2N2V0VLQlNkT1crb1RNUXlxSjZp?=
 =?utf-8?B?NU5YSEo5RC9kQlBRU3Q2L0JmUGVydHd4UEVtRHVqckUrbFFPUmpiRkt5TUlP?=
 =?utf-8?B?dDNOY0ZNL1JwVmZMQStQRk5RbUYzc3NqMXZrVmkzWDJPT1BmcEc1NkhUdmha?=
 =?utf-8?B?LzZieUlUNEoxZ0dlREx1UXVOMmNZWENLcjZxVnp1UE84VytMSW5pWUM4VW1I?=
 =?utf-8?B?M1BpTTh6am4zNkRhQVR6RExSK3hWZnl5Tk0zYlZmYXRoZHRmVEl3MGtXTjNs?=
 =?utf-8?B?NUV4TkIrTEp0bXRCVVplMGZFTDlpeWx6Rk1QWkxLWjBueUxxa0syYjJkVGZU?=
 =?utf-8?Q?Zj9zOPjFz4vvV8f0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1939052-c03b-4160-622c-08da1e732198
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 00:01:46.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jp96vh8894zSfLd4+RoaufktHFMQe7hzBRBGvcHmNoqiWBZDtO+90myFbNPXYOJK4ReMWb89NFbBLr9Rx18Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5423
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140126
X-Proofpoint-GUID: JhC267CTfgzGwV4Qk_kdOkIssAZ_skHj
X-Proofpoint-ORIG-GUID: JhC267CTfgzGwV4Qk_kdOkIssAZ_skHj
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 20:29, Peng Liu wrote:
> When __setup() return '0', using invalid option values causes the
> entire kernel boot option string to be reported as Unknown. Hugetlb
> calls __setup() and will return '0' when set invalid parameter
> string.
> 
> The following phenomenon is observed:
>  cmdline:
>   hugepagesz=1Y hugepages=1
>  dmesg:
>   HugeTLB: unsupported hugepagesz=1Y
>   HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
>   Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> 
> Since hugetlb will print warning/error information before return for
> invalid parameter string, just use return '1' to avoid print again.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
>  mm/hugetlb.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Thank you for cleaning this up!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
