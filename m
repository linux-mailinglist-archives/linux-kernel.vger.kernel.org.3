Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0C6502C73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354937AbiDOPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351151AbiDOPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:20:28 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F8BD7E2;
        Fri, 15 Apr 2022 08:17:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23FBZMFK012645;
        Fri, 15 Apr 2022 15:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9x+mOjrjT5ZspT9CE0WOPCsfraun/iEFCNu/miCf+zA=;
 b=pdEnaeAaMCEogTOcWIkg/hENOxYwnfqEWMFYq+S/Y1nnDP7X3auwzyVy6kM8HxLJJQUa
 KfOj9etI45m+U1YHv7mDaeJebuyZig6ryc/xh2qVTC5Mh47NDKmXbWuPfXEEFjoys2wi
 B8cFzsaj3VzIoU/ZtzFmZnZQ5JGKsuUWTu9E/rmJXsyP/iI86olidwB2AyEIgDLy3s1o
 Xm4Sej6XDySx1vGbR44mv/OCF3nBpO2tFgvrEjp4dcx15l0LV+/oEsMZA758ywvwPEfN
 ouHGI2icHzurH36M3lRV51JQIufW8FHLPDyFHwmb7hSmUikHWmKWzPaEKH4m6VVRwIHQ 8w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu7kk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:17:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23FFBaI6013039;
        Fri, 15 Apr 2022 15:17:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fb0k6f9wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Apr 2022 15:17:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lk7YSVwMQ4ojQmmyh6m9acD7NPMH9lbdYt3Xj/4firtkLZ8pyouaY9e7g9UoEvLGbNvszNRR3OA4S7QvpcLofAiYMF1Omg9O+73FeuUG2Drrk5SIPi++0tVMraX36YLTVB7uPmLP0QtSSbvC3Vs3FcfdQYnz1BEJpoUxSAkEkeXOR9tV5g3bKzjxgGWlgCbkFGdU3XHmsNfgMdpfZxK9KwL1fGXfurM5lsoDjqhNC2hn2Mh8HlQLCG/z5RCdQtzzowxDKTn3ET9WkiaME2QnJe0OxV1vofk3ZRq4sSlYgBg8i/UW8EJ9ZbJPH0LXXYQ4/7Dy/hSiKwIWIIcVVTmh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x+mOjrjT5ZspT9CE0WOPCsfraun/iEFCNu/miCf+zA=;
 b=K5z8Ex9XBf6jW6685q4Iol78v/woeK/Hcvj3YuZ9ImMYj1Xk7g6Jjegz/PClS5aFQGdjocWsjXPBMO4X0OYLaWTzGXvm2vSndS7gnnzyuZEFuN1MkRBV5PdPhnMNp6vAYbImSasj/6hOEgP+pYeDtn72iFVPxjyqvQOe8og3laSX+rr+wzGVsFnm5pHjkW/S9YkYMgwuf6XN28S2deB5uhW8uvpGV90/KQ6GMCq0Tu0aHrjG6PEs8JwHqSYupCd2hqG6aisq59dcuYb817hE3HyRitJHbNXDx/7Jj+6tjxmkMlLy1ONbF2/3ox607R5wFxvPQuaV7V9sTYt2n8bewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x+mOjrjT5ZspT9CE0WOPCsfraun/iEFCNu/miCf+zA=;
 b=AfR8sivonkOzNbJiH14NGgn3YJSq5b98ldX5so9ZY9g/wxiuqDv3dUUtY1S9w3JtwJa5eKbIyaI9w4EGOcReWyPFTH2mIhoiN8kuFcg5r4vkO6bB0VFievXglLT/y71pzSY1zxga7UQJqwP6fYkeg2BEOSKC56zAC+5jQCq6GKA=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB4960.namprd10.prod.outlook.com (2603:10b6:5:38c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 15:17:42 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 15:17:42 +0000
Message-ID: <8d3c80f0-7ec1-4b6e-3e3f-87be1ef8c8cb@oracle.com>
Date:   Fri, 15 Apr 2022 10:17:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] iscsi: set session to FREE state after unbind session
 in remove session
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linfeilong@huawei.com
References: <20220414014947.4168447-1-haowenchao@huawei.com>
 <20220414014947.4168447-3-haowenchao@huawei.com>
 <a8087705-2cea-f01c-ce67-639e97edc30a@oracle.com>
 <f587206a-4479-1748-9211-086d79249b95@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <f587206a-4479-1748-9211-086d79249b95@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR01CA0013.prod.exchangelabs.com (2603:10b6:5:296::18)
 To DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b0178d5-7d57-48c0-82b5-08da1ef31620
X-MS-TrafficTypeDiagnostic: DS7PR10MB4960:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB496058BA900E8539E09295B3F1EE9@DS7PR10MB4960.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eg1BtoUr6dWW7lBnRy+ZOiCyAuRO5HV61aXCMYwqOq03aRgEet59yiDiv7bwNW8aHM77YpsgQtbGbX2fy5lzTT/EwyQKdyo0E2rrJTDhBdthqIYxbW0xBX9QG0kRjjC5iDxCG51KMsBGcjzg+gGIHhc9Ki4GKQml0HfttEYsFy3E7RcKy03i1kAdh0q3thwZMWdwK6Z0ZilCK1ngs6AGoAerxsi2WhbmM7UayX074/ipgtc6lPY32HUGTmwpaxymlLv3z7QcNjnklo8TUtRZAv9qwx7gsmFk0vPD8ng0mHQVSafMnAfy72TVxL7RMSkYLEKYrTiwlBS5mpnhkOefRE5n5bXnsjzJ84iHzQNpOFjj1CszPNU29zXTdEtHQqqqqwslElMCmnnN3bx64erw4f//cuPD8+9gdCga+/a+d6kLRDB99fZqF9j60e8qCD+FH3V9a3TAx7O4h2WOzQth2crGILvAeftWh+kKdm0B1SMrnto29DkjRQxt2bfLmyLb1xSucByEpK36qBLsI4VYDRyU/6cNtEH6Y6acfwIPacQXx39tRVnrBfzA9o3cow3cMooM8zhYkdV8rSLtbM6Ts9sWiy0RIUjGXE1Wch0hFo9M3l1drYlTP0k4nsiKXI+8StqdVgxIT4Xy+kpP1CtdFqtW8eFSyPtJprAKP61y3Z+Y3h/X+DvGUsljHcLNYXSqJ4G5IdPQMl38rOtT9tWrvsW0SSs/UWbUIShObsW7v8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(66946007)(66476007)(66556008)(83380400001)(8676002)(186003)(5660300002)(86362001)(316002)(2616005)(8936002)(4326008)(2906002)(31696002)(31686004)(53546011)(6512007)(6506007)(36756003)(6486002)(38100700002)(26005)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmFCSU9GcWM3QVN5R3hEVXpxeDJhZjEyazJ5NFA3emx0V3JScGlUeEtTUWJK?=
 =?utf-8?B?SlJ6dTR1emNLZzlxeUZCVHM4bUtqNFJRSjF2WlVLbTBFWEFnOGhnb1JUVWJv?=
 =?utf-8?B?bUd3NWNGOXZZeVpNTWVOODRlZ01UcjVxV0RBemNVUGk3ek5kOGxzQlIreGZK?=
 =?utf-8?B?VFlmNkZDelFHWituTzJFTkV1NFdrRmJqZVZUSDkrMkVPaHhqNnhhOU1BYXB4?=
 =?utf-8?B?QURTM2orRWJmNHdoWFdxRGczamtsRHdwSENWZlBOUzlLZ2t5cHNwKzFtRkZ6?=
 =?utf-8?B?MmdoSFd6NUdJMFJpd2p0RE5ickp1OHJZRFVWdjNNZXRpTnp3V0xDamRoeUNu?=
 =?utf-8?B?RnRuWVZlUkhnNXBhcnc3UjlGcTVvYzUyekxsTCtwb3E1bVJuaWxnOHM0SndG?=
 =?utf-8?B?enBHZmxVeE93bDkwenc4eDhPcGdmeWNxa21uVXFxNmdyVzc4QWo1M0hlWHpz?=
 =?utf-8?B?VGtlTEJCVUd3Q0xaWmk2T1poSHYxdEduK0JZMG5NTUpzS3RXNnhZeHhLNThG?=
 =?utf-8?B?R1oxYnhvKy9WMjdKZUlDa1FHbGI3LzVLY1pZcG5rZXc2bXRPWGhDQWhiKzR0?=
 =?utf-8?B?WnlIQUlLVzhYdThTMkNaNDgxclhwbFNpMFkzQjNsK2RISW5HTjljZjlaZ0c1?=
 =?utf-8?B?Z1NlNjNTNmpHblVIOW9FOEt2OWFMd0krU20xUEhwYjA4RHI5c0tROFBGWDQ0?=
 =?utf-8?B?Zlp6ZW5leEdSeUdROTNIeEFHSHlyMlErT0laUGEvS1Q2VU1BTGZRNEthbGZ2?=
 =?utf-8?B?cDdIT3dvL21Sd09OcFNIRDdhOEFRTTBtUGYzUkF2aW0xM3ZyMWNQQW15eTRR?=
 =?utf-8?B?c3pDSW9OVUk5TlhYa1RaZWFQdzk0SVhOYXo3SEREdy9YR0oxVGRPOUhpZy9m?=
 =?utf-8?B?ZTE5WUFoTTFhZ0xhN2NTTFpYMEx2NStkczV2ZDJMM2pCRHdPODV1a2g2MEQz?=
 =?utf-8?B?aWxyTnJqbjJiTEVocmwrR3p6dEtZeGR0ck5mcVpsVFd0d2lNTlJ6ZzFaVmZ1?=
 =?utf-8?B?alVrSittVkFrMzZGeWh0cnlsaEpUMVdnODRCQmFYcVRrWnA5NjNLajJUK0VK?=
 =?utf-8?B?VWxTbUVZdXlHQ1c2L25QdDNoK256bGlHemV6SFRVYW1YanJxV01UQW9TdFNr?=
 =?utf-8?B?a2Vra0hxcEFGOVh4dE1USFFDSkdBYllkNEJZNFdKaEc1K2dFaU5aTE00SURa?=
 =?utf-8?B?eC9EenIvSlJHdWhYRU9VMmNsMUNmd0I4bHEydEhBSE53enc5RHFiQmVYWjhG?=
 =?utf-8?B?L0VrMjZocXo1bXZWK2YyUzU0RXNTMHhWTmFCYyttSFJ3K1J2Q25NaDZCcGQ0?=
 =?utf-8?B?VGRXU3pOcStyQ3NEeU51VUNLSnB6UUxsZDRHRllacWE1RVVrRFovVHpIMytZ?=
 =?utf-8?B?Zm9iKzd6QmpTSkVHaitTL1c0ZE9ETFhldTFWOFJYYTlxSkNyZkMwMlAyVW5X?=
 =?utf-8?B?d1NNQkR1ekJuQWcwYnNUTnd6UzhPRG5pUzY5YzMrLy9QZm14TmhYa0NuN0hh?=
 =?utf-8?B?elBWMmJOWmFhNithRjZudE0yYTBuZm5LZ1VZeXVlZnZGQ3ZYRTFUbU16S1pQ?=
 =?utf-8?B?M2ZGMWt2dUx5YXIxVlBDNUNEd2lHRThmdVNPNHVoVjY1MlR2dHF6Um1YdGhO?=
 =?utf-8?B?NEQzeXVVSlZ5VVVENnlyQzJDLzEvd1JYNWZLaklMaVBoVGFMY3hwekNxam5q?=
 =?utf-8?B?Z2l2S0Vvb1BtRHJJZWRkL0Z5eGFxUTFHSjdlZUN0d2lZQXplRDZQVlVLNU9t?=
 =?utf-8?B?MUJ4RUR3QUJsNUFBRUVCTDVxRUZqNGNQcmNGVDVSdXVGTjF3R0x4STZvQ2Fj?=
 =?utf-8?B?c2pPSjh3SHVjemVkaGhPYjh3cE9pTnNQNmtMcHZSa3dtY0JuaFE4R2VNUm83?=
 =?utf-8?B?cFVEQW9Ka3hKQ1BKSW1rSC9VajFCQ1Z1RmlJM1hlTU9PaExLSUhkclJ2a1RT?=
 =?utf-8?B?Q01Gazg2US95Q2orbVpYbmY1aEo0N0tlUVMwOHk5Nk5TTzh0RC9vYkxrNkVD?=
 =?utf-8?B?NTFyQ1ovUUVabWJGSEFndXhZRVV3V2EyTzZrT3hIS1hqWEliVzUyMzRJV0Na?=
 =?utf-8?B?Z3hEZktQeTlBQ21yMXJUaEExTUhHM0gvMTEwUUZNekZTd2E4MUthRDg0MlRl?=
 =?utf-8?B?SE1NMDZCYTNZdWowRE9SMW9kTUVnNVBIVHFMNUNvVkNUS2sxUmVDKzVDWnZm?=
 =?utf-8?B?VGdnY0hBWlRPWFpTTHA2RmZmRVUyd2RRU1ZXN2lVN2hiZmFJeVFCc3hPYkxv?=
 =?utf-8?B?VGtNdWJzRlBKKzdlMmVRU2Z2dHlZckE5bXNjM2F4S09hN1VnTEw1ZWQrSW5h?=
 =?utf-8?B?cVZKVVdtSVdKV0NOQ0pOWUhEbnBKOFVTL1lRM0hmWGZ0S05kbVpJV3NVREpH?=
 =?utf-8?Q?gG8fqOWPMCbGyQAg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0178d5-7d57-48c0-82b5-08da1ef31620
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 15:17:42.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyPTe66QkShQRgSg5xntpc6RATIF/AQX/bm79W1h8ItaDoYfgc2ogM6/wl5qdSooBIIYMS6iiBn6grU7aYG62/5YVTE71mHjPMCwzs4BmHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4960
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-15_01:2022-04-14,2022-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150090
X-Proofpoint-ORIG-GUID: gpy_jpmXIQJZmMBNHF3u_obmfJagi3d4
X-Proofpoint-GUID: gpy_jpmXIQJZmMBNHF3u_obmfJagi3d4
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/22 4:40 AM, Wenchao Hao wrote:
> On 2022/4/14 23:30, Mike Christie wrote:
>> On 4/13/22 8:49 PM, Wenchao Hao wrote:
>>> __iscsi_unbind_session() set session state to ISCSI_SESSION_UNBOUND, which
>>> would overwrite the ISCSI_SESSION_FREE state.
>>>
>>> Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
>>> ---
>>>  drivers/scsi/scsi_transport_iscsi.c | 26 ++++++++++++++++----------
>>>  1 file changed, 16 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
>>> index 97a9fee02efa..d8dd9279cea8 100644
>>> --- a/drivers/scsi/scsi_transport_iscsi.c
>>> +++ b/drivers/scsi/scsi_transport_iscsi.c
>>> @@ -2173,6 +2173,22 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
>>>  	if (!cancel_work_sync(&session->block_work))
>>>  		cancel_delayed_work_sync(&session->recovery_work);
>>>  	cancel_work_sync(&session->unblock_work);
>>> +
>>> +	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
>>> +	/*
>>> +	 * qla4xxx can perform it's own scans when it runs in kernel only
>>> +	 * mode. Make sure to flush those scans.
>>> +	 */
>>> +	flush_work(&session->scan_work);
>>> +
>>> +	/*
>>> +	 * flush running unbind operations
>>> +	 * if unbind work did not queued, call __iscsi_unbind_session
>>> +	 * directly to perform target remove
>>
>> We probably don't need the flush_work test because we are going to
>> normally call __iscsi_unbind_session.
>>
> 
> I think we still need calling flush_work here. The introduce of flush_work

Above I was saying we don't need to *test* if it returned true/false.
Just always flush and then call __iscsi_unbind_session like we did
originally below. The check you added in __iscsi_unbind_session in the
first patch will detect if it's been called or not.


> is to make sure sysfs objects are removed in an correct order. There is a
> very low probability that __iscsi_unbind_session() triggered by queue_work()
> has not been finished, and iscsi_remove_session() is called. So we need
> flush_work() to make sure __iscsi_unbind_session() has done if it has been
> activated by queue_work().
> 
>> If the unbind work had already run, which is the normal case, then
>> flush_work returns false and we end up calling __iscsi_unbind_session
>> like before. That function then checks if the target is really unbound.
>> So the extra check doesn't normally buy us anything with your patches
>> because in patch 1 you fixed it so __iscsi_unbind_session doesn't send
>> the extra event.
>>
>>
>>> +	 */
>>> +	if (!flush_work(&session->unbind_work))
>>> +		__iscsi_unbind_session(&session->unbind_work);
>>> +
>>>  	/*
>>>  	 * If we are blocked let commands flow again. The lld or iscsi
>>>  	 * layer should set up the queuecommand to fail commands.
>>> @@ -2183,16 +2199,6 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
>>>  	session->state = ISCSI_SESSION_FREE;
>>>  	spin_unlock_irqrestore(&session->lock, flags);
>>>  
>>> -	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
>>> -	/*
>>> -	 * qla4xxx can perform it's own scans when it runs in kernel only
>>> -	 * mode. Make sure to flush those scans.
>>> -	 */
>>> -	flush_work(&session->scan_work);
>>> -	/* flush running unbind operations */
>>> -	flush_work(&session->unbind_work);
>>> -	__iscsi_unbind_session(&session->unbind_work);
>>> -
>>>  	/* hw iscsi may not have removed all connections from session */
>>>  	err = device_for_each_child(&session->dev, NULL,
>>>  				    iscsi_iter_destroy_conn_fn);
>>
>> .
> 

