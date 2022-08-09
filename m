Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DA958DAA0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244656AbiHIO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244680AbiHIO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 10:58:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD791DA7C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660057113; x=1691593113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yeVeFBGCcVrgzjWV/+H5hTsd5occLFwX0zsBtWa6QQ0=;
  b=T4hU4gCMDgPhnjt0LMdGshlMWLOolLogZ3ozWQo3/GQL5gwrPZ3apImX
   I0Q+wD5fOGnByUOEFVuBhYihEpITZPUKxjzqa/F890mhkKR1lLPskrFTl
   axFBr2bHZ+1pxzZ4BByThkWZz5qk5rsJ+T4IHPpT6r5Bb60zS5z4Brwv+
   ixwfAxUi6kgGS+KAEvmmnOcQqVmvz7DIVpvbmq/kPFv4dgPVWPIZObC8Z
   DagFL7eksfeYZ1U3eA8K/0J1J4E5WJr655m74RoDS6Tv1a7/5z+t1sPqs
   0iqB8ndmjE/qbHbdgL0VXtIwhn2D5x8kvgECDLj1wVzUwMKIBh63pfe/J
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="292096547"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="292096547"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 07:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="580824577"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 09 Aug 2022 07:58:33 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 9 Aug 2022 07:58:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 07:58:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 9 Aug 2022 07:58:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldTsfpVYzdMxV5sSZwOcXNxhPBy+g6Z65+IqXO1fAKEy0K+wDNsU2Pkgno2iGm9gJTCw/Qar6Fd8eYndVHgX/5LQGjRUF6EEo+nNtyBZcVLJ+Wf+0Uxm/FTaYvzUSDve7D0t/wZrbJnzPYzl8sMLIkL1sAQ9yIuZ2NOb+j9H3kCZ9VwuTYAuwpzTuDtphVB8ozE0r7GGT9+yAqz3nEie+2MIpo5B7nbu/ArIpq1ewbpPzYFm44A66t2pj8K5szurnlQbWp/IIIjo1zhBFFofLIIrgWdcOhRY1IU+xXqTUYz+CfGYIumOnLM2mLZveVzBbJH0E+NzWA4e0kBUKMpomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/5mVtZSgvLLca1wvv8SI7jhE+HepnR37ivtH84BzvQ=;
 b=hJzayWTUJvyJ5mRhQAvV0osPbY8C0db14k2CWuTkzUPiFyJNK0CUKHRBkNsEzeSYdFQn+G9dfiQNlA4LD3mdFn82EoszAHXTcpi4/wdhqzzOqdmFaCXTWkOojLNTkfVgkipagwmhhXoXpcBpUo+mRWda+6GEHXlWdm+SGSicF5kf+HeCnV3Nocan7gvGtBX6WRXGbZEMLdhHbTdJR+E3ZxiwyTCaOs/ZkKK0/ntVzTa0LjuTIVm7V7qnF0KmNmkC6xpl7ElPwHTf62WpMxio8BwDu+PPf99MnOUWI1Mqlv4cW7Oob5wZ3ft5mjC0RZNfcA7ip+JKLs4yQRyilD0DOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BYAPR11MB2551.namprd11.prod.outlook.com (2603:10b6:a02:c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Tue, 9 Aug
 2022 14:58:28 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::756c:27f:6d51:bdda%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 14:58:28 +0000
Message-ID: <43c610f9-8671-519c-108f-9996e219c249@intel.com>
Date:   Tue, 9 Aug 2022 22:58:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC PATCH 0/4] x86/mm/cpa: merge small mappings whenever
 possible
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Song Liu <song@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20220808145649.2261258-1-aaron.lu@intel.com>
 <20220809100408.rm6ofiewtty6rvcl@box>
From:   Aaron Lu <aaron.lu@intel.com>
In-Reply-To: <20220809100408.rm6ofiewtty6rvcl@box>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::25) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53e709e2-caab-49c7-f2c6-08da7a179dd1
X-MS-TrafficTypeDiagnostic: BYAPR11MB2551:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mst7bqAMdpxhpJyVRO8xNuy4KZvzml0zzET6r3vYI2cvNg9xehgXK6DHJItCPBahZryd9jKx5SwMUHffrimqHi5kRXguYuNMphUkpzVIwQDXfjnVdl+P0qkpugTXcUtgzHWVBTTJs27FU55M9YRxtyvmGpX2N34deLpj8VT8n/HJ8+F4QrLSt7TssTT3FWzfMvUoY59EaVFVD7fkspG178pvcYW/xT0JD1K9cAiG+rCJsrkKz1LN31A9Ahl8wEAN3YLDiRmIzlHvQMItxn5j2ZF/ntZdzFgcWDSWkfxWk05BDzzkPU9XPQKm1hc6RLtG+95K6wjL6EWBwtLH3P7/PaQQGqXeRfCjsba63GUvDxAYizjPJkKrYbRYWr6f+bRCX8B26/VRIDh3QUEowLVmWfFRdH+lpKOTnlZsTytENq5E0ArzmvsNnEDrTjppRfZWyZP59zFVkMVoyBetim7QAAAAHDR7NFXsCVg1UAT4L86p5Otz43yngXvcSdn77Z6wIsUrq0ZFQSw4EzdyutZPLIN/dFhw9VBK5juow9ks5l1WwHMcqgm0iNPAIXQ/sT9GUrdjYxEHAvFMNL6tRpUa1SIKDgTE4NW/N+7e9g3JzXB6KzrRdvZf0YmRl1bYZ4ZGXQbA++9XKDU9xWn7FvN/AX6PTjjJ2y6msu6fsWJhXbOh1Xk68Y6B7yA72WERIUrYRNvWH2176mrtKSgol04hP75TqQoRcInocIEVi25ttISZnLuaPXIRIIOyll7GlOxnqaJbWaqjaKafkYhs441Lbk1BWYadsMPevauaIkuRgLr0NIS9y3E0IrLs1cW7zzRpg7o5juFC1ecC/DsK9OJAQMUsTTSx14tDkE1A4HuTWD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(366004)(39860400002)(396003)(136003)(31686004)(2616005)(186003)(36756003)(83380400001)(6512007)(26005)(4326008)(86362001)(316002)(6506007)(53546011)(2906002)(6666004)(41300700001)(6916009)(966005)(478600001)(66946007)(6486002)(44832011)(66556008)(66476007)(38100700002)(31696002)(5660300002)(54906003)(8676002)(82960400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci8wakdNY0ZrQm1rKzFCaC9PNVhoUXNCWGdtLzBFcUxMZEx5b2tSYlR6eFBF?=
 =?utf-8?B?WWlsUnhaYm1vVzFtL2ZSYmFLaUVybVJBQm9lbC9rckZpVEU0Y0RkZllXMmlD?=
 =?utf-8?B?UGlCT1lyS1EyZnVlUWIxb0RCdTFTd2VlcFZLdHVQZXdhNjVZbFFNcElYTkFi?=
 =?utf-8?B?OHBBbTM0WEY0SUIwNTR3clYxMGFVTWJhbEdZRVU0UWlrTmFyTDc3Zm5mZEx4?=
 =?utf-8?B?NTFLRnVDMHdVTHg1NEtPeGRSY092R240OGEybVZkYjRJS3BVNTZJa2pzL0s5?=
 =?utf-8?B?dmJOdWVkUUkzNFVWYkVpN2VBU1k3L1gvKy9PVXhCNFIyZW5IeEhjTm95STV0?=
 =?utf-8?B?NzJXdi93azBla2JUdlllNjNWRWpjSGthSFltMTNidFBKY3ZTcDZ3VENLdm9r?=
 =?utf-8?B?MmhZaElmQ2Y3VVJDSHN2RmRuaUd4Uy9PSVBqWDJMdTNwaFB3Zi9iWWU3Smlj?=
 =?utf-8?B?cGRRYVgvOStDME1ReUk5UkhGZHBCK211eHduZDN4c3RtVlVKa1FodTJVR3Rv?=
 =?utf-8?B?QytiaXBldXVlZU4zL2Z2VTd0WUxpWFQwUHVWRCtnSlIvYmZPVmxIUUdpb0d4?=
 =?utf-8?B?N21CZXdNMCtCUWtXUXh0TUxIRm5XcEtmOFowSDV0VmtLM1liZTN4eUc2VzlC?=
 =?utf-8?B?QW9QSElxNGI2eU9LNStQUDNuNFpkR1EyYzFucUIrRlNVc2JHMHRtelpHRS9I?=
 =?utf-8?B?Q2JmSjhiNDlxV0V2Y2s0U2xjS0dPd012b1FIVHg5VEN6SlA1OFhzWHdlb0NT?=
 =?utf-8?B?RG5TeHJoclVFdWIzc2pDM2lLaHpoUXV4MHMzSGdBTHIxLzhjYnRHNVJSaUFo?=
 =?utf-8?B?YWVESi9OVjlVcjV2cDA2azk0OGtta2xlcFp1b3g2d3RuVEg4cmgyS0M3ZDZy?=
 =?utf-8?B?dTBKc3IyMEcwRWx2NE56anMyZ3FzMVAvZTZlTFUrK0pkbXZEL1pvS1JnT2w2?=
 =?utf-8?B?ejUzRHdlN1NvRURFN2xTMy9lS2Raa29FWURtZy9OejJlR1BWVFV1WVdEYTR6?=
 =?utf-8?B?TVJoc1JUYXNtZHczQTh4aVIvckF3TEREdGtpaDdzSTFKL2VXYis4L3llaWhp?=
 =?utf-8?B?RG9oMkFwRFZTVEhhckxsNW9MNDEyYjhqcW5PVmtPMFVqTEJ4dzg0RFgwWnho?=
 =?utf-8?B?R2wvbHhWVUFRbEZPM3pnRHBXcGNLQkRzMTBFM0o4bHZkK0taWXBQa2JoTElk?=
 =?utf-8?B?QlVuaDZkd1pqZkMxQjlLUXBobGk3dEV1VEdibVMweDVhcTYxd015QTVJWkMr?=
 =?utf-8?B?T3VIVXNoejFCdyt5cXR2SDFiRDdZTmZEQ3Q0QWlrdkRTM2dZNkxCaEFoZE5W?=
 =?utf-8?B?SExoUktpYkVJUVBJeXBPV2d6eFllN3czTXYwM3hIWk5jNTEyTm5pbi9wTG9x?=
 =?utf-8?B?eFAwWnVDSTN4Z2pkTksrWW9mZUVXSnQwVXpVamw1T2xHZVFqaDQxa0t0TTJk?=
 =?utf-8?B?bzlNL2dubzBlS29sbGFwS3Y3U004VmtLS3ZGYWttdnhkR3NrYm1KVTJKQ2ww?=
 =?utf-8?B?WWY3TktyeS8raFBKNWpTVENnb2MyYUZnZ1VwQ3Y5a25oNkhKSkFZUEY2SG5w?=
 =?utf-8?B?anVuUnFxYnExVFVZNDFxL0k3aEM3U3lqblp2Tllxd2pjWGJ1amNiTFk2WFJs?=
 =?utf-8?B?UEZWTkttUTdrWmIzTEoxQnFQS0xSSVQ4R0pQT3REVDErNXQ2NmIzZzl5UFds?=
 =?utf-8?B?akw1MG9YOGFNekRxc0Zqc00vVE8wZkxyZ2liUHdBTVdtb0FZaE40QW5ncmcz?=
 =?utf-8?B?aEpHU0dzbjEwcStZUmVXS0NyWVRjVzdEWEV6bHY5Snc5SXZnNWlyMVVtOWYy?=
 =?utf-8?B?ckFlRjdrZGNJc0VDU1pKdmFwVVhRNmxiNjJWajNLcWRKOVRJdUd4am5nVERF?=
 =?utf-8?B?SVdFbndWaG15N1NlK1FNdTV3R2g5R2o0NFF5SGNxS3ZJUXJ6RUFxQ2FIakpo?=
 =?utf-8?B?ZUVaaVF3TjN5RWdncFhJcFdmMEszS1BsY0UyQktQc0FxdEFlMXZnVnllUHAz?=
 =?utf-8?B?Ym45UGJVemxJNzVGVDEvbnI1ZG1ub1dPbG1HQklaSDRXODdwZmR4OHdQenZl?=
 =?utf-8?B?ZXpYSitLc1hud09BM2c0a1lCS1RUY1ZERGhvVlM4UUpSVkplVmpRbEpwa0Zs?=
 =?utf-8?Q?EP/QRSDxLrOuFsPgs6c9o5u2A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e709e2-caab-49c7-f2c6-08da7a179dd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 14:58:28.0089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOF92tlVjEITuChaI801MBI8VAaB7rfim4NTrphyux6oZElG5dwhRjkMKjynpH3oyHq+pVC5CDY9dLMlInhnbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

Thanks a lot for the feedback.

On 8/9/2022 6:04 PM, Kirill A. Shutemov wrote:
> On Mon, Aug 08, 2022 at 10:56:45PM +0800, Aaron Lu wrote:
>> This is an early RFC. While all reviews are welcome, reviewing this code
>> now will be a waste of time for the x86 subsystem maintainers. I would,
>> however, appreciate a preliminary review from the folks on the to and cc
>> list. I'm posting it to the list in case anyone else is interested in
>> seeing this early version.
> 
> Last time[1] I tried to merge pages back in direct mapping it lead to
> substantial performance regression for some workloads. I cannot find the
> report right now, but I remember it was something graphics related.
>

Do you happen to remember the workload name? I can try running it.

> Have you done any performance evaluation?
> 

Not yet, I was mostly concentrating on correctness. In addition to the
graphics workload, do you have anything else in mind that may be
sensitive to such a change?

I think maybe I can run patch4's mode0 test with and without this merge
functionality and see how performance would change since mode0 is
essentially doing various set_memory_X() calls on different cpus
simultaneously which can trigger a lot of splits and merges. Sounds good?

> My take away was that the merge has to be batched. Like log where changes
> to direct mapping happens and come back to then and merge when the number
> of changes cross some limit.
> 

Appreciate your suggestion.

> Also I don't see you handling set_memory_4k(). Huh?
>

Ah Right, I missed that. Currently set_memory_4k() is not specially
handled and can be mistakenly merged. Will fix this in later versions.

> [1] https://lore.kernel.org/lkml/20200416213229.19174-1-kirill.shutemov@linux.intel.com/
> 

Thanks!
