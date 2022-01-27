Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E5349DCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiA0IvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:51:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:41895 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231296AbiA0IvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643273479; x=1674809479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4+76dEfIWV1hibJgDeT8TFjm9WhGnBagD42oAGb/MA=;
  b=ZlG8OzjciOjofatE6o2E34RJssAnkWaoKKPMqpTQSG6+K1h0YPrOK9Ef
   2VwG7XfnGPcIGE/NYutN7igRkY42QIuvHNpxv4JI3LpQlhlrptVG2O0SR
   +aQlmNnOm2d73ocgU5hQ8wEMvJeFFBKIOMtZt+p+uUWe2fXAA29OgPkB1
   vXsdyN9mX5p9AokyjNEo1oXFgMNbA/QRoHs6bYUpmlZVjiTJG0DRx0Vww
   +JgasLTIscfeiSHhj7CW9p7xY0vwOuenm1Ae/AEehhVhL2pGtEi9c9mUH
   9OFfGPL1Bh4RF8XJqmdYHRlcAs+sUyA+SOByAnpR30FGGgoi0oHKF/A9L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="247012074"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="247012074"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 00:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="674647434"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 00:51:18 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 00:51:18 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 00:51:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 27 Jan 2022 00:51:17 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 27 Jan 2022 00:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiM4heZ90+eI72r3NZhxfnzR8QV4FBK7/6bUR+5ycs/Qsw4Ae51iVefKeVVrImzuZKdINQtjKfrLXt/wmpihihxpEJNqlFci0shofU9faLyWPro5hV1u6UEXsnoEGqfm5iOzliA7HLjXnvNRYw8VQnSubVpVdBdFb8KWalfRRwBPtzF3gFRyQtmtEq95X1uFO57qA/kHiY1RUPDI/ScUT/CeEZJwPHm5kULayBMItUIyaspwvcgDT/P8jmdGPtSdGIRcGVCtSXPy+xCY+RYpYRZCPfIMaghc5Faf50LEvW7G0fGS3Bq1obGF9I7nEygfmQdh0zKSrcBTvHVO3/v8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSo61H+Vn8ry1+dK0sOQ5xRG+N4GbxvQVKWUNV3bL/s=;
 b=aSFocdhlbncB8ihQZpnp19Ze4UE89rFSpPx8C9X49DGYAPIB3mgjGtBZ7L0NQkZmh4wR7p/baJ0uyQHCYwE1j3h+wuFlOvUbVvEZ7zlMg71QxxH/uwzZ8sH6l5i8oci0U9A1xcBUWYAEfSjT1Z78nELWtExb+SCBvaoFDJfnFWbkK5TLv3rNLIKHFhu+gkr7meOhB+MVPWFielyq1ahwvGnmhFBA03C89DgCwsBtuIXqcf3LvX2SYqNk4CLOskIP9OLnnXhinSyi+6aLy0cvRrKZ59hm/oJS3y4qBxwBShFwoMcMcRi45K2PDLzlVVuejOeBwverxaRjwyfQDK7yEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by CY4PR11MB1557.namprd11.prod.outlook.com (2603:10b6:910:d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 08:51:12 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b802:fe0a:fe78:a558]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::b802:fe0a:fe78:a558%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 08:51:12 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] mei: add support for graphics system controller
 (gsc) devices
Thread-Topic: [PATCH v2 2/5] mei: add support for graphics system controller
 (gsc) devices
Thread-Index: AQHYDU1z5D1fqQ6syEOKQBwBwMGJ9ax1pAMAgAD1t5A=
Date:   Thu, 27 Jan 2022 08:51:12 +0000
Message-ID: <MW3PR11MB4651EAD45375963B6A43CF8AED219@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
 <20220119155807.222657-3-alexander.usyskin@intel.com>
 <YfGNbK6n3Ag/ORFJ@kroah.com>
In-Reply-To: <YfGNbK6n3Ag/ORFJ@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0b964b3-b30d-433f-9dbd-08d9e1722bb3
x-ms-traffictypediagnostic: CY4PR11MB1557:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB15574ACE6A9A4A340BAA2BC3ED219@CY4PR11MB1557.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RiNYItU5nrlwpb49krucBRlS470AUgETIpnS+1wnIhDaom20vdx+9GmYKC4M4wmyDy46+FUlp7aOOc1i/CU1URDwl7qJR+owHB6B8TOkK7kwOZeJ3KqXpJFi0TutoMYozALGaHF28AcsaAzK0PfjAqMYR4AvsOgeoW7MibeacH0wYTYog+LEaJO9m+yH7GYMI/vvHE9R07fmrLogH0uYd7V+qD+M7sMjcXdiDs0vFpUT+eG9hkH3SnP0rMgvRt9Y4y7fQ+FEnkXmfo6NQPJinJd/x3vuQThZoULG0UlIKtHGcoyLFE67GETJg/l4g2Xd2jwevMBPuZ1VdLIUsZJW6B5hLpFR69Hs/D5Q84ieygHPrcJpLdXIJPVgjqqjKnWM/r4tB9berWcwcpzM1CEd2IjDXfXSJKFFQ27zQDUqHjGtCOuqvxaMjQHKtB0XQpL6ws5HPXRbHhonEe46UyS8eOhbjyXpWbUipdNVb/J1n9nITUwwt6cFCP7YB21hx6vnv80dt/uuNSNV6d6LE5bZIKmjLCEeDIeuwfbPk0YJPJxad5A4zfJoSrBh17QTECJ/fKGtES7s/61xIGRQLo9PhZsokidtxQTFXTlF5vh3wP3eSoKWdxqKpYsCryYaP5mJLXtxHJ6zTEcW41HR7jAt28Cq3/ZTXpuNbFmRVwRIz74xpnBZz0MBcKtOo9MrrrjrFZaGrAdAW7qOGD8sKnTi/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(54906003)(508600001)(8936002)(33656002)(64756008)(66446008)(66946007)(2906002)(66476007)(66556008)(26005)(186003)(52536014)(4326008)(38100700002)(55016003)(6506007)(53546011)(6916009)(71200400001)(82960400001)(5660300002)(86362001)(9686003)(8676002)(83380400001)(76116006)(7696005)(122000001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agAPxOWp9mgziRAf0G/6kb+9cpBW8c7HQFb5XaPVb6vdLBeBzMzgwDIgQXaJ?=
 =?us-ascii?Q?gKWnPxvuevaoBQR+Lh5v4LrM/gxeK7wZVbnWoCnp6y1372hYZjgdumUs2GZm?=
 =?us-ascii?Q?7Gl2mWNNTr7gL81Q4MXGdd9/kkIuTxuP+fAumT1QlWCGYTZ5kVCkUSBJEAmV?=
 =?us-ascii?Q?p3GyHwOMmS3AQyH/0DDLPpoVxvjKcJQhHgLWqWJr/oMIrvUG4trbYEWcaOwr?=
 =?us-ascii?Q?/StKOZ1/O3u3hDSGW39EUPOmDP9TQNVEHPxZO9XECEIFO1zbtbkKMXKjUs4a?=
 =?us-ascii?Q?HTsrSOriE852JOxaeP/0tUQTVlG6+kQSpxaNpejMOecsRUkH+8v9Yz/GDf0F?=
 =?us-ascii?Q?4VxlDpB3JUXS88tp98Ha+t3O5X7L/HsFJCXK+nSBlF/yZvu7iQSXdHGe6l4J?=
 =?us-ascii?Q?m6Dszm7hkxf6sNGlVtsjz55C5z6Y6pDKUjmfe9d5uYhQKF/5HaPLPZUENbJ0?=
 =?us-ascii?Q?qxxdm9NnyrSeav53i0cKXH+VVGA9+5UHngRTxABcYrVRY53hEwXecBS6q2hp?=
 =?us-ascii?Q?RHu2iFXfup5gZz4pEY+k/d/ePZC57h2T7uvt95Qm5cQCOJS+PIN8UmSchUBf?=
 =?us-ascii?Q?hUF4Nhv0rRfvqrVPkW8NAoE7Df5xF+t28N1e4eNzFqP2RX3eqW80teQhPgUs?=
 =?us-ascii?Q?oox8SOGSReGF4Hg8rgsV5huAdb6sZZEGIwCU3IyDYAIteAtIkJxKu9t6bUo0?=
 =?us-ascii?Q?KMrBQbOFjpIKyXGJkI0T3iZ8duHhiruTCdKogL46YZEGOSl0Z8o3PjKmfhj6?=
 =?us-ascii?Q?Vq4X1rsL5qt+4D6GQj5cH/wDSqAw1Vp0bGrv44vVpUERrkDhmFhxB8hO70FF?=
 =?us-ascii?Q?F9DdmdaEgcZH2eIvMN5XIMyLg6y243iF9y62S7jKJ/Y1/swIP1n8euUEz/9g?=
 =?us-ascii?Q?V4rxKQOVSiSURGn+H89HFy3eegAukznsaPLkRX2HvKNJXmyIzIW6VoM/1u5+?=
 =?us-ascii?Q?tpOnKhw9V0F5dNvQp12TdJ1Ssm7/TGYKEspxRi9+aeWBO17+1sMZsQiDxgu3?=
 =?us-ascii?Q?RU3Schstct8AUg2E2avbvCxBGZ6Gk17jnspB3R0CjgslG0RjTUj2N98ZlzIs?=
 =?us-ascii?Q?qbCQW8go/QkFccJuj/Zge6eLtTGmscL79ueC9+VqSOip37bRl7YHqBDK13sK?=
 =?us-ascii?Q?qIIZmvvbSufZai+latGAOE984mDGBs/Bo6ql7uZIz4W5KHVY8yOyII5MfgdI?=
 =?us-ascii?Q?zdU3akuBbqUqm0dh3LJDsh28IShPWblIoNk3cG+riCF5pfAeqEQzM6vrGb0u?=
 =?us-ascii?Q?cXy1akkWkTGgCLjCXqeVnbLrBsQZFMz1JtGH453hN22nLet2esSihtQo6R2j?=
 =?us-ascii?Q?ISVWQDArEObzjn+Er+XE1ljUeeo6Srweiej2bINZ8kKjVqHqdU2LhBqiY20D?=
 =?us-ascii?Q?HaFoKT7+ojCH8Y9y8gGH7p7EH1TOo+/Iw8zJhKB+spVPxCIdCBu/tUBRZD2j?=
 =?us-ascii?Q?PyxmEH0E8rTw16o9FNTeyl4EKBtaP9gAWGd2T3bpXyHfGlbVEEGho+qEq+xn?=
 =?us-ascii?Q?9Pey6wqVAsh0EBWy1HqlEq4+E6RdmQir7+pjiU2hairBo87qPLU3ABNTJPbx?=
 =?us-ascii?Q?h79h/UeEZ5jDgEQprTr9jg9sxoB5mz4EM6Kdii0ZZBSOYt0BRoQmu7gjY9E/?=
 =?us-ascii?Q?VJjo1FkdRj/m3A8IcFcIkCHn5SbWAO4voTMPQqcjud4num/MzOoB596PBxe8?=
 =?us-ascii?Q?I+dAdA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b964b3-b30d-433f-9dbd-08d9e1722bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 08:51:12.3942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iomjzKEXiFhaXclIEJtBFJi2VL2w49PZgEd3aY1d2HLOlxgBWc40EFMD2vVD+qG1o9y9MlY2wLZICOgAD5ZCfGNht0vkiPnL0P7xXKgXQS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1557
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, January 26, 2022 20:06
> To: Usyskin, Alexander <alexander.usyskin@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>; Joonas Lahtinen
> <joonas.lahtinen@linux.intel.com>; Vivi, Rodrigo <rodrigo.vivi@intel.com>=
;
> David Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; Winkler=
,
> Tomas <tomas.winkler@intel.com>; Lubart, Vitaly <vitaly.lubart@intel.com>=
;
> intel-gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/5] mei: add support for graphics system controll=
er
> (gsc) devices
>=20
> On Wed, Jan 19, 2022 at 05:58:04PM +0200, Alexander Usyskin wrote:
> > From: Tomas Winkler <tomas.winkler@intel.com>
> >
> > GSC is a graphics system controller, based on CSE, it provides
> > a chassis controller for graphics discrete cards, as well as it
> > supports media protection on selected devices.
> >
> > mei_gsc binds to a auxiliary devices exposed by Intel discrete
> > driver i915.
> >
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > ---
> >  drivers/misc/mei/Kconfig  |  14 +++
> >  drivers/misc/mei/Makefile |   3 +
> >  drivers/misc/mei/gsc-me.c | 192
> ++++++++++++++++++++++++++++++++++++++
> >  drivers/misc/mei/hw-me.c  |  27 +++++-
> >  drivers/misc/mei/hw-me.h  |   2 +
> >  5 files changed, 236 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/misc/mei/gsc-me.c
> >
> > diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> > index 0e0bcd0da852..ec119bb98251 100644
> > --- a/drivers/misc/mei/Kconfig
> > +++ b/drivers/misc/mei/Kconfig
> > @@ -46,6 +46,20 @@ config INTEL_MEI_TXE
> >  	  Supported SoCs:
> >  	  Intel Bay Trail
> >
> > +config INTEL_MEI_GSC
> > +	tristate "Intel MEI GSC embedded device"
> > +	select INTEL_MEI
> > +	select INTEL_MEI_ME
>=20
> Please don't select, why not just depend on?

These are hard dependencies. If user wants to have INTEL_GSC,
user should enable INTEL_MEI and INTEL_MEI_ME anyway.

INTEL_MEI_ME selects INTEL_MEI in this file and it was taken as example.

What is wrong with select? Why to avoid it use?

--=20
Thanks,
Sasha


>=20
> thanks,
>=20
> greg k-h
