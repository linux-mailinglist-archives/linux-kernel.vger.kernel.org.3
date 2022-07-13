Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1899573F12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbiGMVhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGMVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:37:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA372A266
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:37:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DJDpNQ009860;
        Wed, 13 Jul 2022 21:37:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=93cEFZPjpWiOrqTk0FXkK8dpN2jpaHG7orAPfFHjixw=;
 b=bjl/XajS06V1SL6pI0B0pXQnacIveTQz3fJJjO+w8v4qeYLstBjyRO+tIfdMEdTOjqh6
 FfBLEfoGWSsCVCuViIgp30lqOf6+JoHynZ9SmPcLaa7QBXmiEotVYxdPP36t/OSDEmrr
 Jg7Jr+d2kXc2Oxlvt7WTfyQjrBtEjN4JSSJy9TBDE4mFe1rV0DxPG5UcPAdKYSj/G81X
 Xr6JKd8Im8djhg2aN9dB6qKJAX1VxNBkKadsZkLNtdga/9mB/kXVVyVfEFZN3WocgG0I
 hB0Lb64O8a0qqdgudc8ijpyv6ei22JF0xHt6n1nP4/A7jIM13tcHuAJKCsth3ozjhRkL Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1b3m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 21:37:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26DLKGKT037416;
        Wed, 13 Jul 2022 21:37:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7045jtpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jul 2022 21:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0OvIjonzI3nQMD1CsAK8Z0tSXv9F1etVEsqAqLbVZhw6gBSsJH7e+DjQdMtmXPA0fJfNbm+H50wqyXo3fD9pfEXxVajiCUYB4LittupmxgeANxeRoZEv5ZOO1ayRa/rpA21z4A1ftnwyGeoDWysI5ukakEc0imhkO1bHZ0d1H0ysuQ7XJaN5cv09eeHaBB+biwt6WC1bBvZeQVLbnxFppuIt/P8z7X9eze95C51GqwFQps8IDehlmXFGRPs6xvLIVqdk9pDeuaLZ8f6e3gf6ym3hUctWyQjZLQnyaSMDQIKgjHJfwziFA8pYoBFs9/Do2TKtO+iXL6Ph+Y19Mp0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93cEFZPjpWiOrqTk0FXkK8dpN2jpaHG7orAPfFHjixw=;
 b=JmsYQFbn+DbiguPY2ojmviTBteTy7wZPG9HzzFD1s15CqsaaGW4PHZTuaXgWXO3bnga5aN/8DXPPlMs8CEj0Qd79mGDEHEZGr9xa7DLIPPvwsb2xkl6BXlUzuJs/BJvwEBAl8Si9Fm80lI2MzZCZt7jsF5O6B2LgOGB3E0UdNIUDs4FlMyIixNQh9jyvpUUPl/nOeE9JTw7QlLLC+UtIXGv63bF6Cz49S4NJss3CcXNUvEnEVa8V/swbbMKbEmaBsMmGbZm/XURk+VbWAaXUOgiKAxBDe6EHSsyIxicStLsuHgDJVT6BN7BUzxQmYfnZqxyCwZCG2i+gIiRbOR7Lxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93cEFZPjpWiOrqTk0FXkK8dpN2jpaHG7orAPfFHjixw=;
 b=Vfn/JZ07z5+wBhiSewRNOYhx+ZlU9VM29Ab+bRpltVAVznvCah09PWva7JpWngshPz4bJB5eqvbPeCJq0nYZRaAMt4CDzTfvuBqIaMQ/MKnaHDLIYp0CjCcHjf3xhgDyrQmGqy+RVXDr3urVQlohINFX9b3DvQazQWV9vystjYI=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by DM6PR10MB2906.namprd10.prod.outlook.com (2603:10b6:5:6f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 21:37:27 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 21:37:26 +0000
Message-ID: <fdcc81b3-3d60-d090-de25-e2583d43daa4@oracle.com>
Date:   Wed, 13 Jul 2022 14:37:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, mgorman@suse.de, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
 <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
 <ff27aa3bce81a4f9cdf9e71b989af7db5b0fa44a.camel@linux.intel.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <ff27aa3bce81a4f9cdf9e71b989af7db5b0fa44a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0169.namprd05.prod.outlook.com
 (2603:10b6:a03:339::24) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8173b4f-7ca0-415a-6104-08da6517e165
X-MS-TrafficTypeDiagnostic: DM6PR10MB2906:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiSkwbUn8x3cNQ5C+5eSpO36wXZNYWN6nSOiEnmCwswnCWFheMUls5itgWUoYVFwkx2xrP8ezMGBwSr9v7d1QGYYBwziS13WfbpYXHeTkS1Qfkp2GkJuM1NEroybhLFYa/CV3fiHLsU3nZKMUeG5aKgy0JM6Aqf23EaTEeNlfwJ+qbCklLEZeiyu8RF4zPZBtfVfOtpVd/vb9vFO3RWM4gsiRsDWNgaKwtZPCAaFpK6DMIsg4EYV4/O15q50Q6lnpPPgqq+h6HZxaBHWWc3L5iUJuv0CuI2F128lOvay2J31/K1ho1JH1iXMfquY8EVjl8H6dYT4Zg7hEo/K6gvEvWgNHJAgJ+xcZHNxD8LE9iDzMqMotHuLQ0dhYHV9Iag87jtaU7h70ty65RqpRlgKH3NxBcM3QGaXQDDSDDaxruA8I8RKMHIEhLXNEJpxHuGZJN+N1aGz1NXAZTJEnqa88m1t4cjL02eA8E7T9NeyxZXdClY+fsZGKy4TMGen5/H4drJ6PcSwwYiIBPL9XFVfMYt2TDUUlC6AHgJ70aiCw/A8ZsKDH83Uk1wW3kbKCDYbdF/prupJiEJs4rB7mm1t3/CAzlTnj/am6idXPEvjTAF61plgLNuVTxk7L3E//37WCKy9bzDNQkdfDvYvWOTFZTYWOgaI4ibfD/NQh/83M1G1OLQLRF/ih9hXi2yUSswGTOJpP2OHHhiR9TnINVGbSsSvUnjUDKLupP8oEQqZgHvQEB066zkS54ixwidvp++qm8GFpLPlzwGFfuUo6Zjh6UVUiALFeijHOPKN37WeoIk8QBjfGJE5jM6BFUN/WMyRmJcvHRllTzgrXvfXeaH18QrQ4+2l0u6ESw3Mo246E1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(39860400002)(366004)(346002)(4326008)(53546011)(8676002)(316002)(86362001)(6512007)(186003)(52116002)(66556008)(66476007)(2616005)(31696002)(41300700001)(66946007)(6506007)(6666004)(2906002)(478600001)(6486002)(31686004)(8936002)(5660300002)(83380400001)(36756003)(38100700002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9qdTh5M2ZKMUJqajJNOHlVUG1YMmtFWXdtOU02SlFqNzFxM29Vd1ZDa1JB?=
 =?utf-8?B?MUFTa25CUXdKeGtwbVZUSTI5dGNNRE12MWs0aHQyWU1sQzErc2V2VU5EZm9x?=
 =?utf-8?B?Vm1aelpRM2MzblhLNEptaGozQnFPUjU5bnIrazNZSEN6OGJ4aVlMblhydzJl?=
 =?utf-8?B?QVM1dGtwY09tWnBDNHRtU3YzV2ZMbXZlK1poQ3VJWFcwL0RMQVZTd3VBdi9P?=
 =?utf-8?B?TXI1K0RyTnZocjd2cWdoTGxOMjJBTGZXcUN6MUk4QnVjMFdZYkVsRzkvcUpZ?=
 =?utf-8?B?STBkcmh0d3dGL0l3dEoweGVuejVUcUZVak5ua0JpS1NEU25nOERqd0NscFg3?=
 =?utf-8?B?N3BEZnlhRVBWNXAwYlo0bUNiZjcrRmVIS1E4WitUTkliUFZPQng0OW5xN0U0?=
 =?utf-8?B?Tm5GL2ttc0RHdTk3QWh4VHZHUUhUWllUVG9PU052cklVS2orRkVYT1dpUFAr?=
 =?utf-8?B?S05lVmEzWVdyVU1WcEVzWC9jc1BTU1hNekNZdGdhRzdVSXlhZ3ZLOStpeU5U?=
 =?utf-8?B?TTBlOTJaalRWc0dzMWgxM2xuMjg5TjhJQzA1dGxwaDU4QWs5STExL3RaRTkr?=
 =?utf-8?B?eURKQmRXSmxIbnBrYXd2Z0lxajBhV1RNbGc3L1VpcWxvN2E4OTQvNnovLzNL?=
 =?utf-8?B?ajkzR0lwc1FOR0VHNnZZcmpFU3RPQUtFSVJHWUJxTlhJRWU3a0JndWlkd3Zx?=
 =?utf-8?B?NjVWK0V4ZlgzUjR2WEZ2WXI4NjRJQ0lhRU9kQkJDNng4ZTY2S0ZsODB1T3Zj?=
 =?utf-8?B?ZVZaUlJhWWQwV1hCQW5UcmZuVnhnRjNlenlxcnRob3BKNUdFcEcvMzlFOXNl?=
 =?utf-8?B?T3JWYVBzSTJPVlJHNUsyb3FwZEFRbWlGTDNuQWRONWJMUURacUhiRjBEczdk?=
 =?utf-8?B?aG9RTmprSE12elVLSTVXWE41cnlza2UrZFZ2TU5WdG9tVmpWZHoxZDhqS0lL?=
 =?utf-8?B?a2wxV2QrdkM1VXhHNlFVRGxIYjExUVJscGxTZzJDRDQzd0E5Qkx3Tzg1dWl1?=
 =?utf-8?B?K2p5SWgzL0NXSEd3dTV3WHJrR2FhUE50NktPd0xuSHBlUk15RjZFL2gzN0Jl?=
 =?utf-8?B?ZXdaR2JoTGNXL3E3c3lQWmpxa2FncUhxcktVcUdIRTY3aGhzcHZURWlZOUQx?=
 =?utf-8?B?YkIyMnRicTY3RnJ4REtiODAzYW1yZ05sbkpWTWFwNHV0R1owUFZyWlY1Ulgy?=
 =?utf-8?B?U0ZONnY2cTI2L3ZhOVNoWnZkZWZlQmZzN2RwaWh1N0s1VTN1cUZBOGszQ2gw?=
 =?utf-8?B?dUlWRlF3eUQ3dGNZTjRwUVQ0QmhjOG55WkZpY0dxYVJRUVF4OXBBaWE5SWpJ?=
 =?utf-8?B?UmZVU3ZaVWYvcnZJRXBXYVUwZHNVb3l1djFnbjdBRjNEZk1tNkMvTDF1Y2tO?=
 =?utf-8?B?SEt6QnZNRTlnaHkzMnpKOFFndUhHN0RmWWJjbUV0L3VsRnZjN3g5L3NpMHM5?=
 =?utf-8?B?eEVIaFdrTEdnZU9RZGpiWE1LS20xcEdITGU4KzFaZUN2Yk9QNlI4bGMvcHNE?=
 =?utf-8?B?a2ZxaWtsc2ZZZmc1MVZPNm9xb1VrMWJpajRYNXFUVG1mYzJtK2RpL2lPZFo1?=
 =?utf-8?B?V0JGUWFlS2JvYXhxbUFKR1o1UzhJV2RJL0hYdU8rSlA1MVU0alNsMTdXMkRJ?=
 =?utf-8?B?OTBPZlVpQ1d2ZVQ5LzV2bFQwY3ZDMTJZVVBCOFh2YStmR09NRzM3N2paUXFI?=
 =?utf-8?B?UlQ4SFNDMkNrMENxV0ZiTWcxbm9OUWw1L3NSTUdSWGtXOEd6NzVMODZXTmIx?=
 =?utf-8?B?UDViYnRyYWFTOVphbEFMRVc3S2s4cWhZSC81VkFEdG13VUVQSTBzNG4xbU5i?=
 =?utf-8?B?eDQ5WWpwTGkvV1pCcGlrN1hOSERGU3VUdDRrVnlSd2ovcWRLaXN2UmF1N1BX?=
 =?utf-8?B?djlSRllKaXBka0JnV3dhL1RvRjN3N0VUUVo3MXhDWjd3a3MvejZhQlFBUlNX?=
 =?utf-8?B?WnlNdW9XcjVFUmplK3d5VHhLNSs5ZmVEMndLc0tOU3lQc3hQQ3hIYTZ0aE5M?=
 =?utf-8?B?TFByd0x2anRCK1NWek1oTXo3M0ZYc2ZsajNQUVJkWkJwRTJqeEMyY3BUOS9M?=
 =?utf-8?B?OTVSZi94bG52MDNUdnhuVVdJeUw1WWtOb0dxNWdSb0Z3TnZ0U09FM2JwOTZO?=
 =?utf-8?B?OHphY2JlMHloNndERGZ2aUQzUGlWd3pYWFgyR3VQa1R3eEhhbGxkYVI1clJN?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8173b4f-7ca0-415a-6104-08da6517e165
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 21:37:26.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdsFvxtYNzWRT1/zgup1Tb9jxZnq4IJr+66SsECcTNu5/7UyuTNzMSdLATYkCOmKDg5gGtJGHzLXmdZOqakCyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2906
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-13_11:2022-07-13,2022-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207130089
X-Proofpoint-ORIG-GUID: -n9Jg8PnxTDnX46ukUMrJvX30ieb_Bs7
X-Proofpoint-GUID: -n9Jg8PnxTDnX46ukUMrJvX30ieb_Bs7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/22 13:51, Tim Chen wrote:
> On Wed, 2022-07-13 at 12:17 -0700, Libo Chen wrote:
>>
>> On 7/13/22 09:40, Tim Chen wrote:
>>> On Mon, 2022-07-11 at 15:47 -0700, Libo Chen wrote:
>>>> Barry Song first pointed out that replacing sync wakeup with regular wakeup
>>>> seems to reduce overeager wakeup pulling and shows noticeable performance
>>>> improvement.[1]
>>>>
>>>> This patch argues that allowing sync for wakeups from interrupt context
>>>> is a bug and fixing it can improve performance even when irq/softirq is
>>>> evenly spread out.
>>>>
>>>> For wakeups from ISR, the waking CPU is just the CPU of ISR and the so-called
>>>> waker can be any random task that happens to be running on that CPU when the
>>>> interrupt comes in. This is completely different from other wakups where the
>>>> task running on the waking CPU is the actual waker. For example, two tasks
>>>> communicate through a pipe or mutiple tasks access the same critical section,
>>>> etc. This difference is important because with sync we assume the waker will
>>>> get off the runqueue and go to sleep immedately after the wakeup. The
>>>> assumption is built into wake_affine() where it discounts the waker's presence
>>>> from the runqueue when sync is true. The random waker from interrupts bears no
>>>> relation to the wakee and don't usually go to sleep immediately afterwards
>>>> unless wakeup granularity is reached. Plus the scheduler no longer enforces the
>>>> preepmtion of waker for sync wakeup as it used to before
>>>> patch f2e74eeac03ffb7 ("sched: Remove WAKEUP_SYNC feature"). Enforcing sync
>>>> wakeup preemption for wakeups from interrupt contexts doesn't seem to be
>>>> appropriate too but at least sync wakeup will do what it's supposed to do.
>>> Will there be scenarios where you do want the task being woken up be pulled
>>> to the CPU where the interrupt happened, as the data that needs to be accessed is
>>> on local CPU/NUMA that interrupt happened?  For example, interrupt associated with network
>>> packets received.  Sync still seems desirable, at least if there is no task currently
>>> running on the CPU where interrupt happened.  So maybe we should have some consideration
>>> of the load on the CPU/NUMA before deciding whether we should do sync wake for such
>>> interrupt.
>>>
>>   There are only two places where sync wakeup matters: wake_affine_idle() and wake_affine_weight().
>> In wake_affine_idle(), it considers pulling if there is one runnable on the waking CPU because
>> of the belief that this runnable will voluntarily get off the runqueue. In wake_affine_weight(),
>> it basically takes off the waker's load again assuming the waker goes to sleep after the wakeup.
>> My argument is that this assumption doesn't really hold for wakeups from the interrupt contexts
>> when the waking CPU is non-idle. Wakeups from task context? sure, it seems to be a reasonable
>> assumption.
> I agree with you that the the sync case load computation for wake_affine_idle()
> and wake_affine_weight() is incorrect when waking a task from the interrupt context.
> In this light, your proposal makes sense.
>
>> For your idle case, I totally agree but I don't think having sync or not will actually
>> have any impacts here giving what the code does. Real impact comes from Mel's patch 7332dec055f2457c3
>> which makes it less likely to pull tasks when the waking CPU is idle. I believe we should consider
>> reverting 7332dec055f2 because a significant RDS latency regression has been spotted recently on our
>> system due to this patch.
> The commit 7332dec055f2 prevented cross NUMA node pulling.  I think if the
> waking CPU's NUMA node's average load is less than the prev CPU's NUMA node,
> this cross NUMA node pull could be allowed for better load distribution.
Yeah, we should rewrite wake_affine_weight() so that it compares average 
loads of two nodes
instead of two rq loads.


Libo

>>> Can you provide some further insights on why pgebench is helped at low load
>>> case?  Is it because the woken tasks tend to stay put and not get moved around with interrupts
>>> and maintain cache warmth?
>>   Yes, and for read-only database workloads, the cache (whether it's incoming packet or not) on the interrupt
>> CPU isn't as performance critical as cache from its previous CPU where the db task run to process data.
>> To give you an example, consider a db client/server case, a client sends a request for a select query
>> through the network, the server accepts the query request and does all the heavy lifting and sends the result
>> back. For the server, the incoming packet is just a line of query whereas the CPU and its L3 db process previously
>> on has all the warm db caches, pulling it away from them is a crime :)  This may seem to be a little contradictory
>> to what I said earlier about the idle case and Mel's patch, but ¯\_(ツ)_/¯ it's hard to make all the workloads out
>> there happy. Anyway like I said earlier, this patch doesn't affect the idle case
>>
>> At higher load, sync in wake_affine_idle() doesn't really matter because the waking CPU could easily have more than
>> 1 runnable tasks. Sync in wake_affine_weight() also doesn't matter much as both sides have work to do, and cache
>> benefit of not pulling decreases simply because there are a lot more db processes under the same L3, they can compete
>> for the same cachelines.
>>
>> Hope my explanation helps!
> Yes, that makes sense.
>
> Tim
>
>

