Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6797C57E14E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 14:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiGVMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 08:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiGVMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 08:10:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3BBE11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 05:10:11 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26MBs9Gi023861;
        Fri, 22 Jul 2022 12:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=KnMEy3PKFm8NovkeoElwPbJV89DYbcqYEpgReJW0NzU=;
 b=U/ryXYXqU/fkpFQ9yH5WJJrj0fU/PC6WrMAW6mzcL1UzbR6xjEHkLOioqx2e39/2y93v
 w3gfnjHr1v0W+X1A2tMkKz20nyoLcK9nYo89xmE0W+1c5fXpxMMqYOWpxk6Hworsa6Kl
 4T3OLtP0jBBJx0Yo1nnR4oIPuJCEhyUUNFJdC1z6ljs4VWEKE4J2JyeTykIxqzZU66tc
 hRx13ki3hwO7W0QSTXLtoEHwI4duUdoz2BI4NspcWuc1zrCnp8RKelR4PEPfiqY81Crl
 PWLfu1ko/KA+L0JYFu5X1KI1okB0vI1mYQzeNwJpYjkyZ52uqNhLAocGTM/HAgcd9acH WQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxsf7cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 12:09:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26M9k3ku022152;
        Fri, 22 Jul 2022 12:09:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hv07e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jul 2022 12:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2xEIkv6OJolnDXpmdguaL35J0WREQgHWojviXifpqnzzU8QEDNN58cAmGlDyJETiMKECncpA8rUXsGy9r8l8w4o1oUxQmL90adaeXyqXJHnPkyg01KS1uE9Wuw+SP8GiTqz1uJfMkGCjvQfT1Gs1aEnZdr43BYQNpG9j4JSB7hGQckWU6rIPYHAbVLlj/14tnhoH9ox3J6KChOlnGGdOqOX/cOPoiNd7u5yKK7XiMwr0ZPksafSvF8wO8ThPFxT/TF+3z3iliP+Al6MOPXEAv0Vw2NyLhmFQMs4pBoAV22k33TF3JG7kWIDZdi5mQtzwcbiN8XnipFnfN6hunkLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnMEy3PKFm8NovkeoElwPbJV89DYbcqYEpgReJW0NzU=;
 b=IAMZvrWR3Oig13YdiGFkr9w9t/r9ojUXZ4Dho9fk/ErHR4or2uvL2IRv47mHimzz41757psN1MDvGYsnKLIAfXtXHmBjqO1jCHhXFmRDBehfGgjbCbjrUnxewu8rz5s+1AZuxiJ9yv1nEmF7iOtVdycuHEKYp4mGmo1IKPJI9BGNqWyhwfGjU+YeDoMfes/ao5yzhMZ5FKhdTH02LxgVT++DoNkGprytCVFlZer0uxSJNsX8Sfq5Rp9sBpcrU0+O5qPwg083HauOaj8mFzNtZXwEhFEtD3s8+0dCCl76TiACHifxDUK0n8r7Sh46OuwoXH7drly2Qsfen39O4YDfEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnMEy3PKFm8NovkeoElwPbJV89DYbcqYEpgReJW0NzU=;
 b=rydLW9nYLrmgm4Yi7bA+QU4AT9bMCEeZzZZJv4QaucQq1cKO+voBFLDROuTFyCyBnvCI5VocoYjRhrPY1ZlMi4EpedLYr6ckfXqbZktg3feOKQ7DXoYV+TjkyOdrVyNCJGvh7fythNY5tC8256MImGfmgOZoxpYcXWve/rFnQx8=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DS7PR10MB5229.namprd10.prod.outlook.com (2603:10b6:5:3ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 12:09:39 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::d0c6:fa96:addf:6112]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::d0c6:fa96:addf:6112%9]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 12:09:39 +0000
Message-ID: <948d0a25-63fa-7234-57a7-0a9209169a51@oracle.com>
Date:   Fri, 22 Jul 2022 07:09:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220622200419.778799-1-longman@redhat.com>
 <6b2af276-f592-061e-1c0b-b11ed57b49ea@oracle.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <6b2af276-f592-061e-1c0b-b11ed57b49ea@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0002.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::15) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4de56e5-6d7e-4b31-9342-08da6bdb0d82
X-MS-TrafficTypeDiagnostic: DS7PR10MB5229:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnQnrK4SJ+Vn5Mpwb/ysMT4LWNeC2UkIG/B9HRtryJsKplqbaR8rN462vf8iFhECsEEO1VX9Bo6+h53+vC0OLZWW531/pqFxOOsE3nL8CczUcF2clIro4tauBm3nxlvtw1eQdc/T4sKNjSP754v9bnFvZycZmVoP50UaK+kKLyn06Hb2L8Z34oezaWLBCjqR8ozViWgPReQspKJT7e96fFR2fj6RP/wkcsEcAe0SAqkX7dRN1OvC8PXtEckk9f5GnBW9hyTTl9gnj++6AFbRXphoO7JlC7Sg39h+IfoBeg5UGqsuWmuVmoi83Dpa0/ncXir7NTs/V8/4MAKtHALnqHI4mlM9h2wJCYbg9iROYz8lnxQa3ObXQbbneWXIG9cO99LpYTIG8W6gbs49DYSRqND1LuZmbAKXSw1BRzWcT/xS1Wp0tPV/26e/ZgaKk7Bjzl2CoAOpqrkY79AmFws2mCshWsqaSr2JL/9VnWhsWDfBYQrHd7x8bxj7GBibEB8U96YDDVwZ8Inm26D7GUWdr1Oc0z1xBlt99CCcEdCGJhgdaKRmoP5PudOeAgdKOmKkLlc1nrg1aPNB2xFGcZFea9Dw+ZhaWOPxPK/C3U8ClKgwvPhf2eBdk8jOd+K6I1FQaX3V7ugZaFr5sE95R7P1bWlDkMOQM0ICt999pWHUweUJWuM8BfNIo7+PDXLyFYEM1Z3FK7PZtGubPf9x4WkfErSOy4LpN5GSSv2j6s0TzBaq1WebP4RcWNsgPeACrGeoTNwDn5IwMIrboCqLZ4Xmjep09AHExuvEdZQCPcROamB3+hulxIrgAYUR9RcGAetLrmfMac6BrxTdyU3gifaujIclcvdCa6Y4mV53eZHk5far7ZbTVf/hua718d41ioTK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(6506007)(186003)(66556008)(36756003)(54906003)(66476007)(66946007)(316002)(110136005)(4326008)(8676002)(31686004)(38100700002)(86362001)(31696002)(2616005)(8936002)(966005)(6486002)(478600001)(5660300002)(9686003)(83380400001)(6512007)(53546011)(26005)(6666004)(2906002)(41300700001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlFQalZQYVBKNFl3UUlqSHBJRXlNOTRRZS84eWZYYjdvTjROVVZMbDRpckM0?=
 =?utf-8?B?SFZUWG1mOVYyVS9KMHo3WGlUV3NJdDZWeGNXYUJTWTlFMWJCbXlhS2RDeCtY?=
 =?utf-8?B?ZjdTY3c2K3NNemVXQmN4dTU1SWEwYk8vLzZMWU5VM011Zis3alVXTVRtL0Ur?=
 =?utf-8?B?bWQ2S01ITUpvdFhNQUdNOTZ0aXY5c1lqejlkakk2UzA3dER6RUlxVW03a2Zy?=
 =?utf-8?B?dm5IMWlzclIzcHJvY0wwVURUdFhRT3h2VlNZL3VLbjNwMFJFc21EUWoxMHNv?=
 =?utf-8?B?MjBMczZvK0hsaTJ3VituZzZ3YXEwTFFaeDFUUys5VXYzcVY0bm9OT2MwU2JL?=
 =?utf-8?B?azMybmhYVFBSVXZubmdiUXVkRDJpUDY3eWJ1dVRUQ3l5b1dDYzJ0UVJXc2Zi?=
 =?utf-8?B?UkR4bGlNZ1M1cGdCMUZjVEo3aVRGcmVtdXp1NmFuY2JENGV4aTNZL3hINTRv?=
 =?utf-8?B?d1R3QmRJL2NzbFdDUklBNURHZ3ZmMmgxcFRNVnlkdVNWUjRETW5VTCtrQjlB?=
 =?utf-8?B?MWlVVTM5K1dPMXEzeVh6MmY1ZEJKcHlRYkVHYTBXR3h4M2c1NHJiTFFDbUJl?=
 =?utf-8?B?elIxN2JqR1JMMmlLMlA2dy9BNU0vR3crZHZYQUhjeDVzT1liYVhUc3Z4WExZ?=
 =?utf-8?B?cG1ONGhjQkIveGxGNU50Nk1BSzZGZEo5M2wxZkh1d1haRnJ5anB2Tng5bFVi?=
 =?utf-8?B?aVJxMUVWUEJGeFVPbmw2NEpuVUxJZnYzM0xNa3hJQmlHdWdPUzRneGR0RzZn?=
 =?utf-8?B?cXJKNTViU0pCc1ZQNnR6YUN5RUJVU2JRRWo0UVZpV1hmS0kyaGVpcEVjV0RD?=
 =?utf-8?B?R1g2T25vRUJXdFl5bThQUiswakFTaTJ2VXQ2dVVCSnNJMUE2QzFDcTBOS0FR?=
 =?utf-8?B?dkpEOWozNFFic2pwRlZoL2EwZW9ua2h0SWRFVkZidS81UWdYVU9ROXhPRE1p?=
 =?utf-8?B?MlFtRFQ5Y1NzRWRUN0NiSDlocFUyUUNIYUxNVGxEbkpwWlBpaHdOM25uOXZ6?=
 =?utf-8?B?QTRaRWNzbGhwQjU1YytuUnM3SkI2TlZTaDZZOWRkZzJCSzV4eERTbmZoUUJE?=
 =?utf-8?B?Qk9DWVBibmdISTJOa1lIcjAweVZySG04Z1doQ0ZPdVREam8zOEFDRVpMU3U5?=
 =?utf-8?B?OTNlN1QrUjhJaWRabWxhK0VBdmRzd2hzdUhMUE15bUVDTUQ5SjlpKzBBekVL?=
 =?utf-8?B?MitDZkFXZjFKVzByblBhT2FSVEJqSkFJV1NlSTBRRVV6M0drRzdNdjhIbUJl?=
 =?utf-8?B?RmtDS09UcXlsbHphM1FZN3NIdmw2QmorS3lOcFR4eFkxczRXRklLY1B4TjBh?=
 =?utf-8?B?bDhSNkJRcSs5OVBpSzZ6a0k0ckptNjk2T2dnK2NOVVgzQnFJTXVpM21LV2d5?=
 =?utf-8?B?MVpiU3hPZUFvemxWQmk4OVF3RTlLZmxOUERCamZJb0l5UFZqN29LbW1zZjRZ?=
 =?utf-8?B?TjhyL2hUTUFzTWJjN3Q0UHpNK1pKbkszTlgxUDVNeWtLaUh6VFR0UWVNNGpx?=
 =?utf-8?B?TWhUVUtCUno4YnVBVGhLOU9qYTBkRHZnWUdSY2ZWVGR2Rm9wd1NuSFNVYUw3?=
 =?utf-8?B?Z21UTThxdHVlbnRVb1RQQUFseHU0MFhaSVpra2djR2MwQkhuNkRZY0dCdksz?=
 =?utf-8?B?Y2NsRTNBdjIzeFpuSG10blByZG83MWxXYmtna0MxUzhjVnNmS09OZ0pHU3RK?=
 =?utf-8?B?WlRzK3RjclcwQ1l2SmNnSGU2YjA3eUF2RFJZSWhBK20wQ3lUMFFBZGtqUVdi?=
 =?utf-8?B?QUh1L1k1UG85clhIeUxMYlJ1dWNNVTM1bHRNZmVYZ21nSmhDT2hoakJuSzZ0?=
 =?utf-8?B?R2xTVmRxV2ZsQTFKTG1hNXRzYWxNaTd1R1ZWeUZHUUN3RmJaNktlQlpSNm90?=
 =?utf-8?B?L2N0YkRGTTZnanVyclJNSitxME5rZ2F3UlN2V1RldE96UlpyVnlhVEhIbDZZ?=
 =?utf-8?B?ZG1tTjJTaW8xQlA1Q1I0ajdlU2xBRmFHVmJxNEcvd01SUWxCSExVeWlwak1i?=
 =?utf-8?B?T3h2aTdtWDdsd2o2N3Naa1lpVkN2L1ZkSWFDcVAwYkVQbjJ5ZjVnS1JLVVVv?=
 =?utf-8?B?bUxUdjFWc2hFa3BJVUZRWE9LRzVsajNSbG1HSlZJcFBTOUdmL1NiUk9oSjZG?=
 =?utf-8?B?VHJuTG0xNXBOZXB1Y2xscXBtRzBRSHBCMldUK2crWjRpZFp1ZUZpSHFNd2tr?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4de56e5-6d7e-4b31-9342-08da6bdb0d82
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 12:09:39.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wn3yiKktQrs+u+NT7Y5pVWHl0+XHjK47WjwDkwEj6GNYv8m7dbUPsAKLcfvwiR7qjURHmY+g8whi5/BUCugFBJoX5RiK++s1Vc/3xsAP4Jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-22_03,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207220051
X-Proofpoint-GUID: uiUEb83yUxiK1LQRgeV0MtsXI-2dzMwC
X-Proofpoint-ORIG-GUID: uiUEb83yUxiK1LQRgeV0MtsXI-2dzMwC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/22 9:37 AM, john.p.donnelly@oracle.com wrote:
> On 6/22/22 3:04 PM, Waiman Long wrote:
>> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>> consistent"), the writer that sets the handoff bit can be interrupted
>> out without clearing the bit if the wait queue isn't empty. This disables
>> reader and writer optimistic lock spinning and stealing.
>>
>> Now if a non-first writer in the queue is somehow woken up or a new
>> waiter enters the slowpath, it can't acquire the lock.  This is not the
>> case before commit d257cc8cb8d5 as the writer that set the handoff bit
>> will clear it when exiting out via the out_nolock path. This is less
>> efficient as the busy rwsem stays in an unlock state for a longer time.
>>
>> In some cases, this new behavior may cause lockups as shown in [1] and
>> [2].
>>
>> This patch allows a non-first writer to ignore the handoff bit if it
>> is not originally set or initiated by the first waiter. This patch is
>> shown to be effective in fixing the lockup problem reported in [1].
>>
>> [1] 
>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/20220617134325.GC30825@techsingularity.net/__;!!ACWV5N9M2RV99hQ!MtLCpFzIovhhzojTACH793QVlr1c2eCOsHnjbuB6O3ydj5cqhlZUjVchbfnbMeD4kQ5AsgjVmX0hGfREWPrEAA$ 
>>
>> [2] 
>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/3f02975c-1a9d-be20-32cf-f1d8e3dfafcc@oracle.com/__;!!ACWV5N9M2RV99hQ!MtLCpFzIovhhzojTACH793QVlr1c2eCOsHnjbuB6O3ydj5cqhlZUjVchbfnbMeD4kQ5AsgjVmX0hGfQCd2bHaQ$ 
>>
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>> consistent")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Tested-by: Mel Gorman <mgorman@techsingularity.net>
> 
> Acked-by:  John Donnelly <john.p.donnelly@oracle.com>
> 
>> ---
>>   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 9d1db4a54d34..ffd6188d4a7c 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -335,8 +335,6 @@ struct rwsem_waiter {
>>       struct task_struct *task;
>>       enum rwsem_waiter_type type;
>>       unsigned long timeout;
>> -
>> -    /* Writer only, not initialized in reader */
>>       bool handoff_set;
>>   };
>>   #define rwsem_first_waiter(sem) \
>> @@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct rw_semaphore 
>> *sem,
>>                * to give up the lock), request a HANDOFF to
>>                * force the issue.
>>                */
>> -            if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>> -                time_after(jiffies, waiter->timeout)) {
>> -                adjustment -= RWSEM_FLAG_HANDOFF;
>> -                lockevent_inc(rwsem_rlock_handoff);
>> +            if (time_after(jiffies, waiter->timeout)) {
>> +                if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
>> +                    adjustment -= RWSEM_FLAG_HANDOFF;
>> +                    lockevent_inc(rwsem_rlock_handoff);
>> +                }
>> +                waiter->handoff_set = true;
>>               }
>>               atomic_long_add(-adjustment, &sem->count);
>> @@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, 
>> struct rwsem_waiter *waiter,
>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>                       struct rwsem_waiter *waiter)
>>   {
>> -    bool first = rwsem_first_waiter(sem) == waiter;
>> +    struct rwsem_waiter *first =  rwsem_first_waiter(sem);
>>       long count, new;
>>       lockdep_assert_held(&sem->wait_lock);
>> @@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct 
>> rw_semaphore *sem,
>>           bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>           if (has_handoff) {
>> -            if (!first)
>> +            /*
>> +             * Honor handoff bit and yield only when the first
>> +             * waiter is the one that set it. Otherwisee, we
>> +             * still try to acquire the rwsem.
>> +             */
>> +            if (first->handoff_set && (waiter != first))
>>                   return false;
>> -            /* First waiter inherits a previously set handoff bit */
>> -            waiter->handoff_set = true;
>> +            /*
>> +             * First waiter can inherit a previously set handoff
>> +             * bit and spin on rwsem if lock acquisition fails.
>> +             */
>> +            if (waiter == first)
>> +                waiter->handoff_set = true;
>>           }
>>           new = count;
>> @@ -1027,6 +1036,7 @@ rwsem_down_read_slowpath(struct rw_semaphore 
>> *sem, long count, unsigned int stat
>>       waiter.task = current;
>>       waiter.type = RWSEM_WAITING_FOR_READ;
>>       waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>> +    waiter.handoff_set = false;
>>       raw_spin_lock_irq(&sem->wait_lock);
>>       if (list_empty(&sem->wait_list)) {
> 
> 
> Hi,
> 
> ping .
> 
> 
> Can we get this reviewed ?
> 
> 
> The offending commit:
> 
>   d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more  
> consistent")
> 
> 
> is found in all these branches:
> 
>    kernel_dot_org/linux-stable.git    linux-5.15.y           - 76723ed1fb89
>    kernel_dot_org/linux-stable.git    linux-5.16.y           - d257cc8cb8d5
>    kernel_dot_org/linux-stable.git    linux-5.17.y           - d257cc8cb8d5
>    kernel_dot_org/linux-stable.git    linux-5.18.y           - d257cc8cb8d5
>    kernel_dot_org/linux-stable.git    master                 - d257cc8cb8d5
> 
> 
> 

Hi,

This issue now in :  v5.19-rc7

Can we get this reviewed ?



