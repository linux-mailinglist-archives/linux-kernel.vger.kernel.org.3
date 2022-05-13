Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DBF526EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiENDAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiENC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:59:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FE638DEA1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652491518; x=1684027518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xtuyyn9xLqSLhEAjM5Z6SocixCUJlyRK0sexUOcsrYM=;
  b=bdt302b4EfanRB6XA8tChKQ/23b1jBNuZ48nPUe4yY0NS6e90hLIszzD
   nT8Dil2ntkb1l/CN78M+Vb/VvGLjI+H980fxAyp/h3wNAIr19NRNcdC4q
   MNtiz4gImQCsaHH7lCgHw87xH6mUXeexxobyDqHG4SHCTG0WFPuvQbB7r
   4L/b0HONuUwBc9ziFhp6CgIK25tcifbRlXbOiaBnkA4H2J6BFpTKA5xAX
   5K8cBgyWCZF9p+K3FQ96psZwdzwQczc3G6zA1UNOJzFgSwQ8E5F2j/hzB
   dnKMfklYqKa9DaeHZkTiHbdNu8f4X7GCE6Wob3iLKEO4171OAWhVSfvnT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="270569565"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="270569565"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 16:50:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="573212209"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga007.fm.intel.com with ESMTP; 13 May 2022 16:50:07 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 16:50:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 16:50:07 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 16:50:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZCf12lvZOKyejQUlrdWuo2+LirhSTjPVeSD6zj42mO82Vgjv1MPcCWQRF/6tEf7YiehVCopcRyI0v9LP5Wohwz69PvUESHvdckDiPs14Xz3aqIeIgDIa5dih9GNvUKOuJ9e7tr5iD5y9uTKOQtRUdB/Fkyezn6NTB97ZcN6yzu+B+eeCSc54scDK8t5auvVGgP9tmfPbjiizLnqLI0OgeGcsgO+Tcp3wVASQfPn8u//UuUbd2rHzNkO7cYr9WUzKgnWH0najku2AgVr/5f0JRneT/xWeQIq2xp+b9Zcr+ZgtNIy81tew1S4W9SE87XVWYRjrH9RMVAPX6m+2WwDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtuyyn9xLqSLhEAjM5Z6SocixCUJlyRK0sexUOcsrYM=;
 b=n0rXa4UvhsU5DkqDiaWuzxMcJo8UpCOORheu04WRwjxkYTzp+BRQdZGb986l7rFMxO2QRewqB2bm1W9y4AGnkf3h9tQQNu44PdMCcCsuOlgrRgro+yzwtOTptEacOD6CwUl90UPYrHLRzPC9Qir9xl62bDYt6sUW6X8TeDEezSqKgwVCA3hIIzidf+yPXHR7beX4TYt06TtqT3zfV5Bm4PTdAxi5Qye8fB4kBMRaaxcEPcCf36x76s2dfX/g3Mqk5kA6yh02G3snsj30ERshQpJ2lZmkPl1B3vrCEb5QdicnRHFqh1hDwzEMTWPsEUlHbo9S4qTVvoMLYaETu3KATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 23:50:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.016; Fri, 13 May
 2022 23:50:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Topic: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread
 features
Thread-Index: AQHYZOBkvB2PlILtfUOVczGp43rrrq0c3EGAgAA5TwCAAF3QAIAACzIA
Date:   Fri, 13 May 2022 23:50:03 +0000
Message-ID: <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
         <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
         <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
         <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
         <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
In-Reply-To: <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99603b00-577b-4e0b-0acc-08da353b4cca
x-ms-traffictypediagnostic: PH0PR11MB5926:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <PH0PR11MB5926F2ED32A273E41522D02BC9CA9@PH0PR11MB5926.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78iUAX2iSjSr8cme1xgeqEB6p458nciEn21piACBCDfJndZlO0tDiSP9LLEfgjkLiHbenDo7NYwRSWhpdDnIgZr3R9wAHDWEonJ1ohwOzQaw9jZW5wL7d0/nI6wXnwwL5SkQ6UxfPHuVDiOOGG2huLq97Y0eBN91bFsSoxHdGzBttduIVKlcv0TVcc0ecoFw9OpASn5BA3kRfP6fzbrkD7hXQtAwkV3cT7uNu9q0pdMFWiaW4l5uKCP3p32v/z0nNS1PzPCI1YT4jMTe+L3Xcry6nzKL7y5Vf+GcpkF3emB3eeUN0wgEuURcFO+jK62AGe3Ta2uGJ23DeaLIku8ZubgjB+HnNZ837bBFsEKl8DcwfwRiTAw8JaH65HFEQS+TwWEmddarlxS7sOUcSJdQLt/bxh3WsxkHPhBvACh+5XSvV8lrWTVSmDkMdn7Ds+LnDsEjKXUN4zdTHtbshBej2QKmD3G5AQ4KfSNTNy31h8Y5IlXVFEL6BIQoNi2Xi+Fpl9ww5whLsirQBDvYWEF/BSBsx5nRzGPQIJz/V94SD+Cb7QFFkew4StAGYzJxAs2xer0Pktp3oloRmeDq/IThg44W6XPUra+xB26TQH4Hf8aIrwxUpbjVKRceHg1b0bOOIPQ1Z14H3EJL6mZP4IyXOqYza+AvNRor6G4Vl0WLLxdTiM+rWj0ARQJ4THKxgV5i3sGCmOkpwh9+R6ZHvUpkLTxNT7QyVPk6TMFVZvoxVV0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(64756008)(76116006)(26005)(36756003)(2906002)(66946007)(66556008)(66446008)(66476007)(8676002)(4326008)(38100700002)(38070700005)(71200400001)(54906003)(6916009)(91956017)(122000001)(82960400001)(5660300002)(186003)(7416002)(6506007)(6486002)(86362001)(8936002)(508600001)(4744005)(2616005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEJ1UHo1Y1huZmlEMUZkZk55Yndmc3JjamhPOTduaTVXZFJtL2wycTJjQzNs?=
 =?utf-8?B?UGRDaDFDOWdEbHM5OVY2TkVia3hYTU1TTzNobnBuU0p2eDdHNVJqYnhPMXRn?=
 =?utf-8?B?eW1DNWZUMjk2c0tTR2MzcHlCbGR2cUdyc0k1NWFwTmVNYWh6dkRzaGlkVHoy?=
 =?utf-8?B?blFjUkl5NU8xVzk3RkdZc2dlZ0k3VjlOaEJQUVY0alNhMzN4bzM4anVsR3h0?=
 =?utf-8?B?VXQ5YUxtMFVFNjd2U2VkUlYvWkdsV1VHOGxIcWhIN2tRTEFodkNYNFJJMU9p?=
 =?utf-8?B?VXllaGVkRXUyRGJQMS9sV1BXbDQxZWNLWkZmTThZUithYnVRTVJlUngyd0sw?=
 =?utf-8?B?SzBEYTVGYnQyZ0x1SCtDYlNEd2dDWjJGWUF3KzhVQmtab0xNUHZ6Qm1ZeUdB?=
 =?utf-8?B?c3dKeVNGc21Fa2I4ZVNFeTQ5RmtTdHlIclNqMzVIanVZdVNleVFET04rRVN4?=
 =?utf-8?B?b3M2T1VWUmhTam9xS2RaWmF5T0FkYUhLck5xcVN0THg1YkhOT3EzaUdCVlVu?=
 =?utf-8?B?TlRCTm5vc1JPRU93OHc3cWpDYkVzYklXbmRGaHN2WmxqWk5RdklRUzlTaHFG?=
 =?utf-8?B?UnQ1OEZzRHF5VFdHbWR1YU5kWjNxRnhJWFlJWThzcVcycWttYUNxc0g1NkpK?=
 =?utf-8?B?L0k1NnpydC9QUWRnTWozV0c4ZVp4Z01pcUhGNmlKQ0NVa0srZXFSZmUrV0ho?=
 =?utf-8?B?NlBqdUxab3BabXBucU9tWDBmeHhIRmxkYVRtWkRYUThoSExPcFE0ZUdYYzZH?=
 =?utf-8?B?eTlMRG1TK0loQUFRdTFLNDh4VFA0Q3IzNnkwd1dDUmlaanpkdzFZWktIVzVW?=
 =?utf-8?B?OHF0YTlrV2wwZmhwaHQ4MzVIMEprRFN5R2FqYW1Hdm1vVFcyRVNnU3JzR1pi?=
 =?utf-8?B?QzRjQ3RoMkF4eXJNajVYNXhzKzdhckhTN2FmTmg4eCthenZSOE84TVVkSUk0?=
 =?utf-8?B?WGE5Rk10MVd3elJMTytzbVh1VldueTduS0kyWVE1c3JJb0RabWRzVDJlRk5M?=
 =?utf-8?B?ZkpuS05yUXo1aktDajR3TEZOcUFEaGx1UGIxYWZxWndTQ29PL243enVxelRo?=
 =?utf-8?B?aTBMeE5nNjBrUFowNjMxSEJVNURmY3hBZVRsMCtqcGh0Q3p5UWZGa3lIRnND?=
 =?utf-8?B?VzNWTEZCcisvNjc0NEJGQmZiYUFyOFNWTE9HdmlnOVNwelJKYlI1TUJQaVQy?=
 =?utf-8?B?N2Y0V2JTM05CSVFMQzFORmpqTXF5VlFicUcvKzRSM1NwL0xwZU9ya05uTTRr?=
 =?utf-8?B?c2g0VEM1NVgyK05LYWtOMWZIaUxDMHpEQlpmQ05TSmhpZVJQT2IyUkZvam4w?=
 =?utf-8?B?N3dadDRQQ1pNMDNROUlwY2cxbTJYYVRPNmxqcXBrUUw5UU8xT2FYc0NpeExD?=
 =?utf-8?B?SlE5ajdHdnA4WVhLdi9BYnMrYjBLdkdCYUErRTRMQW1FUHFNNlZFNEJyY09M?=
 =?utf-8?B?MzBoQjlEcituNGxYY0l1eDVZOFN4NFdnKzBqWWNDQW9Ua2tGcm5QYjFLSVFs?=
 =?utf-8?B?dE9US3hjdWVSMWlkSGh2YUZSbTRBY1VVemRBNERXRTErTHkzM0J3ZWdMaE4x?=
 =?utf-8?B?d24rSWpoRFU1L3JrS09SbkgwT1FHQXlicHBsVFF4MHVNQkIyR2pHQkloSmZP?=
 =?utf-8?B?VVZzaUg5SXQyOTJhWFd3RVk3Yy9FK3BXYjhuUld6ZVVZWVBpUjRUYmIxQWJ2?=
 =?utf-8?B?TnRhZ1J3R0xLYytGb2wvVWc3WFRadFBwVTk0YTBkWEZRUzJRQ21xSFJneDMx?=
 =?utf-8?B?YUNSL2dPdStTc0Z0bGN4TGpMV2kxY2p3RTErUkk0VXNWVlJ4aVk2YS95d0Vo?=
 =?utf-8?B?THRRdW1HQk43dDR1Y2xadEs4S2RDTFo3VThDbkVQYUZHTVUxUk9CeFhxQjRX?=
 =?utf-8?B?dHVXakErTXhjOUM1MXRZSXNhTnVjQm45a3RYWVNQeUpNamU0OFFrbVpFWXBM?=
 =?utf-8?B?aW9ManM4aUZXTUxBUnJkWjhjc2c4Wjg0S3ZYTDZEeHlmMlc0VDM5WlF5NjF6?=
 =?utf-8?B?SHl6MHVMa1lMR1VkS3pFRFZreDhrT0dkTFNaRGhFM010VXFNaDY5T2VkZHAz?=
 =?utf-8?B?QlpJSG5uSWFlMldhWlFYcURCVzNXMXIwRTFlck5NWXVSNytBNHVxM3BpMDcy?=
 =?utf-8?B?Y2tkbGt1RGloem1qdkFEd2pMZDRaZ2ZEaU5PNzkzQy9LT29wemh3MTh6YTFI?=
 =?utf-8?B?bEdRUjZJNDhTQ0l4Z2tVNTQxeWxDVGJtV09MUGd0RzcyQ0hQTmR3TUtHemJR?=
 =?utf-8?B?TXhMSXN1T0JnejNMa1pBaCtGWXRsNjVwR1F4NnVKc1dBMzFUVmNFc0EyMEto?=
 =?utf-8?B?b3VVTnY2ZWx4dFhsUmlENjQ0cDNlem5EUkh4d0YrbVJia292NE5RbzE1Sktn?=
 =?utf-8?Q?D3Bni/qZGkRtJrb8AbwYj1jrdqvnb4XVulE/7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <817C06F412DAAB4BAE974DACFF7BA3AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99603b00-577b-4e0b-0acc-08da353b4cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 23:50:03.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Snj6/bq6AxPqVw6cEFHyEZA2HMIolPgIX2KTSv1eqEl7oRKTzJEqO0VmK3I4yowNQ8Jw4UT6kTF9U9AXIILe5EGt6fXe8ZHSIOw/s+BPYno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIyLTA1LTE0IGF0IDAyOjA5ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIEZyaSwgTWF5IDEzLCAyMDIyIGF0IDA1OjM0OjEyUE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMi0wNS0xMyBhdCAxNjowOSArMDIwMCwg
QWxleGFuZGVyIFBvdGFwZW5rbyB3cm90ZToNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIC8q
IEhhbmRsZSBBUkNIX1RIUkVBRF9GRUFUVVJFX0VOQUJMRSAqLw0KPiA+ID4gPiArDQo+ID4gPiA+
ICsgICAgICAgdGFzay0+dGhyZWFkLmZlYXR1cmVzIHw9IGZlYXR1cmVzOw0KPiA+ID4gPiArb3V0
Og0KPiA+ID4gPiArICAgICAgIHJldHVybiB0YXNrLT50aHJlYWQuZmVhdHVyZXM7DQo+ID4gPiAN
Cj4gPiA+IElzbid0IGFyY2hfcHJjdGwoKSBzdXBwb3NlZCB0byByZXR1cm4gMCBvbiBzdWNjZXNz
Pw0KPiA+IA0KPiA+IEhtbSwgZ29vZCBwb2ludC4gTWF5YmUgd2UnbGwgbmVlZCBhIHN0cnVjdCB0
byBwYXNzIGluZm8gaW4gYW5kIG91dC4NCj4gDQo+IEJ1dCB2YWx1ZXMgPjAgYXJlIHVudXNlZC4g
SSBkb24ndCBzZWUgd2h5IGNhbid0IHdlIHVzZSB0aGVtLg0KDQpIbW0sIEkgZG9uJ3Qga25vdyB3
aGF0IGl0IHdvdWxkIGJyZWFrIHNpbmNlIGl0IGlzIGEgbmV3ICJjb2RlIg0KYXJndW1lbnQuIEJ1
dCB0aGUgbWFuIHBhZ2Ugc2F5czoNCiJPbiBzdWNjZXNzLCBhcmNoX3ByY3RsKCkgcmV0dXJucyAw
OyBvbiBlcnJvciwgLTEgaXMgcmV0dXJuZWQsIGFuZA0KZXJybm8gaXMgc2V0IHRvIGluZGljYXRl
IHRoZSBlcnJvci4iDQoNClNvIGp1c3QgY2hhbmdlIHRoZSBtYW4gcGFnZXM/DQoiT24gc3VjY2Vz
cywgYXJjaF9wcmN0bCgpIHJldHVybnMgcG9zaXRpdmUgdmFsdWVzOyBvbiBlcnJvciwgLTEgaXMN
CnJldHVybmVkLCBhbmQgZXJybm8gaXMgc2V0IHRvIGluZGljYXRlIHRoZSBlcnJvci4iDQoNCg0K
