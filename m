Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F361F4F0B85
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359634AbiDCRR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355278AbiDCRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:17:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED313DD7;
        Sun,  3 Apr 2022 10:15:24 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 233A4OVP018756;
        Sun, 3 Apr 2022 17:15:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=1GpoZJ7pupMjq4O6pM1F6Q2CpWcOZawkigqbKqNUabo=;
 b=KxNbf+TH+7yI29+qRmcJH9gfgxLUCsnVhzyAg5zYW5PJ2Cb1nSPnMAr9wfH7n8GEEWCh
 RsKAXhUgFk81YL/aEFJcfM+9DxpF7CSgYjNIKTsBhlg1xk7oj45GffFoPnkWQXtxV9JZ
 UTllsyClezOOs9YfRYa7+3xXK9DmCl63swge3B5BE7Y8AAjVcdgbyyeG+wxLf0Ky+LVS
 P4n/KovDEggk3ve4QFQnQ7rkovs9ra91iXMKrFMyxPWdSOKbvzhjsIRbSabUFsuQYWV1
 6uWlCUuVEIBd0c4pB5hqblEda6nnOyhBe0s17KSZIIUmsvRzkipGqs1waBlP19n//DhE aA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3shhkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 17:15:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 233HBZsm034696;
        Sun, 3 Apr 2022 17:15:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx1ts1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Apr 2022 17:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBkyaF6DgsMI3ISnEDzi3JXsK40LKNr48sF6piZ0lhhSw1BO3pVf3UgGp73X1TjM1uf9UvnHQbjLl5a4xnfS+LxW2IENI8vRVAxDUYL0UEJhSRGGgpfGMz23A6cmduGAfEwfGevdNGnzFSHTjjhLGTGdpBRAYyf4g7SROF8ZaeJ6IQcHofz/+owEzUIjHwsP0Atr6olU/R7QnxymAlurT4nmfRTbwF6o6Khd5KpYbxbKv9aDh64ZBBFJCSJPE6Jt0sAMw2E+DNSN72Va1TwwB5CISnhJXoT9Qzm6/YD2DDXsRqqy3dPNeT1v38o4X3//k+qSnjHinsReLj7k+lT6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GpoZJ7pupMjq4O6pM1F6Q2CpWcOZawkigqbKqNUabo=;
 b=lT/EtykX1w7fXk0mvomWJrUTt9mPu55e+X4Sadbz5HZlqolWTDTyhIslcG725gXPiZvajTjrdGXwmEfI/2gAXq4JGQrlBIlXAQSSBhPgdEue/r7xcNNIiueLNuKK/0HNSv9piGE0CF4bT2oCXcrvOHwmBM4Ms/BO5FWz5oHcssG8ImuZqkHyRxiI7ky2VzvQCRLYnGeNyv+Plrt4rkoMzPyA3RkTy2UXAFuQEnlt7InYbvoGXm6Hc36dHvnm8YKNXyHf/aNxe04cADAR4bwbEkSM5WBbksu1QZNKb+wVC6wZym0tvQTuY2iBNG17/6CKrmQxd9Ofq7MgCmHIBj/NCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GpoZJ7pupMjq4O6pM1F6Q2CpWcOZawkigqbKqNUabo=;
 b=nxi1uSgtNlDGX792RiwStcJD3cU4JBqLCcqWMxmnuCoq8XeBPAGjgxKSS/iakVZLkkwG6pAbniVh1/eOJuQQNR1JNZX+5ZfcRRq3uFpdQLw5788eGNHa/JMQRJDP6DLlr13iiWRcHkU0EbAF+5kkyUJrVM6PUIq23nL3bh7bweU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB5439.namprd10.prod.outlook.com (2603:10b6:a03:303::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 17:15:01 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3cb2:a04:baff:8586%2]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 17:15:01 +0000
Message-ID: <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
Date:   Sun, 3 Apr 2022 12:14:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
Content-Language: en-US
To:     Wenchao Hao <haowenchao@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Steffen Maier <maier@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
Cc:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        zhangjian013@huawei.com
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:610:5a::21) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f88a3ca-90e3-4f05-0854-08da15957c83
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5439E3E840BA933B01E49360F1E29@SJ0PR10MB5439.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59+hwP8PMkHrqC3Wn0iCqH4OUQGvTSpWFglo/b3mkEA/HvI2DaHMsqfLEZN0Brn3wbtF8kusL4EXStDbNZuhrA81GVZM7uZeqxannVFy/gZjWi5zvBhgx43r9b2SSeJI0P3Ra9fCltp5VXQ9HYrBx+6b1FgZucayJc7ZiQCgXGjfA05SW5hQ3DzCeCk5dPn+nGEBUQIN4LhI0bibBCyAuSO1GM0LMF79KTF1uWpr9UXF295xUVdWCRXVfwxcqWT3n4KsX7DJctKYLaiWkIj6y5by/X6humtKdax0nupJIEUZJKWJtX9c2LH0aO5m1ygViAV6nJSOuei5Gh4KHZhS7HJC/zQeJAWsbzBLSvNaeRI0CZG3T/l5ErsPkAF1XuRZcASCyZUaEEVpRW8YpPs4ubZ2M/LyTTRhHxFVUm0VFyz4Pj3ysPtlpqHbLTpGtsKoLwSsZhj4DoddyU+v18lEKt8JXGq2qMIOXpfpIJ3RKpMYJ2lrmIHlxWTNBZb3eLmLFuJtaaGzKgDyZRW8QIlU29EHxI6Wb3SbS00SrrIdPNdVYqwHYXpW9vm1GOcYGPV5CbiFzZ3TC8k0H2Ss7J2o9yd5dtfl/x2thms0+cS/dJqaeOfTeq86Q2v7g0m0U9WbpUFdA+G0ap7HwUwbnF2lTpaminMLiHHuIRm+t+7NIud7zck89KLkk7RD0288+OJFA9BvfXtEeU5/Keu1lB1akFRYQG8IHwNAXbQJGxTB20P+v8P0hzFrqruEpL4UD7nKB2bKWOYLYUYdsfSZdiWh9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(2906002)(6506007)(53546011)(6486002)(508600001)(8936002)(83380400001)(2616005)(86362001)(5660300002)(31696002)(38100700002)(4326008)(31686004)(110136005)(316002)(54906003)(66556008)(66476007)(7416002)(66946007)(36756003)(26005)(8676002)(186003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3RwN2dIVnZFaTY1RnFyZ1FSWCtnQW8rWnlCNjZlQzk5N0FMZDMrQ1dCWnF2?=
 =?utf-8?B?RXEzVjZ0OWw0UHFNeHJaL1lnMFovTWtDQmdPNy9paVdGUXN0bU9TOHZFT1dm?=
 =?utf-8?B?RVZWYXU3djBIdXhtZ0lvamZYZ2UxZnY2VGpkUk5Qb2tkWTlyYTQzek15eWNx?=
 =?utf-8?B?REFtdDQ1NHJPYytRc2o4UFFMR1hEcnlpOFhwVGhqL0hrbE9KaDJGT3M2RG1Z?=
 =?utf-8?B?VCtmemtUQ04yb1BnQW5lYmlXcG1OblJEZjArMlUvUmE3VVp2K0YvSnpIMHFI?=
 =?utf-8?B?aHFIdmRTWTd0T013NTJvcER5RXk0MFNKQ0FsZk5SV2FnNjJFTmxLNU5EbWdC?=
 =?utf-8?B?eVRZU0RtS1dIYlhqOFZSc1JsY0gyajFiV0NjUFI1NkZwRDhPaWNUZFJxVmVZ?=
 =?utf-8?B?NXhPbUtrbmppMVRFVVJPNjF4L3prTDBLaVpkM3g5Z0gvRENsdzRUZGdrRVIz?=
 =?utf-8?B?M0c2eVBlRHJXRmNlOElZVHYrSkFWTkJIVHFrc3hWRmUydDJ2UTE2SFFyb05o?=
 =?utf-8?B?ZWtodUNtMU15N3JYbjlxUXFtS2ZPem0xQjNobGw0b3AxQ2twcmhSS1ZqWG4r?=
 =?utf-8?B?MVd1VTlidk5ZWjA1VTRYRkltS3N6NzBETi9SZll3bmZKTVZIT2k0bTdmNXFQ?=
 =?utf-8?B?b2tjM3NXMU5VSjNGcWY0b2QyN3cyaXlZZHhPa1dKdjFNUzFrSHVzVEttMUFP?=
 =?utf-8?B?QlB5enVtQndCSll3cVljd3lETE9OakRlNkFtSjF6Q1NFZG1GYklaM1Z1N09i?=
 =?utf-8?B?NEpNcGhrYWdjejNPeWxHalJ0ZFhwMkJ0b2U0Y3ZQSzA4VEhCTENmMk4rU0xR?=
 =?utf-8?B?RHVyUmlKa0VQRGIwQkRYYVNMeWV1UWROZHdZODQvUDdqb0I1MUtMWmRHS3pq?=
 =?utf-8?B?NmtuZ3VDUGhySnY0dEpBU0Z5ODZPQWV0RUJ5L3FNcC9uSFZwUDBiZHkvalVa?=
 =?utf-8?B?VitGU2dyTndhOHdZNVFUR2p2dHR3MmlaQ2VBQXZMaXoyNnRiaFVOQk1rU0tH?=
 =?utf-8?B?VFQrY0paY0hBN1NWVTVFR0VQeW4zU1pIZllBZE1DSnZQSkxReXpva3pRU0JL?=
 =?utf-8?B?dWhHeDkzSmIxUjVQY0Z5RWRiUStlZmFVTHRMaDRHWFV5SVYzOTZJQU03THMy?=
 =?utf-8?B?RS9iZDdrQSs5MjNyTlJpNXBwK08yVU1uZy9kdnlwL2xnR0oweWl0K2tNVGQ3?=
 =?utf-8?B?MFYxQWl3WGNjaTZuQ2ZWSEZpNHZPcXpDS0xNMTFJVHU4eGJsaFNxZHZqZFJZ?=
 =?utf-8?B?M0oyV2I2MUFuTUpTTUV6WGUxU2tuc3lrcmw1NVRhM2MwTnBkWmI3ZjVFdnU5?=
 =?utf-8?B?SE9XNjNLakxyZi9peTNtWXpvSjVMeWdmTlRjNUw5OXMvWUJMQWtWYUVMQTlq?=
 =?utf-8?B?SzRaNTdicU9GNE44RkM1dkFidUZ0TTVVOVhuUHdsL0oyTk9XSUpYUFZJcWl6?=
 =?utf-8?B?aHpyeldrcTdMWGhTNWxSekZETDR6MjJqMisrcTJBOFU5cmk4WmU1WkdhVVE3?=
 =?utf-8?B?bG44TitkTk1jWEtldG02TTdKai82KzV4cjNHUHBocmlEYWh6TEc3THdlVyt1?=
 =?utf-8?B?eVV5bFZkNFg3dUtFeWIzSzk2NUkwRmdyVCtka0daNERwMGZiZ2g3QXhnVHRW?=
 =?utf-8?B?emo4eFJDV2hoR2FIeWJFakh1ODhxQnN0RGp1ZlcxSEh4N2lqUEozeHM1d3pD?=
 =?utf-8?B?T2NHMnVEbndSS0hIbTJ6c3VWSkVPR2VqOUl6VjBvd3E5RGxsZDM1YURON3BL?=
 =?utf-8?B?RndPRnJvZDZhd2JnU05nWHB6eDd5YVJsNmFCR1Nib0syM0w4SUJuTUZSc2hB?=
 =?utf-8?B?MndyWWhKWGR6cHZDUnozYzl4S0hZMEdwT1VLcldqSFluVmFEcGRzNGo2QVJY?=
 =?utf-8?B?RmcxdjAxS1Jhc1ZibktyNUM5QUx0c0M5QnpUYU1mSDhXTXhPaEt6dkErZTFr?=
 =?utf-8?B?eEYzN1VrS05jamF1M2dKOFRXdHF6c2VOQ2xtOHhRQmFyRndUN3ZnZGlhSEFH?=
 =?utf-8?B?Mm9SajhEbDdaZjYrY3psaXRvZHk2aTVRQUtSekI2SHMrTnNOK283QTY2bk5u?=
 =?utf-8?B?QisxZ0wvbURnQmJvclI1aXBVYVVsV1YvYjU3RzRIWXg5bFMzTUZDZitJZGZP?=
 =?utf-8?B?VHErb1lvUnpPVElnaW12MnRUMjh6S01XU3dUTWFwWmowRmlXWHFaNzNuQnpS?=
 =?utf-8?B?Y3ZUSlE1OWxLdVJqVGJyNHViR1E1Ym8rKzNkVHh0U3ErSVlTRmtiZmUwTlRY?=
 =?utf-8?B?MEVyaGppdWN0OWcySmxCbndZTWdpYW1qdlFOdWF4UE1oUHp4OEtHaXQvZkd5?=
 =?utf-8?B?M0R2RWh6ZVloMVNpeW5JZFNrRTVtdzZjMDFDODM5Y2lOS3dCbTNMUk81WW9t?=
 =?utf-8?Q?gMWcKxLtyjg02ELQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f88a3ca-90e3-4f05-0854-08da15957c83
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 17:15:01.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMEkNkJQIpI8s7k5kcRHPTvP1x831NSVdVBtIH8FyLj/sN0okRVVN+6jFKTN6+EwsyrenUKvnmRcKI1Y0mFE4d8agvy78OCidPvh9Uk2Pq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5439
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-03_04:2022-03-30,2022-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204030114
X-Proofpoint-ORIG-GUID: NF9w65DU5Gb2UO4TV9E_v4rysCgpF0yL
X-Proofpoint-GUID: NF9w65DU5Gb2UO4TV9E_v4rysCgpF0yL
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 5:59 AM, Wenchao Hao wrote:
> On 2022/3/30 17:32, Hannes Reinecke wrote:
>> On 3/30/22 11:11, Wenchao Hao wrote:
>>> On 2022/3/30 2:56, Hannes Reinecke wrote:
>>>> On 3/29/22 14:40, Wenchao Hao wrote:
>>>>> On 2022/3/29 18:56, Steffen Maier wrote:
>>>>>> On 3/29/22 11:06, Wenchao Hao wrote:
>>>>>>> SCSI timeout would call scsi_eh_scmd_add() on some conditions, host would be set
>>>>>>> to SHOST_RECOVERY state. Once host enter SHOST_RECOVERY, IOs submitted to all
>>>>>>> devices in this host would not succeed until the scsi_error_handler() finished.
>>>>>>> The scsi_error_handler() might takes long time to be done, it's unbearable when
>>>>>>> host has massive devices.
>>>>>>>
>>>>>>> I want to ask is anyone applying another error handler flow to address this
>>>>>>> phenomenon?
>>>>>>>
>>>>>>> I think we can move some operations(like scsi get sense, scsi send startunit
>>>>>>> and scsi device reset) out of scsi_unjam_host(), to perform these operations
>>>>>>> without setting host to SHOST_RECOVERY? It would reduce the time of block the
>>>>>>> whole host.
>>>>>>>
>>>>>>> Waiting for your discussion.
>>>>>>
>>>>>> We already have "async" aborts before even entering scsi_eh. So your use case seems to imply that those aborts fail and we enter scsi_eh?
>>>>>>
>>>>>
>>>>> Yes, I mean when scsi_abort_command() failed and scsi_eh_scmd_add() is called.
>>>>>
>>>>>> There's eh_deadline for limiting the time spent in escalation of scsi_eh, and instead directly go to host reset. Would this help?
>>>>>>
>>>>>>
>>>>>
>>>>> The deadline seems not helpful. What we want to see is a single LUN's command error
>>>>> would not stop other LUNs which share the same host. So my plan is to move reset LUN out
>>>>> from scsi_unjam_host() which run with host set to SHOST_RECOVERY.
>>>>
>>>> Nope. One of the key points of scsi_unjam_host() is that is has to stop all I/O before proceeding. Without doing so basically all SCSI parallel HBAs will fail EH as they _require_ I/O to be stopped.
>>>>
>>>
>>> I still can not understand why we must stop all I/O. In my comprehension, stopping all I/O
>>> is because we might reset host during scsi_error_handler() and we must wait host's number of
>>> failed command equal to number of busy command then we can wake up scsi_error_handler().
>>>
>>> If move reset LUN out of scsi_error_handler(), and perform single LUN reset, we only need
>>> stop I/O of this single LUN, this would not affect other LUNs. If single LUN reset failed,
>>> we can then call in the large scale error handle.
>>>
>> I know the EH flow.
>>
>> Problem here is the way parallel SCSI operates. Remember, parallel SCSI is a _bus_, and there can be only one command at a time on the bus.
>> So if one command on the bus misfires and you have to start EH you have to stop all I/O on the bus to ensure that your EH command is the only one active on the bus.
>>
> 
> Thank you for you explanation, it's clear to me now.
> 
>> For modern HBAs we sure can device other ways and means of error recovery, but I can't really see how we would do that on legacy HBAs.
>>
> 
> How about define a new return value of scsi_host_template's eh_timed_out callback which indicate this timeout
> is totally handled by LLDs. Like following:
> 
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -359,6 +359,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
>                         set_host_byte(scmd, DID_TIME_OUT);
>                         scsi_eh_scmd_add(scmd);
>                 }
> +       } else if (rtn == EH_HANDLED_BY_DRIVERS) {
> +               return BLK_EH_DONE;
>         }
> 
> Or scsi_host_template's eh_timed_out should not do this, we can define another callback?
> In the LLDs's timeout handler callback, apply single LUN reset first flow as previous mail metioned.
> 

You probably want to add a scsi_host_template field or new callouts
because some drivers only preallocate enough resources for one TMF
at a time so we have to do it on a driver by driver basis.

For driver's setting/implementing it then to escalate you can do something
like:

1. Block the queue for just the LU with scsi_internal_device_block.
2. You can then call the new callout or old one if we just added some
new field.
3. If device/lun reset fails, then block the target. Then you can do
the host.

We could share code with scsi_ioctl_reset as well. Drivers that support
TMFs via that ioctl already expect queuecommand to be possibly in the
middle of a run and IO not yet timed out. For example, the code to
block a queue and reset the device could be used for the new EH and
SG_SCSI_RESET_DEVICE handling.



> Anyway, what we need is a way to reduce the time of setting host to SHOST_RECOVERY.
> 
>>> Here is a brief flow:
>>>
>>> abort command
>>>     ||
>>>     || failed
>>>     ||
>>>     \/
>>> stop single LUN's I/O (need to wait LUN's failed command number equal to busy command  number)
>>>     ||
>>>     || failed  (according to our statistic, 90% reset LUN would succeed)
>>>     ||
>>>     \/
>>
>> Interesting. This does not match up with my experience, where 99% of the errors were due to a command timeout.
>>
>> So which errors do you see here? What are the causes?
> 
> These error statistic are from our consumers' environment,they told me about 90% timeout triggered errors can be
> handled by reset LUN.
> 

Is this with specific drivers, transport or targets?
