Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD79511639
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiD0LGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiD0LFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:05:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFA52B6F67
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:57:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R9G9KF032115;
        Wed, 27 Apr 2022 10:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : subject : to : cc : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=0t5UyPeBDSdkHNFGd8hdKkV+EbqK+j5EbwUPCtzfMoc=;
 b=EheUX1YkoFuDbJWEjLjFWkAPsiRcY8JmQU3lES+gsUzk2FiBjredxrnyr6VyWi6Y1wNR
 EHw0HBzrKzzX3OXp2YMSk3WQeZKQN9nACSRPaZdsoiv5kl6ccwFijn0q5dWaqD7/N5qy
 laSpQhIJdEC2XSSFV4r69oEc70DXaM//l6wYyhIZc0x+/MrbxKpCB26Nu1hyhHKe1dg1
 zpPp1HueaTkSnwSG55f2NaWndd/BriX9YKrBrEisknX9lI/i8URk072rN8w1E2HhLWBd
 eWv5GvPrPT4AN/IT4dvxZa3a95H7taP0wgD+C1dj68OjciY1YG43M7xFtF8jfNasufvr 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb100c4y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 10:56:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RAunY1011942;
        Wed, 27 Apr 2022 10:56:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5ykn945-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 10:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL9kMNnSMhTNjNYpr9MRRKZt8WQouC38mEvE04T3LUBeCbKnbJLPLfvg/nS0Ooote6MeCUjKd6hhrx6BRv7wZFIdbH3AvG0Hw9ll0zZzHus0XztwnNnvIcjFC0JURSFUmQURg8th+gG1A9R8qPsC3b+l3EotgaBpzZtnFP+5sSCTjQ0ah2747Ruc8pp4qMCh0SqgyljV2g0Z5lCV1+b5kOPJIWV8pABwx4ixnSSVbyAFOTuMmP3MCqGlOIktV7xpozpFwB+VMwPt/QTmOVtqEX1xiCNqbgSn/vqrJfRy3ZzDmcbQOLwndpt18xxCNKytXieGLyqh2eWSfLOHkmWLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t5UyPeBDSdkHNFGd8hdKkV+EbqK+j5EbwUPCtzfMoc=;
 b=INyh+YfiFyhQkzoLwaLsA2dIG5qQjLlyFRbixF1jzsrv6akSYF4WgkLimcafDEINZynSYLjLpUT6FT5jpas2yJV5S1fnzvC/6VvNide1QXeL7DaRMGqFvICiTc3hEWzEqTcta/ntK2J9ryTwy8eO8q3CDEvQBRI7qfFKKH53BUFo6I65hcyqhKjLcuG7ufMp6KvK6uHqTUVAJM8k0REVwQmrSBa47o2Y7ffmOsRnjKPSP11y+35EbVf7GeHiW6HXBhL21dN9gUJCzR6AokycOiGSlT0cSXjeurts2jUTRVXdehtvjsiZlflJFRMPeAIAuavqQyGWJW/pcbiL5Trfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t5UyPeBDSdkHNFGd8hdKkV+EbqK+j5EbwUPCtzfMoc=;
 b=RS2skslrxQOs5PvvkfPOkzWSoguZ2pCOE31Ky5cAQlVmHENgco1CiqLWma005F4fE0dTPB92v/2rxti/StIjxKvAzZP2vGWsKwH+duf769VfGbLxO74uEtayCnNdBvCmnCxyWZLnG9OIou3CJLd1lJINuqU3PpTs0SoFPonoknk=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DS7PR10MB4861.namprd10.prod.outlook.com (2603:10b6:5:3a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 10:56:50 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 10:56:50 +0000
Message-ID: <ef615782-f1b0-af1e-5341-f787d964756b@oracle.com>
Date:   Wed, 27 Apr 2022 05:56:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
From:   john.p.donnelly@oracle.com
Subject: [PATCH 5.15 1/1] Revert "locking/rwsem: Make handoff bit handling
 more consistent"
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Language: en-US
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:217::13) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78c8f5ac-9350-4f59-23b4-08da283ca195
X-MS-TrafficTypeDiagnostic: DS7PR10MB4861:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB48618B03FD89F3F9B79876D6C7FA9@DS7PR10MB4861.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Va2JfTYtxYbMhNoyCoqTtw/9wYlTxgQvuvB48i3C22JOHeLpNv2RtBeuTAX7LcNztluly1iZYQXSZTZkb6Ifd1CuN8r75jmc7DMoNXq/l1ln43pRoA5Ad/wCr+l+7Cp3pDN9isA1y84lMAwUD1D5gFUf9MqQTBi3x8pdVfErTJgAyDV+DqVdUIDG680+U+ulaodqAMFEblHf8P/HDeO6lb1GDglOjxAOB7d6pkvqaQktrO1Wt4DUem5au12jYALgGscQdCqe49mqLiF9inSvuBNxmx9UhzDYg7c6+GKXcJMebgJyKU1NtxkC2nddUWYrVpAJpFjwqTKkWLLxuOq1DG42npR2wJe6j8N5h9Nlrar4e2auuYeY41pXk2uVesiA13r9gRRUU9BvbgiVYZXYsX2bCdP2kpGq5mAC1kBVjQbl8LuifoDk59KLaN2BRtQADKEB+/KfNU7S/1wLAJGfuOg+Z6bqbT9R/CIg5zp7KEeqlFH5T2XQuIzCiyMi+p5vmhos4N8Q3QXbYxurxQur1CXMK43IauMi87i2yCYWfwYElTJu3oL5Jy02MjBEWZfU4PjW1+62nCKIFjlDfcQeLnzkEbkBPVFuHQLY5F2+33P3WNCJ5j7Z0KVP85yHk194EZS4nercj/iI3dlvQtXvhtEiHfaNTs7rdJ7MHtG/pfmPsUdOLEvutaC4KmAnod8FXbG2W8CrAtAnUPJnvZESpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(316002)(5660300002)(36756003)(186003)(2906002)(30864003)(66946007)(66556008)(4326008)(6916009)(8676002)(83380400001)(8936002)(31686004)(2616005)(31696002)(86362001)(6486002)(508600001)(38100700002)(6666004)(26005)(9686003)(6512007)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzlWSFdPOStxTzlQaUgrakZxa2FhMGR5MmZhald0YmVXLzNBblVGSGpsb3p5?=
 =?utf-8?B?SHFjMnllRkM4VWRXaHRBT01TdUVYMm55cmRkZTA0N2JRWXVkRlBqLzdPNTZI?=
 =?utf-8?B?Qlk5a1RuQUZGZXZzNHFhNHBrUmswdTcyeVp2SHI4UU8yQWhBTUtQZnBNU0Nv?=
 =?utf-8?B?VC9GZnRkL1N2SFltdkNFbmNyN1k3VGlSbGd0WlVYeTlmOXlUNDR3MWhxeity?=
 =?utf-8?B?dzNKbXdaL2p3cFJHMXVrd1BXWFJ0NHBQWExUT3RMd1c1dzJtVGorbVNBaTgr?=
 =?utf-8?B?YmJ3YmJJKzMybUFDNzBGUmpPQ1FhbDBocjJjSlo5NU90cGdRTW1wWGkvTkR2?=
 =?utf-8?B?VWVwOURNdSt6YTBad2ljbUM1bE43a2dhck1NeDFaVUY1SVp6MUN0TlJLYWRo?=
 =?utf-8?B?b0tNL09STlY4dTgwV1g5cjlLYllPNGR0N01LUGFCODFLeTZvaHhIZXBpZzNQ?=
 =?utf-8?B?MlJLSVZ3b1ZDQ1k4NHFINkZ6ZHF4SmJxUDVmdEhiSllnNWNaUitsMHhSQ2hy?=
 =?utf-8?B?OTZTZUs5MHpLZFQ4ODJRNDE5RUZBc25rWFV5Y0hZcFB2QmJqUVprN3dJRmt6?=
 =?utf-8?B?MXhwTk56TSttVkpsWkFQbG5lMTZZYVdMUHMxclFCaHdNN1QvNVJPNC9YMTdE?=
 =?utf-8?B?NVhIaWlIWTY4a05JS0c3MGwwY2VJQXdqZVhaQTBIcmN0Vk9UZXNCaEZXZGJt?=
 =?utf-8?B?TXB2VkxWdDRuc29YZlJiRjVpWjlJUnZGaiswSERuOThMUjVleXg3dnlVbCtU?=
 =?utf-8?B?K0d4WHVINkFMMFliY2NiR3oxeEtrZzJDc0RMak5QL0dDSHNHS1BnWHZIWXhS?=
 =?utf-8?B?L1g3UjBpWnJIdng4MGJDK2R3ZVJkdzZSZkxhOU5FN3U1V1hqOGU2a0k5NTFB?=
 =?utf-8?B?OVFuY0U3T1hHckk4VjFLSnhpYnR4Z094WVppUEtkaDBmKzdqTzZlT0h5c0t4?=
 =?utf-8?B?aU00TmlEWlBoUTlPV25vLzJaYVdWOGwxRFA1RmphNFlWZGowU254OHFPaElo?=
 =?utf-8?B?eVI2d2FsNFIvKzdSUElKSXNKYjdXTXZiQ2cvbXo4dmw3eDZkalZGQUJvcHNU?=
 =?utf-8?B?ckhzbGphRk5tSVczRkVEemZyK29paTBmajBTVWNza05iUjBHK1RIS2hTRldl?=
 =?utf-8?B?WDg0OTNRdHY2QndZd1hZYlFxN3VXaTZNN2FwYUhYTXVnNkRIdGhVTS9USkJU?=
 =?utf-8?B?V09WbFMyNG5PcFNQMDRzZk52bjkwVXVYMlFzMTduWm0vZFVUUW9OaVBFckNV?=
 =?utf-8?B?ZVJUdmt4ZkxqZjNYTVJBcittcVJtbk5ncGw3YUZyS3hmNm4wcDhHYlVQYXJE?=
 =?utf-8?B?QTVQK0ZhVHZYMm55TEM4T1pBYzZOQVB0UEdVRVJFOHc0QzhSUTQvczBqM2JL?=
 =?utf-8?B?aExSM29PZldjS2ZjQ0JHd3JpNUE5a3RUVjhFdnZuQk1VUzRjbmdMWjZOZm5K?=
 =?utf-8?B?cXFnQ2Y5K01INmFnakJlOFp1RTFqKy9vOVFoRnlZVUZMYkdUcDBrLzFLWExT?=
 =?utf-8?B?SDN2Z0NNSDE5aU90Ky84cnkwWEY5ODhvaTNwbW5sTGVOU1lxWUFId1hOMmsw?=
 =?utf-8?B?Y3pWUkhGdnpOeDErZ1U2TThyT29RVEV1QVpUTGp5K2lnUTRyNU9iOEJNcXBY?=
 =?utf-8?B?eHVVeWN3elNPbGlMS0NsbVVkWXJMeWt1ZHR4M1dGcFBNVmgvVlJ2cXdNNFNO?=
 =?utf-8?B?TjdidU9rYU9VQ0FTREd3SDVXc1hIY1lsTHdjWlJWSXcySUo1a2VMcy9DVENm?=
 =?utf-8?B?UnR2SVAwNzk1UHNUTXFEL0FDcE8zNmdERlVVSXVYVlNuVFVBMHZOa2lnQnNl?=
 =?utf-8?B?ZVU1WkxhaGZMMVFWQmYrYU1KTHVLNTQ5eGRIWmkwdWJjMmhkdXlIYzM5UEJr?=
 =?utf-8?B?ZzhsWUJVNlAvZlNsUkI0VWtEWko4bHlZRjk5Tnp3UzJidjNvU0FTa3JlNnlP?=
 =?utf-8?B?bmZodHp3ZHNOL2lrNmVTQUNkTmxUWHd5Ykp1cWRKNjhDK3A4Nmp2eTdpWFdO?=
 =?utf-8?B?aUtlUmlycmxvY0JsY1FOVEJLUWdtRGoxT2F1Nmsrbm15d3JjK1JQbkpmVXhZ?=
 =?utf-8?B?N05WMWxaYUlPY3ZJckxhU1p1ZzlVczNOczR0cjZRaktoc0NBdWVzcStRU3o0?=
 =?utf-8?B?Wko2bG1RbWxid2ZCYTFDb28zNjJNbUpKMU5qQVcxbHFjamRGTllvZkJsZUdw?=
 =?utf-8?B?ZUdCclJCSzJURE5MaFY5SUxoQXZsL2w4SHVZWlN2Z0J4bzdxVzU5V3JmNlly?=
 =?utf-8?B?bG05QVhjb003TnF1UFh1TUd4bjRBZkNEZlRMYUo0cEFtMUcvVlA3cHpuSm9Y?=
 =?utf-8?B?alg3Y2dtdWJDN3doRHgxMWladFVMK3lCV2FRWXlhdzhEYy9ySFNpQkdJVms0?=
 =?utf-8?Q?QelKr8Okr12UjI8U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c8f5ac-9350-4f59-23b4-08da283ca195
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 10:56:50.1806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDDDmF7i+hH8SY4ziGBuwI4r0I9rtaQ51SDXcZeeV9aMKwlnm0wl/sZoNTx3W0cMyz4OfIAUB970eEv7EY8HG/AZVcgY4acMc07Nx4+wMQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4861
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_03:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270072
X-Proofpoint-ORIG-GUID: 1ZdMfq7sKHUYbbqnE-nmJbZccSkSAqcH
X-Proofpoint-GUID: 1ZdMfq7sKHUYbbqnE-nmJbZccSkSAqcH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 76723ed1fb8922ee94089e7432b8a262e3a06ed7.

This commit has introduced frequent system hangs running "fio test 
suite" on a variety of filesystem types on LVM volumes composed of four 
nvme devices.

This issue was first encountered in Linux 5.15.30, and later in Linux 
5.17.y.

Each panic includes the rwsem_down_write_slowpath() :

ext4:

PID: 3682   TASK: ffff8f489ae34bc0  CPU: 2   COMMAND: "dio/dm-0"
  #0 [fffffe0000083e50] crash_nmi_callback at ffffffff828772b3
  #1 [fffffe0000083e58] nmi_handle at ffffffff82840778
  #2 [fffffe0000083ea0] default_do_nmi at ffffffff8337a1e2
  #3 [fffffe0000083ec8] exc_nmi at ffffffff8337a48d
  #4 [fffffe0000083ef0] end_repeat_nmi at ffffffff8340153b
     [exception RIP: _raw_spin_lock_irq+23]
     RIP: ffffffff8338b2e7  RSP: ffff9c4409b47c78  RFLAGS: 00000046
     RAX: 0000000000000000  RBX: ffff8f489ae34bc0  RCX: 0000000000000000
     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff8f47f7b90104
     RBP: ffff9c4409b47d20   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff8f47f7b90104
     R13: ffff9c4409b47cb0  R14: ffff8f47f7b900f0  R15: 0000000000000000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  #5 [ffff9c4409b47c78] _raw_spin_lock_irq at ffffffff8338b2e7
  #6 [ffff9c4409b47c78] rwsem_down_write_slowpath at ffffffff82925be9
  #7 [ffff9c4409b47d28] ext4_map_blocks at ffffffffc11c26dc [ext4]
  #8 [ffff9c4409b47d98] ext4_convert_unwritten_extents at
ffffffffc11ad9e0 [ext4]
  #9 [ffff9c4409b47df0] ext4_dio_write_end_io at ffffffffc11b22aa [ext4]

xfs:

PID: 3719   TASK: ffff9f81d2d74bc0  CPU: 37  COMMAND: "dio/dm-0"
  #0 [fffffe0000894e50] crash_nmi_callback at ffffffffad6772b3
  #1 [fffffe0000894e58] nmi_handle at ffffffffad640778
  #2 [fffffe0000894ea0] default_do_nmi at ffffffffae17a1e2
  #3 [fffffe0000894ec8] exc_nmi at ffffffffae17a48d
  #4 [fffffe0000894ef0] end_repeat_nmi at ffffffffae20153b
     [exception RIP: _raw_spin_lock_irq+23]
     RIP: ffffffffae18b2e7  RSP: ffffbb7ec9637c48  RFLAGS: 00000046
     RAX: 0000000000000000  RBX: ffff9f81d2d74bc0  RCX: 0000000000000000
     RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffff9f81c04a918c
     RBP: ffffbb7ec9637ce8   R8: 0000000000000000   R9: 0000000000000000
     R10: 0000000000000000  R11: 0000000000000000  R12: ffff9f81c04a918c
     R13: ffffbb7ec9637c80  R14: ffff9f81c04a9178  R15: 0000000000000000
     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
     <NMI exception stack> ---
  #5 [ffffbb7ec9637c48] _raw_spin_lock_irq at ffffffffae18b2e7
  #6 [ffffbb7ec9637c48] rwsem_down_write_slowpath at ffffffffad725be9
  #7 [ffffbb7ec9637cf0] xfs_trans_alloc_inode at ffffffffc074f2bd [xfs]
  #8 [ffffbb7ec9637d50] xfs_iomap_write_unwritten at ffffffffc073ad15

Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
Reviewed-by: Jack Vogel <jack.vogel@oracle.com>
---
  kernel/locking/rwsem.c | 171 +++++++++++++++++++++--------------------
  1 file changed, 86 insertions(+), 85 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index e63f740c2cc8..29eea50a3e67 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -106,9 +106,9 @@
   * atomic_long_cmpxchg() will be used to obtain writer lock.
   *
   * There are three places where the lock handoff bit may be set or 
cleared.
- * 1) rwsem_mark_wake() for readers		-- set, clear
- * 2) rwsem_try_write_lock() for writers	-- set, clear
- * 3) rwsem_del_waiter()			-- clear
+ * 1) rwsem_mark_wake() for readers.
+ * 2) rwsem_try_write_lock() for writers.
+ * 3) Error path of rwsem_down_write_slowpath().
   *
   * For all the above cases, wait_lock will be held. A writer must also
   * be the first one in the wait_list to be eligible for setting the 
handoff
@@ -335,9 +335,6 @@ struct rwsem_waiter {
  	struct task_struct *task;
  	enum rwsem_waiter_type type;
  	unsigned long timeout;
-
-	/* Writer only, not initialized in reader */
-	bool handoff_set;
  };
  #define rwsem_first_waiter(sem) \
  	list_first_entry(&sem->wait_list, struct rwsem_waiter, list)
@@ -348,6 +345,12 @@ enum rwsem_wake_type {
  	RWSEM_WAKE_READ_OWNED	/* Waker thread holds the read lock */
  };
  +enum writer_wait_state {
+	WRITER_NOT_FIRST,	/* Writer is not first in wait list */
+	WRITER_FIRST,		/* Writer is first in wait list     */
+	WRITER_HANDOFF		/* Writer is first & handoff needed */
+};
+
  /*
   * The typical HZ value is either 250 or 1000. So set the minimum waiting
   * time to at least 4ms or 1 jiffy (if it is higher than 4ms) in the wait
@@ -363,31 +366,6 @@ enum rwsem_wake_type {
   */
  #define MAX_READERS_WAKEUP	0x100
  -static inline void
-rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
-{
-	lockdep_assert_held(&sem->wait_lock);
-	list_add_tail(&waiter->list, &sem->wait_list);
-	/* caller will set RWSEM_FLAG_WAITERS */
-}
-
-/*
- * Remove a waiter from the wait_list and clear flags.
- *
- * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 
'copy' of
- * this function. Modify with care.
- */
-static inline void
-rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
-{
-	lockdep_assert_held(&sem->wait_lock);
-	list_del(&waiter->list);
-	if (likely(!list_empty(&sem->wait_list)))
-		return;
-
-	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
-}
-
  /*
   * handle the lock release when processes blocked on it that can now run
   * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -399,8 +377,6 @@ rwsem_del_waiter(struct rw_semaphore *sem, struct 
rwsem_waiter *waiter)
   *   preferably when the wait_lock is released
   * - woken process blocks are discarded from the list after having 
task zeroed
   * - writers are only marked woken if downgrading is false
- *
- * Implies rwsem_del_waiter() for all woken readers.
   */
  static void rwsem_mark_wake(struct rw_semaphore *sem,
  			    enum rwsem_wake_type wake_type,
@@ -515,25 +491,18 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
   	adjustment = woken * RWSEM_READER_BIAS - adjustment;
  	lockevent_cond_inc(rwsem_wake_reader, woken);
-
-	oldcount = atomic_long_read(&sem->count);
  	if (list_empty(&sem->wait_list)) {
-		/*
-		 * Combined with list_move_tail() above, this implies
-		 * rwsem_del_waiter().
-		 */
+		/* hit end of list above */
  		adjustment -= RWSEM_FLAG_WAITERS;
-		if (oldcount & RWSEM_FLAG_HANDOFF)
-			adjustment -= RWSEM_FLAG_HANDOFF;
-	} else if (woken) {
-		/*
-		 * When we've woken a reader, we no longer need to force
-		 * writers to give up the lock and we can clear HANDOFF.
-		 */
-		if (oldcount & RWSEM_FLAG_HANDOFF)
-			adjustment -= RWSEM_FLAG_HANDOFF;
  	}
  +	/*
+	 * When we've woken a reader, we no longer need to force writers
+	 * to give up the lock and we can clear HANDOFF.
+	 */
+	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
+		adjustment -= RWSEM_FLAG_HANDOFF;
+
  	if (adjustment)
  		atomic_long_add(adjustment, &sem->count);
  @@ -564,12 +533,12 @@ static void rwsem_mark_wake(struct rw_semaphore 
*sem,
   * race conditions between checking the rwsem wait list and setting the
   * sem->count accordingly.
   *
- * Implies rwsem_del_waiter() on success.
+ * If wstate is WRITER_HANDOFF, it will make sure that either the handoff
+ * bit is set or the lock is acquired with handoff bit cleared.
   */
  static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					struct rwsem_waiter *waiter)
+					enum writer_wait_state wstate)
  {
-	bool first = rwsem_first_waiter(sem) == waiter;
  	long count, new;
   	lockdep_assert_held(&sem->wait_lock);
@@ -578,19 +547,13 @@ static inline bool rwsem_try_write_lock(struct 
rw_semaphore *sem,
  	do {
  		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
  -		if (has_handoff) {
-			if (!first)
-				return false;
-
-			/* First waiter inherits a previously set handoff bit */
-			waiter->handoff_set = true;
-		}
+		if (has_handoff && wstate == WRITER_NOT_FIRST)
+			return false;
   		new = count;
   		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (!rt_task(waiter->task) &&
-					    !time_after(jiffies, waiter->timeout)))
+			if (has_handoff || (wstate != WRITER_HANDOFF))
  				return false;
   			new |= RWSEM_FLAG_HANDOFF;
@@ -607,17 +570,9 @@ static inline bool rwsem_try_write_lock(struct 
rw_semaphore *sem,
  	 * We have either acquired the lock with handoff bit cleared or
  	 * set the handoff bit.
  	 */
-	if (new & RWSEM_FLAG_HANDOFF) {
-		waiter->handoff_set = true;
-		lockevent_inc(rwsem_wlock_handoff);
+	if (new & RWSEM_FLAG_HANDOFF)
  		return false;
-	}
  -	/*
-	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
-	 * success.
-	 */
-	list_del(&waiter->list);
  	rwsem_set_owner(sem);
  	return true;
  }
@@ -998,7 +953,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, 
long count, unsigned int stat
  		}
  		adjustment += RWSEM_FLAG_WAITERS;
  	}
-	rwsem_add_waiter(sem, &waiter);
+	list_add_tail(&waiter.list, &sem->wait_list);
   	/* we're now waiting on the lock, but no longer actively locking */
  	count = atomic_long_add_return(adjustment, &sem->count);
@@ -1044,7 +999,11 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, 
long count, unsigned int stat
  	return sem;
   out_nolock:
-	rwsem_del_waiter(sem, &waiter);
+	list_del(&waiter.list);
+	if (list_empty(&sem->wait_list)) {
+		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
+				   &sem->count);
+	}
  	raw_spin_unlock_irq(&sem->wait_lock);
  	__set_current_state(TASK_RUNNING);
  	lockevent_inc(rwsem_rlock_fail);
@@ -1058,7 +1017,9 @@ static struct rw_semaphore *
  rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
  {
  	long count;
+	enum writer_wait_state wstate;
  	struct rwsem_waiter waiter;
+	struct rw_semaphore *ret = sem;
  	DEFINE_WAKE_Q(wake_q);
   	/* do optimistic spinning and steal lock if possible */
@@ -1074,13 +1035,16 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
  	waiter.task = current;
  	waiter.type = RWSEM_WAITING_FOR_WRITE;
  	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
-	waiter.handoff_set = false;
   	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_add_waiter(sem, &waiter);
+
+	/* account for this before adding a new element to the list */
+	wstate = list_empty(&sem->wait_list) ? WRITER_FIRST : WRITER_NOT_FIRST;
+
+	list_add_tail(&waiter.list, &sem->wait_list);
   	/* we're now waiting on the lock */
-	if (rwsem_first_waiter(sem) != &waiter) {
+	if (wstate == WRITER_NOT_FIRST) {
  		count = atomic_long_read(&sem->count);
   		/*
@@ -1116,16 +1080,13 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
  	/* wait until we successfully acquire the lock */
  	set_current_state(state);
  	for (;;) {
-		if (rwsem_try_write_lock(sem, &waiter)) {
+		if (rwsem_try_write_lock(sem, wstate)) {
  			/* rwsem_try_write_lock() implies ACQUIRE on success */
  			break;
  		}
   		raw_spin_unlock_irq(&sem->wait_lock);
  -		if (signal_pending_state(state, current))
-			goto out_nolock;
-
  		/*
  		 * After setting the handoff bit and failing to acquire
  		 * the lock, attempt to spin on owner to accelerate lock
@@ -1134,7 +1095,7 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
  		 * In this case, we attempt to acquire the lock again
  		 * without sleeping.
  		 */
-		if (waiter.handoff_set) {
+		if (wstate == WRITER_HANDOFF) {
  			enum owner_state owner_state;
   			preempt_disable();
@@ -1145,26 +1106,66 @@ rwsem_down_write_slowpath(struct rw_semaphore 
*sem, int state)
  				goto trylock_again;
  		}
  -		schedule();
-		lockevent_inc(rwsem_sleep_writer);
-		set_current_state(state);
+		/* Block until there are no active lockers. */
+		for (;;) {
+			if (signal_pending_state(state, current))
+				goto out_nolock;
+
+			schedule();
+			lockevent_inc(rwsem_sleep_writer);
+			set_current_state(state);
+			/*
+			 * If HANDOFF bit is set, unconditionally do
+			 * a trylock.
+			 */
+			if (wstate == WRITER_HANDOFF)
+				break;
+
+			if ((wstate == WRITER_NOT_FIRST) &&
+			    (rwsem_first_waiter(sem) == &waiter))
+				wstate = WRITER_FIRST;
+
+			count = atomic_long_read(&sem->count);
+			if (!(count & RWSEM_LOCK_MASK))
+				break;
+
+			/*
+			 * The setting of the handoff bit is deferred
+			 * until rwsem_try_write_lock() is called.
+			 */
+			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
+			    time_after(jiffies, waiter.timeout))) {
+				wstate = WRITER_HANDOFF;
+				lockevent_inc(rwsem_wlock_handoff);
+				break;
+			}
+		}
  trylock_again:
  		raw_spin_lock_irq(&sem->wait_lock);
  	}
  	__set_current_state(TASK_RUNNING);
+	list_del(&waiter.list);
  	raw_spin_unlock_irq(&sem->wait_lock);
  	lockevent_inc(rwsem_wlock);
-	return sem;
+
+	return ret;
   out_nolock:
  	__set_current_state(TASK_RUNNING);
  	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_del_waiter(sem, &waiter);
-	if (!list_empty(&sem->wait_list))
+	list_del(&waiter.list);
+
+	if (unlikely(wstate == WRITER_HANDOFF))
+		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
+
+	if (list_empty(&sem->wait_list))
+		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
+	else
  		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
  	raw_spin_unlock_irq(&sem->wait_lock);
  	wake_up_q(&wake_q);
  	lockevent_inc(rwsem_wlock_fail);
+
  	return ERR_PTR(-EINTR);
  }
  -- 2.31.1

