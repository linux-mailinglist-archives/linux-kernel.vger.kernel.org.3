Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF90E560737
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiF2RSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiF2RSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:18:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328A21CFFD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:18:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFECoD005839;
        Wed, 29 Jun 2022 17:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HDQXZKqaw0A5rOXZ5xAzN6hKpLvNQis5UWbnEKxVxZw=;
 b=aew7oMYw8UYQxuQP9vwkGh61JZ0MRisL1VL784RGbd948A1ABjQDSfZSXqMCcHQSaCWy
 VFI3xz8mekImpvBU4FPNmuSuoZL3oGaTP5bYVH2tU+ifk5/WaPpCrJ/dcq5IjQUez6bc
 MZKnEspIKEmfo1XjYLiImYumE8wa+RTjWxILWkeCjq+VDB6zPs/H1MA1npnxb6h8mmRz
 QkjOBYxRwk4U3Bs5eXBKTVci2NgNFtOPpd+dbj4CSGQkD5iNy2e71La9N5r12bzq3qCf
 +8GNfQOnh4PLYG7Wy8j1IAv6rtBS4FvO7EEjGfKkzYINsMy22saH5F61Tf7VIbKK9LEE Yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwry0hy3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:17:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25TH6vFh025070;
        Wed, 29 Jun 2022 17:17:57 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gwrt9aqhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 17:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoK3l5LLRsC6XB+uUop6+cG4hT2RecshHNsyYQcMDxPZAPLeBVm1/hqpJ1jnev+/YPQ6TzMHBHCkvo422ujrGO5ISb5/57K61SlfGUT0eX0qgyUsjzY1l4Ycrx+dz1DkcqyZ/Lx/gv9AqRsgflfRVETA1mRhxXxECHWMMcqqg+7JKV8B+8lql9i65gWl6ISf1CoNZPtwI0MHQ6ZPWlpfeayzG0AvxOn0pblN/YDu8Bx8d2E9d1GQGwGHMQU0F5ihqBrFo01j7uAvUQwIDTIaWdfcCzvprK163agkWNtL+/fUYeP3XuXx8hHqv5/eGMCz0Wur1QYgO8kcJW6AjOqUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDQXZKqaw0A5rOXZ5xAzN6hKpLvNQis5UWbnEKxVxZw=;
 b=CCaD8LpBunRfMcRYCQlcOnN4gg2q/sWGOfQnVPQw4znLd93n92qsYfQ+XKtg4gehq4OwIOhsR6uK0Z7djU75qbYSd3uTBu7iFwQ4FQftXaA17dt58DI3dYrNqrk7tjsHT4hsiJUg3VBYTatEiP/nn8F8z4ja6M/so/Wer9/XjnFcr6ZfesW5nou7Zc92RFR+UVchrfc2ScyXrp2QglzbjTczY8d75aPuSBwa5OnB0S16dJf/4VQbQxmlY9LTnIDHlhfRhmadgaLFvqF4VDLjScUxxlmDgk/nZXP2JgMf9iVMYGLvKDoTAS6af3a0xyu8rCVM8wcEpBsE+nBF1PEuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDQXZKqaw0A5rOXZ5xAzN6hKpLvNQis5UWbnEKxVxZw=;
 b=kW4EKSs3MKT9an4GhRGYmQuKW/OrJ1rp/o9kspif6t9FvbtDPv/iUkoTJXaPQZ4AACLL90FJ7/ue1GmSG1M+rwzyznDSE61Un34kWcdFgWEwfW/tcNTjKyJoakH1ZBPLou9Ucaldxc12djb0y28Kh1hBIWhcItHy8tIIMzEOCdE=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by SA1PR10MB5782.namprd10.prod.outlook.com (2603:10b6:806:23f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 17:17:56 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::e48c:bcc0:fff3:eac6]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::e48c:bcc0:fff3:eac6%9]) with mapi id 15.20.5373.023; Wed, 29 Jun 2022
 17:17:56 +0000
Message-ID: <b77201c2-3fb2-feba-af40-22955d5fc19c@oracle.com>
Date:   Wed, 29 Jun 2022 13:17:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 0/3] x86: fix brk area initialization
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, regressions@lists.linux.dev
References: <20220623094608.7294-1-jgross@suse.com>
 <2592493b-4339-3e54-8acf-585dcf90be96@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <2592493b-4339-3e54-8acf-585dcf90be96@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:806:d2::24) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8142f033-27fe-4086-cc36-08da59f34ed0
X-MS-TrafficTypeDiagnostic: SA1PR10MB5782:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kyFcjsRUDnz2s+sAHhDpitcBospDnOf8hwbEoaeU0i+4JI8wretYciIVuIBNY9EdVoVaufnuGEqOZV+NaUFQsSYpbBrFP/hhuo9BZdmNAd91Xrl+84GMvNcZqDAl3UN3mvhPU2chKkFCfyG2oSPBrsQjP6+8t8hNqs/EeVvf2/fUa6dcMnkPEaFR3y6yrjTU2LGO2FdB15rQh0J/gOElCOfDepzGbcaPrazNA5FrzuWrnMj4OAS4Fi821EhmNNoH9O6Ll9uyD4tBtC9XM2wbQcWH11GfNn1U3esKFaRwV557O4Pjw1wuTohObyKOM/9MngM2K+jdxQHE4fKBnTcITrVBesj6iD3jwYrIkSQMryTiAWmTGUCxf1ctvZlFDrjZGa8hvhccr/Y10DNcyoEkTcfd3mzg/kDGJ3Dau48w2I3jU9JSXUP6l0fWYrj8Fi/uExpDxe2/dO8GHbO85fdAid/Y24mEKoZ6ZZ45/+yFxZHbW2zkye9HTWk/Nd15I4HTWlikndoRP+5RPrJiEDKckXNgqYCGcZGawMWYQgRWP2JgNR1iDpSg0j5XUuDNKgLRzdzGEzFdmjlpqt+Tg+6H1qKObs6t/rKyWT3nSrPjRGkROWS+T7/5utI4e7S+96/yTwxarvmumUrTqNioWsS8Nloc/lv+9cEGjtmzzd/bJXli9uMa/KSkjWwQXnaXN5ySxhTXqyknA97jVMCp7QPrWvgJFpyJiot195ElD9mNii+F9cM0dduBJN4P+IwjZwKa/4rC2JyVsBJVyII58zrQtPkz8NP75eMT2QWx0v4I5T/PSYuX/6e00Z7zxWU+YRdTtFVnv88Dx4+2JzSpMKViqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(39860400002)(366004)(376002)(136003)(2616005)(41300700001)(54906003)(186003)(66476007)(8936002)(83380400001)(38100700002)(4326008)(6486002)(66556008)(316002)(8676002)(31686004)(7416002)(6512007)(36756003)(53546011)(66946007)(478600001)(6506007)(31696002)(44832011)(26005)(6666004)(5660300002)(2906002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KytMWWhVWkdWY0M2SWZETVI5L21IR2ZSRzNRdmhRYkI5M2dBYUNRd1hoUzFD?=
 =?utf-8?B?bDhRbEFDdEpNeHNVS2N2YXpFQnNBVGZrTERHNkZ6cHkyMkFNOEt0MUNObVYw?=
 =?utf-8?B?RjlPUlJNMnBBdW1rMUJsaTFqdHJNV3hVbUk4N0Y5UHZ6WGV4eG1RWThWdEp6?=
 =?utf-8?B?aGtvazZJc1dJSjJRQ3VqQitPbWNOcVdVKzgyaHNtMEtrL05TSnMvRE0zZzFt?=
 =?utf-8?B?enI1c2c1KzlwQ21ZZG0wTlNpckkwR1pEYW9MRXpNeFJ4QzlyRW5XVHFDZVFv?=
 =?utf-8?B?SE5OSDlFQ0swVks3NVdPd25vQy9pOUZ1VnVxbVp5ZklBTjdDZ0ZwNGlKQXl4?=
 =?utf-8?B?MjFNK1RFaVZqaGw5eGdPckJpSS9ZM2ZXOHdKQ3dmWDJsNkdwZFZRZWRleXNn?=
 =?utf-8?B?RzhDNktQL2RpY1BObTZuRnhuNUpnZGlzdDZ3bzZXRVBBdmd6M2JCZUNEeFBL?=
 =?utf-8?B?WnQ2ck1zU3QvVUJITlR1b3F5NzRhaEZzZXVuMlhoNVA3cmo2SDc0a2NQcUFD?=
 =?utf-8?B?NnhZUUZoT2hVWjY3SXhXYVE0Q3I2NzhtVVErMWJpYldLL25jblluRXFZVHVX?=
 =?utf-8?B?K0JMQWw0dEhOR2ZtR3MwVDVRTXpqWGhWZ2MxM0ZQcHNkUWs1M0drYzJCaTdk?=
 =?utf-8?B?ZUIzVytoVTJZNkhHejlGRnIrQzl1Kzd5TVFKbWpGeDRwaUZ5YzMvZGlqK0Ur?=
 =?utf-8?B?ODRDWXhXYVRrT1R5a3F1aTZhclR4YXlNRUVNaEM4S0luN0ZJV2lMSGhMeFRi?=
 =?utf-8?B?ZE15R3hMM3BHcnRjQTQ2L3Q4M2lmY1pQRTg1a250bjROUFVDQkNKcHJna2s3?=
 =?utf-8?B?WkgrbDgrN3M4TjRDKzVpdzJsM2w2SnVDUURIbk1wSml6anFXSm1tajRHeVFQ?=
 =?utf-8?B?ME9qR3E1Q29VNFBvNjdTNU0zY29TY3h4SjQvL25EQ2t1SUNrcEN2a1Zkc0tj?=
 =?utf-8?B?dzM2bWhMSEZBWlB5N3hMZ3JIVWxkODFlS0toOUo5ZUhHNy9wSmZXK3Zzb2NK?=
 =?utf-8?B?ckFJd1AwalZ1VWVUeVBFZUdhWFc1L1pGR01lSDZSSGk3cWN5TkczSk0xV3g1?=
 =?utf-8?B?TFhja1h5eUdOSHN6OWpNeTBnSlNoNlZFM1JCZERqUDJJZmtHMzhMc0hWa1cx?=
 =?utf-8?B?dmlIc3BrTzJGdVZoUEZ6SGRvd0tqMXJwSi9VRmNaek80cFRoSHl4K2ErRkYv?=
 =?utf-8?B?UGk4cFJMUHJLNXRDNEhhckZWb0lBbnNMb0ZZdCtxMWo4cEtDQ3FjODRTREtP?=
 =?utf-8?B?emxBR21weldCOEJzakhtSWsrKzhPZVJ3UjdDaHJPNU1jaXBZb0duYmxQcGFX?=
 =?utf-8?B?NElQbHI5aUpBQUdMSnR0WlhPclZVQXgzYys0Q2ltM1JIbkUxSENZQlVxa2ty?=
 =?utf-8?B?ak5pWFdLOU1CQ2dIYjgrME9BOXFwRnBFQ2lSM2RueUc4ZkNYcktDTm8wOUhW?=
 =?utf-8?B?ekM5bW9IUE13TjJEVCtsMk5BLysxOW53NjNGSFdWOVZGZE9BWThFZnpvYTlD?=
 =?utf-8?B?eG5YdmgwelpzSFBvUWJ3a1VNa0FyWkZLUE51VWpWM1RjRG1LSE5Pam1TSTUv?=
 =?utf-8?B?ejZMVENKdi8yMElYWVBGOUNLdndjODJFZDhMZkxuc01RQjVJZDNhK1BSVmhK?=
 =?utf-8?B?SU1hdEZicFdHYnpKRlhVYWhuTVN5eWRKZlBiczlvOFJBM3lIb0o0NVJ6Mi92?=
 =?utf-8?B?UFk3M3ZJM1lKOFhXYWNXb3lOU0hKNWovZ2d3QWVyMlRwSldOQ3NraTg5OU9y?=
 =?utf-8?B?SGVraU9JaitEZ1g0cG9ZK3AyNG4xMnlEREk3WXRmajlzTHljRmpUY1NRN09F?=
 =?utf-8?B?WGp3YnZtQzBLRjdOYVUzaEsxc1ZGeTBRbVBKSWRpaHlFQ2FLeGUwSjFBaWp1?=
 =?utf-8?B?ajg4K1Jyc0lncWUyakdYd2hkWGxjK3ppNWlLZk1LMTh1bkwxKytBcUY0SVlR?=
 =?utf-8?B?M1dIUWhMb0NLQ1pyN1N3aCtsK1lCRVJxRHlzYkhQeVlYUzdtSHZIYW5CTEJ5?=
 =?utf-8?B?WDJYMk04bG9GRGpYS0JVS3Y0U1hGbGlmTS91Wm11SzZOaEtFYTlRZUJBaW42?=
 =?utf-8?B?N1hOSUxLZnBSQytqakF6K01EL3VRUkhQRk1CWEk1VVduZWd2UHAySUplT3ZJ?=
 =?utf-8?B?ZVJpaFZza3Jha0c4cElYcG0xL0s5eVJIWERSK2xvdW1ldTg0WVQ4OHNibTRt?=
 =?utf-8?B?MFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8142f033-27fe-4086-cc36-08da59f34ed0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 17:17:56.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mpVUgwrhAF5N2zwOvMxNSOGVxlC7TdHAL+otVui8ou/agtZXZxBsoA0THOj6WPY4PynFBSYWFREx21KL5QA3YXbOhDC1rDcFP3XKn5HePM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5782
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-29_18:2022-06-28,2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206290062
X-Proofpoint-GUID: PQ7eudLs0E5Y6lzhYKoodq8nEbFhaK8D
X-Proofpoint-ORIG-GUID: PQ7eudLs0E5Y6lzhYKoodq8nEbFhaK8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/29/22 10:10 AM, Juergen Gross wrote:
> On 23.06.22 11:46, Juergen Gross wrote:
>> The brk area needs to be zeroed initially, like the .bss section.
>> At the same time its memory should be covered by the ELF program
>> headers.
>>
>> Juergen Gross (3):
>>    x86/xen: use clear_bss() for Xen PV guests
>>    x86: fix setup of brk area
>>    x86: fix .brk attribute in linker script
>>
>>   arch/x86/include/asm/setup.h  |  3 +++
>>   arch/x86/kernel/head64.c      |  4 +++-
>>   arch/x86/kernel/vmlinux.lds.S |  2 +-
>>   arch/x86/xen/enlighten_pv.c   |  8 ++++++--
>>   arch/x86/xen/xen-head.S       | 10 +---------
>>   5 files changed, 14 insertions(+), 13 deletions(-)
>>
>
> Could I please have some feedback? This series is fixing a major
> regression regarding running as Xen PV guest (depending on kernel
> configuration system will crash very early).
>
> #regzbot ^introduced e32683c6f7d2
>


I don't think you need this for Xen bits as Jan had already reviewed it but in case you do


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

