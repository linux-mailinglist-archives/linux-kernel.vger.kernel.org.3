Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F29848D62E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbiAMK6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:58:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:22210 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233815AbiAMK6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642071480; x=1673607480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3cjO2Y7t6ilzrFAtAK6783cm3FfHtikGRLPWnTMCNzk=;
  b=HRK63S/y4bhZRoPUx7FMfsA+WMRCiFTG5irMj+EuLtixN6KVLTBOTAG5
   RAulaOvW3N0GrUT94unQzR+VASeJZTdF0/g5U9pNePy6NSMmCBYXArSL5
   vlK8phlnDuC3JyrFMK60m+dquJ1sqsaQ44cvtXKbpdnuMGFd+/TuSS4dU
   +7pldTbrsUkgFaugDM+YmwFZW/WKm6RM8NEpXK1a5C3EIt0utgCTUkKFA
   ax+W4FH5UVpiC3o9ohx858uNhFwOGO1X7jxX9HaiWbkk/xp0zehvgBQa/
   q47o3yDbm5WTpqtCtZGEymfkHaRxyJ5niujO9SQnbRqo2I7EU8CVkM0aa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224674648"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224674648"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 02:58:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="528965908"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2022 02:57:59 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 02:57:59 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 02:57:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 13 Jan 2022 02:57:58 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 13 Jan 2022 02:57:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFrkjv4fVuEixnzLkPZ/TV0LH8r1wX4kjLkWP66UD6/sBPedY/GT+fQcSKOocxUSlmqgiI4KehlI5nn1WUShO9QwgqiblE36fIw61QeXX0sWcSuMaNcq2JD9RoAqAP5D5YlDlK8V2vJK73DhqxmPcGTfUWdgTzoiVLq1hYnz4uC5b/Y+cm1W3PJaIuBXNL5lTOvSjbw6IEB/AWqIaSit8Z9sG+FEz51BEsPAW9sQEisaVcfoDIb5EtfKI0Kwa9jieDrS/64s5XOvX097DdaS3DnE3viQHmL18SNVWmJSDHUVdIFdhidBvnexuLNWIenhXuhiQ6MQq/AZ9NMye2JtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cjO2Y7t6ilzrFAtAK6783cm3FfHtikGRLPWnTMCNzk=;
 b=nY5ZyGgywoD1YuqIuKx8gPTiaV14ueNq9kFxCRdyHGAb9WgyZN4XLkxJa+U6lJoIHyA+cV9pMACS3CltFnc/MlK7oh6wuqyTWL9vTj4GUmr2gvqJA9j07WZ7/81plenUH4Vl1eGtrrEoseVmblBWrq6YYGhFzyJ3ky/E+aT61hoZLkqYmeXUnH4xOvwefaIJ5nPVndB3rd4fHtKKT+zitR3hTw4/+3do6io4WRIBNlgXoQnYaa1hxG7EQD+Nvzgv0VYQ0gUthRoi+Uo5xhHt+BHmQT5JOgsprJP0CU3XRoM5hvl61/bSlwgTwWXtvKPnlh+51GDHsXgUODlIRxIB0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 by DM4PR11MB5536.namprd11.prod.outlook.com (2603:10b6:5:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Thu, 13 Jan
 2022 10:57:57 +0000
Received: from SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::e8dc:d31:287e:ded1]) by SA2PR11MB4891.namprd11.prod.outlook.com
 ([fe80::e8dc:d31:287e:ded1%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 10:57:57 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Liao, Bard" <bard.liao@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: RE: [PATCH] ALSA: hda: intel-dsp-config: add JasperLake support
Thread-Topic: [PATCH] ALSA: hda: intel-dsp-config: add JasperLake support
Thread-Index: AQHX5k061a6qpg0Us0uUNHqGdJ+diawc6tCAgABGU4CAAaaFgIAACMSAgEIrI1A=
Date:   Thu, 13 Jan 2022 10:57:57 +0000
Message-ID: <SA2PR11MB489104ABA9A84DEE65F6E12097539@SA2PR11MB4891.namprd11.prod.outlook.com>
References: <20211201004628.1153763-1-brent.lu@intel.com>
        <4e0ec119-2b15-644d-9cab-b2e19b5c0e48@linux.intel.com>
        <s5hsfvczuwq.wl-tiwai@suse.de>
        <SA2PR11MB489124ED42353956827A2EC597699@SA2PR11MB4891.namprd11.prod.outlook.com>
 <s5h4k7rwgvk.wl-tiwai@suse.de>
In-Reply-To: <s5h4k7rwgvk.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 865d401b-28dc-41f8-f550-08d9d6838ed9
x-ms-traffictypediagnostic: DM4PR11MB5536:EE_
x-microsoft-antispam-prvs: <DM4PR11MB553644EA6FB6B69FC067A1B297539@DM4PR11MB5536.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B1mFhZe/Es2IYG2BTFu9xck1Hs0nky+N+FhkmYF8BJUvYIEg3kwN9lN9ebQgIaAwP36fp3evsYpL63U80pCgePTLK7ND0awI66j9YjiowdkVye2GaJ116BJwdGDYKROz/999jQKeEvcYy2bVYop9CHOtDdu4yQO2TUMzk6zZHkz6xEJqsCc01iX2+zsKdskHM+RoNCki9gmgsfaOD/sxdq7+x6Lo3hPmj0Ez3EZKUWjocy/J0R5O8hoDPT6KRWcb4afNeMPRfYFcTi3Mk3wZ66cR7WpXRwznFMYNAIus+J5LjGYhs520ldXRsGN37ZG4uC0pXJR9Y4o5YPdg6Xk3s8SwOBTbsMH2b5UlRd1bH+Sq3vPQjShZxbQRPYVE5aZjaD6IzQuLCgwvK3y3icGML+ieXV3VA4wzIXl5VeqmDomlCUYWJ4nbYhHgQw0jjUoEjb4ERAg29SdP4QGaBWNOK8vAz9iTPig6oZh7lO9weQZnuOxfWHDKSt645vLjAN4IMlC68SZcCNljiPS+eTFKE/4yxk7Cobb097mCVE9cfg9+BBBnOgzK5JpPh9cx5LIIUE9Z0D1tbRPreQGNQaIBUpRDX1Q+QUIdWUfZ6Qa3bTg9mu6soMY4gQvFHAJg0AccdqmILPxHuCw3UVRbuZ8B/n7Fm3N64iyvEJ5nIwRSUlYK56aETPPq1uBBPuCjb/gfpWrpHjuKHWzOYMf59b5x4PDZU9Ajjt9Z8Ab7rXp4cIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4891.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(316002)(508600001)(5660300002)(52536014)(8676002)(7696005)(9686003)(33656002)(6506007)(55016003)(2906002)(4744005)(82960400001)(64756008)(6916009)(186003)(66476007)(26005)(66556008)(76116006)(122000001)(71200400001)(38100700002)(66446008)(8936002)(86362001)(54906003)(4326008)(66946007)(11716005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2W+11WFwr+J7zPahwSZrdaiUtC+QZb6ip+vDusAugW56kPyYop7JPMx2ILMa?=
 =?us-ascii?Q?QDZe+fQrL2OgPbqfYRtnCHPNmaCXP1qMgnCFmlP2wpZZZS9HqUvU0E4V8S/r?=
 =?us-ascii?Q?u6R9eAPVYhjfvikrKunCFb2fw/CZzk/3vYBt6uZ+8GFGaQ8Ce9ByE3qnM8Bn?=
 =?us-ascii?Q?MID5PV+HJPo9V2PFfI+wIUxXsUSot6iuNIEq8+56mwKmNflMAjxvm4OoLHbd?=
 =?us-ascii?Q?sJ48EkBF1DICbeCcHymkbRZXK/3O7hshcpWTO73bRcuwi8XXeogl2cMjH3Lw?=
 =?us-ascii?Q?7T+mC0TvRu/pB9xX5SiB/RheXpkd8BYqueJ1ro1NZF5gMVlZpTXpPgxrENlc?=
 =?us-ascii?Q?3Ef0iRq8MmbB7xCdyMC2mNaN0thUzYJy1fFQ5HDKHLaDP76HAtGPbPSA8NdC?=
 =?us-ascii?Q?cJx91wmK/Mk8xZgF9H+TA9NNC0ncZoauuMXXNTSrWkfiX8xEp93NqpSBJ50l?=
 =?us-ascii?Q?Jvn24In/CAt0OZuPOAnmKrpIOngbufYylQIMrDIQRXxEty95Gf2+Pb/1zQwc?=
 =?us-ascii?Q?ToT+Lj6osRfm6cFD6oYkNKz0Urxpxo7+288OOdZ6ndtoW/xYqZL0+tZJIMQP?=
 =?us-ascii?Q?AhfwirI2XADNS7yOalryyNXXicueS4PBBJAzY5a4WozekeLnv6+4UoqR9Vue?=
 =?us-ascii?Q?q1KrJnh4X+dHI7CeqgzaEi0qxmzo4x97xhRBg3VrQJPCUWgID9d+LajkTZT/?=
 =?us-ascii?Q?5D0tC4YvlKIljRU/iCHo1uTFoZshhf94WNv4OMFAmeK62gElTae93ksTJyjb?=
 =?us-ascii?Q?xQD8+ZJUKIjqkyaFQH5D085agmts1JGMRblVK37ZRbEqKQWZb6+ZsjvoXqaR?=
 =?us-ascii?Q?aIjJwFbg5GMya81ugOHU1nS/p4qDdrJm4BjeQ47p1uyBPQ400bFonDruA2MV?=
 =?us-ascii?Q?yFVQQYA8hFI/CEo/bxmw5jCZcMn9OuTVVz3AZUt4qSWsVAU/19x9BAOiYDKu?=
 =?us-ascii?Q?zHS8ThJedEwjFVMePsLv2gWtduBP6OG87DhzDAe60GY/KOuMuyp+kitYyq36?=
 =?us-ascii?Q?M22ieCrGbWV4tbiRXDxIPlLu0XZQeOEB8hLXgY0Wv80VBlPxkMSoc7opfqNV?=
 =?us-ascii?Q?ARE6mKIMiPy8pCb98dvPStuerdaJOA8nXG6VnWLEzl0l83Rlt6w2m+7X85W5?=
 =?us-ascii?Q?Z3OOqdh3OagjntX+49w18CvFeNd/hfbAwM181BuDR8HMPR+8LxwYuOwWpvbl?=
 =?us-ascii?Q?QtXuxEhWOcW8MkYwKCKb5DCVQisiwULUUjKVBHPEc+N1vHygTE///x1f0Dg4?=
 =?us-ascii?Q?VeTdnANPz6bV2OGwFgeCCWoVgUgok4PMwTiQsFo02R9JyEW6yk7vEfnpKKxk?=
 =?us-ascii?Q?7Dz3f3dHpXuyPLZFr+cyVA/+FztLWS6R73CxEyJHF/x4CpdCzrjd22pFsV/u?=
 =?us-ascii?Q?w/DTIZMlblpFVcIr5fqf0hNJv437jndMsbC9Tb4we5sLCSthemln6IlO9ZWc?=
 =?us-ascii?Q?1Hm/HR/fNb/5hHe9ufCEPt1wbs7ZbMlzwbdW5r5Zv7AHd2aQsOq2c4mBvLuZ?=
 =?us-ascii?Q?6eQLR72jF4IKKp6u++wtWv/GcYAXS0bKVWrpnORgY7cV+8K7DRyb8hGXamZj?=
 =?us-ascii?Q?02ZNii4hamXGuDuyWNSOpv6H8yh9siqahJg8oSg4pSUQlysO3G1pg5WmksE0?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4891.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 865d401b-28dc-41f8-f550-08d9d6838ed9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 10:57:57.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ahh7xjvq0wltGYXwpevJ11Wx9/OJ0j9x1daQL0TBt48K+KAMB6NmeOkHewCrRAu1Z56tVojI31rHO9emI16wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5536
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi gentlement,
> >
> > I found following two patches in sof github do not exist in both
> > broonie:for-next and broonie:for-linus. Maybe it would be easier if I
> > resubmit my patch to sof github instead of alsa-dev?
> >
> > sof: topic/sof-dev
> > 986f58741d0d ALSA: intel-dsp-config: add quirk for CML devices based
> > on ES8336 codec
> > 2cccdf5b4414 ALSA: intel-dsp-config: add quirk for JSL devices based
> > on ES8336 codec
>=20
> You'll need to rebase to the target tree, i.e. my sound.git tree in this =
case, as
> it's not directly about ASoC.
Sorry I forgot this mail. A v2 patch is sent to rebased on the right tree a=
nd on
top of ES8336 changes.

>=20
> Mark will need to sync his tree eventually later, but for this particular=
 patch,
> just use my tree (for-linus branch) as the base or use linux-next tree.
>=20
>=20
> thanks,
>=20
> Takashi
