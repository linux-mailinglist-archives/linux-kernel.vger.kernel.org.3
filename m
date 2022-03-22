Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F44E35A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiCVAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 20:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiCVAkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:40:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C0B17AB7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 17:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647909566; x=1679445566;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JmVNQB5VwzKnV87//7an0eYN8qmH6X5T5C4yyxrrnuc=;
  b=Q3ZNQLNLCgdX08WOqe5osrUQdOtf9sCmMTkY0KCpMBDEoqKxanl9M9Lq
   IEDPtGXg0kUmSIQl90OCllxQQD2yGm/+SFId4IuX8Zx6i7CcBoYiaYkJU
   K1wfsScgcXfsYu0bHxU+LaAKHett4TI7QQ2X/E1OiTAGzR1CKka2SvUBw
   XaLtsQ+aapvrNsWT2jrE3QXqMT6Kd4r55X51cnoVuNjJnZC+5sPz5r0Pe
   +TuqUzET4cPZYDVgaLPxcwbLnJHhF7mvgdYVzH7Wq8KOxyR0xHyTECtij
   sDPG9wcYrLiBw0PXxHExPz4YbJ02pQGWTTwjh/Fd6lS9pHyBGpjglwt79
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257633106"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="257633106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 17:39:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518652643"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2022 17:39:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 17:39:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 21 Mar 2022 17:39:25 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 17:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+GnCvCEI2oQcHcG7+lS+ybVqePa7MNuxVZeSeLY7K0IHZvSva3/JfDPgrjUtseMxKRr0A0wYk2qZZHx6so5k4rgVUscqYsDreLWyDR7uxvuXkYzaHsVgul95O6rVXWPbSGnnymNhJ9ZUscdWAj0Z4W2/SCm+Ea0PbrI14h6qnSIbn9gt0dGFaFENP30CMAZqA9JnOntoBR5irQ//ATlGs8jebqmepQ1KuEZgI2NRk6OJS7r3HqShUxSZsDlp7ctir5QnvHfJ27V7p6zPGtWjJl56oCULHYDMlDdqTgx57T6qRID6RbwmV4NpzBS5WKmKmqD/9NQwHQMbaJAbjYiTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trWqxF3KG/mLe0d6X9erCgYlTAUfGMfNQuxKKXqhl78=;
 b=XNvRyMPXZkt6XfoJGF+ZWtKT5dbK8HRDCZPmB0//smY+lVYwwq/bGwtZ2FTNewmFadeMQeUk6oxVkRz9uCe/877e9J+n7NtKQjJzAmg6eoQGpbi7tQ/+Ukq/yVIKMdDmhduzaHsHAMNEyOGDlLwPW5WVZFctTmWJRRFoJR8aS/JgVkAWyuLaUCh3MW1bgZ+IrBlUR1ewXozV3wyOV6YB+GUxCbvtcNEjZfnPmUAPz9Y8wauWx7jkShHZH1aaQXvLJbi0S2K448D32VsSFme4+2t57k/BQbqIQ46k7p0KH/E+A5HoRDNPIApyNaJsstJ2ApOuzlRVwFJ20Yar4CaCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Tue, 22 Mar
 2022 00:39:23 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 00:39:23 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 08/11] iommu: Handle IO page faults directly
Thread-Topic: [PATCH RFC 08/11] iommu: Handle IO page faults directly
Thread-Index: AQHYPCXDh2h0i76XWk2TXkPzYVpKc6zJt0cAgADZqqA=
Date:   Tue, 22 Mar 2022 00:39:23 +0000
Message-ID: <BN9PR11MB527618AE2998043E84D7B5768C179@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-9-baolu.lu@linux.intel.com> <YjhjCsrcTNDsFRwm@myrica>
In-Reply-To: <YjhjCsrcTNDsFRwm@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7b5ede4-d92a-44d8-372d-08da0b9c6915
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB421844C25C09F01716D5D3C38C179@DM6PR11MB4218.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BwVXEAi4HO3WaqMM1JKN9ZuOy4aHqexi9i+on3hAaDcBUeIeCgeXOohNZZJjUB5JWqHMRBWuRNWXSaHKNdyldE8LZUWx5zJTSd4jO5wMCytbWVdjZp+mldEmJa1yKNIl1kwpUfv+aTKkVLBh1D1CzVyieqCCp/k8lo0umPLIzpBslayTxopl0xk6sB+zCtYbKiVphIv0yrA+k4gS78nKS0kl9JfZ7xc475MAbq78sVW6YAVkmGAErXTv+CbVk8fFr2Ndub1f0RbneJhk4NfGzAIVD1KsfGH7OyY64haVCeGqMx4470PVabrzTPGBiKe/RI056qeSRODrU7eBX8SkP6pylZuWm5p/lKbJCPo1MVeNfSu3vXUfmoL7NVeSB8sySbmk1ybKaX9tJOry4mInrGgXuSCHMqu3W9zErSs3EMrQciBHowE04GV/Yjhp1AF6PeBQ98m5/qwgQU3kIgra74HbKzzxNCeIM5AfAxqWAcAOxCSZ75XYZgz4rM9Bb2pLpGo6OSAZZxOHOQzEGbO4aDkl84SQmJHHZz2K2SxY8WT6JotckhPcPkv9HVbKN0qWJddtETx9u3AOtRp2AYibfGTQHqmd7fmlsqZ1LfChos+Qpov3Rz3iqV4X2unqPjQfm7EfGfexO4KM1zH9AhAg6nc71v8tgVGrON2awx0NcmuncEZ1J3EoKyMALT4lka/fnN2N1nbU25W0mV8XRrvwsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(66476007)(66446008)(316002)(64756008)(66556008)(4326008)(71200400001)(54906003)(110136005)(38070700005)(76116006)(66946007)(8676002)(86362001)(8936002)(9686003)(186003)(2906002)(5660300002)(508600001)(52536014)(26005)(55016003)(82960400001)(38100700002)(122000001)(7696005)(7416002)(33656002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9pTiSbcu+JMTGnteWevpoef1vRAa8a3RgrZMxEEZoV5GZ7YU1E2bQGQISzUq?=
 =?us-ascii?Q?AoDEyT7efw5VI6TT3rsCHAw0tadTpNnh3k6wgx62f3DJAJzslfvzDfwlassb?=
 =?us-ascii?Q?mdNV7U6On7BKQQZkea+S1QW2xQfXm+DUv4LqzbMo3wsXlWWI94Gp0NIT5ow4?=
 =?us-ascii?Q?dgVv16iIpea2nCzlcRr4EZTE/pBj2JnoYP+HHF2Ru0GHZ2P9mzjG+e2I8ro7?=
 =?us-ascii?Q?p5MXHclVUYjqOMJSpmnAWYlTdAh9DCriC6wWqhtYfIuSpKbHPTLm28htGwFE?=
 =?us-ascii?Q?i7KAwm9rJILvtHLJkYRhnxSedn1vYSm+Hl71iJ+N3g87CRxZqnMD8Kv1jt/7?=
 =?us-ascii?Q?PxGNbJNJgcJi+UhsTTKFdfD1vOLTDK3f5nFEWSAKDwXzJzHHsyWUm9n+hQAw?=
 =?us-ascii?Q?ntWeoHxRmmqV642IRD7wc2uQOosw2hQCGfXJ8eyVJh7YWa5AzVfXcsUXurL7?=
 =?us-ascii?Q?JaCKvZX5Z/b7awFGFURDM4RVZ/v2rbLd10DhGvfYuS7JHmz+53yD45yZYRPg?=
 =?us-ascii?Q?A9llneo6Rsmxd3iY2/0ET+x2nBgF09xKEgf1qFDmJ67CHKtPSOmtxsIA9e44?=
 =?us-ascii?Q?7vrhAdJ9dXgny6KBIaMFFrjtfg9LpA6FT5uWH4N/BO0hPRQ9YrHmmf0dbVN2?=
 =?us-ascii?Q?veqqWjYnW8IpP5ilIodpfjdtZqo9d8uCtEdP7Kmpt0OeKdkp8ii52gtcmT9K?=
 =?us-ascii?Q?6eLmL51v/5zlX8RXT3uLZSdelt/jknghP/hwkfZa7yHb7zLGwO7+IgTyBuKd?=
 =?us-ascii?Q?UjrGFlfrvfOgqQRIUY1R+NfGp2I4I7ZPUVBg+jwEoSc8Tsjn0gNrSF7ciV13?=
 =?us-ascii?Q?XoI2XYPu0c3xxbR53IK1vuqjzfu/JVMOsAsTrQc8ha5bXIs46YpbsqUV3P4b?=
 =?us-ascii?Q?EfDwe6IV49xpnXNXLqO0XqbDYcV7Osj/4EgTHAdBZP7BqTVLSBByEzyYEYLb?=
 =?us-ascii?Q?G18H8zc8xMrzm6fYEj5VnkfNpcbtrJfLVC9gGCfOjlgJsoHDZwjhKNcR3ern?=
 =?us-ascii?Q?C/3SmZ+ExwXtF4N/CMfroQ11iTygKDJzPzZRRxkE0kJV/7QbReK7TwGVVqQX?=
 =?us-ascii?Q?uMP5vqsZUKfZ1zEsANKSpDCrKIEDiqPQVP/a8yNnTGm/52fxG3RX1fR1yg7j?=
 =?us-ascii?Q?T+raKVWaWLFs70Tnk6RbfmuRkxx+5LjA1XqXcpX9CCijcmp709rtR6lzEwnK?=
 =?us-ascii?Q?np7aLNt0gORVxMAdm6FlDUTbRcBAmp5YytqHTo8hjm/oChMHZsKjCrbLXL+G?=
 =?us-ascii?Q?wa3b6w+uoGykiyCmaWI6xR3hl7+wwhHQDjyR7+MyB8V95xd5XTTNKvr+hZkj?=
 =?us-ascii?Q?Bk+Cg0cdn5GJwGyVeFidaJo8b1qUP05w+VAeqZOeDpO+xoNTIRv7Fh/1Rao+?=
 =?us-ascii?Q?ThJWS/2O1knMWUh7UoK71HaYZPRe8rNmyU3ZUv4I/DUnX+opzWaLI7+xEG1r?=
 =?us-ascii?Q?0o39C04fqE5w8O3YgtF3vTk3WhNVVMBw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b5ede4-d92a-44d8-372d-08da0b9c6915
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 00:39:23.1367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXC7JDCjTvTAuHvgSMrvpwrONFRiSBWMjBILlJoBrbhSCrF/uWaSnwDAqZqr16Xpe9EnWw3NZ0f/4EpHoahEjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4218
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Monday, March 21, 2022 7:36 PM
>=20
> On Sun, Mar 20, 2022 at 02:40:27PM +0800, Lu Baolu wrote:
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index c0966fc9b686..4f90b71c6f6e 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -27,6 +27,8 @@
> >  #include <linux/cc_platform.h>
> >  #include <trace/events/iommu.h>
> >
> > +#include "iommu-sva-lib.h"
> > +
> >  static struct kset *iommu_group_kset;
> >  static DEFINE_IDA(iommu_group_ida);
> >
> > @@ -1177,10 +1179,9 @@ int iommu_report_device_fault(struct device
> *dev, struct iommu_fault_event *evt)
> >  	if (!param || !evt)
> >  		return -EINVAL;
> >
> > -	/* we only report device fault if there is a handler registered */
> >  	mutex_lock(&param->lock);
> >  	fparam =3D param->fault_param;
> > -	if (!fparam || !fparam->handler) {
> > +	if (!fparam) {
> >  		ret =3D -EINVAL;
> >  		goto done_unlock;
> >  	}
> > @@ -1198,7 +1199,11 @@ int iommu_report_device_fault(struct device
> *dev, struct iommu_fault_event *evt)
> >  		mutex_unlock(&fparam->lock);
> >  	}
> >
> > -	ret =3D fparam->handler(&evt->fault, fparam->data);
> > +	if (fparam->handler)
> > +		ret =3D fparam->handler(&evt->fault, fparam->data);
> > +	else
> > +		ret =3D iommu_queue_iopf(&evt->fault, fparam->data);
> > +
>=20
> I like the change, but we'll need to consolidate this, because now if the
> driver registers a fault handler it disables IOPF. We could instead
> prevent registration if an IOPF param is present. We could also just merg=
e
> fparam->handler but eventually I'd like to make IOPF fall back to the
> fault handler registered by device driver, in case of invalid page faults=
.
> I have a couple patches for this but am still missing some bits.
>=20

Probably we need two different fault reporting interfaces:

  iommu_report_device_fault()
  iommu_report_domain_fault()

iommu driver knows the type of faults and just calls individual API
accordingly. fallback is also managed by iommu driver if necessary.

Thanks
Kevin
