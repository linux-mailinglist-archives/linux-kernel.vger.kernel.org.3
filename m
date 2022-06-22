Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1995552D3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359547AbiFVRtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376841AbiFVRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:49:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53360326CE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:49:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MFabNa021340;
        Wed, 22 Jun 2022 17:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/cYYJNSuxtmabRsM2qFu3MYwUqg3ihG18/s76AYtdBs=;
 b=ImOFHBHbindEq2hvip7fbRg2YYo1z61QYylfLY/VyBIF3qfVfkEktFdGdJdQSQ9FYF3V
 EpnDW6rT71QDzylXcdNGiZ4lf3NRF7KZHIqog+TpZ7a07AvGJyupiXEl7o1AR6JrAEe+
 ouF2KZksg6CNQxS/8fw+wKApcArBvGOfaK99U9rCIXLqUmyR3U2gxn5Kt+faWI+l0tx+
 i/LdkRx8CdjhtJF8CDjGXmBPvBomBFHEDU3DAtDo/euSkQzJ6EYXbTrs1REhRLwvnjXX
 iCwiL59hddQbD58A9pTOVBT4LrDhxkOBZVBVhubIBDXDRHhvA2AZ0mv3IAArAsFkguuG BA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6at16n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 17:49:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25MHip4L010735;
        Wed, 22 Jun 2022 17:48:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5dupcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 17:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYW2GLn+L1xKzpkbkApla5H8sFMUjqDs3g2sCgzphzUpIQNBZK8C4zGYH2UvFgYvFCEEXi0TKNLEPrvDgATYh5SsJ1uXmpB42Ydh0ZSGMUFlwsUMD2+imTo3FdwmkAWsiIq/sDLqaUrqhQVSzLBHMDVae+BZcggOlhnBcIK/kYzz5WbaSjGqYgJ87kkZyr7cBb1MGywiH6vcvg+gFPaD21ZzQ3trnTbjcg6BRG130yJymG41ZCB3Wg3J+Pnz+WLJgGYltaetAiXKq3Z7i7Til+vmi3ymkge52JGl5np8tAUb2ELH1PnfcBi+MBBfeszABdY4xjYn46R1O7B8K6MelQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cYYJNSuxtmabRsM2qFu3MYwUqg3ihG18/s76AYtdBs=;
 b=ZLRgGPj+2JBOB6kI8fCXEGrwRRIToPzehAyiqZxgW7RRQah4lLNjzrvRvNEjPulsildwlZpk6iHJ0pXQQfDTEfUItlrs2CwSCLQIfWzSwXrSIwNl7cvEXfVlfGCEKofYh6wiGTnoMUK3XcIuMHJ653TXhtu0ZY+3NDqyYIZIUgerXLqBsjlyFgLl09v985VABJLnXdfijNyNmpbEEvP7D+fD7qwoD5rUc+vMrBeCqS4E9b+dfWfurkrAzbc6EUZP5XHCie8+/ElcUNy8vHdwm8A6nFcWRHyMoiiXgLScfCiLdO8Rezl1IkEjo2kTMi87Ze57c1BCgQ9ixiVd8q+ocg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cYYJNSuxtmabRsM2qFu3MYwUqg3ihG18/s76AYtdBs=;
 b=xUd8p4NseF1mkbXR2/OALWJUQgEC0Ce+9FxR6bxdo01q9ifQYNrhIwxEbdz2P4pm2NUOzy8tLT3qL2OddQItcMj2/OhpZ5qbmxzU1WwiIZNXegzgyJI7zbreAzBr97T55tU09aO12c5kAsRK/sO1UaoNmpaRLnKWYA56VTSRstM=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by DM6PR10MB4140.namprd10.prod.outlook.com (2603:10b6:5:21b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Wed, 22 Jun
 2022 17:48:57 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::84b2:5ebe:732a:de7c%7]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 17:48:56 +0000
Message-ID: <368f1ad6-83b9-01cd-1fba-3e87a0f73725@oracle.com>
Date:   Wed, 22 Jun 2022 12:48:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>, Waiman Long <longman@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20220428012342.3713-1-hdanton@sina.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <20220428012342.3713-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:a03:100::37) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d6a31bc-f976-4fa1-1c34-08da54777af1
X-MS-TrafficTypeDiagnostic: DM6PR10MB4140:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB414025690A0E44959948FC96C7B29@DM6PR10MB4140.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPukxlxe/8jRQZ72yHyw5tT7iH/gOSnZe5beeoUWW6ttYrwy2AEIxedvRcMoYIJ1uLjJ9W1Vb7cxFvDygoK4czt5zKFcAaXz4xqsSLG+2KpMpWtqo42ZpubOUWLdfNXvUvKQufIBcmxQxkLLtWXGoXNeFvCWVXxdy9ozfXAKCymKpa4ol9YKMWn3ElatFQWNaDGxnj2La/apg8Rit23tJ+L6SNIIkx+JyKQhktzog17w4rX/gSbZr3dn3io5KO5LHN7IU0XrPx/8a19tv9O+hc38aSJeGakfODyszOT7EO2T0+dPZDCKfFzZFHlLAk/Hn7lKWNwkn4JlYeuaSbKJ5xndxiqv7VWM/SmWvu43NXBHuCa9hrrsAISG4hZSa/yS7gyMKT++Nj78YR1HY53PcXSSe/reWRPtRDqiROCgbYYzvG7gRud15XK3JuMvfV/2Otww02yYyCXpiN61sFjTgcMnPVKyaSfJyO4dMc0wBId8lQXSu71d4gmTz9CoEabFGsEgazai+orCYaVUTdPRdgklgri4jGANRsoW09XrGOhb71tEKp/TRxxfQu53LY1ZBNMqRj78Q/HnRGgS6N6KWmL4CbnJQolrdpiGJhnDtKNoMgyUgs2tNRdd6lm/BJduSlNh++AJijxk7SNaN80goubtbbHvS6enNSvp+sfP9UYPo/bfHUrAolrIcTROxaTyYrZtsnsGl/O0b7xKcU35mtwz+tV5dtj44QCU39X36B26QMxWfUXxBW9t67SfqqkN0H4uq+4RI8efiyuW04IErA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(376002)(136003)(366004)(186003)(31686004)(36756003)(83380400001)(66476007)(5660300002)(66556008)(2906002)(66946007)(6666004)(8676002)(8936002)(4326008)(110136005)(31696002)(2616005)(26005)(316002)(53546011)(9686003)(478600001)(6486002)(6512007)(41300700001)(38100700002)(86362001)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGU0aFBjY2hsMWRQYVJKU2w0czFVMHhtTnM4YlBaVXEvWmcxeEdOWTJMbkxx?=
 =?utf-8?B?YVM2NDZST0lrTndhdVVPcTlzMmZTU2djcE5EM0JhaXp1Uys2TnhnK2NOa0pr?=
 =?utf-8?B?VFlDOHdnVEFwbHRGVGNlc3FzWExuaEVSeHhqTjBDZlQwWFZJWmFwMkJueEY0?=
 =?utf-8?B?eEdGSkIrcGpwTEdyeE1kcWZHMWQyM3pjTXZnTHdNekRhQlZrMWptbDFrNUdi?=
 =?utf-8?B?ekpLNnJ4b3Fkd01sTTA1L1NSYVhmeFh2VlZkQmhFSnc2bFprMDY3TGlPSEpN?=
 =?utf-8?B?TGwrUGVoa2s3T09UT2NzdC8vR0svUVVTeGdVLzh4LzlBT3BGMU41eWMwUDdU?=
 =?utf-8?B?Wk0zQUlMa2JtY2R3N01OZzlaYjN6ekVmdGM5Ykljc3VOYWMyZ2F4Qzg4R3Jp?=
 =?utf-8?B?VkZ5eitpYjRPQkNIUDNlYmhUa3hwZitsSk9EK0ZEUHRLdUNEM0FKZnY4TGVi?=
 =?utf-8?B?bmpVSlFuOHptT3JvektVT3g5UHFoUGloRS9WMWJjTmRMWGdFNGM5amZYTzFY?=
 =?utf-8?B?bCtqNE5oSW5vNjJzWTJRd0dDOFNuUGlham4zZmE0eXpYaVZ1NjNIOExkV1k5?=
 =?utf-8?B?RFF6NllwM1UrMEI4ZU4yWElrTFRCeGJ1SmhDNlh6TngwMlp1YmdqaTNDeEdz?=
 =?utf-8?B?bSt4S2lDbFFOZXJIOWpJS3B5Vk9JMXJkVVVYakd2MGxjOFRZbTVsU0hFbnJK?=
 =?utf-8?B?NnBUUzZzWTdQZVJvT0F2eE95UnNTam1SRjVLVWxzWEp6aEtjb3VWbE9Tb3I1?=
 =?utf-8?B?Sk1GSVhzM293cldKUFZnMVBsSDFUTVVnV2o1MlVkU2s2aHQzaUtjQXo2eFhn?=
 =?utf-8?B?OSsrZDUraElVdzFabTZOSFRhUmxuMXNFa01YSVptSlBMSzdGTXZyMDFGZGhL?=
 =?utf-8?B?ZmpmdGhjNVBLZS9MZHlJRUxtRG92elJMNnpaS24wNExBdWtoZVhFNlpQNTZT?=
 =?utf-8?B?cnNIakhnUlVRdWtkc1RiNFVvR1FjeGxxSW1zUThWWjlyeENzZDhhRVVDaFgw?=
 =?utf-8?B?T0tOQkRYSHFzMFU1clhXandSd1owbjFlTDRhZjRlYmJVK3Vsa0l6cTlzd0tu?=
 =?utf-8?B?N2V5U2JmT1lMdUtaZzZHWklUOGkvRGQzbkNUQlhDWGlGcThrMXEraEl0bUlH?=
 =?utf-8?B?OFJMOUZoM1VpUHB2U2owdXpqelQ2NFAwaTZlSW51MEdtTDZ1V0Fpemd2Rnha?=
 =?utf-8?B?cUUwM2NXeTh2cHJ5bHdYcEdkaUoySzFmS29RQkhqRjhqZGtJaC91d045bXA1?=
 =?utf-8?B?R2NJeVJFNm9uZlZrMjlnN1VGVm1FbVk0YjBXejVzSmlIQk44REcrSjE0ZXdU?=
 =?utf-8?B?NWxUNWU2R2xtZFJQL1VUL3lLQzNxeTVZcGozT1dhRFNkV21OMklOeGV3ckxO?=
 =?utf-8?B?TUxzL0VyZ2FaWVkwWmlYZ3M5L0RtZWdCUVpQbURta05LbmYyM1ZlakFxMTZD?=
 =?utf-8?B?K3FNMjFTRjcyMVFPK3E1My9aWmJhSks0ajVWdHlDcUN3T0kyZEM3T2F5TDJl?=
 =?utf-8?B?SkdYTm9zOVR2ZzhOM3k0cGViZTJ3V0xXYWxIQWQ0b3JaZElxbFphWVFsQTRy?=
 =?utf-8?B?M0pjSDB4TlJnUW9EUlAwM2VzdGRZalpGUkgvN2dqSWphQngzSlpLVUZTVm9h?=
 =?utf-8?B?elNueW5sZ3Q3RFFXZWUwU0VqNittK3NBVUVpcW9Pc1hvTGc5dXAyVGM4MUhh?=
 =?utf-8?B?cGJKSGh3bFhGSXJ2c3BpeVcxMUp1YWpPcXppWWN2MzdGaDdRd3ZOY2tva1hP?=
 =?utf-8?B?SU9Lc1NsbWtvQ2ZSTlZNZFpoSm5Wb2FkQ3VCYlN0UjRETXpSMFFwOWVNR2NB?=
 =?utf-8?B?UlpHOHk4V0FOR0xNOXZ0dTkrOWFjelZjZG53U0FhM0xDZkRQRzRKVHBac1ll?=
 =?utf-8?B?U1hBSC9qTXNMWVlaRlAzNUdCNC9uYmdZU1BURjRLMXIwbVlLbHZLSFFmcmhI?=
 =?utf-8?B?bzQ1N0l5SE5RNnZlc2dJSnVXSDJaMFBoWTB6UHNDenNLTUFWa0NURVFhRml2?=
 =?utf-8?B?NG9ObU43Mm10eUpFQ04vajZwSC9teEV5M3JTbjA5TjNCN3NWNUVNQmhuMVlS?=
 =?utf-8?B?QWlBa0VFTjJhdmpscHlMSXY0UUpSOTFLaGROMjNVVWdwSnozeWxFUGZDWHFz?=
 =?utf-8?B?dThkZEtRSXNGNy9NeXh4WDQxL29ubXRVQWlxVU0wVDJLdEcxei9mUVpsZksr?=
 =?utf-8?B?elhxU0N1MU5jQktNSDB5ZDcvSUloY3ljNDhnVmE3a0hialVhRW5yc1VFZnhx?=
 =?utf-8?B?M2tBYUxEamZJNzBOdGZUMWtFMS9ybVAvVXprNFRIWEdKN0lwcVJTR3RhTDRR?=
 =?utf-8?B?b0o3N0pSWHVIa3lwdzdhNUlZN1gyb2pTa1ViQlpZalZCNnJEOXZSeHVkTDNq?=
 =?utf-8?Q?ts76tesRbyvdMrkg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6a31bc-f976-4fa1-1c34-08da54777af1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:48:56.8830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEpONOxEJDGZxXYmy6qq3a2pvF/2fOAFGumps1vI5CH56+5gfwdkBsvuAppypIFfF/h5To6NfkbOPs2h2WJgNdwiCg6sQhgP8EsTlHs4w5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-22_04:2022-06-22,2022-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206220084
X-Proofpoint-ORIG-GUID: 6Lgh_Dffaa3VdHaybGiTMMgvdFOOL7wC
X-Proofpoint-GUID: 6Lgh_Dffaa3VdHaybGiTMMgvdFOOL7wC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 8:23 PM, Hillf Danton wrote:
> On  Wed, 27 Apr 2022 13:31:24 -0400 Waiman Long wrote:
>> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>> consistent"), the writer that sets the handoff bit can be interrupted
>> out without clearing the bit if the wait queue isn't empty. This disables
>> reader and writer optimistic lock spinning and stealing.
>>
>> Now if a non-first writer in the queue is somehow woken up or first
>> entering the waiting loop, it can't acquire the lock.  This is not
>> the case before that commit as the writer that set the handoff bit
>> will clear it when exiting out via the out_nolock path. This is less
>> efficient as the busy rwsem stays in an unlock state for a longer time.
>>
>> This patch allows a non-first writer to ignore the handoff bit if it
>> is not originally set or initiated by the first waiter.
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more consistent")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/locking/rwsem.c | 30 ++++++++++++++++++++----------
>>   1 file changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
>> index 9d1db4a54d34..65f0262f635e 100644
>> --- a/kernel/locking/rwsem.c
>> +++ b/kernel/locking/rwsem.c
>> @@ -335,8 +335,6 @@ struct rwsem_waiter {
>>   	struct task_struct *task;
>>   	enum rwsem_waiter_type type;
>>   	unsigned long timeout;
>> -
>> -	/* Writer only, not initialized in reader */
>>   	bool handoff_set;
>>   };
>>   #define rwsem_first_waiter(sem) \
>> @@ -459,10 +457,12 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
>>   			 * to give up the lock), request a HANDOFF to
>>   			 * force the issue.
>>   			 */
>> -			if (!(oldcount & RWSEM_FLAG_HANDOFF) &&
>> -			    time_after(jiffies, waiter->timeout)) {
>> -				adjustment -= RWSEM_FLAG_HANDOFF;
>> -				lockevent_inc(rwsem_rlock_handoff);
>> +			if (time_after(jiffies, waiter->timeout)) {
>> +				if (!(oldcount & RWSEM_FLAG_HANDOFF)) {
>> +					adjustment -= RWSEM_FLAG_HANDOFF;
>> +					lockevent_inc(rwsem_rlock_handoff);
>> +				}
>> +				waiter->handoff_set = true;
>>   			}
> 
> Handoff is tracked in both sem->count and waiter->handoff_set,
> 
>>   
>>   			atomic_long_add(-adjustment, &sem->count);
>> @@ -599,7 +599,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
>>   static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   					struct rwsem_waiter *waiter)
>>   {
>> -	bool first = rwsem_first_waiter(sem) == waiter;
>> +	struct rwsem_waiter *first = rwsem_first_waiter(sem);
>>   	long count, new;
>>   
>>   	lockdep_assert_held(&sem->wait_lock);
>> @@ -609,11 +609,20 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
>>   		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
>>   
>>   		if (has_handoff) {
>> -			if (!first)
>> +			/*
>> +			 * Honor handoff bit and yield only when the first
>> +			 * waiter is the one that set it. Otherwisee, we
>> +			 * still try to acquire the rwsem.
>> +			 */
>> +			if (first->handoff_set && (waiter != first))
>>   				return false;
> 
> and checked against both parties, thus in a simpler manner RWSEM_FLAG_HANDOFF
> in sem->count means the first waiter has been waiting for lock long enough.
> 
> Feel free to ignore the comment given the Fixes tag above.
> 
> Hillf
>>   
>> -			/* First waiter inherits a previously set handoff bit */
>> -			waiter->handoff_set = true;
>> +			/*
>> +			 * First waiter can inherit a previously set handoff
>> +			 * bit and spin on rwsem if lock acquisition fails.
>> +			 */
>> +			if (waiter == first)
>> +				waiter->handoff_set = true;
>>   		}
>>   
>>   		new = count;
>> @@ -1027,6 +1036,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>>   	waiter.task = current;
>>   	waiter.type = RWSEM_WAITING_FOR_READ;
>>   	waiter.timeout = jiffies + RWSEM_WAIT_TIMEOUT;
>> +	waiter.handoff_set = false;
>>   
>>   	raw_spin_lock_irq(&sem->wait_lock);
>>   	if (list_empty(&sem->wait_list)) {
>> -- 
>> 2.27.0


Was this ever added ?

I don't see it in


a111daf0c53ae 2022-06-19 | Linux 5.19-rc3



