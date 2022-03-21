Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1434E20EB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245737AbiCUHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240782AbiCUHH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:07:28 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CCA4FC5D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647846364; x=1679382364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fnPY7RoWk2TpjWwFFUbJHZn/yTyPyuP7rCAPyh76m4U=;
  b=k4HW1F8kf2hcxMNrhDEgwMhptPrcS5belpvNxObig0+rmyBgVX3ab/ji
   cTCjhVWjlcFxF1xptuhQ9sLzvHMASjP2UST9dR7XdiJL+Gx0C6NeOUuGV
   XYGalJFbkcBJzAQqcouaEDI3FdqrMHpohkqBOe5W35GwXFJuHJt3lL0Nv
   5ncam4eLlHv9QlSKZorKtesI1YASbl85+kFrbKNO4FYg+Oj1573VIn2Sk
   IiRkRgkMaJgWpJZWlp3liMeCfjCOJ0HeQyOaRvY5WSok928Rzi+1Phr08
   9qd7zAI2C4hVN4ykLf8+sNSn1mLSqzN2yrQahOpx5JN9JRuvfd5tGBXL4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="282310087"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="282310087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 00:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="648457164"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 21 Mar 2022 00:06:03 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 21 Mar 2022 00:06:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 21 Mar 2022 00:06:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 21 Mar 2022 00:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpOdLN1K5h9+GR9pAkQv2/anfrZTdF2jN1qOwi/dGRVZIMtT/HodmG78ZTQi4Pi+D8lVDo4r/9WWeqi4iZ8CXQRtpItKXAJ54KCNoN/KUtIK5lOWAOWo6U1izxS2IyKBAYjSst/MblDgqHPZ6OxnlayVLWTheOkAYLPD06xHLC3qvudkQExxJlPS07nU+F3/CggGdlG452kTFMy41lEYPkNirkMdUTnpHGkWAQe9X3wDbf8tMrN0TogHVLU7U+8jC/uU9WTliwu+LRpRligF/IYInkUWMPfnDJj9hOcwmsmUcgcquYHa8sWByLs/2TA27dqgL4AeXfY4qafu43gJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sGtND4vdm8DpEcoxq1vaCoEb2cF7V6NCsr62C/r8T8=;
 b=oPvdIjX+W6ymlQ0tiNbiO9hJEs3L+hVPklujloNej1rMzHAb8tQgrW4mwbv7R73fHuwTP8rQUup+9msf2hiYeikc2NrRoLum+xgnlJgGb6XkSzSriwtDJN82U2D+zsGIHCBtTQiJCX02Ob/0dd8Z9vtgQevzGWevC5eoF8k/t5VqqS5W0GieDc1THrgQKUVR+SWqzytRixta2jx/kXI9GTx6LZwzhCXa/oempoUj8Ztthjx5L3bXpS9CYz04WV85sYID6KYLbEoFn4wBx5MKznf/os6dfJmvf72dkR8GkZSwStHvPc5hV5vrHxBKhuEmjToqITrS2l2v3PXwQB2M+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SN6PR11MB3150.namprd11.prod.outlook.com (2603:10b6:805:d1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 07:06:00 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::b9cf:9108:ae17:5f96%3]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:06:00 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Thread-Topic: [PATCH RFC 02/11] iommu: Add iommu_domain type for SVA
Thread-Index: AQHYPCW61M+FlaY950Gbzywu/rgd6azJa2rg
Date:   Mon, 21 Mar 2022 07:06:00 +0000
Message-ID: <BL1PR11MB5271E3ACDCB85F1CD92797B38C169@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220320064030.2936936-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 325514d4-1df5-406b-e783-08da0b09414d
x-ms-traffictypediagnostic: SN6PR11MB3150:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB31502EE51D972FFDF07425818C169@SN6PR11MB3150.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YpiuC+DTRVODKxxojpF07fxs1M5yC58wY5K3gGjOlkmkpjsbJNdrGoWZCg3OvpGp0bR3MX1oQAKVHGuUvOf300IvO806377gI0/atZQ64yWPw5D6ZVtu30LZhUVjE0WL9dyLxwYaTDYZul5KH76Gbg+Gp+UyelHlHuoLbsA7A8R35OHM2rrJoxSw5Nn0X0WbmocqejaCr0eDLUCWoKIxyme5BVEoouw7ABFP8xjtqpoIERqR8AupOLoLlevzMrnujVbgiUhRAIDSCiwy+yd30uOEded4vKcPccj7rTBz7hAaC73kdKh+1cXvcRtgFu+QEfSdP2y0bKeEvQynQThyDuNeHw20w+ur9Zlh6dBimuWaT9cWXN3+PRmJIh3ZkQ2gnPg6tmwAib/xqIZTSfnEZlb9kuiCI+upczi3nQK9mtazvEhJj3raN+eL3V7vml07Hf2VOf9/EgaEtdNfeOmbLIRXmAmKOc3L7Cp5XY5Gf0fpcljJuEl9lubnsweM7zZPUI8M5/CaUoPeLenC6Nn81pKLmmwk9N1B6ss/fRpBtDqms/FXAj1lkDevgic2XJkygef2j4uX9kv6yJqJwFQGX+RCuu93r/FoISF4lo4Eda16jQheReJJz3fhla8uO42Dc9DtWUyBPb2IsL+1/jeWRO7kux17uD9PbnH6dfX33NoM9OyDzJkMBTq60//F4qfihVT1ttN5SVgTKlr2/Gwcqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(186003)(6506007)(7696005)(122000001)(9686003)(33656002)(26005)(82960400001)(55016003)(508600001)(52536014)(8936002)(110136005)(54906003)(86362001)(66476007)(316002)(66946007)(76116006)(4326008)(8676002)(64756008)(66446008)(71200400001)(66556008)(5660300002)(38070700005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?szzJV5ihsU/FNm2OPoOv5jowpZx0KJNX9/ebIr2pErfFdcGRpdnCTBlHUuQq?=
 =?us-ascii?Q?XqiBJzNlunJX8Iiy8sS2b2mX8sBteX1P6bOO1XD9isZA3+42LaVpe1vbIWRy?=
 =?us-ascii?Q?TNeQiSIKYc9g1yDp+m4cohvITNUx2hib8QjofZKIx0QID2mzbMUviK9eYETJ?=
 =?us-ascii?Q?x2Cr1xEY0rJXCBHCYeK0Xt7BdP6TAFWzXIyytA/9bywFgL8L6aSwyPXt/RSn?=
 =?us-ascii?Q?zdMuQs/A5PcJyq2NyTa6h/HmQMWiyOb9QM8pds5CTIrewAEbwcMbVdtSZl9c?=
 =?us-ascii?Q?tEJs+ziTWVw+9xa5niQMKph24PlGPFcgVt1n+aKp87oY6XAHk9PMKqNEnTxX?=
 =?us-ascii?Q?RlZKGXK1qGzuhcv38KVZffjKXcgAO73kcoVA2bSPCqKEBIKdw3v/8mO+iZF0?=
 =?us-ascii?Q?DNixZIYCXWsyA1uOajjhLCSDtP/BzP0K3s/aB84Goga8uFdU+Q+BWlcholZd?=
 =?us-ascii?Q?il17I25SFNR70ompeN9IB4sGN9OyPm/ZntIgiSd4akfq3W4fvl09JBqxeGmN?=
 =?us-ascii?Q?dNlN47NhecESo4YwOtpXD4CmYcz5EQACwCLAYOLvYGQ9tXmLeuafJ3vUOzi7?=
 =?us-ascii?Q?RN9VhsZJtKLwI6Tfv1Zim8zu2NimkcrH1bdI5dOB/kpOSjPBKjgNwibo7SEW?=
 =?us-ascii?Q?BME8jc1o6NoSC/ltcd40fUjrDmUJD84kQhndO9CUkT5h56XBKoVNnsOEQcn+?=
 =?us-ascii?Q?NyBm/bcO8agg4ycwMzh4oJrlHSbmtLEq/0FssYFA+ciTWRuiU/4dx5xiJNuj?=
 =?us-ascii?Q?SMkcYK37AKA8ksiFUM/Rwi8TxhzV0iMkalcaPQVry8VT1cXfC3hisFGpcqNP?=
 =?us-ascii?Q?MAaAqOfMIEFyYIvt+nsCoCcmSTkqRw9d9x2sfFz00PB5hl4JuVHUTI2dwCsX?=
 =?us-ascii?Q?XwA4WW6o9Ww4LpXa2GJMWzkV0xYJDEjrdaV9dbFD+DYWEQDa83nUUZ2DeHwB?=
 =?us-ascii?Q?mGpU5V6XwVwZTZYdjaQ5y14GaAWiAbHFRodSrlrT7tvDRAFJHx2Vp9ECgSjL?=
 =?us-ascii?Q?RQEsO8TONTqtmsFpOV5ngJC023KDbMZekLMEqpD319Afbccamjwp0E3i9XYD?=
 =?us-ascii?Q?Yf5AsJPelBlMYG2eshBB2r4AZl5e6j2My6QJJyG3pnekQsxOlpgJ9eoM1R3S?=
 =?us-ascii?Q?lhVXPELHylkj0KBC/ETxYRBg6w0j4LooSPZ7ApNFZv2SUMfxFvAbxzEtwc83?=
 =?us-ascii?Q?3xYQkvmhWV4F4w3np/9lge1EubGzXKix2ctIKZsCwgfmmuiR0jUDfOOMiYgP?=
 =?us-ascii?Q?GGv1MrxeN+PnelDtjyTas3UaZQngaagbZrVlSwVAO/SWq/AeHiQCMxdanay1?=
 =?us-ascii?Q?7Bexleu/f89DoHnJ6CSjdDXKQphBoSYKiG8J7lR99ac/LUreOQIR5wQtYlPu?=
 =?us-ascii?Q?7iD+xePGwROG5wQH4IN9XhLQcln9ROeD/3BuK7T2oUManZG6FghBZBfMgQcy?=
 =?us-ascii?Q?nnrN8QFlTpRPSAE+RiTEl+IaFGvnM74a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 325514d4-1df5-406b-e783-08da0b09414d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 07:06:00.3488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQP4qrWmWVFHUpQbTLlvAR47ZpU9qu8Q+aPTDxDCs31hanHw5NOSWIhFLhSjPYMtJgprv6DrsmV3G1qMjHNGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, March 20, 2022 2:40 PM
>=20
> Add a new iommu domain type IOMMU_DOMAIN_SVA to represent an I/O
> page
> table which is shared from CPU host VA. Add a sva_cookie field in the
> iommu_domain structure to save the mm_struct which represent the CPU
> memory page table.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 36f43af0af53..3e179b853380 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -64,6 +64,9 @@ struct iommu_domain_geometry {
>  #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity
> mapped   */
>  #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses
> flush queue    */
>=20
> +#define __IOMMU_DOMAIN_SHARED	(1U << 4)  /* Page table shared from
> CPU  */
> +#define __IOMMU_DOMAIN_HOST_VA	(1U << 5)  /* Host CPU virtual
> address */

suppose the SHARED bit will be also used for KVM page table sharing and
HOST_VA bit is to differentiate mm sharing from the latter?

> +
>  /*
>   * This are the possible domain-types
>   *
> @@ -86,6 +89,8 @@ struct iommu_domain_geometry {
>  #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |
> 	\
>  				 __IOMMU_DOMAIN_DMA_API |	\
>  				 __IOMMU_DOMAIN_DMA_FQ)
> +#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SHARED |
> 	\
> +				 __IOMMU_DOMAIN_HOST_VA)
>=20
>  struct iommu_domain {
>  	unsigned type;
> @@ -95,6 +100,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	struct mm_struct *sva_cookie;
>  };
>=20
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> --
> 2.25.1

