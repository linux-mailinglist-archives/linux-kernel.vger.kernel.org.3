Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D834F1CF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382414AbiDDV3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380631AbiDDUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:45:20 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33488201B1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649105003; x=1680641003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hFIyHStnspvuOtg8gp2HDuyPKaQy3dJMQH7k0q3suDM=;
  b=cJdIoGdN5VbFPH+WLaiaEcLTp1sNfvSpJQ5n6PExzrOIK3gT/W3H935h
   1diymfuIkjaW22d1le1KBRS1FDbaLLzpwljZNRGs8MmgJpLEXpD8zBvyn
   Ht9J+TE2PgzgzCgypBf9jx1evQBr4xJwoHSH3446W2FRWUYw/nhWxG6bW
   A8tWiOYSZtPStAgn89D1tPGz5RkKO8CVgSX8L1jtdEH+iN6Q/VlxeiRV6
   EU9GRtW++N6bZXWPGT9t6zVbyyt1DvhyNO+kNzfZPbQryepTcSO1v/6Bw
   NuDX8mROG0YpHDTkV1dL12rzczQBa1O0e92DmyxX/FAt4WXZIaeZW9Udl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323779371"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="323779371"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 13:43:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="641360682"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Apr 2022 13:43:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 4 Apr 2022 13:43:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 4 Apr 2022 13:43:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 4 Apr 2022 13:43:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQtFoTXa6n3ko/XPUOL1bdd3VVlYT74Ap+gMBeP0t0P2dMXzpVLRnuNEiWXVJZ2nUqy0mrL6Dv/zSLY6goEtVjYBnYpv73W8Fvoi0eoA7/HiGAS3kTC/Yvw8pofY99cv7nu6/jhywmY/0Ed0UIeoMMRJnUijvwoOuPr51t9X8jLRLmct7aOnykUxK18EQ1CZDakMPRjzqqnxxis4ASW3thzPxkQMMsu+ezcglyyNz4MX/e8P4YfYqAiah41EbDQD11lX1rD79H8ePmZwosH/XGCL1/6kp3Fo3TBrT9qgCWbNN2QzpJ+ZImBEurFvVG4dHWzSEHacTx9Y9JMc09tefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+I5fLHk1mGnrOcdH7mpMkjbe6M9whpfZ4YJDuOAXyQ=;
 b=FgdtziO6sRt8NPW0CLFbvful8leyKSjIT/4BvzWUV2VCbPoPj//zL1Hh6UXm9Xo1GhP2YyINfxyfkR2SEJLf3ECF5V7mQ29Wg8Cq/NPAWZfwPSLbn2BAy155YCRE47Zn7G30P9f6zvS5AcG0YoTRsmG2CjYjaelcHxwUuVPpZ02pTssDaJ1U/uoWoSccnYIVavbG+pp/od7TXz5NndljlFOxZ4Mh9BsuZAVMpEKwJkirK40lBjte4rs2rm1Obh7brglXkCqiu81B7rFPPKSRqxRwc6HLTVyo2crrohJgh2ZdHZmjdFeaJKCRD/fyvjqpRCKaUcs14WfH7gp+xzWCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 20:43:19 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::918d:6022:8ee6:3e36%2]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 20:43:19 +0000
Message-ID: <46d61a99-bb8a-a558-809a-60b085f33d6c@intel.com>
Date:   Mon, 4 Apr 2022 13:43:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        Jamie Iles <jamie@nuviainc.com>,
        "D Scott Phillips OS" <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>
References: <20220217182110.7176-1-james.morse@arm.com>
 <20220217182110.7176-8-james.morse@arm.com>
 <01651414-9d4a-409d-9db7-b4b6dde72829@intel.com>
 <d49bdfad-df5e-77e1-4834-266dcd1b9055@arm.com>
 <91a43681-524e-c12d-612d-259e51bde12c@intel.com>
 <f5f8166e-1831-1fa0-123c-53d3632451a8@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f5f8166e-1831-1fa0-123c-53d3632451a8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0002.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::7) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f28da5-688b-4df8-b20d-08da167bc040
X-MS-TrafficTypeDiagnostic: MN2PR11MB4566:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB4566F2690FDF2F92536872E8F8E59@MN2PR11MB4566.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LpKD2jL83UrKV/2aUK3jKC83tPFaTyPjGblbRvqad+mSGNRKDBmlEqeKCJzo+iIPdMJeJtp9ph2vWRr+46bkvmXDNmgYaNK8xrwEXn7p4/F1c9bGP04deVCjzFfs2fm4Flbs2JMZKUCimyWjB4b1fr1PmLBSs7nI4u5rdaVSQMM2G5xZSifk5XOWvchHdgU2raFyW+KExU6GsQa3XZwXi4o01TWOU+yDh0bdDGWay2lz6+cN011P9fOqzAP/pvCft/0qn7fLhv/B3L+IlSLN+Xi3f0KJVxsVmfSkuhus20WjFWlqcrEwuJMQ6XuR3tykjStHndp+UjA2SK4CtuvCBPL3/tEJ+1VCZqUxeOC6gLLcIzBOk5WIogHXU6hyKusV4QKC7Y9KBRxHPW+ofPvA/oHQ5svebwzay0qnK4u7rT6sWVJ8IRScY+j2NnkAirmD7sN8dMSgETf82JCHDIYhdTFmewy068C/zL9vKunWelFb03q/WyskKjZUqbpIdOl+BtiNVuiE7da8S5oV/79fttbcHQPtLusZS5AoL9fmUAxL5y9QI4tfHEqIJMaUSoAMCm32fx7DkIrIWCRCjlGz0BTzi5/IsT4aPl4BxHuoxJ9OBkydktHOB+10zUMUfoLFzntSO1UIXZoebbNxHtXoI0CEery24UG4v1QDVYnsKZ3/G/Ec/qr0Aa5BSRjPxXMCrBgHB4dyfXwpXI3eH8mM2duorwe5osKmZekimDopBeUSJX4CV2IxfPOxBkpqBGGa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(508600001)(2906002)(53546011)(86362001)(44832011)(7416002)(6506007)(6512007)(6666004)(31696002)(6486002)(38100700002)(82960400001)(5660300002)(2616005)(36756003)(186003)(26005)(83380400001)(316002)(31686004)(66556008)(8676002)(66946007)(66476007)(54906003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUp0MVE2V0JFMFlXaVFFcVpPcU52WjlNdEFOZkF1ajNZQ1VwUWc0eVd0MFpi?=
 =?utf-8?B?YnVQSWhic3YxRTNSL05CU3A0azNwZllQT2RWa1VnMW0xUGJNeE5vSTcwV2xR?=
 =?utf-8?B?dkk1cDJCQnQzdkw1R2pJQm9IUUp3VkZDRjY1bGUyY3ZCeG1KdEttQlk2elND?=
 =?utf-8?B?UTNrZXcxV0ovU25ZdnRPWG5paVdxRU5wMHBuQ2kvNGZHQTRNajhYRU9FOVJC?=
 =?utf-8?B?YnNMb3hZUzNQaENmTTZQNGM5NHZ6TzhRWUg3QzBGYnNxeFNYWFNtcUh2QnlQ?=
 =?utf-8?B?OTVDWE5IenhDOGo2Y1RiM05sT2lCck80eUZtakNCWnhtYW02SzJHQ3ZyRFlI?=
 =?utf-8?B?RkxMci9LRjV4NSt2SW5ucFpOdTgyd0JIUEJVQy95RlhzSGVNRjNYZHJqcEZ1?=
 =?utf-8?B?WUkzUW11MFNGQkl4M3p1d0R1L0w2bzBGNUZ0cmtxNWp3NG5lUm83SEQrWjVH?=
 =?utf-8?B?RG9KMUwvSEZIZTlrQUhpM1M3ckNmV1dLTWlvamJ2K1NVVUxTSzZscVhvM0x0?=
 =?utf-8?B?c2lGVFVrUkhoY1JaNVlsUlI1WVRTaWE0bG5MMFVWVldzTFl1MytCczR6K3RF?=
 =?utf-8?B?cEQxKzU2ZFdWT2JheE51Z1BYOGdYaGRNMFdPelN6cy8yMkV1Szc5a2x3OTFz?=
 =?utf-8?B?eVhlb2tmeEdaV294eEFKZVQrMHhHVEtqKzdpUStlRVhHdXJoSHBpL0twcTB1?=
 =?utf-8?B?S2QyYXZmc3JHQ2RzTEZVTktHZS80NWRiUFkxNnVPV3BiRDBHZlBoMStFN2VM?=
 =?utf-8?B?WE9Nb0Rkakl5TWJLWWVtbXRBWnViTWVVQ3V4bVMvVTB6NkpoWWRHb1lCT25w?=
 =?utf-8?B?djRad3RSeXNrcVBObTYxUURES1JXRWFONGZNbDIxeXRIRjJ0MXFNejM0MU9O?=
 =?utf-8?B?RnpLdmZQWFo5SjJncHZHSmJ4TEdRZnRsZGVobnNST2VlNWpZR2JNLzUreEI5?=
 =?utf-8?B?OE5FVnBQbVV2eGFHNUdwbThtWTNzeDEyWVRaL3NyTFExM0JkbTh2R1hKOEtU?=
 =?utf-8?B?eHRIWTFYeVc4bzJNb3V3YzR5VFBUZzkwUWtOWXU4dzgrYmFJSGkxRzR1aFV4?=
 =?utf-8?B?NUd1ZGQ3MFdSU0hzNlRXQy8wVlFrVkQ3QWVkNFFic3BqUHpDZnRuODJmRStj?=
 =?utf-8?B?K0RlNSt4U0t5dXoxMkRXU004Yk54TEFSRE5PRXJkdFdUU2RjcXBuWW5PWkFq?=
 =?utf-8?B?aTN1anI3T04xSEpzazZocTVQYVR4UVZDYkFXVEJtb2QvN1FMdDllVHQ0ZDE1?=
 =?utf-8?B?M0RHcDZ1cmlPR1RSZGtRbmw4ck1iQi9BaVRVMlpYVXFTTTlCVm1SVTV0K2F2?=
 =?utf-8?B?cExFU3lmOHovVXJMOTlYOWlLK1NYeU10OWpxaDk2QTduRWRGWEkzL2Yyb3lo?=
 =?utf-8?B?RktoTFVieTZmVE4vTFV3OHNMaVJhRENUMFFWWWFnZGNDSFhKODF1djJScmFt?=
 =?utf-8?B?NzZQMzdWWVdwOGNiQ2JvV2VodzRxOG1yVG10V1lSNmdkenhvczRDaUU2dTZI?=
 =?utf-8?B?eGtlSjRVenI3aW1qUitkRlBwSSswbjhpalF3djRGaG1KSE1qT00vZ1lSZHNU?=
 =?utf-8?B?N0lyR29WZm5tOHNHdGg2ekRLM2VLY3E5MXlBR05maVJ5c1EzZytXMkZBc1Ri?=
 =?utf-8?B?RURLKzhwUzgwbmF1MGJWa0xrYzJXVytVRFlVVkZNSUVuN1FieHArMjB1Y01p?=
 =?utf-8?B?Z2RoT3o4N1hBSFRRY1VpRU1KUWhGb2FNOCtyOWtCeEhnbXFORWRxdmxzZFp6?=
 =?utf-8?B?QXZMWTA2WDNmYmd0WnZhMmp0S0lKUUc2SDBjTWJHeWZESUljMWVzNGNJTm5J?=
 =?utf-8?B?OS9aR20yVDVraEZZa1BaekVBRDE2dWdMbjBJSjlwanJLUVZDOWFUSms0bFlT?=
 =?utf-8?B?WWYwZGNQZis1ZHFtVml1N255Y1F3eDMvVWhiSGNsR1h5VzBybEtaZk5wczlL?=
 =?utf-8?B?aXVMbzBmblllcTlQQ2N2WU5vSTVjci83OXlaR2s2bFR5aDRmbThOWU93T2l0?=
 =?utf-8?B?aktNWWZjYlNxV2k3Q0JkVnl0NnBvZU8zbDJ4a05odStMdXBOcmZaT1lsa3Uz?=
 =?utf-8?B?eTkzQU5sRmwwS0RjRVozUXBlUFl4blZodlJ2d0dzbkR2eWxYQ3dyRGJrZGox?=
 =?utf-8?B?MndJYVNXeVh5ZEN6NStSWUplVGxKbjFzd3FjU1ZtQ01JdHB4Z0ZVQlNycCtk?=
 =?utf-8?B?aFlsWlBuSDV5TU9FQmxDY0ZMM0NEaWt2NThOZnNaQUZoWS9abFpWbXY1Wi9B?=
 =?utf-8?B?UVhsZnNxVUQzeGx2T01UbnRFT3Jtd255VVMvaElVV3VRZ3EyajU1RUNnaHAr?=
 =?utf-8?B?Z1hWdm1TTXBHK2VLZWRnZ2s2M2x4OUl3eGp2b0dja2FsMjArbm5tcWJ6MVh0?=
 =?utf-8?Q?LzPak13kRDVeHhLs=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f28da5-688b-4df8-b20d-08da167bc040
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 20:43:19.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLPz2bbgqBhJ940nLzrmPiTgXfJQRKacg+BetNjJN12NPqYDI6f9Pz3GObrXM5k7G15UjR4g+3kysk61JeaCTa8boyrZQW6YYmS+VVhWKmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4566
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/4/2022 9:35 AM, James Morse wrote:
> Hi Reinette,
> 
> On 4/1/22 23:54, Reinette Chatre wrote:
>> On 3/30/2022 9:43 AM, James Morse wrote:
>>> On 16/03/2022 21:50, Reinette Chatre wrote:
>>>> On 2/17/2022 10:20 AM, James Morse wrote:
>>>>> To support resctrl's MBA software controller, the architecture must provide
>>>>> a second configuration array to hold the mbps_val[] from user-space.
>>>>>
>>>>> This complicates the interface between the architecture specific code and
>>>>> the filesystem portions of resctrl that will move to /fs/, to allow
>>>>> multiple architectures to support resctrl.
>>>>>
>>>>> Make the filesystem parts of resctrl create an array for the mba_sc
>>>>> values when is_mba_sc() is set to true. The software controller
>>>>> can be changed to use this, allowing the architecture code to only
>>>>> consider the values configured in hardware.
> 
> [...]
> 
>>>> Considering that no domain belonging to RDT_RESOURCE_MBA will have this array this
>>>> always ends up being a null pointer de-reference.
>>>
>>> Ugh. I'm not sure how I managed to miss that. Thanks for debugging it!
>>>
>>> That loop was added to reset the array when the filesystem is mounted, as it may hold
>>> stale values from a previous mount of the filesystem. Its currently done by
>>> reset_all_ctrls(), but that function should really belong to the architecture code.
>>>
>>> Because mbm_handle_overflow() always passes a domain from the L3 to update_mba_bw(), I
>>> think the cleanest thing to do is move the reset to a helper that always operates on the
>>> L3 array. (and leave some breadcrumbs in the comments).
> 
>> I think this points to more than a need to reset the correct array on mount/unmount ... or
>> perhaps I am not understanding this correctly?
>>
>> As the analysis above shows the mbps_val array only exists for rdt_domains associated
>> with RDT_RESOURCE_L3 but yet mbps_val will contain the MB value provided by user space
>> associated with RDT_RESOURCE_MBA.
> 
> I've finally got my head round what is going on here: I've muddled up whether mon_capable
> is a resource or system property. mba_sc depends on the L3 being mon_capable, but the
> configuration should be associated with MBA (wherever that is).
> (basically ignore my previous reply!)
> 
> The creation of the mbps_val[] should depend on supports_mba_mbps(), which uses
> is_mbm_enabled() to check whether the L3 is mon_capable. I'll check the rid too
> to make it clear its only MBA that has this.
> The call to allocate the domain in resctrl_online_domain() should be above the mon_capable
> check. (which is still needed to avoid the work guarded by is_mbm_enabled() and friends
> running for each domain).
> 
> 
> Thanks,
> 
> James
> 
> -----------------------%<-----------------------
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index e3c90f33baf2..ad0411eb2147 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -3345,6 +3345,14 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>         lockdep_assert_held(&rdtgroup_mutex);
>  
> +       if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {
> +               err = mba_sc_domain_allocate(r, d);
> +               if (err) {
> +                       domain_destroy_mon_state(d);
> +                       return err;
> +               }
> +       }
> +
>         if (!r->mon_capable)
>                 return 0;
>  
> @@ -3352,12 +3360,6 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>         if (err)
>                 return err;
>  
> -       err = mba_sc_domain_allocate(r, d);
> -       if (err) {
> -               domain_destroy_mon_state(d);
> -               return err;
> -       }
> -
>         if (is_mbm_enabled()) {
>                 INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
>                 mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
> -----------------------%<-----------------------

Thank you. Having mbps_val be part of RDT_RESOURCE_MBA makes things clear to me.

In the snippet you provide you may need to check the error path cleanup, I do not think
domain_destroy_mon_state(d) would be needed after moving the allocation earlier.

Reinette
