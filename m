Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30214B7ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344386AbiBPDp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:45:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245547AbiBPDpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:45:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD314D64EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644983136; x=1676519136;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rpyCN69H97YohwYB1+kzzau5J9gH/AWUkgBaUwrHAvY=;
  b=JTQcM/IDJ618mA2W47FIKb3bE2SQI+y65CfjiBUF3R+58m5bE/a/pZB6
   sn+fy3hZvEb82tOphdWhVZPG6aMkcz5muuiYRxGRkw8NNSWSMT9iD7gWH
   zgz7zxq3i0cOAmtxcfIzID5AEdqAfHci3GgLfCg/Q5pIz8ZXn9dZ2w2Yu
   mLqF0uxLcEKuDNKJ77TPVLqTrBKxA8yyuxGDoA2SgZ6R3CeH7i5HDT7Jq
   ewk1HI7VJ97KK1S6EstapV/My0urN/lYnY9QJTmt+Xa/jiiwQBF7cKMI2
   Tb3QbC+frmOvUPBg9dwWyRLFoZJgPcaOmwI5uSyJidBrs8ESdyY9Mtd4b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="231142657"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="231142657"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 19:45:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571108667"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 19:45:36 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 15 Feb 2022 19:45:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 15 Feb 2022 19:45:35 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 15 Feb 2022 19:45:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyUScU7QtduFMVaxE9ckAgvJIaeezniLcT+gXX+qivUKVWNeD/YRP2nFYaVwWmelIdkws+LYo18ZnogqESVAo62ZVtgaBpF3hn0CtLXa6hsXEPhQj2PcRioiiKYgTCh/PA+S6edguN33NjMCfQ6LsHjBK0lPwKiz42GIUSNDeUhCR34NRfEINXcNooGOK1TkaCLT4H3c9rKf8C7QrR+Uz2fk6GTvlXaQZFGItTqNhkV/xXLRxNHDF3dOxzRGIkq7udW+HqH3vMXt9cA3556AErjnFvG0t9EViIhkXT86vHcO8Au5mYs0e9qSVRPV7iW91ypqTIdp9wOe5nY2utXLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpyCN69H97YohwYB1+kzzau5J9gH/AWUkgBaUwrHAvY=;
 b=lhopHcZyVwX1yu9463cug35BSW274kgXc/gaYNAH6cyqWEu9BZMvm05aoKARzLGtF3hl5m8rM3CDlNztl20o8jqJWVOgegTdrDbcZVtDhBqWFwFkS0iTVeuuf78zbe+cPA4CAI1TVET6g2zIupDvmiiP+gLfALVa0mTY62k9KGOzZZRaWQaWJHfe1V9FtsZ4hPfpEj5a/k3ecrujZap6oBQTia+Y0gmGT+ffH0VIx6qT/lY6lar5pSe5qmVyRauFMtFrRK9KLWo7nGYTqRPvlQUCeYpxA/TAUfRQ25gS3GtT4u/TLB0kpEgJCGnMGrc3vDlZFPo2pw+96zrMzkZ82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Wed, 16 Feb
 2022 03:45:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f514:7aae:315b:4d8d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f514:7aae:315b:4d8d%3]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 03:45:33 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Christoph Hellwig <hch@lst.de>, Lu Baolu <baolu.lu@linux.intel.com>
CC:     Joerg Roedel <joro@8bytes.org>, "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Thread-Topic: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Thread-Index: AQHYIU7XPuQ1pkWoHUeQpg1h89xRqaySp/UAgALi46A=
Date:   Wed, 16 Feb 2022 03:45:33 +0000
Message-ID: <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
 <20220214073424.GE17411@lst.de>
In-Reply-To: <20220214073424.GE17411@lst.de>
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
x-ms-office365-filtering-correlation-id: 736baab1-c928-4bb9-f976-08d9f0fec8de
x-ms-traffictypediagnostic: CO1PR11MB4769:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB4769867547500DE67BA6D0A18C359@CO1PR11MB4769.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TvXMoCCl327lLKKNczAYHbVP1PWdBXR0Eb+2VRSS9s2oZgFcZgjsRCiciDcEKVCIieIDpo5YO/h1WL7J+FqNwDVkcs7Zo2B8ez8knOFaTWerQmJ3hRa/erOG248IYsk/kasCvQvsNizB1cog5i/T7wIo4TZxV/pTJ7zk5/oFEaZL9xg2y1OTLgqQjHOKY5Kl4sGJneAsAL28+xKBoWlokch+gF8HKr0C4IpIvmwgtVL/2JRm6GB9eVtbeFpPs726eiDdOPn4wdINFWDjRR78T7UfQAlWLemDqHXTS9VTnW5mrf0Ix46GFvPTrs+5A1UhspjN7wxlDewRPm29Hp8Kphk3ajJ2TZ9rmZNUSAAL9Uf2ADfWM7nCLXprD3A1WLzYN2YVENOG/psWkrxefwbX3aYee4AhtiwoTSTxn5nGGnMtoqS/s95NVDWkcps8Pq72ycwTJ8qV9RnVXuji7g2d3HQDTXD9o9eQadpjRTg/l93+r5gaK1JKeCL18ezLo0yFsG/zwDncxiVke6rYdXGP/uv6Zx8LkyapJXUVQF0bHGOuMeu7/h+9zWxPkI7iTtZL2e8uHkairl3lviv5AbSMHpP5w+2o7SmMdDZqnnNbFy36OnojIlpOnIjIS1+C+GFP/h5rZucfjcAuZvyakrTYOAFHPPV9XD1LLystNQq575e0axYCvkQSPEjWSjBzaqazZaJQTMtbCWakIgvJl29u/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66446008)(2906002)(38100700002)(186003)(316002)(38070700005)(33656002)(54906003)(110136005)(55016003)(86362001)(4326008)(7696005)(52536014)(71200400001)(9686003)(66556008)(8676002)(4744005)(5660300002)(26005)(6506007)(508600001)(122000001)(64756008)(82960400001)(83380400001)(66476007)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFOzMflGGDO9TqGukzN57gvsKEcpnLA6yKGRnn0OKnZownqpdOY/ZqUBSW/y?=
 =?us-ascii?Q?vr5cAbKycM3p08XsRiGYtoS6j9ptAYsQoOQrb2xQXjfIrY2c5lf+JaNNBHOG?=
 =?us-ascii?Q?CWcMXe3BBeMHM8L4IxPKFbY/nnc3wcK6Y3JJAsTWIIK1PbnAnxWPLylVL5L8?=
 =?us-ascii?Q?TgpNfdlbgdLyIclAeHfoe0ohYedt4oPoo4GDRjI46DLsugWcQMU/MKsszQP6?=
 =?us-ascii?Q?txumgHwz9SAqb2wRbxToHiOCnuUl8uJ7jdU7/1zIH0Jw1hJYOjOG2PvkXlae?=
 =?us-ascii?Q?ase2jP4oWW4ELB1YPPS15ImKDcMWQALgww1nDXv6kT2PX+mHXzZwmuqTZFmX?=
 =?us-ascii?Q?MEDkxMzmyh5PJjMcPu7IxIeIJtelfC896czob3+RAEluezWrO6nwibpZoI9D?=
 =?us-ascii?Q?QKlkYVGUJhck5zjO6AVK1EkrE3gZn+Dhq4sVgyhLSz5TZwNLeEjFTmxmVy+6?=
 =?us-ascii?Q?DGErzrZ9lSFpnHGktG5AmY4FuXmtsxDHIBkjDgMxSmweTpLquIUzj9jSiDv0?=
 =?us-ascii?Q?na5Bc+OV2/Kqk/1rc81XD8NTRUn8r5f9aPFfhQHAU1kUKeiMe9BeIzyKzbg/?=
 =?us-ascii?Q?KJpo7H3PCL7LpSmqof+KY8JNFy84qFYaAjEkjqwxE9Nq3P6cXQ6dNE1x5GKb?=
 =?us-ascii?Q?JnuJ7Tslzhvq1TSnl2v3gzAoW4bqQ2lztciTLOF730sV2YolZkmO2EC+RABl?=
 =?us-ascii?Q?Wk6K1k+k+LaynikjTMb7v2iJkQ9AlfgdYf4Xh6oRNJ3NXYQCKNXwHsji2m+/?=
 =?us-ascii?Q?pM4Rke6GdCRvHRtWf/vZnMXYXYA1IYcnZalsOLqheyFlAnBE/dSbh8K9JNTG?=
 =?us-ascii?Q?Wvq/9ugWbRlXbvAE5PMW7uP6uyuAzNUgXXLtig9Kq58d9wzXHrkAyZKVFjUr?=
 =?us-ascii?Q?mDsRAOIPd3FzSS8F6Nk7LmlWSnd4OgdMvHDib8lK6Z75XrlDYhnUWoicoLyY?=
 =?us-ascii?Q?vHxDKaqtUAhJXujmCSMbTocu/zlUPPH6YtmwA5/QizdfDQ916tAz2oZiNoHo?=
 =?us-ascii?Q?pfmvUC10WJdNINar06/YjpLBN1hxLEZySFOSohG7/eK2iym5OPFqdzBxpkMB?=
 =?us-ascii?Q?b4AKLzIMhKj/iLlhrmITV/GqHfd0WjQEHuK4X4FthtPL5FvfNar4oJZfSvOO?=
 =?us-ascii?Q?VW0HA6PGKL3zPh4bpPIvprUhTXWXJk0/qeECU+GZ/MU++YxbzZc/1OvElM6H?=
 =?us-ascii?Q?tp03p3VSRXoFLxa/zN9DDDWLVwVmtgZ4orHdz859FTknNgMTrAN/7edc6PQv?=
 =?us-ascii?Q?7/SB/CFXKmtHFnRprMyCOuWk6TvZSHobRg/LWCyXba3yzMzEnf3alYIxsrkD?=
 =?us-ascii?Q?pdTdSOHmwR9+Ts3JM0MtgHV+bzVrTmWYDSavZg1e7qXK8DpbuC4B2EqG81gk?=
 =?us-ascii?Q?7RlpeTZ5rcjpHAB4ibBWozLCzhbaaqQp12GX8BgBasmu4xNj2IFngMOS6ARD?=
 =?us-ascii?Q?vay2SjG0ACBJNQvFEHKp4RrP6p+BMAIMsDDcFN5ilfT6DS1LLf8dFVfpMT7N?=
 =?us-ascii?Q?2Ny1rGwJmIPJCp07Ky1GXiAJ0jF0bpI/xiR3TklLmnX8XvnEVan5aQVxltfa?=
 =?us-ascii?Q?w9Ktq6PoaBR2QxcgPPVn1mUFfegxGwYx1NEGSYlrZ0dMB36iR/oS0HXMz4Ig?=
 =?us-ascii?Q?UwdubEb9HlR3zUQWnzUx/Gk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 736baab1-c928-4bb9-f976-08d9f0fec8de
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 03:45:33.0944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPizV+Y0W7lDRMX9H+9dv2jZgjirLKTzcuYWdTfq9xqJ7kv7UTetXsk3t5bO7wNQueV+xZihO4+YGFVvWcFbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christoph Hellwig <hch@lst.de>
> Sent: Monday, February 14, 2022 3:34 PM
>=20
> On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
> > This removes unnecessary commented code.
>=20
> Removing dead code is always good:
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>=20
> But someone might really want to take a look if draining makes sense here
> or not.

Looks that dead code has been there since intel-iommu driver was
firstly introduced in 2007. I don't know whether we can dig out
the reason (Baolu, can you have a check?) why it's only special
cased for read draining but not write draining. I cannot find any
such recommendation from VT-d spec.

Looking at VT-d spec it stated that since VT-d major version 2
drain is conducted automatically by hardware and above flags
are essentially ignored.=20

Given that possibly a safer option is to always set read/write
draining flags before version 2 and skip it after.

Thanks
Kevin
