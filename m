Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2346D185
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 12:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhLHLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:06:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:2224 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhLHLGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:06:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="235320269"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="235320269"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 03:03:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="503014921"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2021 03:03:07 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 03:03:06 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 03:03:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 03:03:06 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 03:03:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y19HKlB7M4SWyWwfIiTAM+WHmg0BHVbIqqsYNhRkipb1G5aT0tC/gun2bBzLEYDj5IRlWekmGpt7s0vBhwUrpefb5acfztHRNzvBn+JftMgVeWLE/SwqGFs23SgCaJhyFZsXAND6vGyG81kK4FAKsa1J0oOeW0NxU4IfqtWrBne+giY5L6KWHTRItDvPtUnUEaZdyaZt1CEI4knIgOjX/LMBxwTNTOoFWJt04fghS2e7pB14AOOi5DVH7T87wuGqfZvctyd9q4j22RMcEHEj+jhlJ4jP5U1QqIZ7ayX91eDqJGkKrBDST90eH9qRHv413wz6NYtEdjv5QtAS9YrUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJVzH41Q9C5PkHvyxNEEAbjZt1WbMTNiL91IJx/qGY4=;
 b=aozoERWJlWOwPeIZtBilR8kX3TaNaZHDiYQWuZYPHtLSmqw8EgJxQ2M0iZEzCf0rWJj/Sx80Ruwbz+q4ewUQXLK/A/geSuriy8tl+S6j5NpTPe795fTqzLUDYFZNKdhrpQCZu3q5/a9AZeG51zpuaj3Z4C7isrUfQ90u2vsOXOla8kBBzoG/4QmbkkIY8IBrcF+TeQCp15VA4v/5a+JrZnyT0d/wche0oHF5ZXbAIGK6utTGICwPi8/hVlp2VbN+12bjfhwTHnOEJaITMRKUXa+HnM7s9OPsEqn+Li8DxtwIuvaRvdtDQiyzx9u37ISFFMcwkpSoI/aZxlPStcwtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJVzH41Q9C5PkHvyxNEEAbjZt1WbMTNiL91IJx/qGY4=;
 b=kyNu1VWTF8y6RyUU5gnGBeNbG2XKy1Zh52fVn8IJ1sNxvPIb30ETlgcALmniksIzU7jyE8Ul5iALQxlTXaNxKT/ytyDXxz2UdVPwSzWZ/A0250yewDCPef+FYkdynxSnPq3gR0WaSQabtu4MeRpIdFnrHiXUsVBcCF/x1UJ0uNk=
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18)
 by BYAPR11MB3607.namprd11.prod.outlook.com (2603:10b6:a03:b2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Wed, 8 Dec
 2021 11:03:04 +0000
Received: from SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::50af:ee0a:320c:a26f]) by SJ0PR11MB5816.namprd11.prod.outlook.com
 ([fe80::50af:ee0a:320c:a26f%7]) with mapi id 15.20.4649.019; Wed, 8 Dec 2021
 11:03:03 +0000
From:   "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: RE: [PATCH v3 3/5] spi: dw: Add support for master mode selection for
 DWC SSI controller
Thread-Topic: [PATCH v3 3/5] spi: dw: Add support for master mode selection
 for DWC SSI controller
Thread-Index: AQHX1skAjajAYr0c7EewenRpP9BbBav+X8GAgAAKQACAAAYOAIAADoiAgAAFMQCACAtYAIABF3/AgCDxA9A=
Date:   Wed, 8 Dec 2021 11:03:03 +0000
Message-ID: <SJ0PR11MB5816530165EEFCE780F1CDB0856F9@SJ0PR11MB5816.namprd11.prod.outlook.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
 <20211111065201.10249-4-nandhini.srikandan@intel.com>
 <YY0lpZkIsJih+g2o@sirena.org.uk>
 <20211111145246.dj4gogl4rlbem6qc@mobilestation>
 <YY0zUjjVobtg85o6@sirena.org.uk>
 <20211111160627.fcgrvj2k7x3lwtkp@mobilestation>
 <YY1D3tM4fg8h6mmj@sirena.org.uk>
 <20211116191542.vc42cxvflzn66ien@mobilestation>
 <BN0PR11MB5727E5AF778F8B504F009554859A9@BN0PR11MB5727.namprd11.prod.outlook.com>
In-Reply-To: <BN0PR11MB5727E5AF778F8B504F009554859A9@BN0PR11MB5727.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a483337-ef12-48e3-54c1-08d9ba3a4ea3
x-ms-traffictypediagnostic: BYAPR11MB3607:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3607EE7736D781E13152ED06856F9@BYAPR11MB3607.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuaA2E3M0Wm1PArzPohVFXA3ZTZLU7LlOxvXAB/AHWn4VQRUXzoUQClZ4mfO859q2bLrUDumeVRzPpdLEUlrAOfmEYjMhTv6Z3G/wmG7wTpx22AR+/DcJ1UHnmvvA9vYTonMlEKxHXf7Aq13BbWOqaYJBGIw5eK6ljI3Ndrc7jbvgvS7Udxwd2e6bDGRUp4Tmb/z5K/E3fOvTgQL1bDNuqI5S/JlEsDkMZn+JoJlhiQIU0au4RkXCUY48DWnDztj2UCVxyVCasAAMC+HndAk7q9GFnDeNPFXWAEZSjZYjmKeqrVHkiLOW7m0kAwuugUPbiOC8EABxWE3tzwBXzIzWC7BUZkVme8YbBuPCxbenyJn/msArA9Ei2XoHOfpBwZImlPh0R/QLX1sZbWbkqvpSSN6rQX17QmbYpqZg5rZKWtv01MM7vHBIW1LzDmJ/N3b4DqpAPlTQto3V77tU1SUzRNMEi9abbJfViOjfInNX/KlHc0/piLlYoqhYqW75rtZH0nLFQwYHATXanPlL3acXxTDXuI/8aJtE8mItj2tGL/Ra4wiNb6F8Cvhxd0Wzl7I0n0AGOTKvxTkRqNJySkl2BS87nyNV9d0FA3a8d2IKzGW/UXhHCGbOsWC6yHBscDBngnjR4iCFGddZzc1Dzr9bpxaHr3XoMELo26zGKTibhtu1I3E/ajz0oGp9P7jTKXjl0qz3VcKYfGuiwa3LIhtEzRvK0SVs7edguZ31b9QDGKeB5i0kIB/JH8lvLgzF/4ytgiCdbK2w/C3nLCwj05tysuceRceXMjqc3T8bW/tAw4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5816.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38100700002)(86362001)(4326008)(26005)(122000001)(33656002)(52536014)(9686003)(186003)(82960400001)(110136005)(966005)(66446008)(55016003)(54906003)(2906002)(71200400001)(316002)(76116006)(6506007)(38070700005)(64756008)(83380400001)(66556008)(66476007)(53546011)(508600001)(5660300002)(8936002)(8676002)(7696005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6uz9fzAhJ3nm+UxLO36btL9N5o9/CeLed/Y+TJa56AliSEXVogjkILK2U3z?=
 =?us-ascii?Q?YbwYSIz2g22WwEC0DlgqXlJNyge2P0BGhWNrYgIauQqejrSJwJaFxIzfC3Fu?=
 =?us-ascii?Q?6PJ2bM77tRTpzyHlyVpo8RWJ5XvJ1Rc3MXxjcgRUeOfDMZXIUi5u0nnH/DmH?=
 =?us-ascii?Q?jgBYX3IYkq6HKGvgHli8I11Xj47lu2PcYRo2Qx8I7Xi5jZPOZxaqxwZY0J3s?=
 =?us-ascii?Q?rA2fgxddVp5ruLLGLUptnnakHBV44YAiRbDjVM8X5Mvd5mNAMA2yI25GD5Nv?=
 =?us-ascii?Q?pCqfyiZNKyBpG4ChjIj1ohegtUoEh88Eg0fHZ2VDz3Luy7IGgPakiaYfHjHc?=
 =?us-ascii?Q?coBgmlgPvid2GOmHdz+spa15I2Zc2tBCb0oGCCd1VN6BfT421MAcKXA+ewSl?=
 =?us-ascii?Q?5pxzTpqTSx4y448UKDYb67Px42oJ18GV7b9ufZYMP6/vCr9zaJ5WBTEs8+PI?=
 =?us-ascii?Q?fN8Jauq2LUgQpJpdFAGJtBBsrT/2SzLMuwscTyJtZgoNQRep1nHNFEuwp39D?=
 =?us-ascii?Q?tiUotNBWwsr3GyPTWo8fm7V4i338ThfZq2K3w/gXHIPl5RW7P5WFck3n/hZW?=
 =?us-ascii?Q?qTLUU1dpJY4zVGHqqlZ8sAfk1G301PSnjb2HW0zbmWOkq0yF/NB9jX6DmAYH?=
 =?us-ascii?Q?fr79CNB4XjzvBWCQ7YaRXHpCHMbYdqkD+0WYtPsn9q8nN179IkYouzYKu1BO?=
 =?us-ascii?Q?EmIb60rmwQgoWG//T3ZB+VtLXQt//f8vHH5tmOCj3TYxNJGOZRFxAUfFzTmf?=
 =?us-ascii?Q?QDpb192ElgkYIHGMLus4AxOZ3VTkUi+7BKwJlYJIXyYY7trYmPTXS+cNGyGc?=
 =?us-ascii?Q?pzpril8V/em5n47yMr1N8+WqAKsq2LyGS8eYOmxCzLXdvc4l9UsuQod3vzeA?=
 =?us-ascii?Q?Hh0fBRM4f8KVhchDBFZ+6KfX0WWV3+8DxS4BPTW+jPOD00DokbWQxKsOISaW?=
 =?us-ascii?Q?8Q2h8V7ey+ZIJnkuO9UIxzqIKLu+YG7DW0WBFoOko5BXER7bOKNov7DfBboU?=
 =?us-ascii?Q?7VO5Cn4Itpa+TuL176e9vbfupeiCAELl0kwx9trcNCZZC0k9z8v0CVgwuO5N?=
 =?us-ascii?Q?O+wMQqfk9/Q+aOK/0DxeBAap41QTH7JJBbp7ZBtuWItBW+iphLBkcnNejz/4?=
 =?us-ascii?Q?NTtiGUcaO1KO26TjW5hyGXTDp0FfroeZ7OY7oBl32Z8GCtLHMV5RsLNRU6bq?=
 =?us-ascii?Q?4IXzkmr3WwNNfDcSGdyWog7UnBBimAgxJdBueAh52ExjY12NLeFyAd7CMQb5?=
 =?us-ascii?Q?E0LioKPy3gyK8bQbfJ61/A8fFGzek85RSMXTOaAklfCUiNcAOk1DRLgpSNKA?=
 =?us-ascii?Q?x0scOujguZnILrzmMTZDooolcH85GVF7SsFeO7NdIH8LRArCTW2QMeY6V7JG?=
 =?us-ascii?Q?NasJsEm4LkWw0sjVjYk8Ggl0wUL1kXUqP6V45Q/4WU0u7WgPjXcsxASyOfZ1?=
 =?us-ascii?Q?E2oQlzxrrwEfCWIFoJDQMorZd2GB6G+7tK92/2aeSkFXs5xkNMRRR6B5U+qc?=
 =?us-ascii?Q?O6y+tSz1/jZTbBsIh3cUQzTH+9R5LZ5jkqLHWKFZHenAwGdFizzcR+QD/Bj7?=
 =?us-ascii?Q?2+kxZVuc3/MEWFUmws7HZIg4E0rBqtEItZBHhiTge9+yocCngZxMFdouOGd7?=
 =?us-ascii?Q?zeNt3mZmmJTkAevxql70OaIKhg3fiTUTWw2X8HUIQN5MJzk6fb4jSdjOy2JD?=
 =?us-ascii?Q?eUnqgQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5816.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a483337-ef12-48e3-54c1-08d9ba3a4ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 11:03:03.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLA6n6xJ1dP6dHPshGl4Z4GzksTFO3uEpw1q2uVniiLoEJ/e/Lvd3HCw6GopHyko3cAHbvGJxdoiMwBD3pEBz/cEpeBqPNMF8lPGZxyzKHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3607
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Srikandan, Nandhini
> Sent: Wednesday, November 17, 2021 5:29 PM
> To: Serge Semin <fancer.lancer@gmail.com>; Mark Brown
> <broonie@kernel.org>
> Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>; robh+dt@kernel.org;
> linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mgross@linux.intel.com; Pan, Kris
> <kris.pan@intel.com>; Demakkanavar, Kenchappa
> <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> <mahesh.r.vaidya@intel.com>; A, Rashmi <Rashmi.A@intel.com>
> Subject: RE: [PATCH v3 3/5] spi: dw: Add support for master mode selectio=
n
> for DWC SSI controller
>=20
>=20
>=20
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Wednesday, November 17, 2021 12:46 AM
> > To: Mark Brown <broonie@kernel.org>; Srikandan, Nandhini
> > <nandhini.srikandan@intel.com>
> > Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>;
> > robh+dt@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> > Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > Subject: Re: [PATCH v3 3/5] spi: dw: Add support for master mode
> > selection for DWC SSI controller
> >
> > On Thu, Nov 11, 2021 at 04:25:02PM +0000, Mark Brown wrote:
> > > On Thu, Nov 11, 2021 at 07:06:27PM +0300, Serge Semin wrote:
> > > > On Thu, Nov 11, 2021 at 03:14:26PM +0000, Mark Brown wrote:
> > >
> > > > > Given that people seem to frequently customise these IPs when
> > > > > integrating them I wouldn't trust people not to have added some
> > > > > other control into that reserved bit doing some magic stuff
> > > > > that's useful in their system.
> > >
> > > > In that case the corresponding platform code would have needed to
> > > > have that peculiarity properly handled and not to use a generic
> > > > compatibles like "snps,dwc-ssi-1.01a" or "snps,dw-apb-ssi", which
> > > > are supposed to be utilized for the default IP-core configs only.
> > > > For the sake of the code simplification I'd stick to setting that
> > > > flag for each generic DWC SSI-compatible device. That will be also
> > > > helpful for DWC SSIs which for some reason have the slave-mode
> > enabled by default.
> > >
> >
> > > That's easier right up until the point where it explodes - I'd
> > > prefer to be more conservative here.  Fixing things up after the
> > > fact gets painful when people end up only finding the bug in
> > > released kernels, especially if it's distro end users or similar rath=
er than
> developers.
> >
> > Since IP-core and components versions is now supported that will easy
> > to implement. Thanks for merging the corresponding series in BTW.
> >
> > >
> > > > Alternatively the driver could read the IP-core version from the
> > > > DW_SPI_VERSION register, parse it (since it's in ASCII) and then
> > > > use it in the conditional Master mode activation here. But that
> > > > could have been a better solution in case if the older IP-cores
> > > > would have used that bit for something special, while Nandhini
> > > > claims it was
> > reserved.
> > > > So in this case I would stick with a simpler approach until we get
> > > > to face any problem in this matter, especially seeing we already
> > > > pocking the reserved bits of the CTRL0 register in this driver in
> > > > the
> > > > spi_hw_init() method when it comes to the DFS field width detection=
.
> > >
> > > If the device has a version register checking that seems ideal - the
> > > infrastructure will most likely be useful in future anyway.  A bit
> > > of a shame that it's an ASCII string though.
> >
> > That's what the patchset has been implemented for in the first place
> > https://lore.kernel.org/linux-spi/20211115181917.7521-1-
> > Sergey.Semin@baikalelectronics.ru/
> >
> > Nandhini, Mark has just merged in the series that adds the IP-core
> > versions infrastructure support to the DW SSI driver.  So now you can
> > easily convert this patch to be using that new interface like this:
> > -               if (dws->caps & DW_SPI_CAP_KEEMBAY_MST)
> > -                       cr0 |=3D DWC_SSI_CTRLR0_KEEMBAY_MST;
> > +               /* CTRLR0[31] MST */
> > +		if (dw_spi_ver_is_ge(dws, HSSI, 102A))
> > +       	        cr0 |=3D DWC_HSSI_CTRLR0_MST;
> >
> > Please don't forget to convert the DWC_SSI_CTRLR0_KEEMBAY_MST name
> to
> > something like DWC_HSSI_CTRLR0_MST and place it at the top of the DWC
> > HSSI CTRLR0 register macros list.
> >
> > -Sergey
> Sure, I will test this patch set on our hardware and then use the IP-core
> version infrastructure support and make the changes as mentioned for MST
> bit.
>=20
> - Nandhini
I have tested the patches on our hardware and it is working fine. When woul=
d these patches be available in mainline? So that I can start applying the =
changes on top of these patches and share for review.
- Nandhini=20

