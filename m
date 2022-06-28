Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC63A55D0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343895AbiF1Ijr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiF1Ijl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:39:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3E27CE8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656405579; x=1687941579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J/4bNp6GRH+W/39Q73sGQuIA6nq7i8nQxr6xKD8nKd0=;
  b=TQ9exJlki5PHEmSbKWoBcsrGzqcA/oM7cn/6vmeZSa6QPAD/lqSctm2I
   0+xJgmWw0DOk5LLFyzrdTgtRi0+oODzHS5OSoOS5BfHFcVN0PZQrMnuQP
   JgaQlyBxQh7MlrL3SncpTAzrcM2tQrjDN4SMsbldKhSPywfXQ0g4CoVOU
   rIPm/a73uuDF4FoUgHnHfmFqC29yXltUgzkw34eJK4U+ExhiBSvvwIUqO
   1c3Qg10sYGg5bzsaDkqVGwR7w/UCyK0N/PgKRDBWukXhvnf1xAtTaJnST
   wlAvO2UMEKDTvLl8wyAu6nmJAfv7Xfw1mowXicIUbqhTOQwEOg1a3UQNN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307156445"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307156445"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:39:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="658045288"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2022 01:39:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:39:39 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:39:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeMRQ32v58tkFyBi1Op5oO1XQJbZmSZjNABq6j/Wk1jOsG7WykNOMg5rgZV7VaysgpOJvPjDm/iFbvxDHSMDUQsjkM44OJn1FcT5OiXIFEWlxk7I8r40VqYUgPWOtnQv3QflJVTSlKN3aAehTCCaDcfiPLpb6ZWVU+JhbM/YBZJ2tJq0mT83+mKri6JWV4p900nR/kYRa94afQA5uMwzjgrWi57o33SqNpdAllC29qAHxtXbFLtMd6K0+5ZV3+jfFjSit+Rvp5QBC35aDKJOjzfnD+SOzz1sqCB+/h9V2SSXCW3/U+GMJLlQ1VmspDc0NZE8Blb9oSP1gy+BLdG6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iM8vVsP8jjbIj2F1iLytFsSODI7WwLrrxLjr7LBVVo=;
 b=JQhzQI6+AL3NbvdBlKuCp4tKbC83PxvwN/iia6BoXAlTYyP45FPYSjhpwN2rpyo2WKpPWwJRyu3j4r2Z7b5aox9Eew0OacnE54ZWrxnywbJZ7BEGNNEXoDmvm710bbWunxXSuENHL/ncZiyB02xC9dfj56pQnEMupsbX9YFkuW7kihKDpKIJoU1UGAb3GZbUciPdxN7aVwTC31AMuamrg5pP0oChOgAgSvqJL99vx6fdqVT2IHvSQYTlEOfT1kT5j+KpnAh1+kZ5g5qF53XRILLc7lBuM01baPcBrw53zCicZWHaOQ/4r+9Tj9PzOsaT+f5auTnCe3yw4XGXsxvfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 08:39:37 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:39:37 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Thread-Topic: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Thread-Index: AQHYhX4HMU+DWWITC0iALdyeXsFzmK1kiO3A
Date:   Tue, 28 Jun 2022 08:39:36 +0000
Message-ID: <BN9PR11MB52768181B0EB29DBCB11AEA68CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b462f284-969a-4d77-abaf-08da58e1bbd3
x-ms-traffictypediagnostic: SJ1PR11MB6153:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4istEIRcQlVQTILW9FudRbe9qxAwhP8UYGBj0NiDr/VkWzH8wmw/XgnYt51JV8CTyl6G61wzBfOEvi7+l69n1/hpqfBepYdsSS4n+9ZFcHPG0NN+5yosF0gqXDA62HUMPBa1utxeymMkAR4LD2h6Od1lxh9D9ZCgTsqILY+FIUwA8mLXkbBm+c79ysFXcxOkFclzo7+jyNDbgjFQgNjzd+1+F5EYwfUAmhpdv7vBmhsUjPnjLsHMwdaeK9aT3eezoasLpZpXbLCcdkd5HIP8/yLyZJCXyzEi8jBw46fHAb0xYg1X/KQhvrTxjrz4oTe+DWfP+3M+/AFGIrsxYDTpwZw1jHChAsStvsbJMZR4ef2f4QGrssVrWd5Mt5kfuOM/gUVp5pNN+phiNXSu9RKSAD1K63qCT5BS/TY05/bLL0YyRDoDk3Q1vbQRH3CP1zhTEfUPlpQLxas54M3gwRFM25vHqZ/plFgRwFPS0PHegLEbZ+7MZDmikxqxxAGLpXHcA0199azVU9YRe7l4gRH4cJWeeibMbWUMHC3nP+FW/GmCJSYipUxAH28l28SwvbGO+s/4O+MrzPv2eWz/ufulRFq9Cy4qivAitJfhx6bm60FDfpfVxxLSuld3mihVB41emLluR79DXuDSDzbXm+wa8sbt/o8Y6LdrViIeCm4fQqiabMkcm3mPcJH1X7B+ruLRou2Fg2WCUpaH7ELjvIcLp+tnZmytCCL2UHf+Y4ezaTs9WSxIfkbl7YBfiUmfia9JgHeJiWTEN6gBeN2jhVgBv6kYi5qiz7JAXrNtt37Fm/AmawpM/C0wL/rhw/TEksZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(136003)(396003)(478600001)(186003)(41300700001)(71200400001)(86362001)(55016003)(38100700002)(66946007)(33656002)(66476007)(66556008)(2906002)(66446008)(52536014)(8676002)(54906003)(4326008)(64756008)(7696005)(82960400001)(26005)(76116006)(921005)(9686003)(122000001)(6506007)(316002)(38070700005)(110136005)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/oTwxbzQLLLeB/bRtPg46EG3cGxT4ptrO8WzeG0Bx1RGFr27LDZvvoQKDtvT?=
 =?us-ascii?Q?rg5KydXCcyB/js7wODoB5T+pEkfPvhHAqKO8qt0QK8BeV0IrYThlnFDHxwQf?=
 =?us-ascii?Q?HG54KxvoE4B2oSpc9LbwwNsrjY/sUdnOpr7pLjp76ZxrrTfiLLPeh+5Eu6fW?=
 =?us-ascii?Q?IyUuLd/nmyQfUVrKmnjffvcPRu99A/3Ljk5XfTakK7I3ETI/VFXdoMPtfbjS?=
 =?us-ascii?Q?c0PeXi6sIuK5MG2Hmmywxip8fLQM7uWFYDejMCbcJ1X7MD2yXAvnUyZtcjUh?=
 =?us-ascii?Q?iI5EHjaAi6r6rUdTVMSxO1KB40gqSQB+M9CCCH7czSWIBqKPuTxa14wCar8p?=
 =?us-ascii?Q?WNkKWcleLP/KrfolVtRgGilDVchlOB2JYvUOZB8X5jiI3zUf0eJNGknguITX?=
 =?us-ascii?Q?lVmRSXJvI/xezf3g+YPdo83JaRrAR2BTgXjky67e6rFVHBQ32W81OauVBaG1?=
 =?us-ascii?Q?RT+us18ps4Qbf9rdpc2dh3sjT4qNyZLo4CktYSB84A659jCZnW87X8WJ1rIW?=
 =?us-ascii?Q?JsMCta+5j7a+h1E8dNN0zao138qA6V4FbWv/qXcVlqZ2QmW4EzO2jP9y6R/g?=
 =?us-ascii?Q?K0TD5SaUujO8Ii3T1acS2q+pq9VQjOkPo6KgWIkeNkCFT2Rkp8EQo9iHDL80?=
 =?us-ascii?Q?+xz5RO2XuID7FOzARIkgLNvceIwQAuIrRbAkcYkOzoO4DeBC/Jz5fXyfQJkD?=
 =?us-ascii?Q?e7QebSRJ5RUzut8YqqjplwBd6hMV+3DXP0veFufyYqC08guQ/GPJ883UbTAa?=
 =?us-ascii?Q?TKqE4ilZGp/fcJbcVSgpjR4vOrfvNNiB6nVu1q4wen9ROgGFPayYX4rNp5ha?=
 =?us-ascii?Q?LL0weeqTL4raPnoAYw7O++m6htSrIq533q8QyAsnR9gQvK7pronSa/2q+HR/?=
 =?us-ascii?Q?iQ/9C1NmnGrqDm/KznLE0uU0sJN7BHKXcaE5qjzLTTfcS8qrKRCdvyL55zyU?=
 =?us-ascii?Q?w9bwVXVYJAXKiOO59AtSkbm7czySmo7+tvSzodd8yEaEqJAPdFBnsXwfa/er?=
 =?us-ascii?Q?nfYAfq5WAb3B7+Sq/0/TPCWbv44eZFa2YIg0jO8t0Az+4C7xelx3B2CWUeB9?=
 =?us-ascii?Q?WGnTSCWwaPdF+WqPMEab/GUPigFUAsCOvfeeZLaIjndWsBFBkM8ZP0+Ksi1P?=
 =?us-ascii?Q?UP6fLVXKTs5lYorAA/6LGioOVjp6ivHcdbo4dYAVFeWbSSIldQsvGTJT7WEQ?=
 =?us-ascii?Q?oUQtlXRndwWXSlsiZgh8bKdgLnA017C1G+Z8ZJ82TkavghMDdA6DyPqZvfiu?=
 =?us-ascii?Q?Tyo8/FM4eg4h0ObFQcLwPOVr7XrWZqNxcFOrzyhMUsTQB5EhbYwkaqTryOk9?=
 =?us-ascii?Q?YMVm5y7lKxbJ+VzqdCOcWOvrVzT8pr0233lcFr/lAQimyporfWNN/YhsW23w?=
 =?us-ascii?Q?y+Vwlqf05CDkuuVwP7po0PVGX5/xoOYYyM1KxhSAo+SMwtvJfqToNZl3NOfx?=
 =?us-ascii?Q?L4cfdebcnzrEQjrdm0zFTNUJU1gz2E+hWAMMLJ9ix+ocFEXd01rPUh0e7hfm?=
 =?us-ascii?Q?GoxltelK1JDH8rUR7ekz5Ikw2DVwFR5VrPam3M5CxRz4zAvI8/o2/zRpBzlT?=
 =?us-ascii?Q?2Wrr9yCn9CIm7CpATk6S/R6VVYIXU5UI9p6f7rkj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b462f284-969a-4d77-abaf-08da58e1bbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:39:36.8287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3P8xDqJCwFhFHg3a2AtE/rs09yMI/pbtOO1uHnpHqRkOfbfgobr5JXKUXWRs8VxrqOdb2fgrKHZ0UwauzQ9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 21, 2022 10:44 PM
>=20
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
>=20
> The iommu_get_domain_for_dev_pasid() which retrieves attached domain
> for a {device, PASID} pair is used. It will be used by the page fault
> handling framework which knows {device, PASID} reported from the iommu
> driver. We have a guarantee that the SVA domain doesn't go away during
> IOPF handling, because unbind() waits for pending faults with
> iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
> to synchronize life cycle of the iommu domains between the unbind() and
> the interrupt threads.

I found iopf_queue_flush_dev() is only called in intel-iommu driver. Did
I overlook anything?

>  static void iopf_handle_group(struct work_struct *work)
>  {
>  	struct iopf_group *group;
> +	struct iommu_domain *domain;
>  	struct iopf_fault *iopf, *next;
>  	enum iommu_page_response_code status =3D
> IOMMU_PAGE_RESP_SUCCESS;
>=20
>  	group =3D container_of(work, struct iopf_group, work);
> +	domain =3D iommu_get_domain_for_dev_pasid(group->dev,
> +				group->last_fault.fault.prm.pasid);
> +	if (!domain || !domain->iopf_handler)
> +		status =3D IOMMU_PAGE_RESP_INVALID;

Miss a comment on why no refcnt is required on domain as explained
in the commit msg.
