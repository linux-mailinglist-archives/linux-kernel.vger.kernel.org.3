Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAC4ACD0B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbiBHBFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiBGXr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:47:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF63C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:47:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217MKPUb011771;
        Mon, 7 Feb 2022 23:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=I02aarx13g0GlRyvvZZQa4egB8o4Yyc1StVwHrVQE9w=;
 b=mbvGiKFQh72bkDe7gE4cCmYbtAVdSWm0Zy9td3JG+xhrG5fzNSq+u3MUiZMVYoA3MvB6
 rHpksC+6FGpzNN2NOMvh13PGMaajfHXcFO0NnUMjv1/V6hC2BJeL8ZRS92n1OlQs/UXZ
 aHUscWku3CwFg8bpyVF6uVMiVqeE3CsYo+v0SD4nRMrNdy0dyWUY/J8VT6ThNyCq6TNr
 +47yNyMCpm8ohYvGN+PnW4iADYgzm5CBpDg8MGxKUtYLHLb6Wj8NtPAXAKhHqXpHLTrg
 kNx0w7SEttc4eJfDbQmdSeccqG7xQQjE2Y6VWLMvA4wtN+gu9TQf8qIvWXAvaKb8PmfH pA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345shnnv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 23:47:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Nk3hF126570;
        Mon, 7 Feb 2022 23:47:10 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by aserp3030.oracle.com with ESMTP id 3e1f9e5wqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 23:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHMD13ZK6cdmIJxNFlYn+o1gGmawC5bc6kCgWPrhkJOASQFtklUTwjnXCOJY4Busa25yqvHmSGMvSzI9r5l8iiGtmtD8biv1iE99hTXGkBaXe5m85T6F58KXiVV2M3arrKhwixqvNgTX19YR7OyVYkimrJzpt1N4rNMdf4iJnVuyv0eAh1b+8t/gj+Znsivz+oPTTMXqpqqeLfdqRcf9O4CBOK7ZebhAfOqpszQ6EHgP1j8f9eSNg/UR0NYg/PYbaUF0KfIkxAek6Zv057ST0ClEYidSg4kMPLVxFSViHvHZf2zK6HZqkyIpm9jhYu02N31jlq/cbGoVY9ytzE8Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I02aarx13g0GlRyvvZZQa4egB8o4Yyc1StVwHrVQE9w=;
 b=ogm0s0m4PSa+jAOfiX+dsylsKXod9WBF3EJm23DSbegXC5fRniZkL/b8CSUccrRLRtoaNSSJapdtyt3414rLNErSTQ3UuJwigWgZEz+b5ds3r/a/vfLVjmhJGFeJjDjbXK1MLRxm0ptRuzXT5EKpmqmUNP1Z5NZvdQ7JUwgqy1JGQPNy40mfsg0mmd4hynBnPT/SZ3ZunV6IG7q9ca3GBNL+9sQxe8PS3AxvkxpoRXmHr/44IL+rEb2ppPzNo3+nXCm90+AXNpHvdS+JtdPgZSnw7uJEnRKA3rzeMfA+R5hDRchykcehMVoG5CiT9zinR+kmpvuZiEiXuXCM4hO1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I02aarx13g0GlRyvvZZQa4egB8o4Yyc1StVwHrVQE9w=;
 b=eWahpTBV5Az2OMxjMor19diC7uxIj0stPu5GIYZwC89y3udafB6vDaUgCKTcAemxlbNB8l1DNXtaa2ZMDHz6GiOQDvrdWgiN5k+/olyPgOuCO/9SlX4aZPLmwBwulL/Nzvo+O3ZdnVPLWC7kXxTuUDtquT6vGgdQGOvxY6C9+T0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Mon, 7 Feb
 2022 23:47:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 23:47:08 +0000
Message-ID: <d7e6ee46-8e0b-2ae3-c159-449a26c17ae9@oracle.com>
Date:   Mon, 7 Feb 2022 15:47:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
 <7b174c48-d368-43ba-7eab-13719a0d15ef@oracle.com>
 <6a82ea68-6e1e-8f5a-ca89-6744fc896a0b@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <6a82ea68-6e1e-8f5a-ca89-6744fc896a0b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0277.namprd03.prod.outlook.com
 (2603:10b6:303:b5::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b144bd-4c1c-4fea-c547-08d9ea9426c7
X-MS-TrafficTypeDiagnostic: SN6PR10MB2799:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB279975A25E99FA48BD06721CE22C9@SN6PR10MB2799.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipInP7VsCQUz7fkCBJR6z7IQvyQx880mEHxWnsGVAIuyMDjTvQd1e6Z+1764x0ynWsu36O6QCjSk7uBKvCPNJjQODUmvKqw07qsTb3JH/MVe6F7rnF8Y3BLViHH8dp7b9pQwESnHixjLHSY8VOVV9Vzy3BZ+OdoNHEr52RmoRtDkz51WH7zGaNCSAU9B1M31F4vNjsz3Ge7giDgoXdHqZ4JjS2GEkHEftAnSmATQNsrrVikYlQe8DLAv4egPu03iyh0OfqWnfwjKTRMCzvTXowcPWesYLIlSgTw2NFDQCrUg+BM2VXNTI14vf5O3lE4ZTljscr4lo+uaEiuUO9TyS72qcZaA2QE3qS4hT12e1lZYC7EmDeHUbGjrJYiZVb733Sgy7OXzdXxgVlTjc0oosa+7soAu4ahtaoK43yjo+latjAW72RFkn1KSN8SEWgNb5STmbXj4nWA5yiFn99W2oN3OfNAkYEMJSgbTt1DKdzaPMxX4prsQw30jrKEhm4nPfw1jjkLX5LGPDwMuBNYrknM9L0/VDhpguv+yGJNt9vcFV8iOfpvIKUB2YRA5Q/+as4sMvIaxd12nJc1q2XDcLXdhS1Yh9S4X9eb4pryZOWbKEWz1fT4AK84onFTDg9nUwrKU7cWyinSZ+z7cDxsvx+EV+LyFw6YfiFt15MVIGYdCqDwTkAuSkMnvWmk9fPW20ViN3/0KGrekv3xciscC30uWEdFw/F6pa7oSTw3LH75TS5sRe1D8zQbFbZqOJAKdtVVFFCrlhVZ1G/BPyBntNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(83380400001)(31686004)(52116002)(53546011)(6506007)(8936002)(6486002)(38350700002)(2906002)(6666004)(6512007)(36756003)(186003)(26005)(2616005)(66556008)(38100700002)(7416002)(5660300002)(31696002)(66946007)(54906003)(66476007)(44832011)(316002)(8676002)(4326008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NRVlZkTWhOclVXdFJKc3UyeXFYL205c2pxYlMxbCtMbFluSHFaZWtkQmpG?=
 =?utf-8?B?a1lXR000Yjc5S2xWdm5LcG1XRHBBbmlpU1d0eitqdnRMR1ZuTnRHVEFGeVFZ?=
 =?utf-8?B?ckVOWTMwV2JHK0NJcytMSEJNbHlSWUFvNk92RzNHNlIvUkN1c0hBNStDUEtP?=
 =?utf-8?B?TW1ROVVmZWoyamIxZ3pIUG5tNEYyUVljZHhkRm81aDdvNUgxTy9CRGw2R0FR?=
 =?utf-8?B?SGplYWFzZnpFc1JhMEd6Vnl1S0llL3hHdnE1WUJMc2kxbE9MT0ZVK0NobXZv?=
 =?utf-8?B?L0hVZmdFNjBDUlhZd1hyOUoyaXM2R3lmVkpnWXJpMEhPRG9HTFpaMGtoTXRF?=
 =?utf-8?B?ZElhRnVtdG5teU9mdGJGYlpNYUVmRmI2eExQaGxVS3Nyai82Mno2WnVzU2h5?=
 =?utf-8?B?YlIrdm5YbzN5Tmt4ZytvVVcrQU1pZzRTWGtvbldGMC9Ca3VERFlVVkFBWHBq?=
 =?utf-8?B?RVpVSHZ1TkxKQU96SUI1U0VadVF1L0MyUnFORmVVcE1rdVBrMG5YVHJZZDRs?=
 =?utf-8?B?UlQ3ZWtQVlBCaU1udTJ1cGlmWUNqcTZ0anhjYVdXRllGSWljdmRqdDI0N1lx?=
 =?utf-8?B?eXdDVWVOWjVtSTIrZkhrL3FYemNUb3pyWnBIalNwV3VEbWs1RGFKRk5HSkZv?=
 =?utf-8?B?MC9kTWFCeVZ3YXZPRGpBaHZzYmVaYndidXM1aVRIcEU1UndhMVhaTXBkRk50?=
 =?utf-8?B?TXFNVVhLSndtQTdFRXhlVko2NmNhaEJ2MTR0OEtYUWpRVHFWeUVxampZbEg3?=
 =?utf-8?B?RklPaERYZFNpRS9wYTUxSHVzVDlSc3psZjM3Vm1XWWtYc3lka1JpZVlFVXVj?=
 =?utf-8?B?RlNGYVBJdlE1bzNsZm0xOVhVcFJFWk5rVU9YdUk4NnNhRFZXK2JxcUFjVVEx?=
 =?utf-8?B?eDhZVUJaRXBWSlZsZjM0Mitlbzc4WUR1dzk2WnpnUXpWSkwzWXR3RDdEU2d4?=
 =?utf-8?B?MjY3SDM1SEZRc1NScTFMakNmUnRXUWNoaTRmdVBDZmZZK2kwMkFSTG1BWXVa?=
 =?utf-8?B?ck1RZWtUdEFiM0lTWEJwSDJhbDNvbldSdkQxSlgrY085VGpIVEtxb0N3YU1u?=
 =?utf-8?B?Q1NvVHVpMGhmTStOaGwrMXZyeFQzRWQvc091TVJDRVpUZkw1cU44dXh5SFoz?=
 =?utf-8?B?bERoRmhUbGd3Q2ZNNTBTN1c0WkYvM2xTb1E0WnFKbDBIV2lxMDNxcm9YdEZL?=
 =?utf-8?B?ZGNxOEpEOXhCZ1U1Y1ZVSWxyMzY1b2ZON3dEL1RBVUtUTDhKNXlTa2F4di8y?=
 =?utf-8?B?R0JKN0VZdzBNeUFMelZKQXp6WTVEd2d1b3ZTa3NZOFRoVGdJNzl5R2tCWjlR?=
 =?utf-8?B?QVdvZ2tSL1lqd09FY1hXbkRmNE43WHIzbW1pMHRhRkxUOHpTeGVKblJEa1Aw?=
 =?utf-8?B?WTVPdDB1TkxjSEZUeDIvMVpLZFY0c0NIcWp3ZDA5czNXNUlLM3JaU05zTTJJ?=
 =?utf-8?B?bnNEcVpNdGdRcm1GcHoyZWR1MEc5bUQrWDAwa1B4Vk9oNVJycEN0aUFoMXRa?=
 =?utf-8?B?YlVqcXpKTjUvNnF2dzN3NVhEcFhmSVZoZXVnc21NYjVZQkREK096cWdOdjRa?=
 =?utf-8?B?Y0hqbmtmZXdtU25ZdGl4Qmp2MW9qL2xUaVBkdHg4eGFsY2VmWXhNR0s1ekJv?=
 =?utf-8?B?Y0JmdGhhTzFVaElMaVNnMFNGUmw1R0F0TWZ2dGxJUU41M1JqUlBicCttMFor?=
 =?utf-8?B?elZhQXFyOWFVaHNpZ0h1QUZibEVac2ZhN09nRm1DVkpDNGtxbHV0OGlMeUpj?=
 =?utf-8?B?THJMcHpuR1UrVXZ3cktNSGRqZ0Eza042SWNwcEU4RHJxby9UaTRhQ01jZmxU?=
 =?utf-8?B?c1NiYWNidmxrU3A2QXJ6ZHEyS2psWFdYSFFJUHhZblZDeUFWdTM5ei81eVNp?=
 =?utf-8?B?RUFQN3BaUXBzcHJQNmpBZXpTcHdWQ2QrYmFJNHQ5d216cGl3U1ZyZTJOVGRV?=
 =?utf-8?B?Slk1bFdnS05QT2o5OUFuK2wvY0t1VTI4QXRyT0RIZjZXbUdDWGQvcE54MnVx?=
 =?utf-8?B?aVlaSE1vUWVQYWwzVXhLeUlwdUtHVWZWTnhkekw5L1JVS004V3lRaDFlazNL?=
 =?utf-8?B?emFUQlJwcFUyY2ZzM1BTZ1JMMXl6bTZZMXN2UkVXUk42emF5VTVicDcraHpz?=
 =?utf-8?B?TFNMVGVzdEJGcmpHT0k0dUVHb0NsRW5kSXpEOEhsRktYUmMySE9PMk1qaVdB?=
 =?utf-8?Q?FI/RQJFDk+KEVWhsgtCy9HE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b144bd-4c1c-4fea-c547-08d9ea9426c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 23:47:07.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55JIL0s4OkwuqZfgGSZdEkSn5qrK6yQ4oQIocTWSLcjOYdoDlADpjxnkPahrdwlVtiVYcWp9KhBFXRxk5KYarA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10251 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=962 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070129
X-Proofpoint-GUID: 7eSmzCyM2wZSLWXcoAWuOY0_QpCcrfnT
X-Proofpoint-ORIG-GUID: 7eSmzCyM2wZSLWXcoAWuOY0_QpCcrfnT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 00:35, David Hildenbrand wrote:
>> I thought this was simple. :)
> 
> It really bugs me that it's under-specified what's supposed to happen
> when the length is not aligned.
> 
> BUT: in the posix world, "calling posix_madvise() shall not affect the
> semantics of access to memory in the specified range". So we don't care
> too much about if we align up/down, because it wouldn't affect the
> semantics. Especially for MADV_DONTNEED/MADV_REMOVE as implemented by
> Linux this is certainly different and the alignment handling matters.
> 
> So I guess especially for MADV_DONTNEED/MADV_REMOVE we need a clear
> specification what's supposed to happen if the length falls into the
> middle of a huge page. We should document alignment handling for
> madvise() in general I assume.
> 
> IMHO we should have bailed out right from the start whenever something
> is not properly aligned, but that ship has sailed. So I agree, maybe we
> can make at least hugetlb MADV_DONTNEED obey the same (weird) rules as
> ordinary pages.
> 
> So b) would mean, requiring start to be hugepage aligned and aligning-up
> the end. Still feels wrong but at least matches existing semantics.
> 
> Hugetlb MADV_REMOVE semantics are unfortunate and we should document the
> exception.

Thank you for all your comments David!

So, my plan was to make MADV_DONTNEED behave as described above:
- EINVAL if start address not huge page size aligned
- Align end/length up to huge page size.

The code I had for this was very specific to MADV_DONTNEED.  I then thought,
why not do the same for MADV_REMOVE as well?  Or even more general, add this
check and alignment to the vma parsing code in madvise.

It was then that I realized there are several madvise behaviors that take
non-huge page size aligned addresses for hugetlb mappings today.  Making
huge page size alignment a requirement for all madvise behaviors could break
existing code.  So, it seems like it could only be added to MADV_DONTNEED as
this functionality does not exist today.  We then end up with MADV_DONTNEED
as the only behavior requiring huge page size alignment for hugetlb mappings.
Sigh!!!

I am now rethinking the decision to proceed with b) as described above.

With the exception of MADV_REMOVE (which we may be able to change for
hugetlb),  madvise operations operate on huge page size pages for hugetlb
mappings.  If start address is in the middle of a hugetlb page, we essentially
align down to the beginning of the hugetlb page.  If length lands in the
middle of a hugetlb page, we essentially round up.

When adding MADV_REMOVE perhaps we should go with this align down start and
align up end strategy that is used everywhere else?  I really wish we could
go back and change things, but as you know it is too late for that.
-- 
Mike Kravetz
