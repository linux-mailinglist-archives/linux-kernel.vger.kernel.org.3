Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9450355CEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiF1KDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiF1KCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:02:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9702F392
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656410553; x=1687946553;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CyEV1J5GbtPs+Chu/G7NQwqsngRcvv4EZJW6CwrEOSg=;
  b=CXcLWcB8UFEfuwOEGmqZB7imqEP7JA9lXZLSpm/6OqxhJiWmeqkcIPwb
   IB8M2PmfTNfPbLFv7XFdl05HkAZwffVsC51tWsGJsZgf0pUXZIlaozsri
   bNlXf9hCZZc2iIwAO/3koG5hrgXGA2Laqr4KojJjk2d2k8FHBf+n3EYWJ
   nCSo99vWq1C2XlZbOcrp5uZHYJdH+YJ0qbnBdWHdwx2SxpOzJSHmD4QtV
   3PKlkcGDS7kzDLs9yEkNjNdLE4Z23/Svkq9QVSSJCkQcbjIC6GKUKW3ZF
   gt/SEQUivkos+hDPnv7wQGBnD7Gl3o+9PI5UIaZ6iKDHDi6eW6j2O2ZSm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279243689"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279243689"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594729411"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2022 03:02:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 03:02:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 03:02:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 03:02:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvAexC06vH/xtElJhp5hXtZK720Igdgeyfj1agkL2CONgtZYeMD11PZjOOYsRleTYxnGp7KF/OPNNB//FBfYTQjp1X+52vBkStYVckGPS10otxga8sT+eYp9lZ4B4ECAQrvg8d9Fi/DsNxiE0NkNHrFc7xXhwW1pup0CeGj4A4EjyCIeI7/rXZKbJd0YqGuRENfVAfVffYdAShFrW2CQKq5MN0TPsyFwv0IIB7/n8poijwevFYL7zk6aibVt9lc3cl3eJXmAt54ZZev1/qZ5H8fH6qoF6X8EnRY3ShkMEizB3nO5GP6uLrFMkEGfwd2hV1umMNOFbzPNqgCFVw0BCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyEV1J5GbtPs+Chu/G7NQwqsngRcvv4EZJW6CwrEOSg=;
 b=PAzc3l+uZt4x+YYMZLo5HtAVwidfWS04XxzkwZUqDvUsCM5NVKB1Nzzib+j+1dH1lJJMqcvZQzsTIO3PYUz3HQOGDvZYNQoHfCfEz5bO9zm+fIuTZ5FaMSw3P/RIpEaGdkJVHWAp+XcfIDcZtBhfTIyURhOyhnskawh8IFc57dTmmlgnb96qB8XhkKZS7K5KB5WYKMXojHhC3PeT65XDikcuWhrdkEX5c9+kiSYSEtEy4HGiLIqD5D3qMRGS4t4eSwRt5h8fU7dn7K8wj7Jt/gOSMbZs3VwFUeQDF8nvhfVQqC7dUhM0XX1FrxsRqMRcrIBBUesmoYmuBWSEc6m4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 10:02:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 10:02:01 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Thread-Topic: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Thread-Index: AQHYhX4HMU+DWWITC0iALdyeXsFzmK1kiO3AgAATUgCAAAQ3gA==
Date:   Tue, 28 Jun 2022 10:02:00 +0000
Message-ID: <BN9PR11MB527605AA0663E8BE592898FE8CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YrrNarTWvMydIDwQ@myrica>
In-Reply-To: <YrrNarTWvMydIDwQ@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d53f580-1957-4a95-96f5-08da58ed3ecb
x-ms-traffictypediagnostic: DM6PR11MB4740:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tY48eTyRezXlxZEVrnF38as2H48tbzA+heIpeeQw82abgriQX4VWU0z7AtFJT23z85hlAEmwtrDqH0Ns4m6rfNgAglv9HhUaBLoU5mvux6409P+5+z5QSECY9fOFajYcAk/++nrVgs8Yr4fTDpZFekd2KKgeZT9M1FX9Yu9inf5JOCEfowx4MfvnPQYBK3XgHF3EHJp1M+YXjFIdI7q8AQZg5aTF2QTv/mIQai/X/fm2597emj4Lumh1zxHsmXj/inxdNzs8ItTfIEf2btiqs6Vqjp39kjsgiRByllZ0wisft+wbQIgmtSKTT0hR0Cy885FQbZgmMAXxoCdVgvKM2QsAe7EcfH3aYSoeUVwP52rERBkZATsXG5PU0TJiwc/7Jo5Mf0wD6ohUljQ0dfaDPjU9IDD6iCS4r78omNGcubpO9wpKXZLxfsVFQx9S+2eh4EPGUKsDolBOTnx6d7pDKBysn9SfnKHhHt0tFiqXofbdpU/OOx9izIPL2cleydSUEukyf6MODqCCD7+gFG2BNwcgjwOfd+Nnhwo/jwBILc7EtDznbr5ocfgKNWRugQ80mGs675eBppaA+sfgxVOyhwkculIjcP3JGWIatNI/pFOR67kdkqrjkOyGQrF5jd7AzYbUthB1neM782no28exaUGf1HRtHkC7P1+5Z/V/SxB9BHtNqlU4HC9g2lAd+UD7OU1nFCrUlwQtHjuHaMzTIY4WE6xALqCjZh/OfBcpEZCj5SeoXj/d03egl0/v78sS2Jphbx4wxa0LUA+2ZR1RcdIqLnt4aOJe50gDeR7iMO4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(8936002)(86362001)(38070700005)(71200400001)(82960400001)(478600001)(5660300002)(9686003)(6506007)(52536014)(4326008)(26005)(186003)(66446008)(7696005)(316002)(41300700001)(66946007)(76116006)(66556008)(38100700002)(64756008)(66476007)(54906003)(6916009)(2906002)(55016003)(122000001)(8676002)(33656002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qfj1+ITNWFWVRcV7oH8uTuNtp+llEZdm/0V/p84pvArEziIW0PXI2X67P74W?=
 =?us-ascii?Q?8ieHMAl89rzB3Dyb/6s9PzbXRCHo6Ks7/PLNwnyg3tnS97uuk5k4e16VJtYX?=
 =?us-ascii?Q?NKP6qOXRYNoNhtB1SLcf6JzgGZuqouVokq+ku/1Vz5e65ZJHXOMg+IEdHsTL?=
 =?us-ascii?Q?l669iZbExciyvepDQlF33I9S/zMOjF5S/VhjxW0ePLeJ7S1SG2iQyJi+Le77?=
 =?us-ascii?Q?Xk8VEdVgWMcbiZaX5L1t71YTnXP1TOH5aw7tUF8P2ZRKVWL0Red1sB0Ig8dH?=
 =?us-ascii?Q?8IjiI5z6w3C/Q78WggT4xdL+32OTsNELNLLrSZqMpaTtITNC4tz/IZwT7/U7?=
 =?us-ascii?Q?nz9GsoLFeLeE5dRrz87ycD5W4i+Z8ABJg/t+OE5fsQzGsLnq9b5sY5Mj/LAl?=
 =?us-ascii?Q?zb3T+VP786TwjjZ3C5ntPXcIW/6ZNmAba6oV6xetHdw91AonD8sfjCFPAC/J?=
 =?us-ascii?Q?IYowmEez8FRlHmn82phAaJ06tNyQQUwho6REn0MNqmAjladrUb6t7ZTQNfsd?=
 =?us-ascii?Q?kKZHjQpxJve5ACQ6ba2rh+jun4YyGS5x33EgvtMepqJINXQRBnIQc4bfb8Qt?=
 =?us-ascii?Q?F73bDHY04NlKnRHlokSb0/l4nfzp82UgNQiNPJo62cYX076UI199VaM9aM4G?=
 =?us-ascii?Q?ZFWn3m44m7LhASjDYPTUuHvo3pnCjeUtTKiIx/UpMuRfmgbS1LZDq9vd3ExF?=
 =?us-ascii?Q?TVG3iov0Ly+QbE26bCBwk7x48+WJ0RtALUXFSutQgN2TC+0nkAAH4RSva7I+?=
 =?us-ascii?Q?KrqA02cA0y4F0cPmqqwsSVnEthRj/6EQhq13l3XV9lHyI6n3QNJ28jmec9Pt?=
 =?us-ascii?Q?reRQx5a+0I2XYRwsdagCjh+zcJbthVSRIeMA/P9SKGO0OxBIbs80w46KRHjt?=
 =?us-ascii?Q?fm97mCK4atkHg96C+CYwzS464U944uYmTrLShddiL09eKT2/bOUJdj2hTCbh?=
 =?us-ascii?Q?R4hwxM7d/JTNmvR2n2/MGf4dmU0kRgyTXSljMqFg4SX124c6E4UKD1Rk3kme?=
 =?us-ascii?Q?Ta3+i86krEWg8F/q7xZBUIj1tQ+VEmi9TbEdIpLnEpoWbH15ZT5QaLZvEiWe?=
 =?us-ascii?Q?de24S7A+Z26SRdRAuIBEBBVjI8ol3wof2zI20sEcmsxq0SMK3U9MHcwsdMBx?=
 =?us-ascii?Q?PQonFEMwm1Pnndh//HxR2jM7N54KnSbgmiJjDyV28MCyBnN6deT3lUsvI0W7?=
 =?us-ascii?Q?i5YiGLP+0AylMhr26fZgKMcnbV+BV8huCEJDCbi5hAr56zcrCz3PE2nF+Xam?=
 =?us-ascii?Q?vvwIucJyCKg8OMJ3SQ91t8GHL1Fkgniqeda6RhjVb3xm6ewFtlPMAWGUc+pJ?=
 =?us-ascii?Q?2m9Wa5UUK7Fn71FJeee1A1YMzKXxqU394y1es8rfJbKPVgcKMKw3hDSQmow4?=
 =?us-ascii?Q?MO8Q+bHl4CE0fVK/DpCc6admV/CAyKZaQNZ3kWyF1u8//RCofBYTT/V0jh3x?=
 =?us-ascii?Q?venYRmPEWP2no+Cw+dOHyLuB7TMlXM6F9urJrEkmlISgsy3Qu2kv+srIbyAF?=
 =?us-ascii?Q?r+6d4VlI2l2J3YYMldVYbNywhGi9R2pNMW3OFMPvFNO65wiNoYWAif+r6jth?=
 =?us-ascii?Q?gX0HzqBsm67pKsYUEC0Y8yXNRDUoSJ+lM7XteKsm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d53f580-1957-4a95-96f5-08da58ed3ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 10:02:01.0057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhruxJsMyA+EDjTgD852OKGfmWnZkpFNEAfxFfYDvH48v6WQ1b+wVbjuAvbl+9WpRdCglVIq75UsPghvURTizA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Sent: Tuesday, June 28, 2022 5:44 PM
>=20
> On Tue, Jun 28, 2022 at 08:39:36AM +0000, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Tuesday, June 21, 2022 10:44 PM
> > >
> > > Tweak the I/O page fault handling framework to route the page faults =
to
> > > the domain and call the page fault handler retrieved from the domain.
> > > This makes the I/O page fault handling framework possible to serve mo=
re
> > > usage scenarios as long as they have an IOMMU domain and install a
> page
> > > fault handler in it. Some unused functions are also removed to avoid
> > > dead code.
> > >
> > > The iommu_get_domain_for_dev_pasid() which retrieves attached
> domain
> > > for a {device, PASID} pair is used. It will be used by the page fault
> > > handling framework which knows {device, PASID} reported from the
> iommu
> > > driver. We have a guarantee that the SVA domain doesn't go away durin=
g
> > > IOPF handling, because unbind() waits for pending faults with
> > > iopf_queue_flush_dev() before freeing the domain. Hence, there's no
> need
> > > to synchronize life cycle of the iommu domains between the unbind() a=
nd
> > > the interrupt threads.
> >
> > I found iopf_queue_flush_dev() is only called in intel-iommu driver. Di=
d
> > I overlook anything?
>=20
> The SMMU driver will need it as well when we upstream PRI support.
> Currently it only supports stall, and that requires the device driver to
> flush all DMA including stalled transactions *before* calling unbind(), s=
o
> ne need for iopf_queue_flush_dev() in this case.
>

then it makes sense. Probably Baolu can add this information in the
commit msg so others with similar question can quickly get the
point here.
