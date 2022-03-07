Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98494D0434
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244185AbiCGQep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiCGQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:34:41 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C9E70319;
        Mon,  7 Mar 2022 08:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646670823; x=1678206823;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pzMSnL7Qfb1S+QjQQ3tsKZYU6byz2cGvmVZMjYlMGcg=;
  b=R/E6+7uKwXzANHU7yk68l0YmNVywe/5vWNsINKJ4MZBzU90efKINDvDz
   AefltzcFDW5kVGLKX+7cKaErrf0BXE1hVOiAMh5trjbNCesCp4XhA4UH0
   Jzf23EyMBMN1KjnJUTp/07nrj9b2eDIoJ+dgjMUKplgeI77PgLU5qZuc+
   xvjYek+yR5H2LUFOTwptNChrm4iXUBu4BjUhCy8TWshIg6679apPzAVlv
   p14qS3vmkqECCj1JnmUIbmRM9QOAk1L4VjhkqKNeNYQ7902QuaKsXct1v
   WVcYYV9Cg9IKx6+LuUKyGGh/DNJDeI2lBKZusZjH3if51JC33sjVqKvjD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254628074"
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="254628074"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 08:33:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,162,1643702400"; 
   d="scan'208";a="643309522"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2022 08:33:42 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 08:33:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 08:33:41 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 08:33:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgzyYD+v6llk1rkmW6vMKx8YbFv4YG2V6gTiTuYrDJ3G5jRk/+OPfNh2Om0viX3nYVfcj3NbtOA4svLsAdUH58fhIXk1PqXwUhCGoE1BJkURiGvJ2H8uZmMDcR1dlHZmTSMd8n0kX1zs2ukqWp7uFSYcQk5Nw6srRjtCtQCrOYJhwBurgPWWsJZyRWlxkHHBi6RCL15i7YIZVVcicBLJoss3rWDuGPtumEO0ZPjTmSOn7m5e/uLoEwXqRKH8ze/vzrXv6/vHlxTZ+fgsiDFxeRmuOwY+1uPfiEpkkO+AFoxZFPjnOxpmXqvF8Ma68HqzFSrYGsDnpz+RqXRTJpei1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDTeqgbW7KphpV7xxIa9UUxkzCJr6chd0HgYLuZb3yc=;
 b=K9JGHyhmJo2zCQ9o4FUWcMALYUnh6i0LpYXU7G1J8ASg7+hpRy1gtuT2GB9/ZhTLcqtOlex9BsUyWAKcPcn145HOhtfRJfAxZ9/8MSNzsxME25zqVwVOyt/OKp8F5f8/4Wv79rvn863/35iu/Fo/W2tQC2TsG4HqPLtiMnxG166EGMbNV5BnyxZOOASHd03ymykzQe2srCTURsiiHRrmJIcSBR8kmwmWdZgxh8+e91hvfPmgmIi9CeZa/6TwKlBciAOgwWfgztI87Qo0DAon86pztKc6k6zCVIdKKQxcsvsZeTbhG4YMO0Horylw3p3W3bm3cXHa7ke/Y5lkIPZ+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5545.namprd11.prod.outlook.com (2603:10b6:408:102::19)
 by DM5PR11MB1515.namprd11.prod.outlook.com (2603:10b6:4:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:33:39 +0000
Received: from BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e]) by BN9PR11MB5545.namprd11.prod.outlook.com
 ([fe80::8548:a26:d677:6e0e%7]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:33:39 +0000
From:   "Sanil, Shruthi" <shruthi.sanil@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v9 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Topic: [PATCH v9 2/2] clocksource: Add Intel Keem Bay timer support
Thread-Index: AQHYMhb+C0go31lR+E21PIr/qChAaKyz7u0AgAAu1EA=
Date:   Mon, 7 Mar 2022 16:33:38 +0000
Message-ID: <BN9PR11MB5545C28013C6FD435154FB1BF1089@BN9PR11MB5545.namprd11.prod.outlook.com>
References: <20220307113147.19496-1-shruthi.sanil@intel.com>
 <20220307113147.19496-3-shruthi.sanil@intel.com>
 <YiYMYuENpb1VJV9G@smile.fi.intel.com>
In-Reply-To: <YiYMYuENpb1VJV9G@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.401.20
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc990969-a7a1-4b37-98bf-08da00583c13
x-ms-traffictypediagnostic: DM5PR11MB1515:EE_
x-microsoft-antispam-prvs: <DM5PR11MB1515F39661E197982BFEC678F1089@DM5PR11MB1515.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wq3qfWQvOo1EGv1Ld+cKyWPYmfsj6nrMRgu2dDhkylSZ9wVnBQA4nOsp/K5RFw6A+Ub9ntEby9GnLLn2aIOP5a7KJxe4AuB71P51wqsZKRSlmGFUdMd1cED+HVyRObkwNirsN1amj/LvqjYGxBa/prmdR1tXtZszqDcuXpwyeWhdr68+yvY1fKrR7b0BikXn2eDQPSFsa0KHGWGSkB5XOAoKmZoYJRfImHUVuoL6yRQSZ4Z7hu0F/i6Jv2HXdh7SVKRdFTpyrm9wg1YCz7WvE2sJkXF7J7jJUr1tTJvhldQmW8dEEVCU8R7jNqYNyFhqn3f6gaKBAWNaLh+RaDBKUsrmTC55WXZ0AOBu/UZdPXI/e1gEqBb+n7LR21J3WedUl7IAY5dhm+au+IpINpkbFVYdzYPW9OICFgoxCAHb4YRA2PQu4fYaswikn4y6Z1McOxWf2YCknf3KkuqDG4EcI8ihOpgjNcyKtJKK/oGi566CLYYW+6C8YIB+DsVNRrhnKb4ddCsTfdwe3l89avWGA/eK79Zv7+k22lvq5MKKdrR2osOrIVQnenvwNfdQutVlZJTWrVqooQNbM69AGxECA+gdgJpPXAM/CqMCyU9IHk30uA6qDnx0w1QIWY8RFz0HM3pYwz5DBM5AH8VA4scN9GwgBl0s7i9Sy+reXCzfF1UwsQsvi71yEJkDqlEiop1PrII338naLptSKUd8+8zynA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(52536014)(316002)(508600001)(9686003)(71200400001)(6916009)(54906003)(33656002)(7696005)(6506007)(5660300002)(55016003)(53546011)(38070700005)(86362001)(122000001)(38100700002)(82960400001)(26005)(186003)(64756008)(66476007)(66446008)(66556008)(4326008)(66946007)(8676002)(76116006)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dzmtW/ITbmMQQSxdPkSl3zKfyZvR4E6l5Iq0wMBZYOXcDlPTWwCZpLZoGVeK?=
 =?us-ascii?Q?s0J/upAE6BT/00eZmt2SK1SqYOemhPsTA+AENTcYXi8IbsiVBkjjYCsBCX0s?=
 =?us-ascii?Q?G33yDZ9p1gJRBtcH/r0q7bsUHGeCZJ0otKn5vSM4NUtqHCnJEUW6/eOHUv3I?=
 =?us-ascii?Q?0Gt82+RkrBz4Gg1xCOGJeNwi/eoEsq/il4INYWbBOCfSmaqN9A/W2ehrju51?=
 =?us-ascii?Q?9yFSkf0++Wl6zVFZg5aEY0TEJpkM+ZvlzhlN01+4LagsTTM0gA0O292Urgly?=
 =?us-ascii?Q?ESDAYWtrIlrzhaSCeuj5+aejJG5eOTeR0slgK2PJOuTWVcqMkNB1TJrUy8nh?=
 =?us-ascii?Q?MXQ14EJNLVcUzrZfzEO5/YHXVPuMo3V+Zpn1aEKrLZaiFKVSbep448EofpuR?=
 =?us-ascii?Q?VBV9h3L9ghaThGHq4MyPTNZtDambv8wrdMEIlZJ9AMT07cED1jsaKxfc957L?=
 =?us-ascii?Q?cT+QphTyTjsLhyZijufbTKaiuTJtR0ythY40jomLha19uhygIMwzLxq63e6N?=
 =?us-ascii?Q?4Y9vhPeIzFN/4s4xDdkncRCmMU/o3UsUoQ3uujj8F4Kaps//SEZKhJ5jZNxB?=
 =?us-ascii?Q?Q5ofwQ6i1Gzv14rtm6rJQDxsbTPyd7zf2kvjS0uA9aptX8E1SXd/lE9kSBTe?=
 =?us-ascii?Q?gD2vzmVt7ereDKBPcb3MgX3is/mky69TuCfKU1WdSSid0lO2JaN5K3I5eODW?=
 =?us-ascii?Q?FyET21f9oRjkHjNgbJ+vAcaHJKq6gtBNB52u0dZumId0QKAlFQQ9QsArT82D?=
 =?us-ascii?Q?Xj4paY4U3YU8d+d+IWxQGYw2PcBSqQSqy0R+8/DLkJ/wBb6ImSwSGWgjVY9S?=
 =?us-ascii?Q?L2+evn7Ij25IZ3tbIBbfukNpEUbygNDxlIuEdfsSpgH2uQYww5IphWcQaR9x?=
 =?us-ascii?Q?+kPmu1x9gvcqiOeAwGtmFdIx6wUNzJ/ghc48+nBamcXhml1P89a1Hm6iLa82?=
 =?us-ascii?Q?iveSrpR93yD5+SnReHJDrh+mXAYhdPJv3EWiBNcbP2p+fC1OnJB1apSvsHaj?=
 =?us-ascii?Q?l+M7r5nnB/45Q9lcSI+lhfrKeGF3bGw6RtfT/UtitceLyNYNMXnEcOhx1dFc?=
 =?us-ascii?Q?8PTobr17UBWAQOto/yMHjlUlf2dsUQGKwIZBzVhOJCZh4ZOslx4NqBOGzrg7?=
 =?us-ascii?Q?+zgGktWBZme7EVaSqqDK7rCjIDkmQJ7CINU6qfB6Ez9e7VGxegdxcRmgw3lU?=
 =?us-ascii?Q?0qrPYu2RJPR6GZjTqxtkoeer4xGAv8bIhlDPOFXGLGri8aVv+vhD4eEGDATE?=
 =?us-ascii?Q?Jsp3QevyZpcyy8TH5scrx1yqMWuf1j0o50yw07EHLDFwWO6qpfuLHQccOXxq?=
 =?us-ascii?Q?TIaCZ0eEBUEeQa7AR94k8HLM5wgk1VVW1mUVaaxVaSrUQMMkmuqwDFe5Lxmq?=
 =?us-ascii?Q?H79U72FeGzVVN+dD6R6yC/w4CNg1KdFhw1IDCo4hDveixkmPQitG4gigon4c?=
 =?us-ascii?Q?Hn58PD8PhOar51JE08t4IezlUp3Pi8a1ZmJqZUWzAQnIKITSZNIuMDeykDqz?=
 =?us-ascii?Q?acAE5r1oL+zBFnQZjqHiMROpKjOtQOhxR0rALTAn3Qseb5qYGFmEwj9tz/GA?=
 =?us-ascii?Q?guQhS7w4tx3Q3nSLnMDZVDuy8NZkSrt0XnV1mC9SheVCG/swSLB/87BZ3LEe?=
 =?us-ascii?Q?+mSsitXml1VMfZT6aK29eQU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc990969-a7a1-4b37-98bf-08da00583c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:33:38.9511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2rU/Vu5ts4M+oTwkdK9KlqxytWM+B7EGeNP+yFvvQ3dLdOnKYTmpZ0e80pHkhBcPfjYlVPaG5Kr/HjRK0IXMaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1515
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, March 7, 2022 7:15 PM
> To: Sanil, Shruthi <shruthi.sanil@intel.com>
> Cc: daniel.lezcano@linaro.org; tglx@linutronix.de; robh+dt@kernel.org;
> linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> mgross@linux.intel.com; Thokala, Srikanth <srikanth.thokala@intel.com>;
> Raja Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v9 2/2] clocksource: Add Intel Keem Bay timer support
>=20
> On Mon, Mar 07, 2022 at 05:01:47PM +0530, shruthi.sanil@intel.com wrote:
> > From: Shruthi Sanil <shruthi.sanil@intel.com>
> >
> > The Intel Keem Bay timer driver supports clocksource and clockevent
> > features for the timer IP used in Intel Keem Bay SoC.
> > The timer block supports 1 free running counter and 8 timers.
> > The free running counter can be used as a clocksource and the timers
> > can be used as clockevent. Each timer is capable of generating
> > individual interrupt.
> > Both the features are enabled through the timer general config register=
.
>=20
> ...
>=20
> > +		pr_err("%pOF: FW_BUG: Prescaler is not enabled\n", np);
>=20
> FW_BUG is a macro. The above is an incorrect use of it.

Oh! I'll correct it and send the updated patch.

>=20
> ...
>=20
> > +		pr_err("%pOF: FW_BUG: free running counter is not
> enabled\n", np);
>=20
> Ditto.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

