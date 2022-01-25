Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4D549A88C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1319369AbiAYDIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:08:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:61324 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3419568AbiAYCTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643077180; x=1674613180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/40HLDCJCSrSE9Q5SsTOEql75csYZ5B/vwvUYkk+Ccs=;
  b=ZIsWt0w4tvETJ6vdQ4sH6UJFpg9sqPHGJaICNdSmZoYei/PgPuMg7UxY
   j7A+2OStaevGoMo3gnZ08eg3G241EP/lQYE6qW9KtoTtZ6ZVTdEJ9ci0B
   nxH9qaFUAd+t+wxuiPZwMMB+NaBcOiPzKaIKK49ZFhlHyDR3/T5b6Gbip
   2g/JOe/hXUwNdS3NYuqt3CvLd3htVMeGobES1ZkIn9+QABooxvGCkL3P4
   V/po1ymrknd7fPJ7Sdd+e3eGI121iPPipAvOAVTIBcTSHFSozyyL2KSL9
   1At0tXqjSzYVxlwS4BNbHwHyMCO+ohTv7u0P430mPxbjXwYpGhDg1/cv9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246134518"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="246134518"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 17:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="562864281"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 24 Jan 2022 17:11:58 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 17:11:58 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 17:11:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 17:11:57 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 17:11:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxeYR7xGWtglI3udd0+j78/O/NbKWeRUHMThdz/Y4PdNZWutVMmFuac3DXoP57iXB58gyu8dw0E0+sxTRDu3nKZWOtGFbNlQHOSIZi+j+VFZMkpG1q1QPV/64ucVeJY0FsQzn/qkTO2K0jb95qwUpIosaoBBsN8/gUkIfGkoN5kfg2rfupaa+DOyTnXrzNdXw6eriijHh948W68cmW08ld35zv130mRmmuA1cNBMrWfze1j0ntOq3EDPK5XDAFUmGK2FoZTq0lEr/amTomQs/U8+4twcUl5fBlt87LOl9ZkFHYAioUJe5iE8RPbnIdrgRm8j7E1Arl8Vypod3dZJCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/40HLDCJCSrSE9Q5SsTOEql75csYZ5B/vwvUYkk+Ccs=;
 b=RGFSsCwEf9SlaKzB0fY0705xALGwfJXNpo6zti2f70RpeNv+j6QzXavoio85wjB7BL79x7V+TKbbA1z2rKtd7kCCYES7uOqVY6uMS7UBOsUP4OUL2kC7rPLufsu7ZsmqaEeozys9SquE0aIqepU6B33ggUdaLidhGAau6gMbQxvg1Qbcc5y201Dz77a5yoDxkc4mPyQk91mOs8hSj/ayZeMCjA7HhBxmcIxpaPICeFER/PbeWBHZHkCXBje3UrT4XytcKQuBqyScJhvIKWZBGbtuSG4g10jDmP9h6x8cvp3UhRyRDvfIlvzj9lrOZbxRtSZd1x0cdPBdZnR2WF7oTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4262.namprd11.prod.outlook.com (2603:10b6:610:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Tue, 25 Jan
 2022 01:11:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 01:11:55 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Eric Auger" <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] iommu cleanup and refactoring
Thread-Topic: [PATCH 0/7] iommu cleanup and refactoring
Thread-Index: AQHYEPHAKjrfWJEn8EK96HWI6wkQH6xx4JAggACRgQCAAH0HkA==
Date:   Tue, 25 Jan 2022 01:11:55 +0000
Message-ID: <BN9PR11MB527647F0336BBD8528E3413B8C5F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
In-Reply-To: <20220124174404.GG966497@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd042b15-e788-4e4b-dc86-08d9df9fadbf
x-ms-traffictypediagnostic: CH2PR11MB4262:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB4262E864D20FC900626D82AE8C5F9@CH2PR11MB4262.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUeWjtfyyS5rDJqosbQs1W1+yKjgU9yPv0rbCQ1rUj9YVeJ4ciEIz3QRmjZysnx7+t7/C9tYgJC+koOxhCylz2RipJBwLDtmw+M7U8/bRT/taKFXt5FhyoJQrn5Fek4tZRjs298YeDMl4Eq3TF6ddITLUJ9UOrUoJHmxrQcSiW7oVihK9z9NE6+rXFzdSUrjJxwp828KLiHZGLCcn2WpmcYQfS/V/EREuQwWjJAStqKj4kTZkws1s71Uuxe1IEqFS+2Npps0e4efDbB0owZoueBUsosQqdKXGc5v2xv665Pb02KxPTD/5px/P9nQnHx1KukkrygONopK5baToirS7zFGK+dBfG7n3z6xP8ZU6EPT8L/qguTSCh+NIpdWgA1eSBaHS7qKr9U6dulhQlO63Z/QXwduw8K23aUu5UhoPuXgVibFCf1qtIu7O6O9dwvc+Ce5Sdxw/PeWa6hpFjcIcbjFNnjzuPIfN4Ez0wRVFwv8jo/v3bLJ+tDBL+kr9ssFjfN9tAudyLy/UTiQTc57FK8aQkwLryNnXQE5EByFKi1DqgTljLjiuYXXDg1VBy1JfTXOUKekap5k9/gIYPXWv8eDHlCkE52H6fhYVUjTrZXTaIJ0v87NENf/xps8Hu+sMSEBN6II96qdB31USBOWXN32ZvCLcNXmPYMc0aFLwHj7cbQ6ZStyOdYQyRbDmytNmUFehl5Nj8vYh/k2m0h08Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(52536014)(66946007)(122000001)(8936002)(508600001)(316002)(71200400001)(7416002)(55016003)(9686003)(66476007)(2906002)(66446008)(7696005)(186003)(38100700002)(4326008)(6506007)(33656002)(5660300002)(82960400001)(54906003)(86362001)(38070700005)(8676002)(6916009)(76116006)(66556008)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oXWWEJfaiAsoVEK1Su2U8AVUpshcqKceQhDANTQ86rM9cQOH2hCUnEKXJSTy?=
 =?us-ascii?Q?itYtgllTg7ZOFlPvpP8vepzLefq3CCH/31pkKmC0VUYbcsiqUflWw5b/YY3W?=
 =?us-ascii?Q?OQAFT/u0bcTpGPWMZ/+50AtZsN0mk0MDeS7BaQYm3UC1hqeOVNfUJRO2UdDa?=
 =?us-ascii?Q?bdsmc1HAZJ6bkqHRQeENVTWwNi1rHSlwjrwjXicTlqGg36Hr6nHiZChRlM3k?=
 =?us-ascii?Q?V9skdKPcP1qrSzsBXLv7MiUu2eAWvIzD5gjQMeGMhXLaTuYuiYchFZzDIFBQ?=
 =?us-ascii?Q?EYtYRm9dGR9YFXqSc75uPoPQAIWVj7J2720uvWP+4uMY7Xf0TjMQO2cPiwGo?=
 =?us-ascii?Q?AEGk8aqGSrr5oZFspGdgiCNn9hQEaocXwjp+JS3nN57sdhBAYSJHeMxk2e9J?=
 =?us-ascii?Q?eUwYj23FM5yJ9HT+2fuMDz8Zkq0sYHaGCLKaXH/9ZK/MyaAmU6slwo9dZteI?=
 =?us-ascii?Q?DIPZnVpp6mLsyuNQ+uDqFaIWWCrNYzVVjcHOX8YtlmnVrWTyipTeJaTbPmOC?=
 =?us-ascii?Q?b/ivKta7/nJz/YrQvkvwiPyQqEvHXpXOoYngx5m4XN8a/l6chJVvuZn/7JLE?=
 =?us-ascii?Q?w8TR0kLEQH2bX52enCbSic1DJPsFeZ8GRi0St90Ke44JjSkmkvKFjq4Q25r6?=
 =?us-ascii?Q?UwUxh3doxCqymYm7RV83bJ8d1nKq2yysPIo1FMN9V3IkKGpU/Zne4C0uRtha?=
 =?us-ascii?Q?l82tIDHQLCQ+ScYOOySRg+4Qjn2U9MNKNQ0xClS/mqjYaYGYBAUfU08F1aPE?=
 =?us-ascii?Q?NxbqeJgHbsCpor3ONMrhAgTJFVhB2gJuTLDuaZyvlTyhlWucv24vSxmg2Ktm?=
 =?us-ascii?Q?E0V5yFfmI4xt8+qOTC5VGJ8Bm0Eb5CovhHpQdnlTtrvotACyk6JLYy4UkLn1?=
 =?us-ascii?Q?+au8wsyM74Z1kwXT3S3RFs1l6WUW6Q+c4IqS7c0rHpA1qTrEWSO47VbYkXVr?=
 =?us-ascii?Q?FKiJWlclwGkXRjatgiSGv3o3ZRDEiAdEByE9SobyURO+zoT/gSUW5HQIVSsp?=
 =?us-ascii?Q?VsxJdXNwncSTMf5Gd9seplbB2XbxDMXuN+LU1LM3ek7rJ0oM7DlEXsxo/062?=
 =?us-ascii?Q?6MLB/1zrLcViGMpShhdgw799jNJKNmI0AkI1I/1rXRdTPLp8pYj5LwUW5pWt?=
 =?us-ascii?Q?17KLWZw3ZXgtnXKc/1x3TxIzeoqWyMNcxZLsv6FwzmqZ1txpyDa40zk53klI?=
 =?us-ascii?Q?AlAcqpamR8pasGQQGgtfKmp69mXI4cAER7lUHi+nozdONvpD46bT532L/JVP?=
 =?us-ascii?Q?JvZMh1fYpYyTQlT/dgnlKx01DiXe7pNQAXMpMiOxZftZy0W0b87rvS7xYDP1?=
 =?us-ascii?Q?2y/TILAnrH/v1JfmXKzet2M8v/wamrpE/l5Eo+Q5bdc8JEy9Y2cT82QBaPBn?=
 =?us-ascii?Q?d2PhbQaTHNFYB3U3dFxd5++SrTJG+orqM/IV98v00Lr2onqKzRc+khRbxqr/?=
 =?us-ascii?Q?r9a+Dm0G4SegjTvOAJazmmgSrH8EAOZ+Ehnps2KBTfG8GawS8M0UYQy45GTq?=
 =?us-ascii?Q?Mcv63G6l8TGr9xyiPkmz4wee8UoGE04ez+TsDUmUUB4dZS5aeD+2TtqSY+lE?=
 =?us-ascii?Q?HLJ2welGLw+6B4zNtyMyWQYJlo4ZSUef2jbXJGIBOfnX0SaM+PRI1GHqi4eM?=
 =?us-ascii?Q?VvXdwpaRLP+iu/ZJloFyBZI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd042b15-e788-4e4b-dc86-08d9df9fadbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 01:11:55.4024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8e3zUHYiY8EwySsdyBBS+Zege9A6R69aCW0cnTGTfrYErIJLr7Uw+jwClBsgNCl2uM/fr8DQ4bsBM193FOBBLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4262
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, January 25, 2022 1:44 AM
>=20
> On Mon, Jan 24, 2022 at 09:46:26AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Monday, January 24, 2022 3:11 PM
> > >
> > > Hi,
> > >
> > > The guest pasid and aux-domain related code are dead code in current
> > > iommu subtree. As we have reached a consensus that all these features
> > > should be based on the new iommufd framework (which is under active
> > > development), the first part of this series removes and cleanups all
> > > the dead code.
> > >
> > > The second part of this series refactors the iommu_domain by moving a=
ll
> > > domain-specific ops from iommu_ops to a new domain_ops. This makes
> an
> > > iommu_domain self-contained and represent the abstraction of an I/O
> > > translation table in the IOMMU subsystem. With different type of
> > > iommu_domain providing different set of ops, it's easier to support m=
ore
> > > types of I/O translation tables.
> >
> > You may want to give more background on this end goal. In general there
> > are four IOPT types in iommufd discussions:
> >
> > 1) The one currently tracked by iommu_domain, with a map/unmap
> semantics
> > 2) The one managed by mm and shared to iommu via sva_bind/unbind ops
> > 3) The one managed by userspace and bound to iommu via iommufd
> (require nesting)
> > 4) The one managed by KVM (e.g. EPT) and shared to iommu via a TBD
> interface
>=20
> Yes, at least from an iommufd perspective I'd like to see one struct
> for all of these types, mainly so we can have a uniform alloc, attach
> and detatch flow for all io page table types.
>=20
> If we want to use the iommu_domain, or make iommu_domain a sub-class
> of a new struct, can be determined as we go along.
>=20
> Regardless, I think this cleanup stands on its own. Moving the ops and
> purging the dead code is clearly the right thing to do.
>=20

Indeed!
