Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366A148F353
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiAOABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:01:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:29554 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbiAOABt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642204909; x=1673740909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+I0DHEqXvIcqyHT0b1XF5TcVZAJbWDrxs/rxJUk68Zk=;
  b=FZF/Jlt2JwSxpXlNozyG53g2zr+uUDdZfaMw/HVGWr8NFxkou9kqpcsh
   8hjQU48cOeDBSO1G+696GmBu0MC2V+wnpGqNgs1QeUL/WK/NTOy25e0PF
   ZWWlHH49dcbALUuwCWGKZ1FFcsYtEmpZ1Y5epJYTDqo8aD6iOPHDAmwXe
   ujxYp7jH2C2BiPLBYSmaCXinzirjKrjVDyhK4zTcyAoJDACXlGvwCeJG5
   RwHt2hc3cLXgzkYK5qg5bxQnga4d+jCqoOLCsRPNRaj2uzKMCbuPecPen
   m49srRnKMr5h9A+iVvLINGEoO/WmO0402GKbWgTb8u3IqJnTRIepWhe9L
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="244553321"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="244553321"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:01:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="614499949"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2022 16:01:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 16:01:48 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 16:01:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 14 Jan 2022 16:01:47 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 14 Jan 2022 16:01:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcotFqNUXVz1ud9UXxwdYYBHj+K9vdKY5L3Mqzdm037AtrhcQ3mPJRkYEMU5nb9NtFbU757P9OUiIzTJqoE1GnovoKff6sM2Mfu9HOJxZlw06q7TZ0SaPe1fJA4wl9F0M4gmrRLT+/NDqlqm69qczajpxVkpKDarl/GjYSW+2/B84EDfG6on6LuyPdDT12SlVcX7jOmvR0VRabOdvFUfb7e7Dszwgg7GMYg6hz3Zy7CSHxKhIT+eI1Df+PcOdntVRlqhvULYZ+NYj6UYYvnap9idfrGPHf9wcyRvdQ24en7fpg9JytwQwZD1DR8IZvv3B1K8YBFnLuMZMR2Es8AXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPrtISgpByoDWg0TXVFWUCfmV8XMnAHBm4D1KVgm4J4=;
 b=Ni3Sq8p8uK037u1RQudhkLV3UocEoNDtpiw1N4WQ46SYeUIQ7OS9WBsHeE9ujIT2GtKr+c8JUJW+8dwYPikoa4dkPWS+ygEIXWNo8vMB2AM+Gl1DPiKLiYnhZ64M2SEh3THYtmAGFsJQJDDY0aDQ4QblaM9m7JXAoKRlJhuoCmTPK0CoF3ExIZotBPlL50L/7ELERcHW9j3eFqlgZh4wZ+MfAQKFV0JtXwWwM6jj5XWHsWRpitmNuv+ms7Z7mwSnc6D6UD9z/UWINn6TpuKtZchT2ZQZ1ZtNp8HqqIaS6f/9eFb+1JhtH7In8vcFGl72sXwY+mea3nQefCZjjPFNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CY4PR11MB1895.namprd11.prod.outlook.com (2603:10b6:903:126::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Sat, 15 Jan
 2022 00:01:39 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::a113:192a:3201:1e0%9]) with mapi id 15.20.4888.012; Sat, 15 Jan 2022
 00:01:38 +0000
Message-ID: <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
Date:   Fri, 14 Jan 2022 16:01:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        <dave.hansen@linux.intel.com>, <tglx@linutronix.de>,
        <bp@alien8.de>, <mingo@redhat.com>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <seanjc@google.com>, <kai.huang@intel.com>,
        <cathy.zhang@intel.com>, <cedric.xing@intel.com>,
        <haitao.huang@intel.com>, <mark.shanahan@intel.com>,
        <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net> <YdzjEzjF0YKn+pZ6@iki.fi>
 <4195402f-cbf9-bc75-719d-22cea8e36e60@intel.com> <Yd9pMq4lUy56B+50@iki.fi>
 <Yd9qmMx7NO450mzZ@iki.fi>
 <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com> <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com> <YeIEKayEUidj0Dlb@iki.fi>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <YeIEKayEUidj0Dlb@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:300:95::26) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e966b52-e3d6-420e-cf63-08d9d7ba33e3
X-MS-TrafficTypeDiagnostic: CY4PR11MB1895:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB18950F5699E2E27720F2854AF8559@CY4PR11MB1895.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NLzOaGKULG6LdOguYo4tKjekUCDeYi0q3bp/RbB6wZR6pHQucv/brGyScG8o2pStsn6sqlRGiJYM50JVnwJw510twXy7hLoFVnGl4DzmRSe4DtwLWxDbJzxQa6jT27HY7dZh4p3tLVhViUymgVPXk4Ek5qhMOI0kzDAGER29vM7r9zlXQLtqL3lNsSh7pt+OriAqA+8DqHfT/1JFW/dIM6LqC6lRKFhG8ud1cizkYtELhPzJUBfrwGfKvBJkT2a6azsstPy7rzUYE5ysszDa+/cg5867u6fkRVLf0d2q1rSnQI6huhGFpFi0l2LB3dpwi1TtCK9f/sQng9ZCmv6CatxIgw94Q9pPeuakltYaoeAHO9k0mMVLEA77QceVIjCYWmRy0YUNRd1Y3NiRDsIFRaTPt+yONkXzz23w+fcS9YNsJp97GcdBcutrH18QEZfKltjwjkglWTgi8St68q0UCUrEtzlBRf4OqbtiA75Ozet/80NOKIaljHJeGd7wVN6p4cHeE3QGJ6MqDT5Vv0fIY0aaQUS3L2mRG7kpa1pc+k5HHYkiA9b+Akw9F8VPYDE8+xH/GcAzusGe7rVD08j4JEX6uQFe4m2xW/09RIiZvSoAAw0pLuIP52hqEf75XTodSbSk6yT2vUzG217sZA5+wyzYeskJ/Q6PnmLrSEqRO348DOK04wrhCD4z9H+1jftOgOPfkNj6M36eZVuRmWtWusQe21Rh1Owp+jhOQzpLQ1bRa9PRE3z7nGjki9y7qaLXmzRSnQKEEFrrPFpTaIkzPL0UxbhYhGErUj9pzA6a4LARxl/LPeAdvrdfEmJ0ZD6sWW4Ny4OfyKAL4XYjdjQiFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7416002)(54906003)(508600001)(5660300002)(36756003)(6512007)(31686004)(53546011)(6916009)(8676002)(6666004)(83380400001)(316002)(26005)(6486002)(66476007)(6506007)(186003)(2906002)(38100700002)(4326008)(966005)(31696002)(66946007)(44832011)(8936002)(86362001)(2616005)(82960400001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blJONXRBRm5xWmtPeXBYYk5EeDVFQ2pYOFZPN0M1Zy92WXpaT1NyUWkwUDNn?=
 =?utf-8?B?NVdTYzFoaW1kem1XTm9yZkg2WEd3dnFNaWNFT1dQVmZ6VEJpN2dmL1JzNU5p?=
 =?utf-8?B?YisybnY4dmRaRnFPN3hQQ3ZWM3h3eVFocWNYRlNtVlNZN1Q0UnNOcDd0QzdU?=
 =?utf-8?B?S2plRmdLV2RjM2w4WDhHd1hhSlJKeXQ4NDB3aFhQQkFxWlNocnFXMmxyU1lt?=
 =?utf-8?B?dGpjUDFtWEJMTWx0M016Qk1kZ21PY0FjSk1naUYwQnlaeEdvV2o2MFBacWhK?=
 =?utf-8?B?QmZldlpBLzhnc0E4REVOUlJCckFheEJuZmVtcGNUUkZWbmkwVjdCYUIzZExx?=
 =?utf-8?B?LzZRWDNTREhvdmFWREQrYnpBVENpNitZeVJ0d1pEb3B6ZytyZjlZeWdGRDV1?=
 =?utf-8?B?YlI2VS93TGdGcHJTNzZJU2g2SENBVjZyTGYyMFh4OTVwbU5oVmx5QzhnTFBz?=
 =?utf-8?B?N3p0TkxoUDh3UERLVmNqWThOQm5ycFlkTkVyaFdUamtMN0p3dmhubHpLR3hU?=
 =?utf-8?B?N0tkOWlTWnVmU0JyNDNRem1idzFHbDBxRjhnSE9wUEQ3NkJVOU1jMDRnd2Y0?=
 =?utf-8?B?NjM5RzRSeEd5dHk1b3V3V0o2RldieW5ydFZ3TzJNUkpjTUhkSmNZbEJtSE5R?=
 =?utf-8?B?b1VuMXN3d1cvdzBPTUowSGcyaVNVWDRWQjlwUWlya1k3Tkt3RmZTcHZjNXFG?=
 =?utf-8?B?VmkwbjhYQlR4Tm8yMUNLdEt5Q1VSeFpRL1ZOemh2MjQybkVSSnR4bHdGM1pt?=
 =?utf-8?B?TGlWM1MxMkIrbEs1YnJzckVhTE5FNm1qZ3k5cG5FSlVucHJoTTBRVkhUZmxB?=
 =?utf-8?B?amx5RkhVbFVTTmwyN0NUTFpPUjgxZFFwU3VjaUVsS0FHUk5SZVRFTnl0emVL?=
 =?utf-8?B?Ny81NTE3OC9JbHFaV2FlQWh2c3B0dlRIQlpUYW1WRlZRU05ycHBiZUR2ZTU4?=
 =?utf-8?B?bUxPdU4rL2xjWUtIVlNQOTFPUFlhMmROUUVsZ3lQRUJwbEg5QWJaZytST1Fr?=
 =?utf-8?B?UnZKRlJsMXVmdzVYd3UySVk5MjZsaHc3RDRuSFVvRWpiRG5wTFBJM0tSSjZn?=
 =?utf-8?B?bi9la0ZsQUlDc25KZDNBSVhOY2M1SmpOcGQ5NUpYU0FpU0VMMlo4VVNBR2VD?=
 =?utf-8?B?R0lEK0ZYbGdTZ2VWNW53MWhOZm1nNTdCT1E1YTZqWkYzekRlQk1MVm1NSnFm?=
 =?utf-8?B?MGRqN2l6YjE0aWEwN3RuTXUvKzdxY1lLb2IxMElxbGNmbzl5blp2ayt3VGZw?=
 =?utf-8?B?d2NjWWdIRTRIa2FGbE1Vd25xR0NoOTBoWVljN0JibkN3NFpUbThyaFMyb0hN?=
 =?utf-8?B?aE1WZFF5czBpeHdwWHptdG5aMlA2REhyVGN1bXFqT2N0NEZnZXJxMHJuMndX?=
 =?utf-8?B?cXlkS0hNRkVUY0MvaDdycHI1SDQzYWM1Zk84UnBuNXExckxkaExndEpNbnZP?=
 =?utf-8?B?QjR0SFRsQ0ZrWkxQZjJrUG10a2dxbHljci9TT3l6ZitCVTBOTytIVTZoVHhr?=
 =?utf-8?B?QWVrVXpLOUgxR3YwczJnYlhqdzhoV0tURnl5MWpqVDZ1KzlmY09TY1RHYzZH?=
 =?utf-8?B?K0RTUTAxUXRNb2c2VVpPb2ExMkdldk1qUXlqdnBUcFhsY2QyL3paV0IvZnp3?=
 =?utf-8?B?cHlRVHJTVk5hdlZhdmFCRXgrdGNEWi9RcnY3a3NqMnJCSnAwL3JyOXZpSktU?=
 =?utf-8?B?WVkvTkljekpjdTIwdzdFN1FCeVhwaURjdGJqVHY5WmFVRnV6T3gzc2V1dGtV?=
 =?utf-8?B?eHYwMVhka0hNS09sbm9EVEdXN2pHRUhVNkRSVG1pckozY0c0K1pqYkZTYk9O?=
 =?utf-8?B?NE5SYWYvTDlWSnhOV3VqMitWdzRoZXdTaFJKQU9FNWJNNzJsTStTRzhvNnNO?=
 =?utf-8?B?SEdlV01tK1AzVk1PU3IrMTJNWHo2Nkw5eklKOVRtMDIyVXNKNHNCdjk5M3Ns?=
 =?utf-8?B?VHdaMngyT2ZETTFSaFNKV2ZZa2RrdFQyUms2S1IyV1o4TEdHVWtIcXNTbURx?=
 =?utf-8?B?NVM4NitPQjFaRnNpc1MvTU9EQTE4ODJYb3g0Ykl1ODBHTVFPUGhTN2F6dy9P?=
 =?utf-8?B?RkJUVE54Q0VpSkw0dEVrVFpKTUdRQTRnK2Jqb0dKMmYvUXZ2aU4yZGdpWk1D?=
 =?utf-8?B?Y1k4U3l6dGl0LzNRWnBkUnNyUm5waHpXeW9aSFBkK0xEUmZrbHkySjI4V0pV?=
 =?utf-8?B?ZTlZS2E2WnFac3A0a1NqSlkwQ29KQ1I2NmNlQjZoUFROcFdZMWpVMFZBZDA0?=
 =?utf-8?Q?Jnj9DXJZIZlhcAlp5MwJ4+If8D/Lz0S6vGJLpPsxuw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e966b52-e3d6-420e-cf63-08d9d7ba33e3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2022 00:01:38.8950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TLVwOptThRn7J7Ikhe5nKNdSnnhqdyNpS7JjrzWowzQhtIbOsw/5jRU39yfrJp2yM4iBnNQkmD3oDrdGCXQcIxFqgnSLT6zABZnozvf5aRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1895
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
> 
> How enclave can check a page range that EPCM has the expected permissions?

Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
time the enclave provides the expected permissions and that will fail
if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).

> 
> I'd expect OS mistrusting enclave to do such check at the start of TCS.
> 
> Otherwise, it cannot be sure whether EMODPR was ever requested, and thus
> it plays zero part in the game.

The EPCM would always have a PR bit set after EMODPR was requested.

> 
> You would get equivalent level of security by just modifying the xarray,
> and not doing EMODPR.

The xarray is an internal SGX driver structure that can guide how the OS manages
page permissions (via VMA permissions or PTEs). This brings us back to the
fact that the OS is not trusted and a malicious OS may install PTEs that
allow full access to enclave pages and that is why the enclave needs/wants
to control its own permissions via the EPCM permissions that are managed
with the ENCLS[EMODPR] and ENCLU[EMODPE] instructions.

 
>>> It's really hard to ACK or NAK EMODPR patch without knowing how EMODPE is
>>> or will be supported.
>>
>> EMODPE is currently supported and you can see an example of its use
>> in the testing code that forms part of this series. Please see
>> "[PATCH 11/25] selftests/sgx: Add test for EPCM permission changes" where you
>> will find support for calling ENCLU[EMODPE] added to the test enclave and the 
>> "epcm_permissions" test making use of it.
>>
>> After running ENCLU[EMODPE] user space uses SGX_IOC_ENCLAVE_MOD_PROTECTIONS
> 
> OK, great.
> 
> A minor nit: please call it SGX_IOC_ENCLAVE_MODIFY_PROTECTIONS. 

Sure. (btw ... I was following guidance from:
https://lore.kernel.org/lkml/Yav0%2F3jeJsuT3yEq@iki.fi/ ).

Reinette
