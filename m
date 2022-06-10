Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D4C547041
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348793AbiFJXdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348626AbiFJXdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:33:05 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C84289A20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654903984; x=1686439984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WKgX2uTOk5i9oG09Skvgr3plT2vG64ktUxpQnVoTzsw=;
  b=HCcvboGrLvp7yI48S+lteEEj9z+IfeMntSehBtsI1z36gBio0zWCKzXv
   o7+RCsxZowVq/enfvkCBIOpYKrp2l2XGIQVRVARbWfzWPTrvXnXFMbHwo
   THDTjEYGIy17OHPzKJM0Aul5PPxVa7GuqiqBhAY+xVMteMjSPH9VNPy/y
   x5nhZSM272LMUTUvlLOXF3dJRivtlMeosTZ6lUtA8MrTTAARLpwX6xHEp
   Xj6djdZ6ir2KZp4mknwbl8fIvP5yiYmyXI1eFXaLQIyay2+fL6BVFPz3Z
   /Xkq56IBgnAhGOBAuQ+XEXPHOLEvpPfO0pvQano+5qkVFNi08ZiMYQiNA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278908696"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="278908696"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 16:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="672097623"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jun 2022 16:33:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 16:33:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 16:33:03 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 16:33:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLYJnw7nxsXypGtHTRIwKc498+xGZVSla7p4x0zeCwQAfgipUC8o9m4NUb3zwvVNA1jWJlQJpwkum9wgDHBZ/oTJuofbMExJQs3DSCNb9jFWIBkdHnCb57121KbZ5rbanA64ptjKmHJnl2pz1q7Vq66TrgRfN0KJfzeyVMwjRVWSnpfBQuM7/1ba8lb0sBJ45f3kqivse7hQYTX63r0yCSuJwO9JL1HOTvbajUHJt/yZnuZOikICR2veG+1Pu/+wd4hmtR2A/+AiY+KlMm4QGrjywyac4+ymCMLdrnESNSkx/Yen7oARbmifJunUr9QWQLRlCm2vpdGTzBQIcytueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKgX2uTOk5i9oG09Skvgr3plT2vG64ktUxpQnVoTzsw=;
 b=LWGUk4gOxJ/LLiUe5Pxxpqw4dKwKiNfqhBdykaZc8CBZAdLVZvqYCG6aNl3qucldKmK6ii7ENeiglx3kZmUdR/lVusKrpwAh1u2hU4nXAYegL83ODJIuVA3qpPLAMoO7AsK2U3KkmvwRbRxWGkgRDTwrGUWghEABgZQFuPjyX6RjDIy6IT+NyIyVNHx0AlQAui14bIVeX4wqG8w458CCZrFT8zZ5o8TXss8ZL52zIbIYlN8/SOzK4Z6BL61mCCem2tYDhYqNTFTWMvtjeoTAc9ZYOM+TDmuX9fCR6QZ6HvXIGIxeqAI0AiOcxNniRKYmqKS8Av5l8EG9AKKcfYnyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BN8PR11MB3667.namprd11.prod.outlook.com (2603:10b6:408:88::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 23:33:00 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::6463:8e61:8405:30f4%11]) with mapi id 15.20.5314.019; Fri, 10 Jun
 2022 23:33:00 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kcc@google.com" <kcc@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "glider@google.com" <glider@google.com>
Subject: Re: [PATCHv3 3/8] mm: Pass down mm_struct to untagged_addr()
Thread-Topic: [PATCHv3 3/8] mm: Pass down mm_struct to untagged_addr()
Thread-Index: AQHYfNdcHaWwJPAXYUKFeMkoYR62M61JSyeA
Date:   Fri, 10 Jun 2022 23:33:00 +0000
Message-ID: <8c506ae6d413e45eace17930a10a3ce267b6cb9f.camel@intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
         <20220610143527.22974-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220610143527.22974-4-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faa8c0f1-2034-41ac-4c16-08da4b398eb1
x-ms-traffictypediagnostic: BN8PR11MB3667:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB3667ADA2ABCFD38D8115114BC9A69@BN8PR11MB3667.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQloJxlEpu+fEWuN10wA1PnFsF9qU7UKswn+Eh64LwPT2KF13H5q8AJPzWjMGbeaU21sSGs8OTJHBYi8CUM2hG3nOhesOz3of+AJyumZtclXh1fX9trmd8unjCv4bgykfnvZZabvcxPq4YsoAQT9Vsh/eVzTcNORwp3Kh/CmJxvX3bQMMiPaZQdtACQ7h/jS7QDLmaI8brQKaDGzFeCoKDvb3AvSZKaRewJZMvD4g38BwLdor/CZETAtaSomzEc5pjzocvvuuFs6Kynyr/HifuxjyXbE/3MfbXMbbIhOhCIhB0PmX0EAMfh8ZsC+LbH46+iZND/77N8yjmfIHhj+cHUUn3X6MfZXRcG9Smuy974zbqIOUfyV4DZPXzoHaN+zFYfo+r6wDEu+KnZ6r9zknLcVUeectABGgc/XjjGpugrjb15GRRwoHy6jcYIbop+Qw5NIxhfcVqCZ1Wl+KB5/LPKNUjtYRitnzGytRid28lbNmng7O39FBSpbsqkZFR6L29YYwWvx4/VmgDCYUFN+oHq8pxaxU8hT9ftIob0oOtabUMnlrG+EW27abHOZf2AZ2QEbhxpHCGSxPMG2y69h+z5QJMJecCwAqQQOuwcUCmPzP5V0+jq87bXqpXX6dO+efMtPA0D6amZIUyvWv7/x42Tl3fUnqBkOamviOdva69FtEYVaJIUmegqXBuT8qOBgnBI2jv+OKkYse8uAJeTHOn0NkHb3sRMwK6LdZvovQjc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(76116006)(38070700005)(6506007)(83380400001)(82960400001)(186003)(6486002)(316002)(122000001)(508600001)(26005)(2616005)(6512007)(2906002)(36756003)(71200400001)(38100700002)(5660300002)(8936002)(110136005)(4326008)(66946007)(64756008)(8676002)(66556008)(66476007)(66446008)(86362001)(54906003)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlZBS3FqY2RxUEVNT2xpSU5LWmZLOWpZQkhLanBpcEdjVXA2MCs5clZSU25W?=
 =?utf-8?B?L0lCRVpKMlpDeHBHS1hyQnR1OXNpWGJLQXM2WGdLdldQSDFtNGtXdWxrRktu?=
 =?utf-8?B?ZUZib0YvOVRQQm1UUmRKdkxJZjNEZi8wcUh0U20rQTFXSWJzcFpMa0V5SnpL?=
 =?utf-8?B?ZnY2cGF5NndBVk43b0dHUFdDTFFkZnZxQkF3MlhGR1NDM29tUm5mUnFrK29z?=
 =?utf-8?B?RU4xbzB3aXdWYlV0WWRzdGZhamFGMzFUKzVzQk05OHM4SDdsa1NnS1UvTHBF?=
 =?utf-8?B?eEEwaUtsb3J3U2sxS3ZaanVmUktiOUFFUjgzRm5ITnMzUnQrekRjcUdhQzVn?=
 =?utf-8?B?MktKbGV5NS9CVWI0c1ZLcDVOeWZMa1hBYUtnOVFOVnBydytOVVpZTFRzNTly?=
 =?utf-8?B?WGZURE5UN0dIMG9SQzJaVUd0amZUTUd3U3FleXlDTTRNSXNLaTM4Mk11blNN?=
 =?utf-8?B?RmYzbnNSYk9zaHI4SGs4aUlNNmp4cG9LWExJUk9rcDljdmczZFdNTjRRRnJy?=
 =?utf-8?B?V2V1RGFKYzcxM1VxU21WeDJ6ZmdEUUxENjJZNjNsbkI3aysydmNMZXhlS1ZB?=
 =?utf-8?B?azNIQXNLa3RHMFVLYUdzeElzOWRKblFlcFlFdUw1UmM5NUFtd1pCcm1DMHRL?=
 =?utf-8?B?ZS9YSCs4WkxYTnVBZnJDaTJSOW5QbGhpU29GSXJZMXNleWVITHI4dEFNSXhW?=
 =?utf-8?B?RnYyU3loTGdveDNHUGJOOHAxOGxNL2F0bjltc3NTSC9ONGRrb1FBb1JBYlNt?=
 =?utf-8?B?TEpBUXhZQ0dlcWhnRVdTM1g0YUQwcng1b05NUit3WDcrTHZZanF2YnkrLzNS?=
 =?utf-8?B?U0x6QU9KSEFXUUJvR2JLTmhKSWVjc3N3VzFlbFE0eWRqaE1tM1dBejJzWmhM?=
 =?utf-8?B?L0FLcWlmbEdvUTEwcWpmS095OTBHeTNpMjk5MWNjTnFYUWZ5RVUwODROMDdt?=
 =?utf-8?B?M3A0eElYSURCUjZkdzRkUzMvdHo5cVh4a1FESzNGS1FKWFhSTlZYQmg1bmFx?=
 =?utf-8?B?ZnpJbnBHTjh2ZDZCajF2M0pOWFkrYklWRFBKWU9HZkUzYURrSXBYemRyalZJ?=
 =?utf-8?B?cDF2Y2JYbld3V05jSmRaTGlscUphUWJuWG5CK0xhaHZWdEVZV3dkNVg3Z3VC?=
 =?utf-8?B?ekFBdWFQYnJFR25UM0tHK0ZXYTB2NjlpMVgxRTgyVExGaEo4WkFMUXduMDIy?=
 =?utf-8?B?N1R6S0R2NkhVNEtOUlVJR0NUSHNXSkxxc052M1NXU09ZYUFyN3hYdjFMUUds?=
 =?utf-8?B?RE56c3BvdXVtSjVYU3RvekNIU0g5QkFobDFaWUp5VVN4S3JhTldaWlpFVkRy?=
 =?utf-8?B?d1lNNHJMVDNjWHIrRk9PelJQV21lVjUyZTZuK1FFQ1BtWlBGVzE3R1UrQ0Qw?=
 =?utf-8?B?OUhLTnFzdXJKY0UrT1NJTHFKMnZtRXIrb0toRUJvbmFSemdFS2V1VUZSaG5E?=
 =?utf-8?B?eW43RTBlQU02Rkxmc0xwZTVWNmxHekZ6SWxzdFMxQUpkRFNJdmJXT2VCcURF?=
 =?utf-8?B?TEM5dXdNVWhGVUtHOWdUK0RVeEpLWXZFckFEMWtKRk1EQmhVSTNpcThrTlph?=
 =?utf-8?B?RDdCQTllOFdCL0pwcnlOWHMySFJ1a2ozNGdQVWMvaXVQazBrMlh1d2RRU2Vl?=
 =?utf-8?B?YThVSUtVU3VUVUV6djMyc2xkMUt4ZVMyVzl4OGRYZUw4VkdrNUMwbGdGV1RV?=
 =?utf-8?B?WGQyeTVKeU9IZ0ovTHNtSW1BL1Ivd1FmZlBsVDFvYzVYU2JGblJUWG5INytO?=
 =?utf-8?B?Ym9JS3FIQVFZQUpMWUtPL1VaLzRycGdIeVFzUk95VGxZaSt0N0hWaE5HTGQ5?=
 =?utf-8?B?V1JuNjh0SVlLNW1FRGErMHowQ1BhSmJlM1NZWi9jaGJQRjh4ZVM3UmJKdEk2?=
 =?utf-8?B?RUZZMkI3U2JoTTVLeDUrZm4zVFc1dTVYTGlNUGVzdStZV2ZmZHdobnBYdklv?=
 =?utf-8?B?TkNwMEhGVTNwZUdMNXdOVHlYOTFrd1ZhQkw3TUg4TktaZFQyV2ozT2lRUlVM?=
 =?utf-8?B?N2EveDZWY2EyM3BTRStHS3crTDJGUXJEelNWcHl5UjgyejBSZklvaDBIUXQv?=
 =?utf-8?B?dnMrLzVsa2VMOTFpbU9IQnlLZWM0WUM1cHFzNGd5NG90WVMxd0JOT0VjYmVh?=
 =?utf-8?B?a3lRN2g1NEphaUlwSE0rS3lKeS9SNldOZU1IaXBFM3lRUnVuRGRNVHpveGhj?=
 =?utf-8?B?Qjlpa1VTckpGYmIzeFZjbmUzSXlkNTkyQjJJVFREQjVpcVZHUDM0VEx0UmZq?=
 =?utf-8?B?c3d4dTM3blFDdmRaVDVleHpJQWpzQUgxeFM2b1dnUzBPNnduNkMvcXZRekM2?=
 =?utf-8?B?dC9yYzFIMmR6VldtRk8yd3ZhWDJXVFMzY2QvaW9ZL0hoOGlJajZseGhWWVRu?=
 =?utf-8?Q?9XRnblxHjNyE086ZBttbHjvYEm7CLY5PHMof6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3973DBE6C6BDA8429D55A400F6C874CE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa8c0f1-2034-41ac-4c16-08da4b398eb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 23:33:00.4924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKcHfp6ue1HzzIvi/SanKWTjWFaWhj6aqdouv5D/rwu75N1zW+NubvqgGB5Ij1oQyFW35ji/PuU1xu0MXGv/p3CzuUI3GrwkXBuqBv1pQLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA2LTEwIGF0IDE3OjM1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IEludGVsIExpbmVhciBBZGRyZXNzIE1hc2tpbmcgKExBTSkgYnJpbmdzIHBlci1tbSB1
bnRhZ2dpbmcgcnVsZXMuDQo+IFBhc3MNCj4gZG93biBtbV9zdHJ1Y3QgdG8gdGhlIHVudGFnZ2lu
ZyBoZWxwZXIuIEl0IHdpbGwgaGVscCB0byBhcHBseQ0KPiB1bnRhZ2dpbmcNCj4gcG9saWN5IGNv
cnJlY3RseS4NCj4gDQo+IEluIG1vc3QgY2FzZXMsIGN1cnJlbnQtPm1tIGlzIHRoZSBvbmUgdG8g
dXNlLCBidXQgdGhlcmUgYXJlIHNvbWUNCj4gZXhjZXB0aW9ucywgc3VjaCBhcyBnZXRfdXNlcl9w
YWdlX3JlbW90ZSgpLg0KPiANCj4gTW92ZSBkdW1teSBpbXBsZW1lbnRhdGlvbiBvZiB1bnRhZ2dl
ZF9hZGRyKCkgZnJvbSA8bGludXgvbW0uaD4gdG8NCj4gPGxpbnV4L3VhY2Nlc3MuaD4uIDxhc20v
dWFjY2Vzcy5oPiBjYW4gb3ZlcnJpZGUgdGhlIGltcGxlbWVudGF0aW9uLg0KPiBNb3ZpbmcgdGhl
IGR1bW15IGhlYWRlciBvdXRzaWRlIDxsaW51eC9tbS5oPiBoZWxwcyB0byBhdm9pZCBoZWFkZXIN
Cj4gaGVsbA0KPiBpZiB5b3UgbmVlZCB0byBkZWZlciBtbV9zdHJ1Y3Qgd2l0aGluIHRoZSBoZWxw
ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0
ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9t
ZW1vcnkuaCAgICAgICAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9zaWduYWwuaCAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGFyY2gvYXJtNjQvaW5j
bHVkZS9hc20vdWFjY2Vzcy5oICAgICAgICAgICAgICAgICB8ICA0ICsrLS0NCj4gIGFyY2gvYXJt
NjQva2VybmVsL2h3X2JyZWFrcG9pbnQuYyAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBhcmNo
L2FybTY0L2tlcm5lbC90cmFwcy5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKy0tDQo+
ICBhcmNoL2FybTY0L21tL2ZhdWx0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxMCAr
KysrKy0tLS0tDQo+ICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCAgICAgICAg
ICAgICAgfCAgMiArLQ0KPiAgYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS91YWNjZXNzXzY0LmggICAg
ICAgICAgICAgIHwgIDIgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyB8ICAyICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMgICAgICAgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fZ2VtLmMgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvaW5maW5pYmFuZC9ody9t
bHg0L21yLmMgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL21lZGlhL2NvbW1v
bi92aWRlb2J1ZjIvZnJhbWVfdmVjdG9yLmMgICAgfCAgMiArLQ0KPiAgZHJpdmVycy9tZWRpYS92
NGwyLWNvcmUvdmlkZW9idWYtZG1hLWNvbnRpZy5jICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvc3Rh
Z2luZy9tZWRpYS9hdG9taXNwL3BjaS9obW0vaG1tX2JvLmMgICB8ICAyICstDQo+ICBkcml2ZXJz
L3RlZS90ZWVfc2htLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgZHJp
dmVycy92ZmlvL3ZmaW9faW9tbXVfdHlwZTEuYyAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4g
IGZzL3Byb2MvdGFza19tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyICst
DQo+ICBpbmNsdWRlL2xpbnV4L21tLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAx
MSAtLS0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC91YWNjZXNzLmggICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgMTEgKysrKysrKysrKysNCj4gIGxpYi9zdHJuY3B5X2Zyb21fdXNlci5jICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICBsaWIvc3Rybmxlbl91c2VyLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbW0vZ3VwLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrLS0tDQo+ICBtbS9tYWR2aXNl
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgbW0vbWVt
cG9saWN5LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrLS0tDQo+
ICBtbS9taWdyYXRlLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiAr
LQ0KPiAgbW0vbWluY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIgKy0NCj4gIG1tL21sb2NrLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA0ICsrLS0NCj4gIG1tL21tYXAuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAyICstDQo+ICBtbS9tcHJvdGVjdC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgMiArLQ0KPiAgbW0vbXJlbWFwLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gIG1tL21zeW5jLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICB2aXJ0L2t2bS9rdm1fbWFpbi5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgMzMgZmlsZXMgY2hhbmdlZCwgNTUg
aW5zZXJ0aW9ucygrKSwgNTMgZGVsZXRpb25zKC0pDQoNClJldmlld2VkLWJ5OiBSaWNrIEVkZ2Vj
b21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo=
