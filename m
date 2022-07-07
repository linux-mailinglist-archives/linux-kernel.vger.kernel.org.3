Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1722A569BFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiGGHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiGGHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:46:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED5232EE6;
        Thu,  7 Jul 2022 00:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657179962; x=1688715962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Qq59lzmIj31cr2gs0M8+etVGqwxhjQq6sLfZk6IdlM=;
  b=UMiRIHacs2ZOemAOtDaBrnBmC7iBgFSn0nRatoXf+eCpsg2r/cXWfAmP
   q5K6l9m9seqqr99FInjQ8CUUcLnxEtWuE2of2neszCR05azhMhA/0P5uh
   K4IkaH/h3v6OwGcfmoZtmOB00zLWEZKMjKK5P7N8rFkCulkQWqnqc5aFw
   GFsSHwNUfjRKdXk/ZJxizI817RaaHzE+CdBpc7jvz7593Wm2y4XnLcAha
   Q1LNX7fw7Oga4G9sW31rjX6qbosIBmy3k4KQcKVNwGZ3xHArQx+lICJ7x
   mqnPRDfvq7uic1kI4EdZr6/HV573hu/1RavUI2ip2Zlwo+QDpMXLMr9/6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="264374344"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="264374344"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 00:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="568410101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 00:46:01 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 00:46:01 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 00:46:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 00:46:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 00:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj//5hp/vEgYNEHO7eanRQwT4hwO7RImgAD3Sdqqp8cUa5wdVrOALp5tNeL4XMqZLeTK/SXVwm18MdmHjK9ODKSYJzeZNXiQN75lnNqkTY8dYY+Itecok3LjGCgkVJa0flgdHC2Za/RU1bLtrbTxQw2qUv+hzW/v+REB/MY5EDuP/06nMpLznMd5uGJ811Wt06hmh49qiqSWnzft1je9OvREZJaN72aj58Mk7rxEwiQAEebNF/PNbL0maA07qu70dtQKwkmE9lGOWqMpzK1Bl6PCnvHU3jN+9JobANMjFzy2JCyGOznDiAm4CXx0TGUmlXiPEe5l8USoyG8rXDuFUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qq59lzmIj31cr2gs0M8+etVGqwxhjQq6sLfZk6IdlM=;
 b=B0e+8t79OktxfbIBNBFWjgY2iZxMYPSN/UZixUeXWADMlzWhZeSfoMLxeekPpK2PFmG0UNrPyr88u/maTOFw9WCOD1vgDNRtMw2sY57To+UxbieYcfW+1k0CceA82igHX/jeFMJNevQq/MADk61wu4kl/ZqOanslrbOA6pM/YiXBT6y6I+NsYO/Z7rEaWLHTcuBZnUIoXBy7/ywRf0hIZmhQOEQmvE54Pd6xogVJKFnBFgnbBxEpDK+GW/fmGH2TH36u+ADb4nccgIEedL8vVuvV0bfRZcdFYQBmdgQj18CQx5BcDQn74HoTHzZAsd7nkY6Fu3qOogQBCTh0C8y3rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Thu, 7 Jul
 2022 07:45:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 07:45:59 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 15/15] iommu: Clean up bus_set_iommu()
Thread-Topic: [PATCH v3 15/15] iommu: Clean up bus_set_iommu()
Thread-Index: AQHYkJH5yIFOSo78w0u9xtztwXlo8q1yieGQ
Date:   Thu, 7 Jul 2022 07:45:59 +0000
Message-ID: <BN9PR11MB5276AA266B538366C2B3971A8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
In-Reply-To: <dc44a2269276e1d0fa6715d4530a51df4e7b781c.1657034828.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c1d3e42-91a1-4f65-039f-08da5fecbba5
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZO5jN7qZChiNjhbLC/0//YNLr0IJk4JxrM/2Bwn7x/gNq1FEx9IRdN5GvrCt03fzFrbmfHmdRmnBci0sRN9BExF4ELr3t91X64GsXPJzf3eTmQR2mvkNT6uw2AECLXyE7g5rA5XHmtRVMhCj9AToSioJ2/NtEBGc7sVVq8FWKlJf7C1v/JbIFNcLsvwk+Vg7J8YOrDlSBdEhkiZqtlLr6VJpTTpLXIIUuPzXmPQmlJq+jsWQFKsxiMGbgSAg1ZLszgnMySDLwIFBTVG1OlOsnbvljZDozxy1ewlyxhShqFY0lxbPM6fRjbcjNCwLHQjshqnICy6CO+eNN7a1FfjkwcQI+PvDsl4vd4Go4Fr81fTAyhncVEUK3VNfHrFwn4hL73qTi50VL/37Z3uwWc8xg469+I1jprR+18tUUKq0dsrW4sA1nRymhSTNmgrD0KivFJMEPCvJsf/8XCi8GyBEekBnAn/pXjvWWrYbel2gr0Bb38JdPWPva/jeitRzS7fC1nmG2dnJEd672RFGtTl3xors2mCJfiKfydH1g7FxJtbGBbOtNzT3en2nokuAPx2gAzrEwQvz4vSDaZjhjo9HiQZUyt7wwluHTYGMX+EhjCy05RluQUr0h02ZpfRhERrkASA0pDliZznC3LzfY1OoalnCM4ADZpUOGxsAmA97PnJL6vO7I/TS+AII+DqFVQiIsBhGz3r3anwInhE6cX68vl6ZGyWBKQLDbYkjNOxagEZHTIblfKmjcQMNt16MdDTvaB7pV8KD3IHeOazn/y69MOprzKtiINpAv0r902xiEbHYrthsxveJXG00dHCjpbf2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(346002)(366004)(26005)(5660300002)(2906002)(71200400001)(55016003)(7696005)(110136005)(9686003)(6506007)(54906003)(8676002)(86362001)(66446008)(8936002)(52536014)(66556008)(316002)(66946007)(4326008)(7416002)(558084003)(66476007)(64756008)(33656002)(82960400001)(186003)(38100700002)(41300700001)(38070700005)(76116006)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G8x55B3LJqJkSXuJ+mIsxYe/dRLUE0unHgIRB0gyU6eKOcVGSbgTWWpI+116?=
 =?us-ascii?Q?NnxzX/TctarSYYVBp3xlfki7HgG9r2t2AyR3z3jnfghB/HGFR8JedeC3HDfS?=
 =?us-ascii?Q?XmPhEqWkxjuE3NRmDhn9CDPnGOtecdhFSl1anZA+3V6UY/hiYabpC2T/EUOc?=
 =?us-ascii?Q?tp3L5MIm2W9+NDdLvCJnCHMXi+M6TsiQjrFjfP0R0T6jUr4iVQSsuUatyYHK?=
 =?us-ascii?Q?p3rueqOwA6SDpdKtBmxUfUEvrrbGBxXQSuTxaWyDQE1ATdbt3rlhEfcOodrD?=
 =?us-ascii?Q?8vVPVQARExSk9BgZlf8Y/E8ZKw690NlgihHNKhNGQUMIuZyXDP69S39+/L/+?=
 =?us-ascii?Q?Ay/ak0nq60Bf1uvbGGkJK4BhuZGh+BqkXen9Si+xDbAsfsN/epIgdjRZy00A?=
 =?us-ascii?Q?iGc3SmaJsiCLfNx+6LIzFzgMJk0/ogrQMiZnN+A6I+QthdyX70P8Z9tcXZLK?=
 =?us-ascii?Q?rsGevR+GLfxzjXXcefq1IyWRAKIoSnIB/lsS7uRdgSSoF5kyyj7Xn1Nnk0ue?=
 =?us-ascii?Q?MRQ6ViZfwuYjQ6cku48LgF/4Qv2t/sqia8Po66vOFhWzrOYVtf/DcmUGN8AK?=
 =?us-ascii?Q?CPd2+oafoI4v+s7HSnPJQvysvPTDv6GSv/LWuNEYdL95IrCpGEwOzylC9XWJ?=
 =?us-ascii?Q?Ey5T7w0SxGdK+M6FMAL8HqO5JTxmlSTO8VD8RnGGzJiOVtVyBhPB8p7Is48A?=
 =?us-ascii?Q?Bii31VG8iRtdujER7JsSlVCmemMZBJbkKcBEsXebSGhW2afUdllkQk2gYLdh?=
 =?us-ascii?Q?1tUxr9bqnFPTd8dJWl1ztYEIARI01BTRogE2yzZEC/t+U5R3LU8CeAUpyNeJ?=
 =?us-ascii?Q?GKNCUeSd7RebFigt8iGJUxSGs3KxsHJe0nJbSUF6JxPlxjh/KgwVh3pKaz8A?=
 =?us-ascii?Q?3I1QCNLx/u7MWooxKLKvDaZ5pqRhq8QmuegRZbF+wkeULlcwGI5gHPL2k1ZC?=
 =?us-ascii?Q?vkmh/keUPoUMqYr1G+v9X5gKSYa4fv3BTz8YXINpi5lkZz5XVl0QV60nhTez?=
 =?us-ascii?Q?dgrnqnGXXv9cirxL2JPgFLhULhXBsyQnjd2/eqVRyAN9YEacRyJhTP2N+ply?=
 =?us-ascii?Q?zois7cjC6eeBPd03fmo+meKcl3TgEQY2j3Tqvi/SeduoUzJRbW9Kp1Sstv9C?=
 =?us-ascii?Q?P8z6fAlVH0CjjWpboEB6cz19NP9bvkVnolTh+YEIVH9Kdmj9AFfLXctc27Fz?=
 =?us-ascii?Q?lWc5+i5wYMnG9QGWlNxH5SVcUeTuA1ReMXc4Y7EGmGVn2nNmF4o7g8K21hbS?=
 =?us-ascii?Q?kUEDD7YDzI8n6ZWrlPprvgMQCFqwSmlH2xu5Ou1djm5SHcA7vQBgkWr5Pgmd?=
 =?us-ascii?Q?w2nBJN3+cegdF36LH9mdTw+A/56+IxYIlK/UF7Qxaxzlo/6WjOHTqHo7ED1x?=
 =?us-ascii?Q?ejkrT9X0R4XvUX5ikaJJaC9+nLXrSwlHGFjC8IsrH0j9pEW3YW17G5GkQrVF?=
 =?us-ascii?Q?FiE/1dclw1368+6x1lOP60fn4KsBdTX8+Zq3DWCJPwtNivBdGgIF56kYRmE1?=
 =?us-ascii?Q?huVi8xvTg9lIksxWT3TwmYgh53tF1r8hSKuH+WKj5wquQmeuuM7fcYTWhmB7?=
 =?us-ascii?Q?60iteEPcTDwWO+BUGp0kUq0ynVzLMyaxNIHawLj7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1d3e42-91a1-4f65-039f-08da5fecbba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 07:45:59.0951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d7UM4aZvk3i5MH80Ns1gEgYb4mXIb2HIyNoWiHvgr5RO+nIVQ1DlQsS68lMOzaxpbJqV6BOxEQs1UoaCjR8lmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5862
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

> From: Robin Murphy <robin.murphy@arm.com>
> Sent: Wednesday, July 6, 2022 1:09 AM
>=20
> Clean up the remaining trivial bus_set_iommu() callsites along
> with the implementation. Now drivers only have to know and care
> about iommu_device instances, phew!
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
