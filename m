Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE28A573D43
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiGMTf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236974AbiGMTfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:35:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE53057C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:35:04 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDmrA023352;
        Wed, 13 Jul 2022 19:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3A5HavGVazYWnu7fGIaA1FQKhkviA1RF+I0rV2cmpvo=;
 b=x5OUKEmuQVnSj0vQopFpIXRko3bhmK4h1AtqmmdOffewTjpCMAq5YYogvG1vfVS4T2qG
 P7xQdkK0SpwuUT2AL+yAggt27NxN6G17yp+izxnP9dOn2WNurUSKLjEmMH2WiGyoKUq8
 fEIdZZhEkMhRVI/A8LqLEQIiQnr1dsUrn0wiPtvemLF0FOVFHD0dPaKyj6XjdxFb57r9
 w/AUAip1HKrclFLckw0kOCHW6t0k5GBlLgDC3rDzU+cEfXAIEWG835MeYEsV6IY7U9Xl
 mfB+dqg30okUyy+omE0+ZFqu2xfQVAFaTavweV838Lw10dYtioKf6KTZMei57uf1uS71 nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scbas9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:34:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DJ6q3e031208;
        Wed, 13 Jul 2022 19:34:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7044qw8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 19:34:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T85KDUfR7UCvuERkJzHITcKPShiMP9mU0r79yXdg/IOrRIrxeCu4C+Zb1R7twpzXdaR5DI3HV56fIL+JDaBibYO61BvrWtLWEKDQnmEs6xGuwoFnEXvhiT0FK4nEdXe41qbTFl4ynmc1IJVEI/b3h5XoMOxHLBQPRUAG5BflGcJLjwxhkjp2C7H/yQQVaUYLr/bdP7ooGB5/TJEFsNVEQjhaQdMhYIY2ClMvOP6nE7vtlucoing6+wwjxz5D8Mhh8U1MOuyyGI1qqgTIDMAqpuAdivCDzAlIywjsNAy886MYPeH7nHWb9XxStNwfhFlvz9vxeLqb9Fbz3rvCpRKvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A5HavGVazYWnu7fGIaA1FQKhkviA1RF+I0rV2cmpvo=;
 b=cYfpXCP+7MKrptrP9QvKy+WDrz6Z6e9kVc185wAQBajJQl9YBV1v1OUmnM8udXiVuHFLUUj0WbXAShzt+bkut5OVcFOcMmmzophmhSGFlRMIb6OWv2tnxezEKyLWbfaOAWrVIV9U1kdOZ5+izB+X302nC8tcShHKVskiNWaeh3TJnycrbpG/3jffUQOAMHTrYKghxQEJ2wnyqZ7tP852iGD3+LrbX4XkeuHy1xr1EdQuamshUBZEha89Nc22UaA/bnp6KFPDwwkBfF90cwwXvAKggZ8u5IhPhlqV56HqCtyObryBMDl7bA7d2eC6A+xbh6PqBVdRUimiCUHYoGquoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A5HavGVazYWnu7fGIaA1FQKhkviA1RF+I0rV2cmpvo=;
 b=jLVSHznkap+cYczrTiUYWjkkzZridvNdH7R3MrTDkKQ35OEiZycCasc37csh3osz8Ao1r5+btyXUwxU8sI4pws/7VPsAC7Xn4YBYPCGnhMJqXMd093hSWMjXLCvRGC8dhM+4GtGiEufVtDuVrla6ypuIyTgGCmXKt3pedlM34mk=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 19:34:30 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 19:34:30 +0000
Message-ID: <702546fc-5d5e-2d62-561a-5c323452f5be@oracle.com>
Date:   Wed, 13 Jul 2022 12:34:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
From:   Libo Chen <libo.chen@oracle.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
 <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
In-Reply-To: <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:5:100::39) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b34d227-df9d-4b66-9a5a-08da6506b495
X-MS-TrafficTypeDiagnostic: MN2PR10MB4285:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6ohkAXyne7/lzA/NAeNTrRvJ6RXdwiSV84G6FtKheSnRhJtOjwDDomx+ho9xUvxQjEuyuanHVCVX+O1eYosnZP/CMgMb8r0Vs2BvqB+w//7uVXl5/GdHaFFEvcZlS+8PdEU7lTUAmibMiJPc3e+KdfGXbvOu6rNSNSemp6/SPvCrIw3bjCCLrGTWjzsfe6qRExPQw30jqtEWFMSLao9omh0qVPL6g3KL+Eh3CkMgnICUIrUc3/de04nPkdVXNAJdnLoDB/Swl8vK1xtOKzHD19EDMj1DE5fpHb/lPg1YXXoOal1vMHSzfoivZsgQV0aK411K+M9NB6Sy6iKWLcbYyY5JWc0AVqOyKwCyoHVtc0RbWGUUz18Mp8mb5CL6fgJjUbpmoaW9FoFwKgP8Pu7PJaqlOJgbMkUhLrAMWZRBPKc/QORTbK7xZlt7/HHuho3VvSgzjV/xKm9SPd7NJK6C2gEPFqfNMvu/H8KGf5chQhOt8mUMoOSD4bIRsxtKScJADLZHd8SjceB9eytr7zSpR3a+2smRCmRKwv5+rKxupEeBs8wpGW5aPnhL80hhHh+eqa1iBNiEozIAPuMzQI8T11VdNOPXat7JBAnnmb1zq0z7511Lo6oUG8buYJB2Xf18VD/T0MOGdo78J12HfZukvviQYzGIIpFh0LptYQatnjdHSrbvu07Nl7ewRLVsCvkxRwLk68dtHlB7/aqWvYqfjcmCpQYzeXb2sYri1f++/OkN+VZV9dNtUif9YPBHXaUkcGB9Mg7mduJnCWHo4OHmXxwbpv4DVA6PVB5HtP9nCm40sElLq9+2Rpq8ZVZbRwc8VmoXS0s/5ePlHM6ik9+rzZzbr9Qf1GCVxrPUZ2kqBUgV6V4oPz0SmYpYJh09BKu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(346002)(396003)(39860400002)(66946007)(31686004)(5660300002)(83380400001)(186003)(2616005)(66556008)(38100700002)(2906002)(8936002)(44832011)(30864003)(36756003)(4326008)(8676002)(66476007)(316002)(52116002)(40140700001)(53546011)(6506007)(6666004)(41300700001)(31696002)(6512007)(478600001)(6486002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFhUc2RYZCt6NXJHN0hJK2ZOU0xIZk9BbVVsM1R5UXViakV1Y1IwU0VLT01T?=
 =?utf-8?B?WUV1NEp0ZUZpVWV5NVhjVTlMMEJiUFdkSU1FcGJEVFF0emF6UnJ6SUJYMG5M?=
 =?utf-8?B?RVFBOFZwMW1IVytRSFhDdEFacWVldHkwRUdLMWVyMFJaREU5SkorQ1Q5TTE0?=
 =?utf-8?B?Z0N3eGpoRmRoVEliczNJbjRUMWlRS2ZVVlJCOTFRKzVZTUdBNzNUbGo0UCtH?=
 =?utf-8?B?QjYzM1BZdHdoamc4dzRBTlc5S3B6R3RNTi8yR2VXTE5Ed2NSVHlDSEUzdnJP?=
 =?utf-8?B?MldFTFZqYjJZSzdHR1pycnFvMnE4c21hM1h1QWU0T2hOS0x6ZXNJNlh5bzFO?=
 =?utf-8?B?RTVqbXBxWGNCNTRpMitlcExPNk5OZ3FXOGFiSFdUeHhTM2EybVhLaWRRWG9v?=
 =?utf-8?B?bWdhMFFESnNMeVc2V1lEZkRFV1pRdzlLVDdtVHV1UnpNTVczR0ZiMCtFWG9i?=
 =?utf-8?B?a3o1SVA1a01UNStabStPVHpENm0yNkV5VDJTWWpuRE5jL1RYYzJ1SHlqd3Vn?=
 =?utf-8?B?UHlMdi84aENUdXVNb29OTTZyalBneS9MTHRzL1lORFdGb3JlMWdkZnFKLzdv?=
 =?utf-8?B?dklGSGZFTTRmOUJ2Wks3djZkR3VGU1FJNnFoZ2JMcFhxRjRMaDJibUpLV1Bx?=
 =?utf-8?B?cjdDT05xV0dZMmNndlNpeVM5WGZDUW5MVWg2c0FDVzJmRE83TUJib0lJL1Np?=
 =?utf-8?B?clgrb3VmaTlwTDRWak53dDRtdlhRd0VTNzFrOE5ZRVMxc2t3QXpucFZ2YzRi?=
 =?utf-8?B?bVhXYXg4QzBCMmFyZFFZSzAxbU92eTRiMktwMXZUNytRWWo5RDRwakprVzBI?=
 =?utf-8?B?L2lNU0VkUnVZQ3E0SGwyNDVMSHNheENhVlR4OU1oZWlNRU9ONXlsajJZVXRy?=
 =?utf-8?B?S29JMGJYMnd2Z0lUMW0zNEFIN216cSsrRlB4ZmVRaXArQk02L2xjQnM1cWVN?=
 =?utf-8?B?TGVUTnBJUjh0aWZlMVBvNi9qTVJNQlNJSHpEaDdHaGVWNzJHSnh4Wm9lRWpI?=
 =?utf-8?B?MEJwOHR6SVByZElMU3NSNEN6bmZDQ0UyeElxanNvdkZ5UzEzZHBJYy96dGIz?=
 =?utf-8?B?Z1NabTlqWUYvRldYbmc4QSthdi9zbEtwQitRQUFyVjAxWlprRXVybGI5UkpT?=
 =?utf-8?B?VUtuaU94UWZ4bXpjSStYODdUdXA3SGYzcC9oTVZBU1M3bE9BT2Z3aXdmdU5r?=
 =?utf-8?B?UGRRODR4blF2ajBZVFVONXhMWXNLTmdlb3dkZUE3dmZLNDlYNHcrUElpWS8r?=
 =?utf-8?B?dDNnbTZUaWl6OXh2ZUxQUnlZZ1ZUQVdUcTBsZUk4aWMyMFpGb1BHRm1KZFdN?=
 =?utf-8?B?OS8xc3lvRXNoK2s3SHlGN2ZrWFpoZ2I3YzNpN2wzcWVvM3JpdnlEWGFJWFpl?=
 =?utf-8?B?Y2VoTldDRDF4eTgwRlpmck14SVVydW1HQjdwNmZtOFZKc2ZXalQwcE9PckZy?=
 =?utf-8?B?RkdjUnRDa2hJV2ttaFZsaWtDbWNYclFRSUJUQ0M4YzRkbTBxTk14cGZ3bmph?=
 =?utf-8?B?eFgxZ3psTTJyUmdSdUV0ZXYxbEJIMFFXcC9yN3BmTFhyRmx2YXhiWnlPak85?=
 =?utf-8?B?L3J1OGVCT2czcDF2ZVIvdWE4QmVaZVFHay94bTd5eExSUnB4WmRUSjhTV0Rq?=
 =?utf-8?B?RUF6QTRwMVdGRmtSNGlzM3pPVytQQXdGY1dtOFlHVUJHbENTZ3M4czRtWnJa?=
 =?utf-8?B?aHV2ODgxWlVuY0g1N2dQZzRjWW9pcnRRamZSWmJTUlpRMm1HSmNVVWw1WWk5?=
 =?utf-8?B?T2RJUHNvSFlYR2JKSEE2OFJOUlphYit1OUh1dEV5WGFmWW9uS3psaWpqY245?=
 =?utf-8?B?L1Fja1A3bTVxbFcweEpxSU9XUjJCOHRJZGxXRTVhQmcrUWdYc0ZTMHhsWWo3?=
 =?utf-8?B?YzdvR3g0V1lrZmVIV2FVSXZQUWpRbHY3ekFoY25GeGpxYjYzRnBDT1JtMmlv?=
 =?utf-8?B?VCtrMmUwOXMrOTN1NFZ6YlIyRTF4ZjJoeHE0Z2I1b2kzQzA3ajVDZVFFWFBi?=
 =?utf-8?B?SzVNbFRvWlNib1d1YjJoNjduUFVzUnB3dDJ4TG9RdGorVG05eExOSW4yMU05?=
 =?utf-8?B?L1BDclZxeXl6VXRNb0t0QzZDK2ZqK2NnSXArVmFKaktwSTVVK3VkNmpMZkUx?=
 =?utf-8?B?Y3VDL2VadTY5czdQQlNuL0FZNDRqdXlrMXg0MTgvMFdhY0pkc0JVNXVWckNa?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b34d227-df9d-4b66-9a5a-08da6506b495
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 19:34:30.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/VM7qVk5rebzbu81GExQBmjIrUZUW2SZ04Qa7vm5RybSBHVnlZC7qykPIIGcNnysIlDxUWNNEEno/Uw1Jeaxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_07:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130073
X-Proofpoint-GUID: KpgJR17YQse-D7KDm2tk9f1TNeZbyqmr
X-Proofpoint-ORIG-GUID: KpgJR17YQse-D7KDm2tk9f1TNeZbyqmr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-kernel@vger.kernel.org complains about html subpart... I am 
resending it in plain-text only
so everybody on the mailing list can see.

On 7/13/22 12:17, Libo Chen wrote:
>
>
> On 7/13/22 09:40, Tim Chen wrote:
>> On Mon, 2022-07-11 at 15:47 -0700, Libo Chen wrote:
>>> Barry Song first pointed out that replacing sync wakeup with regular wakeup
>>> seems to reduce overeager wakeup pulling and shows noticeable performance
>>> improvement.[1]
>>>
>>> This patch argues that allowing sync for wakeups from interrupt context
>>> is a bug and fixing it can improve performance even when irq/softirq is
>>> evenly spread out.
>>>
>>> For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
>>> waker can be any random task that happens to be running on that CPU when the
>>> interrupt comes in. This is completely different from other wakups where the
>>> task running on the waking CPU is the actual waker. For example, two tasks
>>> communicate through a pipe or mutiple tasks access the same critical section,
>>> etc. This difference is important because with sync we assume the waker will
>>> get off the runqueue and go to sleep immedately after the wakeup. The
>>> assumption is built into wake_affine() where it discounts the waker's presence
>>> from the runqueue when sync is true. The random waker from interrupts bears no
>>> relation to the wakee and don't usually go to sleep immediately afterwards
>>> unless wakeup granularity is reached. Plus the scheduler no longer enforces the
>>> preepmtion of waker for sync wakeup as it used to before
>>> patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
>>> wakeup preemption for wakeups from interrupt contexts doesn't seem to be
>>> appropriate too but at least sync wakeup will do what it's supposed to do.
>> Will there be scenarios where you do want the task being woken up be pulled
>> to the CPU where the interrupt happened, as the data that needs to be accessed is
>> on local CPU/NUMA that interrupt happened?  For example, interrupt associated with network
>> packets received.  Sync still seems desirable, at least if there is no task currently
>> running on the CPU where interrupt happened.  So maybe we should have some consideration
>> of the load on the CPU/NUMA before deciding whether we should do sync wake for such
>> interrupt.
>>
> There are only two places where sync wakeup matters: 
> wake_affine_idle() and wake_affine_weight().
> In wake_affine_idle(), it considers pulling if there is one runnable 
> on the waking CPU because
> of the belief that this runnable will voluntarily get off the 
> runqueue. In wake_affine_weight(),
> it basically takes off the waker's load again assuming the waker goes 
> to sleep after the wakeup.
> My argument is that this assumption doesn't really hold for wakeups 
> from the interrupt contexts
> when the waking CPU is non-idle. Wakeups from task context? sure, it 
> seems to be a reasonable
> assumption. For your idle case, I totally agree but I don't think 
> having sync or not will actually
> have any impacts here giving what the code does. Real impact comes 
> fromMel's patch 7332dec055f2457c3
> which makes it less likely to pull tasks when the waking CPU is idle. 
> I believe we should consider
> reverting 7332dec055f2 because a significant RDS latency regression 
> has been spotted recently on our
> system due to this patch.
>
>>> Add a check to make sure that sync can only be set when in_task() is true. If
>>> a wakeup is from interrupt context, sync flag will be 0 because in_task()
>>> returns 0.
>>>
>>> Tested in two scenarios: wakeups from 1) task contexts, expected to see no
>>> performance changes; 2) interrupt contexts, expected to see better performance
>>> under low/medium load and no regression under heavy load.
>>>
>>> Use hackbench for scenario 1 and pgbench for scenarios 2 both from mmtests on
>>> a 2-socket Xeon E5-2699v3 box with 256G memory in total. Running 5.18 kernel
>>> with SELinux disabled. Scheduler/MM tunables are all default. Irqbalance
>>> daemon is active.
>>>
>>> Hackbench (config-scheduler-unbound)
>>> =========
>>> process-pipes:
>>>                  Baseline                Patched
>>> Amean   1       0.4300  ( 0.00%)        0.4420  ( -2.79%)
>>> Amean   4       0.8757  ( 0.00%)        0.8774  ( -0.20%)
>>> Amean   7       1.3712  ( 0.00%)        1.3789  ( -0.56%)
>>> Amean   12      2.3541  ( 0.00%)        2.3714  ( -0.73%)
>>> Amean   21      4.2229  ( 0.00%)        4.2439  ( -0.50%)
>>> Amean   30      5.9113  ( 0.00%)        5.9451  ( -0.57%)
>>> Amean   48      9.3873  ( 0.00%)        9.4898  ( -1.09%)
>>> Amean   79      15.9281 ( 0.00%)        16.1385 ( -1.32%)
>>> Amean   110     22.0961 ( 0.00%)        22.3433 ( -1.12%)
>>> Amean   141     28.2973 ( 0.00%)        28.6209 ( -1.14%)
>>> Amean   172     34.4709 ( 0.00%)        34.9347 ( -1.35%)
>>> Amean   203     40.7621 ( 0.00%)        41.2497 ( -1.20%)
>>> Amean   234     47.0416 ( 0.00%)        47.6470 ( -1.29%)
>>> Amean   265     53.3048 ( 0.00%)        54.1625 ( -1.61%)
>>> Amean   288     58.0595 ( 0.00%)        58.8096 ( -1.29%)
>>>
>>> process-sockets:
>>>                  Baseline                Patched
>>> Amean   1       0.6776   ( 0.00%)       0.6611   ( 2.43%)
>>> Amean   4       2.6183   ( 0.00%)       2.5769   ( 1.58%)
>>> Amean   7       4.5662   ( 0.00%)       4.4801   ( 1.89%)
>>> Amean   12      7.7638   ( 0.00%)       7.6201   ( 1.85%)
>>> Amean   21      13.5335  ( 0.00%)       13.2915  ( 1.79%)
>>> Amean   30      19.3369  ( 0.00%)       18.9811  ( 1.84%)
>>> Amean   48      31.0724  ( 0.00%)       30.6015  ( 1.52%)
>>> Amean   79      51.1881  ( 0.00%)       50.4251  ( 1.49%)
>>> Amean   110     71.3399  ( 0.00%)       70.4578  ( 1.24%)
>>> Amean   141     91.4675  ( 0.00%)       90.3769  ( 1.19%)
>>> Amean   172     111.7463 ( 0.00%)       110.3947 ( 1.21%)
>>> Amean   203     131.6927 ( 0.00%)       130.3270 ( 1.04%)
>>> Amean   234     151.7459 ( 0.00%)       150.1320 ( 1.06%)
>>> Amean   265     171.9101 ( 0.00%)       169.9751 ( 1.13%)
>>> Amean   288     186.9231 ( 0.00%)       184.7706 ( 1.15%)
>>>
>>> thread-pipes:
>>>                  Baseline                Patched
>>> Amean   1       0.4523  ( 0.00%)        0.4535  ( -0.28%)
>>> Amean   4       0.9041  ( 0.00%)        0.9085  ( -0.48%)
>>> Amean   7       1.4111  ( 0.00%)        1.4146  ( -0.25%)
>>> Amean   12      2.3532  ( 0.00%)        2.3688  ( -0.66%)
>>> Amean   21      4.1550  ( 0.00%)        4.1701  ( -0.36%)
>>> Amean   30      6.1043  ( 0.00%)        6.2391  ( -2.21%)
>>> Amean   48      10.2077 ( 0.00%)        10.3511 ( -1.40%)
>>> Amean   79      16.7922 ( 0.00%)        17.0427 ( -1.49%)
>>> Amean   110     23.3350 ( 0.00%)        23.6522 ( -1.36%)
>>> Amean   141     29.6458 ( 0.00%)        30.2617 ( -2.08%)
>>> Amean   172     35.8649 ( 0.00%)        36.4225 ( -1.55%)
>>> Amean   203     42.4477 ( 0.00%)        42.8332 ( -0.91%)
>>> Amean   234     48.7117 ( 0.00%)        49.4042 ( -1.42%)
>>> Amean   265     54.9171 ( 0.00%)        55.6551 ( -1.34%)
>>> Amean   288     59.5282 ( 0.00%)        60.2903 ( -1.28%)
>>>
>>> thread-sockets:
>>>                  Baseline                Patched
>>> Amean   1       0.6917   ( 0.00%)       0.6892   ( 0.37%)
>>> Amean   4       2.6651   ( 0.00%)       2.6017   ( 2.38%)
>>> Amean   7       4.6734   ( 0.00%)       4.5637   ( 2.35%)
>>> Amean   12      8.0156   ( 0.00%)       7.8079   ( 2.59%)
>>> Amean   21      14.0451  ( 0.00%)       13.6679  ( 2.69%)
>>> Amean   30      20.0963  ( 0.00%)       19.5657  ( 2.64%)
>>> Amean   48      32.4115  ( 0.00%)       31.6001  ( 2.50%)
>>> Amean   79      53.1104  ( 0.00%)       51.8395  ( 2.39%)
>>> Amean   110     74.0929  ( 0.00%)       72.4391  ( 2.23%)
>>> Amean   141     95.1506  ( 0.00%)       93.0992  ( 2.16%)
>>> Amean   172     116.1969 ( 0.00%)       113.8307 ( 2.04%)
>>> Amean   203     137.4413 ( 0.00%)       134.5247 ( 2.12%)
>>> Amean   234     158.5395 ( 0.00%)       155.2793 ( 2.06%)
>>> Amean   265     179.7729 ( 0.00%)       176.1099 ( 2.04%)
>>> Amean   288     195.5573 ( 0.00%)       191.3977 ( 2.13%)
>>>
>>> Pgbench (config-db-pgbench-timed-ro-small)
>>> =======
>>>                  Baseline            Patched
>>> Hmean   1       68.54    ( 0.00%)   69.72    ( 1.71%)
>>> Hmean   6       27725.78 ( 0.00%)   34119.11 ( 23.06%)
>>> Hmean   12      55724.26 ( 0.00%)   63158.22 ( 13.34%)
>>> Hmean   22      72806.26 ( 0.00%)   73389.98 ( 0.80%)
>>> Hmean   30      79000.45 ( 0.00%)   75197.02 ( -4.81%)
>>> Hmean   48      78180.16 ( 0.00%)   75074.09 ( -3.97%)
>>> Hmean   80      75001.93 ( 0.00%)   70590.72 ( -5.88%)
>>> Hmean   110     74812.25 ( 0.00%)   74128.57 ( -0.91%)
>>> Hmean   142     74261.05 ( 0.00%)   72910.48 ( -1.82%)
>>> Hmean   144     75375.35 ( 0.00%)   71295.72 ( -5.41%)
>>>
>>> For hackbench, +-3% fluctuation is normal on this two-socket box, it's safe to
>>> conclude that there are no performance differences for wakeups from task context.
>>> For pgbench, after many runs, 10~30% gains are very consistent at lower
>>> client counts (< #cores per socket).
>> Can you provide some further insights on why pgebench is helped at low load
>> case?  Is it because the woken tasks tend to stay put and not get moved around with interrupts
>> and maintain cache warmth?
> Yes, and for read-only database workloads, the cache (whether it's 
> incoming packet or not) on the interrupt
> CPU isn't as performance critical as cache from its previous CPU where 
> the db task run to process data.
> To give you an example, consider a db client/server case, a client 
> sends a request for a select query
> through the network, the server accepts the query request and does all 
> the heavy lifting and sends the result
> back. For the server, the incoming packet is just a line of query 
> whereas the CPU and its L3 db process previously
> on has all the warm db caches, pulling it away from them is a crime 
> :)  This may seem to be a little contradictory
> to what I said earlier about the idle case and Mel's patch, but 
> ¯\_(ツ)_/¯ it's hard to make all the workloads out
> there happy. Anyway like I said earlier, this patch doesn't affect the 
> idle case
>
> At higher load, sync in wake_affine_idle() doesn't really matter 
> because the waking CPU could easily have more than
> 1 runnable tasks. Sync in wake_affine_weight() also doesn't matter 
> much as both sides have work to do, and cache
> benefit of not pulling decreases simply because there are a lot more 
> db processes under the same L3, they can compete
> for the same cachelines.
>
> Hope my explanation helps!
>
> Libo
>> Tim
>>
>>> For higher client counts, both kernels are
>>> very close, +-5% swings are quite common. Also NET_TX|RX softirq load
>>> does spread out across both NUMA nodes in this test so there is no need to do
>>> any explicit RPS/RFS.
>>>
>>> [1]:https://urldefense.com/v3/__https://lkml.org/lkml/2021/11/5/234__;!!ACWV5N9M2RV99hQ!PTDVWQJ1pb2KldrRnXA3EJ2CPKyHAolke1QRjVLadEl2ctd3xYxTo5uZ5Dp91L3ExImjbrrqbNM27uEA-E9do7LM$  
>>>
>>> Signed-off-by: Libo Chen<libo.chen@oracle.com>
>>> ---
>>>   kernel/sched/fair.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 794c2cb945f8..59b210d2cdb5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6704,7 +6704,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>>>   static int
>>>   select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>>   {
>>> -	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>>> +	/* Don't set sync for wakeup from irq/soft ctx */
>>> +	int sync = in_task() && (wake_flags & WF_SYNC)
>>> +		   && !(current->flags & PF_EXITING);
>>>   	struct sched_domain *tmp, *sd = NULL;
>>>   	int cpu = smp_processor_id();
>>>   	int new_cpu = prev_cpu;
>>> --
>>> 2.31.1
>>>
>

