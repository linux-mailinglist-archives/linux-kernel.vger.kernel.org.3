Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133BD575648
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiGNUWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiGNUWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:22:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA94E65D67
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:21:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26EJd5w2013215;
        Thu, 14 Jul 2022 20:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rUUEVo6iktesGXmpygYWo7oo7fn9zrEW0UhTUt3NGbY=;
 b=YBw2UK+NQR6GzirmGiPKKKeL6lPuarwHMz/xApZq8zZqEwYgsREdqTOcy9RBqK/SFEqu
 2YKcXGLZ+Xqvjl6Gqf0aaoTunPV3NztssnuRhMLWc+4Eq3GIwMAFB5JDU04O+vmg2ear
 Uu0CFs1kHwrp1ZKilszPPr5WlPsOIB9CWtI2NRaphumPMUAMIbjg9r4OwkNWusHwUIGD
 Vvg2XrTSjL1hy+DHHvEceRoYmkWvyDkevBNOXfmaC+CR4drk8zsD2LnhfEn3pYannkAF
 F9nkp9mP2Vf9sR81EjYbalr31yZ+dfbguLHBhjOLOAMEK/XyfUZn2n67RuChPR2bISOK Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71r1dsu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 20:21:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26EKBfQ9027807;
        Thu, 14 Jul 2022 20:21:26 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2049.outbound.protection.outlook.com [104.47.51.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3h7046sg7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 20:21:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2eZKhfx4hPzmdoQeslMa9SZ47gh/7WVzLhPHBf2ibajo1UWqV/oLlhccOhOuXEmJP3aiS2uE4IrmwiP2ap/3It7m7XIk+pkhIsz3HsXZu8/9y9EC8b9JANqqH/cb7BVbv0s4IQjkBDMol35YEC/sutVyyow4n0D1hQGv6FPMzrgMl1XkgP2p7d8hKYnufgoxEAyBkydEHQnMNssUrXFBiLxCMi5rSGjU6FqrDod4h1idEDsdG+R5FlbdqwOF54183/s9JB7meYtyzKTc1uxgTd/LDNYxqtwrqiH1OkkvxcPhbFaIF3841+/HYDy3at57mN+cSqqWOtTXXi0jJTdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rUUEVo6iktesGXmpygYWo7oo7fn9zrEW0UhTUt3NGbY=;
 b=mchcXVUqvMahreuY3Z5wGrsih9LS/XIUUCVF0wyeTCtZHgnuW7oHBGc2V75+0h9siSW+fuCNdHnIbn1/OdbDyCdUbMGZs3tJj28PLO6Uqc+2dnOyP2iDDgg8gb0xCP40d6mg0uFGxESo2sz3M1oK/a15QULzuercYnWSTp3A5Lc8HXkD6Is2J6H82/lOfUTaiD5tNKNDfua7TdhNODFJ92jEpsM6KJdyhIUoajsc5GFo/8mONAt16I9EoA3qScxMOLw3uhm0FvF0KdaVRbbqLTWfPoco0NHMsawvyu/Na4QtVzEpEcQ7GgjrgEvBsj5Zq17PMK2uo899yHlMBZvHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rUUEVo6iktesGXmpygYWo7oo7fn9zrEW0UhTUt3NGbY=;
 b=lT7KS19+OlSYThVLGcZyH6S6OqS0M5NLMXTOHhDYN1/4BuGmLvq8CSrGP1RD/53lD19lTcf6uKnjEwbULcG2AKRkVDe8R2wz8Zlso+SaHQLG4XLC26V4S84mQC+uPp0X9767PYiMRrs2KuLItQTylpIYNPoffJkI77aVJRurDuI=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by DM5PR10MB1292.namprd10.prod.outlook.com (2603:10b6:3:d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.20; Thu, 14 Jul 2022 20:21:23 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::2913:8783:edc2:af11%7]) with mapi id 15.20.5417.033; Thu, 14 Jul 2022
 20:21:23 +0000
Message-ID: <0c0dab83-807d-317e-af1a-7bd898626b86@oracle.com>
Date:   Thu, 14 Jul 2022 13:21:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] sched/fair: no sync wakeup from interrupt context
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>, peterz@infradead.org,
        vincent.guittot@linaro.org, 21cnbao@gmail.com,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20220711224704.1672831-1-libo.chen@oracle.com>
 <2c0c61a1c4c54d06905279a9a724a9390d9ee5c3.camel@linux.intel.com>
 <0917f479-b6aa-19de-3d6a-6fd422df4d21@oracle.com>
 <20220714141834.GC3493@suse.de>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <20220714141834.GC3493@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:334::15) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21257ef8-cee8-421e-063a-08da65d66bf3
X-MS-TrafficTypeDiagnostic: DM5PR10MB1292:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InG5WnyoutKRuOMNGOAa9eJh1DbS3+5xNWKWDwpruHGAsvtY1ewbfWR/pYAcmiKqR+j1uXWnce/JY1f2qwsYKmQOQN+obwjSllZ/JOuGKlH9Ho74KTS4sRdH/z+3ZSF851ox7ZruH0lLhg7ZhlaL68LR2zRoKjIFVQmFvAFnsYVysNtDKf7B7gHvOIbZnd8C3klk9hOGuclscbNtSsX4/a1/b9JAmD7PDTMuoowkqepmh1c5tgSHXdZFtDMbMtSdpKjLabkMTZPuz6Z0SV8hF2/9FuFwPl+I/H01Hsoa1R1v0/+DsViwsNmYQfKdugepjXsOX7dlv+ypX217UfqGlSTAB36o9WtAigYQKqqpMnpCUB1eeenVmzV5au+tR2ycGFdn+A4llygk2sbSIe9P6kDsFtZCfvJibN6hG9MArbRMioPzEqnXBWa222zdHgUYR6WRjwNYWWi/+/K9c/Q9vbTxmZOlxtqzqIrj81Xvqrdi6Lc4nA9T/SWQfy5sdQGqcM3OBGIKgyLj0NbMtCQmf92mUcSML9iHGsxrE6W7uZGRMou3JOb9ggYIRpR3UuhqUewNv5v5WV0g8shcxJA1Yz9mpASlwLGFDxXzAUIYQIPC4YA+d9nYkI9flLslgM+cMyNofHWyG2wOrXdZ4uQ8JXRYo57D1L96zdS+uxs0wHOdzala1iSgEfXh60LoWpZSu52qu0H+nX5rmzXl7R4RSr+98YPytNmfK1Sbrzf9zlsVxx+5Ek9XQ7ez4EToEU3hex8T3TlnhMJO6/aSjeC/we4iZUmrBunJmyO1G/P/5tugTaBw+J0OdE5nv0Q9GPQp+tRgtDg4vWXeq3HvSmZXAzEwqPs8XDXiCadc2/afG/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(376002)(366004)(44832011)(2906002)(8936002)(5660300002)(4326008)(8676002)(86362001)(83380400001)(31696002)(36756003)(38100700002)(478600001)(6486002)(6916009)(54906003)(316002)(66476007)(66556008)(66946007)(2616005)(186003)(107886003)(6506007)(41300700001)(52116002)(53546011)(31686004)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtNaDg5alNQRExUU2lNMi9GOHMvQzdZTU8vZEUrRnNyT0pYQXlTc2tmSXln?=
 =?utf-8?B?RHR3SVluL0RPY0M1azdXRVI3RStQWE9mVStSbFZ4amNKK3dpOUFlSGEybk1a?=
 =?utf-8?B?Z3NlSHBQOStSWXR0VHZ1b3NKMjhpMDBXODFUU1pCcXByZXFPVGZYc3g4ZVRp?=
 =?utf-8?B?NE10TFJha1d6SjdTOC9pTEllZ1J5bmQzbWdLVGRYR21qWUxaSDVKTHlTZWFz?=
 =?utf-8?B?eFhKKzEyMzVhS3I3T3Q2TG5ZSVphMDlHLzJaeUtDSkVqUm03RkEzWGcxYVdY?=
 =?utf-8?B?MTNnSzZSYVE4cWFRbWxEUXB5UG9PSStCRzZsMTFDZ1FMMnp5WDBUOUJGZWlt?=
 =?utf-8?B?MDkzOEpSZkRhM2ZXSTVRL1UzYnRWbzlhaEUwVVRWanFHK1oyYVArUndLQ0Jx?=
 =?utf-8?B?cEJvWVlhaGRCMFIrVnNPeTZyYXk2eEUrQ2IxdndJaHE4MjNXMFV5SkJxVTEy?=
 =?utf-8?B?NUMybTJiZ01FdVB5Vy90YXVqWnJuTThMNXJrMzk2OEYyQ2N1b25UelNaS0JR?=
 =?utf-8?B?MkM3ZkRMNDhRakJaOFlwOEd3ekhoSDVVMlZyZmR3a1VmNWdRaW1oT1Qzckhm?=
 =?utf-8?B?OW82L2p1bWJOSWpld0p0TGNiaGdBRzFiVFQwemJhUWlYRitoNkFGclFZV0hB?=
 =?utf-8?B?NW1tanpienhKbG1CL1ZBdUdLWG5Gay9TdklVRDZNRHVjY2lzb1R0em1uOVIy?=
 =?utf-8?B?Q0cwdDhXZC9yT2tOTXZJTUNzMlJRU000ZFI4eDdoZFlTS0lWSzN3MmNtWUlX?=
 =?utf-8?B?UWlSemhZZDdudkhEUjdndmQxQ3NyRDdNWHc2ekoyaG0zVkFkVE9JWkNKM2Er?=
 =?utf-8?B?d1BTU2RGV29WNmdZY1VadGlpdEhVYlF4OG9RUW00bndlWlp6SUhFNHlvTHlN?=
 =?utf-8?B?YWhETE4vSjZxQjNVNEZUeFZNYVdldG1IUzN6Sit3L0ZtNHliTThPUWxWRm9a?=
 =?utf-8?B?U2hyNDNTS2s3cEZhVUcyUkJOZ1QrczRZOVJaOThoZ0FVOXB4N3pRL0U3OWps?=
 =?utf-8?B?MlRFMFFJSGt3ZzJ3azNvQXFvZXJlS0VMam5UL2gzSTJKL0pNSGFvUG03T0Rx?=
 =?utf-8?B?cGRmdVdnaHFtVnNlcHZ5c2xacHE3WVRCVDkyYlNNZDEzZFZwYVZCa1dqRjdF?=
 =?utf-8?B?R0I1SExBd1huUk81QzZaM08vaXdidzNRcTVwTFNZY0FJMW8zRGhzSHV0dVJX?=
 =?utf-8?B?YzJ0KzZZZjlaUUg3MjlKajUzdzhjaVRkNThhTzdidUdjSUlUaDhtUkRibHdC?=
 =?utf-8?B?WkdMMVRLVG1ySHEvK0ZremwzaVZVdFR4QmNEQmowdWF0V3Vxb1NwNUM4OFlz?=
 =?utf-8?B?RlZxS0tlZ3hzdmFoTGZaZU1wNUJ0K3V6aUUya0wvWDRIcUFTUVE4aEE0UkJV?=
 =?utf-8?B?bmlsS0tpMThueXJTZDd3R0JXM3drdEQ4UjFLM0NZajE0WGJ5cVRINjExZEtv?=
 =?utf-8?B?SDZ6MitSdnlkQlhydTUzK2pnYk1VNkV6a2kxU2d5LzRRNm51KytLTG1jTnVJ?=
 =?utf-8?B?cTRqN2Q1a3EvNkR4VVZ6Sm1jcEkxOVJFVENsOEtvWVRCbW5TdXM5M01yRjFS?=
 =?utf-8?B?OGxYL3pmc3JtRnIwcG5jazFKOVlidmFwbWhaOERUREpuOHdZSUZRc2xUbWE1?=
 =?utf-8?B?cy9CRWowb1pwUlJEZFRMd1VtVFdZeWN4RG1ad3graHVPY280cVo1U3I2NkU3?=
 =?utf-8?B?M2lCK0w2WXlGczFucFNONWMwd0xScmRQbnBCTjMzTVc5Q2wwYlRJdkt5NVYy?=
 =?utf-8?B?cm1wQ2JqY0ZSd0RoYjQ0M1hHUnVjRUV0MnFSL08xakhXdEN2NTNwMjdzdm5W?=
 =?utf-8?B?ZW41bVBtSHJVTDNXb3BMell6MGY4aFVlRzFmRFMrT1dNTEY1dUlkbDY2Z25y?=
 =?utf-8?B?TUJhTEw2cEFydzhZeHZGNHMxTFBCOUhCREYzMHhEVDQ4dnVZQjVvbThOcXJL?=
 =?utf-8?B?aDkrTnlJRy9mMXZxa1pKL1MzL25SUUVpNzV5ZlM2TXJWUmt1UkhhVm5nUFVM?=
 =?utf-8?B?eHlTcU5IRXhxK1VsUG5nSTNGVnNWZllpazR1VlkzNjJsYi9USUdEaDBLQ1Bo?=
 =?utf-8?B?cWlNWE90bzc3RndwZ2EvbUFuaFVYZit0TE1raFRLb29WN3d6cDlmdjcvUEJK?=
 =?utf-8?B?TmE2VGZBOUF6NzMzejZhQW9HcjkrVFFoKzJQVkMzdWxReDc5RXR3S05UeUd3?=
 =?utf-8?B?OXc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21257ef8-cee8-421e-063a-08da65d66bf3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:21:23.6091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxL+0E6fhYc2BTR6+b44iUCPmt47F79cAD3XyPpyVQpn+i+hcuow9mLsdolnWd0INw46D053xMElCpVez+7JwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1292
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-14_17:2022-07-14,2022-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207140089
X-Proofpoint-ORIG-GUID: vhKnw3G7qiL5PWrwp33VU6OCmm-BstXH
X-Proofpoint-GUID: vhKnw3G7qiL5PWrwp33VU6OCmm-BstXH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/22 07:18, Mel Gorman wrote:
> On Wed, Jul 13, 2022 at 12:17:33PM -0700, Libo Chen wrote:
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
>> There are only two places where sync wakeup matters: wake_affine_idle() and
>> wake_affine_weight().
>> In wake_affine_idle(), it considers pulling if there is one runnable on the
>> waking CPU because
>> of the belief that this runnable will voluntarily get off the runqueue. In
>> wake_affine_weight(),
>> it basically takes off the waker's load again assuming the waker goes to
>> sleep after the wakeup.
>> My argument is that this assumption doesn't really hold for wakeups from the
>> interrupt contexts
>> when the waking CPU is non-idle. Wakeups from task context? sure, it seems
>> to be a reasonable
>> assumption. For your idle case, I totally agree but I don't think having
>> sync or not will actually
>> have any impacts here giving what the code does. Real impact comes fromMel's
>> patch 7332dec055f2457c3
>> which makes it less likely to pull tasks when the waking CPU is idle. I
>> believe we should consider
>> reverting 7332dec055f2 because a significant RDS latency regression has been
>> spotted recently on our
>> system due to this patch.
>>
> The intent of 7332dec055f2 was to prevent harmful cross-node accesses.
> It still allowed cache-local migrations on the assumption that the incoming
> data was critical enough to justify losing any other cache-hot data. You
I am not too against cache-local migrations here because they are still 
under the
same LLC. We really focus on cross-node migrations that sometimes hurt us,
sometimes don't because this is where you need to determine who has the 
warmer L3
cache.
> state explicitly that "the interrupt CPU isn't as performance critical as
> cache from its previous CPU" so that assumption was incorrect, at least
> in your case. I don't have a counter example where the interrupt data *is*
> more important than any other cache-hot data so the check can go.
>
> I think a revert would not achieve what you want as a plain revert would
> still allow an interrupt to pull a task from an arbitrary location as sync
This is the tricky part, I didn't explain it well. For rds-stress, it's a
lot (~30%) better to allow pulling across nodes when the waking CPU is 
idle.
I think this may be an example of interrupt data being more important. 
Something
like below will help a lot for this particular benchmark (rds-stress):

if (available_idle_cpu(this_cpu))
         return this_cpu;

But for db workloads, yes, in general, pulling does more damages than 
goods as
said before esp. under light load. But I think pulling to an idle CPU 
across nodes
is okay, because this usually happens at the beginning of a workload and 
once a
task is pulled it stays there or at least in the same LLC sched domain 
for a while.
What is not okay is when the waking CPU already has a task and the 
wakeup still pulls
the wakee task to that CPU across nodes irrespective of its previous 
CPU. And that's
what this patch tries to address.

Mel, I am thinking about a follow-up patch like below then we can 
continue the discussion
there since this is kinda a separate issue:

-	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
-

+       if (available_idle_cpu(this_cpu))
+               if (cpus_share_cache(this_cpu, prev_cpu))
+                       return available_idle_cpu(prev_cpu) ? prev_cpu : 
this_cpu;
+       else
+               return this_cpu;

> is not checked. A follow-up to your patch or an updated version should not
> check available_idle_cpu at all in wake_affine_idle as it's only idle the
> wake is from interrupt context and vcpu_is_preempted is not necessarily
> justification for pulling a task due to an interrupt.
>
> Something like this but needs testing with your target loads, particularly
> the RDS (Relational Database Service?) latency regression;
Sorry, it's Reliable Datagram Sockets. We run rds-stress to measure rds
bandwidth and latency.

Libo
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b7b275672c89..e55a3a67a442 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5975,8 +5975,8 @@ static int wake_wide(struct task_struct *p)
>    * soonest. For the purpose of speed we only consider the waking and previous
>    * CPU.
>    *
> - * wake_affine_idle() - only considers 'now', it check if the waking CPU is
> - *			cache-affine and is (or	will be) idle.
> + * wake_affine_idle() - only considers 'now', it checks if the waker task is a
> + *			sync wakeup from a CPU that should be idle soon.
>    *
>    * wake_affine_weight() - considers the weight to reflect the average
>    *			  scheduling latency of the CPUs. This seems to work
> @@ -5985,21 +5985,6 @@ static int wake_wide(struct task_struct *p)
>   static int
>   wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>   {
> -	/*
> -	 * If this_cpu is idle, it implies the wakeup is from interrupt
> -	 * context. Only allow the move if cache is shared. Otherwise an
> -	 * interrupt intensive workload could force all tasks onto one
> -	 * node depending on the IO topology or IRQ affinity settings.
> -	 *
> -	 * If the prev_cpu is idle and cache affine then avoid a migration.
> -	 * There is no guarantee that the cache hot data from an interrupt
> -	 * is more important than cache hot data on the prev_cpu and from
> -	 * a cpufreq perspective, it's better to have higher utilisation
> -	 * on one CPU.
> -	 */
> -	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> -
>   	if (sync && cpu_rq(this_cpu)->nr_running == 1)
>   		return this_cpu;
>   

