Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62908527A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 00:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiEOWBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 18:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiEOWB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 18:01:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DA713CCE
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652652085; x=1684188085;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=68Cd+Rp++cqty6phoouxLE86/gnHseweDztGu08Du90=;
  b=KY1Z4ThIwbWcNdXSE2hVICe3P/o90pjyazsGUht7Xo2ib95YKeYpyXR7
   w1t5Joo8r+ueZnU8Kz2KzlxnGDMPTYohGoobxpqwwYzTrkBH2IzFZUUZz
   nmSjgfpjDTJFNixnGFtDTykbaBB+wsDtCjhYm8EAAN1WaBSwovFDauJp7
   RBJm+Sk7+D915AgdZN1c6SQTGSF5RvyfaEbcDPUhSS02i3uHP4yVADn3o
   SfG8phNzZzb2nanqcjfEZ7Ku6OtFkXatFm/WA1oj7Ns1oSJOK03iV7H3o
   67kIZ6Jr1TmG9lhCPDSqIITAV4nuBHjsQW7SR69IcyQRFWaeQFvEFQYNE
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="269507970"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="269507970"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 15:01:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="625663894"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2022 15:01:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sun, 15 May 2022 15:01:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sun, 15 May 2022 15:01:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 15 May 2022 15:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiGsJpspmh5W1e9mm1IyYmm9qd8WvoDgm5iGfYCb7+3DyMaqQTn4vos0CHn7eBDbKT/kFs5+aq21F3P/B2uF8WLyVDUX/aKABnCESKRCtIxWhwuuJdehNLUcRWKCeUfih/Jj5wJ7mAXhGh+fhpxwv1Ct1ZTbVU/t+03hf45UguIJ5z2B/gu88e7rly/hTg2TJNODQOwp+Gq1GUepfWkZLyYPeU4TVZ1e6g65pcoUv7kn+0OozQWbzSi0TVT2PKTv2ymEP6dGxq3SS/ooe4PimOcbx9oQdnUoKj0ngTEVV+HBlQbGjRGnBvtNjuWtQ/pXKh2ssQevmyGLb6VeUkBqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Cd+Rp++cqty6phoouxLE86/gnHseweDztGu08Du90=;
 b=QMYJvoRY5LBUGXgZAe7l32Bffpns6DtR256jrJXTP6GvJ6th0+JbQtzBXQH59kxR/s5R/0Z/dZ5FNMkBTtEVgqJrfevFTeAdwuvI5EeG3weUdbUClZWHj5QFsR71cNb1HNq8nR1z4bEmaKgTUtPbMnUBI8yDV9Pi7pK1RH47H4Git7DyEa6yMrZzyNK4iGwEYviTfaIvPHNzs/4D28vnVc56UskA2V+L58IHkGArax9vAFZYP0GAtZlPP5lI31Pj6zxhmGk/+Rh6FiIaKdgMJoCpzSzbVOllYQuXaNb8xUeMBGQjA1YbuDqguVxKDiAkoyYzi8ClJYYZmD8XF8PHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB4491.namprd11.prod.outlook.com (2603:10b6:5:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sun, 15 May
 2022 22:01:19 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Sun, 15 May
 2022 22:01:19 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
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
Thread-Index: AQHYZOBkvB2PlILtfUOVczGp43rrrq0c3EGAgAA5TwCAAF3QAIAACzIAgACTWYCAAPLzAIAAplKAgACc9ACAABS2AIAAKAAA
Date:   Sun, 15 May 2022 22:01:18 +0000
Message-ID: <0d10c85ed7cdad0150bb3daa1b893722d00f87e5.camel@intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
         <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
         <CAG_fn=V8k3hiviv3htV6wWZ6fUBri=MORfXGJ+Kz7GdRDZvesA@mail.gmail.com>
         <da0f438bb459050e5a586a17382e961259449761.camel@intel.com>
         <20220513230958.dbxp6m3y3lnq74qb@black.fi.intel.com>
         <543eb3ff98f624c6cfa1d450ac3e9ae8934c7c38.camel@intel.com>
         <87k0aose62.ffs@tglx>
         <9e59305039f2c8077ee087313d1df5ff06028cfe.camel@intel.com>
         <87zgjjqico.ffs@tglx>
         <95efb5ae85a96914fff3939d4924e46686196cc7.camel@intel.com>
         <87lev2r3hb.ffs@tglx>
In-Reply-To: <87lev2r3hb.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b9cbc8e-4b7a-4dc2-766b-08da36be70bc
x-ms-traffictypediagnostic: DM6PR11MB4491:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB44915F74AF291A6955931646C9CC9@DM6PR11MB4491.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M0gO26yG4AArwue1u6pcBYwHSt6O1EK8V3j7UL65jZD9GsGwOwwzKMwJcE316n6+c5Jblo5q7sjzmiB7tAoMOvtrlQhl2FoezPQNcNd8z2CUj4Nw8JnMSHmkUyyAd9SjbhmA8Lhn37UX3SVSgoZtaEyfRUZDJfPjHMghKMTD6/EA8ehvJxflUX7AGYoqxtVxdQGftMitjxeJHBg1ihUgReKI4iR1tMpCofY6d957eieCNLhmgpayOjJETOrRE3tTUYfEeqqzfragrLP0Ht4P3p6HaM9uIaVjFphqxA1oVix/tYqEq4ub1+erbeAMXD3BhNVTg2um13AB4VMQP/iJyrESibFJyFu0fJs/Pemy2rGv0LyC95+Uzii9HLRM7yysqWJtAI7lx8hWRa52lJW/i/tDys/OxkMZNw1FuAb8MslklDrTbFmdIR2/g+hBiMzMw1Lc+xtItIcDxk170Uhr6ABsG6MUep12Ra5iJRNLFRoV4SAIceXxfRsVawecI7gVKaiOlIdZCTt9ii3vzDCzgbxsMstuSNrkJTUP2zznmsbeltfQTQO/KLt53i+BwisZPci+DKUgmSd73TYyUgji/1EVu4rxyj0TSyJpGO6NX7TAsUrFBeg+VFVifOnNbsvxiNOXlnIph3pnkc/hDLeHFUTzgcSb1JEIqkL6PJ3WoDWco6gGB+q/1jX/mQZFQajfGbb9j8pXOMDZ+hkSQkfGY1NQGFGDgcOhPe0XlOKL2Vc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(6506007)(64756008)(76116006)(91956017)(8676002)(86362001)(71200400001)(54906003)(66556008)(316002)(6486002)(508600001)(38100700002)(66446008)(36756003)(66476007)(26005)(2616005)(122000001)(186003)(82960400001)(38070700005)(83380400001)(8936002)(2906002)(6512007)(4326008)(110136005)(5660300002)(7416002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TllUV21tOFF3bWNOeEJaaXQ0bmpJUUt2UzZtd3NaV1B0c3FUbHdBV1lYSEYr?=
 =?utf-8?B?UVcvaXVSN252UWVDV1lnWWRMSDhvVDVtMTJOcjlqeXpQdTdhM0dIWjlKUXp1?=
 =?utf-8?B?NEtiZGtUUXV3aFVRTGRBQUFzYXJ4YzExY1lWSFhVMnBJVzgvbzVmRnh1d0ox?=
 =?utf-8?B?bUNQV3NMU2FIRW9XUlZabVNxZjhOc3JaSTJ3MnQ2SDZFYVRhMVgzVkhlRDVp?=
 =?utf-8?B?TzVxanJNZVQ2dk9UZzVsdWxraTRJVi93Mzc5UFhVRXJnY3hMR202SC8rWEo2?=
 =?utf-8?B?ZFJDRjhGN0ZWK2grZlB3WUNJZnRnYlpPdEFzaTh4QUVJWHJpN1J2eW1kdUFm?=
 =?utf-8?B?Y3JCbWxZUzlRak5HRkErdXFlQloxc29qUFl5Y1ZkbzJlOHJEakdKbkQ5bjd3?=
 =?utf-8?B?d0lOWnpyb3hGRWhxMkZ6Umw4ajFtSEtTRUExTnlqV1BhWTRTY0xaSkQ5WEJt?=
 =?utf-8?B?N2ZRUUU2SkJvWjE5M0JpQWFrWkw1V1pQOHJ3Rm1tendCTS9zYWhRallZYllJ?=
 =?utf-8?B?dU5XZ0J6YkpWODJLZ2VjTXhnVUJ3NDl5aGUwTzU3U0JFMkl1NXBHTkhCVUV1?=
 =?utf-8?B?K282bUpYek50RFBpMFM5MHVsVDRaU0t5emNWbzdjRVpwbGh0V0hML3kvVE5F?=
 =?utf-8?B?SFFVc2loWERWeFRpRkVmWm5BVE5aY2YwVGJpRS9QK05aaHA5VE9wR1M2WnBl?=
 =?utf-8?B?ZHFQL0MwT3E1Y1lPQzNLc3Y4S2padWRxaVlRRGt3ZlF6MVJqZU1VQVZPaEJp?=
 =?utf-8?B?M2pNaklLZ2twYyt4VGNSYnhtWGlnSzBhMExYVjRpVERXZVJoeThiVk8zMDJx?=
 =?utf-8?B?V0RPUWF4bnpCTUsrWnVMMjBjbElTZVgyKys2M0NaN0x3anJsbC9rZUhuQksz?=
 =?utf-8?B?Y0Jmd1YyWWp2M3doZXVvUTlmLys5QW5CRW1sZnpoeTU4bjdCempXQThxOSs1?=
 =?utf-8?B?VWl3a0p1c29mNkthWkQ3ODJrY2tPVzJqUENSajR4ZTlTUTNRbWowQ3lPbmN6?=
 =?utf-8?B?YUpzditndjRCd1hSRCtyOEFSNThyRkVvRjNrQjYxb2hBU0dEbzdjbklRVmpn?=
 =?utf-8?B?ekNXRXNvOU15WmsvZUN4YWpTNWU3alovNFVEWjRRbGhnTlR3ZWVoaktabTdT?=
 =?utf-8?B?bWJ4VGg5RjdLQUZ2R1RnMHBMMXVWekJTV3dzOS9oMEkwZ1VLakovVUNFRkU1?=
 =?utf-8?B?V0hkTjd1TlVITlZxK0c4dWR4Q1BMYXVUVUtYaWJxT09mWms2aTZmYVpRYmlm?=
 =?utf-8?B?VVlmUVhYckVYY2ZUK1dhOWFNbUxUOGh3OWpYV0tGVE5taEh1bUgweHB1RCtQ?=
 =?utf-8?B?bVN5akdhMFI5VjkrRHdmTmZ4QlltMUtUa1NtRTdsVURNcUxPL1BySTd4SE1u?=
 =?utf-8?B?cHc5ZVV1b1VxWmRXSy9Rb0RtQ1pLZElwNXdicS9Lc0xRamQzVXBFQzZPR2k0?=
 =?utf-8?B?OFhSQnc2a1ZnaGV5eExtTzlVMmFQRFBmMDFtTUZsUytYUytWaWpQVHU5aXZQ?=
 =?utf-8?B?cUtLbkNkNzg5WEdmMys3aVdyTXN3bWNiM3kraUw3VkNoVmcvN0xxMitnai9u?=
 =?utf-8?B?SG9aVWFZMmg4Vm5OT1FqdDJDSEt0QjdQZDlRUEFiRWR1UjBNaGhrOWFCTFVB?=
 =?utf-8?B?MGNBamF6TXo4YjFjUXRBS1ZzUHB2VnU3bmw5Z2lJbjRWdHhYVUZJRDRwdkNu?=
 =?utf-8?B?VEpDTCswZ3U3QVg1V0hmWTd3TDBrcEYwUmxYVzNNWTNFZkEwMldza1ZSWExL?=
 =?utf-8?B?WGU3QUwxclhLK2dlU1E1NDVlUVBYcXFidVl6NTIzSHg5azhyRDFMR1g0V1N6?=
 =?utf-8?B?WWFyUUhaRE9McUlNYWtycXFwNlIxaDF4Z0VObGwxZGI3MkRGVi9rbTJXazN3?=
 =?utf-8?B?Y0dOUlpTMjY3SUVzRlJlNW54MXNvN0xBVGFPUXZCRGhGSGt0TXdmRHBRV2pY?=
 =?utf-8?B?SHR5SFNEcVFkdnQ0VGRsSzNCQ0JZbDJCR1JjZDN5UzNTY0JXbVdnMWYwdk9S?=
 =?utf-8?B?VnMzYkV0RHVTVExIWW5ZNWJvenVCMmlVa0dRMTIvR3RWOTVGcHg2cFNNRzBP?=
 =?utf-8?B?NTBIVlRTVWxYa3lVcG03UDdKZmtQeEh3RG9EK2lERnNMRXY4M2VmVml1bnRy?=
 =?utf-8?B?My9PZHJOOEVQNndLWnIvVkRSdEROcTFOQmMxUG1IaTlxdkVWS3haQUZWeFlG?=
 =?utf-8?B?UlNSSEx3aHduYmNUNmNnMVV2VnZ1YXpWRDNPSHUwbGZjcHAwemhZR1NwZ2xo?=
 =?utf-8?B?Nk1OemhhV1dvaUhxNzdVVlpDVXBzdWJaeXR6eGVEZ2dvdTNxay84eTRRQllm?=
 =?utf-8?B?ZUpCQ25tcHBhSnk3eGhhT2k3d2xDcFRMQllSMVdtVWowRllGRXBrbzk4dHpR?=
 =?utf-8?Q?DjPfkp1l9w4kD+keXJzH1UXIzYdaT/ITLnJRx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FFD3DAF0C35CC7489FCA96D570B1559E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9cbc8e-4b7a-4dc2-766b-08da36be70bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2022 22:01:18.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9eKo1yUKxbidGSamo/C7WWyLKuGHsOD1z+D4Qot4C8aVRVcgM0vPmXgojirLJeHcjLerNP/GGH4t1begfzIfrcLDxSQilgx2njkModfxq3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4491
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIyLTA1LTE1IGF0IDIxOjM4ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFN1biwgTWF5IDE1IDIwMjIgYXQgMTg6MjQsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3Rl
Og0KPiA+IE9uIFN1biwgMjAyMi0wNS0xNSBhdCAxMTowMiArMDIwMCwgVGhvbWFzIEdsZWl4bmVy
IHdyb3RlOg0KPiA+ID4gSWYgaXQgcmVhbGx5IHR1cm5zIG91dCB0byBiZSBzb21ldGhpbmcgd2hp
Y2ggbWF0dGVycywgdGhlbiB5b3UNCj4gPiA+IGNhbg0KPiA+ID4gcHJvdmlkZSBhIGJhdGNoIGlu
dGVyZmFjZSBsYXRlciBvbiBpZiBpdCBtYWtlcyBzZW5zZSB0byBkbyBzbywNCj4gPiA+IGJ1dA0K
PiA+ID4gc2VlDQo+ID4gPiBhYm92ZS4NCj4gPiANCj4gPiBUaGFua3MsIHNvdW5kcyBnb29kIHRv
IG1lLg0KPiA+IA0KPiA+IEtpcmlsbCwgc28gSSBndWVzcyB3ZSBjYW4ganVzdCBjaGFuZ2UgQVJD
SF9USFJFQURfRkVBVFVSRV9FTkFCTEUvDQo+ID4gQVJDSF9USFJFQURfRkVBVFVSRV9ESVNBQkxF
IHRvIHJldHVybiBFSU5WQUwgaWYgbW9yZSB0aGFuIG9uZSBiaXQNCj4gPiBpcw0KPiA+IHNldC4g
SXQgcmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIHdoYXRldmVyIGVycm9yIGNvZGUgb24gZmFpbHVy
ZS4NCj4gPiBVc2Vyc3BhY2UgY2FuIGRvIHdoYXRldmVyIHJvbGxiYWNrIGxvZ2ljIGl0IHdhbnRz
LiBXaGF0IGRvIHlvdQ0KPiA+IHRoaW5rPw0KPiANCj4gV2h5IGhhdmluZyB0aGlzIGZlYXR1cmUg
Yml0IGludGVyZmFjZSBpbiB0aGUgZmlyc3QgcGxhY2U/DQoNClRoZSBpZGVhIHdhcyB0aGF0IHdl
IHNob3VsZCBub3QgaGF2ZSBkdXBsaWNhdGUgaW50ZXJmYWNlcyBpZiB3ZSBjYW4NCmF2b2lkIGl0
LiBJdCBvZiBjb3Vyc2UgZ3JldyBvdXQgb2YgdGhlICJlbGYgZmVhdHVyZSBiaXQiIHN0dWZmLCBi
dXQgd2UNCmNvbnNpZGVyZWQgc3BsaXR0aW5nIHRoZW0gYWZ0ZXIgbW92aW5nIGF3YXkgZnJvbSB0
aGF0LiBMQU0gYW5kIENFVCdzDQplbmFibGluZyBuZWVkcyBzZWVtZWQgY2xvc2UgZW5vdWdoIHRv
IGF2b2lkIGhhdmluZyB0d28gaW50ZXJmYWNlcy4NCg0KPiANCj4gSXQncyBnb2luZyB0byBiZSBh
IGRlbXVsdGlwbGV4IG1lY2hhbmlzbSB3aXRoIGluY29tcGF0aWJsZQ0KPiBhcmd1bWVudHMuIEp1
c3QgbG9vayBhdCBMQU0uIFdoYXQncyByZWFsbHkgYXJjaGl0ZWN0dXJlIHNwZWNpZmljDQo+IGFi
b3V0DQo+IGl0Pw0KPiANCj4gVGhlIG1lY2hhbmlzbSBwZXIgc2UgaXMgYXJjaGl0ZWN0dXJlIGlu
ZGVwZW5kZW50OiBwb2ludGVyIHRhZ2dpbmcuDQo+IA0KPiBXaGF0J3MgYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGlzIHdoZXRoZXIgaXQncyBzdXBwb3J0ZWQsIHRoZSBhZGRyZXNzDQo+IG1hc2sNCj4g
YW5kIHRoZSBlbmFibGUvZGlzYWJsZSBtZWNoYW5pc20uDQo+IA0KPiBTbyBoYXZpbmcgZS5nLg0K
PiANCj4gICAgcHJjdGwoUE9JTlRFUl9UQUdHSU5HX0dFVF9NQVNLLCAmbWFzayk7DQo+IA0KPiB3
b3JrcyBvbiBhbGwgYXJjaGl0ZWN0dXJlcyB3aGljaCBzdXBwb3J0IHRoaXMuIERpdHRvDQo+IA0K
PiAgICBwcmN0bChQT0lOVEVSX1RBR0dJTkdfRU5BQkxFLCAmbWFzayk7DQo+IA0KPiBpcyBhcmNo
aXRlY3R1cmUgYWdub3N0aWMuIEJvdGggbmVlZCB0byBiZSBiYWNrZWQgYnkgYW4gYXJjaGl0ZWN0
dXJlDQo+IHNwZWNpZmljIGltcGxlbWVudGF0aW9uIG9mIGNvdXJzZS4NCj4gDQo+IFRoaXMgbWFr
ZXMgaXQgZnV0dXJlIHByb29mIGJlY2F1c2UgbmV3IENQVXMgY291bGQgZGVmaW5lIHRoZSBtYXNr
IHRvDQo+IGJlDQo+IGJpdCA1Ny02MSBhbmQgdXNlIGJpdCA2MiBmb3Igc29tZXRoaW5nIGVsc2Uu
IFNvIGZyb20gYSB1c2VyIHNwYWNlDQo+IHBlcnNwZWN0aXZlIHRoZSBtYXNrIHJldHJpdmFsIGlz
IHVzZWZ1bCBiZWNhdXNlIGl0J3Mgb2J2aW91cyBhbmQNCj4gdHJpdmlhbA0KPiB0byB1c2UgYW5k
IGRvZXMgbm90IG5lZWQgY29kZSBjaGFuZ2VzIHdoZW4gdGhlIGhhcmR3YXJlDQo+IGltcGxlbWVu
dGF0aW9uDQo+IHByb3ZpZGVzIGEgZGlmZmVyZW50IG1hc2suDQoNClRoZSBsYWNrIG9mIGFiaWxp
dHkgdG8gcGFzcyBleHRyYSBhcmd1bWVudHMgaXMgYSBnb29kIHBvaW50Lg0KDQo+IA0KPiBTZWU/
DQoNClJlZ2FyZGluZyBtYWtpbmcgaXQgYXJjaCBzcGVjaWZpYyBvciBub3QsIGlmIHRoZSBMQU0g
aW50ZXJmYWNlIGNhbiBiZQ0KYXJjaCBhZ25vc3RpYywgdGhlbiB0aGF0IG1ha2VzIHNlbnNlIHRv
IG1lLiBJIGd1ZXNzIHNvbWUgQ1BVIGZlYXR1cmVzDQoodmlydHVhbCBtZW1vcnksIGV0YykgYXJl
IHNpbWlsYXIgZW5vdWdoIHRoYXQgdGhlIGtlcm5lbCBjYW4gaGlkZSB0aGVtDQpiZXlvbmQgY29t
bW9uIGludGVyZmFjZXMuIFNvbWUgYXJlbid0IChjcHVpZCwgZ3MgcmVnaXN0ZXIsIGV0YykuIElm
IExBTQ0KY2FuIGJlIG9uZSBvZiB0aGUgZm9ybWVyLCB0aGVuIHNoYXJpbmcgYW4gaW50ZXJmYWNl
IHdpdGggb3RoZXINCmFyY2hpdGVjdHVyZXMgZG9lcyBzZWVtIG11Y2ggYmV0dGVyLg0KDQpJJ20g
dGhpbmtpbmcgQ0VUIGlzIGRpZmZlcmVudCBlbm91Z2ggZnJvbSBvdGhlciBzaW1pbGFyIGZlYXR1
cmVzIHRoYXQNCmxlYXZpbmcgaXQgYXMgYW4gYXJjaCB0aGluZyBpcyBwcm9iYWJseSBhcHByb3By
aWF0ZS4gQlRJIGlzIHByb2JhYmx5DQp0aGUgY2xvc2VzdCAodG8gSUJUKS4gSXQgdXNlcyBpdCdz
IG93biBCVEkgc3BlY2lmaWMgZWxmIGhlYWRlciBiaXQsIGFuZA0KcmVxdWlyZXMgc3BlY2lhbCBQ
Uk9UIG9uIG1lbW9yeSwgdW5saWtlIElCVC4NCg0KPiANCj4gVGhlIHRocmVhZC5mZWF0dXJlcyBi
aXRtYXAgY291bGQgc3RpbGwgYmUgdXNlZCBhcyBhbiBpbnRlcm5hbCBzdG9yYWdlDQo+IGZvciBl
bmFibGVkIGZlYXR1cmVzLCBidXQgaGF2aW5nIHRoaXMgYXMgdGhlIHByaW1hcnkgcHJvZ3JhbW1p
bmcNCj4gaW50ZXJmYWNlIGlzIGN1bWJlcnNvbWUgYW5kIHVuZmxleGlibGUgZm9yIGFueXRoaW5n
IHdoaWNoIGlzIG5vdA0KPiBiaW5hcnkNCj4gb24vb2ZmLg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
ICAgICAgICB0Z2x4DQo+IA0KPiANCg==
