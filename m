Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142925A0C43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiHYJNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHYJNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:13:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F67EFD0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:13:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P6xDio005520;
        Thu, 25 Aug 2022 09:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=LSwaFOwuLIjsX6iE3JtgeYuV2f4qv25eZC00kq6/L9g=;
 b=n7vlaCQdTUtFxM+uN/VUXqdSK0ElhLejvyOvOuuHEX8vmiOud9h6jpRW3n6WFcsn2DDw
 E6ZXUvcx1urgsBG1th1Y1I6KnYIFxAj3ZcyqxGDPEiqhzQEYlnkyRILc6803FL5Y91lc
 PgwePYKixgaMnIz7ELxZDWwzFguIeszyVHtPUMGZwtuMoh3NUgEXyvtzsbFPA7M1I8iJ
 WRbvzF+LISmHhMq68e9H8PM9oy/8ARBRXDbitTAB2xtc0TqmUxgKhTi9p1qca7I0SeQJ
 wJ8LDcPA2hnSPfqrbGg0hzi719IdEekXm0Ph9d5JK4V0G9BfvWwF8Jg3ZhnK3fTWNkwY eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww3jrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 09:13:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27P7lner011150;
        Thu, 25 Aug 2022 09:13:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6mhq5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 09:13:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isYmsyDu5nCn+AVHiIrbTge+P+ZS40B9FhyLioxrq9lDw7XAABS1Bx8MfPwUhmFS+W7TR3u22LMp4j2KT+OCLBFG4628OjfQa2A1Gly9sSn7g3Pcl3h/6b+6DnzBqzyEKmyXFjvg6xPO4P7X+wvsDoD7iKmlTOMCe1QmLpzU0PHgbEAnRQHKswDg0ZqfjmJuNVY6YaIu1AFwQA0qfKooZePGj9w2R57RPXJrzJIzRhEOrW8NwPdsxQaGyZD5E4Od/ZFIzJLTo77NuVZCbKuVGzKwvdk2fECZES9GWvl7Vz3Brm7esav4ldmM7zizBDiPU+EIKIuv7uk3DPS79kUq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSwaFOwuLIjsX6iE3JtgeYuV2f4qv25eZC00kq6/L9g=;
 b=I0cDKs/7IgFZyGlU9ZGT+f9sXRSPAi1vay4rhNO6/WD7n2QLeSCwRmptijgVTBlHvcGeTs+0wTPkxDoyEchqteE4B/tMGPYINDh2pdw8HMVhSxISgWC2NlNmRPnMN3oylyByMD05ycKDauzdziW0zkmIhcxmbRSr7ZRVrEUzmoigf0Lr9jmS6sHnqu1SW1VkBz2IMZdqFktGqAPCwVQJaoNwBCMw9gIAH+dbgVa5vZb+K7YYjHSv65SQgizBI0gu5d8J7vS6WyDBzJqTjlPOPwykdthhn26cC+Q8vSIm99t2BjreVowdba0B72e1aOWFdMb6/24qf0wF72REE/iZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwaFOwuLIjsX6iE3JtgeYuV2f4qv25eZC00kq6/L9g=;
 b=0UkBXqbGDWXTwSgcbr1RqNMmuAkqLjBDkOlx7/IJLawH9nMtLLF6CrtR+m+KSwjO7aM+Z8xBhUeAN+P1SAtVCabt2/HMbB8MMOsbW24kRwEcocApqbFsLUuGgGQEhI9t9lNm1NQ0SXD2CA9mL4TczMlpt/pOd6E8Wc6ncBpksNA=
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com (2603:10b6:a03:2ae::5)
 by BY5PR10MB3923.namprd10.prod.outlook.com (2603:10b6:a03:1fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Thu, 25 Aug
 2022 09:13:19 +0000
Received: from SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::dc97:4e45:24eb:a7f4]) by SJ0PR10MB4576.namprd10.prod.outlook.com
 ([fe80::dc97:4e45:24eb:a7f4%7]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 09:13:19 +0000
Message-ID: <90041ab2-a8a1-8572-969c-143a707faed2@oracle.com>
Date:   Thu, 25 Aug 2022 02:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/1] sched/fair: Fix inaccurate tally of ttwu_move_affine
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20220810223313.386614-1-libo.chen@oracle.com>
 <Ywck+3E0DyNdUJRE@BLR-5CG11610CF.amd.com>
From:   Libo Chen <libo.chen@oracle.com>
In-Reply-To: <Ywck+3E0DyNdUJRE@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To SJ0PR10MB4576.namprd10.prod.outlook.com
 (2603:10b6:a03:2ae::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24474076-c8e3-4afa-ed42-08da867a0d3b
X-MS-TrafficTypeDiagnostic: BY5PR10MB3923:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jwFGKFkKnxpo1VdXbf66XwCf+S1f6JUwhsxh6NQaHEjaAu2Asq94WLaxJ6WRVCSIg4o4Nu6HyNFnC9SxhNB/mXbl9MVV9O2EwJsS/7rkX9DvDoqnZxuFv++X9Zs03JW5sp6pSimtTPze+ptOT+KPxn1aOULYSMALHlH/kiJKB3FyY1dNBX+AW7Dt+EWigoirAG6CxQ+gGpRshrUvynkAY6GMpFidmDWraEtgVXi2KLpFL1QG5nwyPssXJs2zWoCk65vQw5vwlUm0u6nE2obF2k3Mh5bmr/C6wLV3iR4lqmVYN7/2OgR/k9ZN3PSyZ8zhQmUiOy88AiHK8dBy610Eg/dQhZjoPMkYsACMuR86w4u7+1t5Rd2m2CnxlGPwmIyIaDHjBRq18qgqvAOlB8Wzye+Foc/2ybp7mGqZSqznYFZXY/AJhjJGJ2Si8JLDMf3fp3MZUesAcuIDiaQVgY8AeNqccoJIsUbLxDlrAdXW1oZZqIoAuvjR2EhKSNnFvv2DHLIdi8hsIN1MdMWRu6loLZbI64iP63KE08RBP4L7UY3JduFYV26nWI/JalMxl549Frm9rd2e6OuVMCfkWULE3EdvfiAwYodhB9avTMawstjGXZrH1Emme/yKFp4PkPDUsrDevkKgStaZoiusjqJ250dhJDi/5F7Qp0zguEMzsm6hyzXEJty9mVDzPeiMugIcYX7XMvR3GsMSqqcnZi2AB0F45Nz2Clm1/v/YEAtyf+l8schqU3mg/cJmHz8Z2dOsz6/AgIo6IkQCocOr7bFXV7JQELgtJZE9KsbHcegULcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(478600001)(53546011)(52116002)(107886003)(41300700001)(6486002)(186003)(83380400001)(6506007)(6512007)(2906002)(5660300002)(8936002)(8676002)(2616005)(44832011)(316002)(6916009)(66556008)(36756003)(66946007)(4326008)(66476007)(38100700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFBDTHU5ZHVoOGZaalVsZFpKNXpoT2plRm50OEpnbS8yQlYrNElsNC9WS3dY?=
 =?utf-8?B?SVJRSW9ONGRBd1V5UzNIaHhRZWhzWVVZeGFGSHNLYm5NOFBMWlNwQVBTdkt5?=
 =?utf-8?B?OXVtMGtuQkVNQnJIN1A3R1NMOEhLR1Vrd1BrcTNwUmI3UlpRWm4wTkY0dkp2?=
 =?utf-8?B?N2NVWEdycnZUK2dUNlB2RlJuMEtSSWRkbnlTSkdzODk1QlNqRkFIa1M0TzN5?=
 =?utf-8?B?TGRqbEQxVDgyQ3R3Szd3Yy84SjVDVXBzanowY3VxcDBXVW56blNQMjArWDhs?=
 =?utf-8?B?NEFZZk1WNFpXaitmOVJ0V3B2M1oycjk1VW43cTVxLzF5YU5PNVRYNUZFbEtY?=
 =?utf-8?B?L2lEWTd5b3l0WWhCWU0zZTg5ZTY4U1k2OWpnUTZpOFFGdHRscUZ5STVQclpM?=
 =?utf-8?B?T0l4dUJFRUpFK1hRZ2E2WWJrZ1hqLzJWengvZWwvZ3YzZjZQRnJQSUdGUVdQ?=
 =?utf-8?B?alNGcEIzRVNMOEhJY05QL0xzZDIzNnAyVDd1V2hDZklCOEJQWXpuL2tZMHdJ?=
 =?utf-8?B?eUt4b0JpM0NCY3JIajY3Wk1LNENCQ2hpQ2pzT3FtbDNjVDVJUzRxV3Q1bmpr?=
 =?utf-8?B?UUZKM296dURVU2hUcGJVeXd1OVFzVWVva3I4d1Bud2ZUb2VsL2VtWFZjVHJL?=
 =?utf-8?B?NEdqSXlKK1VzVU1qTmYxMVVqcnNRaCtxT2Z2MTZQa0RBVklmT0ZZR0lHSjhn?=
 =?utf-8?B?RFkyMS93cGc5R2Y3ODh0RlVQZksySDI4WlIzSlpHU08rT2hTZjVtbG1xWkFG?=
 =?utf-8?B?dFJra1RCZXIrMjVHUG5RYkFxVTBrSG52SjFvbW9ZYWlOQzJYU0NsRmMvMW1S?=
 =?utf-8?B?QzMrclV3SUxDRmFPTTNuc1ZGM0g4UGRIUmltMlFEWUsvY0FEZ2ZwdTlQZmdw?=
 =?utf-8?B?VWV2NkR0bXA1Q09HWUxmSDhMbUQ4SjU5UDVOeXIya3B3THIyVm9iUE45ZlYx?=
 =?utf-8?B?SUNKS2U3bEZ3ek0yVThqVzE5VGRHdW5ZaEorWGs2Z0JNanFjNnlnN2JQbEo4?=
 =?utf-8?B?Q0NPV2MzSVZ4c2tzWlNaRWgvY2FzZ3ZWbmxJZTFJaGllRkZ6dEhOTSsxZEhZ?=
 =?utf-8?B?WkpzOCtUTDEyT1ZHWHJVUkovNUJrMkJINXU3UFV3em1nWjdqWmUyVzIxVlB1?=
 =?utf-8?B?RkJ3RjFoc0oyQjVjMkZ4K3NpWUNpalJrcHRnUmh2K1BUem5ySERkaUM4QjV2?=
 =?utf-8?B?QzJSL1h1aU42dzBBR1dXbTNQVzU5dXNMOWVMQnNoZlpnSG5RV252VFBLUmd4?=
 =?utf-8?B?TVg2Q2FOSGtLOGZ6eHlMYmNmR2g0aVpqNXlIa1QybXBvbUxoU1MzY1U2aVlt?=
 =?utf-8?B?dUJqVDhmdnRaQm5SdXVrUCtadTN3QzRTclZBSENMcnF2UDBxbUJURmZpcXh5?=
 =?utf-8?B?UDB5ZmpJUkUrc3k2S3lMUXZuT3JkV0QxWDZnL2NhZHptdGZpdXNnbzVZaDIr?=
 =?utf-8?B?SHVNcXRsQjBudmlob1dqK3lvdVM0YSthdXB2TzRWUWdpcEFNdi8rVGQzR2ww?=
 =?utf-8?B?elRKWHpvTmVXaDV4T3A4Q2hQcHZQcVUxMXUwN21mQUplajFCUERGOWZOZVRK?=
 =?utf-8?B?dGhQYTNFc1ZxY2xtNnFTM295MjhYS0w4UWZDTHZwN09nVkNEcFpCclMzblYz?=
 =?utf-8?B?eWJYODNpMTNuOFB6WlhodG5HMWFaVHRCSkJwS1BNM0czVC9Nd29xR0EyMnRL?=
 =?utf-8?B?ckVrOUJFWXZzVVpGbmsvNk00bkx2c3NKRE84VU1ZV3JYcE5rYjNEVXdxcnZY?=
 =?utf-8?B?VXBiaGJ3M2d5aFRpK1pCd09IcGVneS9uQWZiTkUzTnJPVFoyWEtaRkZTaXhK?=
 =?utf-8?B?L25DVnNPK1REd3FYWHdoa1YzWFV6VG5HWEJwcnNqZkZHWGtTMGlBSmtQZXZX?=
 =?utf-8?B?TmMybWxOQ3I2Y0RodmRJVlRMcTkrbnZQQ3lpK0JaaXgydUlYSnBZSEdKdjcr?=
 =?utf-8?B?TmtCclBmM2kxSjNaQlA3QjUrR0Q4a2VzejJDUHlXVjdFSTlHRE9OS3hmeVFS?=
 =?utf-8?B?K1Y3a3dyd0NFWUQ4WXhIelJRK2lVNm1XR2JZZmdRNG1FSGViVUd2aWlLQmZv?=
 =?utf-8?B?eVFaOFZ6WTI2TmNPUXhGeUl2d0JnQ0lmcmd1S083dUNSU29GeUdZcU1ZK214?=
 =?utf-8?B?RDl4QVFyeGR5djFqdlp2ZWhnVVQrK09aNkRYYlFaMitzVUl0YjhBcjZWMTdo?=
 =?utf-8?B?UVo1Qm9qRnc4VlBCdGpkQzJBZkl4YmlIWUJJRlJLNWlVVjU3MEZrcEVlcnpK?=
 =?utf-8?B?NmVuMWV0dTBhZ2ZoQ21XVGJ6b2ZnPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24474076-c8e3-4afa-ed42-08da867a0d3b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 09:13:19.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Py+iZaKdz1kd4ZQlwhiAaxR2u1nrvF5X/al6+bLnfwSrw57UDaHVaDTeATTj3m1T92GHd6FWJwWfehc7OhYadg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250035
X-Proofpoint-GUID: E5_HWFcdPfXWJMHaaFkHtftT-QImUZfe
X-Proofpoint-ORIG-GUID: E5_HWFcdPfXWJMHaaFkHtftT-QImUZfe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/22 00:30, Gautham R. Shenoy wrote:
> On Wed, Aug 10, 2022 at 03:33:13PM -0700, Libo Chen wrote:
>> There are scenarios where non-affine wakeups are incorrectly counted as
>> affine wakeups by schedstats.
>>
>> When wake_affine_idle() returns prev_cpu which doesn't equal to
>> nr_cpumask_bits, it will slip through the check: target == nr_cpumask_bits
>> in wake_affine() and be counted as if target == this_cpu in schedstats.
>>
>> Replace target == nr_cpumask_bits with target != this_cpu to make sure
>> affine wakeups are accurately tallied.
>>
>> Fixes: 806486c377e33 (sched/fair: Do not migrate if the prev_cpu is idle)
>> Suggested-by: Daniel Jordan <daniel.m.jordan@oracle.com>
>> Signed-off-by: Libo Chen <libo.chen@oracle.com>
>> ---
>>   kernel/sched/fair.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index da388657d5ac..b179da4f8105 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6114,7 +6114,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>>   		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
>>   
>>   	schedstat_inc(p->stats.nr_wakeups_affine_attempts);
>> -	if (target == nr_cpumask_bits)
>> +	if (target != this_cpu)
>>   		return prev_cpu;
>
> This seems to be the right thing to do. However,..
>
> if this_cpu and prev_cpu were in the same LLC and we pick prev_cpu,
> technically is it still not an affine wakeup?
>
I think schedstats like ttwu_move_affine/ttwu_wake_remote is defined 
within a sched domain, so if the waking CPU and the previous CPU are in 
the same MC domain, then picking the previous CPU is a remote wakeup
within that MC. If the two candidate CPUs are from two different NUMA 
nodes, then picking the waking CPU is an affine wakeup within that NUMA 
domain. Correct me if I am wrong, this definition is consistent across
all levels of sched domains.

But I do understand that when two candidate CPUs are within an LLC,
     a) all the fast-path wakeups should be affine wakeups if your 
definition of an affine wakeup is a wakeup to the same LLC of the waker.
     b) select_idle_sibling() may pick a CPU in that LLC other than the 
two candidate CPUs which makes the affine/remote stats here useless even 
if we are consistent with ttwu_move_affine/ttwu_wake_remote
        definition.

I personally think it's just too much trouble to add additional code in 
the kernel to, let's say, treat all wakeups within an LLC as 
ttwu_move_affine. It's a lot easier to do that when you process 
schedstats data,
whether you want to treat all wakeups in LLC domains as affine wakeups 
or ignore ttwu_move_affine/ttwu_wake_remote stats from LLC domains.



>>   
>>   	schedstat_inc(sd->ttwu_move_affine);
>> -- 
>> 2.31.1
>>
> --
> Thanks and Regards
> gautham.

