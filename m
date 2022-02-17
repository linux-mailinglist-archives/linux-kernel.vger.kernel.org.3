Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76ADC4BA8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbiBQSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:47:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiBQSrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:47:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550E3CFCD;
        Thu, 17 Feb 2022 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645123656; x=1676659656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vs50ltVaGLoFEBqxiXWMJKJ2QTs9h3WvZNh7saWvcug=;
  b=AqLwRV7vV88rSwG24bnSKFoRe/vRhtZSTGex5o1reQA+fbACwB3hk0ru
   yQs9JAH7Y/H0JeSBB8AAFMBBvfU+Nq1xSjvWXTAGKsTsUhR7iwNbl6hpq
   PWr095f8KuA2ha3a83V6/q+tD1HPHZ3FWOK4ZX9teQNKOX+Fnb+G7nKpu
   GZAWozEzEaDWdhzKJT9dNE7h9J9D8tyob9YcfsRUnZBHtxITiZhEAZOX+
   vsz0gAn+jqOxvBKfuZB7IQ5acOJYQpo5BFkOEv4IBpoTIAkj6EHZ+jYrO
   e6qnZ/C0s/UNqX2lK1yw5ijfkuAotsSIydMf40vlZ04ppqcVfPt0msyQJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="314212438"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="314212438"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 10:47:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="530433241"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 10:47:32 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 10:47:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 10:47:31 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 10:47:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZX6Y4sd80sssetYvLZZClF5ksid+SQfnfmnvepUiENV9x3WoPK4a5Fsx2Z5Qxe8IuJ/sNo1sq9y6bFyBnlf9gxSCfQDExRqnLLxUIcXp1Vy4H1Urlv9+gUT47kkeert/xVTfaEZrcWY1pPy+vSYBkVj6HnCPOwZ/93JP9Q65aHJOAhS5fQCdt2PeMqQnOPuxAIC2lUzyENTikEuFjcALixbIJ/Iqmyt5WFwdeOhqY6T1d0g6jJmRg1HpABXnXaRdS4KKQ2i1UPp3xbzmYUI8BadQ4+B42v9eCxkghOFLmOw7ib/P+wh/63TPrkU6NESKHGjXOxa3Yy8N0kx5r0wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYrTr5pFa/KkGxGKHOWK0MrBCPRATZ5cwZk5qj9rBgM=;
 b=hZBmD91R0y2k20IWECQwFWibHEwNiXcyV17epKr+H6bFcXCuqVnQOmJttNqPcSJunpJ2Ttba8QrPePJQRq5uJCD2shKqfVAtA3811lfZfbJCJMeJon/rdNTUngr1kUs6BPbdoeJTFO25g18OAZiNRzcC6XRoAt0qihRzXpmrLkYOqL9Ghhtm3956Pb70gPaWw0uVsKf7T5jWE4AE4xxLodGzD9njTFeNjVZlUL5csfhycRsElqaeAX2izdanSlIAp3jF19u4tEYbjWw08YTGMV5tRlrNM6RM5OzsPZo9ZCHDlBbvdKS+OErBB1rMFH/E+lj4r+S/FXBf0ezwUnHeGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by DM5PR1101MB2217.namprd11.prod.outlook.com (2603:10b6:4:52::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Thu, 17 Feb
 2022 18:47:29 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::55e4:9a32:8e6f:4774%4]) with mapi id 15.20.4995.016; Thu, 17 Feb 2022
 18:47:29 +0000
Message-ID: <870ed4bd-814f-cf0a-01a6-25807f59f6c1@intel.com>
Date:   Thu, 17 Feb 2022 10:47:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH V3] x86/sgx: Add poison handling to reclaimer
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, <tony.luck@intel.com>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <tglx@linutronix.de>, <bp@alien8.de>, <luto@kernel.org>,
        <mingo@redhat.com>, <linux-sgx@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <dcc95eb2aaefb042527ac50d0a50738c7c160dac.1643830353.git.reinette.chatre@intel.com>
 <91fd3b35-b791-af37-6663-9c37055f339e@intel.com>
 <cec52989-04b0-5d5f-06ef-334abec10d14@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cec52989-04b0-5d5f-06ef-334abec10d14@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3427801-da54-4c3a-5734-08d9f245f2ed
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2217:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2217749D31BBD653CCC54329F8369@DM5PR1101MB2217.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfwbOPPnOAOyU2Qknc1V+NdHtTbfFP8RibPS/hzmdE7qaNyynfcwxj4wplbJ5HDd8xICa6mMTBlpHlDBD68GG855FDPB45rPwHMpbH3SzO+ajCgiYSPXvIQb2eNzc3aF36klcXbE/v6R4Llec8xgb+aiNZPQbSNVmi67LcH2HPZZqhrzTipjk8i27VcOH4te8h7k2reYT34qacOgNfpamtf0viT7Edyt+TYlV7gWhGypgSqFES75HECdAQPEww81xj+Wsl5mARRL0VEgOGEmJ14oQWPdAYSZtiAHF/0q9hslpbNUsfqwgLgOoI9RQhr7aHSezxQNsSCUfOsqAQE+LatSkDgEZ96B5PUEUAxxNQwRbX4Eqn52jRPMpI4zDZZKipKu4FPgfBROcT9LEBoLhOjzjI4PrFMYArA7tiBI9fb9+Hb6TDT9udW4MTg6F6XJ05SBKQ2VOViSAcuJJtTQRCjroAnVJohl8oKTEnKVdYAaK/4ANdsCMXdLs0ZXTBjJ4DEZA94QXdvneCt7qQg+qbG398PPkUGdwfZ+rXXYOC6T/MlIdVwWrdofZn4h7qrkuDWpoF4hZ8qU2fWLNV1QVf8wGU3Fqe6DxTSaB01PE9Go+ZuVujQr0Xhz4lD05K3/h+y7KszdEO8HAVYm7fQ8E1awTZx4EBFC+eekQs3OvmUaU9AXV2gzOzJd4GRZgtrBi+TLpKx806NVxhNtbzOkbdjNrHo6TQR1ykNEMv0Q3nRIUeo+osW/uFqbvQKmZixngUNxjiNpSSbpRDrkAIzhWBYItwGAhktl672erBfHlhixzSil37F0BLPSu2+RMSpV0tmG0UKe2RKJ4pvAhe0AAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(8676002)(66946007)(186003)(66476007)(66556008)(921005)(31686004)(2616005)(26005)(53546011)(4326008)(8936002)(5660300002)(4744005)(83380400001)(38100700002)(36756003)(6512007)(44832011)(316002)(6506007)(31696002)(966005)(6486002)(6666004)(86362001)(508600001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnV0Zll5dTd5R0dEMVRCOEpMOW5jYk5DWGlKZE5lRzNFSmJYcmFDSGFTLzA5?=
 =?utf-8?B?N2poOFJvVGFmZHhSNFMwNitwTlF0UHJLbUxscnF0djVkMVdvclBVZGZZd0R5?=
 =?utf-8?B?V0xnazdyblFPR0pldWZIYUJKQ3A0bXNKL1ZxSWJvd0M0TEFtR2U2Y3hGWWV0?=
 =?utf-8?B?clhTNTRxZ2xDY1dLSng1bjZhd0tGbFVXNTVyNnArbHg3UWFZckNtalFJK0JS?=
 =?utf-8?B?Ry9UVVljUHE4aHVlUkMrUHJDWWxFTU5xZ2wxWGdFYlBaWlk3S2ZxaWd4ZmZP?=
 =?utf-8?B?eFRwZHRXRG55em9pNGt2NWx6UVUrZHhyVlczZFMwREZlYVhTT3RMSlM0WUNI?=
 =?utf-8?B?SDAzNVVMWjRsVEI5R2VLUjFmUGhaUEJDS3Nvait3Ny93dXhtdzFpQWVmRnVn?=
 =?utf-8?B?U3MwZzJSUnlvb1RiTFZRZFRFRmdsZ2dDT1ZNbjVqTkdLckpONGY5enFyWW9s?=
 =?utf-8?B?MTB0T1pPMlRUd2RYN0JVZmZHYlJsZEVvOWxyMHlJZXk2MlN4eE9GenhPdkts?=
 =?utf-8?B?Z1BMOE42cXh6NHFTemdSYWcyaWUyTXBFTGZyNHJreExucDlHOFVCcE13bmVO?=
 =?utf-8?B?UWRRNC9LOGt6TzIxeGZ4SjJOVUN6MXVtQWs2aDdRMW9vNytlMGVGZjRYT05W?=
 =?utf-8?B?Sks1dnRrRERZZjFDQ3JTZGszdTAyNURTYmtwMEhWcW8xQWlJUUZOZUVNR25S?=
 =?utf-8?B?M3pCWDdlTkU2MUlYS2Zhd2o0bzVGWDAxaVRDU0lKT1hGeTVOMlNaTFR1THJ5?=
 =?utf-8?B?dTR0M2d0aVpPK2YvQ2x3REJiQnNocjFndlhoNnBxcWVQSXo4QUVyczRBcURC?=
 =?utf-8?B?RDMwQ0pHY2Z4Mmx4YURZTGZiY3NCSVdHUyt5OExtUDh6K1p1cWJpTWU1TEhv?=
 =?utf-8?B?NytrcDdiUElKV1JUNGFnZTVkTWhMNVpSQlJYb3pmT29QMUxuTnBCTWdRTzRn?=
 =?utf-8?B?S2RMUnkwQjlZRUNCdWExUFNZWUNMOGlSYXlSbkhFbHdQZlEwZUYyS3NOeGRE?=
 =?utf-8?B?N3FQT3BvVG12M2tLSGN3end5UmxrY1VuYVJuOHhCUnR3aWp3TzVibXNZclZR?=
 =?utf-8?B?clZCNTI5SU1XUWR5aUZ6azRoYTlXcU5GWmhIK2MwbjJFaWVqMmJydnZiZklo?=
 =?utf-8?B?UnZzcHJ1WTRvUVBnTnlmajhqNFNUR1RBeUQvdXMzTkIyMWJxUURwTE9helFn?=
 =?utf-8?B?NjBER29zOUttanBtaEJmWjJ0WWNUdWo0UWw0YlJ5eWJ5NEdmaCtkTHowdGxm?=
 =?utf-8?B?bWk1UGVBK2FEUG5jd0xUUXY4MzdVdEhBemJCTzlqTzJMZy9MZkpkQWo2M3V3?=
 =?utf-8?B?a0lTdXNXbmNuVXVyTWxRd2ZQeElackxOT0RLY09vdkE1bm54SmRDTDBUZTFR?=
 =?utf-8?B?YXo1L2xQcnF6eWFwbm9sVzYxMWhJb0YyYkw0UWZmQS9kOEhjeFBIZXF2eUp1?=
 =?utf-8?B?QzNhYkh2TnlyNU83R1ZmM3h6M25vQnJxMGQrdlhvUkpqcENHYjdzWllqVW02?=
 =?utf-8?B?RzhtbnZBR3A1TXF1TEpBUDRFWkVwWndyTElkVTlwdEVmTkxwTitiVk0zaGNl?=
 =?utf-8?B?WnpoOVdRaTVjUTQ1KzFmSzJBZUFENUZKVzVGZzdqcTZKb3Jzc0MxT2Y4Q2Qr?=
 =?utf-8?B?cHpnekMzUWdsVkJxUnVTblU2ZG5maVZnWjYyNDJqc0xRYjVnZFZiMCtiQ2pX?=
 =?utf-8?B?T3FNOCtTTE1RM0lScktXRGg3RjVVejl5Sit3cWJrUFNmNEx6NTliUXkyc2dp?=
 =?utf-8?B?SG01Tm5GUWFLaFRkWnNocUdUTUZEM0ZmejJwUUxjek4zNWZpOC9jODdtTGVG?=
 =?utf-8?B?MU9SMHgvSXl3Q2JaT3J6OGdZVkVWRlVqWHJVRTNNWHY4UjA5OHV2U0Znc2lE?=
 =?utf-8?B?dG0vVWlWVU4xWG5Pak9CZ3hLdERqUXRZSlNFbW5Sb0NJb0xMR1EydklSZUY1?=
 =?utf-8?B?aGZDaTBPbUkwYStZNWNZZHZNa09LRTlKa2czY25DNXQwUTNoNEtDcUdWOXNn?=
 =?utf-8?B?ZDFrdGY5Vm40bGZ6cVhJaHBEYk1FdmtDR2YxUW5YM2tWc3dKcEdxOXF0eDY0?=
 =?utf-8?B?OWRseGR6akpUME9OeEZ2Mm9neXlKVzRYTEszWG85OEpjc0NQYktYS1p0YnNs?=
 =?utf-8?B?NHNtbTh3TnhWMktMRXdad2Vqai9nbGxKRTVUL01CYlFqM0pPa05LV3dIWGVG?=
 =?utf-8?B?cTNDMjVzS0ZycVAvYlBXVWxNTGFLckp5VVVrS1gyUDU5ZXRKazdLOU80WXF1?=
 =?utf-8?Q?5stLNp9J9pntC+uSyQPDAYTiSKTmEkuqdJdbXFNo1Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3427801-da54-4c3a-5734-08d9f245f2ed
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 18:47:29.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zO45XgF5aF+1e1hGCx/puiYVLfR6/g2Bh6jvUhMEyFzWtHHeIJdCScAgWHhgBNiLLvH3DLzr52Y8fEaECjpWd4sBIg9/V8JQNfxEnRHZJEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/17/2022 10:26 AM, Dave Hansen wrote:
> On 2/16/22 16:25, Reinette Chatre wrote:
>>> Fixes: d6d261bded8a ("x86/sgx: Add new sgx_epc_page flag bit to mark free pages")
>>> Fixes: 992801ae9243 ("x86/sgx: Initial poison handling for dirty and free pages")
>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>> Could you please consider this fix for inclusion?
> 
> Thanks for the reminder.  It's merged here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=e5733d8c89c3b5

Thank you very much. Also thank you for improving the patch subject.

Reinette
