Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B254AA4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353610AbiFNHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiFNHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:16:48 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832603C4A9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655191005; x=1686727005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOMJ9wLfoNqGl4MRL0O2orAa+q01k5q9ZMDa6qayy94=;
  b=igNMwrf202lSiNzO/Lu6muP59gfYiBcH9Ske2zGwlB4zKqv75KUedb9w
   stQdme2Z5lajybBzc/Vu1LfVFDSzOUszn6MaV8W4shc1nTt9WueEzknfK
   ywZZ0vYPTrw2UAcnyr0yQrYuP0RCkI9G2/3PKRTUP3hmk79dh+WtGnzkf
   WYWA2o8HBFzfQQNOQ1cY7XSxvz+Sl1xE9GWRT5gfYSHP0/gPBwyQ1FTg7
   /lIqeoDlk72GpA+QhphvHdr20fulD6pFmuoAHtZutg+mgd6nSpz8ihKk6
   Cdu7HwNqQ+jDG3hqaHY2TxSVq2CXN0c0dCrxP99GSc5zbJhCzw9nHgNGr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258365905"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258365905"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910834497"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jun 2022 00:16:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 00:16:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 00:16:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 00:16:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+pMMIaLMzOzAA09hX175divLGnZyTpY9QJl6cofSTUa5HVpN2v8FePyD12zY7TSmLE9LFm9V3CEnZGvp1KuGnz4rYOYdz+zcB1MKzkIVQGVQqVrp/TaaIHp2n3ri5byl9wkBf+r8yQT1xh1fbTIkzzJvaEYDB4GxHbALTV4e/Kqv8YkXupKn6n10GvmvfXvOX8fpUz88IrASDaITc2ylJM1NFuDJcDA2kXf8qnpvFu7bCUDxsnRIGd7RO0a1CqyHSIIpi3vrgLBHSriViarCGMUffXRmGE1+7OrI/WQ5F3UvJklmzOjo9Rl36f7VmCVsKBlCcOGgg9kQNLRR/qiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Q7YozYfz/rY7O6R0nRnWG9GUOd8ikWsSf7yZE8l96M=;
 b=FYtl4Q5O4n/0JmFmvuC4k7raP+jmESQJO28r7lAgncpW6p5OeLp5WoxTYaivACBx6rxlME8uqd3u3YGGjXRg8kXz4VbvVeSxNrKs/78VEYLPyTgCqEpSj8HsNR9VYDQpx9pro01Wf0lhu9xmwB7+fSNHBGK9HvW6tp+b4qSmvLH/wGHKujISaVFj54VW4uB0wJWPlKNW9vkEW5nW6Bslm6To6+xo5ntOiEpjyHEMm2X8Ztvzt3y66DxSCQI+lpUoFu5qGfABb4tEYdG5UzmqCei30l6sU/pRapM1Zf6181piN4XDuj3E35+aAY2iY01+ra9dP8ihLWA/YeQ3rQNQlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 14 Jun
 2022 07:16:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:16:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 11/12] iommu/vt-d: Use device_domain_lock accurately
Thread-Topic: [PATCH v2 11/12] iommu/vt-d: Use device_domain_lock accurately
Thread-Index: AQHYf5pR36hR4UdJTk+LBkAKKigPdK1OfMnQ
Date:   Tue, 14 Jun 2022 07:16:17 +0000
Message-ID: <BN9PR11MB52764D7CD86448C5E4EB46668CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-12-baolu.lu@linux.intel.com>
In-Reply-To: <20220614025137.1632762-12-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1936ab95-be1e-4c75-770a-08da4dd5c684
x-ms-traffictypediagnostic: CO6PR11MB5649:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR11MB5649EFC6265D8AA07032369F8CAA9@CO6PR11MB5649.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JI09Y05h/rasCA63WI3o7uyLNF/fZCe3izum430ONpoF4ywtmBfAPAMa8b0xeuj23sIl0tqgSiyFKww+lO5hKvrzJeeWsQtbrS2P0zWLvtrqZZV8iL9c+eJDAUyAYXFj9FQ2ZYu+7/gxWvBa4b3maVXUZVbJfgAVBADR8K4tlRqAlCeCztjM0tkjZyYr90of0Y/Hzs+TKCjEv7hVONVvkERbi06zHuWx11i3IOwLPE8IO53RjMmD1mvBo68KJHw+gDc49EFVUxopK+0iGjofLjYLbhhRsgAYDyFeLpRlWbBDH0HdYxewtK1G56FPlhW4Yo+l94EOhlfF9j4v2hsAgaB+yHNvOjTOva7Jr0HvXkPs2QXg7DATw7vXldWKAD8IZSPOjwhAj7Urvl1TYZj2RVB0OR5mYkaxEs7+Sz9MwFtLZdR/qqivUPw0GoH0yEvcS0yICn+JZZPdf4MKunAMX52OdMWZOCz21OtSUp5P7IaMnF/QIZzG+SvG6panGSlYXKY+ZUsLkEeZcFNDdPKtoQCfb7Uhm5e+uBHM1bo9ybpHb/+ShhH4ma4Oa9RbdANWxauvPd5fj30vbg2fnoEq7JfZ95PODyif94S74xsrBiZcJMYRjBkhk/KN1B29m5zOUU2X/dvKoLTAUMmZKrTKajhSXqK9HnCLcdoHiypUFdqCKGjUYAC6qlfZThyVccrSRcMBWRmZW5z7ynwbvM9nSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(54906003)(71200400001)(38100700002)(8936002)(2906002)(38070700005)(9686003)(508600001)(52536014)(66556008)(66946007)(4326008)(64756008)(66446008)(8676002)(110136005)(66476007)(76116006)(5660300002)(7696005)(82960400001)(55016003)(186003)(26005)(6506007)(122000001)(316002)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?guBEFf9BUTTyuMUuDq3Lb6Sv1zpgCNu9yxoraZCznjLL99+cTYwOeZqZLGJg?=
 =?us-ascii?Q?h7ESV+/IbPwjfw6ui3zVj/QUXyHc1HoKI77wX9fHnjQjN2CcJCf+XHRSL5vv?=
 =?us-ascii?Q?25g3PG3F7OLNwqGiAR1GOENoUJbX+qQEGyjul+X57WmbW8UCyPcis2B17Ro/?=
 =?us-ascii?Q?Au6ilBTeYk0jeM2C4xtrEFkzQSAkiAIrZ3JksamGSEEgkT6+hBRRBgbvz5XW?=
 =?us-ascii?Q?GoXLCU5Qaym2VykiVVXdFTedgM1xS10aMKBo5R70kMYOea/CFQ2R3OQp6ZeW?=
 =?us-ascii?Q?uu0v5zLUB1qTuzSw89rvwE/hLyN61+4HiqCa4iWxGWekciayOm6k7j6cvl5+?=
 =?us-ascii?Q?bi0E4wX0xWwA21YOxvdn+zi9TjZhfx5YFukNSjHjfxfDqLahIkW+vgChIPRc?=
 =?us-ascii?Q?HOkSzXJhbOkQF5UZSuUc2Q3Xef9vI1NTkL255hE3vwGPVX+Jh+ODH0lNGmTZ?=
 =?us-ascii?Q?2DMLoKGoBSsooUjSXYH+kF+zUBEFZtENGwWEsJ+FTwvsFRIbFLknF54O9j9k?=
 =?us-ascii?Q?On+rmGsmJ3Fpx2809SZ4uznQp+RNHFp55g1vw/eH4erj5FaxmoQaXo2YOVmB?=
 =?us-ascii?Q?zB/+9GUuozMwX8+VMJt4rDSaEQsw+hEMIWZzROrtMsAo47IYWv/oxZBd7oLR?=
 =?us-ascii?Q?8vdSlxBwcmsiD75aMy7m8vDhhRh/q8VL+EZRygcqE4DSJLwRDQmaMM/EZHCP?=
 =?us-ascii?Q?gyHNwHtLo32Bu2M5ZwQKVc0H9q/LFI/ZgryRZN0M0E4hG5FSvEnChcTzMrsa?=
 =?us-ascii?Q?tfLc2tnjsJ26CmstV7Xm1XGCjj3VLTB5HQxs8bqi3/UVf8cquBboOKlkSUcO?=
 =?us-ascii?Q?12d4EQOJ1Psug1Vo5HT2N+zL9kdRU7SgYYFfeVWJ7bePZt4C6gXgS24UemuX?=
 =?us-ascii?Q?5zNwfHuJAGLk0Dq0rVDVOjvK6r0nueODbiZ90uV6f+jIoSqtqZbT8oDQegu0?=
 =?us-ascii?Q?DIt/HyktQ541dsV1bZhlUEmNaT8uRFaF0t7GumYQ4CKPFTX5IA7z9wm2kyKI?=
 =?us-ascii?Q?3hgdMedkqedhKbfVr1V+Sou95GU5GYZh7pzdg6eRQF2wAACiOEWKsiPiqWch?=
 =?us-ascii?Q?xTaztCUkOR6eS15SvOpX2c1/mNhlBV/M2i/JrsI0i1/6llR1+Or1g1/XMOOH?=
 =?us-ascii?Q?N6OtwfXk1tv2OFXHP6ljIEZjuA9HdcxAjKzWi6COPeOQW+UJhbHgWznoMzKO?=
 =?us-ascii?Q?9rYTUspJAqFLfWj6hysMSlXw55Y9boFNpvSKd26z2R3wg7Y61DvDN8JZ9Pw1?=
 =?us-ascii?Q?xwnJXuIhgnbk4azVDLP6plpWz6ymK+QL5sDcxMau88W3SFQEIvDr/S2F8O8r?=
 =?us-ascii?Q?ACnlssX0qI4ugW5btVVvjIIAjm8OLgACIuhg+8GtbnvOK80xwsjvEqNWRvjg?=
 =?us-ascii?Q?FfCIOrPjGr6m28XgwLpurqUjF3famssgio7KSeSXuu+2lJcsm2jH6zU6XgOD?=
 =?us-ascii?Q?g/+oMziUOzaqpEi9JHlvRxU1Vs5Xz18wiBbk6yHjcIvp8R00puzccyODdW1Z?=
 =?us-ascii?Q?nqMVjqFoZhib020SHMfRMahrDea2hS9AWu1XdTlAQbmSSW5os1cGIK93LVrx?=
 =?us-ascii?Q?+OG4e57AS2PfY3fdYX4/kPse8pzzAIOOBwPgT0EJTgr2h/osGuZQokii04G2?=
 =?us-ascii?Q?yQfJCmUhGX8G7knSk+2RDrx6CrrNlapJtE6QGHD2zznzS1qjbHFEGNfjlRzf?=
 =?us-ascii?Q?2ZWozo2JsmUBRPDqDAwob0g6bZYvMeJ0rX9io6kJOtn4+gHW8v3Awul3JfZl?=
 =?us-ascii?Q?oacPRqHWCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1936ab95-be1e-4c75-770a-08da4dd5c684
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:16:17.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUCOmUlP32LEvkkoSmgZrRi7RAUc2HT4DlGmTI9iN6CqvRR8E/yiAhCtvECwlufZGpFp2OO00ci7jloRgsGbzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 14, 2022 10:52 AM
>=20
> The device_domain_lock is used to protect the device tracking list of
> a domain. Remove unnecessary spin_lock/unlock()'s and move the necessary
> ones around the list access.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 68 +++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 41 deletions(-)
>=20
[...]
> +iommu_support_dev_iotlb(struct dmar_domain *domain, struct
> intel_iommu *iommu,
> +			u8 bus, u8 devfn)
>  {
> -	struct device_domain_info *info;
> -
> -	assert_spin_locked(&device_domain_lock);
> +	struct device_domain_info *info =3D NULL, *tmp;
> +	unsigned long flags;
>=20
>  	if (!iommu->qi)
>  		return NULL;
>=20
> -	list_for_each_entry(info, &domain->devices, link)
> -		if (info->iommu =3D=3D iommu && info->bus =3D=3D bus &&
> -		    info->devfn =3D=3D devfn) {
> -			if (info->ats_supported && info->dev)
> -				return info;
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	list_for_each_entry(tmp, &domain->devices, link) {
> +		if (tmp->iommu =3D=3D iommu && tmp->bus =3D=3D bus &&
> +		    tmp->devfn =3D=3D devfn) {
> +			if (tmp->ats_supported)
> +				info =3D tmp;

Directly returning with unlock here is clearer than adding
another tmp variable...

> @@ -2460,15 +2450,14 @@ static int domain_add_dev_info(struct
> dmar_domain *domain, struct device *dev)
>  	if (!iommu)
>  		return -ENODEV;
>=20
> -	spin_lock_irqsave(&device_domain_lock, flags);
> -	info->domain =3D domain;
>  	ret =3D domain_attach_iommu(domain, iommu);
> -	if (ret) {
> -		spin_unlock_irqrestore(&device_domain_lock, flags);
> +	if (ret)
>  		return ret;
> -	}
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
>  	list_add(&info->link, &domain->devices);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	info->domain =3D domain;
>=20

This is incorrect. You need fully initialize the object before adding
it to the list. Otherwise a search right after above unlock and
before assigning info->domain will get a wrong data
