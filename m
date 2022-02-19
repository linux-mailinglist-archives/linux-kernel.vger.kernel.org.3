Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE9B4BC45D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbiBSBIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:08:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiBSBIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:08:20 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E353738
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645232883; x=1676768883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=11n5PS3wXGCACB6UpcA9hwmDHR834wVmiQYYyTfLhgk=;
  b=oJOvncM8itO66IIIhqcnVaQoQCcau9+qFeX/FZ9EFQauk59851vRCtXH
   wzapG4bfIKw9Mu60ItkZXQg6R9M1TmbnASzgRfQKtdbnfOqf3M+OmP35V
   nxe+MCLHLgdb8eCGIlaLEWPIub5Uud6f2qxHD3iQdoaRz53+KdtVG80Of
   3Bw8eZBFbPXWwauKLNQF5E1sFcSw3B/0B5JkQlMOwi4d6GGFHLvYRfYew
   50bChE4aP9upggaglWvU3rRTe9+GkblGiz92QInLjgS8W6dXhU+guf0DK
   9aDCXPpIB5YpoD2gVCPfNOymcVEdSyWTEZkwbweAlyXcEwB4H6lCw0BJx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231877060"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231877060"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 17:08:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="626795316"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 17:08:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 17:08:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 17:08:02 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 17:08:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1kuCYtj9NPVjTSjuHOb2SoLG1bkNeYVf7rA+d8VgdT1paiky10qrNTevDj5OTv6eVQnVoppcn3RWdc0fuYEez1TFzZ7JyltKQCX95vJSfs39Ofd+H9xMH0i4TR/g48FIqcZ+8kmzsnfoajAW6XLZQvLzwHFnmaH9mPenZaXjGuPuBF9BEyvhqcCIiX9SMpSQbQzchDp9Kjb3Qjzw6KeuW0cao6wOcRTaE8h5ICJ/pQaxqo6fAJx3xzUx2tDg8un09uPk/eKhg+4qFKhd7J9St/UmtDFJsJqxE1kcQlxI9A7scLf+CVPDXEHvYn6+ob3juSPQnKt2XpgMBtWSvkFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11n5PS3wXGCACB6UpcA9hwmDHR834wVmiQYYyTfLhgk=;
 b=DqXgvZdRv+ksKD5+ny+jZFergYxk4Z5SYHYdUx+8zYTNsxy1Qpza5uOeH4rzqUWukyzhT2FYNtSum/ib8fVTpukfHogH6e7z4KjBt9VeIOgI17bWlPRNsoZ0ugdOfQOtVaVtw1YnjZ03uyNbZJg+DHtfz+ihl3css0M/i8a9KVWkU5Ga28h4ua2HsWDA2pwdITO7hFlor+LrOro4IF07456ldIVowSvLMhMNKnxPJ6szrZ0QQyWl1c1SFucCupmeFelNn9Sjob0dDWvnZKi88WDp33rLOQu07ODY/w1y0UINSbyoq1+25OnzQL1EKMEAaw2Ekcpgb1QcrIGCiUXHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR1101MB2316.namprd11.prod.outlook.com (2603:10b6:4:5b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Sat, 19 Feb
 2022 01:07:59 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::250a:7e8f:1f3d:de15%4]) with mapi id 15.20.4975.024; Sat, 19 Feb 2022
 01:07:59 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Poimboe, Josh" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "joao@overdrivepizza.com" <joao@overdrivepizza.com>,
        "Cooper, Andrew" <andrew.cooper3@citrix.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: Re: [PATCH 05/29] x86: Base IBT bits
Thread-Topic: [PATCH 05/29] x86: Base IBT bits
Thread-Index: AQHYJSovoy8xRBs5BESatKobe+5PdKyaD+8A
Date:   Sat, 19 Feb 2022 01:07:59 +0000
Message-ID: <55a1466a01c0ef06541249d6e7901e2510fa1da8.camel@intel.com>
References: <20220218164902.008644515@infradead.org>
         <20220218171408.867389898@infradead.org>
In-Reply-To: <20220218171408.867389898@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1cf5f0e-ccc9-45c3-f814-08d9f3444549
x-ms-traffictypediagnostic: DM5PR1101MB2316:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR1101MB2316311309F582E66304E607C9389@DM5PR1101MB2316.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGnb0KsQ5zc3hZbbUmxaQXElwh6ETlmFz5wDQuQbhz4Il1FkjZVo+EEskuEvyTNsqYvWl9/MdMlG4QLeT5h00CSlr74TTi7GK6Fjy6yL7FwkElsaWnPi2QGcZtnWO8hS9IKKYcvFJ9g0R8na52KQksdQTtQHBzI2UEsi8F0cF7+UfITAv6QpgOtwJxYO9gwEFD1aDE+MoGI+LAlguv1nliq99uqnBsbfLCv8wFbCGMMqdKlqIDbvd/7qbMwlbxXkt0DODJ4LDsEljCmvNC5qk5yLEHoZyF1Mg99Bow0igACKfACWtfO32dgg0wk6cv8OW+Veo9Yx9Dvlcqkx5vabqSsEkUvdYmeCeKgynkhSZXXxeJZgrwfnhYJ4YDt5y7goKAP0bGxjKc19lK+v86rEOr5Q2y5nvTk0n1roHaS+JSu+wpyysqQ8BHR6zSgLbeX2e2kgaZlhPsC29bskwwTUr+/eVFZh0KPPpcf5RfiNljABfQTHvpymZtsIg5r2pqqgvvHjN2Cn5Dn977Ykb6ctOxt5mqRESLLEbZqerZcb8ZtntJLcl/ya17MIThEitXEK2DPdsjMxjGTRLJ8jvaAp1MtXNyNvzx+Ca9AyfvJA8e/rEy6kqzYHXkiTenw5zQbITLsKylJ5fRVrAPuW7pvwlApep0OYnVB2nvtyDak55dG5HirZi3DSXHbYQnNBFUNSgzNGmVOuZ/fKJ7sNRfEExkX5FVvQFMjAMyLUEY6AUPxxyLaosGa279xYZygtUoOVFFjxYYaj9x96KDO8OxOJYgnWJSA0ykI20SsryZvn+e4Wpex8ObflTZFNcgPjhXXI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(5660300002)(186003)(107886003)(2906002)(6506007)(7416002)(122000001)(26005)(8936002)(36756003)(2616005)(66946007)(76116006)(82960400001)(4326008)(86362001)(38100700002)(54906003)(110136005)(508600001)(316002)(66446008)(8676002)(64756008)(66556008)(6486002)(66476007)(966005)(71200400001)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2ppVWgvdFZ1STBjZTAyNms0RFJteFM2NDdENmNhbTZacWNNMFM2VmlvdWha?=
 =?utf-8?B?OUl4QVpSSURqNGlkMzBvZnNHYTFDaXNUa1FZd2p4MlBkbkdtZW4vWmhvUnNI?=
 =?utf-8?B?RFRqZHU3b3UwalYrdStRdTdNSGt2VUFtZjVxakI5T0dUTjNLaENkV3dhQjcx?=
 =?utf-8?B?UEVSMzFZOEZLSTZmZW1COXRSZUY3akhUd0xOM2VFa1czY0RTdkdLR094aFdv?=
 =?utf-8?B?VWc3eGxGaWZrM2FwY1QyZDNGTEYyOHorUklVUkJ2WXNTM1drcXJXV0crMUk4?=
 =?utf-8?B?aW9ocTU0Q3l5RThqZUEwVzdMamg4Qk5kdENKbDZDdHR6VVptN1EyS2pLZnYw?=
 =?utf-8?B?QTFxUVdZYmIwdzRBdXVRUzVQcHB6c01KQ2dQSzk0MndQMThjSDM4SkdCNndn?=
 =?utf-8?B?WTRnUFBlZ01pa04rOGR5SnJRbThrWHhYSzFCNkkrVkpQdy90M1FJMWpicndk?=
 =?utf-8?B?b0FWdnNEcmRSeHZCbEFBMDBsYndzWkFYdG4yeVhuUjhHTExPU3RVMEFWaEtS?=
 =?utf-8?B?VjVPSzZmaklGc0FYTUNHVXZOQnlFNkxwbnN1cHhqWlV3YnBoZjJhdXh4QnNQ?=
 =?utf-8?B?TFJENFNJTWt4OGFQSFBkUGF6Z0tEWXdEMCtScUFtRkJtcVU1N2MrTEVHRk4y?=
 =?utf-8?B?K3hyNjhaZXByRlcrc2s5UlRiS1FYUnJSdkU5Z0U3VURIRDJFTnA0R0ZtaFIr?=
 =?utf-8?B?U09HdXMrVmYveDdFQ290VldXcnU5UmNFcFFneXNSbk1CcUlJZmZwdVZhRzhk?=
 =?utf-8?B?a0FXOTRUYUNXOWNONWNMWmgzRk9haXRHd1AvYjRnbnJMeTBQemRsZm1UK3RZ?=
 =?utf-8?B?QlRSdGFVaWltNjlTWE9hRiswRkFFa1QrNjEyZzNJYTFNbUN2NVJnMWZNU1ZU?=
 =?utf-8?B?bU5KZnB0dE1oNXFyaktsQzZNRlI2WDRYVm5uam9YTzlkREVHQXhieFhrYVVV?=
 =?utf-8?B?aXpyZytrbEhPbFNzVGJmTmtWQ2pjR1A3NHZVU1g0dnM0dEpPKzNBZjhpelYy?=
 =?utf-8?B?bEJ1OTdKYWxVckhoSFRlVTlYd2g1S1ZoSmp6QjRkNWFpWVh3K3hydXFnWXpP?=
 =?utf-8?B?cFVGanpxUUhocDdOK0RoeDBFUURraG50aUtmZ0RRRUkrQ3lnck9iTUxIS3JH?=
 =?utf-8?B?SFZ2RFREcWpGS3BsckllT1VMaGNhaVdlRGxLWWdQY2ZDTk1pQnZlbTJhMzYz?=
 =?utf-8?B?RGpZWUhERTdYN1BMaGlzaEFiYm5KeDNZYm9KeUZJSE5CSEdNSUxON0FwMnU0?=
 =?utf-8?B?S3kzeEJrRjFMTnp4NWYxa3N4MWd5MDlpS242dWV3NXRWVWMzZzVmckpEMUZs?=
 =?utf-8?B?NFBvK1V3MlBkZEUvajNyeGhqM3MxcnJkbCtEYUYxM0xJUFZRNGh5SHRsb0VZ?=
 =?utf-8?B?SGVJNTVzT1FBaHRPZEtZK2VVLzBzQnd2T1lQcHRLWHY2WUkvSVZjTHZsbDRX?=
 =?utf-8?B?ei9ENmNJQnJ1OTd4M21RVUpzakJQdUxtQ1VUQjFFSXg0ZnJGL0dUWnQyNGV6?=
 =?utf-8?B?M1BORFJKM2tINjJQMDFkNG93SHNqU2hhUjFvUUZ3UFl1SGxtakQ2WTRvS05i?=
 =?utf-8?B?SU5rV1RYcVZ4L3k0bE52SzhPK1NRVVJXamlWN2FmYmRYWm55bU1DUEhWeVpp?=
 =?utf-8?B?L0NFMUZCeEVXZVlSSWtVMC9SQTZDUXY5S2R0NGdnQ3gwK0VrR0pkd2lHREhE?=
 =?utf-8?B?VGFCMDM5UEhZb1U0cGplK1gxYWFYVlpPSVRoU1ErQXhtUVFNcXZXUTdUbzU1?=
 =?utf-8?B?N29jUU5pOGsrMmI0OG5RSmRBK01zTjRSTnRzS0lHTzhNeDZnUzF0UVFQQzFC?=
 =?utf-8?B?aGE2aWRLZ0pDSXZNN3MxQ0VUOUVWNkd2M000cnFrVVlKb0t2SmNmQU5nTXR0?=
 =?utf-8?B?NVMxSERHK0ZPVXd1cUxqaEdKbHhHa0ZvcVhFeEdGM2FndEJsRDNmR0I0d044?=
 =?utf-8?B?TmxTRGdZdWVvcFpERUZUNDNzWTBiSjhnd3pFM2lwTGZZdDJ4NHFzeXRPdG85?=
 =?utf-8?B?Nll5WVdZNCttVlIzTjJ2Qmcxd29PK3VhZnJtWnVXeUlkcEs4cWxTWnhZVXlo?=
 =?utf-8?B?OG9wTUZsaVNYdlpBV0JmaDhPTktoUlFIdlAreE1PMHlnNXdPYlFWMUhiN25W?=
 =?utf-8?B?em16aHpGaWNqUmkzVUVFU2NJVjhDV3c5WjU1bkFvbk5rRDF6TlNwdEhCZGJy?=
 =?utf-8?B?b0plZEtRQlpad3lXMW9NbmlWcEwxWWQvRHl4bElqS3NhUWhKU3gxb3lXUGxS?=
 =?utf-8?Q?8pgH92x8JfDyIa8aoLqw7DCBG27L+3Mbnpq+5uN9aI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A7E10F81CCB564D9E2EB2A67B30EF5F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf5f0e-ccc9-45c3-f814-08d9f3444549
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2022 01:07:59.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/jDurt0LNGm6rRHVnOgC5JqdTehJEZwW07WYrtwgplyFE5XBzyDL6wCpESEsoZWLo3HcMYsJFz1OfqBWTtU3DZpliI3Gtx40KDB/Ob6/Cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2316
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTAyLTE4IGF0IDE3OjQ5ICswMTAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gLS0tIGEvYXJjaC94ODYvS2NvbmZpZw0KPiArKysgYi9hcmNoL3g4Ni9LY29uZmlnDQo+IEBA
IC0xODYxLDYgKzE4NjEsMjEgQEAgY29uZmlnIFg4Nl9VTUlQDQo+ICAgICAgICAgICBzcGVjaWZp
YyBjYXNlcyBpbiBwcm90ZWN0ZWQgYW5kIHZpcnR1YWwtODA4NiBtb2Rlcy4NCj4gRW11bGF0ZWQN
Cj4gICAgICAgICAgIHJlc3VsdHMgYXJlIGR1bW15Lg0KPiAgDQo+ICtjb25maWcgQ0NfSEFTX0lC
VA0KPiArICAgICAgICMgR0NDID49IDkgYW5kIGJpbnV0aWxzID49IDIuMjkNCj4gKyAgICAgICAj
IFJldHBvbGluZSBjaGVjayB0byB3b3JrIGFyb3VuZCANCj4gaHR0cHM6Ly9nY2MuZ251Lm9yZy9i
dWd6aWxsYS9zaG93X2J1Zy5jZ2k/aWQ9OTM2NTQNCj4gKyAgICAgICBkZWZfYm9vbCAkKGNjLW9w
dGlvbiwgLWZjZi1wcm90ZWN0aW9uPWJyYW5jaCAtbWluZGlyZWN0LQ0KPiBicmFuY2gtcmVnaXN0
ZXIpICYmICQoYXMtaW5zdHIsZW5kYnI2NCkNCj4gKw0KPiArY29uZmlnIFg4Nl9JQlQNCj4gKyAg
ICAgICBwcm9tcHQgIkluZGlyZWN0IEJyYW5jaCBUcmFja2luZyINCj4gKyAgICAgICBib29sDQo+
ICsgICAgICAgZGVwZW5kcyBvbiBYODZfNjQgJiYgQ0NfSEFTX0lCVA0KPiArICAgICAgIGhlbHAN
Cj4gKyAgICAgICAgIEJ1aWxkIHRoZSBrZXJuZWwgd2l0aCBzdXBwb3J0IGZvciBJbmRpcmVjdCBC
cmFuY2ggVHJhY2tpbmcsDQo+IGENCj4gKyAgICAgICAgIGhhcmR3YXJlIHN1cHBvcnRlZCBDRkkg
c2NoZW1lLiBBbnkgaW5kaXJlY3QgY2FsbCBtdXN0IGxhbmQNCj4gb24NCj4gKyAgICAgICAgIGFu
IEVOREJSIGluc3RydWN0aW9uLCBhcyBzdWNoLCB0aGUgY29tcGlsZXIgd2lsbCBsaXR0ZXIgdGhl
DQo+ICsgICAgICAgICBjb2RlIHdpdGggdGhlbSB0byBtYWtlIHRoaXMgaGFwcGVuLg0KPiArDQo+
IA0KDQpDb3VsZCB5b3UgY2FsbCB0aGlzIHNvbWV0aGluZyBtb3JlIHNwZWNpZmljIHRoZW4ganVz
dCBYODZfSUJUPyBMaWtlDQpYODZfS0VSTkVMX0lCVCBvciBzb21ldGhpbmc/IEl0IGNvdWxkIGdl
dCBjb25mdXNpbmcgaWYgd2UgYWRkIHVzZXJzcGFjZQ0KSUJULCBvciBpZiBzb21lb25lIHdhbnRz
IElCVCBmb3IgS1ZNIGd1ZXN0cyB3aXRob3V0IENGSSBpbiB0aGUga2VybmVsLg0K
