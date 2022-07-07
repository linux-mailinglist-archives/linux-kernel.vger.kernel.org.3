Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9F56988F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbiGGDD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiGGDDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:03:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55A2F666
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657163032; x=1688699032;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mqPHtafMb6xBYqA5Pi+9TX3BelTYxxKHDWz+jcpoMak=;
  b=KXW+qS2V/0rsw6/z6rIUJUpQqGJizHgz7uGg7r0MOtQrZLHb+gbD+RAm
   ejRGMB1MKb8EvUYAi/jETfbMoGY65Q/VqoN6R6pe0ywbRbYgdek3L2hsw
   UIZ6AFTWxcpSU6wEsI2BBX21lmLP3LeoSsilXHLREsm/EHXnRsFbJGNQ1
   Iste0DjmwJdZWiGg2KpEjJAHnCLJ1pAk/Nnds38s1YrB40Q/sNP4J8Jxi
   YVyEUSnSSzwpX0SDRaGBXMPAKejhI9kyFPtHDl0UzUj50Y8jpULZi49V8
   R/GtE14a/xlwB6VP6CGal59cHTbLS2nFPWl6ObWlUEXXLK1rYpuwv/QQv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="282669178"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="282669178"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="661209797"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jul 2022 20:03:50 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 20:03:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 20:03:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 20:03:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azQsxj7DDS/SqIXCZuMT9b9LPvFc9TD+WpRHsVPLXOw5fM8jL+YFYoJkkDGayXyCcB3x/ZPbhyb4glAFAHuKvJkxmXiANr61Ma4QCusTXT6o9AloMgexVRxTa0f9viLsdrRznLW0aL65kBzkrYeC0Y0lTZlMGCKpC2dopj0OSyI0BKVbRZKUwySPENp7Cvp5zX+b3Mj+qyKEgoRmgb3eKjDTKWDwb36pvgyCHn4ScSIiuVCCFeyRqhwAeIM4SPa8yd+CQCROWbVuTkzI84h7eo8c+LzB99NUoBUEVvUJUdV4PgpTelDQoowb4ldNqKRGq1j0DHTTgVun+zXCzp/Vfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqPHtafMb6xBYqA5Pi+9TX3BelTYxxKHDWz+jcpoMak=;
 b=G7DHp8Wf0z+rTe/4kRU+6wLyh3lYxXK9FgdevrJOr/fLDxwQ/vvEeBMm4Vms5SE2E7d+lopnHWDrbjUo/B/jGs2kEcK/KY7LZETVXqfdF224/kBPJYonrW3F24/tDTjA28kFRS63tPo5+nQzMDNMYSOBYoZndZTHUs5EG3Yb6wf6QQIkt+oe5IfZBagvgq9Q1rmzJd/k4/KDhMX7cYVkact5X1ufP43IKp5GZbIwfdocYndThxzPMYHVgq80wXgBaoAH0Vjp/iujjxqA3bo2rd8ETr4Jy8FLZSdhX/+3oTGsuz4Ar2T5r1+3FLSl1sj+LY94hD+ubP/gCotBwLsRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 03:03:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 03:03:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Topic: [PATCH v4 02/11] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Thread-Index: AQHYkOR8JtTLiasK2EuPFBjIH+OkSa1yOmVA
Date:   Thu, 7 Jul 2022 03:03:46 +0000
Message-ID: <BN9PR11MB52766EDED74DC1F0703D4CA08C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
 <20220706025524.2904370-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220706025524.2904370-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b29b6d55-4e83-4343-ba4f-08da5fc54f28
x-ms-traffictypediagnostic: DM4PR11MB6117:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox5+rnjqy+mzn68iVRSJbeB6yk3Tp9AhqZA+t9IygJoHSsvGjLVEi8v70g1bql+nbEjImr8ujcKNUT3VNikU//O2u6VbuhsLjn1DabYpb2L9f6+wyW9RgS+qb4Rc5E+Y+VW+ZZUUAs6HHzpG3RD7p+wY6fr+G7cKkaZGbF0l9cfKC+D2fDgDq2duzV/GfN/5SY6QnHZHYq/NfuMUpzaY3uUT31q9Z76Pa0mNns6ovtntlbRZkGHe3M1yxEorKnFbeyesz+YxzoW3ZOtggI8S7Iy6KVVGWgEP+6eg6wBQR+Uk8ud0+ub+Xx1LugjUPtWG/dBGWUzwvUG3+3Xp26jEwAC/oUEl1C0hFK9iwX5mZ2IrlCSXmV8Iy0UAsp3EWvjcMkuT10ox6Mu/g32iyiUE9PBZB6EHvMlieREWRDGUB1YRBQK3mN1WcsD9OpU4aus43wBdWI0jE6NPfW7st+q6XpvSxtq/ebcetdM/NpBqDYmzagPIlkJ6mF9iE+Fg3+omqxQa4JfvvWnTvzcALHMaWveo6QePaKqsiY340L96OYFruILb5Ekko67OfoC7629TGpgOD633UskPgsYh4h86ySnDi8pUAs5Oekkkzi3+E1zLTC8oZf6h1KRF11yAw8mW3GL6Q/V/y9wDmi5tLe1WHF9rQVFdOKuAoMLlknSVbrSRvZwxlpn6zfvx93Cf0iFZeWkZCzR+Lv5xx007ELCQvPR4XBe3BbRyUnYWUHsp+JYAjNplWc1DpZQCAU3wZw5KKNmkX+u7rxjUu5FjvSJnsHa0SuVNUFW75ECt9ICPJHqDU+isZfey8187RQhBmNTW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(376002)(366004)(396003)(346002)(66476007)(76116006)(8676002)(186003)(66556008)(82960400001)(66946007)(64756008)(66446008)(9686003)(6506007)(110136005)(7696005)(54906003)(55016003)(26005)(33656002)(38070700005)(4326008)(122000001)(71200400001)(4744005)(478600001)(52536014)(41300700001)(38100700002)(86362001)(316002)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q6AN1nQ0VQjSv7FiJEOYEPSgKxrUCr5vQo/BuRrR4w/7mSnTUiHtL1cxG3vE?=
 =?us-ascii?Q?bu8joutgpTw8sXjau6Rp7FyiW/deZL4eBZ3NdsxOkyeKE5SFv1Vuh763KIPr?=
 =?us-ascii?Q?TBP+pLwM8uHXYjsRVQuUN/KhFM+Khxv8RK3OkFSOoXlEpLphWqCvhB9A1/Dm?=
 =?us-ascii?Q?TsthW6LyjeAQEB9ZbXV8zQ/RxIMCcbvwsGhmH43wj1VY5s+t7jYU7lAUMR5l?=
 =?us-ascii?Q?qlpf08Uxqdfu0en897yPvr45kww2R5wV6b71i6Em4bqoJAQnTubVpG3o9M9T?=
 =?us-ascii?Q?ibD5J2YhfjUQ/d7XGgSFb49o6U0mAD/cRbHlFfBR8yX21je+sTt1fRzSlOb8?=
 =?us-ascii?Q?lxnc7+Iu7pAhtxWjHSz7ptmUCXGRTolLK+qHgT97jAluxhv0lw7XjqgMP8k7?=
 =?us-ascii?Q?3zyUCxDXWs6gVo8lhRsmHMOqrF6+Xuh8hEKcN2Qkq2Pmj56gFIBOKeTGQg9E?=
 =?us-ascii?Q?NVq4e0rMcVvahF88aXFrCkpW9iF27q359B8PIbP7Mcoo28cTMcJfhwLqgi+T?=
 =?us-ascii?Q?YKUvLlrs1zjI/qYPFb/kDuquxcc6TAOzsT7M/sSz++FrBFizI4R/KHNg+1/V?=
 =?us-ascii?Q?xhsqNnO9iVNRRdb3UKG4fI2ObNYaxB/+47m+7uY92fzDgxbU/lcpuxhssvww?=
 =?us-ascii?Q?fvBwSmJ+h08hpd6Qye9LSVVJmyd/NYqKEp84q8caM1x11GngA0Nl9wFi++Tn?=
 =?us-ascii?Q?o8B3mVTJWbATMY9HHgzrz6bDakHn6mo2kRWn2Y9WqMSLdrO/fYUq3T+gOLmX?=
 =?us-ascii?Q?7qpLBTOXjRSg6/xjA8Dv2jUEqZcf4Yaxho6CD5oiJi9pimv5raEt+UHUpFiW?=
 =?us-ascii?Q?uHxUoxA0UT9CSmEVvbinMrk6NU5bKv3nDzl+WIg3jhSqr3tzzmcHm21jC4IN?=
 =?us-ascii?Q?48EzYKFJ1n0Lh859J9AXxs7q/szWhTPTl1uOZ19wLamujJL4nQvtTiq5jeXc?=
 =?us-ascii?Q?U27tYrPaXVsX+4WLrCa/xzeZRVzGsGK2Yr0mK38U0pGQDa6O9GR95lX82qvR?=
 =?us-ascii?Q?H8lgLjAxCDP7p8J5ZBdZJXXJUdpUkN9v4SekYbj3DT54EsfwNn2k2hBYva0X?=
 =?us-ascii?Q?+w2ffwRZ8Iikcjnqdm6DBueLkuJ8yz7M0GQEn388/urNIG/yu8ru/wgpUsIb?=
 =?us-ascii?Q?+5+BErVQfcsX1Gy0sv2kXQt6qVyP/V4kq2YCa3hBfhTDr29EvmO2YlT4Jdsc?=
 =?us-ascii?Q?cPMyZn6jxDTFMhcUL9HAHjLT5NE/w8iN43g8HhXrf/9E/GPKYcbDgPqnWWVu?=
 =?us-ascii?Q?w8s4Vu056rio6TcKtZdUPlg8i6GuHpIIyf92puq+D3bCmM8UDoUqsG8dhrJg?=
 =?us-ascii?Q?B3uAg+GE5Qp7CHkSCLjR7NHixvKxU31WdWqheqFCUV5GdT94v4YpqZpitwV/?=
 =?us-ascii?Q?ccEbH4EPTfc8pphBamJgYj+MqyF0tUTkyHNxHE/ain5wq6Hr5IqrXI4uA9m6?=
 =?us-ascii?Q?ijoOWqAzKt1PT5mQIoWRRPOnGjp4fw/85LLdRDeOoijRANiuH+mW0C1gqLfI?=
 =?us-ascii?Q?QH79OnSxke3c0FP/w5aRHD68BNDFD5fjoa+loMB+z1Xo0COiqQja1U7GVrIY?=
 =?us-ascii?Q?yBohtyEGYK+3zodqzG0SKjDvi2tbHt9SyFCnNR2D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29b6d55-4e83-4343-ba4f-08da5fc54f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 03:03:46.7285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8d6czI1zU9LHXUqWrIUYrkY81NJhPZA41NA8bNnGwzQW2o8sauf6xvMQM3Y4+05i58MexonpYJ188wOYat0dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, July 6, 2022 10:55 AM
>=20
> The disable_dmar_iommu() is called when IOMMU initialization fails or
> the IOMMU is hot-removed from the system. In both cases, there is no
> need to clear the IOMMU translation data structures for devices.
>=20
> On the initialization path, the device probing only happens after the
> IOMMU is initialized successfully, hence there're no translation data
> structures.
>=20
> On the hot-remove path, there is no real use case where the IOMMU is
> hot-removed, but the devices that it manages are still alive in the
> system. The translation data structures were torn down during device
> release, hence there's no need to repeat it in IOMMU hot-remove path
> either. This removes the unnecessary code and only leaves a check.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
