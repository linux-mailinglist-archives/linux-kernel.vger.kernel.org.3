Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40C52BF61
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiERQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbiERQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:00:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD1E29
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652889629; x=1684425629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L6L5nlTi2ZPliasF1kktZv2aSdBcjFXRQ+NkmdIWqgQ=;
  b=Fxol+I+G6o68wNsceq+Uih6aoSpDs4cwhBIdCzJ/bhpjIbh1XmPR92Q8
   cfjO7r1RwcaSLN3loDpEjItyt+Vgqr9mh3dCmvaMF+ArDnCYK+sgu/qao
   rwYpoedv4WyTcZ+VlLHle1tbHvG039CNtYxswlTVKsALDTfs3ySPd7y3H
   cAwfqwWCKe6GoOUb/HE/K8pCCEgplO6KBZ4PeF6QEP8ltgu0c9V0MfQI1
   WwQNFO6HyJVDeDwIlIp1c0DVWWpV9pkkvx1esYwYDRud4HQLbNIkUBcKg
   wenAWpxqnPDneA2IWdhFTV9aNYwsjdpUsgQyIS+Kds6d1BRS3CRndTnuN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="270567956"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="270567956"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 09:00:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="545534036"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 18 May 2022 09:00:14 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 18 May 2022 09:00:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 18 May 2022 09:00:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 18 May 2022 09:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LISkjYsSji3A2+4V31NaAptCkhKsrPw9v3QhRQEySb0vXf7Bhc//AZkGf2XCsqQ9kVl1siRXW3hGm2sa+PDpWVvAmdX0PLGcM0RPars+MI8BQuX+ofCKJV86EuiABbPWRHxs0rF/oSOHr6lCXnE4v/L5+FtNq6gWziKhEGl18xK7KwwSvGdfjFw06nJrtghd+a/GUEkaKt5sRKhG5/if2HKgA99JuZKFSiPPwnQ+XZoXMpwIR+RhUBLHq/eQ5VMqQKigHNVNE5Opfw1DSj1JVFu1oVDc+umenlpAyJxIRsyuVNUIAWtQNvWEjxZLll9bdZ3HMm4FMWL5MqE+Tr5bCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tzANwXwbJCCqy7Ch9wRRHwiYWeWy1M95Eg0z0n3ZfJI=;
 b=W/ReMPTyzrA1d6AUho06jAmNqA9EXDoAXf2XYsN3VDR8FZ0FH0Utdsv62LTH5kEOxc4lpO5aW9BaAdsDK9NPyZwhKwfoPrKfpVHJKycabnq2d4+thcKiOu927ta82pdftcJAsMlKyBbPLCGzimCr1g+ho2o7UV3KBaIkiJP8ZfHwySSlCczRFMEaHzciTdOC7X3MDg0E+fLx+FyEMK+ZV/hjlqeg1VSd1Jm2gFUAtmMwOZiUgmUc8JCNPFqNxwcmQBrKoSiHJxiY+FoWms9mK26qIkz4AB2witCR6a8XOlLAVNykF+UFVDlXoc2/0B1KTXxZIYG0KIAnJfzzS1PaIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by DM6PR11MB3164.namprd11.prod.outlook.com (2603:10b6:5:58::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 16:00:12 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1c25:1258:e9d4:accd]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::1c25:1258:e9d4:accd%9]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 16:00:12 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Tvrtko Ursulin" <tvrtko.ursulin@linux.intel.com>
CC:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 00/14] GSC support for XeHP SDV and DG2 platforms 
Thread-Topic: [PATCH v2 00/14] GSC support for XeHP SDV and DG2 platforms 
Thread-Index: AQHYWHkD2l5ZK/qrLkmPjlxnBlRrG60krfnA
Date:   Wed, 18 May 2022 16:00:12 +0000
Message-ID: <CY5PR11MB6366B24DF2CE9A5871DDC1CBEDD19@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20220425074901.3991274-1-alexander.usyskin@intel.com>
In-Reply-To: <20220425074901.3991274-1-alexander.usyskin@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.15
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21070d06-9b5b-4ad6-2d86-08da38e77dc2
x-ms-traffictypediagnostic: DM6PR11MB3164:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB3164FE36D55AF9B1F85C7920EDD19@DM6PR11MB3164.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1I0zWBtZ6hsSMb7GKdO0+mALa+Kgd36oia9aZ19/MKcfiesZ9a1Y3eP3FrP+gCcwkyWIWVdv6Gy01J24LzXATtGbJrRBaEtBHGN7S/7guJVpVjm3zEVAq4qN7YEQ6hazN3sFMrwDc+5gwo39UXd+D98MjjOqLK2KxithCwHgdVS45q5rVSsVyAhw/3YCjSSriSU49XuAfn01Y5jLgxCO6z9UVfTFSvFH4/eblyXlrXg3a5wy+wEk0Izh4BxxhLROBC2EiqEJ6Tmj639/vZS9h5KieidHmpwnGyePwoRL4zms16Z7FMCI7LQPgzzoIp1NOXEylHjGw/0mvVWXnqNqyCF+wNEmSGUOzl82JnKxipIJBSoZSkB1AlHo+9NQepLZtpRHoagLYH5AfkF2lGiud0jY4Fbsm1LykfgAn5gbs4Sh+6HpkwCxL96pWoW8Kf8FIwrmGY3Ct9lrmDzyExrdkNrACQXyJBoXRIv1xKWOoG7aw90WcE22C/vuDnbGlD55Wt2JRKspSBPFBPK5QlO7PgH4+oD26jVnFrNTGLx0w4tG2n88F2mpPztjoMN/kG0RcFz/octEDdc/t7IMYudkSCsP71vPATGwwZIZsrvMuRqp3dCGaCaVgLThvFR1N+QsPxJA+RfE32dAv/wXzx1NxTE64pxWDEWT9pkv/64lNDm68Rvd4pdcfTcwJJDPIoQNCpZnqK6yviAQuhWa7QQPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(38070700005)(110136005)(186003)(8936002)(76116006)(82960400001)(122000001)(508600001)(54906003)(66946007)(316002)(9686003)(4743002)(26005)(86362001)(71200400001)(6506007)(52536014)(5660300002)(33656002)(8676002)(7696005)(66446008)(66476007)(55016003)(4326008)(64756008)(66556008)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?59j5m88oFIJ6NCTkyutaIlLsXAi/zxJLYi+QxAW5+ONVjk9k2qWDn7EDJ0hP?=
 =?us-ascii?Q?KPcKqblo6WrSHyML2PYCSlR5Dxdci9WyyKzY9rnNDbP4hibXitBxVBBdtr5C?=
 =?us-ascii?Q?BnWjWvnEnA3SrT9668Bst2jEAsQHy1hVacgTZZkxYGZGJcfrt4p9/h7gaiRl?=
 =?us-ascii?Q?qIdMVVodS3KnpQjkv5wF/VdygnQgqrKqD6nrdBMoSIbr1uTGj1zdGCCRh5lg?=
 =?us-ascii?Q?KcGk/kC6al3GmMknemMx/HITgB5SqTMpuM4eVpvjl0lYILw/wL4lHGWIlv5B?=
 =?us-ascii?Q?F2C7/BoqjaMPVX/Wk1sp6l8HhR+lJb5RJAU5F3SqLPn4nIRrr//ZKe0hloew?=
 =?us-ascii?Q?Y8SduOW6ODa6qNYiZWNwKb7wAYPd1uev0HKAJ/K9VcBH6+Z2ogRL/F8kU5Fv?=
 =?us-ascii?Q?Dgnds6AVaMZAnqg8mXu7kWGByw1PJTwHu7I1/TalAF85jMxsovNxdc4tPtN6?=
 =?us-ascii?Q?xbYN5A0DCMjN5UJQpVCpGow6gi1KUCVMPZycuETZbHuMZLkBByU/jnucQ7AM?=
 =?us-ascii?Q?Y07CHpR+eEQAnNTcyfTeu2HuN/+7YZ1hvEGIBfIoeSV2wUlCn+vLF0AxH893?=
 =?us-ascii?Q?IiVYnHvmU0bl4+cM68NytBrNFwipOms7eHqCTHbSbPCXpp5FcDLWoN64nDwy?=
 =?us-ascii?Q?5BJuyFKOP8keYJU4IucezH8im8BiFbgneCDLJMgBBW8KQ/cNz9jRlFZJ3HtN?=
 =?us-ascii?Q?zIJNl50NrahA/JXG3UgzOQZE6NR/ArzDrM/EJJmGYkXuqg8MiuRIqjyGRqNM?=
 =?us-ascii?Q?XQbi1nlSOYbOeM5SRe3BnldV5MkopqElsH36GaYBZ0RgdC4h2N3hy8p7Hgtm?=
 =?us-ascii?Q?H0Uo2WBBQxvEBc1KLmEkR+d6j62KnEc2LEfZICmZ5NcbRcDtFBU456XNUk69?=
 =?us-ascii?Q?QHYGd+2M2ri6FxZgqgKHIQW6Uz67vsiC/LO2cj//Uu2VFPDikpHzgCztFWez?=
 =?us-ascii?Q?Tq+DMYg/Jk1MwinbOI9bRfjPNHVvMYqEc1rO9adMLMkfpPd75Ed3U6fZORbs?=
 =?us-ascii?Q?LwU9grqG2+aHvRcCZOw+y7sEMT98U7FbRRCYYmeYGk9DQIHcrG4PKmVW5x2M?=
 =?us-ascii?Q?urTquXt3Az23xi9IUho7TuP8atEelFmO/3PfI9CwdbspU5G4nQ8wYLMEFRRM?=
 =?us-ascii?Q?xsU7P/1hFDeQ/iUwfQ+8ZFkeUl5GnT3rObshOjguCMKFhHZZXMOPj6fuNSjM?=
 =?us-ascii?Q?AQ5wCf2uqi4vxcAHRPrIxs2E+DJeQd2Z8ttNN39wKOQu9NBZkINchCN9yECm?=
 =?us-ascii?Q?FvwgpNH3KlQXTk/G8PqgfiA6JcpkxNmMqaf/CfvtZjNUCuV7MxWRKxrtOh0I?=
 =?us-ascii?Q?RP6+j15b8yipiW+2MBSwcHejR/qo/JZjKHacCLQ1iTL+PdxK6UaXclSLhR11?=
 =?us-ascii?Q?nnnYVN/HkDmKn1Jadp4dRBegcDlupS1mY4lTKSVbmDHQ6AyraZr6ricIvRpj?=
 =?us-ascii?Q?SmansubuItpG8H99ihZNG3NKOeSuY5EIn6tZlzz/v7w8bea72nJmEuMA0zGg?=
 =?us-ascii?Q?wDuQM8JBGR9jXk2qZJsFI6Tf3aze4wtskbNJNSYJDQbI/PFQxMnPHcnrx6fB?=
 =?us-ascii?Q?ddfASGLzAluDwcZsTtmJ9ZQyqJneS5FtvedpU5JpjiJF15+zu6laRLxXdYRk?=
 =?us-ascii?Q?nucGJftiie1g1WkcCkgTIkyymBybnuz5x44xDOv3gf1d6mG4fXEWWRL/JwyJ?=
 =?us-ascii?Q?WojC3PUQf2FhNWySYPClRMouQTYedV28ctlXdeshg5ssny5++Uz5jX2wjtE7?=
 =?us-ascii?Q?MlWrs35Ac1SC1A7tlrQCuQX38+LQhhs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21070d06-9b5b-4ad6-2d86-08da38e77dc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 16:00:12.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LiTVl1nfXiBdbXJEzVC13sUVHZnNbQvCdMs7YKfF/ZBP0ClEap9ewDQ5tlTrCk76cZ8fzaa3v5AiXSQNOlXoQBEa7vTE+RdkMT1HmvKzKmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3164
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

> Subject: [PATCH v2 00/14] GSC support for XeHP SDV and DG2 platforms
>=20
> Add GSC support for XeHP SDV and DG2 platforms.
>=20
> The series includes changes for the mei driver:
> - add ability to use polling instead of interrupts
> - add ability to use extended timeouts
> - setup extended operational memory for GSC
>=20
> The series includes changes for the i915 driver:
> - allocate extended operational memory for GSC
> - GSC on XeHP SDV offsets and definitions
>=20
> Greg KH, please review and ACK the MEI patches.
> We are pushing these patches through gfx tree as
> the auxiliary device belongs there.

Hi Greg,

Are there any problems with these patches?
Or I did something wrong with this series publishing?

--=20
Thanks,
Sasha


>=20
> V2: rebase over merged DG1 series and DG2 enablement patch,
>     fix commit messages
>=20
> Alexander Usyskin (5):
>   drm/i915/gsc: add slow_fw flag to the mei auxiliary device
>   drm/i915/gsc: add slow_fw flag to the gsc device definition
>   drm/i915/gsc: add GSC XeHP SDV platform definition
>   mei: gsc: wait for reset thread on stop
>   mei: extend timeouts on slow devices.
>=20
> Daniele Ceraolo Spurio (1):
>   HAX: drm/i915: force INTEL_MEI_GSC on for CI
>=20
> Tomas Winkler (5):
>   mei: gsc: use polling instead of interrupts
>   mei: mkhi: add memory ready command
>   mei: gsc: setup gsc extended operational memory
>   mei: debugfs: add pxp mode to devstate in debugfs
>   drm/i915/gsc: allocate extended operational memory in LMEM
>=20
> Vitaly Lubart (3):
>   drm/i915/gsc: skip irq initialization if using polling
>   mei: bus: export common mkhi definitions into a separate header
>   mei: gsc: add transition to PXP mode in resume flow
>=20
>  drivers/gpu/drm/i915/Kconfig.debug  |   1 +
>  drivers/gpu/drm/i915/gt/intel_gsc.c | 119 +++++++++++++++++++++++++--
> -
>  drivers/gpu/drm/i915/gt/intel_gsc.h |   3 +
>  drivers/misc/mei/bus-fixup.c        | 105 ++++++++++++++++--------
>  drivers/misc/mei/client.c           |  14 ++--
>  drivers/misc/mei/debugfs.c          |  17 ++++
>  drivers/misc/mei/gsc-me.c           |  77 +++++++++++++++---
>  drivers/misc/mei/hbm.c              |  12 +--
>  drivers/misc/mei/hw-me-regs.h       |   7 ++
>  drivers/misc/mei/hw-me.c            | 116 ++++++++++++++++++++++-----
>  drivers/misc/mei/hw-me.h            |  14 +++-
>  drivers/misc/mei/hw-txe.c           |   2 +-
>  drivers/misc/mei/hw.h               |   5 ++
>  drivers/misc/mei/init.c             |  21 ++++-
>  drivers/misc/mei/main.c             |   2 +-
>  drivers/misc/mei/mei_dev.h          |  26 ++++++
>  drivers/misc/mei/mkhi.h             |  57 +++++++++++++
>  drivers/misc/mei/pci-me.c           |   2 +-
>  include/linux/mei_aux.h             |   2 +
>  19 files changed, 511 insertions(+), 91 deletions(-)
>  create mode 100644 drivers/misc/mei/mkhi.h
>=20
> --
> 2.32.0

