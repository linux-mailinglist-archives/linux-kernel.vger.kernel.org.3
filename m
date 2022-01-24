Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDDF497C86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 10:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiAXJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 04:58:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:22907 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236891AbiAXJ6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 04:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643018303; x=1674554303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pFHG41JM0nvv6a4TItM3bNI8xvbIjo4y2cQ0uX8UmyQ=;
  b=d6kz1kOdtC+tKNqfYsG7M80n/WRFePQm/zU1EBt2Cvst4Cm0sp3aZj60
   /zTRDwv09Qz5HHJEEZQgSBU8YiY1juW1kxiRAkd2CLVFS48PVnyOybOrI
   019OBfQ+andq7HtRvDIFLiiIZxpoZrrZTGT9CeHD27gmh7LlU1t0DPyaz
   sD4xeN58qCvjOdSqCtbtC9+iHY4opLpn8/dmZ59Eb3JNYWfpEwx7CdYsg
   zT6qz7xHbFwKQWp7SRyaLvlJpD3Kdl0cZZskKdrZzVLf5pNLjzSmFOl3X
   lZM+9owpsqSng0ECSgAyRVbB9pQ2j5Tryc/Q54GHbDiiL+9vJBwuo7QUJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245955534"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245955534"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 01:58:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="695368535"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 24 Jan 2022 01:58:21 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 01:58:21 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 24 Jan 2022 01:58:20 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 24 Jan 2022 01:58:20 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 24 Jan 2022 01:58:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtb3xApDkGBPuBQVnTgJq9+bRdfAlb3kFJ+gumTz4O7Q5XKrhtpWhsIJfmKpDfsGecnzRvCRbv/PC8DA16V/S2OVcoxLqRPVZJAPhbyh6VFM9oZos8fezHRB0eH16GTVLRqECqJZq9E3KlsNXaf8ByPh/9+/6g5Kslqxxpi7FRiuDo818P6jMRz5Z9kUaOVOGj5z0r8P2z6ws/jfF33YaYsnSfk1yT/cb8RtzYCFxGaxS8hXmrAmFx7mmMUlVoUVlkcIDNG6RwGTlLLWR24d7RPe/zcLYJuBxynucc/xPgfjdMlJx+GCmOI3YOJ/NqOVEd1zz+ZxyE2w0YcyIhnUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um0cfd+Dp6gHJ/rPGPUR90bXqhdqiMr0cyTORRjUz2E=;
 b=P10kSmGXS64FQ/ri7gAgbsjiyVTll7sBS9xqUxzNgftFlSR/w26J3CtpR25maGDB2PczlUNQ87EDaet3pnjC3fmebY3WHCmYIVmzxjr1+sHBHMjTHRWCxT3pBQwXacXgqRgNhSdfWCd7YCx1SndAtYgFRGRScMz74v4oYXaAkbxkJXyPludmBSKlfXho/s4sU71CsmXHnuOLnzIzvuGDTSJeJb6O/zOnFeI19xV2MTYv90v8T4kLKaUkiFqInYF5NllL2REri3snqi1ZlwrR9LsbFRlFm91K+8Oug5Ucg5wRPGciY8xaNRQGjivqOAF6fKkUXO7ZuXdDx4XMlgjdEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH2PR11MB4375.namprd11.prod.outlook.com (2603:10b6:610:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 09:58:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::e46b:a312:2f85:76dc%5]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 09:58:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Thread-Topic: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Thread-Index: AQHYEPHVdqbh5j+v9U2GKt1N4SJ4Aqxx7Uag
Date:   Mon, 24 Jan 2022 09:58:18 +0000
Message-ID: <BN9PR11MB5276BE30652988271878E78C8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
In-Reply-To: <20220124071103.2097118-8-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1fd1ea6-66f2-46ae-3985-08d9df200c2b
x-ms-traffictypediagnostic: CH2PR11MB4375:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB43750DE5083B3C0B7869D5198C5E9@CH2PR11MB4375.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwFUVrwp9ugH6LKJAS1e1z1/SyM828cr1OAU2f5XH1Fx7fDIruqKvg/QKRgyoVJ0rNCOApJC7bnqd9zq2bgwGr6ulrGE+dEW0iDwojz5UPZ+GGDZGA7Q5ikcQ1R1CmoKmyjgIG/NAGMWvRUSrtIIjG/RRNFpPXwHv9zbhdx2SX92IUOw4jXjcKCR7miYTBHvcpZRd6+5rRyBuVIgqxPWujtrLIueHvMoILRZKdH4Gc4+j7zjFCblE2pufFKO9eP5ldCgsmNGWYVZ3otvtmMV3uxv4jzBGLsFOgj/8PXlLr7SBEn2yo448OOx8HGQ/Tb35qAomp1KSAX6c6Y4jCJ7llnaCUKFekyLK92zIvV1mEGUuU/Pz/xhtbejnWFCBX1WqRk1lg05Ws6pOau3fTgf5YUJUHWxgaS22OEUGNWcMuRAqtUJ3ayUfhcD/A6r6ttPm7NHcIoLijQ1dPPhkafkuqMI8yCtfVXV9W2o7oboDG4k988fYAHt0lcVdGlvIhYJxM6CwBlM31lpITo1sVFfFE985pFI/GnFXTqJjjs+rs6ZNRblUpwHFHWPn5oiTJoiGyWf4tiLGYTDDWBs/UfVBTtwbBE/xz9MccpQLgCberfbawnqbP5XdM5p+Q1BoDZE/dvjOw0A8nB/bmHd+UFIteXccF5mID2LPp2KbThthIv9XV85Z2thmSivSDjofp6ADgDSQsY1lCyftgBVfGjGIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(82960400001)(33656002)(71200400001)(54906003)(6506007)(9686003)(7696005)(26005)(4326008)(8676002)(7416002)(38100700002)(110136005)(316002)(4744005)(8936002)(52536014)(5660300002)(83380400001)(76116006)(2906002)(66556008)(66446008)(66946007)(66476007)(64756008)(508600001)(122000001)(86362001)(186003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TrL4L1jbmZCj1IB82GfSzZXcx4BQZHqS1X+gX4uOAlmr1BNYcRCjkZ5laRob?=
 =?us-ascii?Q?GLZLPDR8TAj6tY4tbRoY6ZmJ1kAqoG8CIbMNRsH8O1XMhD3EXMRBxbDJGnIC?=
 =?us-ascii?Q?DqENXMqoxN9PW8ZyO1SAd4Z/SxNh5pncjVyiRLl2G0s8JWdpl2JifiJuX3Jp?=
 =?us-ascii?Q?aidvn/+7G/orhqkIUr4SivFil5vpG5mwNuBqNjcz4pcNQSWqog2QWf0hGrQZ?=
 =?us-ascii?Q?HnBt95CUm+YPCsT9Jmmt2wZC/UZJBTEGyNlFffzH41F85nsEJy0fcErlWVRO?=
 =?us-ascii?Q?NWI61uq1RQAQKNJWf43sbu0aUIkx2ndCupkoyUqJC/fhUeHecipi/COFJvtB?=
 =?us-ascii?Q?yt4BfaCml+Vqj8630pU6/v4GfecpZV48rWCZFNh8KkvlRWdfSQAx9LONerXz?=
 =?us-ascii?Q?nXIVl4gnHuhFAyIVAxzmuHDjr7O9k0QUWvCgljXc3itOOGEmOvT5uv6wY7zu?=
 =?us-ascii?Q?JUFClzvIvT1BI5qYoa8oJMrX8cxlwROdfOSXilwxL+QQjMbFUyfNs97AtJo9?=
 =?us-ascii?Q?5O4wYnL9hf/ye/vp4z0W1BaRdYPKhAPsfLgSnHcvjsQC/i9tUbydgx28rBiL?=
 =?us-ascii?Q?4+sWN/TQgOeHvC0TAwILhOown4fJvd9gP16qDYjk7rYuzvFpHU9yR8g8FZO5?=
 =?us-ascii?Q?bUp8289NNqCS+w6WU1dTDV6FEQ/orvptyi0UkFLVYAmAt07StNJtr1yqGw8V?=
 =?us-ascii?Q?Era8W7D35PHPqsRlilG3cWDmS/0OSqPWjen5VN9mIZKCl+Sgnh3EFfOUCWpl?=
 =?us-ascii?Q?X458/9g4vlBxYusn2xmisJFvQsGyv3+tjMYSPM4D+uz/k+MC0IM5wgpI5Ekt?=
 =?us-ascii?Q?30Q/FZt7qCg3sVSLNC0//n4yTkdpBzbWbEjs2UbIiS+Hl6v8NlUTOP3FjN/W?=
 =?us-ascii?Q?zKFs+HqQ/m+Czk2JSj++noEwDpiu5cw7LmAq4AR48olx/RG8jpr7NMw4KVNq?=
 =?us-ascii?Q?WuO3A7iRxKqzcMqemgjBU+gSLXycQmSxwQJ30REWPHv6IqbUaReABmjxmgED?=
 =?us-ascii?Q?JkoCHJ0NXSYK6h405FHyciAK93YIUiGAXKyHOXPn0Dje4TeD5lD4gAlvARVY?=
 =?us-ascii?Q?MpylASdkWdJP6QuTtYQprg0ie/CK6yUEiq9YKdG3s4agsGPzljmSKpQanOo9?=
 =?us-ascii?Q?UFwE8QFZMb+z25CEN1pAYlezOtPt172Eeza6k/70InDeF3rGle2gkEkloFxz?=
 =?us-ascii?Q?vA5XGfDCLz5v3xc8Ms/+AJYhP7RwX5I42m8uIHedjog0SeHYP5ioNOxFfC6D?=
 =?us-ascii?Q?mgdFyafs0cV/zMjGKHB7U37mEK9w8R0eWRtgb93oj475eiYXkuyNEmdAD77V?=
 =?us-ascii?Q?iRRT3doOkaXYz5a/LP22vqXItjUIAwUFh6a9+PCgrUzjlC+olIR6M6tFU1iN?=
 =?us-ascii?Q?xVNJhSS9vM34dCwGef0Y9isLhWQ0h5TWI+ZpLypH68o/IgFmWC7shvf8Hivj?=
 =?us-ascii?Q?ma+IKNxg1d/j/6W17POgif6oHHiaMfLn4ipvNorx7/1vG7pflX3GHX2JVrpM?=
 =?us-ascii?Q?1JUYRXf7c4V1NzC5IktCoC9KKyxFJmoQ6zdJe3TJQ51HYy36OMRoUvECXRjj?=
 =?us-ascii?Q?qXfFKq0B8vDNHznoh8fzac3J7PC0NYrXwLRUTOQ7HvoluRVKcqjh5rTxDRYQ?=
 =?us-ascii?Q?QhFKQkv//8mGeNeF6+7sa48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fd1ea6-66f2-46ae-3985-08d9df200c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2022 09:58:18.4948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cs42OTR/EKlqpNF/omUW4KV3g79fFljV13w8BKqoLQYXsV5hNRKBMJDipVpheaM6ug461yk/DqIGeSAs+jVcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4375
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, January 24, 2022 3:11 PM
> +/**
> + * struct domain_ops - per-domain ops
> + * @attach_dev: attach an iommu domain to a device
> + * @detach_dev: detach an iommu domain from a device

What is the criteria about whether an op should be iommu_ops or domain_ops
when it requires both domain and device pointers like above two (and future
PASID-based attach)?

Other examples include:
	@apply_resv_region
	@is_attach_deferred

Thanks
Kevin
