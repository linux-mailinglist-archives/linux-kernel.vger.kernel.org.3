Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD8587E13
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237146AbiHBOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiHBOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:22:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803591706A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659450142; x=1690986142;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gLmGF7E/JSsKGi3cLgkhGfOskAKp614sQ2JqovFD5uo=;
  b=EA86dWI7DYpJIbpvFzgb4yeSJq3ktiEnxcR9Nfu0oa7hGFQ0sEkY00xt
   AyIplrBzBmy5VgrWjpQ4EtYXwH5iKy8+9b63WdRTCSI2OxS6p4biJWEFh
   QTMbbagk7aP8/t2Te45GxJKW+dPAfZNqeK7TWkenINDmto4ycKBIyj9c5
   td90sey6T3OWNmvHKxlwvaRCWLlTNGwymREtGEPW9p3h5iGsf0siEaB/T
   mPe+QTkoGi0wT5Y5ZvQIgl2f8Z3d3VlWQx4QI8KkrTquGfIoo2Kb8XH8W
   M4fuZJxsT7VYvbIBU3h3bYhsOuWr5nqeSN0qXtAtzofKlXweJPBhtGcOX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="276328960"
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="276328960"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 07:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,211,1654585200"; 
   d="scan'208";a="661641668"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2022 07:22:20 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 07:22:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 07:22:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 07:22:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImJ/FnpA9BsX8TzqyYtzKIZZXUt7tB/J4R1UWmWvfkDjGUd1ARxo4s+gTHn6FkoL/UL5hFuW344nvlkb3/GcVlXety2P3Rk/091VdjL5PS4Etn1aIiZs2I980wVrMlsSjmtzUHJgxg/SeJIaofV+7aSrZS+CiJOxAxdLwhfCa0J4gNALGnvOAKnKJOjEvlx3EseKzH0LjkaO2hduzkvSDFs+AVm/vUAvFynKImRfoXX6phG3GAt0CU3Hvlgjamwl0s7OuU+AbjjNUCbksasbWdPUr0pynegBYjEfMw1pEXCwjbm5jsfv5aU+OyFez1lKkvuP0o4JQKPmG6DLlHRICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+RLHZp2hwi/YJVEuSDha5XdGvqS4RsiPLG2zvB+/lE=;
 b=Fkw8KaK1xoGggt5wjpKUY6dndyf/OmeSmzIEFC4mkOD+Rt+3Mt+9O3iaXDA0tOuAtw3Ih/sFQWD15qnmB6j5KxoI9GctGKTG24m8vOCRunxijPT8zAodyrUTCD+UwyCI1k53fjvnW4dB+KpyJDlmL1cfgwlLR3VPWW4S/YQcUyrF2BJK2+MTAD/S6Gm/lwdCvPY67jBCiGvAG4/Xve+xpcedDrRZdMdjGGFAl0Y2+b9PCnOPC7JfQECuCEVfPjoaR/d7Ljd2BylpUMGGawtV9Yp0o13UVe09f3Fm00kJoVR54MaxPi5K4YmgyUyR/y6JGiBGj159Hiy5NKY0MaXGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CH2PR11MB4280.namprd11.prod.outlook.com (2603:10b6:610:3f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Tue, 2 Aug
 2022 14:22:16 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%9]) with mapi id 15.20.5482.011; Tue, 2 Aug 2022
 14:22:16 +0000
Date:   Tue, 2 Aug 2022 10:22:13 -0400
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <peterz@infradead.org>, <mingo@kernel.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <eranian@google.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <tilak.tangudu@intel.com>
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Message-ID: <20220802142213.d2f6qzwl2w3sfm5g@ldmartin-desk2.lan>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
 <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
 <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
 <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bec1bc73-b3bc-50da-8aa7-0aab2328d62f@linux.intel.com>
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ef26082-6d2a-4eb2-896d-08da7492664e
X-MS-TrafficTypeDiagnostic: CH2PR11MB4280:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bh2gPWvYIJOJLQBsLPaMOk6OwP99xwUjwNgA3XQhAEfhiID8QvonggnHNtRTUa3ydc6NKxRC0NH4hEfUftCIm8ikEjRcGC05zh/gb4lIUZENuoxo62eG8m5K+9vQG4E3wu3gqdZg7njCTFUW5EITr4O62uZR2QFNUwQaIc+JU6TP/hZiwTKc0IO73RtAZ4guq9GZ2GwHWNMRB0xNiIiGEAFLTN+twpma+pWFOIPTZCCzabKCctloFp1Pkyukq81u8bsfDzv2SxlXsx09WzK3H4guJQg1qH8W8JfGyivcpzjef12vIZyNjL/XMX3gtY6kjFaZkCUnZt6tUe5H0Gc4UMiO/0J3lLxkgGTq0hkhJgY6XfcJjX3qZgcJnBxCv/zsrxJkkzHNskv7pA4M/pNmGoSoXlX9RoaVBBPh+j8lXpDPHyMG/uU+lyLGkJWefZBA7h7Dk2dVjQv7dye/lOiSBaS+4v1jj8mDnWg/VBdsSfV8+QUU+QsunLgtc0ZDQNZzcBT/aCsXSu8h6nwjBuh0E6O99d96HgX9IycYaXFOLm0kIUKnA9KN8fpFAOpPdObHfkx5AgBFOTkRN+WbPz2sjJVdWaZp0Gdz7/cqQNyoh3vlDQY4eCz5KQvYPwIwYN175wo/mwSBnZoEDEXBV1uQHQGtot2QVId6VagYw/IavcRkIcqcbPBzrEB9KcI6ltFdq6UiT+eJvJB8tlG5z+GSmPn+lBmFcyPsw04Q/CfcwsZjbd2fowCVtu+wGEQ23fhJy4O+xkpE0ZrfCtZ8DNOGuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(38100700002)(966005)(6486002)(6506007)(6666004)(6512007)(9686003)(26005)(53546011)(82960400001)(66556008)(41300700001)(478600001)(66476007)(5660300002)(2906002)(7416002)(86362001)(8676002)(83380400001)(36756003)(8936002)(4326008)(6916009)(316002)(1076003)(186003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ihMRkxS95qmpCs84C8PDnmGvnT+ggfNwf1gMvSG8G6s+85q/T7X2Y94apH?=
 =?iso-8859-1?Q?7ulvCBbFOqyaiBd3kuTKAX0jTPJewOGClINbVDYK86jr9oHWAeAo9hppco?=
 =?iso-8859-1?Q?mGRQNTuzBmobpg97vHj3++cqU9dvLeCxZRMO9ZgRwRtPHkXoksE/HXDDFI?=
 =?iso-8859-1?Q?tjGFa3OuGeIDGXbqkYB9QR+FlluZyCPhy2XADUmix6zTlDHGmwPrT4eVPo?=
 =?iso-8859-1?Q?6HdNoTO/KRUwK212ao38vQ9sWBnbvdpKOrQ1oGrMviwryFEReyaeMEFm8k?=
 =?iso-8859-1?Q?/NDAiofBGl19yRQ1+M3Euk+XRvhk3UFC1ZW1wmIUPyydql7nfK2l684eph?=
 =?iso-8859-1?Q?aPws1JBGVcCI0oK8Rz+q2CbfrTUI44xXenJvTusc5ZfixdyBxqENXMqVen?=
 =?iso-8859-1?Q?HIrIaCmJbLioX7axL8Yy3/WcVpFKGl9RoIOqFH4msGqoV4Y4d6zI/kPMhC?=
 =?iso-8859-1?Q?RX6hc6jkl/Xt2HO8qD+VQ4hAzN0RmHulJwOrROe61pch1EVsWrkk+69LbK?=
 =?iso-8859-1?Q?1Cg+sPVinwj5zZJDZYryjiEjl7Co+168SmyRw0Kti5S1zrMZM/ogalaz5+?=
 =?iso-8859-1?Q?g2sv76nNjB8cznAsSeWkcC2rVmXyIl8fhMDGiF0wyC2ZFpAmRJxHgTNvSw?=
 =?iso-8859-1?Q?vTt3gF1zpZMgek3vq8V/PGlKrqx5JdumBPbBSraZf1BIzsfLuOKmzr4Fma?=
 =?iso-8859-1?Q?5X0zK1f3Q/PcEGU5/fPYsFqPwUT3Izgy1qoRmT5hAK8yD8MBxxney0O6G2?=
 =?iso-8859-1?Q?ehKGRaCukftmwIYfhVF3bMBT2On0rkwjTnxo6olQcJMdufZdvvLCwfNQAk?=
 =?iso-8859-1?Q?yEbeSL+YPLlU2zdpqPNY+uv5kXHT6bltl9ueFcu7hIeUyGdhD9ZpOpIvcM?=
 =?iso-8859-1?Q?jX8KGk/hrqnp55lMhZ8avvVRNeSGy+EPQIXXbFjrfPgRYuqR1mUcVY83WW?=
 =?iso-8859-1?Q?Nh7Dgq830jYNqJUIWb+aYltJ3z290wowTZuOrXIMWnl9xr+wVtKYrr66Ye?=
 =?iso-8859-1?Q?Yacu/aFRpMjc9FQNBP3o3ZpsSLU6rz6rruAmmmqEZVBli7fHJQnuhoE44W?=
 =?iso-8859-1?Q?WPCLMNiwPrUy23JDyfLgwoXUCbq0xOX1T39PBe0KH29Csj+KUfIrUc88Ro?=
 =?iso-8859-1?Q?j9fn3g+Rii5bCw5sICePqw8Q+b1uX5VtCEmfbRP0hUdtTvb2fEWvYZKe5q?=
 =?iso-8859-1?Q?8vXkmyAuFaaYhR8qVT8uOisc7/Ldv93wLXki5cf8hiJVUAzmsJEGvv5PkL?=
 =?iso-8859-1?Q?XpREtd2c7QxSoZugWQoED3Ftq3Py7Hsb7yD1rzsXZRobxjiENFxCbfAboG?=
 =?iso-8859-1?Q?LgDCzpF0JiwLPjbF+k3KXoKpHTL3rtz+LMN0StrTtNf9JW+0QlXpEl+GBj?=
 =?iso-8859-1?Q?XmRn4RQ3bxd7C3bITOWvIxUCfe/dgOMHR17SoOO6QsrABO4G02lOQJXWvH?=
 =?iso-8859-1?Q?qoF0CxOs+dkvpVhqmhfBZFaNMheVDk4vbI2ue23zpra8U7vaaSwsEFJtkT?=
 =?iso-8859-1?Q?JsT5eGr129TP54GOUVBCbNkkjElIjDOvIITPch2osDHdG6f/bHTo5069CT?=
 =?iso-8859-1?Q?C5Vz1l4HLoRQv3ZfwJE9ujawxEierEToAi0nV4pE0HoWTntOD4NjT/aLgN?=
 =?iso-8859-1?Q?z7FosCqaH9QchuK58hEc/+KDQXJufQnv/VteyPCBz9m0/DjfiPFZOV4w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef26082-6d2a-4eb2-896d-08da7492664e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 14:22:16.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvwHbG6HV2mADtuSACgvkzGDfjvKKSCiBswAV5RpZsfbcTGLSfcZgnidLNNG8nOnRC2sImW/AhHctYDFzK8s31y5JInSAoUX4SNw2Tqi8hQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4280
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:51:44AM -0400, Liang, Kan wrote:
>
>
>On 2022-07-23 2:56 p.m., Lucas De Marchi wrote:
>> On Fri, Jul 22, 2022 at 09:04:43AM -0400, Liang, Kan wrote:
>>>
>>>
>>> On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
>>>> Hi Kan,
>>>>
>>>> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com
>>>> wrote:
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>>>> introduced with the latest Intel platforms. By reading through an MMIO
>>>>> page worth of information, perf can 'discover' all the standard uncore
>>>>> PerfMon registers in a machine.
>>>>>
>>>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>>>> a PCI device with the unique capability ID 0x23 can be found on each
>>>>> die. Perf can retrieve the information of all available uncore PerfMons
>>>>> from the device via MMIO. The information is composed of one global
>>>>> discovery table and several unit discovery tables.
>>>>> - The global discovery table includes global uncore information of the
>>>>>  die, e.g., the address of the global control register, the offset of
>>>>>  the global status register, the number of uncore units, the offset of
>>>>>  unit discovery tables, etc.
>>>>> - The unit discovery table includes generic uncore unit information,
>>>>>  e.g., the access type, the counter width, the address of counters,
>>>>>  the address of the counter control, the unit ID, the unit type, etc.
>>>>>  The unit is also called "box" in the code.
>>>>> Perf can provide basic uncore support based on this information
>>>>> with the following patches.
>>>>>
>>>>> To locate the PCI device with the discovery tables, check the generic
>>>>> PCI ID first. If it doesn't match, go through the entire PCI device
>>>>> tree
>>>>> and locate the device with the unique capability ID.
>>>>>
>>>>> The uncore information is similar among dies. To save parsing time and
>>>>> space, only completely parse and store the discovery tables on the
>>>>> first
>>>>> die and the first box of each die. The parsed information is stored in
>>>>> an
>>>>> RB tree structure, intel_uncore_discovery_type. The size of the stored
>>>>> discovery tables varies among platforms. It's around 4KB for a Sapphire
>>>>> Rapids server.
>>>>>
>>>>> If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
>>>>> will exit with -ENODEV. There is nothing changed.
>>>>>
>>>>> Add a module parameter to disable the discovery feature. If a BIOS gets
>>>>> the discovery tables wrong, users can have an option to disable the
>>>>> feature. For the current patchset, the uncore driver will exit with
>>>>> -ENODEV. In the future, it may fall back to the hardcode uncore driver
>>>>> on a known platform.
>>>>>
>>>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> I observed one issue when upgrading a kernel from 5.10 to 5.15 and after
>>>> bisecting it arrived to this commit. I also verified the same issue is
>>>> present in 5.19-rc7 and that the issue is gone when booting with
>>>> intel_uncore.uncore_no_discover.
>>>>
>>>> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
>>>> reaching pkg c6 state, even if we put it in rc6 state. It seems the pcie
>>>> link is not idling, preventing it to go to pkg c6.
>>>>
>>>> PMON discovery in bios is set to "auto".
>>>>
>>>> We do see the following on dmesg while going through this code path:
>>>>
>>>>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
>>>> 0xffffffffffffffff 0xffffffffffffffff
>>>
>>> On SPR, the uncore driver relies on the discovery table provided by the
>>> BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
>>> you please update to the latest BIOS/firmware and have a try?
>>
>> hum, the BIOS is up to date. It seems PVC itself has a 0x09a7 device
>> and it remains in D3, so the 0xffffffffffffffff we se below is
>> just the auto completion. No wonder the values don't match what we are
>> expecting here.
>>
>> Is it expected the device to be in D0? Or should we do anything here to
>> move it to D0 before doing these reads?
>>
>
>It's OK to have a 0x09a7 device. But the device should not claim to
>support the PMON Discovery if it doesn't comply the PMON discovery
>mechanism.
>
>See 1.10.1 Guidance on Finding PMON Discovery and Reading it in SPR
>uncore document. https://cdrdv2.intel.com/v1/dl/getContent/642245
>It demonstrates how the uncore driver find the device with the PMON
>discovery mechanism.

ok, this is exactly the code in the kernel.

>
>Simply speaking, the uncore driver looks for a DVSEC
>structure with an unique capability ID 0x23. Then it checks whether the
>PMON discovery entry (0x1) is supported. If both are detected, it means
>that the device comply the PMON discovery mechanism. The uncore driver
>will be enabled to parse the discovery table.
>
>AFAIK, the PVC gpu doesn't support the PMON discovery mechanism. I guess
>the firmwire of the PVC gpu mistakenly set the PMON discovery entry
>(0x1). You may want to check the extended capabilities (DVSEC) in the
>PCIe configuration space of the PVC gpu device.

However here it seems we have 2 issues being mixed:

1) PVC with that capability when it shouldn't
2) Trying to read the MMIOs when device is possibly in D3 state:

	/* Map whole discovery table */
	addr = pci_dword & ~(PAGE_SIZE - 1);
	io_addr = ioremap(addr, UNCORE_DISCOVERY_MAP_SIZE);

	/* Read Global Discovery table */
	memcpy_fromio(&global, io_addr, sizeof(struct uncore_global_discovery));

Unless it's guaranteed that at this point the device must be in D0
state, this doesn't look right.  When we are binding a driver to a PCI
device, pci core will move it to D0 for us:

	static long local_pci_probe(void *_ddi)
	{
		...
		/*
		 * Unbound PCI devices are always put in D0, regardless of
		 * runtime PM status.  During probe, the device is set to
		 * active and the usage count is incremented.  If the driver
		 * supports runtime PM, it should call pm_runtime_put_noidle(),
		 * or any other runtime PM helper function decrementing the usage
		 * count, in its probe routine and pm_runtime_get_noresume() in
		 * its remove routine.
		 */
		 pm_runtime_get_sync(dev);
		 ...

But here we are traversing the entire PCI device tree by ourselves.
Considering intel_uncore is a module that can be loaded at any time
(even after the driver supporting PVC, which already called
pm_runtime_put_noidle(), it looks like we are missing the pm integration
here.

On a quick hack, just forcing the device into D0 before doing the MMIO,
the PM issue is gone (but we still hit the problem of PVC having the cap
when it shouldn't)

thanks
Lucas De Marchi

>
>Thanks,
>Kan
