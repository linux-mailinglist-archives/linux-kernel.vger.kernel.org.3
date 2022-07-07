Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D1569AC0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGGGv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiGGGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:51:54 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0DD2CC96;
        Wed,  6 Jul 2022 23:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657176710; x=1688712710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YjaY8QygeAkT8y/LxVnDBuqYVwhmLMSPXZd6upizyks=;
  b=KOh75W1bCqG5o6QnSLbTzb2Hkr9/4he8c344d36U1wPujU9Q3USvel2F
   6DgYdzNsI+RxbiL/H/iOQecP0LmaojmvYED/rMyq9oUo5tbn41Wqo1plT
   zN//BszeDcGcKMdV3B38IUW2c/jF1x7o74hN47+QNrZxBScFWIsijj/tU
   98efAHS9RJvvOsmcrLycUx0tb3hh/AmCojIiZZPwjNLuuOguzzq4ZJlWh
   WjXecDeJVrVCB/55J+m0sbxdyXD1E5B7Ojl0bHC+MS++YQuUNeDcg8h4y
   pzn0R/VQb9ZjAaXJ/+9TZirCJZ6d68CCR8+m5hMbw/lDPys5N+OZPZHbk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347931759"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="347931759"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:51:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="839811153"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jul 2022 23:51:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:50 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:51:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:51:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lpyq6rtHuImdQngLzKYp76JTx4c4z3In/wOunrkTjhXlJOhkUQ+IY1P8TgODdeN3YxU8GwVDI9zpOmGDpR3JHgA5nonCpYXgwzzubA9pL4p/eW1HPsHspYmqijf0oCTbwpQ6CXq58FDOIufnZekT4tTLsyYrIHEb3bqpwFtNrcaPl0RddPrQIQbdwYMCOP50K1hZ80HCi7D/kzweciH++bMoW56aJyjKiSkgpRV+Y3phvLsf+3saROO4bY/1dbS/4n+ay7tiDOaHyFkWkGYX8Le9HKKa74WPOcHsMk2a+DavsKWNng2f7sgTlCOzAa/qmcdAptpcdQQkROam3NTC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjaY8QygeAkT8y/LxVnDBuqYVwhmLMSPXZd6upizyks=;
 b=aqPAqcviee/V98vVUK+Paa4Ogqrysdy7tlBCi8i/foxm4jjI88eaXgROvi0qb07xnv+asgPBROyST+ZFVM7WdehW9nkYBL2NEFWpvVFLX46XKr7Hd4j5hMMGqm8N6YCqb2EvkYc+fBibYQZHkvj0xHNNCxJ1hdHck7DCnkcGikE72UIB2ZwNmHXbb2vHDNhI9veiKLJ1vOo9oV9wo4l+6OpzC0w/YSLoK4DxbElus9nBnJrQoS3shvii7w+CFOHQT5i6Ajz/GHPFH0/R31qp/Sp8x+NfeCKmkxLkJsyxEHvUmHvPrt7WbAlgB802IfrcbOINEhMrgrrJ/YLNaxf3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB3987.namprd11.prod.outlook.com (2603:10b6:405:78::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 06:51:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:51:48 +0000
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
Subject: RE: [PATCH v3 01/15] iommu/vt-d: Handle race between registration and
 device probe
Thread-Topic: [PATCH v3 01/15] iommu/vt-d: Handle race between registration
 and device probe
Thread-Index: AQHYkJHsi0bcrSQnykSk3n6Td1/b/q1yetVw
Date:   Thu, 7 Jul 2022 06:51:48 +0000
Message-ID: <BN9PR11MB5276339C628ECB8AAC8FC2118C839@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
In-Reply-To: <894db0ccae854b35c73814485569b634237b5538.1657034828.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cef94d78-46d2-492e-3903-08da5fe52a23
x-ms-traffictypediagnostic: BN6PR11MB3987:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69rAxaxLvzwgSOwJ0nI3zp4b+lijp0n7lAoNg7A2TCJf+eLCkyfxC3fpQPiEy0j5UC7UbuczdpymHDr0v9haIfME/nsW8ssc24XRkzjgnuD7oKpQo84cvzWgkCCTsHbwCvNEOodojNqyZf8JfEeEz+KkhW885nzzAIyQgbB3DF8BkcnHQcAJrIhGbZV+rIoUQIrgkhT4XlothYAu3Bglt9RxTkINsGfB/rElBIH53e0MyuzSVLOQpg42fHxf74icCwRYzdzj9koWyT2aht68n5/FrC2FvaEluAWvqvRZhfmtI27DTgb6jPt8Gxhf4ukhxdZs37/aK2DFsnLKOmK7z6dIpJPzIVTh12KoQotcOKYXJQdRzgFAmjTVjIMU9LiE2csSp8io3F3crKXUw2mzWiil584iSu3omzhS3tCBbhJjAdvaHdxMWRzG3i79F4nv2OIYJJJ3jUQWSxRE0/MtASws7Q4nJKJOR2HMTuH69F3pPbZA95w7C+pnh1eDdD2apsMxumKzE1HRP5HEldaBo3cRjI2Imuf0qEK9i/LAYPFUxMSkWM7rs8CG8W+48PZ7vtED4UnhXdKd1KbgtX5KQS0udJz29lBkMJlLtxYv/7i97vpRG7aqL1/NGVDsZYTWuXLg339JIZ351MSRuYEvlqDxiWaOv3VVFUR/1KTTGCQF550aS2lUWepEdDacq5JRwQaFg1yCJXRGcUtpIuYP0LWMihPMo5rYW/R0sau+783fOedH3dNaCWc24ELxBemk/lLs+krIBIeCc4bGoIVI/JSYzK5SStZnuW3frvrEhKEuSfHTDxNyZpRR09olSD9k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(39860400002)(136003)(8936002)(478600001)(82960400001)(110136005)(64756008)(66556008)(26005)(33656002)(7416002)(316002)(122000001)(66446008)(54906003)(66476007)(66946007)(9686003)(76116006)(86362001)(55016003)(52536014)(38070700005)(186003)(4326008)(41300700001)(8676002)(83380400001)(7696005)(2906002)(38100700002)(6506007)(4744005)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YgcJnd4YAPMUlqXgehvi3QTDVuHBU+t670XTZGse1ASNVtDZuyoqDYDusjYk?=
 =?us-ascii?Q?pRdE6jhLPbwBdxaZSN1nzby47/rd6SfovEFSZ1aO9bvcXLZwwl71sIGZhXA5?=
 =?us-ascii?Q?+dgzyTY7v0K7pyfJ38gnodPTyfCBiJq5HXzSuhFlHVwxUW4l02Nt1+17dDzF?=
 =?us-ascii?Q?JETBLAUBUTx+BeRrGboWGRx9Di1t7Y/OxouZbqq6pB/9ocHlmnXiSlodSHWU?=
 =?us-ascii?Q?C9ekxE7ThZzsbmmfYqVJS0zyg8miqZ7O5uPzdjlw4UgU0gR8tzWGNwvvViEF?=
 =?us-ascii?Q?y5x71hmOQjXW3W8o1tcKFFCtqXqwkWwZER3h5i4e6IqIks2TNJMBk7G8OvW0?=
 =?us-ascii?Q?VyPS4oOwcp4BA0sBCe5bfU4hWvvyOyjpTvJEPfmKQxpZOGR8FfGxlL8hMOG1?=
 =?us-ascii?Q?WZ+i8gQGrRpblT5JfnPb7K/jwIZ3GvR+odwaO/QDyFh/QhOVFg2eCAl2y4/F?=
 =?us-ascii?Q?A22lwt1xrNQnIvxdGL0VZ2QJyJEe3v7UFgE7Sqge7TZD5IKuUiTDmrLRXcCx?=
 =?us-ascii?Q?xRrOt6P+5gpsfIRO/VzsCLTzanDEErrmic5fp4qtSJn7MWnDdtKHlZp0uhhs?=
 =?us-ascii?Q?LfBxdasUMFa2FeQNJtAlXM+RrRRNpJZE6IzusO3FfOgwZxC/Ln1dpcnhgU/F?=
 =?us-ascii?Q?3QV8/WSDxGL2SS5/ox2+nJek4zlFAPjdGjSoFTwT0rabZRaHJaf8h3uCHZlj?=
 =?us-ascii?Q?YvI48swxe4fTObu85kL5n2jj4pz5P1cZXMlFVQlllYf8q6J2VAX2msuT+rlc?=
 =?us-ascii?Q?fdTXqPjqQrcKIiluD8N78TG2+kJAmoZw1uHPipnrjl7NhEs6ry7/IbAhrvYB?=
 =?us-ascii?Q?tU5SHXHgElTg9HcjEM3/DlKnH7PeJbElV0OxyKYxg2CQhdgUsLj4eX8mY17o?=
 =?us-ascii?Q?xUZ281ZFUIKVPqTAHeKhe+gZ3U/4QXqaBzhJS0sKTENp/D7PuUUjVsnyOTfM?=
 =?us-ascii?Q?GULZlxHp3QgmyytpoK0oFC4kVIXOhkXcrUeAyqzREP8W2+GCN+RcWSSr5FcW?=
 =?us-ascii?Q?8Wew3gx0vMzYJa10HBPTuru5rcMIEeBRmiAPBbPwWUu6Gq8oGM/jyMceuDgD?=
 =?us-ascii?Q?mdB8IpQpHp17MYgI5rrPMY1w1vmgvsi0r0mUgzdsW9W994hrKTsNJEJRjti6?=
 =?us-ascii?Q?LOHd6u1YDPiUZ+X/h93i0+J69usmhcZzYGUjrHQtJUQTj1QnO45/kHH0YWdn?=
 =?us-ascii?Q?2WV0KNqPr6Vp5u3mHpIxpdO0xpjn7Q2PzosQ1bo0n+qTvVhPRGsFj9C/rYPL?=
 =?us-ascii?Q?Aj4Fb3pS5n8sWlbvvlyD/enS+ZOc4hlAyp9NLaWPbMb0zmkvA4nidMCSX1Tw?=
 =?us-ascii?Q?wgDEYaTPX8EtLM3b/r3/F2KlTo7KSC23U5Vk0NhR0Xy4MUYzCiXyvxg79DEh?=
 =?us-ascii?Q?aLqltKhAzD63a0NDjky9vWBg+f/2fv51vZZEoSz1PwMbgCwoFvzizA4ZUAXm?=
 =?us-ascii?Q?/gg+JirjI6mcs8FK1nxi/3YmoTdp1IWJWEWwJwR3u9WOtqb0CbpnoOp8uwoW?=
 =?us-ascii?Q?osCt4dr2It4qHDS0znfaZWXG1USOYxN9c8J6tbpYjt888vnr2zrY5QHwLtia?=
 =?us-ascii?Q?jSOSztkzdjUA3zwYbJFeqkWUtWtXfoInSKeoXHOM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef94d78-46d2-492e-3903-08da5fe52a23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 06:51:48.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: olHLI8tg5ksa5Zfsww4K10DnETS+4CqKYtk2UXwrbwfCJ7IDLFMlayQdxrFBF93psQ+SENAeQIFjwEjeW8TjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3987
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
> Sent: Wednesday, July 6, 2022 1:08 AM
>=20
> Currently we rely on registering all our instances before initially
> allowing any .probe_device calls via bus_set_iommu(). In preparation for
> phasing out the latter, make sure we won't inadvertently return success
> for a device associated with a known but not yet registered instance,
> otherwise we'll run straight into iommu_group_get_for_dev() trying to
> use NULL ops.
>=20
> That also highlights an issue with intel_iommu_get_resv_regions() taking
> dmar_global_lock from within a section where intel_iommu_init() already
> holds it, which already exists via probe_acpi_namespace_devices() when
> an ANDD device is probed, but gets more obvious with the upcoming change
> to iommu_device_register(). Since they are both read locks it manages
> not to deadlock in practice, so I'm leaving it here for someone with
> more confidence to tackle a larger rework of the locking.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
