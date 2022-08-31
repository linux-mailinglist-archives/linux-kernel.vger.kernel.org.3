Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67765A88F0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiHaWVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiHaWVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:21:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5953C9E102;
        Wed, 31 Aug 2022 15:21:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27VL3BAo026541;
        Wed, 31 Aug 2022 22:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=I9NXolNX9h9NY2hQxxktiuzx6spLmVozYssEapm1Vt4=;
 b=Lu/fwiDUo7Y/x61Czz20+tbxJMsA6m+kGsrR9Lz45WcDUeS6PsNE+81BpU7KbTxo+Ynn
 L67pas1XEW5YlvXEEQmnBbm6Xj0qggnUmAbhbetrdBSOv7CPYgU2Rr8AN95H1TjenVAa
 YULrzFWMB1v+f5V8oUVZKYrnaOU52zDyUhDlyJ8U3gCVQDtXniVM1KYdWMPrXsivkJIt
 Y22si7ecLsyiWbSC5wneDpaUwL+0l7qAckgmkiBNKsgPMItenVx7ylNRVvu9N5K6eSAe
 DTWxh6dXzgYN3d+Jj1e6sXlHZGH3p9ghY6xu70B7TqO2N2BeVBfj7SMoPyMBA+jrPPOy 1w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7bttagmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 22:20:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27VJsh9m033710;
        Wed, 31 Aug 2022 22:20:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ja6gqt9jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Aug 2022 22:20:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1EnZ0fHSf45lhqSu6Ki6gPOM6AmrlBljt34et5NPRPaDzSDaJ9KcWaiF+LM/MSRAuQ1j9X5oZI4ozKfWSadnkV5eUg0XtJh6q5p6gfQY5fCCZ01ZVkY61TGTdtZr7Gx739/EOQf8GUO6t2G5FGWNuUPG/L0W2hEpfvyrVmC+IZSh2hL8bqzX5I3zPDNqO3xX2AoiQZ0xx3rH0/N+f4iohusrO7ey8+IJVAFBT40SGYdadcYo78iyEhNCZfxwLNpRSG35t3myf+bwb+HtOh/GMs3MVO1ZhzXgVNSPe/1KSVs7MbjeuqQQPXohaa6QkgY/tulFQ08nq6hF4k6mTtitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9NXolNX9h9NY2hQxxktiuzx6spLmVozYssEapm1Vt4=;
 b=Dkh1OmYdsQyjmfmmXdvZoAig/qiz3qM5k9Ih3Z1J+FMQWHlDC2e1Kj81xLV4SC/9I6ToMdXbVnRJUTVciG9FXlU1YkAYnc7SNzlkfbFI84EnD0LDQ7DiqhhB95O1HGAy3Vd+KKqcDxXbc3KTc1eRuYm1VuJ8KBrszhg2qJe+Y32cefrHeoA1XVz/Z7HrYg9+HzyTNr9ydanbcLA5lvD8w7sMbWALmac/9sHD4xg5dfGbE+hxBXeYpFdsgTuLuKQCPVQGXY5EaTY/Ylse5g2G0yc+7Yc3t5fA86+teUSEkXfe3cS70yWqROUyQ27ALRu+ggD299BICtmxT/v3l7mUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9NXolNX9h9NY2hQxxktiuzx6spLmVozYssEapm1Vt4=;
 b=CURxNlBd5qOpPfJEDC/WuV1LF8k7MhBYsogMATADU6dgqB0lgNUeZ8WNWQjSJjSLFHaOFL6vModT35SeBPTrXjjNmvv7zND80V8mLkvFqUWXEwh+ZZNiknLZlPRt8etou7dV8B/gFUtS+2u90lOp4SVyk+evVL6zYWnu3jQ20/o=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by PH0PR10MB4488.namprd10.prod.outlook.com (2603:10b6:510:35::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Wed, 31 Aug
 2022 22:20:42 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 22:20:41 +0000
Subject: Re: [PATCH v2] Revert "swiotlb: panic if nslabs is too small"
To:     Yu Zhao <yuzhao@google.com>, Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     iommu@lists.linux.dev, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220829232934.3277747-1-yuzhao@google.com>
 <20220831063818.3902572-1-yuzhao@google.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <747f76e1-a5ec-150c-311e-a60396f6f7ab@oracle.com>
Date:   Wed, 31 Aug 2022 15:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20220831063818.3902572-1-yuzhao@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:806:6e::7) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1607f37-9dd0-4ad2-39fd-08da8b9f0a47
X-MS-TrafficTypeDiagnostic: PH0PR10MB4488:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IDrOcJMJt7u9pysJ34Z4UqlU8RWkvM6/VsSrZg7GTZ+XJlqoAPlrYHH6ti+bIrVz8aIGm8RVlhcnYMnyB8uuiyf4ZaLxLxBEZuD/Me+LQempsrX4/mt5iA7JhyPvohcKfXtfD/uZTpdWa9pDxC/X98woIYgWhQNgtmPpHU6zU2Qx9tsjSItPxPuCRPEvU+LxMD3GvPJ+bqQnHulVnkqWm8eSGlDOd51KWfUdxvY+YAol3ceqLckcFCWHmHIljmCsGJtohXKvvYQt32OG/JZB23qKngte7NLUIHrM2Zq9w/UJblFsZobhRZXBGALz+gUHJfg6MW54WWOBT9Cstwk64qN5OyVkkB0u3gTzqDy7nNIaJzCCqgsEpxiRLD0GXvHDb+1lVWP1MM8egcQPV2N2dnzXTsM1pHJ2Fv/oy9VjpEpXBPBiPCHaAYd7p0AMi2ObJ1ckArk2B/6Ef8ZFWQJMtGjpCrRmdkvmUMR1Y2uvE4qG3keeVCoGLvWVPSgLIetCE+SR1sulazw6SFxGk5QCLH31/5p1Q2YH59fsAGY+1AfYTS/JEzos9gR8gK2EXfAJ4oCRht7/Iicdj503b+8ssZAXXEYeFMUMYEAxkTgovkCUyMejHZsLSLsXnFzcUF597BQ9R+jnBfzeukmJv0i+gMJtE+lPFUKz1HyQee4yrVF9qb0bvi/fikpKgvOWrBIEIhrsPvbxVMqjOiNR5am2iEOLvE/clLKV4kYTHOWhctyIMCdxhAJT9OKDOiDOyECM6nxiJh8M+CyacDYdDvSW1zSFztcW6Kb2dG5QfGfW0b+PPUcGoQcXhLlV6ZNCG6vGWQgXJR7YEtSpReJL05e7zObfTf9HwTswVIi3yp67J6XBVlZA6FTuHHU39slxSJ+wkd9+KWP/o4McJtkOWH3TBdSEWZW5EkjFEOPJZlZZSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(366004)(136003)(396003)(66556008)(31686004)(66476007)(8676002)(4326008)(66946007)(36756003)(38100700002)(86362001)(31696002)(107886003)(2906002)(53546011)(5660300002)(478600001)(6666004)(83380400001)(2616005)(186003)(6512007)(44832011)(41300700001)(966005)(54906003)(316002)(110136005)(6506007)(6486002)(8936002)(160913001)(15963001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVlVd01Wd1N3NjFFOVFoL0J5TC9vaGx4MlVYNi9hMHVJWVQxeFExY3c0ZzA4?=
 =?utf-8?B?MnB2dkxWZmxxaVF1TlRZb3BHRUduQ0NYTUVnL25HdXpBa2xxOXBBNE96b2xB?=
 =?utf-8?B?dnhORG5uSzh1czV3SG1ndkNCeFVWaWV6QjE0S0ZZSVFtdDRqOHQ4a1dUWDE3?=
 =?utf-8?B?b3NZYmtQNWl4SXhuMk1hSHlnY0ZmNWxXdkxXNE1oQThjNnQ0TjJzS29PRVFS?=
 =?utf-8?B?bzhCUnZnTG91dmVNRnBlbi91M2ludUhtV1hPNzNrN0xwZmpMZmRvOXlrSjFN?=
 =?utf-8?B?RjNCdEdYeWZOK1ZFZ1JxbzFJZE9ZdEdacmMrVkwzc3dOSWxySWlwYVUvWktJ?=
 =?utf-8?B?NnRnbG9BRlVENmJuVWlOMTVMNFZValpabzFHTjBCT1JWNHJBdk1ubkYvaUFS?=
 =?utf-8?B?RjFnanJWRTBvNmhUcHpoMWxZd05FWFVZeWN4OWpjT3ZjMEhuZXRJN2s2czFw?=
 =?utf-8?B?NzhuRkc1TTV0RTUrY05vd1ZvL3hFcWZ1aUdPUHZtWmFoTUF2SDhWeUJKM2x0?=
 =?utf-8?B?R3p1Vkh0KzY1MkdVZlVPUTh2WHQvZGNRTno1ZzFpcVoyRnQ5WStKekhqSXNv?=
 =?utf-8?B?Qko2R0hxVTZJbmtPb290ZlplZ3NUS3dFSzVKTE1ZR0NSUGRvTkwvWXVVUC84?=
 =?utf-8?B?VzcrVFpLOWdMekVMS3BWZWRZdVgxMERWdW1Qc1Z2K29HL1Q2dFd0WXp5Y25D?=
 =?utf-8?B?Q1FEbXplMlI2L1lORXBZZFBPcTZBakF0WVVEclZTZjJvMEIzWnMxL2NQWGRN?=
 =?utf-8?B?N2FKejhCMTZCOEFLWmhyQVRLa1NGWWpveVdjZTBRUGFDQis1THBMOWZ5V3Rx?=
 =?utf-8?B?cEVUOGlmNk4rK3NLM1R0S2c5Vnp3emVMVTVyd0kwUjlDN1BoVWVQeWYwVDdG?=
 =?utf-8?B?Y1pVUHprS1lCeHgva2hVVGdmNktxOU93cGlZYVFrNTBTL24ybDltVmJYTTJL?=
 =?utf-8?B?Y2Z4UldsdzVoTGZnUEcyczY5VVlnUXl6VitVQnd1cWFGTmlIS28yblJaZzJi?=
 =?utf-8?B?NEtPY0hmQU5zZTQ0Tzd0VXhvSUVYeXVUc3I3UGRDMzIyTko0S2JlMzdUN0JR?=
 =?utf-8?B?bGdsZzE0a0pMa3l0V0NHS2dXTlBjL1JoNnVKV0UyZmFJaWZ3Y2pKNFNDcnlI?=
 =?utf-8?B?L0NxUVRXN0JCWERXYS9US2dtUDJobXczV2J5bDc2SWdLZ2w2L0VZQkhvTjFK?=
 =?utf-8?B?Y3h2WEhmVVQrWXB0Rks3UnM5M2JLR1M3TWFqSmhic3NUeDN6R2c2T2lNMGRy?=
 =?utf-8?B?N2VGclZmUHMzY0hqS1FUcnRTNUNoTlZqWENzUU1QWlA5UmhSUXJDb0xteFlh?=
 =?utf-8?B?dCtEOW8yWnFlYWNQeUlCTDM5TWlpMGdjcGh4VktleXZCYlNucGtHTGhpMmNw?=
 =?utf-8?B?TDlZSEpTNzNtb1BJd3FMTUthODhYbkpnZnhQMEJjUndtMWxka0NhaHUrcVRm?=
 =?utf-8?B?ZGVzTlZpZ2ZTYTNSQUtucnd3bENHazkzTTQrSTFjUjZMZzlIelhoYWdIbmF1?=
 =?utf-8?B?dEhWTzFlclYrVnVWSWpiamlNQ05DQ2E1elo5NXlWdE1WKzdDSkdYZDlPZzY4?=
 =?utf-8?B?MnJRcFBpc0xRRU0rTlNVWVpMNXZxMktvVkc3WElvUG95TTQ2a1pmbzBIaWtU?=
 =?utf-8?B?TjNSS2E5TTNncEhGZ3hrRlJVNVZxSkZlRWR1ZzllSWJMRG5zSThqVndYTjhG?=
 =?utf-8?B?cXBGa25wbUt0YUdmUEJCajc5QS9xbFZIRlowclk0TnhKamxXQTQ5L1dsZkVH?=
 =?utf-8?B?UVZBSlU4N3EyTnp4MzdkZzR3RzlTeUFUR21xODhlL1ZHM0RheCs3TVUzZEZ0?=
 =?utf-8?B?WlYybm9zVmEzN1ZVSy9xSHdrWFFYV0g3amMzKzV2Nm9mb3p4cGlJQWovSExR?=
 =?utf-8?B?SjNJajF2ZWRkSHEwMFRBeXh1QzBWa3NYVzg2MmM3TzNjZFl5eXV1a2V6b0ZN?=
 =?utf-8?B?c00va3lQK2RzaUhhYlFVakVxQWxDd2VBOWs3MUMwS2ZwbTQxSXF4c2x5L0M5?=
 =?utf-8?B?c2lkVEdScjZqTHU5MXhWMUNSelBTci91Y0RzUUlRbHI4cnovYVV6ZFlOTDd6?=
 =?utf-8?B?Vm1ieFdQK1ExeWdkaWJ6U1ZkSG82anAzSXFTNmNlZlM2dDhHcnNROGdBWG9C?=
 =?utf-8?B?YVk0ZGJZK2MySHZWei9iSjU1RDRqTXhnVjlyVkFOVUdscVA1L1ZXWkIwQm9N?=
 =?utf-8?Q?eWfDBLmOIVgqc4Qz0mEhzxs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1607f37-9dd0-4ad2-39fd-08da8b9f0a47
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 22:20:41.7503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqWwvVs10v6U5qQrepERso0VCkv8gndFBrSfSwDZJv1IqEaWuldGhYUdJ6v+qCNOE5INDrtbaZYJ0honrPZ4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_14,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310109
X-Proofpoint-ORIG-GUID: L_KnwqI66TqP1AXyXeUWtojrTw1yMtcW
X-Proofpoint-GUID: L_KnwqI66TqP1AXyXeUWtojrTw1yMtcW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

As we discussed in the past, the swiotlb panic on purpose because the
mips/cavium-octeon/dma-octeon.c requests to allocate only PAGE_SIZE swiotlb
buffer. This is smaller than IO_TLB_MIN_SLABS.

The below comments mentioned that IO_TLB_MIN_SLABS is the "Minimum IO TLB size
to bother booting with".

56 /*
57  * Minimum IO TLB size to bother booting with.  Systems with mainly
58  * 64bit capable cards will only lightly use the swiotlb.  If we can't
59  * allocate a contiguous 1MB, we're probably in trouble anyway.
60  */
61 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)


The arm may create swiotlb conditionally. That is, the swiotlb is not
initialized if (1) CONFIG_ARM_LPAE is not set (line 273), or (2) max_pfn <=
arm_dma_pfn_limit (line 274).

arch/arm/mm/init.c

271 void __init mem_init(void)
272 {
273 #ifdef CONFIG_ARM_LPAE
274         swiotlb_init(max_pfn > arm_dma_pfn_limit, SWIOTLB_VERBOSE);
275 #endif
276
277         set_max_mapnr(pfn_to_page(max_pfn) - mem_map);


On x86, the swiotlb is not initialized if the memory is small (> MAX_DMA32_PFN,
at line 47), or the secure memory is not required.

44 static void __init pci_swiotlb_detect(void)
45 {
46         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
47         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
48                 x86_swiotlb_enable = true;
49
50         /*
51          * Set swiotlb to 1 so that bounce buffers are allocated and used for
52          * devices that can't support DMA to encrypted memory.
53          */
54         if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
55                 x86_swiotlb_enable = true;
56
57         /*
58          * Guest with guest memory encryption currently perform all DMA through
59          * bounce buffers as the hypervisor can't access arbitrary VM memory
60          * that is not explicitly shared with it.
61          */
62         if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
63                 x86_swiotlb_enable = true;
64                 x86_swiotlb_flags |= SWIOTLB_FORCE;
65         }
66 }


Regardless whether the current patch will be reverted, unless there is specific
reason (e.g., those PAGE_SIZE will be used), I do not think it is a good idea to
allocate <IO_TLB_MIN_SLABS swiotlb buffer. I will wait for the suggestion from
the swiotlb maintainer.

Since I do not have a mips environment, I am not able to test if the below makes
any trouble in your situation at arch/mips/cavium-octeon/dma-octeon.c.

@@ -234,6 +234,8 @@ void __init plat_swiotlb_setup(void)
                swiotlbsize = 64 * (1<<20);
 #endif

-       swiotlb_adjust_size(swiotlbsize);
-       swiotlb_init(true, SWIOTLB_VERBOSE);
+       if (swiotlbsize != PAGE_SIZE) {
+               swiotlb_adjust_size(swiotlbsize);
+               swiotlb_init(true, SWIOTLB_VERBOSE);
+       }
 }


Thank you very much!

Dongli Zhang

On 8/30/22 11:38 PM, Yu Zhao wrote:
> This reverts commit 0bf28fc40d89b1a3e00d1b79473bad4e9ca20ad1.
> 
> Reasons:
>   1. new panic()s shouldn't be added [1].
>   2. It does no "cleanup" but breaks MIPS [2].
> 
> v2: properly solved the conflict [3] with
> commit 20347fca71a38 ("swiotlb: split up the global swiotlb lock")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/r/CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld*pnerc4J2Ag990WwAA@mail.gmail.com/__;Kw!!ACWV5N9M2RV99hQ!PPVATbHVDT6TZ4sqoj5G6vfAJGPAEz-Lmp9njTsM2PPYPQqCP6aq5RF8FDmrXDlSzxJmTUUSgOW3yjKDtg$  
> [2] https://urldefense.com/v3/__https://lore.kernel.org/r/20220820012031.1285979-1-yuzhao@google.com/__;!!ACWV5N9M2RV99hQ!PPVATbHVDT6TZ4sqoj5G6vfAJGPAEz-Lmp9njTsM2PPYPQqCP6aq5RF8FDmrXDlSzxJmTUUSgOXQRsYjKQ$  
> [3] https://urldefense.com/v3/__https://lore.kernel.org/r/202208310701.LKr1WDCh-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!PPVATbHVDT6TZ4sqoj5G6vfAJGPAEz-Lmp9njTsM2PPYPQqCP6aq5RF8FDmrXDlSzxJmTUUSgOW_tjcVMA$  
> 
> Fixes: 0bf28fc40d89b ("swiotlb: panic if nslabs is too small")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  kernel/dma/swiotlb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c5a9190b218f..dd8863987e0c 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -326,9 +326,6 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  		swiotlb_adjust_nareas(num_possible_cpus());
>  
>  	nslabs = default_nslabs;
> -	if (nslabs < IO_TLB_MIN_SLABS)
> -		panic("%s: nslabs = %lu too small\n", __func__, nslabs);
> -
>  	/*
>  	 * By default allocate the bounce buffer memory from low memory, but
>  	 * allow to pick a location everywhere for hypervisors with guest
> @@ -341,8 +338,7 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
>  	else
>  		tlb = memblock_alloc_low(bytes, PAGE_SIZE);
>  	if (!tlb) {
> -		pr_warn("%s: Failed to allocate %zu bytes tlb structure\n",
> -			__func__, bytes);
> +		pr_warn("%s: failed to allocate tlb structure\n", __func__);
>  		return;
>  	}
>  
> 
> base-commit: dcf8e5633e2e69ad60b730ab5905608b756a032f
> 
