Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37F59AAC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiHTCut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiHTCuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:50:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52950B6D2D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:50:45 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K1iQlF014104;
        Sat, 20 Aug 2022 02:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=F8IQ9tO9RJsoFo1GEMjaenpYt6hgoUO3BAOvg/Q9mQQ=;
 b=jIUu8e6UhDaA6fLcjLU6z8Pb41BaaWgSeBvo5D8X5+Wxy3UcQKpDYoa82xn9BUmvxnxW
 6Mzk47nxu9oyPD6JhCkBKoGUi8WV3SZC8yW2uy1SRDBH7LHluPZoFoNfsp1cbm5/fN3K
 g/fNQpDvJsVPhS5/5r29EvEZxOnQFCoWUlZ+V6tVSL7z4m1HsM7jqMiCHO9BzKd6XxT/
 ShFK3yoZ1qLnBjYZg4ZICbmypGm8n9SKZr0o+IM7333Ke3de9ah+OJzYM0iEorAYQRr1
 WzRxEr5TgwDjgENEwya1hqc9NK/kK6on4efdu2EJPyFAU4MAOIqatNstlewQ9YC0Axrg Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2p70r177-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 02:50:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27K1XluI040888;
        Sat, 20 Aug 2022 02:50:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j2p26ru2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 02:50:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsN9wHby3qhB0851qIq0BsdOuBdpzVsUEg6TIneWJYaoxh5rPTG5hxoHKE4nuNGZXlal7nQXtS+rasbUSEyJW2g6pp1NUT7+Hm4vg03leoN9dPlFM7V3xAv9oxdo2vFHBTdh01ShHUnkrmzpePiXsKFMX3Wz8H4Qzewyq+7DocOl3j8/i1RjYxpCjBW7IK/0ntrce6MpINoMLilFvoAN6F5s52JKKn9F397Tc9c/cvOXKs765RJzOuKXIDJoDjTRqYOzOp2K4wOO+39Qih9Mnrhl0082yprraTnqYRYzlX717uml6o25iCfkmVy5JosdTA6ZSGUCj6VhDYMHxJmAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8IQ9tO9RJsoFo1GEMjaenpYt6hgoUO3BAOvg/Q9mQQ=;
 b=WK5teycJKQFhkWtNnFkD5WImZ2nUfqBt00VWAw7O12XBbbtBGJK25AQtDFq9RqtT2AJsp3EyKUtDZ0MdkgkGNDup0rjeazy+affAvdcrxoHsPx6QX1Sskrv1Vk9Pf529DcSZprjasr6OtZBImk5hbWtC0DoA/pprlKMyfztS9RBOcaCDevAW2NnaLR4LrAGNJOpVNGGdRWeY06SGGUo6oSk/GRslzkStxRIv+OvUyoMYBHOck7syIeX/iqy1t121ZK7p3YqkPbys0VfKvKY9uqPx6WGBoYtbq5lGUOIrmUJnbLXNT5gRoHnIggF+ckc8ZlUrciTShKOcBstceVPKpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8IQ9tO9RJsoFo1GEMjaenpYt6hgoUO3BAOvg/Q9mQQ=;
 b=pV34vKxhD4reMqsfhNDkhmT95qjuQUCsfkkXVpppCRELzryeTqQcwog34L1+GIfsRhGzmuyWeJMXR4Tj29bzyQNAqQ157tKbWCW6H5iCVZ0jD5DKuBf1nSARE7bpc4DgeUtZxLDtq67kLB9jhCklfblp4s+TFbviAB1ez1C0VQ0=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Sat, 20 Aug
 2022 02:50:13 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::95ab:eb8e:a0a7:3f0d%5]) with mapi id 15.20.5546.016; Sat, 20 Aug 2022
 02:50:13 +0000
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
To:     Chao Gao <chao.gao@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
        jxgao@google.com, konrad.wilk@oracle.com
References: <20220819084537.52374-1-chao.gao@intel.com>
 <38c58aa0-11c7-f553-95fd-292fd4944a75@oracle.com> <YwA8DttmM7wgYuHv@gao-cwp>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <c64a4414-f04a-fc75-0f54-ee8026ae63c4@oracle.com>
Date:   Fri, 19 Aug 2022 19:50:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <YwA8DttmM7wgYuHv@gao-cwp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:a03:100::42) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 552d1158-2108-4212-80b2-08da8256b44b
X-MS-TrafficTypeDiagnostic: DS7PR10MB5070:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHiI2orap+gHC91rwl3jGHOT2S3bpbbvxS1iQetzahPQ8KScoO8mJIlIIDEAmeBp+wGKvwisrHF2Hv85kIc5XvQnaUXBDDRZe7pAmlPZZOBW3h0bpakadgfg86M0Oq7Dg3+Dlq1Mz3o7pjNs0DoPvAVFEKMQJvMe98jZugQxEEo0h5OFxX3exOpBqJJlWBE291tU4PzJJGbKjU4Tbk3rmzKzkL/T82PE/ZcN767lCAjfvPK1y9h9o4Nz4P9fCpa204XVm37nzzq6GCDDEBFJ1pPXMbTvd5OerxuEihYsWiiVF5aP3wlySyZCN9sVptN3mXKdKfIU+dVqCbSpzJVCGZ2SpybVZ1nnfPLK2evwlQVdznF60EtkcTTgvJE8Wy0h+TCuu/0uvlDnLDfUnIauLDknwlu422Dw2DkKWNmv5dyqpfdekKlIBpBDfZU6r3xD/Q2gkzmkQfm/84+tGh2DSLSf2WYpLrkQXIrvRKjCH5jbCWZLKH8+E5RpZwC81l8Ajo/lSeSwzO6rW9QtBRU/O006DgSe7vIAitgf5ty9pgjqYQgbaCKvd9G7pXyBTe0dCJrdkSs4+UNgWOa0TJyOfAWA8RSl+dpOHlcxpKsv937KoE861fXkhgDwM1ssqJTwRLdacpEz0P3Qcd+C5K6rpGyd5oWGa+TGLN6kHt9FKclAwxS/7fHue+ZCMghS/0s48jf4QiMMXbqZDb33XsNz8LQT+OBmcvVejUBe/cvigbGkg8TqTJkEHJQnJSkC8noQyJ05c7UTkfRqy2PY+84fkkOpu/EQt7WK5dKMvDCJyTQs7CTSLErtrN14vM3uCzo/OQwK4f1UHoeyrf8C8URUKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(366004)(396003)(346002)(39860400002)(966005)(41300700001)(107886003)(2906002)(6486002)(478600001)(316002)(31696002)(36756003)(86362001)(31686004)(6916009)(83380400001)(53546011)(38100700002)(2616005)(186003)(6512007)(6506007)(8936002)(44832011)(66556008)(66476007)(8676002)(5660300002)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk1iS2ltbnFOd1N5OXBmSHlJd1Q1c3I1MjM1Z2NOMUFpVmpkWFJJWkVMN0xD?=
 =?utf-8?B?Sko1Q0RBS21kVThqTEIwSm00TVRJNHQ0RVFNbEZDY0FGdUVkTTUvQzJOVFZO?=
 =?utf-8?B?Y1JVZTg5d2F3WkU1ZGZjR21NR1I0Qmh2YktBV1RwSkRmenNqQjlGdjlzc0ZC?=
 =?utf-8?B?aGt0Rjh4YTVTelBOWHNncW4wYTVSMUFKTVZtVHFBMWlqMXJzTFpwWkQ2a00r?=
 =?utf-8?B?Q3JxSmRFb1h1a200YldWR2tXYm5vRDhSZXNKdVNuYm0xMEFTSHgrNGkrcE1V?=
 =?utf-8?B?bGJZS2xsNzkvNGo0V0JvK3hpSnJtRHJUS3k1WWNVb3lrNFVvS2U3WDcxMWRQ?=
 =?utf-8?B?NlU0VTZXZGZuWENudzlhVlplNFlKczNZYTBGbU9Lb1NLalVCaUJod2xPUGo4?=
 =?utf-8?B?KzhUKzNhRVNrVVkwN2lERVRhK2NSS0hUMHNtV3N5a2NnRzJJWEs4S2gwOHFq?=
 =?utf-8?B?M3F6c2FzM084M3VSWTBaSFprSml4QUpMa3FsQ1AyVjRUOS8weFVXSGJHMTN2?=
 =?utf-8?B?L1hha0djNHk1QXZPYVpMS1NhMGpYc1NRVXBHNFM0dDQwSFdoWkRpb0NiOGMz?=
 =?utf-8?B?bm9PRUpFc05BaDU2bzFnRWhRa0VKaUpuamVCSDlRazh0azJ6ZkNGdzM5S2U1?=
 =?utf-8?B?OHRvT3ZURGNkRnNnZ09MY013bjlIVkhQekhHOHkwbHhTM0JWS3d1d1poandI?=
 =?utf-8?B?UHgrSHFRN1R4cnA0QkFkbm9RSkhKbFZuNWkxZW9NUHlDby9NQzQ5b3FreVRR?=
 =?utf-8?B?MXJvK2JaNGtZZHk2ZHg5cWFPZ3M1NVJKL0VuVWEvTzZqeUpyakR2aTFNOHEz?=
 =?utf-8?B?Qi8yZWFZYW0zYlUzTy96M1l6ZEl3MnBUQWZpYVdBeWZueklXVGhYWlhsUUh5?=
 =?utf-8?B?SHVlVzdkMXJiMXdJRkdtbGRXN2tNYlJzazRJdElvM09sSTQ5b0Vnam1wck5u?=
 =?utf-8?B?UUYwRzViOGYxZ0dSVWZCaG1SUVV0VTM2TlZsWTdldVVVYmFTRFZXc2lETkNh?=
 =?utf-8?B?T1FwdEZYS2N2SmtZdGY4YmZic05iazdFbjRLV21OdzNLQXNRd0VkdVA3ekRX?=
 =?utf-8?B?K3VpeURMUWlSd0taR3ZSTU5RWEZMY0RsMys2TnB4QURUeU9KMmRtUXVKUStq?=
 =?utf-8?B?bXhMY1NmUWE1OFJHOWtuR2dZUnBQN0p3VG53aFYzWDJtdUllNi9ob3kxU0Rx?=
 =?utf-8?B?eGVJT1V0SHRjb1lGUlViT3dvWDJnNkN1b3RwVFpwYzl0RXBkSk1KSFpCWklN?=
 =?utf-8?B?cXVCSU93dkk5Y3FJYy9MaS8yVnRVWU50QXpPWDBYMC9vREVyejkyNG5aaURa?=
 =?utf-8?B?bk5HNDg0U0xnUVBVMmpTL1FLN0gwNHpKWFFLazJDTTZlT1oycVpWem96MFdw?=
 =?utf-8?B?TUFXWWNFc29iamZ4cWFFMWdOb0RBcmMrbzBORTRPb1dpeVZTZmVZeHU2Lzcv?=
 =?utf-8?B?L0tZU1hnUXp1dFZad1BWWFpEZDdtZ0RuZWRQaXljNHhVL3lhdE51bjE4UVVX?=
 =?utf-8?B?Z3M2VkEzaERENVRCU3pHU1BVdzRZNkpMcjVleGs0Y3lDZGg3RlJmNEp3ajhy?=
 =?utf-8?B?Y1lJYlhrNVMrRElzMmxXOE9SM2hyZVp6dlVvY1hpVDRDTjRkSWxiU1pkQ2wv?=
 =?utf-8?B?bTdCNzNFMFRSbmtDbTdkbDNlSitWYkEwekNpeGZjOEtsMWltcUgvdEpPODJJ?=
 =?utf-8?B?bER2VmRZV1kySVU1RjNjQXVYTmh3K1ZJVTg3Rk92cTFtblJ0cHVLamhoa0VG?=
 =?utf-8?B?TlV0TEZJV0pudUVQbDRCc2g3OG5jZkwreEFjMUprSWV3dGx6SThQOHZLMDIz?=
 =?utf-8?B?V0lmTUc5ZnRQNWhMWENKdHpCSWgrM0Y4UmlYWXJwWXRtM1hSZkRRcmNRa0J6?=
 =?utf-8?B?UVRzdVZKbWhLOG8yZVBHblM5MDVFeFpaMDlZYmZjbFE3dWVWZ1RQRjZUa1hi?=
 =?utf-8?B?aEZaVTh3bXdGRGM3cXpJOUdnZElHNkwzTUM5TUp3aG5ESzZtRm4xcUpvQ0hB?=
 =?utf-8?B?d29LMUlldklDcitPNm5ydDYzTTZ3OW5HaXUwVWx3QjBIMWNJV0pISCs2WEp6?=
 =?utf-8?B?ZmpBTkVROE9EZVpDUWRmYUtrT05oRnBEYW43SkFmT2pNQlc4Y1NxTUZTQXh6?=
 =?utf-8?B?NW51ZEFucDFlYmJ3aGdLRXdSWWNEZnJOdU1ST3NWNlpacXN2bnBNOTY2RG91?=
 =?utf-8?Q?0uth7Ak3pyAXoYth8dqNHB4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552d1158-2108-4212-80b2-08da8256b44b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 02:50:13.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MoPQfwNKjI3/5aIysH1QGorJnT+CawpDXuFrfk+CxZvQ1Sc8z9xx6j7yVak1n3KPRR6okqmVKzVAp0I/z1zOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_01,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200010
X-Proofpoint-GUID: Y-xToUT-12G-S3fmHrzTZioMAD1sZy84
X-Proofpoint-ORIG-GUID: Y-xToUT-12G-S3fmHrzTZioMAD1sZy84
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/19/22 6:42 PM, Chao Gao wrote:
> On Fri, Aug 19, 2022 at 06:44:05AM -0700, Dongli Zhang wrote:
>> I also encountered this when sending out another version of the 64-bit swiotlb.
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20220609005553.30954-8-dongli.zhang@oracle.com/__;!!ACWV5N9M2RV99hQ!O-2m8d_6yG-OJx1eoiF-wmpJy13HaSz884huJjbeRA9tUdXnUbWsD34MAoY21pSYMdS8tKOM0_7teFvOa3w$  
>>
>> Unfortunately, I could not find an environment (e.g., powerpc) to allocate more
>> than 4G until swiotlb supports 64-bit.
>>
>> Although xen supports 64-bit, but the hypervisor side limits the max to < 4G.
> 
> Sorry. I didn't notice your series before. I agree that the overflow
> isn't an issue if swiotlb size cannot be larger than 4GB. That's why
> I said the overflow is a potential issue.
> 
> In an internal effort to measure the impact of swiotlb size to IO
> performance of confidential VM (e.g., TDX VM), we simply added
> SWIOTLB_ANY to the default io_tlb_mem to lift the restriction on swiotlb
> size. Then we hit this issue and worked out this fix. I posted this
> fix because I think the fix by itself is helpful because it removes the
> implicit dependency of the left-shift in slot_addr() on swiotlb size and
> then someone trying to lift the size limitation won't hit the same issue.
> 

Thank you very much for the explanation! I was just curious how to test this
without code modification or powerpc hardware.

Although my RB may not count much:

Reviewed-by: Dongli Zhang <dongli.zhang@oracle.com>

Dongli Zhang
