Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40ED4D3D52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbiCIWvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiCIWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:51:19 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1986C120186
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 14:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646866219; x=1678402219;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=blkBWuZ82G5eL82K+4bTAsNp4HZP5/vOW7sGidVRjzk=;
  b=MhIr9RO2uzVUSW2+zIxInFCqgqNYfs879gueLishVqKKynqUpOd3/QzM
   /jipVGRuMpG7Aiypb42Sgduqlev24djggVkKz8j6h9KcA7c9RGAagim3a
   LH1qUHndjXtm1N2QGw1RF24QfEyaqY15kbfb0oaKVh0hVwC8y5KZn+6bC
   HgajqNwvEoFPpW+wZx09BtUgjflSkFIWFq7nlATBf7o12mglkmGAmMeEB
   Y8UZmytn+1/dcZ0YHrxiIv/vL8bv6MqnxXSEy2FOyDYkQ8L0O7/koLrR9
   KhzJ0ipb/5esdBzwzAGTW26ebelMNCgc6r9eQrOqbPvs6/tO+j5vDbSdQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="315826609"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="315826609"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:50:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="496016774"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 09 Mar 2022 14:50:18 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 14:50:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 14:50:18 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 14:50:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6To+xrPKkpimLXEE8SBF/y+1ZqvTIrq8iBPXtVc1wa13r8FzQA9DzvheG4X9bFRhtqXaJgrXsPd7atxvtMWn1hTUNRTTKI21o/6FuOxVHYwESXNwuIwrhIFyX3QUVRgCgMRwGm0nwIIeq7akugbfsOCbcqT2vybwnnZ4VcqwBvU74NAyNnW8oVzsCvnI/T8mF1y0F73gRcR5sBxohpUQRSaVR/J1j1NOmD+3IPj31Bq1nJBI/RQNDGGXWHxk9I7WV9CPhFpFewOl3vLVXWCXUSghjLuHQN/f+8HaELvSEr/P5Be/kXLKq8T3axbofWchm4vPrMHgrHBvCEX+exJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/8Qb++c5slUEWSbp0fPFfOlE3HxDb3RtK4AcSGpLw4=;
 b=n+1HiWjQLhdZnEt9+T6nj5SAuRe0infpS5VeAfFwJx0QHJfPiFwAjOezjqqokMpDdCH2PiDtOyiVsmE6GiZ0w8CWl5WmEyeiLOTxlfXpJ1FiWrZ0VJHx0k6q6B0rzAls1Jh5t0xRWwXCN3qZSsbuvaoTpLjqtf8JwokTCdOGjBvQSTXB2q8YR7hIkl/Yp1GXPEmfhJtY96oUzntEr13dbxJFpu20wt4Dham5kDRoYiC9YneCZrkbrBVPD/IF9ws5NwJxV/mBcz3bZFj3qIJPa8ukDWdPk6v1fCVtJtSOqKssEA1unEwuWVKLxzru9auilEdaqRj4SHHLgryfAFWCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 CY4PR11MB1589.namprd11.prod.outlook.com (2603:10b6:910:e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 9 Mar 2022 22:50:15 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%6]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 22:50:15 +0000
Message-ID: <59bb4254-a672-f3c6-d1c4-ac03ad7b6248@intel.com>
Date:   Wed, 9 Mar 2022 14:50:12 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Intel-gfx] [PATCH v10 1/5] drm/i915/gsc: add gsc as a mei
 auxiliary device
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-2-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220308163654.942820-2-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::33) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77e96270-7bcd-476c-3bf9-08da021f2d4a
X-MS-TrafficTypeDiagnostic: CY4PR11MB1589:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR11MB15898947C871A7E286A28E9CF40A9@CY4PR11MB1589.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4m+oBtmUhr4/5uIdjhV25mvZEIolLAmmUNJ7zDbiBPHQADj3dVlUe6B/xAqvJLB1qZpk0hz48Wq23sNMyaDjE7LVZ1Cj77p8/Db5wqwmSajDCQQeXacV8Z7bgCIczrwMAUyO9aUCT0cLBXQ6rMkcO8iRgjfHOhZ5UgYFZZPdk7OwrFF+tTLhPOQdawFIDiUd5S3mNwkEjriYBgs2eRRNvE/lJReg2HohxfUTZsK8Y284JhESZN/O18zsZDGAD5DfQwe1w2yybhPixPEvNksIEI4DsB6vDhkqJJV5Prdrv7AhOTYaSbBb6vmoPpukrOWTcVA+3ehcP4RrU8/OevAxtT/dVohKzB6GvMVy4F819T5mKmNDeBa8GKrpCQcHRPonfOdMtiL/irtvvI/ZBsT78bpLwXedGjRlswplLeth5Ek7Uv1eL86nEHUiaGa0ImtFiJjWDx+1YXGr6C+qyz5kK5OCf8sogBkD+SCNsZbfHookpR9TkEijvNnSXb055ShgRhppYQtvtpnwHw9tukzZisOs98gEpVQh89QDvw0FbgYsIJ6+jT14TMsLVDvN3+jP73eyMk0vsFTOJT4/6KX2TZ8TwVQP+uoPQXXwyVxRCQei6Lg139oZJ1nrVnYHJmE0HAhc7tTPRLCmx9gEI/NDuH8crH69lxEH8kVejJ+3zGOfmxFSMoybWG8xPCDs7VgxQc0Sl9mCQmY9mCpS4/r2sngnn81fyu8QefZ0Cgjc0BFYEpA5ywr3VTFF3xkc8T7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(86362001)(110136005)(66946007)(31696002)(6506007)(53546011)(83380400001)(316002)(38100700002)(66476007)(66556008)(82960400001)(4326008)(8676002)(6512007)(6666004)(2906002)(30864003)(36756003)(2616005)(26005)(31686004)(5660300002)(6486002)(508600001)(186003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzhZNFBWZ0dXTzdvNVR5ZURPM2VEcDVGU1hkQ3JkdE9SUldlYVVBemlST3Z2?=
 =?utf-8?B?QTZzUkZPdWFjVklscTlmc0tUM01CVTliK0xyekwvdlA1Z2RnQk5mTXMxWDhC?=
 =?utf-8?B?Y3JoczMrQ3YwUDNHaGtLakpJclZ6c0tSeHdQWGZ3b2wzeG9kWEhqZGpzMllL?=
 =?utf-8?B?WnlJQ2lHRmw1dFg3aHN0RmlVYWdqYkdCMDljbVdoNCtFOTNaTWNyYnhYTnVu?=
 =?utf-8?B?cEhrb3VSWFRYdzdMV2g3TXVFN3Z4MHdHTXRxc3pBbnhGUU1ybzhnQjNUcVF6?=
 =?utf-8?B?Nytud0l3RDBSWlhDeWloN1VZWExlU29uUjZyNUZnUkRSKzVXZjRBYmpYb2tj?=
 =?utf-8?B?blJmMzVicmZUbm02aVVEUFdUSHBOZ1NyaHg0a2xXdEdOeXRxeXdIOGZSbXhY?=
 =?utf-8?B?UDBxNEQ4QlN3OFZWbHpsaGRnUFVYdUc5SENJVEVYM3NrazFuN0hvVXZHNVBC?=
 =?utf-8?B?ZzZ0ck0rdk02V2dNS2l0REx4aStKRFF3VlNVanR6STU2bk9hL2pReS85NjNZ?=
 =?utf-8?B?ajhINFQ0NGl6VG1ZQXM4WXkyQmFoY294aGFjdXExaTBFYnRoTTlHUWFDdFJ4?=
 =?utf-8?B?eFJCVnlqVHlpdktIL3h3bUtVRW8wamxvUUluK1ZPb1RpeGhxNFRkRnF3L3du?=
 =?utf-8?B?RjJCTjdCOFU5Y2I5TGpMTWFkUWlIb2dzdUlUMkc2REtEbCtPNWRFekhYWDZt?=
 =?utf-8?B?MEdyNTNLeGxGSzZVZHF3S1EyM1pDWUxlMks4eFBkTFRqbHQzTEg3cnI3OEZx?=
 =?utf-8?B?YTBEWUp0cmFNQ2VORnpFQnFBTVRIdE1VMlJJQldjaU1lZFhlaHJpSDlIMU9k?=
 =?utf-8?B?Q0hYVWtBUXQvWWpnUi8vRDNSODJWNlZvT0w5aTdkUVVWaW9vS0hQbHJLcUli?=
 =?utf-8?B?OEgveXBWVHQ0bzQrL2J4Q1FjK3BPVTlNcS9JcXVGcWg3M2ppa3pKeFVXMHdo?=
 =?utf-8?B?WWsraTd6UlNmRmN1RmpTczgzRndEdDhMSlc3YVpOcWttZ1phQmRyb2IzNndh?=
 =?utf-8?B?bGFTWEQwTUx3MktLOVJLd0dOOXRSNlc5azF0NTJldDh1czR1Y2RQelRRSmVF?=
 =?utf-8?B?MFc4YXFoNWttZ3ppZTZiamQ2aUpkRHNZMitObjdWWlRqbkZWd1ZBS0tGUTdu?=
 =?utf-8?B?QmJ4YzZ0SDBBWmhmbnRTd3FDWmg3bGdUYXBySnZlNlF2K0FqUmpyVk10UkJB?=
 =?utf-8?B?NWZFaEhxTlFKSUdXZ3U1aXczSVlSQVZTRXJYYUZRZ1FhRmZUN2ZjdFZCMHhT?=
 =?utf-8?B?NVhUbXczNlREZVlGTWRoVGU4eUZQUXVPUzFMRWpOY3VVSDI4ai9lRWlvK0ky?=
 =?utf-8?B?cTBLbTN5L0s3THg2ZHFmUTRGd2NCanRYdEVjZDdDaERPTVBrOHFuZXJLamVV?=
 =?utf-8?B?R0xKcVhLYTZJWjYxMWJkNjZ4cFVsNjJqSGZROFNFdVB6U2RIenFobWI2eGM0?=
 =?utf-8?B?NEFzRHlzZUVTTWlDMUl0VlpwTEQ1a0tpRVJudU92bkZ1MlVMdGRIYWZUM0Vq?=
 =?utf-8?B?Vng5REdPTUVRdzgwQm1hR09ncVhDZzgrY053Yk1EMmRadUxRaDdYKzBQbTFa?=
 =?utf-8?B?djhCTWxSUmxsK2xSb2ZEd3dNZlBMUU9ONlY2ZHhIR0R2dkNVWUl4Vmllblpp?=
 =?utf-8?B?dlVXWTFucmJ3YmVJQmNJV21aTmxiWHJiVTdwUmFNNGk4bStoQWVWSy9sbEJW?=
 =?utf-8?B?QlpPZHJrWm5VRUUxVTVIc05oY1Z0Nk51RGJsNWNLNm51UVFTc3pqcisrT281?=
 =?utf-8?B?cEhISGNJSVlsTU1wLzlmQ2lGVzZhTnpoYmRXcDNzaFF3QlJ0ZWZSdmJRV1I3?=
 =?utf-8?B?Q0YyVnFVcms2SHVva3JKcmVoRTMwek5XZTlCMEN5MmZJc2pvVzJSSkxobUdq?=
 =?utf-8?B?QTVmTGxnWlZWWG5pZG1HdE5UbmJ4RVUzQU9WZXVLL042TVBJU2VRTVY1ZlZ0?=
 =?utf-8?B?VnpWVDhLOUQ3Y1B1YkNoaUZNb3U4dWtJaHhPM1ZBUTRLNnBYVlRRYU9TUTk1?=
 =?utf-8?B?NWhOWVdlN00rb2RaWnl5QjBKV0tkVmM1SHJhTUlmSDNUSmRXU0JNbjc3blJD?=
 =?utf-8?B?Z1FlNVFGNVk4aE9jZ0E1T2RNMjlzV0k1KzZZMzA3REpsdlVNbGVwWG45OTFm?=
 =?utf-8?B?Q2EzcE1DWEdWSHNtWlZ4eFIvcERhSExVTDlGWFRPRmlZeDVUdWc0RUFUcjln?=
 =?utf-8?B?Q2s5cEQ0cnBTOVN5ZFQ3bFAwSldJbU1LWkZhVkV1bjRFUlNDMytrbTJUa1Zv?=
 =?utf-8?B?MGdWdk9HTlh3R0RIZlM2TS9mdURRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e96270-7bcd-476c-3bf9-08da021f2d4a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:50:15.5458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJRJqHEeW+BXYxW2Ck6+ogDlxN251G91CYWqb+wMrVpcK70ZjrctMIxDAU9mKcoCh4pu9OPQ6dGgv9chbBa9AK7X9gzN1SHc/OHZd+9T3To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1589
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2022 8:36 AM, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
>
> GSC is a graphics system controller, it provides
> a chassis controller for graphics discrete cards.
>
> There are two MEI interfaces in GSC: HECI1 and HECI2.
>
> Both interfaces are on the BAR0 at offsets 0x00258000 and 0x00259000.
> GSC is a GT Engine (class 4: instance 6). HECI1 interrupt is signaled
> via bit 15 and HECI2 via bit 14 in the interrupt register.
>
> This patch exports GSC as auxiliary device for mei driver to bind to
> for HECI2 interface.

Do we need a test for this? E.g. to catch the unlikely case where we 
stop exposing the GSC device. We are going to get some indirect coverage 
once we start making use of the PXP interface from within the kernel, 
would that be enough?

Also, IMO we need a line here to explain that we're adding the code for 
HECI1 as well because we plan to follow up with it soon.

>
> CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> ---
>   MAINTAINERS                              |   1 +
>   drivers/gpu/drm/i915/Kconfig             |   1 +
>   drivers/gpu/drm/i915/Makefile            |   3 +
>   drivers/gpu/drm/i915/gt/intel_gsc.c      | 204 +++++++++++++++++++++++
>   drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 ++++
>   drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
>   drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
>   drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
>   drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
>   drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
>   drivers/gpu/drm/i915/i915_drv.h          |   8 +
>   drivers/gpu/drm/i915/i915_pci.c          |   3 +-
>   drivers/gpu/drm/i915/i915_reg.h          |   2 +
>   drivers/gpu/drm/i915/intel_device_info.h |   2 +
>   include/linux/mei_aux.h                  |  19 +++
>   15 files changed, 303 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
>   create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
>   create mode 100644 include/linux/mei_aux.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1d296f92e9..d322e630d1d1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9822,6 +9822,7 @@ S:	Supported
>   F:	Documentation/driver-api/mei/*
>   F:	drivers/misc/mei/
>   F:	drivers/watchdog/mei_wdt.c
> +F:	include/linux/mei_aux.h
>   F:	include/linux/mei_cl_bus.h
>   F:	include/uapi/linux/mei.h
>   F:	samples/mei/*
> diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
> index 98c5450b8eac..2660a85175d9 100644
> --- a/drivers/gpu/drm/i915/Kconfig
> +++ b/drivers/gpu/drm/i915/Kconfig
> @@ -30,6 +30,7 @@ config DRM_I915
>   	select VMAP_PFN
>   	select DRM_TTM
>   	select DRM_BUDDY
> +	select AUXILIARY_BUS
>   	help
>   	  Choose this option if you have a system that has "Intel Graphics
>   	  Media Accelerator" or "HD Graphics" integrated graphics,
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 1a771ee5b1d0..9be7b13d8822 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -196,6 +196,9 @@ i915-y += gt/uc/intel_uc.o \
>   	  gt/uc/intel_huc_debugfs.o \
>   	  gt/uc/intel_huc_fw.o
>   
> +# graphics system controller (GSC) support
> +i915-y += gt/intel_gsc.o
> +
>   # modesetting core code
>   i915-y += \
>   	display/hsw_ips.o \
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
> new file mode 100644
> index 000000000000..152804e7c41a
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/mei_aux.h>
> +#include "i915_reg.h"
> +#include "i915_drv.h"
> +#include "gt/intel_gt.h"
> +#include "intel_gsc.h"

A bit of inconsistency here because intel_gsc.h and intel_gt.h are both 
in the gt/ folder but you're only prefixing one with gt/. Also, we 
usually try to keep includes in alphabetical order, but overall not a 
blocker for me.

> +
> +#define GSC_BAR_LENGTH  0x00000FFC
> +
> +static void gsc_irq_mask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static void gsc_irq_unmask(struct irq_data *d)
> +{
> +	/* generic irq handling */
> +}
> +
> +static struct irq_chip gsc_irq_chip = {
> +	.name = "gsc_irq_chip",
> +	.irq_mask = gsc_irq_mask,
> +	.irq_unmask = gsc_irq_unmask,
> +};
> +
> +static int gsc_irq_init(int irq)
> +{
> +	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
> +				      handle_simple_irq, "gsc_irq_handler");
> +
> +	return irq_set_chip_data(irq, NULL);
> +}
> +
> +struct intel_gsc_def {
> +	const char *name;
> +	unsigned long bar;
> +	size_t bar_size;
> +};
> +
> +/* gscfi (graphics system controller firmware interface) resources */

Should this comment be moved down in the array? the array has sections 
for both pxp and gscfi resources, even if the former are not set. Or 
maybe expand to something like:

/* for DG1 we only need gscfi (....) resources */

> +static const struct intel_gsc_def intel_gsc_def_dg1[] = {
> +	{
> +		/* HECI1 not yet implemented. */
> +	},
> +	{
> +		.name = "mei-gscfi",
> +		.bar = GSC_DG1_HECI2_BASE,
> +		.bar_size = GSC_BAR_LENGTH,
> +	}
> +};
> +
> +static void intel_gsc_release_dev(struct device *dev)

We usually avoid the intel_* prefix for static functions. Same for other 
functions below.

> +{
> +	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +
> +	kfree(adev);
> +}
> +
> +static void intel_gsc_destroy_one(struct intel_gsc_intf *intf)
> +{
> +	if (intf->adev) {
> +		auxiliary_device_delete(&intf->adev->aux_dev);
> +		auxiliary_device_uninit(&intf->adev->aux_dev);
> +		intf->adev = NULL;
> +	}
> +	if (intf->irq >= 0)
> +		irq_free_desc(intf->irq);
> +	intf->irq = -1;
> +}
> +
> +static void intel_gsc_init_one(struct drm_i915_private *i915,
> +			       struct intel_gsc_intf *intf,
> +			       unsigned int intf_id)
> +{
> +	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
> +	struct mei_aux_device *adev;
> +	struct auxiliary_device *aux_dev;
> +	const struct intel_gsc_def *def;
> +	int ret;
> +
> +	intf->irq = -1;
> +	intf->id = intf_id;
> +
> +	if (intf_id == 0 && !HAS_HECI_PXP(i915))
> +		return;
> +
> +	def = &intel_gsc_def_dg1[intf_id];
> +
> +	if (!def->name) {
> +		drm_warn_once(&i915->drm, "HECI%d is not implemented!\n", intf_id + 1);
> +		return;
> +	}
> +
> +	intf->irq = irq_alloc_desc(0);
> +	if (intf->irq < 0) {
> +		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
> +		return;
> +	}
> +
> +	ret = gsc_irq_init(intf->irq);
> +	if (ret < 0) {
> +		drm_err(&i915->drm, "gsc irq init failed %d\n", ret);
> +		goto fail;
> +	}
> +
> +	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> +	if (!adev)
> +		goto fail;
> +
> +	adev->irq = intf->irq;
> +	adev->bar.parent = &pdev->resource[0];
> +	adev->bar.start = def->bar + pdev->resource[0].start;
> +	adev->bar.end = adev->bar.start + def->bar_size - 1;
> +	adev->bar.flags = IORESOURCE_MEM;
> +	adev->bar.desc = IORES_DESC_NONE;
> +
> +	aux_dev = &adev->aux_dev;
> +	aux_dev->name = def->name;
> +	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
> +		      PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	aux_dev->dev.parent = &pdev->dev;
> +	aux_dev->dev.release = intel_gsc_release_dev;
> +
> +	ret = auxiliary_device_init(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&i915->drm, "gsc aux init failed %d\n", ret);
> +		kfree(adev);
> +		goto fail;
> +	}
> +
> +	ret = auxiliary_device_add(aux_dev);
> +	if (ret < 0) {
> +		drm_err(&i915->drm, "gsc aux add failed %d\n", ret);
> +		/* adev will be freed with the put_device() and .release sequence */
> +		auxiliary_device_uninit(aux_dev);
> +		goto fail;
> +	}
> +	intf->adev = adev;
> +
> +	return;
> +fail:
> +	intel_gsc_destroy_one(intf);
> +}
> +
> +static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
> +{
> +	int ret;
> +
> +	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
> +		drm_warn_once(&gt->i915->drm, "GSC irq: intf_id %d is out of range", intf_id);
> +		return;
> +	}
> +
> +	if (!HAS_HECI_GSC(gt->i915)) {
> +		drm_warn_once(&gt->i915->drm, "GSC irq: not supported");
> +		return;
> +	}
> +
> +	if (gt->gsc.intf[intf_id].irq < 0) {
> +		drm_err_ratelimited(&gt->i915->drm, "GSC irq: irq not set");
> +		return;
> +	}
> +
> +	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
> +	if (ret)
> +		drm_err_ratelimited(&gt->i915->drm, "error handling GSC irq: %d\n", ret);
> +}
> +
> +void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir)
> +{
> +	if (iir & GSC_IRQ_INTF(0))
> +		gsc_irq_handler(gt, 0);
> +	if (iir & GSC_IRQ_INTF(1))
> +		gsc_irq_handler(gt, 1);
> +}
> +
> +void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *i915)
> +{
> +	unsigned int i;
> +
> +	if (!HAS_HECI_GSC(i915))
> +		return;
> +
> +	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
> +		intel_gsc_init_one(i915, &gsc->intf[i], i);
> +}
> +
> +void intel_gsc_fini(struct intel_gsc *gsc)
> +{
> +	struct intel_gt *gt = gsc_to_gt(gsc);
> +	unsigned int i;
> +
> +	if (!HAS_HECI_GSC(gt->i915))
> +		return;
> +
> +	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
> +		intel_gsc_destroy_one(&gsc->intf[i]);
> +}
> diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.h b/drivers/gpu/drm/i915/gt/intel_gsc.h
> new file mode 100644
> index 000000000000..68582f912b21
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + */
> +#ifndef __INTEL_GSC_DEV_H__
> +#define __INTEL_GSC_DEV_H__
> +
> +#include <linux/types.h>
> +
> +struct drm_i915_private;
> +struct intel_gt;
> +struct mei_aux_device;
> +
> +#define INTEL_GSC_NUM_INTERFACES 2
> +/*
> + * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
> + * The reason for this is to allow growth for more interfaces in the future.
> + */
> +#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
> +
> +/**
> + * struct intel_gsc - graphics security controller
> + * @intf : gsc interface
> + */
> +struct intel_gsc {
> +	struct intel_gsc_intf {
> +		struct mei_aux_device *adev;
> +		int irq;
> +		unsigned int id;
> +	} intf[INTEL_GSC_NUM_INTERFACES];
> +};
> +
> +void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *dev_priv);
> +void intel_gsc_fini(struct intel_gsc *gsc);
> +void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir);
> +
> +#endif /* __INTEL_GSC_DEV_H__ */
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
> index 8a2483ccbfb9..fd83ab4b8849 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.c
> @@ -444,6 +444,8 @@ void intel_gt_chipset_flush(struct intel_gt *gt)
>   
>   void intel_gt_driver_register(struct intel_gt *gt)
>   {
> +	intel_gsc_init(&gt->gsc, gt->i915);
> +
>   	intel_rps_driver_register(&gt->rps);
>   
>   	intel_gt_debugfs_register(gt);
> @@ -766,6 +768,7 @@ void intel_gt_driver_unregister(struct intel_gt *gt)
>   	intel_wakeref_t wakeref;
>   
>   	intel_rps_driver_unregister(&gt->rps);
> +	intel_gsc_fini(&gt->gsc);
>   
>   	intel_pxp_fini(&gt->pxp);
>   
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
> index 0f571c8ee22b..de779a505c21 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt.h
> @@ -34,6 +34,11 @@ static inline struct intel_gt *huc_to_gt(struct intel_huc *huc)
>   	return container_of(huc, struct intel_gt, uc.huc);
>   }
>   
> +static inline struct intel_gt *gsc_to_gt(struct intel_gsc *gsc)
> +{
> +	return container_of(gsc, struct intel_gt, gsc);
> +}
> +
>   void intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
>   void __intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
>   int intel_gt_assign_ggtt(struct intel_gt *gt);
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_irq.c b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> index e443ac4c8059..917b85d0c189 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
> @@ -68,6 +68,9 @@ gen11_other_irq_handler(struct intel_gt *gt, const u8 instance,
>   	if (instance == OTHER_KCR_INSTANCE)
>   		return intel_pxp_irq_handler(&gt->pxp, iir);
>   
> +	if (instance == OTHER_GSC_INSTANCE)
> +		return intel_gsc_irq_handler(gt, iir);
> +
>   	WARN_ONCE(1, "unhandled other interrupt instance=0x%x, iir=0x%x\n",
>   		  instance, iir);
>   }
> @@ -184,6 +187,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>   	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE,	  0);
>   	if (CCS_MASK(gt))
>   		intel_uncore_write(uncore, GEN12_CCS_RSVD_INTR_ENABLE, 0);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE, 0);
>   
>   	/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
>   	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK,	~0);
> @@ -201,6 +206,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
>   		intel_uncore_write(uncore, GEN12_CCS0_CCS1_INTR_MASK, ~0);
>   	if (HAS_ENGINE(gt, CCS2) || HAS_ENGINE(gt, CCS3))
>   		intel_uncore_write(uncore, GEN12_CCS2_CCS3_INTR_MASK, ~0);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, ~0);
>   
>   	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_ENABLE, 0);
>   	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_MASK,  ~0);
> @@ -215,6 +222,7 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   {
>   	struct intel_uncore *uncore = gt->uncore;
>   	u32 irqs = GT_RENDER_USER_INTERRUPT;
> +	const u32 gsc_mask = GSC_IRQ_INTF(0) | GSC_IRQ_INTF(1);
>   	u32 dmask;
>   	u32 smask;
>   
> @@ -233,6 +241,9 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE, dmask);
>   	if (CCS_MASK(gt))
>   		intel_uncore_write(uncore, GEN12_CCS_RSVD_INTR_ENABLE, smask);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE,
> +				   gsc_mask);
>   
>   	/* Unmask irqs on RCS, BCS, VCS and VECS engines. */
>   	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK, ~smask);
> @@ -250,6 +261,8 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
>   		intel_uncore_write(uncore, GEN12_CCS0_CCS1_INTR_MASK, ~dmask);
>   	if (HAS_ENGINE(gt, CCS2) || HAS_ENGINE(gt, CCS3))
>   		intel_uncore_write(uncore, GEN12_CCS2_CCS3_INTR_MASK, ~dmask);
> +	if (HAS_HECI_GSC(gt->i915))
> +		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, 0);

This should be ~gsc_mask, right?

>   
>   	/*
>   	 * RPS interrupts will get enabled/disabled on demand when RPS itself
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> index 19cd34f24263..a277fb480cc8 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
> @@ -1483,6 +1483,7 @@
>   #define   OTHER_GUC_INSTANCE			0
>   #define   OTHER_GTPM_INSTANCE			1
>   #define   OTHER_KCR_INSTANCE			4
> +#define   OTHER_GSC_INSTANCE			6
>   
>   #define GEN11_IIR_REG_SELECTOR(x)		_MMIO(0x190070 + ((x) * 4))
>   
> diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
> index f20687796490..5556d55f76ea 100644
> --- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
> +++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
> @@ -16,6 +16,7 @@
>   #include <linux/workqueue.h>
>   
>   #include "uc/intel_uc.h"
> +#include "intel_gsc.h"
>   
>   #include "i915_vma.h"
>   #include "intel_engine_types.h"
> @@ -72,6 +73,7 @@ struct intel_gt {
>   	struct i915_ggtt *ggtt;
>   
>   	struct intel_uc uc;
> +	struct intel_gsc gsc;
>   
>   	struct mutex tlb_invalidate_lock;
>   
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index 943267393ecb..1c000c15493d 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -1327,6 +1327,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
>   
>   #define HAS_DMC(dev_priv)	(INTEL_INFO(dev_priv)->display.has_dmc)
>   
> +#define HAS_HECI_PXP(dev_priv) \
> +	(INTEL_INFO(dev_priv)->has_heci_pxp)
> +
> +#define HAS_HECI_GSCFI(dev_priv) \
> +	(INTEL_INFO(dev_priv)->has_heci_gscfi)
> +
> +#define HAS_HECI_GSC(dev_priv) (HAS_HECI_PXP(dev_priv) || HAS_HECI_GSCFI(dev_priv))
> +
>   #define HAS_MSO(i915)		(DISPLAY_VER(i915) >= 12)
>   
>   #define HAS_RUNTIME_PM(dev_priv) (INTEL_INFO(dev_priv)->has_runtime_pm)
> diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
> index 67b89769f577..a948f566bd3d 100644
> --- a/drivers/gpu/drm/i915/i915_pci.c
> +++ b/drivers/gpu/drm/i915/i915_pci.c
> @@ -901,7 +901,8 @@ static const struct intel_device_info rkl_info = {
>   	.has_llc = 0, \
>   	.has_pxp = 0, \
>   	.has_snoop = 1, \
> -	.is_dgfx = 1
> +	.is_dgfx = 1, \
> +	.has_heci_gscfi = 1
>   
>   static const struct intel_device_info dg1_info = {
>   	GEN12_FEATURES,
> diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
> index 70484f6f2b8b..0ed305ff07a9 100644
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -975,6 +975,8 @@
>   #define GEN12_COMPUTE1_RING_BASE	0x1c000
>   #define GEN12_COMPUTE2_RING_BASE	0x1e000
>   #define GEN12_COMPUTE3_RING_BASE	0x26000
> +#define GSC_DG1_HECI1_BASE	0x00258000

Do we need the DG1 HECI1 base definition, considering we're not adding 
HECI1 support for DG1?
Also, we usually put the platform name (DG1) before the unit (GSC) in 
our defines, so DG1_GSC_HECI* would probably be more inline with the 
rest of the defs.

> +#define GSC_DG1_HECI2_BASE	0x00259000
>   #define BLT_RING_BASE		0x22000

IMO better to move the GSC defs to after the BLT, that way we don't 
separate it from the other RING_BASE definitions, given that the GSC is 
not a RING and its base is something different. Not a blocker.

Daniele

>   
>   
> diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
> index f9b955810593..576d15a04c9e 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.h
> +++ b/drivers/gpu/drm/i915/intel_device_info.h
> @@ -141,6 +141,8 @@ enum intel_ppgtt_type {
>   	func(has_flat_ccs); \
>   	func(has_global_mocs); \
>   	func(has_gt_uc); \
> +	func(has_heci_pxp); \
> +	func(has_heci_gscfi); \
>   	func(has_guc_deprivilege); \
>   	func(has_l3_dpf); \
>   	func(has_llc); \
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> new file mode 100644
> index 000000000000..587f25128848
> --- /dev/null
> +++ b/include/linux/mei_aux.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022, Intel Corporation. All rights reserved.
> + */
> +#ifndef _LINUX_MEI_AUX_H
> +#define _LINUX_MEI_AUX_H
> +
> +#include <linux/auxiliary_bus.h>
> +
> +struct mei_aux_device {
> +	struct auxiliary_device aux_dev;
> +	int irq;
> +	struct resource bar;
> +};
> +
> +#define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
> +	container_of(auxiliary_dev, struct mei_aux_device, aux_dev)
> +
> +#endif /* _LINUX_MEI_AUX_H */

