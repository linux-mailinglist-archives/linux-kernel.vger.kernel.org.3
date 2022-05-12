Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18052522A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356299AbiELQLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356301AbiELQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:11:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870FC3B2A3
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:11:05 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CEFahX010429;
        Thu, 12 May 2022 16:10:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=u1USWRC9SJ/0LB9vjVSg+s+gpe+Y7QM/iYIilWPXFzA=;
 b=UWl9/XxMZFdp6aYPCPDvOf8wjh9Cl2ouulVIWEp9GVzGbMpH5HsWJ035DBjk8NC6aa9x
 1zunooWz7d1m4GYzp1Q/L0CllHQGtWOy8ADz+na/avNubGa0YHW9S3AGHxsiSZW8iOUK
 PZHMc3n7spTYTog6vbiU/XdSOK1IK3KuXU3LHJYOR3iC3zEUUJ81jSWEFLNoqgVSBwqk
 WUCLmLfEP64BPaQIilVuzsnfEo0DUfSgjcGsrFAj8SnyI7zlMiZGKfAeHVU0I6vrkovt
 plocY/Lcgq2Bu+wGbJqrw/d5Z64i4ouASGbRxm3dWJGiKkaMY5BGr9FjXX55mxOERZfE fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwf6ccw2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:10:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24CG5k6F008935;
        Thu, 12 May 2022 16:10:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fwf750vgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 16:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiTedDZ+Sj9zk4Zbk8bA69/e3F9dTIkl3+LmGxt+i5ufEOX5RD/Wh03ltFFgoyu2scPSdsa++WquxvKls0kagub0XOS8tsoSRcfjOaufQIc2yBkoMs6pTct17pX0N0EJoGsgb0Uwk0sUYyPvPl0KxPfExxQJpx25peZeYt5xhq2yBPxw6S0U/1PvWB5eoRsBeC8Y9oFNKw2mrIYkRkS7ofgLOsyDT2lPzevnLQ8PD3nMXZVXtEdTVF3B+XCko3afUJN726lEWB6AiWayJjm6DsRTKH5elVKxnAMp190/5EiHkWi3//7FrwSopA9nkRyg0XL8quvK1HxbxmkAjoa1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1USWRC9SJ/0LB9vjVSg+s+gpe+Y7QM/iYIilWPXFzA=;
 b=c87StSGnv+Cgzb86eBHYLIManYghR/k73qlhsJgvvx100Kj0+J9n/rVhBHhIHis7FblgTRg5gjjJQyM9+Z67pt2Gzq6+hCjrT7tqmo1CBhaBS480IjyjL3HlkMX5XIEU4EK9LIbeGEZia86aiRXMbO5Ay48pqOOr3OebhVLkS091+NBpNt/8m80BH/gABegcHASrnPKEGygxU+TWzaSePJ1oWPe3LV//td3ukbIOlJJzG1j5omRCzjJTrcMYCTNaLS9/7egL8ndUW9R2eWGqX61E8RUui1TPbVsSLz/ab+SsMyGtgfFDaVcGQ4zPKbtNsUWRYIR56kJdHzaAm1zuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1USWRC9SJ/0LB9vjVSg+s+gpe+Y7QM/iYIilWPXFzA=;
 b=a9W8816PbMbTZKuEbH/Oxv008sKzrnKpKGGRQ/6cj5bh50B4nJHdG3ZdiX11mBRDyrQJ5Q/0rtCdD3wwedMoHV5cc6CqMPaiNtxF6bKuvVFOKCQBhOJ4nTTzFA/TVSYvW7LveOHY/vv2F9qzSPlLOyPDjZvArn0+BFLBaNR9TXY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3906.namprd10.prod.outlook.com (2603:10b6:a03:1f7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 16:10:33 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 16:10:33 +0000
Message-ID: <e4120abd-c3ac-ee4d-1a0d-260126914b09@oracle.com>
Date:   Thu, 12 May 2022 11:10:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <20220505184603.1548-4-eric.devolder@oracle.com>
 <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <62089f7b-4a3e-7dc8-1cda-84583e19d6fd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697d9113-9be7-4829-853d-08da3431f131
X-MS-TrafficTypeDiagnostic: BY5PR10MB3906:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB39064CE01CDE09270F81D98097CB9@BY5PR10MB3906.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYAAaTai2xHRwNXzU70V//97+LEJwwg0AgxRp8rkDt3ZuknWPnl9W3hLhssiwj9zVSwLNSugbfVGCyi40Ut7k2AcYF70FXzZPpuhRUDULpqLiil6l9xEWGiXUfUYIBqVHeFUHECjk8W7go9PgMGzEhbcypZnDvRmTwGV8UDBb81B/SZWoZ7ZGmzxN0IpVBJdk1se2VCkjTM7otAyxwTGoOSPNLu1YP81PjHhPfj3FPAae/KTInH98XOBIa7DIJotsWf+thugzGWC5dlXbs05c4MCenk1BnBHQ4cinDXMKbwfMjs+zFnddaV37SNvn7uSTpZKsneaeRnoKBWuZuidhB1tkmEn4Ac45Tv2XvKB8OnlOC7DTtbrfC2geD1BO6Q3MfdFxrkbvYt1jYY5EvHaK4kZ3lg74Tck1Hm9/l+oad6P+vV7wVNzgJ1G9xwqXWttpSpF86Gvjs7S5AnELgNjDhnTna6kAB2JkbSGEWp6hnifD+05VKJzZGHwyaUAwtZl5LKnPVhZ1A8Os7Uykn6++uuoeYWGm2jNC2m3eiM+bPjXPcr5vCp6OIEFsY4IfODtNI3QAqPS+p9oArBskVuZGBEg9giGNk1GZjkXaD9f8vAkUB4QzTscijF2a3UFxlQ1vkqj9cP2Tr22BpT7oMESFT5BIkZhZvWZNdeod6rtArfExYshqZ0fhPlXKTsa6YrN57/4Y+ZYkRSi1Tu3w4nGVur7bMmcB+UOWQK8ymNpb30/krR61VuIxQSS+xY6+bGNPauyp5c6DhCIydA//FvA3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(8676002)(2616005)(5660300002)(31696002)(4326008)(86362001)(53546011)(2906002)(6506007)(6666004)(6486002)(83380400001)(7416002)(508600001)(8936002)(316002)(38100700002)(31686004)(36756003)(186003)(66946007)(66556008)(66476007)(107886003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBnSG9VUjl3L1BmNk1qN2thaEJpbEFBOXBGSWEvMTN1dW1HQ1FpdW5yVXpR?=
 =?utf-8?B?UGhvV09yWkJ6blhJdUhycnJKTzREVmcrdkFLWm5ySThwOHQ2L055R3ZLeEVy?=
 =?utf-8?B?VkdhVk9UTkoyeSs5akY2N0VrTm16RXRtOHBOZ3R2OVdkL3NIUmR3NE5pQXZP?=
 =?utf-8?B?SWl5ZTJPUDVwR1lKbURYUDVKNk9tMHYwb0ZDa0RKR3phcGwvcUR0ZHFIaWNR?=
 =?utf-8?B?bS9aR1k1UHc2V1p0VnhScEpLMEJYMFR6L0toUGZkdXdZaDQ5OHFTMVJZaUZm?=
 =?utf-8?B?azRXbDdIWXBrbTRma2k4U3Q1UDdpVU1kT2x6NkNzajV5VWJKSTlLSDJ1T0VS?=
 =?utf-8?B?NHFsbGtZQ3NMalgwMjYrd3BjNFVnV0NuUmtMcFZWemNrYTBCWjBJVDc5UzBn?=
 =?utf-8?B?SGtwWG51SlVDUVpyVnRaMkRqTTdVZFJYOVVsK3BTREdodzY5Njh5ckF2ZlZs?=
 =?utf-8?B?ZG1qZGYvU3NTOEdLbjB5SHJ1TkNjanZUWHJFdTFaYk1LVVR3YkltVkhlaFk0?=
 =?utf-8?B?c3EwLzgwUVNpUk9FbGJzY0R2UnNJUTRseDBsR2UxSWRaTjZPQW9GUXBCT0E0?=
 =?utf-8?B?MkJzY1FFRFpVYVo5RnpmTVJHWDY5MzR2MUhFVkxqQlZwektXTS90MWFwQnU5?=
 =?utf-8?B?cGkvaVlpYUoxUThKVmlERUs1bjBxTE5XakNPLzlsTjhma0lmV1ZVZ2pXdCtj?=
 =?utf-8?B?QTRvUFE3bkloMGl0OGRDbnFQcmg1aHZiSnZzcTI5OXVnektnK1ZRdHZ2c0VX?=
 =?utf-8?B?V1VPblM1VlhBNHBWT29wdExlcnBRUlRLTDRsWFdnbTZiblBINTZyR0VITXJp?=
 =?utf-8?B?ZndCVlo5eTZVYTVsZU5CK0JPRS9IRzRrM2IxYjFUU1RGdGlYWG5pc1V3eE5B?=
 =?utf-8?B?Y3lQR3dsRHZ0SjI1Ryt4cjRxcDZ1VFdGdnEvZEk5MFAxd3g2UmhuME44Smda?=
 =?utf-8?B?ZWFGWFRoMURaY3BzSWhFWVVkdXJaZTVVMVNyZ2EwbFE0YytJMGZqNkxyRDN1?=
 =?utf-8?B?ZlVGUkNUZk9NdkZRQmRNcmdtOHBSVHpXUzVIRzF0RXZsUC9aWWhNdTc4YXhm?=
 =?utf-8?B?TmpnWVNmTHhXT1FEMTZ3LytqOC9pekZYTmN1YlZWeVJ3d1BxNWJxTWlpdE4r?=
 =?utf-8?B?eTM2aEZ3WlhHU3VVUXNHSkQ4VXFyUGsza0RraDRkdVZkSzVac09ob0xPOTBH?=
 =?utf-8?B?cUg4UVM1RDFIcExMSGZUbEczWVY5TUVPQzYzTklIcUxNUkpsTjVnbTUwZmpD?=
 =?utf-8?B?VWF5MzNDajhNTkI3ZHZzVHNxTXNxZEh3b2loZTRaQ0F0NHp1MlltQkJocEVn?=
 =?utf-8?B?UnQ1L29vQlJHdVVFS0JjTHo4cXUwVHBDWnVTVWlXa3VIVnZuZVNLM1ZmelRM?=
 =?utf-8?B?bDZVMmlCcldIMC9DODFva0JrN1VTK2IvZHF0SUlJYWhVbjVJMDJjQ2ROUWcy?=
 =?utf-8?B?UWd0dFUvMWdNY1gxUkRIZ0YyMnBadXduYXdzOG5NM2o3L3BKbjNsMFZPcnR5?=
 =?utf-8?B?c1ZpSjV6Y2RjVXQ5NzVTL3VFNmU4RndZcFlFRHZaZUZzbENBeFhuMTRZN0ZT?=
 =?utf-8?B?SG5YcmFucUxTOC9GVGdUazBQSDJrcVV3YjNjN0g4cTljcDNBVHlnd2MyZnRZ?=
 =?utf-8?B?NXloZEtNYzllMi81eDJrOGFVZTVUY3JKVTdaMVdQbFZ5OWN5NWV4U1RCY1JB?=
 =?utf-8?B?VFo0ejVyUklmSHFtOERKc2hpYTNaMU5nY2NWc3Q5R040NkxQK2hRdHlYclNm?=
 =?utf-8?B?cGJuUGEwV05rMVRpQUtXVjZrZzBoaG5DU3lUUXFpMWR6bHdzNzUxUlZHVkZs?=
 =?utf-8?B?WTZ2VDZ2dFpwcFdtR3JBa21NTTVIMDVidzU5ZDZJUVhxcyt3OWwzdElMYS9y?=
 =?utf-8?B?SVdwM3gvZEx2NzJZWnAwcmtYbmE2ZjdUK24xZDUvclJlNmhPQ1hsdTFVWjhy?=
 =?utf-8?B?aFRCNE9KK2tOYlNZbmlucTF2QTJsbENmSCtkQUtobjgrc2xLa2h5WVhxQTVp?=
 =?utf-8?B?OHQxaTYrWDVIakJwU1JMMnJwbVFWS2poQ202YzdlSUZzM0dRMlQrb2o2dHhI?=
 =?utf-8?B?ejY2VFl3MGMwMG03ckJGTWo0ZzB6LzNqS2hDWXNaWHNTYnB3a2xWNHdLQ3pU?=
 =?utf-8?B?cCtJQnpMUXRZMDE0cHk3bEp2ODV6b3k1aGJyVWI4NGdxRVBDWmNHVkJrREJR?=
 =?utf-8?B?d1o4UDU4bHd5SkJMY3B6MlZKdklMczYvejJIeXd6dytqaWxOMG9iVmhUb0s1?=
 =?utf-8?B?d3Yxc3EwYTUrN204YkZaUkFxNHhnSHlMUFYrMk5qdGQ5R1ZkUTZMeWhIN3A5?=
 =?utf-8?B?SXhIVzR4eHZvWHIyeXZBUUZ0eGFVajVKZmV4eUZ5UTN0ejQ4VkdRMVdMUkZT?=
 =?utf-8?Q?CZD3LYq2zfNojlZfnd9H9eJsLXj+sjKjvsKpI8PHyqfy6?=
X-MS-Exchange-AntiSpam-MessageData-1: MQ5uhFGWVTxvQQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697d9113-9be7-4829-853d-08da3431f131
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 16:10:33.2348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wMKHh7b24k8YExD5y4QKpgztKUWfBJXEHSDl5IWgX2puzdo3BAOYGJrodOlg+UjM6I7WO6aXRmQvw1SSnpDUiuMUCKH1eDRCJANxRNwXejU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3906
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_09:2022-05-12,2022-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120076
X-Proofpoint-ORIG-GUID: kB_W0E4vd5gb8SdluDO4tC2GOnz5QnLc
X-Proofpoint-GUID: kB_W0E4vd5gb8SdluDO4tC2GOnz5QnLc
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David,
Great questions! See inline responses below.
eric

On 5/12/22 03:52, David Hildenbrand wrote:
> On 05.05.22 20:45, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> to handle the hot plug/unplug event. Then handle_hotplug_event()
>> dispatches the event to the architecture specific
>> arch_crash_handle_hotplug_event(). During the process, the
>> kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> 
> [...]
> 
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +void __weak arch_crash_handle_hotplug_event(struct kimage *image,
>> +							unsigned int hp_action, unsigned int cpu)
>> +{
>> +	WARN(1, "crash hotplug handler not implemented");
> 
> 
> Won't that trigger on any arch that has CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG?
> I mean, you only implement it for x86 later in this series. Or what else stops this WARN from
> triggering?
> 
You're correct. What about: printk_once(KERN_DEBUG "...") ?

>> +}
>> +
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	if (!mutex_trylock(&kexec_mutex))
>> +		return;
> 
> This looks wrong. What if you offline memory but for some reason the mutex
> is currently locked? You'd miss updating the vmcore, which would be broken.
> 
> Why is this trylock in place? Some workaround for potential locking issues,
> or what is the rationale?

I took this from kernel/kexec.c:do_my_load(), but you are right, this is not
right.

      *
      * KISS: always take the mutex.
      */
     if (!mutex_trylock(&kexec_mutex))
         return -EBUSY;

This should simply be mutex_lock(&kexec_mutex).

> 
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		kexec_crash_image->hotplug_event = true;
> 
> 1. Why is that required? Why can't arch_crash_handle_hotplug_event() forward that
> information? I mean, *hotplug* in the anme implies that the function should be
> aware what's happening.
Member .hotplug_event is needed in crash_prepare_elf64_headers(). To date, it has made
sense (to me) to pass this parameter to crash_prepare_elf64_headers() via the
struct kimage, rather than directly. The patch "crash: prototype change for 
crash_prepare_elf64_headers" changes crash_prepare_elf64_headers() to accept the
struct kimage. If it is so desired, it could just as well be changed to pass just
this one parameter; though struct kimage seems a more useful way to go.

> 
> 2. Why can't the unprotect+reprotect not be done inside
> arch_crash_handle_hotplug_event() ? It's all arch specific either way.
> 
> IMHO, this code here should be as simple as
> 
> if (kexec_crash_image)
> 	arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
> 

The intent of this code was to be generic infrastructure. Just invoking the
arch_crash_handle_hotplug_event() would certainly be as generic as it gets.
But there were a series of steps that seemed to be common, so those I hoisted
into this bit of code.

> 3. Why do we have to forward the CPU for CPU onlining/offlining but not the
> memory block id (or similar) when onlining/offlining a memory block?
 From patch "kexec: exclude hot remove cpu from elfcorehdr notes" commit message:

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

If there is a better CPUHP_ to use than _DYN, I'd be all for that!

> 
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(kexec_crash_image, hp_action, cpu);
>> +
>> +		/* No longer handling a hotplug event */
>> +		kexec_crash_image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +									"crash/cpuhp",
>> +									crash_cpuhp_online,
>> +									crash_cpuhp_offline);
> 
> Ehm, this indentation looks very weird.
> 
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
> 
> 
