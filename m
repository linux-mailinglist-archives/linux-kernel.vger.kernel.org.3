Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D6534FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 15:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbiEZNSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiEZNSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 09:18:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A07D413A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:18:16 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QAnCW6023111;
        Thu, 26 May 2022 13:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=NouSz4VWfTfnh5o1gLWs7KleUu4U0IiW4nvzIvYeQnk=;
 b=ESPIa32G+UgWW/7ijCz1VMeQEUmR95Xortg3NtcUBg2HYFlwde3oSNOx9fpDtnjhG0qm
 Roc+3w51SV1zJietn6qK3x0/nz5h4tdj4vQlTWOMb/M/01WgBgsjJIstMgxoGN9NamLr
 5bL8odXrIb6Pk6aka+dtxor7367weSSqyJpEns0YlRZGzEzP7GCKPyZ3jPOIJQWj0aEy
 mZe3+g0+bcrS4OboRagY5YtJDOL3F02F0Y79e59++FVW9Xasxf7HBbG+VWNCFyUIl0yS
 LCzqr3hl7+/bFoVqIncf/WOY/xsCVzpPAHoqoUU+HaAEvxhqJJjSwErBxW5BF91Q1OaN SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9vseh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 13:16:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QDGRGs036421;
        Thu, 26 May 2022 13:16:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93x1hy5k-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 13:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF8tCyGuATjy0OlIlUM3iUDjnteJXiKD0CmVDd5jagWzVOh84djfi1gKF/9yco91iBoLrJqUqmCDyBY6dggfIgh1sfxolDQwDiw04RUgkaYA+yvniCJT4D2F9M0MRlIiimn+jAE8gU+mVRgl7RiMPVoe9hPWLG7DYd5MJ+moZMHAwZ+3QDuftE4/5J8KnwEg6GkDtI8VRORac9yMCGDpuA3ygeHHqXaocXWhjZrG4pCeXZMa640ujCl9RZO3y4sibEh4chb/DexDL2U4rBgH8/xFOwIrShE1U2r2hIfXYXgnfnw8gzp5oCTcH1xGCa0dLtrNjr2Uc+6CmiemnKLPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NouSz4VWfTfnh5o1gLWs7KleUu4U0IiW4nvzIvYeQnk=;
 b=hqPjfg9/8gWzudobvxICxoZeAaBlvjWAHpSyWFLZsVCd0Ce6UNTvXRstsIPMaYE7RiwMMsIRXOU0c6S0fFljpUY65Lh89wdQ7fH3+b4vYaxlYNiIgbK+CTbG39wB1iS5uY+na/sSRE3LRs0GG6ApvSFqHZ1rc8VQBdVXDKsfqOY8zyeB6K2SclvpLKR4/sapnNcm452JlL+M52Ocp5nqLPLB0i5pXFLG5+WBgVOISKnZ7q+tcEFQZZeMu5jPJPqO0cvqn0nmLiM7cNllr8m8V4EPBmOmA8qLcyFS+o2v4xMQtltKeNb4GC6YE6P9S1T6FTavDl5CxMR0YRA/1gm2Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NouSz4VWfTfnh5o1gLWs7KleUu4U0IiW4nvzIvYeQnk=;
 b=b0UALne0gW+yRLObU5zX4o8Q1auocsAPQtkRPGoBE5arbv/T0dW3DBaUpnr+8Ru6QwVuvtRYsOBWMXK9h/e5yA1fhjRZHvfzqLFaFLg59MzDksJQUSi1N4klA4Iq9mOT7gvXTTHLm3L5iz0S/sqcguTaGbDMaWAMaFNaB+hLnqM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5754.namprd10.prod.outlook.com (2603:10b6:510:148::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Thu, 26 May
 2022 13:16:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::bd49:f0ab:b476:860c%8]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 13:16:23 +0000
Message-ID: <bffb3d9e-1946-f4b6-d58c-9c44bc0bee26@oracle.com>
Date:   Thu, 26 May 2022 08:16:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220505184603.1548-1-eric.devolder@oracle.com>
 <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <311b0834-c675-fd15-8184-82b122f4a9cc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:805:ca::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11458238-5662-4a06-a803-08da3f19ee22
X-MS-TrafficTypeDiagnostic: PH0PR10MB5754:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB5754EA10DF0D9E373138BA1597D99@PH0PR10MB5754.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78soxjY6HodxV0roIGF1VEGlQgMI8n/13UK8/7MSoL6IOwtPtfy7APhk3zT/ZK0z9zPFqIv7I5TC9TU5Tcn3iLJZBgmzYQ+DxjL8k8g0UrDTTE1gr+ZrnSByNM6tFz99+HOFuq3RqrNPg82GWSmeXrmphd2KAQDLJsrtEVkVClNpUt9LXkcZio/hAkNy/7wK68j37zEiFB0HxVxBbAitU2JYXh9U94x7Ikk5dpFOzRUY1aE9KdMvnVSdO9DUg5lw01iWfq3FXWC/SPFWP+23o0zpYT+bYoeYCeq8mXptL0q0e16suDuhNRrMumNa/bpILFyOkCYTc7MfRzFSY2a56c8yjG0jaCrxLOfF/OaRq1akMNNq6B1O4nSear/kq5wHk3YjBKAJB+ZydJjpLINpxfzxYh3vUhbsP5f1+Lp1q5dsHv9PmmwXSAdMeQpQ3hOc449DbKxQjSqyRuLKphJujWkA6US8GB6NIZ/0OwbDvrCbH6xqZNtSPoL1VdSZamZz/R1Sg2jUFlryDPpSBuE7A/FfcXC5Hh2GciDyrK7FUriHVZyLHy0kb2qPJB0KXaiiFW1gV6m3lWqbAeadJO1syZYSJ4TGdQ0mTkAoe94y/vlAZKcFNdEqgeXcXNdmhogUejgTTxix9O/FIGqjpfiuiFJnKZFKVpHumV7u1Oiu/XZvhnLYz/YvysDNK/sP7k4Hvu1aDfAhPCU2CbL2AnkthFJVMsOnlxB8AzY+l8iov22eh6/KV61HzEttnN47z10J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(107886003)(4326008)(66476007)(5660300002)(2616005)(8676002)(31686004)(6666004)(186003)(38100700002)(66946007)(86362001)(7416002)(6512007)(6486002)(31696002)(6506007)(2906002)(53546011)(83380400001)(508600001)(316002)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1aUnZVYXBGajNxdWIwZmFtMEdBUGxBUFN5Um9GQ1FZV3Z1RTF5YWRlT09C?=
 =?utf-8?B?elFIYWJPTHNJc2wreVNPSHVNUVphQVNZVUdkYXRVT3B5Y2xESEpCRkI2TGll?=
 =?utf-8?B?WWtnd0lQeWFJRDhDUlNVZFRkZjEzcHBQOFM1VGw4VlVqMlQ5d29PcHRYQnBu?=
 =?utf-8?B?ZEJHRmFiaVVvUzBwMDRWaGtLOGV1NkhZM1YyaEJwbmdUUVRvRG0zTjdsd2VN?=
 =?utf-8?B?NDhWRk9ScytIMk01cHhnNEVpQnhkWC9RMnY4MW5mOXppUG8yVThsRmRTR3hD?=
 =?utf-8?B?T2M2alE4SFQ5dEw2UXRCbzJNc3VVVTkvMDBNYzJWdnNvdGEzTUxtaGlZSGxQ?=
 =?utf-8?B?R0ZWL2VieDgvK09qY1d2L2ZPTFVHZVZMNXVQeE9YOWw5NlN4MzI0QWZXc05K?=
 =?utf-8?B?WnZQOVFvZU9pV09uTE45aTFBTVY4cmRjUnV6dkpMeVFMcENsMnBSN2tSZ1lh?=
 =?utf-8?B?NVh1Y1IxNXVkaWpJOFNoOWJYRTZmTjdFS2RRTis5OUJ4MCt3SWdmM3UvWlVJ?=
 =?utf-8?B?VVZqQWFUdThrSXpHUmx1OVhNMzBmUVdYQVJXVWt0ZHVycTZCeFAwMDJlS2d6?=
 =?utf-8?B?clhPK29rdngvRkNmR0Mvcms1NUo1MUhrK25BcTE1RkZ0RWtrT2dnZExnUS9k?=
 =?utf-8?B?c2FmZyt5dkR6bmNiajFldTdqWG05QVBtdjRueTZGelhMV0ZCdnkyVW1Gd1lm?=
 =?utf-8?B?Ui9yZVF4bitJZTN1L0hoWWhkZGlqbEYzNEVQeE5wVTVURWdRUkxLZXkwTGZJ?=
 =?utf-8?B?N0puY1NUUmV2Ym9oNFhuOUNpd2ZFZk1hWTZrUVpBdUFtSUFMb3A3UkdnWE1i?=
 =?utf-8?B?NDg3NmlyL0M3Tk9PaHliZEIzS2xGdWxSOXlEdVZqZDk1UjNWZGVodU5qVk5M?=
 =?utf-8?B?TUhZeTBSMkU5UUVQUld1YmdhdnhITGczeVRSR0ttS1VLQXdtN0Vpc2JITU42?=
 =?utf-8?B?amxKUklsaWVKcDVNVFBmOXN6NFpNNVpic2hKNUljQjAxWEx6Z200LzZaUGli?=
 =?utf-8?B?RGd2dEJUeHhHdmVETENQVVR5cFBkbHpYQnFRbVI3NVBpMkMvOEZReG91Z011?=
 =?utf-8?B?dEdpa0xWaU5HUlhOUzBvQmhiVm8wRnBxT1hqaFVKM3BWUnhlL1haL2RuR0ZZ?=
 =?utf-8?B?elR0WWlscUprYzFJbGJEWVZyWVpVNk5hRFM5T28xMTJFUmxrRjBSRUVIa1k3?=
 =?utf-8?B?R0ZOa2dRM0VpNUJQQWVkMHpoVlg1R1Y4ZHprSW9KbzJXQkpZT0N6RzJrNGdM?=
 =?utf-8?B?UW82U1IwbmtQRWU2ekdpWWdvVFJmakU1d3c0aGpkUDA1MW1sZWlMelRlcHpp?=
 =?utf-8?B?NVVQc1dyZ1JBK1Y5VTBOUnlvaHpwSGM0OXN4Q0EvUWpKUk80R2pCRDZhWWNq?=
 =?utf-8?B?TElWVkxlMFRmZnRTMVg2bDFtZ0EwcjV4ZjBqeEZ4RU1jeWlxam9YRWVWL0gr?=
 =?utf-8?B?a2xHNzJnVkRUSVRmdTgxT1dMV3o3dnVwcGIyQmJPNkt2NHdlTUVNVjdiUXhs?=
 =?utf-8?B?MzRYNWpOZ1ZhWmxLY2FiNmFzbys0clQ0TXpVRktPSkJrKy9FSWlJSjhHWGtr?=
 =?utf-8?B?MUlwMTJ6bC9BOEN5WFR1TnlVcnY2WXNWTFNzRHRqdHRsMmVwRWl6T0c0MFox?=
 =?utf-8?B?biszTEJzRlpSYzRoMHEwRXBHTERUMlF5a0NBNCtVbVF5QkhiL0x3NUZvTjBM?=
 =?utf-8?B?aS9vRmNIR2x1NGs4QWJBSE83L2lnbFlZQUowaDhwcG1QNzI4K3hPajhjMHJY?=
 =?utf-8?B?MkNyblVxN0hFNllLV215YWRLb0pmeW1zSTVaT3BWTTlPWE5aYWZNaGh2SzRa?=
 =?utf-8?B?TVU0bS85QkI2Njg4bXF3Z24yVmpJaTBmdzBSOHdaZjRxMHZJckxQVFBaRi92?=
 =?utf-8?B?M3h5UlRsem5BS1VNUmdHMUpZZWRxOXJlT1BTOGFndU44ekI0UmtWR0NUSUpB?=
 =?utf-8?B?QXUvM1lQWTluNTh5dEEvZkpWQ2xkM0pyaFhKRHJWcGlVWnU3M3RwZzE4UFov?=
 =?utf-8?B?RGhEM2dTUzF6WnJZK0hxallDV1A5aXZMdHVKbVVaQ0R5eXlDeGR3NXlhZm9D?=
 =?utf-8?B?TTU0Z3lGRnBqNXY2UUt6R0hyQm5WUUVsKzNJeFliSm9wdEdpcVUxRExJQm9X?=
 =?utf-8?B?UzZaK2ozdjRWYUlhNERib0V3OGVqQ0dkQ3FEN1F3dnhIOWlNalhPblMzVGZ2?=
 =?utf-8?B?bzBWYnFyTTVSZGpoRFJBT3YwOGthZlBIWTRZSjI2K2FMbzJONWFqcDM3eUk3?=
 =?utf-8?B?REMrVWZ0Z3kyVnNyd3VUVmxFWm1xYllaV0RTR3FpSVJkSUh5RklncTc1V0xO?=
 =?utf-8?B?dGtxSFdVdXJnOTlXSExrMFhxTTBacGl3NER3dG4yeU44d3ZXeEZTUllLZVNM?=
 =?utf-8?Q?6GGP8TeNPGw1tNUu/ceuLZALcbGcwrru8+xkY+SsL9j8H?=
X-MS-Exchange-AntiSpam-MessageData-1: gOaT5JUJdmcidw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11458238-5662-4a06-a803-08da3f19ee22
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 13:16:23.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ohL+wAcBGUBcrX36wg4EW1x4ErWb+diLsQ8Nbju9sq/Wf1SYsVH7vvTyrAJEWXw31Z15g7q3lyzr4/hJAqcYzAv/l3oJg4lMXPsamkUKWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5754
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_05:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260066
X-Proofpoint-ORIG-GUID: jf6qSkMW0imXaCK2cGmUApuEWrf8MQmA
X-Proofpoint-GUID: jf6qSkMW0imXaCK2cGmUApuEWrf8MQmA
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 10:13, Sourabh Jain wrote:
> Hello Eric,
> 
> On 06/05/22 00:15, Eric DeVolder wrote:
>> When the kdump service is loaded, if a CPU or memory is hot
>> un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
>> and memory in the system, must also be updated, else the resulting
>> vmcore is inaccurate (eg. missing either CPU context or memory
>> regions).
>>
>> The current solution utilizes udev to initiate an unload-then-reload
>> of the kdump image (e. kernel, initrd, boot_params, puratory and
>> elfcorehdr) by the userspace kexec utility. In previous posts I have
>> outlined the significant performance problems related to offloading
>> this activity to userspace.
>>
>> This patchset introduces a generic crash hot un/plug handler that
>> registers with the CPU and memory notifiers. Upon CPU or memory
>> changes, this generic handler is invoked and performs important
>> housekeeping, for example obtaining the appropriate lock, and then
>> invokes an architecture specific handler to do the appropriate
>> updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, and overwrites the old one in memory. No involvement
>> with userspace needed.
>>
>> To realize the benefits/test this patchset, one must make a couple
>> of minor changes to userspace:
>>
>>   - Disable the udev rule for updating kdump on hot un/plug changes.
>>     Add the following as the first two lines to the udev rule file
>>     /usr/lib/udev/rules.d/98-kexec.rules:
> 
> If we can have a sysfs attribute to advertise this feature then userspace
> utilities (kexec tool/udev rules) can take action accordingly. In short, it will
> help us maintain backward compatibility.
> 
> kexec tool can use the new sysfs attribute and allocate additional buffer space
> for elfcorehdr accordingly. Similarly, the checksum-related changes can come
> under this check.
> 
> Udev rule can use this sysfs file to decide kdump service reload is required or not.

Great idea. I've been working on the corresponding udev and kexec-tools changes and your input/idea 
here is quite timely.

I have boolean "crash_hotplug" as a core_param(), so it will show up as:

# cat /sys/module/kernel/parameters/crash_hotplug
N

This will provide userspace the indication it needs.

> 
> Thanks,
> Sourabh Jain
> 
