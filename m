Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D681589507
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiHCXwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240520AbiHCXwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:52:05 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD885E328;
        Wed,  3 Aug 2022 16:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659570724; x=1691106724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6w6uyJGZmcWyYDKn9e2+081kc5HVG8rSUB24TtrPnGk=;
  b=MKtzlDBnIGShsO7sz8pEYDHZnsvX6sjYfv3V3kkIHd+xv7IvW73q7bWk
   gHBH6aJTZtlWvpoQ4wabPfR7Q0wO9i7tZxYElCG8xuK8kta2qjqUKaguh
   v8MPDmUp5WIl5xELkCqBnt9hz8xkLm53bsnzv03GP1ohnFFjt+IcLc2ON
   gjeQGLBgciDqBGeIYoB4RfYHkqMH5+lhltj0a5+OoFrpW32nTZWsvT0KH
   tIiiHUMxSXm42JsoqjNl9ptMz4MvBkGPcUQyCcCMl/rWbebXtNJt10Z2p
   4VELUdtWjV8jtyxq3Q5ffpvTxSE0Bz7Sgnc4XOf07d8kSNhvYdDt74k2m
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="353800140"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="353800140"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 16:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="662296186"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 03 Aug 2022 16:52:03 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 16:52:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 16:52:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 16:51:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiEQRX3d14s0Wm6Cbg72RiYNqNO43/UZdLkpYWD52guYt61wZnO+KyOQ1Bq5W+tIlyRapUt5kjbJoNhkRQhX9PDx5wpWbNDjPv4YDThjxvpB+MXUjL3SkT1ObcXzIALrej1GNNYgoilnvDG0Q+syKqtsRneiCs//ELPZlR1XUFfUHgq/JD0l/PPpFogcC9zHhWiEtYgruK1jqHk0y5ArYP9QAi1YM8TOhX1mBa9wZTCW4GK3U+Y3FARn7DHB6WvzDcUbU6PmsqXPpKiE9l+bvlyhYWn1PH6fUAFmbTJiAQAR/zRPPu4lU8O/y7qeEX2pQDjUwWVx8gwD40l/+bxfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reRloh19s6Asm7uesznEkADjwnWaW1cghdSvrGAbvfg=;
 b=C5yWooyfdnBqYJCDsHM/KqXyDzYC3v1qHXAhK/LBtO5cR9rLtoZzdNwaPpUnR+utBxB90dPnLu/vypyqKT+i/zis0LdYrcpWKmPT3ZY8Z9C4sHtt+t6N8Ovs/lpzW7brtt7YVUzR8k/VF3bDdkA+LgXDOVXxxmeB2K/1Ttxlpzs5Q0lQDIDkmBMkErF1HteEgkFx5r17KZMg9P6JQBvcFeR7zRO7bpLDoouZ8jZRRoDlZU/hrQg7fuAh2p66aRokOZ88j1odX6TLyjnWksazOLUa8p8C9DI/Yqd9/gpuq0cnVDQ5QFsVwVUMmfUkj9DMo2XEq4jzkBTPDwlVw2Qk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by IA1PR11MB6217.namprd11.prod.outlook.com (2603:10b6:208:3eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Wed, 3 Aug
 2022 23:51:57 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::58c7:c869:bd32:963]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::58c7:c869:bd32:963%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 23:51:57 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH] usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor
 Lake IOM device
Thread-Topic: [PATCH] usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor
 Lake IOM device
Thread-Index: AQHYouJz7thRnPvu+UeuQ1FvnIN3Dq2bVpcAgAKK6cA=
Date:   Wed, 3 Aug 2022 23:51:56 +0000
Message-ID: <MWHPR11MB00484EFF0A94ABEFC0885F3EA99C9@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
 <YujndMdpS+4L0AiL@kuha.fi.intel.com>
In-Reply-To: <YujndMdpS+4L0AiL@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14083289-0b6b-4993-6f7a-08da75ab265c
x-ms-traffictypediagnostic: IA1PR11MB6217:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7jQ5sf+Xv36sPYt1mwWh3CXmeyZeke26jqDj0Xq0XuBnytpthhxAoTDZd1WvBQZ91X8MkdGsSddBrc59OLRYCbN5ZxXarFzEZZsYv7d56YZvyKAdnF+qYN2TgP8CwgqogarT3GwRcp4i2nR+UWlgz2LhbmTyrKe1EuHkCjYtsJV63c9TdVYM1I2xsp/fifoZwWHwhA675dK5KlCXQHZ2WwhbzofRh5J8jX8TnYrvIweoUcjQiX8Hjv9AJHNwDmGf7WMtoSfjZvqIjzDAj3iYv4R8XatNAy7ONMZ1N1n46OZWkbCmf1XY9s4o+fE8X/pR5pDNi6J8VM7m2lfqzRCdRk3e/+qrYJdSFqHbugzgZrxiBA2k5VO7XDphiPnS0AYpmkrM+5l7dRbZqnOouBA9RyJKJbA1OSZQdhs6is7Xno6STYPV2ffD9s+XmSxDXE6IFUOYRRL3IWIm2RL2ip/K24lVrNmr2IlBKGowJImm0TGNEcXIoqF5CLTbU4bdjeykAWpQ5qia2dyvHzNLpxJri6DeETB9zDmUo+ArMZ5w/WkCIS+1iNj8wM2TSbBIG6lzTF0oGN+uDfd3dwgcpKe4vgNVhdQ5XOIt+jtznPbrGf8Y48v6jgO3D4Fy32YiU1/NUywklXe91lcm0k7JeGMxqPxRYqtyggY2ky+VaAMb3E7dfPtg6Z+o/CkccFL/MGng1rPIMeQAJi0tRQHjGfuye/bNJfamKURzMZAm3J8dout2UpCGG+hTf8e0xD1H4JfxtTFFczPnzQvVgyJYfPvg6BMUPCuOCAVJ7dG9mJ5cpUr8UuTIvtCXkhRTJt2PN2K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(396003)(39860400002)(136003)(346002)(7696005)(8936002)(86362001)(6506007)(52536014)(5660300002)(9686003)(26005)(33656002)(54906003)(6916009)(122000001)(38100700002)(41300700001)(2906002)(316002)(71200400001)(38070700005)(55016003)(82960400001)(478600001)(8676002)(66446008)(76116006)(4326008)(66476007)(66556008)(64756008)(83380400001)(66946007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIrTol1IwjyVUXAKYFly5xtKNTxtXzcYSEQNN80GOW2wHaxxD67j1cQ/SL1p?=
 =?us-ascii?Q?5f2vKReMgqCupaD9URHLlh/GV83lPmv7bBesPq7geXrH59oZoHE+zbq0hx/j?=
 =?us-ascii?Q?nT7JRukmadrXrSqL14Qck+Il7y62Pe7LsBBS5jWsdlR0r/4s9E1I0jbNKCMZ?=
 =?us-ascii?Q?NQ3xxDz0e8b9Z/TIWf6lEytpQx1RDmPObh0P3nLIFww2RpHE9yUNH30u8Uo5?=
 =?us-ascii?Q?uFYfHfbQq3ZuDWKoxr6UJmz2cAGPbbmzYDMDjFcgD8pxX5OICxpiliS+VNrU?=
 =?us-ascii?Q?3Oh/Beq9aqSEdWgdrsHOBUa73TvtfpX/vQCroiY2RF7bbWOTBlVcKMPUI4Wa?=
 =?us-ascii?Q?QkeqwRpbQxiLlyYYR/cBSgJKlrRKYao8vjTNC0VFLVndMJ5cY1Q1EcXup223?=
 =?us-ascii?Q?TKEvXxPUb6mgTzJ8ffXbKdM/TT3rUryn60bIsHY0QzJ96fo7DQ8AfmHRusbv?=
 =?us-ascii?Q?9WeuVNa2GcrDSMkQ8Y3DOXVp1Tct6WYWmQkohzFr3b2WTVtK33aI/e/uPFs1?=
 =?us-ascii?Q?lBCgGyegLIJrcqM/0MfoxjpzBvdWmypvUEzYU41z+KZ2MO8sbknU734r34Nx?=
 =?us-ascii?Q?FON8GrZCjaheLzDRKhPgPgzticFveBaFhQuKzUHFmOTUyNEPtfT37PZ8Otr/?=
 =?us-ascii?Q?qHCk/iGFS4wCZxu6wmM0lrGvpXDAGL9YJNvh4BaGcowWTVVwfxnFmwwaWWVc?=
 =?us-ascii?Q?uvSSpXSkDxGA5KvHvVcktq7qtNtQB90nGL6bgq2AyjmxeJvW0+wHBwMolStd?=
 =?us-ascii?Q?mv/rHcyR5aCR2+ItlzieUcC25h3edczOLDMnlcxmqmKBkcba1GRXfODXEQYm?=
 =?us-ascii?Q?h2rSd4MIdYbv0aEeOHeKIOl0FMPf2M6PZPTv4cyjopYnJkJU5bgm1yknJkoP?=
 =?us-ascii?Q?MoHYRwKfkjcNtS7OLhXptiRtEFhJt1AzWCI21bWu402TauyVKR2mu6lfkN5O?=
 =?us-ascii?Q?S4ASkLeFdko8o3bgHvYxeKTdx8nlq3S/B+ndqp/RSpkIXkfsE7dcuorvDEt3?=
 =?us-ascii?Q?zlCw7YyhDtYztDdPHc3nhkEdoODFzZjDBhX0slJNSFAJEyab6Cws9h1w7bhu?=
 =?us-ascii?Q?1bQlclL2tNMtrYnV3iZRrN7Vgmtlh/Udl44Ll5/Hi0l9R06gGXf1GE2/QZcF?=
 =?us-ascii?Q?LlfUr7hAuZ6PS4OAHHKfm39Bq/5ns3AtmCKvVTvLULKRRgQzoNb6qxPALrla?=
 =?us-ascii?Q?JNZqEmxzZSsNkzvj0rftvIYRTHmrelQIioAvBQR9oQHYQdUi/L3tbVbEnhtt?=
 =?us-ascii?Q?jsGmsDwoCHCeAQQFw7Aw3nkmX+n/dKmJwh9KSBHMmPdQklRsPJ7HUYDXrSqg?=
 =?us-ascii?Q?OgRArUyz8KT6d6dh/nQ2jXcH+5SmlAsnXhpr65m9OYo2SMA9j33jFrsQ7jl9?=
 =?us-ascii?Q?H0WNew7+wmLf4yryVrok7pwpQjOiKOfEElvLYQYbzYpZ42jbE37yL36EvwHf?=
 =?us-ascii?Q?SJvWZyKaWnfW7V+ivSqatCYdF4ElMi2fPSrc7VB0sOw5/WNb5cHdjFyws2JC?=
 =?us-ascii?Q?KvhIWLZobT1IrxDXL6U0PFutdE5M9jaazr7phWIW0o2DiMxoKaleV8xakJRV?=
 =?us-ascii?Q?FImy9o7N5U/97qyCSekKPXsSLFfpBC6J25PMhgD/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14083289-0b6b-4993-6f7a-08da75ab265c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 23:51:56.9483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8VnsIKVvDw9ex9gYy4mibK/tk+PoarM/3WOhsCY9Mt8vkWrUABKmhifngyO6RrGx15GRrqphDzMy3ipekRAuq+1+mtrp8CAX2gDv9ndlMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6217
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

Thank you for the review and feedback.=20

> >  drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c
> > b/drivers/usb/typec/mux/intel_pmc_mux.c
> > index 47b733f78fb0..a8e273fe204a 100644
> > --- a/drivers/usb/typec/mux/intel_pmc_mux.c
> > +++ b/drivers/usb/typec/mux/intel_pmc_mux.c
> > @@ -571,9 +571,11 @@ static int pmc_usb_register_port(struct pmc_usb
> > *pmc, int index,
> >
> >  static int is_memory(struct acpi_resource *res, void *data)  {
> > -	struct resource r;
> > +	struct resource_win win =3D {};
> > +	struct resource *r =3D &win.res;
> >
> > -	return !acpi_dev_resource_memory(res, &r);
> > +	return !(acpi_dev_resource_memory(res, r) ||
> > +		 acpi_dev_resource_address_space(res, &win));
> >  }
>=20
> I realised that now that is_memory() function is basically just a copy of=
 the
> is_memory() function that's in drivers/acpi/resources.c, so I think we ne=
ed to
> handle this a bit differently. There are a few places in kernel that have=
 that
> same check.
>=20
> One way would be to just export the is_memory() function that's in
> drivers/acpi/resources.c, but since we have already a wrapper function
> acpi_dev_get_dma_resources() for DMA resouces, I think we could have a
> similar wrapper for common memory resources.
>=20
> I'll prepare a patch(s) where I'll propose a new wrapper function
> acpi_dev_get_memory_resources() that will take care of the is_memory()
> check, and then convert the users (including this driver). After that, th=
is patch
> only needs to add the ID.

I will wait for your changes then.=20

Sincerely,
Utkarsh Patel.=20

