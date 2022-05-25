Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A653452E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbiEYUoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiEYUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:44:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024A666B9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:44:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24PIrR5Z003157;
        Wed, 25 May 2022 20:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gwf33jVScIbamNC8wN/3TVN82LzfENt85aTsaCCCdTQ=;
 b=QiADCIAtYqCkoPL81BPt1O4ifHjMPqgSxHMqGPdmNLVgwMLuFqPhWbUxIi/gYeHKptpw
 3Fox93SpDFtNoKQ4aAniqt7aygLq9bHHG8Sn3feO4JbA/hlotR6cSeGNjuk/aL1CAx2v
 hYuc7i+VQI4sBfeJxCtcd0Ljn2W95g95foDQ06DkSDXygcVQvO04uSq83N5XW0RgllWP
 79EyFeKkHg9lEOKKJ7tYIpC0S6/SGXG5tZ40wb0MflegrrRZo8PUoXqzLJqLbRziLAdk
 R1nxMKYSBVj7m8fIB2wXAwPhY2jRl1xDx0Bq6uHYZgoF1e2SDJrPIfCuqev2onR815p+ lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93taua1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 20:44:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24PKeCmK018433;
        Wed, 25 May 2022 20:44:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wwp2bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 May 2022 20:44:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROgRYsYcjmJRZI9rLAWMhJzp8zOa4dadqa8+I9q27zCFphiUH8JGq/LJQiddfgRLmI8qR8Ap6cZ5LhVpyMuQ3zwHnJ5TeQ7pLwbNeMvfOqpYOXE3xldg0+wy1ROZn7T/+pbqbqicGkBUpR0PAw8chpGLcVYYryxcXTTFydiEq/Kf2MWMb1pRGaR6aUMoTzqEoOyir402FIExHfCoTql54851I23MEqpykNY+xglXT+j7UQ1A8BpB4Yblk80eiDNWEo/E6CIt8N6iz8F2I1v/cWVx+IzPB3BB1u2NUWRz1noL6b5yN/fU8CaIBc1RrdCH+RoqHwNXlIBnX3zE5S7kFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gwf33jVScIbamNC8wN/3TVN82LzfENt85aTsaCCCdTQ=;
 b=am80h0niSDXjj4h2TySZe3i65HZB7biABIVyXIWg35XYQdsEpdcWUzNVETpk/xZxwZAMj5q/sWGj2fy7iOf+edoM43p0knCK8ex74n1mYwJpcuUyJBXZ+PuYvfdpxpd3Od1Me/SFKAD//pgw335ckPHl1IXDda3vhak3AhNhQFN/cJiybp6vSidrnuavMFpQopOvpJTA4Tyw+f9FXHKKINIKnR1I3p/8/QllqMUVjZTJBgqE1fkpNA7hzaPyUYcyz1Rkpt4APWsHFtPAvGi+Zku5yA2T2Xg8tN4KRMvvRo0hEnABz4tJOfb8LWXn3Goe3/NSs5pDB1VCQjX0zrMSXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gwf33jVScIbamNC8wN/3TVN82LzfENt85aTsaCCCdTQ=;
 b=eJMeeGSCUQFfo1nvoyXk3MVyLQRpyrLIfKKHucBcOPyS23HvYJfd4xoNo8SbiLEQoP+CrmHbWcMJbMyJ+uRmtIr/ilt2WN6fXt5fW5Q2KSncfWMLDc8qlEXIauDkAlN2c5zucn05XsesnRxIJxrD9D2qJE4xFY7Z/eYyndBZ+Ik=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4619.namprd10.prod.outlook.com (2603:10b6:806:11e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Wed, 25 May
 2022 20:44:06 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::2125:9bb7:bfeb:81f9%9]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 20:44:06 +0000
Message-ID: <159491e5-942f-cec0-7ab7-2ff331916225@oracle.com>
Date:   Wed, 25 May 2022 13:44:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] mm/x86: Remove dead code for hugetlbpage.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20220525195220.10241-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20220525195220.10241-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b010df9-6bc0-4ba4-93b8-08da3e8f4f63
X-MS-TrafficTypeDiagnostic: SA2PR10MB4619:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4619136E1A0168150F0E0925E2D69@SA2PR10MB4619.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29jIVSZsrLxMvZVSvZSARqeGrC4CzwI+B+WrVbjf+P9pEntQe9H8tsLPRmv9TefdiachgiCH+1QwOX0sBNxDocmbVPdQapoE3itHZ5eI/0Vmk6MO6VYKnN8VRt42x/WJqaxoqKvXmHCR+P2J8ciyRRC1NiFtdiD6CQXmTRN2Rv5lmn4mI24nOTxN4gPHEmvNrIFWC0akB2xC+QL5WGTT0IAAPP3FbeYjJfA4td3Q4v7VP6iEO5yggYgfs7s9Xq7djm0vPtK8OQuUuC0aJ1zs3HhtjcKCLLjdF/bE+pgW1/34oQwJmtfq1RSUgnAVw0Ag8qVzuyiWmP56UoIyXRQ+CUwj28QfQACDJ+sSsTBoNp+4n6dPLK/GT30wQaBhbcapyQM2WhCyYDQ5iSF84ypqarWFJnD+KsVC6JKCXys0KTYqZdKUcoTP79yG0tVnnDGfTQs+oIS5WMBWmki+KRHYl/y+rbAIfrU+If/7XONBO2Lrdgf/2FVq9jIeEJQsuh92dhCrMQu0EA7KZVvCDPvJGUI2fCtN+RhOj22XRmieJ/lzuXp5kTruC8pX/+M3V38MZSehRQ1vktVQZ0Fndh+Q5VEW2pJmFZLPcBqN2LiH/jwS/zyDYbU3c0mqkSvWn+8NfLVzwKSLktE4WEgexgegLbNnzlJhtL6Rivc5fXnqxJ947LPA/adFYP+iUWFCLRNFLzXCHLdI90L7hDVXFXdRxZczFWzpNkY4t8U6fyizgTR/DGVvf3QY5P3XGn/aGmKkQiEAvdhiBHQl0dNFXGotVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(4326008)(316002)(8676002)(5660300002)(38350700002)(66946007)(66556008)(31686004)(66476007)(86362001)(36756003)(6486002)(4744005)(508600001)(2616005)(31696002)(53546011)(44832011)(52116002)(8936002)(38100700002)(26005)(6506007)(6512007)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEltRTYvUUQ1MzZ6cFUrVDhtM1pHNk8zZURVY0Izd3FFdEVra3ROaGZKcm9R?=
 =?utf-8?B?bXRUN3BwN3pHaGhtc3d6eHc3U2RlOXpZQlRJQnloZ0ZuUWpTeWl4UlgzaEdn?=
 =?utf-8?B?RGU3QWIvN0lkeDdVWUVzQVhqYkdFYWVFbjhES3FBUzBHUHVxejB2bTYyZW9R?=
 =?utf-8?B?cjBwV3BqcGpkWldpb2tiSWJuc3I2c1BIeGRtMkw5UGxqb1dzbXFNR1VKaGpZ?=
 =?utf-8?B?bnFhZ040TFBvUnlRbkxEcTVGQWVtSXJkQnBDL2ZUK0gwL2RCdVk5WVRMbWMr?=
 =?utf-8?B?amRyd0ZoSWJxdFltQ0NEcTdhSmZqWXpsTytGaTViMmk5Q0hkNTEzaTRhU0FC?=
 =?utf-8?B?VzlDK09MUGJ3ZUxqcFczR0V0eXByZHdSSy90T2VKSXdBTVJTN0ZaeTNqNFJK?=
 =?utf-8?B?ektURFl6azNQNW5XQnBiNFk0b29VT2d5ZGNXZklQcVVURjYvd2VIWi9yUTVo?=
 =?utf-8?B?R0NZalllTlh2ckFnTEJMRTE0R0dRVVA2QXpManRUM0tZS21wTmlKOVdjRDBh?=
 =?utf-8?B?ZHZJQlRPQ0dLNGxDOE8rd0dERWNSd2E5ejA4dmpXdEtEZE9JaGtQdWsvUjFD?=
 =?utf-8?B?eGtWSmFKZVVhK3ZuZUpYVkFlRjN1L1lMR0tFcmV4emwwTm9zYnNoZHhpenVr?=
 =?utf-8?B?Z0xsQ0JrQzdKWS9QUDdEK2hHSE9vdVJkSkd2MTJsWE00VzFJSEYvMnAzdjVI?=
 =?utf-8?B?TEZHTnV0blRWVGJtbVZLaTlSK3RVTzA5SWVNVTBBUXFvaitnMnl1TXNjMXY3?=
 =?utf-8?B?elIzMTR1eU9zdlBqMW5DWWluWkc0M2g3S2hnb0tyTVFHL0RERjdhS2JQaEhS?=
 =?utf-8?B?SHJpYkRLM1E5ZUxRMkFNYmNiN1R6NzZacTJpcis4cFFPVEVpZU03czZRbHRZ?=
 =?utf-8?B?cUdrMjJhSVo3WUREQkY0eDdCMUtteGhQOWFrdE04a1pCc3BJSTZQeWUrTXkv?=
 =?utf-8?B?cUpzUXFaeVFYdXMzc24rYXczV3FXV3k0b1l3R25Fb2U4QnFBYXIwYWZYYWNP?=
 =?utf-8?B?V1lqV3E4OGxCMUdyWjZWb1RSQkJiQ25ZOE9wRjBidS9JU05TT2JEM2pRQXhY?=
 =?utf-8?B?M1dvd2tJSEtJQit5WVhpSWgvT1liWHJLd1d2UWN0bU9YRENuWVNWaUd5REVI?=
 =?utf-8?B?elhBeFcybnJTcVB5R1BJZWVQM2R6OXlHMmtFS2dhS2xUUm4vSms1enNGVXJH?=
 =?utf-8?B?aE5UVkd3NkZ2dDJsR2hhN1p4blFxdVgxU0dwZ2RScXphNCtNNUF6WGVqT3dF?=
 =?utf-8?B?V1NIK1RzVjRPTml0dHAvVDhxS0RYMnRKVllGU29ySWhhWnN6eE1aYW5XdFhW?=
 =?utf-8?B?TGd2cGtHanMrakJwMUNVVUVKTXgrZDhwVWxyYUM2ejBxb3BwWXJxcFdNK2k2?=
 =?utf-8?B?N0gzUjRDanpZSE85QTQyQWdOM0ErVDgrYU5RZ2xHRG1VKzY4NXJheTBsUm1T?=
 =?utf-8?B?UUFhZG94RDhkWElHMnFUSERaMFZPTUt5Wi93VHBmZ3NCNUszemdyNXd5dFRP?=
 =?utf-8?B?dVJvK2I2aXh1TW80QzhFd2hsMERoNE5SZ3BGL1ErY3QwcE8zZGtTMVRjK0N3?=
 =?utf-8?B?Qi8vWjl5M01oVnFzZndQczZFSEk5WEptMHhtL2x6MWRUV1pNcjd3a0gvK0JW?=
 =?utf-8?B?eXZab2YrKzdSRG9RdEt4UXdLamdVNzRJVXZTRGFVUXVxQVhZTUVvaC92dUZt?=
 =?utf-8?B?UHYvalVCMHdWdlkvdGZVZWp0M20vM3VlRkxhVnlHcUFUSUdYdXFWMjlzWjVP?=
 =?utf-8?B?YTVwUGVUVUluTEVTY3JWQ0JWeXZ4Uzl0M01CRzVoQVA2UUhicDhsZUtXUGNo?=
 =?utf-8?B?a2lmcklsSk04SlFIeVd3TWNEYUt5NWIrajdxaXBQVmhRdVFYdU5ydjRWT2pP?=
 =?utf-8?B?bnlVQm9SZEdIWFJnVDNWa1BTSkN5dk1tYTd6R2pwb0lCdTlNRVcwd0c3RkJa?=
 =?utf-8?B?NHZIMEdSSElUaUVWcDdrWjZTclNqbXZPYm5CVTFoQnU0Q1RYL1lPSE1qaUpJ?=
 =?utf-8?B?d2p1VVRJWXRPQ3JyemxHY2dtUzNLcTRwdXpMcVlDMkJEV1ZaS0h6UE5oN094?=
 =?utf-8?B?NGRCb0R0QW1oN3p4ZWU1TkdubE4vVEp2SlY3L2dqY05YdnhxWTI4YmQ5UkNF?=
 =?utf-8?B?b2RWd3dENmFJTGZ0R28xOEJ1T2FFNWV0MG8vRVpCaldtVVpEa2NtTXhkNVR2?=
 =?utf-8?B?ZlFhbVRPeDFDU2l0NUsvV0lLLzNIK2FDcllIQWNIdTZ4bjBPMjJNQVFMalVM?=
 =?utf-8?B?M0tBNnZOMmhpU0Q0N2ZPMnNuY2tiaTZQNm54dldBd2pZSzJ4NkZzWjlhYnlj?=
 =?utf-8?B?Q0s3WDFsbVpYd1RPOUpTSHR1dEw5LzFIV1g1SUJrbG5VTk94ak5Wd1dnVjJX?=
 =?utf-8?Q?q5a+JQT+ZR2tv9os=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b010df9-6bc0-4ba4-93b8-08da3e8f4f63
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 20:44:06.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cUJ0llPrXthjTbS9QbdRzt7UlhRvkNO51Di3CA4iCL3b3mIpNDEpiBIZXHPJXXYY+mGL3RLtimjKeNM1ZjDqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4619
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-25_06:2022-05-25,2022-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=976 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205250097
X-Proofpoint-GUID: iQ9p9kGBONQ7pOPs0NBQXnf3OefpoJnm
X-Proofpoint-ORIG-GUID: iQ9p9kGBONQ7pOPs0NBQXnf3OefpoJnm
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 12:52, Peter Xu wrote:
> It seems to exist since the old times and never used once.  Remove them.

Yes, and the code even assumes hugetlb pages are prefaulted.  i.e. No
page fault support exists.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/mm/hugetlbpage.c | 39 ---------------------------------------
>  1 file changed, 39 deletions(-)

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
