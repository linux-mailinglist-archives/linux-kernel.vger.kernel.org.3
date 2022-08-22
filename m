Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5659BBF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiHVIrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiHVIr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:47:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF1C2CE2A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661158047; x=1692694047;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fRI74ILS17XWRV5fQ65xgMgQ0xFcUdJrGAJrZkrNLWA=;
  b=DncZ5dQf4YwnqI/VVHji988q12OLPzgDD35wL7vKR2dqKoW7WL/kO1Tf
   TrfxDJCh6pXO/bOOPFRsd3ptV0YE2nRScRcTa0KWfuZB0cEfRKFBmpUt8
   FxK/oKDYKiTflB26HWOdbB0vq5/aKZAWRkhHefFuML4wBKatq0t4WXYD1
   fEh+vXHH36Ybi1Dnr5i3BYZGA4NhlJg9byccKbXqIuhm3RulftgWL96Mv
   3iFPiceD63aXaQrcCsRmeDdQUi1LBbxFSr/LEHcDiTenVaDw1/fkxMDI1
   TudKy0LA7sIK0hHSlA4SWwYnM3Pxyl3kBL9XAEaG3SxPlPActRmhWV64w
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="379651776"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="379651776"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 01:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="698213140"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Aug 2022 01:47:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 01:47:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 01:47:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 01:47:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwB2AyCWSWkpcJ5IgK7LeEGV+7rfmLI5oW77d1DOEGPuJNK/ntLSKXwbRv2VQ0fOcB7RqEPQo356LudIVoTouPT0W7wMY9bVjECsMZW4r93duYlaY6QZkqS9WewhY72fiffim3E9Q2GBG7nbaQGVZagFFncrSzXzCgGb1FXnYUcvUyzdh908ujfVuxgf5dxkS+CYOQ257QswKinvklRyL96YLv3NR4ZMCYt0Cv/Slq51/YXAcOT9U6g6JoLQ64hyuExcnhfNya3hMf5J6VpkqnHT7WXNa7ayHC7Rb1Ss+bTxRZ0TelP8lKsYcKH/CvfRovzbMvz+Nma73MqoEf8hvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMkoiB1U/4pgBTpr7Us0U0mjR+ZqUgI8fxHRt6OD6Mo=;
 b=KG1zWMKMo1ZOqXzC+osrJXsIfoAMIGvZyeUNE5vD0TyTbUbta5xhpW2Ye/hrWAmzp3jIdotB5NG1SQEPFlZsSYnJF9BK/jzP22JFq3Sd8hfmpX1X1IEhdyMuywV/vEF4CTcWnITDMP25tDWD7naI9g0f5sdfn2s59KiwKVQk2Lhm3jqI0gaTgHY7XLF+sqweegov+b+tF+BBPiiZTRyuAqYrePFSP5GEC4NyigksdoZWwr+rxl71MmcZ1qyazJhtJOQ+uMooqvKYwfUfCWDqky7fgz8KoAV9ehGBPBQijGWx/9YmThkMQdSzYBDczQX0qwk02iWwGq67AwJW/GYAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5310.namprd11.prod.outlook.com (2603:10b6:5:391::19)
 by MWHPR11MB1967.namprd11.prod.outlook.com (2603:10b6:300:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 08:47:19 +0000
Received: from DM4PR11MB5310.namprd11.prod.outlook.com
 ([fe80::50fb:ef2b:38da:6049]) by DM4PR11MB5310.namprd11.prod.outlook.com
 ([fe80::50fb:ef2b:38da:6049%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 08:47:19 +0000
From:   "Zhang, Weihong" <weihong.zhang@intel.com>
To:     "Hu, Robert" <robert.hu@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Weihong" <weihong.zhang@linux.intel.com>
Subject: RE: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
Thread-Topic: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
 cases for linear-address masking
Thread-Index: AQHYsF2klaR0mms/cE6Gw+7wKWKS1K215uGAgAEoEnA=
Date:   Mon, 22 Aug 2022 08:47:18 +0000
Message-ID: <DM4PR11MB531021EF2652531F037D21BBEE719@DM4PR11MB5310.namprd11.prod.outlook.com>
References: <20220815041803.17954-1-kirill.shutemov@linux.intel.com>
 <20220815041803.17954-10-kirill.shutemov@linux.intel.com>
 <CY5PR11MB6187230204E669607437716FE06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
In-Reply-To: <CY5PR11MB6187230204E669607437716FE06C9@CY5PR11MB6187.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e8028d7-d4e2-40ff-eb85-08da841aebfd
x-ms-traffictypediagnostic: MWHPR11MB1967:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81eZjiqTgQCiYBObY1kTrMxDDVkExKzNXBcBeoZQM/00U1qyCSkeF8jqnNV1ebTv8x7oBlQZ3TfDwV3dF/mBsW8wkK1OR8/o7IHvfMiFQ+dwBjq0zbkvc3e0YQYeU8ssklU0cFmZKT5jQBOBXrOJCf4hRfQQxM/jQB/whmojuAii4G6KGGs7N30TXDGafptTTk7Pj2XYYAM8CzjzJaG6tP2z/QoFAtDV/wC517wMFP+mEH4BOLU+KZQa7FxRxKi9Fz19DPuvIzGnMQ8SAa8IKPV78+lGC2eMfDmDFDtwwhUP5F4RrYl/QxKkVurrbWZ3ERD34G6tG7hQHBDthT32kx323E46JcKlAaq37rQbBuFIV68w2rkLfAIZWMh2n6rcio0ZZegeaCu/oUWk1GBaK62Ap3RYksFjApstkV6KhBbvHS3zVw3Zv6FWLWRDnsjV5twTb7a0beRZSnQoc06VlgymfH9mbeEH2Lg8dHEAWHmsEBDWb4iTYwvRdCXaE/JZV2Z6Tpi/Ur84W7TQByg/JvpJYLagljifKUt6iGW+4zWeiJrJQxHn0aTnHwk7MNVZiJq/5SxtqsOtVGdXHbhs8nCd+4Kg9Q3IVa9IbfDPPuRdj53VK7XUVDMdrSwk8Bz1UEAVY21unoxhHyuH94FpN93E3ZPro4566K/B7+hz+ccZ10HMJR3mnGsMND5y8xmvEPh7RahtfFl4cp6jwc+QJ0k/LTXWzGFNqBGutlH1o0iU1/WSSo/J/+fhxJdDF7l7IksxGpap9mD9ULP4wJmJyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5310.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(136003)(39860400002)(346002)(9686003)(64756008)(4326008)(2906002)(8676002)(7416002)(5660300002)(52536014)(8936002)(66476007)(66446008)(66556008)(66946007)(76116006)(7696005)(53546011)(6506007)(33656002)(26005)(186003)(55016003)(478600001)(41300700001)(71200400001)(82960400001)(86362001)(83380400001)(110136005)(316002)(54906003)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QYfBDPoiaimY59O0cPQL2H8UQKt2wV0M0O0d0uyYp+Ov9pWqavzG/6oCvw0S?=
 =?us-ascii?Q?XQl7j5QODM6U+MuntaFpXLLrm7dCmIcvXaZHm8qCWwp2xSLyLBBkRPVKKswB?=
 =?us-ascii?Q?tBmJmZuQnMVU5UsPHmhi2DUhIWHJcWV/dnqwQjVMFJjPiRrJR+nklR9j9BoF?=
 =?us-ascii?Q?i/OAdkob0VoaRKVU25ap5i9G4+e5qgDvOLcHU9aUwwhNanr4EZHfcpD/MGGx?=
 =?us-ascii?Q?uWnvg7oWw0IIt9sPoRrIZvpFxBI+3ajZ6L1aYDl6JAnd/q7YOf3Ijsai7qf2?=
 =?us-ascii?Q?Vak1Dkc5uU/emfG3WyIFknnRIZHXz4iKOyuoMrPR0SvD2Y5s5/LLxGlOeR8D?=
 =?us-ascii?Q?qGB5E3CHO0Lc9UsVA+z7cFeftsSJe6lu4wjTY2Si7hTNHXdf8AqiOPL41E+Y?=
 =?us-ascii?Q?GSSX8kO2NNlSZ4wk5wGb4eqdJPBEZMDh1BrSKPjkYf+DDfesMgcUdESGc/Yr?=
 =?us-ascii?Q?kWEinxr9r2Uadpq4nY2DpPEXyyEieDL1Btfh5O/0IvWmAtffqwFRfFwXp3y1?=
 =?us-ascii?Q?XreecJtAu0pOc538dTJUx9jf8wDvNO9gDASSdGA+syDD51GYEkbcmznpuqcz?=
 =?us-ascii?Q?AJvShOlYENHmAk/N6wztQKaveedRShdUB+Vpv0eVnGXGxtCS+dmwkatse8B9?=
 =?us-ascii?Q?NPJcApSGigp+NjoLvrT1bxXZ2/lZmSFFXjrXjSmtPCWLWZWfQ2ItfkvqzB79?=
 =?us-ascii?Q?NU3ZGwuFWOWb+/Gt9GfJU6Hq24EJ4OTxbx1EkbPljjLdWGPNp9Q/rctttbN+?=
 =?us-ascii?Q?UjlRckKDtb1dz/WO4/vTle5V+nJFFKrIxqHqwOMP5WZLFbbyqGKn7k+Ajtmw?=
 =?us-ascii?Q?j8DWiuBLI8Z3sl7/91a05lQfP0pTTbNnvTI/O8PIyXp1byOnxoPLlbX4PBk+?=
 =?us-ascii?Q?3pW3PbTd0YMr+t7j6ucg5cZ5J7/GNWdKdaeybxDj4b7XCT1TOD+TeqXs5STq?=
 =?us-ascii?Q?HYjxoCCERuIUvdHG4/eHpK3cmbyQJRayydkBCuvmzyD9kRCDSxsH6fRaL2ko?=
 =?us-ascii?Q?KdSV89b371PXrspXTKqz1gxj74CzMbslsauhkyMQ4gdReMld1Tu4EjPH3M0f?=
 =?us-ascii?Q?v1B9B3/XIR7R6cl3FHnr7SLfM+q/E3VxFS451g7+WP1HKgUDJm2tnaZ4jSR8?=
 =?us-ascii?Q?jiInU2VCNjnj+QQLTicOPkB1Q+D7WVV6omuEa5yBgmYM56fTT9m4J0qoTf5V?=
 =?us-ascii?Q?ZFZXxjqU1kxLNjjywRgXiXuX19HvPhr2De2GW9MJhkUVofpDSYE8y8WqCrFM?=
 =?us-ascii?Q?lVcJUil/Eafe9fi3MagzVxaQj5FW91hIclSUgXAjhS6zlPQfuXIjfQd5x5o8?=
 =?us-ascii?Q?mdaxPBEEehWdLTcdpJCh4csICQ1gVonKUd/TCA69FHdxHnJUnqAsbAhxmvZH?=
 =?us-ascii?Q?3tLK+CZ2eLeGXDK7Fvl1DeEEhtG7UwLB/ZatQYGI/Qddz2osNIcpiAoTuxGD?=
 =?us-ascii?Q?6QsHaJz03jkR8zmsKUn7KEUo4V6DzA0empqM76J95oN4zaSJB+mtee2HAC7p?=
 =?us-ascii?Q?BizfGb4L3dc11KzDM9kWSD3cKjY82xNQhLylLnr8Gbw3wuqQ8PSk2qB3QIDP?=
 =?us-ascii?Q?GfsXNqLf6oLZ34iA0DHjCk6JKCxfrnln0ZTuHKvW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5310.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8028d7-d4e2-40ff-eb85-08da841aebfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 08:47:18.9180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zQfqP+Dnz3CzVycYmS5UweIcvPnJYHiezUeyv8Cy2iBjDucxpAE92zaZeykho7BILLuLrLJNRvcbS0VysYVFCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1967
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Hu, Robert <robert.hu@intel.com>
> Sent: Friday, August 19, 2022 4:15 PM
> To: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>; Dave Hansen
> <dave.hansen@linux.intel.com>; Lutomirski, Andy <luto@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>
> Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey Ryabinin
> <ryabinin.a.a@gmail.com>; Andrey Konovalov <andreyknvl@gmail.com>;
> Alexander Potapenko <glider@google.com>; Taras Madan
> <tarasmadan@google.com>; Dmitry Vyukov <dvyukov@google.com>; H . J .
> Lu <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>; Edgecombe,
> Rick P <rick.p.edgecombe@intel.com>; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org; Zhang, Weihong <weihong.zhang@intel.com>
> Subject: RE: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
> cases for linear-address masking
>=20
> > -----Original Message-----
> > From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Sent: Monday, August 15, 2022 12:18
> > To: Dave Hansen <dave.hansen@linux.intel.com>; Lutomirski, Andy
> > <luto@kernel.org>; Peter Zijlstra <peterz@infradead.org>
> > Cc: x86@kernel.org; Kostya Serebryany <kcc@google.com>; Andrey
> > Ryabinin <ryabinin.a.a@gmail.com>; Andrey Konovalov
> > <andreyknvl@gmail.com>; Alexander Potapenko <glider@google.com>;
> Taras
> > Madan <tarasmadan@google.com>; Dmitry Vyukov
> <dvyukov@google.com>; H .
> > J . Lu <hjl.tools@gmail.com>; Andi Kleen <ak@linux.intel.com>;
> > Edgecombe, Rick P <rick.p.edgecombe@intel.com>; linux-mm@kvack.org;
> > linux- kernel@vger.kernel.org; Zhang, Weihong
> <weihong.zhang@intel.com>; Kirill A .
> > Shutemov <kirill.shutemov@linux.intel.com>
> > Subject: [PATCHv6 09/11] selftests/x86/lam: Add mmap and SYSCALL test
> > cases for linear-address masking
> >
> > From: Weihong Zhang <weihong.zhang@intel.com>
> >
> > Add mmap and SYSCALL test cases.
> >
> > SYSCALL test cases:
> >
> >  - LAM supports set metadata in high bits 62:57 (LAM_U57) of a user
> > pointer, pass
> >    the pointer to SYSCALL, SYSCALL can dereference the pointer and
> > return correct
> >    result.
> >
> >  - Disable LAM, pass a pointer with metadata in high bits to SYSCALL,
> >    SYSCALL returns -1 (EFAULT).
> >
> > MMAP test cases:
> >
> >  - Enable LAM_U57, MMAP with low address (below bits 47), set metadata
> >    in high bits of the address, dereference the address should be
> >    allowed.
> >
> >  - Enable LAM_U57, MMAP with high address (above bits 47), set metadata
> >    in high bits of the address, dereference the address should be
> >    allowed.
> >
> > Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  tools/testing/selftests/x86/lam.c | 135
> > +++++++++++++++++++++++++++++-
> >  1 file changed, 132 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/testing/selftests/x86/lam.c
> > b/tools/testing/selftests/x86/lam.c
> > index 4c6c6dbf7db6..e9e92ab7fea8 100644
> > --- a/tools/testing/selftests/x86/lam.c
> > +++ b/tools/testing/selftests/x86/lam.c
> > @@ -7,6 +7,7 @@
> >  #include <signal.h>
> >  #include <setjmp.h>
> >  #include <sys/mman.h>
> > +#include <sys/utsname.h>
> >  #include <sys/wait.h>
> >  #include <inttypes.h>
> >
> > @@ -27,11 +28,18 @@
> >  /* Specified test function bits */
> >  #define FUNC_MALLOC             0x1
> >  #define FUNC_BITS               0x2
> > +#define FUNC_MMAP               0x4
> > +#define FUNC_SYSCALL            0x8
> >
> > -#define TEST_MASK               0x3
> > +#define TEST_MASK               0xf
> > +
> > +#define LOW_ADDR                (0x1UL << 30)
> > +#define HIGH_ADDR               (0x3UL << 48)
> >
> >  #define MALLOC_LEN              32
> >
> > +#define PAGE_SIZE               (4 << 10)
> > +
> >  struct testcases {
> >  	unsigned int later;
> >  	int expected; /* 2: SIGSEGV Error; 1: other errors */ @@ -47,6 +55,7
> > @@ jmp_buf segv_env;  static void segv_handler(int sig)  {
> >  	ksft_print_msg("Get segmentation fault(%d).", sig);
> > +
> >  	siglongjmp(segv_env, 1);
> >  }
> >
> > @@ -59,6 +68,16 @@ static inline int cpu_has_lam(void)
> >  	return (cpuinfo[0] & (1 << 26));
> >  }
> >
> > +/* Check 5-level page table feature in CPUID.(EAX=3D07H,
> > +ECX=3D00H):ECX.[bit 16] */ static inline int cpu_has_la57(void) {
> > +	unsigned int cpuinfo[4];
> > +
> > +	__cpuid_count(0x7, 0, cpuinfo[0], cpuinfo[1], cpuinfo[2],
> > +cpuinfo[3]);
> > +
> > +	return (cpuinfo[2] & (1 << 16));
> > +}
> > +
> >  /*
> >   * Set tagged address and read back untag mask.
> >   * check if the untagged mask is expected.
> > @@ -204,6 +223,68 @@ static int handle_malloc(struct testcases *test)
> >  	return ret;
> >  }
> >
> > +static int handle_mmap(struct testcases *test) {
> > +	void *ptr;
> > +	unsigned int flags =3D MAP_PRIVATE | MAP_ANONYMOUS |
> MAP_FIXED;
> > +	int ret =3D 0;
> > +
> > +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) !=3D 0)
> > +			return 1;
> > +
> > +	ptr =3D mmap((void *)test->addr, PAGE_SIZE, PROT_READ |
> > PROT_WRITE,
> > +		   flags, -1, 0);
> > +	if (ptr =3D=3D MAP_FAILED) {
> > +		if (test->addr =3D=3D HIGH_ADDR)
> > +			if (!cpu_has_la57())
> > +				return 3; /* unsupport LA57 */
> > +		return 1;
> > +	}
> > +
> > +	if (test->later !=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) !=3D 0)
> > +			ret =3D 1;
> > +
> > +	if (ret =3D=3D 0) {
> > +		if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> > +			signal(SIGSEGV, segv_handler);
> > +			ret =3D handle_lam_test(ptr, test->lam);
> > +		} else {
> > +			ret =3D 2;
> > +		}
> > +	}
> > +
> > +	munmap(ptr, PAGE_SIZE);
> > +	return ret;
> > +}
> > +
> > +static int handle_syscall(struct testcases *test) {
> > +	struct utsname unme, *pu;
> > +	int ret =3D 0;
> > +
> > +	if (test->later =3D=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) !=3D 0)
> > +			return 1;
> > +
> > +	if (sigsetjmp(segv_env, 1) =3D=3D 0) {
> > +		signal(SIGSEGV, segv_handler);
> > +		pu =3D (struct utsname *)get_metadata((uint64_t)&unme,
> test-
> > >lam);
> > +		ret =3D uname(pu);
> > +		if (ret < 0)
> > +			ret =3D 1;
> > +	} else {
> > +		ret =3D 2;
> > +	}
> > +
> > +	if (test->later !=3D 0 && test->lam !=3D 0)
> > +		if (set_lam(test->lam) !=3D -1 && ret =3D=3D 0)
> > +			ret =3D 1;
> > +
> > +	return ret;
> > +}
> > +
> >  static int fork_test(struct testcases *test)  {
> >  	int ret, child_ret;
> > @@ -259,7 +340,6 @@ static struct testcases malloc_cases[] =3D {
> >  	},
> >  };
> >
> > -
> >  static struct testcases bits_cases[] =3D {
> >  	{
> >  		.test_func =3D handle_max_bits,
> > @@ -267,11 +347,54 @@ static struct testcases bits_cases[] =3D {
> >  	},
> >  };
> >
> > +static struct testcases syscall_cases[] =3D {
> > +	{
> > +		.later =3D 0,
> > +		.lam =3D LAM_U57_BITS,
> > +		.test_func =3D handle_syscall,
> > +		.msg =3D "SYSCALL: LAM_U57. syscall with metadata\n",
> > +	},
> > +	{
> > +		.later =3D 1,
> > +		.expected =3D 1,
> > +		.lam =3D LAM_U57_BITS,
> > +		.test_func =3D handle_syscall,
> > +		.msg =3D "SYSCALL:[Negtive] Disable LAM. Dereferencing
> pointer
> [Hu, Robert]
> Trivial, Negtive --> Negative.
>=20
Thanks, will fix the typo.
> > with metadata.\n",
> > +	},
> > +};
> > +
> > +static struct testcases mmap_cases[] =3D {
> [Hu, Robert]
> Can mmap also have negative case?
>=20
Mmap just get a pointer. under U57 mode, negative case for mmap can refer t=
o malloc cases.
> > +	{
> > +		.later =3D 1,
> > +		.expected =3D 0,
> > +		.lam =3D LAM_U57_BITS,
> > +		.addr =3D HIGH_ADDR,
> > +		.test_func =3D handle_mmap,
> > +		.msg =3D "MMAP: First mmap high address, then set
> > LAM_U57.\n",
> > +	},
> > +	{
> > +		.later =3D 0,
> > +		.expected =3D 0,
> > +		.lam =3D LAM_U57_BITS,
> > +		.addr =3D HIGH_ADDR,
> > +		.test_func =3D handle_mmap,
> > +		.msg =3D "MMAP: First LAM_U57, then High address.\n",
> > +	},
> > +	{
> > +		.later =3D 0,
> > +		.expected =3D 0,
> > +		.lam =3D LAM_U57_BITS,
> > +		.addr =3D LOW_ADDR,
> > +		.test_func =3D handle_mmap,
> > +		.msg =3D "MMAP: First LAM_U57, then Low address.\n",
> > +	},
> > +};
> > +
> >  static void cmd_help(void)
> >  {
> >  	printf("usage: lam [-h] [-t test list]\n");
> >  	printf("\t-t test list: run tests specified in the test list,
> > default:0x%x\n", TEST_MASK);
> > -	printf("\t\t0x1:malloc; 0x2:max_bits;\n");
> > +	printf("\t\t0x1:malloc; 0x2:max_bits; 0x4:mmap; 0x8:syscall.\n");
> >  	printf("\t-h: help\n");
> >  }
> >
> > @@ -311,6 +434,12 @@ int main(int argc, char **argv)
> >  	if (tests & FUNC_BITS)
> >  		run_test(bits_cases, ARRAY_SIZE(bits_cases));
> >
> > +	if (tests & FUNC_MMAP)
> > +		run_test(mmap_cases, ARRAY_SIZE(mmap_cases));
> > +
> > +	if (tests & FUNC_SYSCALL)
> > +		run_test(syscall_cases, ARRAY_SIZE(syscall_cases));
> > +
> >  	ksft_set_plan(tests_cnt);
> >
> >  	return ksft_exit_pass();
> > --
> > 2.35.1

