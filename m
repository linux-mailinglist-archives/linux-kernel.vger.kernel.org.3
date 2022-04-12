Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D2E4FD59A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390229AbiDLJYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355609AbiDLIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:08:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98F26DA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649749150; x=1681285150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=txIRCbpNx/+FLin0sX5zbA3i+u0ak9KfBh1N535ACdQ=;
  b=P9gtKB8hRs+Q7O1Ivw98epQ5XTgSYXO2MMQxrUsa3qIh+wtjFSWiXe2e
   FsXczERF0bbCOsEzcGJRITXxcLsXRYGTBJu3yB4tkQTzul2OM9WA2863p
   NO5hIfAg6/+NXQ1SYy8U+R8OhjzMoe4JZpetrQ/Ao8J+KY0IP7tkB5AZc
   ihaX6rc7R/mbCPrOymuI/k5FHx3zMna22+tn9TtHdrhEw8lr4gVKsuHX7
   4A8urdWzJxy0DplngKCJrYLylxT3BydsyLyasLLQ5TIXluEhHvrzTfI0L
   GQyaday58DW1dcXz65SzufxoJnZfbQnF48rSOxN197UhI/xbf5IyFqHgW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259897889"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="259897889"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 00:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="660379603"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2022 00:39:09 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 00:39:09 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 00:39:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 00:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4zEYsr9vjnD1XksxyXZP96apVY6BEUmgVhuiSM6ioACsFi03Srs7Ot4JqmPHU3nYrEXfr0OpDtZq/GyhKOYkvpzv1baqaokBSywm47p0iSEnV3lhDMlXqpp68qsa2RIDFTd2HCawNZXaKmNSLiqO0bJS25WUWrAcO7nyRCvC/B4XWICIpZ+hVXP+jVmxKc01Y6umwtFSxJ3YdLWnEr8w4tSQ2gp2YlHnPfL2CX8mTrlgtC2q6woC+ktTKEGqc6Md0QpMER8ObLP4mstBkC/5SrHgk6kkkNB1PV5/foauRnITjpoPtUnp1Hw6t/r2yPuN7hCIzdwqmIIjc/4DiSdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kec1RrgHleqiePNX66WuyjhAf6R2SxxVZOYt8fLSSms=;
 b=L2Q/3d/M0Erui9BtLUJSINVAxONVP66yGaMyfBr+B8RNMKLP+jPTPzEw/Yi677Xx9tQdGGm2FQK1x532uAWCsHELMKd7npnG9AAMBCoxtwDV5gWtmZEUp+usXNhuZRRtTsqPIo2Cki1pwrW5IhkmpUlauEoISsEgrk03zCxn7h4n0aEe/OCw3oPFcj0mTK9hAkV+Kxogs6/NIK13JayYOJsDdGEXXvaOfCwFlxw7NAas03GBKTkXuxpd1cRus63zqMQVWDAZO6Coho/Lt1RL5n64NSiwvJ5bMS9Hkz2IFhd2rlRAwyih3nBmBRFGQgxPujsidIUcrMKMEavRWGG7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB3615.namprd11.prod.outlook.com (2603:10b6:208:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 07:39:07 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%8]) with mapi id 15.20.5164.018; Tue, 12 Apr 2022
 07:39:07 +0000
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
Subject: RE: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Topic: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Thread-Index: AQHYTMWQdMRj1LtW7ESP7xJUKRpqwqzr5u3A
Date:   Tue, 12 Apr 2022 07:39:07 +0000
Message-ID: <BN9PR11MB527689614CBD807A113493B48CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
In-Reply-To: <20220410102443.294128-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24050985-daec-4aea-5a71-08da1c5786cc
x-ms-traffictypediagnostic: MN2PR11MB3615:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB36153501D50BF1D733EBEDA28CED9@MN2PR11MB3615.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4ceZOPekcQKn1JosAS8OkIp/+RmBFDMsHqu4Hcg2Dj2bu/atpMdIRXZVimC64w50A7Z4q38D+mkoOxp7PulLWBVnbn7117vbLS4xnmpH8evsvxW07/ct8impCH5wRkW6S9dzFd9Y3uCYa2kqYCmBpDoA4TFP7GtuLnMalWPAL45eBUqn6KJStXU5thFQM6sdUMG8JzTzBlU+HcXqF4fiFx8qndGf+iPNltdwx0oxGDHgiVe2cyF4MM+b4URPGWrc29NeEPNHUJkCWF/ytPVkPrwDGR5TSk4poBhEfeLLGOMpOB2mNM6Wym54bA+4hacCEWXrZZGUAlZxLbKyQL8T+wpKOljRgxkky2pzLfeyQmrAwAsTa0/pHwDyhR9Fkk9UgSY0wmPpKnW9GUao4t8scVoM1do+kplWmEc/Uq76EKOOsJoox2O+4mdfFYE0EopfgOXi+TNM/phpflLe4VZZGmRrPgZwv8ct4+VMNpFrpIYYQIv3R/rzmsBUkBGThxUq1oHtliqLeD5K3R+4YNp4VEV7R8tMDJ5VZTM0dtIIDU8og0LmvbioY3+hTIARVJgnC9F1zQiLv98/xB/Tuwk9RDmyunCDCl+Gvurca4I5x9RMfGmo0ZD3sYLvkiBOjAn15EyBtRVyJwaz0gbPbAMfyg+qvD+CcOuej1E8WkGiTAi05UjW3zZifyXPAjYxZTYemrMy9RtDIFatvUA99hA5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(82960400001)(122000001)(9686003)(38070700005)(33656002)(2906002)(83380400001)(508600001)(86362001)(316002)(52536014)(38100700002)(4744005)(71200400001)(7416002)(8936002)(5660300002)(66446008)(66556008)(66946007)(66476007)(76116006)(6506007)(7696005)(64756008)(110136005)(54906003)(8676002)(4326008)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?krDGti3C9EAPldej4944NjaFIXKhOLG7a2r214G8Mnmlk90jTRvvwRqV/W3E?=
 =?us-ascii?Q?OB2fWuushwRWXPHl/erO8im82nBjrYRzaCotIO24l6xMIJbGQ2IIVVQn5ip7?=
 =?us-ascii?Q?TPo5VmPePlNoE64QCpEbZMyaDtTiCOJEICulUke0cWoHJjmN9qCaHYaOqKPy?=
 =?us-ascii?Q?l1qMbmqMHJXE1tLet7nSZBWCtLGUuOWrZZPpCQAG2ZKH/GMms7hgbf7QB+w2?=
 =?us-ascii?Q?wiAdjhhKCGcvfLnunFv7fS+XchKW4oQBcfgXSlAttNjLIUKc7FweqjfE5J/s?=
 =?us-ascii?Q?5k5DmlocFx4R8mZfSbgXzsYOREmwJxxqDRWxJ6J7IFX41rrmNEkOLZrCVgQ/?=
 =?us-ascii?Q?LX4dGJtjplWT2vKdnRpnfVsXvmZ9bJPcek8cIQz9AlPBSx0NipJ8aB4z99OL?=
 =?us-ascii?Q?9JoFdtaJGunxdismpNSKUx4q2BZNTPCq3j0yhY3yH9QN8fDzkQFAFLWAyaW2?=
 =?us-ascii?Q?0D2NUl6k+4XUO0mhtbBbYn0fhQY5uDUpfeIm+/Fh/y19IFIv2gKvwjQW5iRw?=
 =?us-ascii?Q?IldC0DNUYVblpjGxG+t0bOC8PON9RgH8CdveH2O6C5ZPca3uVhmh0cbHMcE8?=
 =?us-ascii?Q?KQiAkITXoLSIdncyI+AEKVGvQz2mtRlAWgGhhw4Rr4ehy1m5rCQkRaIz5nk6?=
 =?us-ascii?Q?XsBnOFmQ+80FwbOTL2oGt6bmxtvOsic5Xeqz7LzZmbR5Mz57M89/CSaCrcad?=
 =?us-ascii?Q?g2KDQO3eZiYbgDBERzhTEpB1XYBptgUIlIO7/c5TaCPEcCXBB+SaAOUIpJd5?=
 =?us-ascii?Q?xlj5WmmeXd0gbOliSeYoVA8L6kKuiQbHpd/5exLpd7dGHmPJrP1Q2w0UpB3r?=
 =?us-ascii?Q?34I52i40xawPidGcf3/o7JM08ld5jvKFDymTn/hDZ3jzPLvp07deV7sq0B2c?=
 =?us-ascii?Q?2EuHYZUB6zotH3jboGfKG1ki3APHXcudjpp+NdrASON7Q3tPryooRhuNj0E5?=
 =?us-ascii?Q?wBbUqRYf+zkc6OgiZwaa+zjLC0fnN/vo1epy3CfmFmasHtvNBIjLMHkFb0p0?=
 =?us-ascii?Q?ihfwb3etsQSDL6adshYiLCpD+DQ6x/6FIIaiyHUcAY6J2bbDbP+ydlldgc5P?=
 =?us-ascii?Q?Gzu3JiRzhdFsOQoY9thv4tvg8+1CXAfOWLxTO9Id76tIDWG2q+ES3LK+7CYZ?=
 =?us-ascii?Q?0VeyDukMyjldGLp/Cfl/jY49rkEZaeX+4z3ZkLhdW467n20B8NzsS1ZuKtxl?=
 =?us-ascii?Q?/HdBsGGDCY0ieH1sGrZTPhp2ZCDTDHWh/PskNroeWF/rIxpOAESCI1r8jG/S?=
 =?us-ascii?Q?1xcq7GG86AhxyawcsIphOcrONbFig31m8dnzceGMkygr9fWC+qt4YPzBPjwh?=
 =?us-ascii?Q?5nS9IKXY1a2jX5ORy+7WNkpnryfWEhMWx2IZQQyas5y3wFJqvCqR7a+npHTj?=
 =?us-ascii?Q?5oSJTsqMaumQwsT3P8MLn8nsua66iMH53ZgUqd8ByDp9hKpeLHZRhogGtSS4?=
 =?us-ascii?Q?ZkLLlHfnAQEonuYCAJ9Lr/OfoEosSUm82IVUIgI2sSk+XM2g1dpRc1J7Zkwy?=
 =?us-ascii?Q?HLTZsZrKmYzzepa40KGsghYmjU4dNPcVK+NvZxyVUKFLtpGpf4Sb2eO7t+hW?=
 =?us-ascii?Q?Ujlk/RRTy59t/d87DP5GETSAX55fIvf8a6MfJYK8OGpIRb/f/mPO5OFQWT6J?=
 =?us-ascii?Q?wvayx3K8G0+S+CZFOvL3k6AgJAbXJgHGM0cYmko3bbPNBb1T57ihBOf32LNG?=
 =?us-ascii?Q?A9fYyLuWknfxjvwhN4wrmZ6Erv+wjAg10KRZKBD8jUfJPnXUxJCk4hXVfwlY?=
 =?us-ascii?Q?XJE8wT4O7Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24050985-daec-4aea-5a71-08da1c5786cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 07:39:07.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZOI5/AbLZGIag9U0UucodZ8r2lQKjhTOLjC/ezXQKXqetyzFPoo2B3xmbYiVVxlP3Tg17ePk/3NbPcXQL6lxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3615
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, April 10, 2022 6:25 PM
> @@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group
> *group, struct device *dev)
>  	list_add_tail(&device->list, &group->devices);
>  	if (group->domain  && !iommu_is_attach_deferred(dev))
>  		ret =3D __iommu_attach_device(group->domain, dev);
> +
> +	/*
> +	 * Use standard PCI bus topology, isolation features, and DMA
> +	 * alias quirks to set the immutable singleton attribute. If
> +	 * the device came from DT, assume it is static and then
> +	 * singleton can know from the device count in the group.
> +	 */
> +	if (dev_is_pci(dev))
> +		group->immutable_singleton =3D
> +				pci_immutably_isolated(to_pci_dev(dev));
> +	else if (is_of_node(dev_fwnode(dev)))
> +		group->immutable_singleton =3D
> +				(iommu_group_device_count(group) =3D=3D 1);
> +

btw probably we also want to check when a 2nd device is added
to a group marked as singleton, just in case some weird thing happens?
