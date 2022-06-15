Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7388654D155
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349137AbiFOTGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFOTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:06:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953502316A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655320008; x=1686856008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y4+G7gPzbqYeW3SBhX6/0DIUb0xPZgx3wAZ4nhyhSH0=;
  b=LZkycKL7VDqVVkwhx+5VIj4M/e3Y1VXxjSGwbWaiU1fDlgCvZyiPhS//
   rmN2ernjPg13qAm7pLw1HQEg/nW5LIkL1wfWa0x97z5NaQ6VQKUzSBBNs
   mlRC8fazhH6rYNzZEGf94n4zSgdcP0FsuthkglAQ1w8CLwgC7wHYJ0NzN
   cqLeFh0QWTur9wQLA7Fy4zGtvhUQwFn+O7xg8CO/TOwj05j8hjp47tXDB
   zCV6d6+jtwhHZg7q24vtabM63xV5AI1WpgGN5GgR3De2R5ZexfF3+i6an
   gcFDrQ0tP7uBpCnbBp+R26lgrhl4CNLFdqZVi7dLC4IGrNJVONrIg6MYt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="279132401"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279132401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 12:06:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="583349083"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2022 12:06:48 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 15 Jun 2022 12:06:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 15 Jun 2022 12:06:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 15 Jun 2022 12:06:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKqcfEokIU7FQXNrML0SdeCMTTo2pB2o+lEJNUSrnR/wEPuX0uAcYzyX8pBnDE0FmVqT46sei3CQYUdEfkgh7PXsBfGfSX4hU5uCfL0k1WXS4ZAJPXXQeS6RoZuGOKCCIn7ZNlWfKqUMLMNde8AEDOS99eZxMMbvOBGOQiTAA/nnL6pHCErxEDl9b5Yiacn96YWl7pMkhPFbIEPOV4PhvFab4ZXuAjSs881Iwvj5EFfzK2uOfhkknwmcMIGE/mp8vg45dNH8xvS9STr2LV//DO5VzMNhmecx/Giy2u5BY/n1Pac45K4ENS5j8wPUoZl1BYOZlQZme15kgqnlxTS/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4+G7gPzbqYeW3SBhX6/0DIUb0xPZgx3wAZ4nhyhSH0=;
 b=WUD8BQtlKegJPU1vVK6Eft1ojdL0wm0dQa4isB55OKPPgyCZDWE6ShgXlB+VEKhxDX1KcCHvHTS1RLI4r8OmYVAqka40etYlX6x0Raiqi+GFwLUT1+EnE7aJRBAUgRwwPp8/FGl2fQ2EiX4lEWtNFf+sa5p7vmQXgH6J1pqrNseOivmzmf7eJj4DHcoghZgCfQvNBtQmij3KdD8/FnFluX8RWJ8/HcxdKLC/JLxRgpm3bbsW3F9vsEfwYf0N6/faQNS6RJf6+8WAGwO/ol1Sg4FkkxYYzbAKr/IK0CZxTzNfp7C49M1gONekPdl1vckJqKY2unzDBJn9utlDrso15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 19:06:44 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%12]) with mapi id 15.20.5332.022; Wed, 15 Jun
 2022 19:06:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "kcc@google.com" <kcc@google.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Topic: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Thread-Index: AQHYfNdsZ8qhjd5y50Oatxr0zO7+Ka1NnpyAgAMZ+QCAACPWgA==
Date:   Wed, 15 Jun 2022 19:06:44 +0000
Message-ID: <685325f8704e46aee6f94e5953121e4f643e2de5.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
         <c7e2f8fb44da067e7565d091edeac300977b65ed.camel@intel.com>
         <20220615165828.5ggwnoxo7zhvmqzt@black.fi.intel.com>
In-Reply-To: <20220615165828.5ggwnoxo7zhvmqzt@black.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3af77ce2-7094-42ef-45fd-08da4f02304a
x-ms-traffictypediagnostic: SJ0PR11MB4973:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR11MB4973BD8988B76030362AAAC0C9AD9@SJ0PR11MB4973.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WvmhA9EQkoeOPe5aaG2JdRLyt6SKQHxAQlcivAnQCL9d4Cw0Pb0NXtKMBW+KqDMWt9oT/reWEltFGZ+pMuTR47vRyHhKA3sBB54zjumTEJwzkAhK8R9DuG7f1sfDwwmA9VMKYlnTkE3XRCH5iuvtwOEPXxeQNZswgCzO+6GX+X5DxLdez4O/1fWSBTaho35vg94OBqjnLteLKgp0MkCzNa4lLLW8f3letK2RJj1Q/CYWT6rvnuuqGBhGycMembhkuqk1xChWfVWtE/SPVxWvr6P/e1VXa33NT+RW43N2uff5jBqFHnAHraVMAParhM8cWuDLtgd8YHImqcTZUDw3SfauGuSZ2lFLFNMBGdMZ2OhJ5SpThr0NnNEmMEhie6SaJZsg2wxy1Rrtvzcj6+zaPODGcIYwudlHXJXkWreqTHwoP2ZQrhTeCFYB3WcM4m3l+XodCxdFwG/Wcfd8pJmZYwK1yBk8bFDF16ErLJgXbijGutifwsOybHbHfoFdASSpaPZ9Lgnn6v57Qmvw7sq630KolrXCQqTWs/QahlN/ODNK7v/CEEK2GkMCzBy1SHWM5t6JdNOmjqxqgscGZWSq2Xgl6/w5zGKzCu3LErQaU28A7Il2d/WlSp3jyd1AYdpGrZlrMsaBED6rsvWEXYJusMmjSyzDirBGYkA0gO5ZIg9jLrYoLAmqwXe6FiH0KPwZLDi3kfqtx6Pv2TtkCcobBrW5gdBTfDaAYMOttWVaY6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8936002)(86362001)(66946007)(76116006)(54906003)(64756008)(6916009)(8676002)(66446008)(66476007)(66556008)(316002)(4326008)(38100700002)(122000001)(82960400001)(38070700005)(5660300002)(6512007)(2906002)(36756003)(6506007)(6486002)(26005)(71200400001)(186003)(7416002)(508600001)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0g5S3pBRVlDOGQrOE43WlUxSHh3bnNBTHJqcXN1Rjc3blB1eXlGdE9xY0ps?=
 =?utf-8?B?MXIxdU1qT3JRTU5jUGIyNzRBenVjZnlIRnR1eVZUTnZvdmcxTFFUTlo2Yktj?=
 =?utf-8?B?N3VOOU9yRVpxbVAvRy9oeWRQMzh4RVFxaTBzM2Q2aGcyeWd6c25HSytYLzNo?=
 =?utf-8?B?YVNJQWlibTlsNzlaY3grYk9DZ2ZBYktqTHNsbTlWVmU3bjdyckNlanVQdFd6?=
 =?utf-8?B?Q3NSVzBJZkwrelV2dVFJL1A1aEk5QXMxZ0tDSDZJV01SM1Y5WXU0eGJpNGdz?=
 =?utf-8?B?SzNsUXdneDR1djc0N3lCTjlYUFZhUHFBWWkwbGcxNzg4STlOM0FqaDRiWmpE?=
 =?utf-8?B?elBTT0RtbFdnWXVUcEM5RnhKcndodm0xUDJHcGIxZmRiWC81UzV5em0vNVFw?=
 =?utf-8?B?cDdUNjF6N3JPTC8rZldhZHZXWkIxZldJRXRla1hRWk5mTkx4YWU2a2hmaGpt?=
 =?utf-8?B?N1dpVzk5N3RWYVQvZmVGMGlUL3gvM1A1YWZhU2xNM0ZBMU9rSjZNd2lSK1FK?=
 =?utf-8?B?bnRtUG9qU2FGa252bmFUWFhLdjNHQmppcStlUDZMMlR1RkVQeEZYVFZ5emho?=
 =?utf-8?B?RTA1bVRaVHJWb0hiYUFiM21NclFXeTE3dEJiV3h6R01zektLYkh0TUQwUURZ?=
 =?utf-8?B?TGE4a0VWcU1GWi81VVdXNVJEWjhBdkFvbWZTbUVpckk2a1ZYVkdXbm5rM1lL?=
 =?utf-8?B?cjg0WlA5WmpEdXM5MTlOeTBtNUtTaVdCKzZKMlZpM3lJYnhyeEdjR3BmUGVo?=
 =?utf-8?B?d1FxQmVWUkx6dGk4U1ZKbVBIalZZdjhjZjkvNEIxRjRkUkQ0VDBNY3F1Zzd6?=
 =?utf-8?B?UlAwK091eGZWS1JjbnRpcTMwSnM0VVdxRmM0QjNzWFI2MjYyTVBEdjdMWDhJ?=
 =?utf-8?B?ZkpHb2VpUTdTQmxiRkIxejVHUEc5NEtnVlhzV1Bma0pTL2FHbkZSRmM1Mzhl?=
 =?utf-8?B?dmEyS05KTnV2MjhQSmcrRDVoVTF4OXFTek43c2xqZVlTUlVHTmRJTUVVWGtK?=
 =?utf-8?B?NUxmMU9QdHR6NmRmODJIRWdiY3VvK2tuZHZXUFVacTZNS2duOU8zdENBYVRz?=
 =?utf-8?B?TC9YYVpVTzRJT1RCNVIzZ3VtV0lDSFp4SFdveWxCdnBOc2dMK2VmdzNXU01p?=
 =?utf-8?B?Z0puUE9pT01iemE1bXZvU1ZDcWdJUFZTSXEzYVJEcEtEOFhHdmswbkg1SVpn?=
 =?utf-8?B?SmZtY3VHTnJVTnpTTW9sckMxMHdOQmNrcTU0ZERZbDRoUTJGc29TYjZLR05X?=
 =?utf-8?B?ODFGemtMZ0VFZHZ4TkZWa1pCZE1TMWdHb2phc213V2tjZU1YR1Z3ajVIVTBh?=
 =?utf-8?B?a0RYN0l5S2Noc2JLRWJLOVc0K0FuVjc5M0lMK01xQ3FiaEx0dmdkdjc4THBw?=
 =?utf-8?B?SDU3Zk9ZM2ZZUEs1azljMmI2eCtPeVYvOTZMYlRVVGZIV3cxaUlBcGZ1Vkpw?=
 =?utf-8?B?WVRtYkhpL0s1MmRLTjlKTUYrS3lWRHBJN3dqc1hHeE5hMCtTQnRqTkx1NS95?=
 =?utf-8?B?WG5ORklFY1hrME5PZU1nejNQQ01lbTlzYnJCRWlvNnpHTEU4a0JpZlYvajQv?=
 =?utf-8?B?WVJYZldobEJ3Rmo2SkJXakQ4RjBLdWNJOEhFeWhaQ2FlL3JHTzFRemdkanBC?=
 =?utf-8?B?akU5UkwybS9Fclk3NTZ5Q2FYdHhTeEEvb1YwamxvY2ZzQVh1SW5GM1lHSDhV?=
 =?utf-8?B?c21ZL3ZPTE9ZSTVJY3k3SW83alVvSzNVbEYySW5JcExqL2xXSEx0cXp6UGtj?=
 =?utf-8?B?VzBTVE9IUUtyZmRNR2tFMnBRcmdub2ZvbVZHUFArbDN3THl4L2JmcnJkT2g1?=
 =?utf-8?B?RGlxUy9UMzJDcTViQ0d2OS9VaVRFOCtBaFV3azUvVjlwdkQrTWhtQlcwYU8x?=
 =?utf-8?B?WTl2NDZqTkNnNURXV2xTamhmTE96ZG05Rm1aeUtUVW1YVkxWczdmS2JsVWtC?=
 =?utf-8?B?VC9kTjZEZHJCNml1b0xqelc1TUNtTXh3SGl4YlEvS3pmaFRISURMVWRxWTJn?=
 =?utf-8?B?RklkSXBKK2hnK0UzV0Fvc21qcURBdWZmdHJiWG9ENTVXUFpQQ1dhN2dxN0xh?=
 =?utf-8?B?MVZvMDdJUU5OWTRlMEswaHlTd0R6dHlHNzNSdXg4N0xyYk9qUXZmUysyK3FP?=
 =?utf-8?B?Ri9NSmoxSWpJYU41T0pLcENMZDNmemM0VDdJK0UrYjhDOTdOQzhTZSt0MzRU?=
 =?utf-8?B?N1RnenpzT0FrYTZqWnNQNFBBN1hIRkhOeklPL1JoUDlMdnZ5SFdOQk8veDhh?=
 =?utf-8?B?a2JaZ05OdHhKNmpwRVJQSDlHTVVMc1NFenpwZEN3K2tlTkFLaDMzMDJZVzR2?=
 =?utf-8?B?NTJLb2RNWjQxcU5WQk1YYnd5aWhPZWpzaG0xM3dIeWIxUlQyR0tZazdzNThh?=
 =?utf-8?Q?rTiGQDbpIc64P+w3EUj+PiiOekXSsAdd9DpWh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29E83DE483312041BEB498B0ADCD86CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af77ce2-7094-42ef-45fd-08da4f02304a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 19:06:44.4424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye8sNrxUROC3AqH0tdHnpCVIFGW2bsV1FTnGObvnXWsTG5t6aLANd7/0GSGNslAQYpBYeoTbHWQZ0p79gl5u4ZwOxQGd7n/5R/6iM9tXMMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA2LTE1IGF0IDE5OjU4ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IE9uIE1vbiwgSnVuIDEzLCAyMDIyIGF0IDA1OjM2OjQzUE0gKzAwMDAsIEVkZ2Vjb21i
ZSwgUmljayBQIHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMi0wNi0xMCBhdCAxNzozNSArMDMwMCwg
S2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gKyNpZmRlZiBDT05GSUdfWDg2XzY0DQo+
ID4gPiArLyoNCj4gPiA+ICsgKiBNYXNrIG91dCB0YWcgYml0cyBmcm9tIHRoZSBhZGRyZXNzLg0K
PiA+ID4gKyAqDQo+ID4gPiArICogTWFnaWMgd2l0aCB0aGUgJ3NpZ24nIGFsbG93cyB0byB1bnRh
ZyB1c2Vyc3BhY2UgcG9pbnRlcg0KPiA+ID4gd2l0aG91dA0KPiA+ID4gYW55IGJyYW5jaGVzDQo+
ID4gPiArICogd2hpbGUgbGVhdmluZyBrZXJuZWwgYWRkcmVzc2VzIGludGFjdC4NCj4gPiANCj4g
PiBUcnlpbmcgdG8gdW5kZXJzdGFuZCB0aGUgbWFnaWMgcGFydCBoZXJlLiBJIGd1ZXNzIGhvdyBp
dCB3b3JrcyBpcywNCj4gPiB3aGVuDQo+ID4gdGhlIGhpZ2ggYml0IGlzIHNldCwgaXQgZG9lcyB0
aGUgb3Bwb3NpdGUgb2YgdW50YWdnaW5nIHRoZQ0KPiA+IGFkZHJlc3NlcyBieQ0KPiA+IHNldHRp
bmcgdGhlIHRhZyBiaXRzIGluc3RlYWQgb2YgY2xlYXJpbmcgdGhlbS4gU286DQo+ID4gICAtIEZv
ciBwcm9wZXIgY2Fub25pY2FsIGtlcm5lbCBhZGRyZXNzZXMgKHdpdGggVTU3KSBpdCBsZWF2ZXMN
Cj4gPiB0aGVtIA0KPiA+ICAgICBpbnRhY3Qgc2luY2UgdGhlIHRhZyBiaXRzIHdlcmUgYWxyZWFk
eSBzZXQuDQo+ID4gICAtIEZvciBub24tY2Fub25pY2FsIGtlcm5lbC1oYWxmIGFkZHJlc3Nlcywg
aXQgZml4ZXMgdGhlbSB1cC4gDQo+ID4gICAgICgweGVmZmZmZmYwMDAwMDA4NDAtPjB4ZmZmZmZm
ZjAwMDAwMDg0MCkNCj4gPiAgIC0gRm9yIFU0OCBhbmQgNSBsZXZlbCBwYWdpbmcsIGl0IGNvcnJ1
cHRzIHNvbWUgbm9ybWFsIGtlcm5lbCANCj4gPiAgICAgYWRkcmVzc2VzLiAoMHhmZjkwZmZmZmZm
ZmZmZmZmLT4weGZmZmZmZmZmZmZmZmZmZmYpDQo+ID4gDQo+ID4gSSBqdXN0IHBvcnRlZCB0aGlz
IHRvIHVzZXJzcGFjZSBhbmQgdGhyZXcgc29tZSBhZGRyZXNzZXMgYXQgaXQgdG8NCj4gPiBzZWUN
Cj4gPiB3aGF0IGhhcHBlbmVkLCBzbyBob3BlZnVsbHkgSSBnb3QgdGhhdCByaWdodC4NCj4gDQo+
IE91Y2guIFRoYW5rcyBmb3Igbm90aWNpbmcgdGhpcy4gSSBzaG91bGQgaGF2ZSBjYXRjaGVkIHRo
aXMgbXlzZWxmLg0KPiBZZXMsDQo+IHRoaXMgaW1wbGVtZW50YXRpb24gaXMgYnJva2VuIGZvciBM
QU1fVTQ4IG9uIDUtbGV2ZWwgbWFjaGluZS4NCj4gDQo+IFdoYXQgYWJvdXQgdGhpczoNCj4gDQo+
ICAgICAgICAgI2RlZmluZSB1bnRhZ2dlZF9hZGRyKG1tLA0KPiBhZGRyKSAoeyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiAgICAgICAgICAgICAgICAgdTY0IF9fYWRk
ciA9IChfX2ZvcmNlDQo+IHU2NCkoYWRkcik7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFwNCj4gICAgICAgICAgICAgICAgIHM2NCBzaWduID0gKHM2NClfX2FkZHIgPj4NCj4gNjM7ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgICAgICAgICAgICAgICBfX2Fk
ZHIgJj0gKG1tKS0+Y29udGV4dC51bnRhZ19tYXNrIHwNCj4gc2lnbjsgICAgICAgICAgICAgICAg
ICAgICAgXA0KPiAgICAgICAgICAgICAgICAgKF9fZm9yY2UNCj4gX190eXBlb2ZfXyhhZGRyKSlf
X2FkZHI7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gICAgICAgICB9KQ0KPiAN
Cj4gSXQgbWFrZXMgbWFzayBlZmZlY3RpdmVseS4gYWxsLW9uZXMgZm9yIHN1cGVydmlzb3IgYWRk
cmVzc2VzLiBBbmQgaXQNCj4gaXMNCj4gbGVzcyBtYWdpYyB0byBteSBleWVzLg0KDQpZZWEsIGl0
IHNlZW1zIHRvIGxlYXZlIGtlcm5lbCBoYWxmIGFkZHJlc3NlcyBhbG9uZSBub3csIGluY2x1ZGlu
Zw0KbGVhdmluZyBub24tY2Fub25pY2FsIGFkZHJlc3NlcyBhcyBub24tY2Fub25pY2FsIGFuZCA1
IGxldmVsIGFkZHJlc3Nlcy4NCg0KV2l0aCB0aGUgbmV3IGJpdCBtYXRoOg0KUmV2aWV3ZWQtYnk6
IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCg0KPiANCj4gVGhl
IGdlbmVyYXRlZCBjb2RlIGFsc28gbG9vayBzYW5lIHRvIG1lOg0KPiANCj4gICAgIDExZDA6ICAg
ICAgIDQ4IDg5IGY4ICAgICAgICAgICAgICAgIG1vdiAgICAlcmRpLCVyYXgNCj4gICAgIDExZDM6
ICAgICAgIDQ4IGMxIGY4IDNmICAgICAgICAgICAgIHNhciAgICAkMHgzZiwlcmF4DQo+ICAgICAx
MWQ3OiAgICAgICA0OCAwYiAwNSA1MiAyZSAwMCAwMCAgICBvciAgICANCj4gMHgyZTUyKCVyaXAp
LCVyYXggICAgICAgICMgNDAzMCA8dW50YWdfbWFzaz4NCj4gICAgIDExZGU6ICAgICAgIDQ4IDIx
IGY4ICAgICAgICAgICAgICAgIGFuZCAgICAlcmRpLCVyYXgNCj4gDQo+IEFueSBjb21tZW50cz8N
Cj4gDQo+ID4gSXMgdGhpcyBzcGVjaWFsIGtlcm5lbCBhZGRyZXNzIGhhbmRsaW5nIG9ubHkgbmVl
ZGVkIGJlY2F1c2UNCj4gPiBjb3B5X3RvX2tlcm5lbF9ub2ZhdWx0KCksIGV0YyBjYWxsIHRoZSB1
c2VyIGhlbHBlcnM/DQo+IA0KPiBJIGRpZCBub3QgaGF2ZSBhbnkgcGFydGljdWxhciB1c2UtY2Fz
ZSBpbiBtaW5kLiBCdXQganVzdCBpZiBzb21lDQo+IGtlcm5lbA0KPiBhZGRyZXNzIGdldHMgdGhl
cmUgYW5kIGJpdHMgZ2V0IGNsZWFyZWQgd2Ugd2lsbCBoYXZlIHZlcnkgaGFyZCB0bw0KPiBkZWJ1
Zw0KPiBidWcuDQoNCkkganVzdCB3YXMgdGhpbmtpbmcgaWYgd2UgY291bGQgcmVhcnJhbmdlIHRo
ZSBjb2RlIHRvIGF2b2lkIHVudGFnZ2luZw0Ka2VybmVsIGFkZHJlc3Nlcywgd2UgY291bGQgc2tp
cCB0aGlzLCBvciBldmVuIFZNX1dBUk5fT04oKSBpZiB3ZSBzZWUNCm9uZS4gU2VlbXMgb2sgZWl0
aGVyIHdheS4NCg==
