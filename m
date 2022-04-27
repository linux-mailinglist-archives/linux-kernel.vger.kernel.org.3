Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4A9512775
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiD0XVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 19:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiD0XU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:20:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B19114030
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:17:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKI0DD015475;
        Wed, 27 Apr 2022 23:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=bzM6PJjhKah2phTkjxNQeC6aRvae7GMXmPgzLSdakOg=;
 b=wbv2gDAR/y7vHE5wRNf+qXg2cJj8o4ollifGM8zaeGhxdWVe32cU9daB/aniVvVfK14O
 O+AsjoLf3q5/9DaWEf8jSlWrhgDLEhPjNybA30TE2BUf6RiYGooMNVMyDBABY48qUyFl
 BkAG5VhkTU9Jje7ojFn49uON8W4SJt8vGT6Wtpht0qgiuZZwljKBbEBRnpn2sWG0Vr1X
 G4bo5zvApnnQE8VzVL8b/lk3UY4NH5cCUPAN/fBeGvZ68jA4jdkQjCkZ2lAVb12k5+S5
 18jJmfHefrOumfmM8+P/6pVONmCcYCWRgKHC2ihBl3FCqbjsNHjtIXbDTRcNMsTpjM2g Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9atf2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:17:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RNB9lv008637;
        Wed, 27 Apr 2022 23:17:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5nxsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 23:17:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHuJ/CvFiqII/6mDgnHreQXZm245i1ngdBJvWZp4l3iU8ISXLhqWrcLjAlJoORzOJnZlKIr9jTMB91KWXoMeZ8wDefXfQCnBscMH3YswJBAyjNvBZhHQpwIg4gbLCR0MSamH9IhiWVV1VQFykJAvo2M0fv13B3BCeVAVUpgi+UN68IDcWIl3Lbuk5INd6Pk8Pv5qeD3uCVx6kjdNSJv3uT0i3mFiI+f3UVyNHetE75huHj+MY12Q+4AT63or0oTHg2HPERNWsoNmd5kN+lY+Lg4VpfbxHoQlhuLIRKZts6OCUOQ/r9lz/kayXvQ31QXXXQgupC/JGwzu2fz//B6acw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzM6PJjhKah2phTkjxNQeC6aRvae7GMXmPgzLSdakOg=;
 b=g1uhGx/BeaTbSzQ77JCV+wl7VmDQeMl0Cl4o9llDYTfwrEPvPsv0nbpfeD3rPvaMmiFKJEzsI7/fXczojCLSwSuesd0z07/qSck/1Ak7+26XylNr3XdnjS66ct6RlkN2yh1MBgTHRKgM+u9/r0pvQZPWUIJgN0+B3AkqujVOMkUG04dMljlJtt1sGZEyagXUABa4DGMeNeXfJnVOu19WSJXx/LTBmUejSQohrrGQnPERu9CMFXEOJvYfhLXjAPxRBwRoQhGC9CWIJ1TOjXaJEtdTZO91Xf/RQssoJ6dtjO6xZ1CkH39XysmzsyZXbbuc5+NOxJN9WCIgvIkdvI4psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzM6PJjhKah2phTkjxNQeC6aRvae7GMXmPgzLSdakOg=;
 b=UZ+E7VVB+nzphiETabDN6lLcf4Y2aQPynWv/w9sBs1wcui6gXTrOg1TBxjJsN8SibFghJ1QVZlYrcmqeWoMNQLqXbjr7//ZQ8CCvm9rePOBKw2jXz7bEfDaQEPK5guFSDjmZTiQR2ViQfJH+XAoJ+AjalwW2apcBpIX6Hl29L/k=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MN2PR10MB3902.namprd10.prod.outlook.com (2603:10b6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 23:17:12 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::4427:92a2:50a5:50b6%8]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 23:17:12 +0000
Message-ID: <cd1da3e3-9024-2c97-3343-2569f74018be@oracle.com>
Date:   Wed, 27 Apr 2022 18:16:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20220427173124.1428050-1-longman@redhat.com>
From:   John Donnelly <John.p.donnelly@oracle.com>
In-Reply-To: <20220427173124.1428050-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::20) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50d79be4-10cf-4ee8-9cb1-08da28a40f28
X-MS-TrafficTypeDiagnostic: MN2PR10MB3902:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB3902434230A4C58725CBA79CC7FA9@MN2PR10MB3902.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pk5tDJbKE9Kc9GErdquKUcCphbxndtgUhIBpCjPaQ5Z5CNAimA6BYxD+cOZJFzSZlsNXCkb2TQLDNSma7qwtn0FNoHZC5Qh5HWo9GBUaNEV0AmAyV3Daasr4CIG9F2vXty39UDK7g6zNRqkAbEn9Pe3AUAYJ09/lWFNlJgPGgNbCGGOU72iKnMn8nmqJTL/QBoAjsxRElguqCvs+AiPcwBAthYxvRhpuSPLo/yxs8+2IJsKBWyh9PE1OVIn4zAQvXUhtSS48KOxVZTNxvX7vnDcMHg9xCCXS+Lznft1XJwchsYVeMtGP+iYfqdd055pfKmxWTOOT6LRmMDbCrZu0GS11IDWdh4zT9cKj+5dtOkHKhEmpl8ZVeBFj0ft9OEtOnJV3vEMQfbQ8WOPLCYQ7wv50hjCixGd4DYzvQXgNl4RW8pBR4vclmwxiJ628jdsV1Rd3kXDyi/Mn358KvPaTRWovyRZOMe10WJZBI0eC8II7LrstNSwwzstqYpzRr1xIm9KNTQAxsN5RLc/pubrHS91z20u1fiaEKAwwinigCJIm/kuSycvpeym0H28ImEJwk00dwksnW5IwitAJtWZfWqaZt5UTgQoKDu9sPc8heXDMuEJ/gaVUpcEx8j97+UPhqFLshkL/1V7I7J23aQFPpmZ2XVvvJylW/GjdGlxrs/+lRO7jU7s9LNFA7gwn1yeILPqJMRfvQuO6egZUfZMXTzs66v4S6ch5+MnB8KhlnLTvfTCqs0o+3CuTNuBE4AON
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(86362001)(38100700002)(83380400001)(26005)(6506007)(53546011)(508600001)(186003)(31686004)(8936002)(6486002)(5660300002)(2906002)(2616005)(4326008)(31696002)(66476007)(66556008)(8676002)(66946007)(6512007)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFBsNGhiOXlab0tXZkJnSVdEN0dnU1dieURpbkpxNlV5WEErcmh3ZzJVeFNK?=
 =?utf-8?B?eElQdldmNndnZUxaU0JnM1QvajJJR1MxcjFzSWt0bHpyRTNyMVJ5TloySmoy?=
 =?utf-8?B?aUI0Y0FQQm1jK3o4R1JldUg0OEQ3T0Y3OTVRdnp5d09BQXkwQm9xTmExdGRS?=
 =?utf-8?B?VkJkUjU2MWNsdTIvNjk0dHJ4MmhPK0tmUFYwTit5eitBUEtmS0VMcCs0OTdP?=
 =?utf-8?B?TW93ME5CNkJVSlpIRVRaNG16STQvT1hpZXNyRldTcE8wOFJQRHJQRXlzRHgz?=
 =?utf-8?B?UlF2WGYyQVN2cmJyUzdIOXFsUDZJcHluUUJ4aFRlelJjSG9zWHRnMVFQNTNp?=
 =?utf-8?B?a3hlak1PdmpnM2RmZzM2cG9xMlN6RUVSTkJSaEhPMDVtQUYvZEcramFjdmtQ?=
 =?utf-8?B?dEdzTnhxN3VrUEgwUXRnVVQ4MnhVNzlUQlJEdTI2U2w4TmN0MTNLblNwNHBi?=
 =?utf-8?B?SG95Qkp3RkJvTU5TZTZ0ZEYrQVFNdzE3VmZGamNTTHhiMzVhZnJsQXBibWZH?=
 =?utf-8?B?Ti82NzVsUGVMZzNycFhHelNVZUx6eGp6Q0lWWlZLYTVzRFFBMW1acmNUS3dK?=
 =?utf-8?B?UndWMGxLOGZaZFJvNU9uQVdFejV4TjhzaUdMRDlFQWFCSkw0N1pzZXpjS0lq?=
 =?utf-8?B?YlhVL09maUNYdmVSYVh3MXZYKzdPVEpHb2hacnpOZXMvWFhnb3BLMTZnSHdw?=
 =?utf-8?B?eElPcVl4RmNEblVNZThaN1h0RGdxQUZONU91ZUs4bEdxekhZR0UvV2pVY215?=
 =?utf-8?B?bjJpWEV6RnlIMDRNOVA3bE11akZWOGx1aGlTT1ZkTThKK3B2ejZqQzFTZ00y?=
 =?utf-8?B?S1l6SVhHK05LQlhTNEo1dUE5NjF3RjcwNXY4T004eWVDdUVqNFN2L3JYNHZu?=
 =?utf-8?B?V2s4RWg1MVdlQ0pNeHhmYlFKVFRqSGJkaFFoeFlZbmZ2L2hDRkZ3Z3htUVVl?=
 =?utf-8?B?UGcxbkdQVDlINlZqS1d4ZjVtQzBDUVhlSnIyKzJPRkM0SG9Ta2NnZ2t5cmZ3?=
 =?utf-8?B?ZTU1OGdlcWNhOWUxbC8rSVRoME8vaWFmNGdVN2RqbURLS2xoci9EdkJYcWpE?=
 =?utf-8?B?TUo3ZUxScHdkNHhPUDFuRGFxVjFuT1V1S0N5Rm9lLytqVVNFWEJuY3N6TkhY?=
 =?utf-8?B?TTFYZzYzUHk0T050WUFXdW9GKzQ2SVJFRFgzdWpLajE3SXFOcVRYWm1nbWVs?=
 =?utf-8?B?SVQ2VkJZcFJJcW8wQUoxSmNxWVoyQ0JsYjhhL2hOQldpSWthSEFmdEFrNXl2?=
 =?utf-8?B?VTd3NHZBOVNPZjJ5QWp5Vm1uME1MZDB3T01MWDNDQWRFUWxHYm4wdGlVWUMz?=
 =?utf-8?B?TFlKSmNMNGUxWWZmSW10WEJ1WVRpR0l5dzZ6QW1jcXVJLzJnS3R2NjYzUEdQ?=
 =?utf-8?B?T2ppclVpN1RRS2xhUnluREdiOUVNMkNMOVloc2NkUWxKOXl5Tm1RdStmRU96?=
 =?utf-8?B?ditlNDdnN1M2Z0lFZkVnVGJHQlVWNExscnh0dGp5WWVtM2JVT3ppSVFqZVc5?=
 =?utf-8?B?Tno1V3F1OHRsRGt5M1JzMTB3eG12Slo1T0RLRkZjaEVUY2kzMUpzZEZQRE9G?=
 =?utf-8?B?UUU2bm96d3NzclU1NzkyMlNjUFp5NTdnbzNzTnNXVWZML1NKb0lGVzFsejhi?=
 =?utf-8?B?QzVpUENxaWhLUzhRaHFvWGtEVXhxTjZoWWFkS1hZYlJ6WE4zSTB5NnFUWWky?=
 =?utf-8?B?NjZyV0NtUDZRbW9RWWxRY2lnMWdXa2ViYlJaWU1sNkIybFRUU3ArcGx5M1NS?=
 =?utf-8?B?RDZ4VU8xT2h4SkJ0SVUzQXZnYkxRa2RDSzZlcTNLNmhnYXB0SEV4dk9hc01C?=
 =?utf-8?B?OWMzcHZMUkNoTUNIaDVqR2VYa3cwQlJRbWppeHVEL1B1NWhuMXpxcUFUVGxm?=
 =?utf-8?B?bU5ac25OWWFIRFFHbjFxZ2RYRDZvVUd0aS9IbzZYbGlxME5KVVZzekVXZVV0?=
 =?utf-8?B?OWVYcGd3WlJod24yczV5OXROZER2OFBhQXVuNkxmamFxazYxSFJ1bnhFSDZF?=
 =?utf-8?B?RDJLeWRKYVZNWmJsdkordkEzT0JuUExBZWNJWi9BVVp6Um5KOGxRQTJaWG9I?=
 =?utf-8?B?Wk4yVzlHR0Y5dHFSV2FFOHJDSi9laUNpSnpxS0RESWNxV2Jmc1YxY01PWkN4?=
 =?utf-8?B?MDNXSGxTSzhYRzBacTNNbXpzY25yemhnT1NoZ2ZyYk1iM0M2bkk0VjBZMFNR?=
 =?utf-8?B?cUx4V0NJUy9KakRQWTRDOURtQmdjUnZTSitxbUcrOVl2NHVEOUYyMHFSNW1H?=
 =?utf-8?B?WTRFSEtENkdycnUrVlhJUGduOWIzU09yclBOYkQwZDNjRFFvSmpSTGxtOEFt?=
 =?utf-8?B?VTBLdHBTN29wSkpxdzRiTUZhajYxdTZvbXhRODJDcllMRUVvU0xFSmJXdU1N?=
 =?utf-8?Q?d0PegTGpSz7W3Rl0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d79be4-10cf-4ee8-9cb1-08da28a40f28
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 23:17:12.2600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emjY75qg7sROYxL5V7NWeZPUygEorJUC2FGWUS5lx5Sd8ontGO2f4Yt7T++z+u3k4Z1GdsDp6D0CmbS40doarphSkQBO2Bd2WihKcMnbbj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3902
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270136
X-Proofpoint-ORIG-GUID: z875l7Qs1kPXINmoIaUdqJhfG-1KfVqK
X-Proofpoint-GUID: z875l7Qs1kPXINmoIaUdqJhfG-1KfVqK
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 12:31 PM, Waiman Long wrote:
> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
> consistent"), the writer that sets the handoff bit can be interrupted
> out without clearing the bit if the wait queue isn't empty. This disables
> reader and writer optimistic lock spinning and stealing.
> 
> Now if a non-first writer in the queue is somehow woken up or first
> entering the waiting loop, it can't acquire the lock.  This is not
> the case before that commit as the writer that set the handoff bit
> will clear it when exiting out via the out_nolock path. This is less
> efficient as the busy rwsem stays in an unlock state for a longer time.
> 
> This patch allows a non-first writer to ignore the handoff bit if it
> is not originally set or initiated by the first waiter.
> 
> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")

Hi Waiman,

1. You likely need :

Cc: <stable@vger.kernel.org>

Since d257cc8cb8d5 has been migrated to other LTS threads (5.15.y for 
sure) .

2. I had posted this earlier:

[PATCH 5.15 1/1] Revert "locking/rwsem: Make handoff bit handling more 
consistent"

That is likely not needed now.


3. Please add :

Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>

We can likely test this, but I can't give a ETA when that will happen.


> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9d1db4a54d34..65f0262f635e 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -335,8 +335,6 @@ struct rwsem_waiter {
>   	struct task_struct *task;
>   	enum rwsem_waiter_type type;
>   	unsigned long timeout;
> -
> -	/* Writer only, not initialized in reader */
>   	bool handoff_set;
>   };
>   #define rwsem_first_waiter(sem) \
> @@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>   			 * to give up the lock), request a HANDOFF to
>   			 * force the issue.
>   			 */
> -			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
> -			    time_after(jiffies, waiter->timeout)) {
> -				adjustment -= RWSEM_FLAG_HANDOFF;
> -				lockevent_inc(rwsem_rlock_handoff);
> +			if (time_after(jiffies, waiter->timeout)) {
> +				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
> +					adjustment -= RWSEM_FLAG_HANDOFF;
> +					lockevent_inc(rwsem_rlock_handoff);
> +				}
> +				waiter->handoff_set = true;
>   			}
>   
>   			atomic_long_add(-adjustment, &sem->count);
> @@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   					struct rwsem_waiter *waiter)
>   {
> -	bool first = rwsem_first_waiter(sem) == waiter;
> +	struct rwsem_waiter *first = rwsem_first_waiter(sem);
>   	long count, new;
>   
>   	lockdep_assert_held(&sem->wait_lock);
> @@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>   
>   		if (has_handoff) {
> -			if (!first)
> +			/*
> +			 * Honor handoff bit and yield only when the first
> +			 * waiter is the one that set it. Otherwisee, we
> +			 * still try to acquire the rwsem.
> +			 */
> +			if (first->handoff_set && (waiter != first))
>   				return false;
>   
> -			/* First waiter inherits a previously set handoff bit */
> -			waiter->handoff_set = true;
> +			/*
> +			 * First waiter can inherit a previously set handoff
> +			 * bit and spin on rwsem if lock acquisition fails.
> +			 */
> +			if (waiter == first)
> +				waiter->handoff_set = true;
>   		}
>   
>   		new = count;
> @@ -1027,6 +1036,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>   	waiter.task = current;
>   	waiter.type = RWSEM_WAITING_FOR_READ;
>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
> +	waiter.handoff_set = false;
>   
>   	raw_spin_lock_irq(&sem->wait_lock);
>   	if (list_empty(&sem->wait_list)) {

