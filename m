Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792D657F102
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiGWS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiGWS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 14:56:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD541658B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658602591; x=1690138591;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=yXhvTUPZeesozTYUfFx5AhW708bcG5gUi//LEsIIhX4=;
  b=I89LCNaqpHSiHHMrooiNH50idsJKYXftmuARWpl6J58y34UVm4SJnRi2
   er33A4T1YK2Lu8QkwPpAdPLkfgFRSctsAiQw38ymLafi9ICUUPi012NgH
   OMgv/elPLjRcv2FBPw/Rv2Qfvbe9tSqdWMhFWokZLDrju6RmZqHGWV8uN
   i/U9Hc+PgGtdLw3OT5TT/PXqZ0vNrvLRYT1FNkPAByxhpK8upiyAgaWAH
   DRCf5rL1KpeTM2PMXYXty13KLhiYLeJib+sczwcPd2Kweu+JqO0MNxI6b
   oSehYrZvlrIlGJkdkSP+QaU6W1ASdPC1HugxAiRnxq+BJm7KFikfF36RB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="270524236"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="270524236"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 11:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="702017962"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2022 11:56:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sat, 23 Jul 2022 11:56:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sat, 23 Jul 2022 11:56:29 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Jul 2022 11:56:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhCgCr87NZqnfYlJoyVQgWFKTqBmJgPqYou7V12KFXNL54rSXOPsTvzTZvob1i8aYTuknMdKledQqcjIoSs6TMuDORlZZhvh/jKNSpsQ5dbdPDYjZc/WJKdycxJG2aIh+12Dt00XzTCLTjaa4TvNxFvydB3I0j6XC2JxhYi3JtN38SWQJQimdwtVtkylR1u8UrPnLyNMg2hEj+CUHW051vifZyiOYBMMr5sCHPmF61Eohb5AxwY+qXpYhGu5KhmVgQ7Tu5m91wmjykVrlEpuSHZdRpblAjCEobhZgyuVMfcpxwHcT9I/p3f72j2MoDqK3HbAaqpd3bVSsCqOysHHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7K4tZF2a6gq/YiJPrI+t/J4f2AjyHoMAHPdxNjIBsw=;
 b=QUijugfHn5lWBdSA4WPhCvpzSoehx41oPt3M+m/HiKKj/w6DdmE3tLLsm91jtdNSQfRbS7MKKgAKG+HCPIwfDkmYE5t4O9J9Y1AfpKxZDny2YviqdilghgEB/5sAcC2R/eLQGxGdH7ymTYtPB85EN1R5Dj4qZ2/NXrN0sdmSstn4o94Qgi6nQH+ushl2PphXwGDiecBAFG4NTbIynNlxAZeByc9sDNhgtyFwg7zHW+2heBpPzGxZoG9aWoDKkMIGZD8ewxqN8LcRi2WUg2TJyxAY9UqctgDylzrPc2L/MnQ4QtLvVW8mRK2ThJxTwfapY3HOvMCOAp8shfuLRICWTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Sat, 23 Jul
 2022 18:56:27 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%8]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 18:56:26 +0000
Date:   Sat, 23 Jul 2022 11:56:17 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <peterz@infradead.org>, <mingo@kernel.org>, <acme@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <eranian@google.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <tilak.tangudu@intel.com>
Subject: Re: [PATCH V2 1/5] perf/x86/intel/uncore: Parse uncore discovery
 tables
Message-ID: <20220723185617.vz3swht66lbtuwzl@ldmartin-desk2>
References: <1616003977-90612-1-git-send-email-kan.liang@linux.intel.com>
 <1616003977-90612-2-git-send-email-kan.liang@linux.intel.com>
 <20220722125552.fmljascpvmi2b6ec@ldmartin-desk2>
 <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c122462-afa5-bdf2-8bfb-910ff59ada03@linux.intel.com>
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57dbee21-94c3-4820-1bda-08da6cdd0b6d
X-MS-TrafficTypeDiagnostic: PH7PR11MB6356:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0FiPcT8fBzhLTMmXIZoHfBZGpUUKHQ2ivv4t8pwj3zu9bnrtSp3bDBo5VxKFWc+sdcKY0FqwXO//rlkuT3nVcyO8R9vfweSrM5mdcGMVgQB+pQ4sATBnDxIrpBhOO2/xVBSDFhZ0gCzAHHKZ8F0rXjUpKlnocj+j2JOTytLNVqXct4yXOjFSpeGWzAtGYtxZnkoGQQ+tUXCishICvmYdd+ZylMIFnGyBy230gnRVcbsFmWjAYcncNzyyUcB+N0uvc7A2k3EBwrR22CaWx+APdW7LFsZpkzknnCJVRgnR1QXgJjx33LlMYYaNEbZ9D6VC0n4uLf+RmJGgVUU4mcFsnRAU/Q6hHALcsXmBXv4lWn/KvLKbTHhHs80DVjU4oMKaqtF+2SN3g+vphavr8UomUPgP1rEtETLznxI74Xze3fSYVPsJQYNJyEeAe3LrbuhKqWd3BZz5u2L3BAOV/2tEpdsIc4uKrL8HMd/pUz71jjnUv1bb6Vbh5D0sloSs3z8X3t/LPg5pLBZaJLNZjRmw7NzQ+djSpIt72Bd/UofmA4cL4XOxDfjAJJNSrMQbNObd17H9B8GsSHwN0pn21PvXs6hYNV1Fh+zf9jEINfRVlHDs/Uwf7kUzqEcwE6YHkF7fstBcl/qRS373uHOOt8OyY63r5NZb9CV26vfoMzQcSpwQ1GsLPhL649SKY8dHpzhT2psJ0EFGxLz6KATL/uQu/fdRugJCHX6TRDSf/D2wC98=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(376002)(136003)(366004)(39860400002)(9686003)(86362001)(186003)(2906002)(83380400001)(8936002)(33716001)(6486002)(66556008)(5660300002)(7416002)(1076003)(38100700002)(6916009)(6512007)(6506007)(26005)(4326008)(6666004)(82960400001)(316002)(8676002)(66946007)(478600001)(41300700001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zrCJ3OgDcGAkxoFZxkgRCgCg2+Z3hvanrXeFzIzkpSoaQKNkuWaDf6D15e?=
 =?iso-8859-1?Q?3CpezUWx3DCgFXStB69QiV0wH8IlRYedYnoPKT+K0wJIBIkXXibJeNsUVi?=
 =?iso-8859-1?Q?7ejkAh/pThFCqIlkJZu6oRX+pVKnUJxpL3lKtvcNHL/+Gki9AibfROsZFa?=
 =?iso-8859-1?Q?EvyZwGpEBpPwuxlBCpwvCVK1JOdSBV23fXCIUQROmsSVZJ6QsbNUCCOkzV?=
 =?iso-8859-1?Q?FHPqzRIyLLmTuPsC2Gj2Ix6pvmWJI5T1eOuqsPUwitK7Ri0D1upJgqi1i4?=
 =?iso-8859-1?Q?tz/upkR9a54OCRFGguEqx77vaqCFD7spn9lVfIOPs8YOU6lxfdo/LaDnDk?=
 =?iso-8859-1?Q?M6OMWZ1zZxvsieC3O9NBbgw5krVMXfWmJ7c3w3vLo4qO3lroWd5MS+UNJe?=
 =?iso-8859-1?Q?OX22dlMtgfqPv2RU3YfauEvBOdKpybPgzHvf3JQR+klYfTaQ4qXubCn0DY?=
 =?iso-8859-1?Q?UruY4n/WOPR33rzQdb2Ys8QHjOulV5oKcnVykz1NTR9UtsSNyCVVl2NxAW?=
 =?iso-8859-1?Q?o6RMNzpgNt4rzZ67BQB0WkjgBEMpK6v6JPyL6YYGnJPvPdvIRyyXD24hwU?=
 =?iso-8859-1?Q?CGzVW5DaCjUAh19sNV2C5ZaYhvR/ZLXS540u9eQNPkWHCKyx+lqPwtrNOs?=
 =?iso-8859-1?Q?HRjvpAEZ7oC5tJO1evGTd0P7BQp/fyXkPe0CBbhgp2zbuSDNALMlmJYwq8?=
 =?iso-8859-1?Q?uTLlQvYSl9uzM2SfN4h1rfsMgdpvkM+swnkIxT3fgJWB+UAdH3ailIKTG2?=
 =?iso-8859-1?Q?2wq/uskkEdOaN0wYmeK8whNkcDUcmn7uuVUhyt8f4vGWyKPuo8PKPhXfeW?=
 =?iso-8859-1?Q?d69M3iKjbTArrqbMi5J2ayDLXUoyAk5ftKcvKjq6D9bPt/F/5cEkVbyDe2?=
 =?iso-8859-1?Q?Pu6GOLzYq3rD4G5MaKIHYZC4/9qUJiHvb4WmUh82H4hHJaUkwQGS0PvSfa?=
 =?iso-8859-1?Q?G0DpBU3li1Xf5zECY9OuqJnP2kSrU/HSHT3hZCQgj9chfNwIZz/N4aWZnW?=
 =?iso-8859-1?Q?gg+KSCIK2HaM4QRw1LFEUF36xhmBfoOfwQBDRQWyRP6K0CQmoxAmlnjvQw?=
 =?iso-8859-1?Q?YHKJZQYOOsgDZ7UchUk0zvxs0JAIt9zcA8D69Ldspw45eyN4ZxXIbAmM+M?=
 =?iso-8859-1?Q?4VvSi+gwN/Elf3w3hnoR7gUhvabej8RWn++vXl/P9o/Z7HRiNPpsU/JfWl?=
 =?iso-8859-1?Q?NJI03qVeSFbl2bVcpVy33xEl2SZWVmke1cXK0cPmzxGkLDbtnRVSB1qvPU?=
 =?iso-8859-1?Q?TPJ8BSn5VVV9JlYhULd1ULOIuslPvTQJtqhHR+FZ1vgg5oztkQ13qtafW8?=
 =?iso-8859-1?Q?a6IJuSdhVYJfEKIlasCRhvJUJLJCuTlufy94n9bln88VXJYrDo5rNt+Mv6?=
 =?iso-8859-1?Q?D+94ftKGSn3FDfRGsdkoEmQ01e4IDOWvdVCnSqNI2OEnz2euNtI33wodgs?=
 =?iso-8859-1?Q?IdWOoIBcVkOkjB2uNK30Ks17bhQJQEdnAMURrf0rnyjNyMMN4p3f2nbdOH?=
 =?iso-8859-1?Q?BbHpNnCcmXHgzVURcFWsijSkJoOlGnBaFfRazq7MBxCQZafuVdig/YccF/?=
 =?iso-8859-1?Q?ZYKudqtw9f+dGGhZ6NqL2GNCQDDW8dgKIIhPB238P9/djhQz2n42WESQyW?=
 =?iso-8859-1?Q?7pr8WzmcLsH7e5DScL4XEj0f8KRFcN0YhqeTlDY9yImlFwMhGmc4Im6w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dbee21-94c3-4820-1bda-08da6cdd0b6d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 18:56:26.5380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skPtfnLypLCJsSDfQXd+bN8FPh3S8sm5umEgF6k6wO1cYyVCmipX8AkZSCR2nJPkO6We01G/LsdXh2CnGfumduTQIvlEjKCtLm34uRWippk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 09:04:43AM -0400, Liang, Kan wrote:
>
>
>On 2022-07-22 8:55 a.m., Lucas De Marchi wrote:
>> Hi Kan,
>>
>> On Wed, Mar 17, 2021 at 10:59:33AM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> A self-describing mechanism for the uncore PerfMon hardware has been
>>> introduced with the latest Intel platforms. By reading through an MMIO
>>> page worth of information, perf can 'discover' all the standard uncore
>>> PerfMon registers in a machine.
>>>
>>> The discovery mechanism relies on BIOS's support. With a proper BIOS,
>>> a PCI device with the unique capability ID 0x23 can be found on each
>>> die. Perf can retrieve the information of all available uncore PerfMons
>>> from the device via MMIO. The information is composed of one global
>>> discovery table and several unit discovery tables.
>>> - The global discovery table includes global uncore information of the
>>>  die, e.g., the address of the global control register, the offset of
>>>  the global status register, the number of uncore units, the offset of
>>>  unit discovery tables, etc.
>>> - The unit discovery table includes generic uncore unit information,
>>>  e.g., the access type, the counter width, the address of counters,
>>>  the address of the counter control, the unit ID, the unit type, etc.
>>>  The unit is also called "box" in the code.
>>> Perf can provide basic uncore support based on this information
>>> with the following patches.
>>>
>>> To locate the PCI device with the discovery tables, check the generic
>>> PCI ID first. If it doesn't match, go through the entire PCI device tree
>>> and locate the device with the unique capability ID.
>>>
>>> The uncore information is similar among dies. To save parsing time and
>>> space, only completely parse and store the discovery tables on the first
>>> die and the first box of each die. The parsed information is stored in
>>> an
>>> RB tree structure, intel_uncore_discovery_type. The size of the stored
>>> discovery tables varies among platforms. It's around 4KB for a Sapphire
>>> Rapids server.
>>>
>>> If a BIOS doesn't support the 'discovery' mechanism, the uncore driver
>>> will exit with -ENODEV. There is nothing changed.
>>>
>>> Add a module parameter to disable the discovery feature. If a BIOS gets
>>> the discovery tables wrong, users can have an option to disable the
>>> feature. For the current patchset, the uncore driver will exit with
>>> -ENODEV. In the future, it may fall back to the hardcode uncore driver
>>> on a known platform.
>>>
>>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>>
>> I observed one issue when upgrading a kernel from 5.10 to 5.15 and after
>> bisecting it arrived to this commit. I also verified the same issue is
>> present in 5.19-rc7 and that the issue is gone when booting with
>> intel_uncore.uncore_no_discover.
>>
>> Test system is a SPR host with a PVC gpu. Issue is that PVC is not
>> reaching pkg c6 state, even if we put it in rc6 state. It seems the pcie
>> link is not idling, preventing it to go to pkg c6.
>>
>> PMON discovery in bios is set to "auto".
>>
>> We do see the following on dmesg while going through this code path:
>>
>>     intel_uncore: Invalid Global Discovery State: 0xffffffffffffffff
>> 0xffffffffffffffff 0xffffffffffffffff
>
>On SPR, the uncore driver relies on the discovery table provided by the
>BIOS/firmware. It looks like your BIOS/firmware is out of date. Could
>you please update to the latest BIOS/firmware and have a try?

hum, the BIOS is up to date. It seems PVC itself has a 0x09a7 device
and it remains in D3, so the 0xffffffffffffffff we se below is
just the auto completion. No wonder the values don't match what we are
expecting here.

Is it expected the device to be in D0? Or should we do anything here to
move it to D0 before doing these reads?

thanks
Lucas De Marchi
