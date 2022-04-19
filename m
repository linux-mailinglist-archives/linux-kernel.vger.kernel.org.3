Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330B5507CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 00:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358356AbiDSWxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 18:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiDSWxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 18:53:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559F1D305
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 15:50:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23JKITfr011972;
        Tue, 19 Apr 2022 22:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/NnfWqSj5lf5krVoy6P9ss2Fo7O+Lb/kaCVnGCcfQJ0=;
 b=NVHu/ydYkdiie9uaTiqmEx1oqbQMGFnubJoR3xiULrAkau5zuwgpQW1Vwc2lNRoxCciw
 FqgpdWtO3H3hxQvNxWRdnOsrKSF/tziJGzpJhUvz7cTDiMguE1F/EfV/UjiwjujVGQ5l
 IPKiL5ylKjDbvvo5/KVcRWNro7dl6dFUGF0CRFiPHZLe3jNEXjfLOp+Px4rg7Ug6VrkG
 lipAdj8cSUkg7x3nEGSsxHONJSpIPlyCGzzNcqRYs1PplWxnbQZokk4gZtQSG7/bjMWm
 KDbuyvRn+y2n+EjJ5bR/X8/tM5NY2zS9KioHDCzSDcjwLX+rWa0QuxbsQaWKmSkACUC/ yQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbv7gnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 22:50:08 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23JMVsoI016275;
        Tue, 19 Apr 2022 22:50:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3ffm88uc5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Apr 2022 22:50:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1hWMg3TRdm/+Mc+z/nBcdSZw1BnyNqEt72TF6niZPaDgVpvN2JITXhjsRqZuyQ0QTuTVJ4Y1E8GGt5efpBziggoXB0iQmv1N/l9/DeiNxBw14LwH1s7Mjte4TPrLmHqXQ2daxxQxbAWStUnslyBk6bySKQsQRbien65qvAv2YcwBpWZ1+gSp6SOKNiDLMlT9AoNuuyUDVOjYqzU65hkJeDtUX7hlaDnw5LZtvbe02V9Ogvn1SBPk2W7CNXoBU4h8bnCsWzE9gQPILWJZ9tObKhTvmnQfPmW6/CjYa6G0HdgJTbW5DowWa/iQQuTHwG5sP+WXvGzqNOcJqf16TP4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NnfWqSj5lf5krVoy6P9ss2Fo7O+Lb/kaCVnGCcfQJ0=;
 b=mfXPvpt3JxjFZTZTIh62jaDfMTGPuj6F7yhHiYp5Ndp173//034X+qxmnbswmE/8uXwz7y1I1uLxrrRPO78lx1wxuhJBazmhGBxqyTmyQ21GOrRewuLWgRxf+b6VoKj/H0vLFJ49BjPEISDzFqWUXBOYezYt+kFIO19g/0IzvhMmnlsVss0VFHY00ixQ/MQFr3El+f2nRl9Klr6HKG25FmXiq/Fc2G7iWN7EFZreQB5y9h8dk/prVw1WqHjpsQU00IrWjOTLE+WgncI0P2J9nZZPWxMsTx3eMFht4HDDPZW7x3hpck8Gtz1+p8BVXHvGr3YWbtyHkMLmY+rP9+sUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NnfWqSj5lf5krVoy6P9ss2Fo7O+Lb/kaCVnGCcfQJ0=;
 b=RDPcwJfxCCsKrtf2jrzfuyMN2j+vX5U5NzRM580pXWu1UVnk7tP7+0u2dpF21sxPwHcmk4uDXElvMCEYsK3EX07eL5pz5Qs36r5aK1hDzXn5547vPDe7BRkk+xPAvcLl+kXYVMqiVjxUUm/AVlq14ty/CBjpqBFMVwTbkAqKUw8=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4528.namprd10.prod.outlook.com (2603:10b6:a03:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:50:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::bd4a:8d2e:a938:56af%9]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 22:50:04 +0000
Message-ID: <ec97313f-c7ce-ab23-3934-faddbb782336@oracle.com>
Date:   Tue, 19 Apr 2022 15:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
 <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
 <4ddf7d53-db45-4201-8ae0-095698ec7e1a@oracle.com>
 <dcda550d-a92a-c95e-bd08-c578924d7f8d@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <dcda550d-a92a-c95e-bd08-c578924d7f8d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e79a4e4d-5c60-4957-9366-08da2256f187
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4528:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4528EE000D037C470C6305F3E2F29@SJ0PR10MB4528.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tj178MnehJjNF3Bijg8RRkDH5FAM5UDdzo7qRccfWZWZab8NWSWmfL52XTexN0ULZWPt9oTo2uFzbS/U6kHfICogqp7YAvhh8d3B6d8a4X+A8YAoVWXPrm72KlTczJpmlhgieAszM9BDcnJSB2VN1L7o7n1bFHqdXrncMXA0jwW5pOoSb2KCYwbqhkij5rgHDLCr04xIPacDe9C4yyL5up6YBIv74Kz4TeTG0yVGZqr8TrJI8dqZcxvxUvuXAQYoqcqVbRgPhI5PutBknv77BDmQ0DAnmTVmJgMRYHHhTww3/8LIHMx0VnHTBs87W0xuRDha9dDIiXVaWR04s4gzhhiHUbFLvVeaumyCkGzkTHXShrkQ4JxH9ngvx+Uv16XNuJE7/ci4I0PcL0B31LHQ2oeJhzrUOuDvzYKlDEJlNbfE43xe6KlF2ki/xIq6UCTUKgwy5/PV9KbaEKI509ZehvK/Y7ujw3kAKG/ATiT598L+V5ul+jHStUjNR8BTatwfjwftBnlIEWOzW53nU4KVroRGyFvwYCQRKiW0K37AxV5R5d4FOOSg06iA79n6JDKlIbUsCKOHYRhL2eD/SPxRxVBwoGU6mt0joT5aaBdUYmE78GRGpsy4XiZeSGvPPcAdioDPQUrLuOKWsrTOv7NMbZJVZTCqJ1SOt7ifpt8kw2HMOO/AP7+uCco3BIyd0NTa1PviAsIhzHGrpEk5Q64zTNIdvogi1KZB+HhQprA96ao8ywQG6YsWDPDZ8FjGCxMrIZdj9/OT1jsiZ5qhOtPPUc6mG18Mvy2545wAqfPZYR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(186003)(26005)(86362001)(31696002)(38100700002)(508600001)(8676002)(7416002)(38350700002)(66556008)(66476007)(83380400001)(66946007)(31686004)(5660300002)(316002)(6512007)(6486002)(6506007)(54906003)(53546011)(44832011)(2906002)(4326008)(8936002)(36756003)(6666004)(52116002)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUtXSUlkRmttTkEzbkxwWTVhNUFFMkFuazV1WCtBUjNVOUJWQnAzb2NodTN4?=
 =?utf-8?B?YTRFUXZ5OWI4SXVMa1hTSHhSa0FMM0djUUVCaHNXYzZtc2d0Tjd1a29zRUZv?=
 =?utf-8?B?RnI1eVM3WTM1SVVOWkVDKy92VUlpUWREZ2dRMkdsYmNjZGMxblFnbDRkWjJZ?=
 =?utf-8?B?SllaWWpFVUhJUFF5NlZudExFeWlaOFdqSkJVa29SVVlmTHUxUEpma1ZzcDZ3?=
 =?utf-8?B?ZVNYeFNaUEtBdnp0SnltQzZwQkJVNHdQQllTUWptdDI3VjdaeGJvUS94NnI5?=
 =?utf-8?B?SEF0TXhiM3VVbkQ1d3dRdGk0VlFuMkwzRi9tU3RmWklnRnJ3cTVlR0ovOUpk?=
 =?utf-8?B?SEZTVGJRV0wzajVBQ1JEd3hpK1JDTTNYNEs5WVFqRGd2bjM1SmtVMjBIMXhM?=
 =?utf-8?B?RnVDMGQ0dk9pZy9seUJIb3poSzFJTlYwSU85akNVbFJ2M2wrWXdhOVcvL3Rz?=
 =?utf-8?B?dHJnQzhYSkdhbGp2blFyQmkxaXcyUE1HL0lqbEJTaXBzTTNHZ2RPaVhqY0Zq?=
 =?utf-8?B?dk9ZVnhUT3ZiOGM4TlVmOGNpMFFQY2J0Y09uQ3FEVjdORkJMZTlCL0FTMUk3?=
 =?utf-8?B?eDhON0luVXE3Vi9TRjJCdWVtSjduOWRjWmEvSHM1b0N6cVh4cDhBbzl1ZmZL?=
 =?utf-8?B?QlhYVTY5d1V5a2J5bkJvMTBIdjhJNG9uOGl3RkdMWFlqd3lJTkZsUlVSckJM?=
 =?utf-8?B?bURyWWlSUGVNK2t2NDI4dGV2eFg3TTNBeVhlL3VMUWFLajU3Ymw1ajkxOGN5?=
 =?utf-8?B?UHFCTWs3RDE4TW5POWN6OEtmQ3dZME1lQmU4eWFKNFMvSGduODJ1UjJ6QlZK?=
 =?utf-8?B?VzFqd1lHVzJvN0c0dlJIcjBybnRMVjBaUWdBTUNOTGg5SkJHRGFmL2tacC81?=
 =?utf-8?B?Wk42NzR3NjhTbkVta2N0d2owaXQ3OFpzSFc3UElSbWY0WFQ5N2JQZDI2UlVV?=
 =?utf-8?B?Y3htY0pWT09JNXBIL1dhZ3c5SU9aUUhmRlU3NklQbkp4SmZkenlsNXFsdkVD?=
 =?utf-8?B?b05YdjYyTFZVbEI5MElkRHBCaCt1cndoOGZzRjl5MldSVVZYT3Uzc0orTkZF?=
 =?utf-8?B?bTBTQjJWYndqMzJ0dlVMblptb0UvRUVteWlvT0Y2emRSWS95SEx6MnQxb0Rv?=
 =?utf-8?B?TnFQYXhKMEdTVEV4N1NpQzZHRmppUktuN2t2UjNVR2JTR3ZrZUFVQXN1VHZs?=
 =?utf-8?B?TlpKTGorNjIxeWNzb1NJMnpuTTdtbElJMDlUa29YeGhoSEJHTjRqSURCMzJn?=
 =?utf-8?B?NDYvc1FQYURGbWxVRFRpTXhVd0xhRWpVZU54eG5HWGw3NzZhVU5KWlhwd2I3?=
 =?utf-8?B?enJSSi9vZ3l2eXVuOGpjN3lEbzNEc1pzUTcvSG5TeFR1YStxZ2VYUTF3cVk5?=
 =?utf-8?B?NTNiSE9vVXJSb2cwMnMvN0lHdkhNRklEa0FnbTdRQnZFUm11L0hSMHNlc2Ro?=
 =?utf-8?B?djVFazB0LzZkSFFDaVhlZW12Y2ZvS1dybGVpVlBzUVBnK1hTdXRBbzV4L3hH?=
 =?utf-8?B?NzdBaHdBL0lyQUhucmc2L245azExL213UTk0VWc0M0VPa2ovLy9QQzhyb2Na?=
 =?utf-8?B?NG5PeldZMlQ2aThZQjlWSEdLczZqcVZGZ3JjUW96L24rV0FuU0xKUms2TjVk?=
 =?utf-8?B?aVlPa0I3cU8vZjQ2cXFscmlrNzlsdDZYb2NyUWk4LyttNXNicDZBd3E3SVFJ?=
 =?utf-8?B?dU13UXdqbnplMkx3YzBma000dmdBSlU4U0hTdTl2YXQ0RjhrWjNBRnB0blZp?=
 =?utf-8?B?WnFKN1luZ05KRzkvMDFSSFFRWHdDNm1WT1U0Rk1JL0Y2VjYwR0o4Rno4Z2F5?=
 =?utf-8?B?VytpQTBuZCtvOFZjb0pwTzF6eGxUa3hEcU5UWVVmNlE1a2VRb3JMVUZPT1F2?=
 =?utf-8?B?bVluZ3kybGhHWGlYdVQwcXpZNjcydjFrUUVFVFpOWERMQVVrY1g1a1VKSTY4?=
 =?utf-8?B?NWNIY1NDSExPZnBGbkpRdjg0YkgrZEVrSXMzU3ZmcFlxOEFzQk4vamwvdkZ6?=
 =?utf-8?B?K3dqNzRsV282M2lDaE44eWdSb2ZvS2ZkNDl4Tjg4VEU1MVJQWXYxd2FOWjA3?=
 =?utf-8?B?L2VYdUduUlNjcHQ1dXVlYy92MTV1S2J5cGxhSWRWVFIyZW9sbC80dVhONG9B?=
 =?utf-8?B?dnRKcE1NMUtITlI4Um9RUkRvcGVsaXY2UjJ2UkRYaWVja253Y2tjR2IybDVI?=
 =?utf-8?B?K0t1Smlwc000WVJiZVZ6bUNYcXVjMmtia3FqN1NPSW9IKzBvdEJNVjY0bzZu?=
 =?utf-8?B?SkxwRXF5NVlMS1ZvTk0xa3gvd3NzTll4aFhVSWhOY1lzSHd2SmQ2cXdReHlB?=
 =?utf-8?B?SjRUdzBTamlLM2xnaVdZaitIU1UxL0JUajh2T1lybEhoNkQxN0w3Y2NJaDFI?=
 =?utf-8?Q?RhNh4LiYYD4Md+R4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79a4e4d-5c60-4957-9366-08da2256f187
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 22:50:04.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Fd62RXeAMe7veIl9Z+4OhSbuu5KgXH41DUJpUxK/zpbubiBl/CJG5qjI9aVVTbjRNEf0pXRS+eN8bKjnwSf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4528
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-19_08:2022-04-15,2022-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 mlxlogscore=593 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204190124
X-Proofpoint-GUID: 0KDBK2XXEVJ5z4qJ5NfWTDFFtFy5O_hw
X-Proofpoint-ORIG-GUID: 0KDBK2XXEVJ5z4qJ5NfWTDFFtFy5O_hw
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 02:26, David Hildenbrand wrote:
>>>
>>> Let's assume a 4 TiB device and 2 MiB hugepage size. That's 2097152 huge
>>> pages. Each such PMD entry consumes 8 bytes. That's 16 MiB.
>>>
>>> Sure, with thousands of processes sharing that memory, the size of page
>>> tables required would increase with each and every process. But TBH,
>>> that's in no way different to other file systems where we're even
>>> dealing with PTE tables.
>>
>> The numbers for a real use case I am frequently quoted are something like:
>> 1TB shared mapping, 10,000 processes sharing the mapping
>> 4K PMD Page per 1GB of shared mapping
>> 4M saving for each shared process
>> 9,999 * 4M ~= 39GB savings
> 
> 3.7 % of all memory. Noticeable if the feature is removed? yes. Do we
> care about supporting such corner cases that result in a maintenance
> burden? My take is a clear no.
> 
>>
>> However, if you look at commit 39dde65c9940c which introduced huge pmd sharing
>> it states that performance rather than memory savings was the primary
>> objective.
>>
>> "For hugetlb, the saving on page table memory is not the primary
>>  objective (as hugetlb itself already cuts down page table overhead
>>  significantly), instead, the purpose of using shared page table on hugetlb is
>>  to allow faster TLB refill and smaller cache pollution upon TLB miss.
>>     
>>  With PT sharing, pte entries are shared among hundreds of processes, the
>>  cache consumption used by all the page table is smaller and in return,
>>  application gets much higher cache hit ratio.  One other effect is that
>>  cache hit ratio with hardware page walker hitting on pte in cache will be
>>  higher and this helps to reduce tlb miss latency.  These two effects
>>  contribute to higher application performance."
>>
>> That 'makes sense', but I have never tried to measure any such performance
>> benefit.  It is easier to calculate the memory savings.
> 
> It does makes sense; but then, again, what's specific here about hugetlb?
> 
> Most probably it was just easy to add to hugetlb in contrast to other
> types of shared memory.
> 
>>
>>>
>>> Which results in me wondering if
>>>
>>> a) We should simply use gigantic pages for such extreme use case. Allows
>>>    for freeing up more memory via vmemmap either way.
>>
>> The only problem with this is that many processors in use today have
>> limited TLB entries for gigantic pages.
>>
>>> b) We should instead look into reclaiming reconstruct-able page table.
>>>    It's hard to imagine that each and every process accesses each and
>>>    every part of the gigantic file all of the time.
>>> c) We should instead establish a more generic page table sharing
>>>    mechanism.
>>
>> Yes.  I think that is the direction taken by mshare() proposal.  If we have
>> a more generic approach we can certainly start deprecating hugetlb pmd
>> sharing.
> 
> My strong opinion is to remove it ASAP and get something proper into place.
> 

No arguments about the complexity of this code.  However, there will be some
people who will notice if it is removed.

Whether or not we remove huge pmd sharing support, I would still like to
address the scalability issue.  To do so, taking i_mmap_rwsem in read mode
for fault processing needs to go away.  With this gone, the issue of faults
racing with truncation needs to be addressed as it depended on fault code
taking the mutex.  At a high level, this is fairly simple but hugetlb
reservations add to the complexity.  This was not completely addressed in
this series.

I will be sending out another RFC that more correctly address all the issues
this series attempted to address.  I am not discounting your opinion that we
should get rid of huge pmd sharing.  Rather, I would at least like to get
some eyes on my approach to addressing the issue with reservations during
fault and truncate races.
-- 
Mike Kravetz
