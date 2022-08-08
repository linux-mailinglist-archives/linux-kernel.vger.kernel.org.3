Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EF158CB34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243629AbiHHPVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbiHHPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:20:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F88E0ED
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:20:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278F9JqJ009513;
        Mon, 8 Aug 2022 15:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I1X4MgpGbtVYk5i2Ww2JgPK4L0n592G0dpLI4mgvS4E=;
 b=ollsKZRk3uweFA1zLjOiKbmNVoHBxtfpWBV49zOqx/VewsWmNfLqrYq/nEIbjkSlcxTE
 dN1h4D2JRnyLqH7O/n1ctoicjouUfsoCJ6ZWgFtjejPkXE0hYkvVOJFKz9i6hX0hD6V6
 YxO0AeQ2T6Tifuu7oQbJ6kYrha7jR0Kw5tegtVZTmZQhxy30uXWQsP88uTktSezalU+j
 NJ13dnweKaLMIILKNCyIfkZ4y+CYJtwyPzQboTL8gysm3pKpyI3UmAcfbYRRSohe3NlR
 FYepQXZ26k3M7CgysqduFZZuGsugL+UeyFWkHnwVl96DRwJ6g8Jul9ceMLriJLtJYpMK uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsgut3ud0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:20:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 278DfSP3012597;
        Mon, 8 Aug 2022 15:20:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hser82ktd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Aug 2022 15:20:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obY1bI8PQiT1RHrZISlDp69GYVfahxz6pg3rmBtsj2VhX8BrHrprezh/SE/pfDs4rNoh1yy3713OCYTbtOan9uYFQ+yjNBbgJq236t2wAoL/3IEVnJ2Ne9x3wV6TZ7dRR8BOxuSBb/6quEh/5JaqtUvjA5eUWGKY7gJXJSQn3gm9+nPbftdHo/iGFoL++NuT7HEVi9TyiK3qDThrgfxyo1Oc1Wk+uS1rh6dk2W3DeFrkeKV4c7/Aoah+2OJbp8jNcJJewEOqohIROb7iPpnHzTJiwY28YR62V5WsixeLJden+TNA6XbwggjCkE24E+RVyNwHZOhnWnqbGAStf9aa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1X4MgpGbtVYk5i2Ww2JgPK4L0n592G0dpLI4mgvS4E=;
 b=N5sg7E4K23T/6vbmXtOXNd9cz5RrYOK8+aCIuHndoO0hErYjDuIUDBXfj9xboch0DRWZAvIiXSu5zbwgerVin1+5LEAe3K6B+uTXKti6KjO1KeNo9efKTWPLHxkWD7MGWQmjUGKXS208ZUlBRCxrUsNAHrhjRR+TZetWvU/WvBJznebYDzmn1hND30ak0BReFZf+QZADXnXszlykvVDaJyKiUewJfKzEw2l+SUpHyBQjX0sBdRN4wtH90m/zUq+VH9rSwJkM8zwo8R8YLYwcLuSNxW3eRcZ92h9akFieq5nP7DEMOVry71L+MZD0sWgu72BQr00Xh1pfob4dd9z5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1X4MgpGbtVYk5i2Ww2JgPK4L0n592G0dpLI4mgvS4E=;
 b=GFJJz4ZRdpBtqEzQDBQuZn4p3U7lqBwCnCC7Adu0wynMOBL074vNVbowP4Cch3aaEexd0+FHzzWMaszqzoaf6BZFNnWSeTMAInTxug0gOPOrvqCfcm8gHTBkgY2HxDSfG1/U8WVE9RIyY3k3+2IdYXEH4VuDFwF3mlp/r/l5kLU=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB4099.namprd10.prod.outlook.com (2603:10b6:408:b7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 15:20:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%7]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:20:17 +0000
Message-ID: <bbc09ba9-dd24-deca-cbcd-92296a026fd2@oracle.com>
Date:   Mon, 8 Aug 2022 10:20:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v10 4/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220721181747.1640-1-eric.devolder@oracle.com>
 <20220721181747.1640-5-eric.devolder@oracle.com>
 <YvDXmmCBXWAFkehc@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <YvDXmmCBXWAFkehc@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d64dfd9-3ec7-4ca7-ec8b-08da79517fec
X-MS-TrafficTypeDiagnostic: BN8PR10MB4099:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSajvgNlJsp++OjU+lHioKAxemypGKMRpyConVaELrXkQaYpk9urONtGVXDcmzBu0/05NW3RysHJXGu1OwBdtbVdpqKDGNbAKzDBIuMK54mLMyg1+/uSK6HrgU0/5kU+PSEhxXHuUXY6mkdpElndtJmOFVslr+wYRSFbX4AED0Ei4fsQMKkRYJGSznE2rWHKibpjCwCc/vW/16YlhecjhxehvwwJkX2x14D5frNrAHCUdeMyAxLSydVh5ORjQllPGI/HVNqiQAqhaucR7B7S5PuQOUg/yDCv05Gfsg/YebsbTs6uR50e3Q9JQLeDvf9bDEn7Yzr1iVz3wozsNdteRC0mdZa3fcLRQss/SaL80f+nC+tWanU8WnjkwvA0hH12p9g8oE4GHs5EltQnXTgEX5+ZL3qK9kYisixB2q7QAGsXZrGwmP4CW1WjxKzGrqO5zmhUYpiS8EFEVqyeJ4mXTt6ebZvCf5YcZZI3ossr+bUh+We6GvpKveWE+437bgHqgXJpktu429kLQzyF7yunBf8KvSOpIIuPw5662xaIEkmYlveya2hIPQwMUVITJPfZV86o/e+VGRpOI+5BElmy99cFkMWc6+alhq/kO63jqupuv6V7c2BdBxFxAUlhMdjR+qJHHg+Y6/jY4z24Dky2mpGWvl7xeETqC9gHTFh7LljPpCjRiUroH4CDKqlkv27ZM4pMivBCgr9QYLNCLU50AmGvisdJOtEQY3xijZfMTWKWyYHZipnU7sg3uvoP/i4wB5XyEBFpKVPgIqUwqlszTSsPj+kNeOgB37ULnrjubkwjFvOhY9GFAT98f7usZrc/EcwazeQGR8SN+jwL6sWIvLdrXIfSb9Z8QHWam943/4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(376002)(39860400002)(136003)(396003)(4326008)(31686004)(6916009)(7416002)(8936002)(66476007)(8676002)(6486002)(66946007)(186003)(66556008)(5660300002)(316002)(36756003)(478600001)(107886003)(2906002)(6512007)(41300700001)(6666004)(6506007)(53546011)(83380400001)(38100700002)(86362001)(31696002)(2616005)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThtcDVPZlJ1SXZpYlFFOElTdFhpSTJTRFN4SlBUYnBXbVZCQ2VqaWg4S3dJ?=
 =?utf-8?B?TlZNU3hXVTJLeHdzckVKSWRNUzNvZU8rWVBxNVpzY3dBVU5TV1RaTFRab2p1?=
 =?utf-8?B?U3JMTWtiS2lhTUdudWJaSkxoZndFbnBhNzBCNk5WMDQvWXR1WTRtWW51TTB2?=
 =?utf-8?B?dW1kdmlDZ2lZUXY0eC9mRDQ4QWhxMlAyRmRmeWZFTlNNVE44cFlHWUxaMnMz?=
 =?utf-8?B?bGRSN2lGQUpVT3F6ZXJZUGJuRUhzcTQ0Z2RFaVB3OE5aY1RQWW94SXRnb2JF?=
 =?utf-8?B?QzlGQjBMS09XNXF4TURwV2N6L0tsbVVORUk0ZU42Snh2WHRjcWJEKzlhVmhM?=
 =?utf-8?B?WjFRUENDZVFoVkd0eFVldWk3UFZ6ZGxxSTJqVnBSNDFQaEVqQmQvYVZwbzZC?=
 =?utf-8?B?VkVmVng0QkVJRk96cnlZYVdieFhkdDQvTFNuZ29Gd2JIakUxVFpFS0RlcGVw?=
 =?utf-8?B?YS8yOTVlbkpVb0tCS1BCUE9td3Z0SE1LaXJyVXIwMiszcnJTVmx0aCtDWFJx?=
 =?utf-8?B?T09GQUtGRmRpSDlXMjRoQmJ6aTlQZkkvWkJaekZoS2FwSm50TDFJbFdTK3Zm?=
 =?utf-8?B?dnFxeEFMbTE2USsvczNKZlE3QmlYNUdxMm9PdlpHU0hsVVZNUzNTV1ZDZzBL?=
 =?utf-8?B?ZnQ3SDkrK1MrYmpOS1Q0OWphbDFhbVIyc0NIcHR3ZjhiNW5wWjRoUEgxY0FD?=
 =?utf-8?B?L2VicW94T2NjMS9WUWdTaFVWaUNBeXY5dWdNYmh0YTJvWWdJQ0x4RDc0NkJI?=
 =?utf-8?B?cUt2ZDNFeVM0VFRoVFVkWDBxYU9ORmU3R3h5Y3NqNEVnSFBMNUVwRTlaN2ZD?=
 =?utf-8?B?Ym9WeFJkRlZmWTJINDdiSnVUQ0RHQUFGWWpwY2NPQ0hMMzA5cVN2WDE5ODZT?=
 =?utf-8?B?TDc4MEcyYk5yTGRhQ3BnWGM3M0lWRmh2d1dpR3JrUFdoellrODlLQ0lYRFZO?=
 =?utf-8?B?MGhUVlcvcU0zK01ETzVNZ1FRN2gyNjNhdTNMZ095QVEvY3ZzeHhnY3VhMnZI?=
 =?utf-8?B?SVRScXZxQWRpUVFjYlpraGxoeXdhd29LMHkweTRDdksxU3N4c1RyTFZVdURI?=
 =?utf-8?B?WG1xRldxOHltbVFGMG5ENnpuNFlZK1hOUk5FNFdQbHFtNDd2RTcvbjFadjFr?=
 =?utf-8?B?Q3F2SkI5cDlnLyswaEMreGsrbGErbEtna0JLTERTTVhQdE5HYWJTcmJSUVFn?=
 =?utf-8?B?M0FPTVlDSUdWVUgxSlg3UlBkT2ZKUjBXZytaa3BqOXpKQ0hXZCtlanM2ZjRt?=
 =?utf-8?B?NVFGZWRrUjJsUHR0b2hLSHRETFpCUHppMC9XeDBVcEJlRFdxTDJudlZjMEVq?=
 =?utf-8?B?ME9oWVBlRFAwU1NDbGpDL1B2ZHNWZ0l4Tm9RSXJMTG5MbktNa1RybXI5SEV2?=
 =?utf-8?B?NjRPdElEcHo5d2trZUxGSzRJZHlZSkdNQzVkcVJpWTVvS2M4dTVPQ2RJdEZJ?=
 =?utf-8?B?czZDakErblFHQ05oTFhSVlNzanllSWdEaG1qMm4rVG9nd3lrMTVzczg2YlVD?=
 =?utf-8?B?b1o1bXlGTlpIS2xBL2h6bmVkSlREdXlmMDhiRzArT05PVS9pNlZHYUxvaDNU?=
 =?utf-8?B?Q1g1RDJyR0o3VVg5WlpUaWRhbmVMM1I0MENzN3JMZVBaUHRUeGl3SmhFZVVw?=
 =?utf-8?B?UU1HK3N6VTFqSFRjbnFhWEZTSTFvUFBJNWpENzlSTDVWSWJITjJqMFBzSksv?=
 =?utf-8?B?ZmNlYU9GWFQzQ0xkU05xdC9sbXp3K0pEZzRwWmVVTHY2dmdqNGtpZEZJdkJj?=
 =?utf-8?B?cG5objhVZ1BTZ2ZRTDhUa0lTalRNMzMwNlMvNW5YMWtBb0VITUxjakVxTWU5?=
 =?utf-8?B?VjhtZUF3YzVzK28wT01JdVpxYTdYOXdPVzI2czVpa1NPK2RrMEZxWmU2cWtI?=
 =?utf-8?B?U3lXZWpHZjR4d3VQWmMvVjZCQzlBbTJJNG5hRU84ZEQ1Nm1kbnp3bmhJYlZX?=
 =?utf-8?B?bUgzQUtES1o1TWI0dWRDbXZhY1dNL1BZYWJSc1dOUVRZb2c0WWFqdVpnZy9R?=
 =?utf-8?B?ZnJsQTd6MXB5RGVGRDVZZ2toSDMvNHFPOWY5Rm1ZcTlRWVNBSmlneG9vMEdj?=
 =?utf-8?B?YUVGRTYrcno5b2FlYkpqU2pNby9zdWNlVklTUEdZZWt4cUh1Q2tlVGN0eml3?=
 =?utf-8?B?MnQvMzhaVThQS1JDRzBYYkpkTUNZdFNEdzFrNmt1endUQ3RBOEc4SjZBc29V?=
 =?utf-8?Q?DFwBcLX9eEY+9w6rKODXEo0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d64dfd9-3ec7-4ca7-ec8b-08da79517fec
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:20:17.3922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sifwSs/exZ+am022UWazpzEIbIMnh/CGPfhvzOcYtANn7JxP7aXDZoLxr9An1A1v5hlDXmKfhtEh8Xbp5elRLsadSC227LYzWuvt+NYOQds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB4099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080074
X-Proofpoint-ORIG-GUID: dq8lr-_DsEWR-6YC36O1w8H0aLXPhsRz
X-Proofpoint-GUID: dq8lr-_DsEWR-6YC36O1w8H0aLXPhsRz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/22 04:30, Baoquan He wrote:
> On 07/21/22 at 02:17pm, Eric DeVolder wrote:
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
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/crash_core.h |  24 ++++++++
>>   include/linux/kexec.h      |   7 +++
>>   kernel/crash_core.c        | 118 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 149 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index cb0f1916fbf5..c9705b6872e7 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -86,4 +86,28 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>   		unsigned long long *crash_size, unsigned long long *crash_base);
>>   
>> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
>> +#define KEXEC_CRASH_HP_ADD_CPU			1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
>> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
>> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
>> +
>> +struct kimage;
>> +#ifndef arch_map_crash_pages
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +		unsigned long size)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void **ptr) { }
>> +#endif
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action, unsigned int cpu)
>> +{
>> +}
>> +#endif
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 5f4969cf3f4e..7694aa77b92b 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -340,6 +340,13 @@ struct kimage {
>>   	struct purgatory_info purgatory_info;
>>   #endif
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>>   	void *ima_buffer;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 212d4dad0ec7..154ef532d45a 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -10,12 +10,16 @@
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>>   
>>   #include <crypto/sha1.h>
>>   
>> +#include "kexec_internal.h"
>> +
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>>   size_t vmcoreinfo_size;
>> @@ -587,3 +591,117 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	mutex_lock(&kexec_mutex);
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		struct kimage *image = kexec_crash_image;
>> +
>> +		pr_debug("crash hp: hp_action %u, cpu %u", hp_action, cpu);
> 
> We don't need to check if it's cpu hotplug action here? Then for mem
> hotplug actions, we also get:
>                  "crash hp: hp_action 2, cpu 0"
> That cpu 0 will be confusing. And you forgot the line break.
> 
> Can we do like this:
> 		pr_debug("crash hp: hp_action %u ", hp_action);
> 		if (hp_action == KEXEC_CRASH_HP_REMOVE_CPU ||
> 		    hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> 			pr_debug("cpu %u \n", cpu);
> 
> Other than this, the patch looks good to me.

OK, I'll make the changes you suggest, thanks!
eric

> 
>> +
>> +		/*
>> +		 * When the struct kimage is alloced, it is wiped to zero, so
>> +		 * the elfcorehdr_index_valid defaults to false. Find the
>> +		 * segment containing the elfcorehdr, if not already found.
>> +		 * This works for both the kexec_load and kexec_file_load paths.
>> +		 */
>> +		if (!image->elfcorehdr_index_valid) {
>> +			unsigned char *ptr;
>> +			unsigned long mem, memsz;
>> +			unsigned int n;
>> +
>> +			for (n = 0; n < image->nr_segments; n++) {
>> +				mem = image->segment[n].mem;
>> +				memsz = image->segment[n].memsz;
>> +				ptr = arch_map_crash_pages(mem, memsz);
>> +				if (ptr) {
>> +					/* The segment containing elfcorehdr */
>> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +						image->elfcorehdr_index = (int)n;
>> +						image->elfcorehdr_index_valid = true;
>> +					}
>> +				}
>> +				arch_unmap_crash_pages((void **)&ptr);
>> +			}
>> +		}
>> +
>> +		if (!image->elfcorehdr_index_valid) {
>> +			pr_err("crash hp: unable to locate elfcorehdr segment");
>> +			goto out;
>> +		}
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(image, hp_action, cpu);
>> +
>> +		/* No longer handling a hotplug event */
>> +		image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +out:
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
>> +						   "crash/cpuhp",
>> +						   crash_cpuhp_online,
>> +						   crash_cpuhp_offline);
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> -- 
>> 2.31.1
>>
> 
