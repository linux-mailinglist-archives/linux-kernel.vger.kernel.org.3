Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C298450CFCA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 07:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbiDXFQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 01:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiDXFPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 01:15:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A969360FB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 22:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650777162; x=1682313162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cs6EQEqxkdNpaHJzPwII7ctha6F5zcP1up6Aq3sGI7c=;
  b=R/LiV24scffInP7agKQbIqZPM2e2GmxWj0mTmtUbP09UJrLP9ol2FWKR
   4Z/msut+27EFMSh0wbs439az9lnol7x1S9hiA1Sk6iMlNszcsONK+T5Pp
   bgv9t6GkiugjXY7h2eZHf4LlEOZ2K6+yTZjrCBPaP3Sz+sBOhCBveXoXR
   wUJLeOASdqHG9ZIdsvZoHRUYAnQcZkBqNmbEa6YF5gBQBBJRlPI8OveQu
   e+R+FokKZol+GNoTkTGAUrglFkIXylgjhPt4iPtQY1JhvpDT8RI+WDa8X
   bYx5uQinb5Q3XnUUGhxvcSy9u+Z/oD63ZlkBBU4juJ8ZvVswoSAosy30L
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264780226"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="264780226"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 22:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="557131202"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2022 22:12:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 22:12:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 22:12:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 22:12:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4u9ziOduPgcFQ68IlhW7FTWrayYfRrNlh9n1B57k1i9SGfm1Nen5Sov6uQzd8UM17YUwlykyGtT7QVHSGVmbxOXOyoaBkpSa2uytGnpUO09rJ7OnTcqN6qSoq4C2Wmm/xKnxMrtJxv68lBgQTSVn3BXFh7C7jV3fH8LAOxK06Ug5Z5Xg7rnmh7uqoHdxOFqE0F7/IMcHr9mbvenRLBaSx6hYanOm+Z9y10fFxz2389t9LzGUeliVwr9MMudkEn8CXDb7DwKat2Nj4jZ3MVKm3j9tegGfks2rosGYKni6NeKQ2UVn2PbbIy5JmHvyvzhmrHcsZ3e12+PbH+HAMOZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUeu/S5ZIwSfTNmpXVrh98vu/g+2q1OcOdwCg6b+Nj8=;
 b=Ux1uyx9mrZfNVEJ9aoh5zHTqP6eIXsLeftTGtPUGh0Qe6LagzL56L5JANpbLlANkHcyDYPQ3SHYg6bxT6y1LCyQr8iL+ftSDxOcuwH9XGGKrj5TdfMwr0XDTmUWipfygDf5sNynqatvbXBDKSKMKncWJeRopAIAkW+70AOTMmkzgLoTWQElZ8aoL1DZ9pEEuAtbofGf0ud7RftrYpWNBeNmxF+uRpL8LCMiysXZbl+68gR5rH1XLd7TNCJrFmHK1xJ90bOKPQfrtBrXggQyWwgPlPWHCnPj8zin/SAWbITH68beBC2XuM28vKMRpiRAhjKPsSNw0h1j5vgITWrsvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4651.namprd11.prod.outlook.com (2603:10b6:303:2c::21)
 by CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sun, 24 Apr
 2022 05:12:40 +0000
Received: from MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::2c7c:1eaf:e38a:bdc2]) by MW3PR11MB4651.namprd11.prod.outlook.com
 ([fe80::2c7c:1eaf:e38a:bdc2%3]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 05:12:39 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Won Chung <wonchung@google.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C
 connectors
Thread-Topic: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C
 connectors
Thread-Index: AQHYU04XncBI3ssso0mb0+jIcO6ZNaz4otoAgABg7YCAAN/TgIAEqV9Q
Date:   Sun, 24 Apr 2022 05:12:39 +0000
Message-ID: <MW3PR11MB46517BE51D4DCBC02B463C0EEDF99@MW3PR11MB4651.namprd11.prod.outlook.com>
References: <20220418175932.1809770-1-wonchung@google.com>
 <Yl/l7gjRXj41a93q@lahna>
 <CAOvb9yidpOZ4jCjme+u1a4fPTRnLmxUHSTO3yHPPuYtDbe1V0g@mail.gmail.com>
 <YmDy/xEsyktRS6D+@lahna>
In-Reply-To: <YmDy/xEsyktRS6D+@lahna>
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
x-ms-office365-filtering-correlation-id: 3b23d37a-2602-42b8-c1b3-08da25b10dec
x-ms-traffictypediagnostic: CY4PR11MB1238:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB1238C9D052089BAA7437E233EDF99@CY4PR11MB1238.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0oiPcZsZvfKcULPjSEmvpkWrAZnQaw5MVkwPgGiVsnDReXSDnGOZA+cIIvyTgMoxV8snuN5gGnV3+yIDX1KI2xUatIzBf/+ryQsdGK/s541qe87rsW4FD3XqQrJNeusJ28ASu+TfPivvhREYI+KOENES4dGv4eYG7f5BhdZw+4G3Ly5t1vEjD1QLma5YV1H/XVPegwZ+aAkVAU+KrQHRfsqxps/lsGucjqUusHPubz3iM/rrMPiXvHxdgHoriI1yRAHzpBF9F/yg+dliN/TEPs6ryhToaiNP9T/NXC7rNCI6zabFrZMGvMIwyOJlVWeXPkhugf3cooBDZCFmYZLVpPN0s7FeGA9qVQPCDRw74c+Puv/qrG5XZNnpgR6bkkBPSAVNCQxBNIPwuBbt9Tr4dOcznD3wg9cLm1RDFXnXWF1VmY2PgxDiH3TmdtXa/NnaLiRk9fSeicH7NUJsuwXSyv0Qalp3sD0F5dFyFNxSh29Rnuxgj0bbi91BbKTXLpH7dO4xDmLoQBER4uK9YzXyfhBTubvKtDSMXxx5pjqByePa1mGQYEY5NH4SoaODF5t9WbuadWAS+612Q3tqlDsklFfvG3fAlvy5iCp2Yxyq84SDEjBFJZfOpcA4cxWrkWTovkbqc0LuDkuW/6L8QAJgNgiYCcZraY8GP7SjRBWTtBFLs8fr4bJw7mFEvjOEzZoVe+vZRmkn6X0Hbeg3rMO5dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(8936002)(82960400001)(52536014)(122000001)(38100700002)(110136005)(186003)(6636002)(54906003)(508600001)(7696005)(26005)(9686003)(71200400001)(64756008)(4326008)(316002)(6506007)(5660300002)(66446008)(66556008)(66476007)(8676002)(66946007)(76116006)(86362001)(55016003)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f7GyBDd5mdGfMD6kjsrgDXnyWVNNG1Vt21x+L/htLqrtZK7SYPWt5yqNVosj?=
 =?us-ascii?Q?uTzLUBWxr+uAAF3EqZ2LP37TBmTJgttr8jThYIOnDnswTPLDVNfKwGjdeZfK?=
 =?us-ascii?Q?pqwZw18VafUBMFwR1+DI6vOW0yG+BfSTO3AzyqxG1K00XZz/nYtqS+D2S3OA?=
 =?us-ascii?Q?tfUDjTAoI2Et9Y5pks7KgVtDaOLAFHEb0GliuWsza6iVdbfxor5e8ILFWn21?=
 =?us-ascii?Q?i/yCYmUd3L+RKWwyftKvfE+igaxxfEG4wjdRKD8jY043y0gVIwxXT5omk4TJ?=
 =?us-ascii?Q?VxYD+1t4kBdspDagpBF+vL8+Z/SVUDld+GzMq/4uihfOMfbQWqhA7eKc3w6M?=
 =?us-ascii?Q?Wco4je4WBtY7s4DrAyetYsT5WyWm++L1mZZQhbzM8Pc9GPptPXKlDZHOSS5i?=
 =?us-ascii?Q?xHl/E0fRZzjFggDYpeQESrz30+S697XvpHKYjuDQbuBUJ//h6bhxOPOz+uCF?=
 =?us-ascii?Q?wEAS9sArwOZug9X8i7k2GCLm/sROA/S7pD62fS68QGCllEB+vxmDSJzM7xk0?=
 =?us-ascii?Q?5UZM/T6Nlt2kB6vuHlkzdQSzRtQlnUpJ9OQ2IwP6L0mjkNUQMYQulzhoIAHG?=
 =?us-ascii?Q?hza+Yb7ni8EO67aK0+Vk7RYZpCX4plRomY2B2oHfoOlNeXzApi+m4PBRrdrL?=
 =?us-ascii?Q?B2FIpj/7B+6ZVfcnijqJbAlUlIMwCIToCd7AZu3yXaW0femJPiPCYwfYsh0c?=
 =?us-ascii?Q?uWqnumNETvIMYBjgvRE7rCQ5ncK90t5qYW2nmnndMrYYtV6Fb0qRAQMuVdHu?=
 =?us-ascii?Q?+xAOFMZydAbganFlIuj/WvfIv1q+NtnrThfjqkvbhrIP2vSRGbATsAoyIs0z?=
 =?us-ascii?Q?u01Hk9spBoaiAxK2Wkt6afA6sZh99LWPaMv86Diy0dBN9lwopVdJhktaegaZ?=
 =?us-ascii?Q?wOSIaR3CZvW9o0q3sHpdVrFU6pQpWT9Pq/SioDHcLDlc11zj/JzLOOA4Lu7Y?=
 =?us-ascii?Q?e2VSQJnKJy2v4WJVUW85fsUznqmTRVYSdOluOahGOaE1+g/1Wpx2JzQIf32g?=
 =?us-ascii?Q?Gl0ImwtvvcQOHpRDYFAm606mQB/cT06Cs7BmgLECftj+NuhMSc1Njf16Seyy?=
 =?us-ascii?Q?a5UsjKpY91QcbsPmdl251usT1B2I4WmKFLjsW8B/FvTjnZ/tNIC6r7voSdDs?=
 =?us-ascii?Q?EKKMYjYQOVm8vjUmgOhxPIqrQCZUH/KEEtuWw51xj0xeEcaqdhJaPdb4XVNr?=
 =?us-ascii?Q?xZttUgTGAsk5KVsdku5eC425bGBaKIm6AsPTPkaGQ3e/Lj/8zGVWGOvjISTk?=
 =?us-ascii?Q?OraGM7PvFQjtyCGKCMQqzdytWlw9IwgRlmaGpbw1JyFAkl60j3Wo6kq6J0R+?=
 =?us-ascii?Q?VbFKfGf6Hu9Fq4ZtSlOT9H4kAstTzHeI6RrwydkPrYAXVtyDvQTY2CQZvrL3?=
 =?us-ascii?Q?QbueblnPM3yQqqwI2B8IAvGfg0xsHTUvuOnknFSClpa1p7MuZ7PMFXF63A15?=
 =?us-ascii?Q?ZBm0IO2rVbFBdYZoRqGGt+ITdSg1DWMbLy/CYHuLMPWqgToLAdfh6AeUBHjY?=
 =?us-ascii?Q?s4VmdvHASVvoxjyVBob2P0HTmPNhkHmDDbZas0TVHHma7voQpeY4mQC9n74k?=
 =?us-ascii?Q?dJX0MUdi29MwQxpJGIg8/mHMTvFI4aafYUV3qZI4c0D1gpa5boDyZ8n7ffC6?=
 =?us-ascii?Q?1YNc1Fpmyp8b6ObH6RhdweSZUMreybGL3UkWrgMCRJ6Gw03kW22TTnhUP18S?=
 =?us-ascii?Q?gvDfSY/5XjQj4KLapVGY/lgXyqziBfusCuEdaKo9oDh1GYYn+sM56xIgaG2E?=
 =?us-ascii?Q?fhbG3RYz/OTNZlKolixK6Cgj2l5xtzU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b23d37a-2602-42b8-c1b3-08da25b10dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 05:12:39.8780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wFeK0hS9zHzsI3Dn5GPs2/+vECCjLVoldbuH9ffUyRrg92wxjEKibfbadpw2cISFzB1bm6481mUiGS66Ank6rcuNm/IVrSkCVnN44e1ZVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Currently, USB port is linked to Type C connector, using the compon=
ent
> > > > framework, if they share the same _PLD fields from ACPI table. Type=
 C
> > > > port-mapper searches for devices with the same _PLD values, and
> > > > aggregate them as components.
> > > >
> > > > When there is another device that share the same _PLD but does not
> > > > registers a component, Type C connector (component master) would ne=
ver
> > > > be bound due to a component match entry device without a component
> > > > registered. There exists some cases where USB4 port also shares the=
 same
> > > > _PLD with USB port and Type C connector, so we need to register a
> > > > component for USB4 ports too, linking USB4 port with Type C connect=
or.
> > > > Otherwise, link between USB port and Type C connector would not
> > > > work either.
> > > >
> > > > Due to the nature of the component framework, all registered compon=
ents
> > > > are shared by all component match despite the relevance. MEI subsys=
tems
> > > > also use the component framework to bind to i915 driver, which try =
to
> > > > match components registered by USB ports and USB4 ports. This can b=
e
> > > > problematic since MEI assumes that there is a driver bound to the
> > > > component device, while USB4 port does not bind to any drivers. MEI=
's
> > > > component match callback functions should handle such case to avoid
> NULL
> > > > pointer dereference when USB4 port registers a component.
> > > >
> > > > In summary this patch series
> > > > 1. Fixes MEI subsystem's component match callbacks to handle a
> component
> > > > device without any driver bound
> > > > 2. Registers a component for USB4 ports to link them to Type C
> > > > connectors, similar to USB ports.
> > > >
> > > > Heikki Krogerus (1):
> > > >   thunderbolt: Link USB4 ports to their USB Type-C connectors
> > > >
> > > > Won Chung (1):
> > > >   misc/mei: Add NULL check to component match callback functions
> > >
> > > The Thunderbolt patch looks good to me. Do you want me to take the bo=
th
> > > patches through the Thunderbolt tree or they can go separately? I nee=
d
> > > an ack from the mei maintainer it goes through my tree.
> >
> > Hi Mika,
> >
> > I would prefer the two patches to go to the same tree since it can
> > cause a crash with only the second patch (tbt). Would that sound okay?
>=20
> Sounds good to me.

Tomas is MEI maintainer and should ack MEI patch

--=20
Thanks,
Sasha


