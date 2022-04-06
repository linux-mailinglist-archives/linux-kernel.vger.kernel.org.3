Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA54F6EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 01:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbiDFX6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiDFX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 19:58:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14FF1E93
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649289395; x=1680825395;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6pogIEWcprVMn2iQ7JwaH7NWkHtW2Pz01V0euW/3K4k=;
  b=Pnv50dGQEZZ4urZnmykTiDZoaJLGYIDDlTzq15TKMvIjMe67v4PetETY
   mMdxOkJE9QlGUgbwbF+I0lN13zmcpMC97gH+qMJP+zmTp33uqqCX3Qqmm
   hdQOIx6Ex2wVehzozhlWWh8X29DOHRTPrLMg52xJgA807k3klH/T65Dml
   VfdE9tnVjOPlC8kOZiC3Gf4SPCO7hqZyoPVivxzu35l6h14xb3c5/cjiz
   NA1jnoF1HsNZmuBIIT9dwmnYFNv10mJss8yKnpdrCCKDz88XQ+t5Nte7w
   o7JUJpxzmCfHvBWqwFz1N9T9lY/yKEuT2wIfwT3MtWhLDKz9M6JKwQq0u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="347629676"
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="347629676"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 16:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,240,1643702400"; 
   d="scan'208";a="557158441"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 06 Apr 2022 16:56:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Apr 2022 16:56:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Apr 2022 16:56:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Apr 2022 16:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOqGaKQ6fftlYe98ZmcsxbfqpXEEiqTktlX+ZBJunxHlvnLY5AtPZKfuG5YzKshp2SCQoSauc/3zp6cCf3uERk3kdc3vmarIHUlAFgOS8q5kBZ+dWWhQZRi9nG+hNR8yZYYrKSKlbAUypVl7uRnzOc/Y3w0szOSY3fM43XKntvIvkd4LLvahcAW2V/C8Hgjvg5beVE4YIH4IU0Zc0LcbXzZZhgZjj7i3XVKfgxrTU/y+P2iwMUL0j+beoI6LJxhzKp5AAKKofbAW8w+5dOlrDlyK16UGbQcam8NL0d2w7DY7VQTaWXE1hc+DGWAJXSMp7cBYk5gcpjKpu45VrfSK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pogIEWcprVMn2iQ7JwaH7NWkHtW2Pz01V0euW/3K4k=;
 b=Z2WvISB1N4GEnoDAzkNYUKDfEJpDRsf4h1l6mkmpW6hUMF3R5QDx0C4clCEeAyKyPfXScquWmFYEfa0Vcj+AzkSZ9YFr0hJf7xVAyBskFV1kXula5eYjvgMMrWcT5BaCH7TLLLIF/U+X0RLQ0Ngr3LKIJjRikTONda5rQT5B4lqoec5tA4z9QLDeH8jZ6enhWnpz8bc4Dkxk+ozo7Oh4KT1odw3BPObEYdQdJ3GsKeYiajqipxvJ+9vaqkraizRwc+2cTldB3bU8ExVmiz73s24DW+lhjYYCuLihRobARNA+zatI+TIqDp9IDwW5Yl/Km+ttuI0cIAJL9BzInyx7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5761.namprd11.prod.outlook.com (2603:10b6:303:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 23:56:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::c4ea:a404:b70b:e54e%9]) with mapi id 15.20.5144.022; Wed, 6 Apr 2022
 23:56:24 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Subject: RE: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Topic: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Thread-Index: AQHYQy+FyOvFomDYNUS+m4eyrODKe6zWBZTwgAA4VICAASjOcIAAbdAAgAAjg7CAAAbnAIAELxCggAaGagCAAAkkMIAAB+MAgADXqPA=
Date:   Wed, 6 Apr 2022 23:56:24 +0000
Message-ID: <BN9PR11MB5276CD0EB0222283DA885D858CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
 <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
 <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a5542ef5-bacc-f527-0295-ffdedefcbdd9@linux.intel.com>
In-Reply-To: <a5542ef5-bacc-f527-0295-ffdedefcbdd9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab70909-67e8-437a-d0de-08da18290edf
x-ms-traffictypediagnostic: MW5PR11MB5761:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MW5PR11MB57616CF7928A207E9FBE54828CE79@MW5PR11MB5761.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJyyn1DP23zFYe1bIqLoAgQ8mbBrAkgul0bBf+J6uXucpTK/0gpmejo+6GZxCw1+DyaW6XZ+gRxxmU+sqkmA2KHaW3YF5tF2HnzAwm5Cda0LVKbwpEINnfVhxd35hoTUMPJGS39lnPMYMhVSzKOwYjEGyVBhbXLHlMw4cmIOOa5CoXmYd8zW5FM5HUFH1xcapPlopC7SSarrE4ysiI8j2NbTyp1ME21AqjYJ63XA86iGCV1IUfyxungnZp9E6LO2wXGcGb8skBpfq1zElUxWUIRdkqqo9x0AUSxAhuvvpkEYQBRFvjFPPoSm+pXl4PfUZ8iWLTyQhIghARBnKxVU6gMWQLcHThd3jgcR9a1KjUn7O6EuVbjDmKC/FwVhGunudTVIrVBlT9x/ETDI2Y4enEetk+FfVPBpmozD8PVZ8dmkXJU9CtpC7eOjWyBGcrxsb88eKPII2hLHBFu3LtloKK3lVZOHN1aW+nMIFf3Zdfm52z+sMmOm7DTJ75svLRUsYrn2y3ajLgUwfCqFvYT+FNLDNpNCc3YlFF+DDltUCRDBy+aAHwMepa3lKlw3I9ZSvJDAe5dMSvhHNONyAHEYb41ZpGe4moyiePIWeG9feS7NZDkOkcGBJ47lbXjb9HRgonsPxv2XkBqmo0/2MGJ6oOX0u8roz+YkX/ERZbqB/I6G/GWBESccBj3BtaotjmvAbNqxuJAOJuBw3AX/ib2gEOq0B3NuTMep3dtn0KFgPNyXRcCrhA5TBiiWp5E6wDFj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(508600001)(53546011)(86362001)(9686003)(7696005)(52536014)(5660300002)(8936002)(26005)(186003)(71200400001)(38070700005)(64756008)(4326008)(6506007)(316002)(76116006)(33656002)(8676002)(66946007)(66446008)(66476007)(66556008)(38100700002)(82960400001)(110136005)(122000001)(54906003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDVNYXVUeUtzOEFRdmU5Z2JicUd3NzZmVkJQRjhUUkNYbDhQSDBsTFh2aXJh?=
 =?utf-8?B?dmlkR0hERkU2bnlIOWZuWDNPU2E5Z21jTGRnOEcvUVdRd3cwTndLOGcrNmI0?=
 =?utf-8?B?N2h3OE9XZkJuVHBubk5tMWxadUV3S3lKMzlRZE1Qa3hvUVk4dkl6NGxXTVBv?=
 =?utf-8?B?czlmTWlrckFrcWR1N0w1VWZVL3B5SS9leWtnL25Nbzc4MGVMZjNqTDZ5WGRz?=
 =?utf-8?B?QkJzSG1telFodHljZStwUDVtb0tYelZjczZacHgxeXk2NUMzeFkxNWw3RUgz?=
 =?utf-8?B?ZldTbkFqcmNoRDNSekZBSTJhdTZmQ3pySzNKNkdTcmYvVi9XVytHWUs1V0Rr?=
 =?utf-8?B?YUcxZlBTKzlScG5uUDlTQi9FUkNXZUE5NnRDVllpcU5ZSWdYOG82VW5FdWtU?=
 =?utf-8?B?NGJHYmhEYndTaWIzRHVRRDg1OFVhVTlkMnErWUtPOVk0VzhBMmVSOWNIeWZS?=
 =?utf-8?B?cWY5REtoY1pYcXhNTENmTUl3c09uK1ZySUgxZTUxZjB0cGZvWnd4U0hISjEz?=
 =?utf-8?B?RzFvRVAxUUZLeXk0NzF1MDlnV2dRY2dMcXJYTXc2cW1PdmdRc1dzdWJJRnFO?=
 =?utf-8?B?VDk4WVgzVzhmMnY3VW1uTitXaGpkUE5MSXBseEdLNE5uRVdEYkdMRFVTZ2dv?=
 =?utf-8?B?Vi9vamZSVktRa1p1dm5sM29vNDZHdktiYWdHV2c3UGVWcmo2RkhlTG1uZ2tD?=
 =?utf-8?B?WlZuUGhZZnlJd0Mxcmx6aTh6NUg3aVkwYUh1ZDZRZURMS1NKOEhpU3dIcFdJ?=
 =?utf-8?B?WUdTeFdONzQvR1VNTVVBQjJmRmFWZk4xaWk0Qy9wVW5JSUdOSEJFNEJhVjkz?=
 =?utf-8?B?OUMvRkVkZitGdEZObmp5VWh1RGRTeExETkhXYlV5aTR6RGg1akZqT2NueUto?=
 =?utf-8?B?S0JLa3ZMNXdRd29JTlBocTdySXFiQkNoamJJZjhrN2NSaktzU1lNWFNYaDdU?=
 =?utf-8?B?SHNJVkZHbHVkSGhtTFFLL09HUU9JR3g1b1lhZ2trb0JFMUEzVE5zUVZqR2FN?=
 =?utf-8?B?N3oySG1aTG15b2RmRTR3eUhPZG80QkFQYzQ5THphcTAyY0RubjB5TVlBTDVP?=
 =?utf-8?B?TDRCRnJVczZVdFZndStzQjQvVjA4ZjRDMGFKMjdtMCtXVXVIYkRPTWFIVkp0?=
 =?utf-8?B?OWo2aUxMVXEwYjRGdEZYMElzT3pzeUhxNHBCcWdYR0JWUVowYVFrYldodk1p?=
 =?utf-8?B?Y2JWOGRGdEFBeVR0K1ZId1dlZWtQZXQzdjI3bUo3NmdtSnpGa0FRSUx6OE1h?=
 =?utf-8?B?SHA0RnFkRm5iRnVBempSL0VzUE1ydkJnSzJkTElNRUhHTDh3TStCb3dIRmZS?=
 =?utf-8?B?SGdzMjdTWFA3ZFhWU3RqNWgvQnJ4NmNSV2JSSEUweWE3eTJTeE1ROXBUWWE5?=
 =?utf-8?B?WkF4ZDcvVFNwd29UZm5MQUFnd1JOSk5JL1ROTGs3bEVuaWZXZUl4Ykh2QnVj?=
 =?utf-8?B?Y21GeWRGNjdmZUk2bDY0M1FoL2JQQnpweHVzMDMxcDJtbDJla0gzUWU5aHYz?=
 =?utf-8?B?VHU5WGRtRll2Z3R6R2xTczdadi9QWk8vT2dnWXdwRkpXS2ovVzlla3FuTFV5?=
 =?utf-8?B?U3RNckp3SGdBWHM5Mm9RSGNkZWQ0d0ZxS2NrY1ptZjJ0Zm5rUHBEWWZoUXBU?=
 =?utf-8?B?dnRaU1hFOG9pK2hSd0VhdU9sQys0SGtlTVZtSjRZM044NDJvbDZIMWIzS1J0?=
 =?utf-8?B?S1I1NmtnZUdwRERIMXArNjN0Qm1wNmFvSTZGTGhSbzlkSFhJeGNEK05OTklK?=
 =?utf-8?B?YzZUZnZrSWU3RTQxMlg5bjlvelozNGVXWXgrU1Mvd0QxQkZiTzFRaWtMMXV1?=
 =?utf-8?B?ZGhMdkJWS1d2TXNvVHQwTDRCRitoOWJDZjcyUmdySy9aWkhCOXVlSkxZL05w?=
 =?utf-8?B?RGtKWnlLdklydkUyZlZOaGU0bTdPK05mdzFBZkk5QjNRVXRWeFgycTFkNXdC?=
 =?utf-8?B?ZVlUVnBvS0w3U3hFS0RkVm1vbEhLUlczSysyZEpDZnBUNEt1TUxzM1ZJa2kr?=
 =?utf-8?B?UUZYZnlOaFZLRXFrT0VnbExOUG5qdDIwQmZQZytrdFFvdmxRVVhETnJTUnVy?=
 =?utf-8?B?TVQvZDVGK05RSkxnUU1ZMlRyT0M4aHJ6NU5OdnJEbTlZN1JCdFFmcmtEVDVq?=
 =?utf-8?B?Z1pocnFENzBkalI5dmFQUzJVYytwcW83RlJwTWw2VXBFSlBlQS85L1Y3SVdw?=
 =?utf-8?B?SmZ1djlOL0gvazkxYWMwUnBGOHV0Q1VmYzdwS3VyYzRXM0lzNGs0dVkzeURx?=
 =?utf-8?B?cjAwcDE3bmZYZXkyTVo1aExKUTBscXVDUFFxeXFsYm9OSkVHYWQ0U2ZUY0Z1?=
 =?utf-8?B?U0tmMjlDNktUVmlrQ0hkb3NWeFpoQ2JnV2QzTzBWR0J0WnJ6TktuUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab70909-67e8-437a-d0de-08da18290edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 23:56:24.7371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z6jBGcZ75yS5F2bRMIfoDDFwlDZQD5AVKTQDbIOFAP7jbLcfdhRZnmh1OBEXLNLY0Kin8qMf3pyuak1tfqH3mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEFwcmlsIDYsIDIwMjIgNzowMyBQTQ0KPiANCj4gT24gMjAyMi80LzYgMTg6NDQsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDYsIDIwMjIgNjowMiBQTQ0KPiA+
Pg0KPiA+PiBIaSBLZXZpbiwNCj4gPj4NCj4gPj4gT24gMjAyMi80LzIgMTU6MTIsIFRpYW4sIEtl
dmluIHdyb3RlOg0KPiA+Pj4+Pj4gQWRkIGEgZmxhZyB0byB0aGUgZ3JvdXAgdGhhdCBwb3NpdGl2
ZWx5IGluZGljYXRlcyB0aGUgZ3JvdXAgY2FuIG5ldmVyDQo+ID4+Pj4+PiBoYXZlIG1vcmUgdGhh
biBvbmUgbWVtYmVyLCBldmVuIGFmdGVyIGhvdCBwbHVnLiBlZyBiZWNhdXNlIGl0IGlzDQo+ID4+
Pj4+PiBpbXBvc3NpYmxlIGR1ZSB0byBBQ1MsIG9yIGxhY2sgb2YgYnJpZGdlcywgYW5kIHNvIG9u
Lg0KPiA+Pj4+PiBPSywgSSBzZWUgeW91ciBwb2ludC4gSXQgZXNzZW50aWFsbHkgcmVmZXJzIHRv
IGEgc2luZ2xldG9uIGdyb3VwIHdoaWNoDQo+ID4+Pj4+IGlzIGltbXV0YWJsZSB0byBob3RwbHVn
Lg0KPiA+Pj4+IFllcywga25vd24gYXQgY3JlYXRpb24gdGltZSwgbm90IHJldHJvYWN0aXZlbHkg
ZW5mb3JjZWQgYmVjYXVzZQ0KPiA+Pj4+IHNvbWVvbmUgdXNlZCBTVkENCj4gPj4+Pg0KPiA+Pj4g
V2UgbWF5IGNoZWNrIGZvbGxvd2luZyBjb25kaXRpb25zIHRvIHNldCB0aGUgaW1tdXRhYmxlIGZs
YWcgd2hlbg0KPiA+Pj4gYSBuZXcgZ3JvdXAgaXMgY3JlYXRlZCBmb3IgYSBkZXZpY2UgaW4gcGNp
X2RldmljZV9ncm91cCgpOg0KPiA+Pj4NCj4gPj4+IDEpIEFDUyBpcyBlbmFibGVkIGluIHRoZSB1
cHN0cmVhbSBwYXRoIG9mIHRoZSBkZXZpY2U7DQo+ID4+PiAyKSB0aGUgZGV2aWNlIGlzIHNpbmds
ZSBmdW5jdGlvbiBvciBBQ1MgaXMgZW5hYmxlZCBvbiBhIG11bHRpLWZ1bmN0aW9uDQo+IGRldmlj
ZTsNCj4gPj4+IDMpIHRoZSBkZXZpY2UgdHlwZSBpcyBQQ0lfRVhQX1RZUEVfRU5EUE9JTlQgKHRo
dXMgbm8gaG90cGx1Zyk7DQo+ID4+PiA0KSBubyAnZG1hIGFsaWFzaW5nJyBvbiB0aGlzIGRldmlj
ZTsNCj4gPj4+DQo+ID4+PiBUaGUgbGFzdCBvbmUgaXMgYSBiaXQgY29uc2VydmF0aXZlIGFzIGl0
IGFsc28gcHJlY2x1ZGVzIGEgZGV2aWNlIHdoaWNoDQo+IGFsaWFzaW5nDQo+ID4+PiBkbWEgZHVl
IHRvIHF1aXJrcyBmcm9tIGJlaW5nIHRyZWF0ZWQgYXMgYSBzaW5nbGV0b24gZ3JvdXAuIEJ1dCBk
b2luZyBzbw0KPiA+Pj4gc2F2ZXMgdGhlIGVmZm9ydCBvbiB0cnlpbmcgdG8gc2VwYXJhdGUgZGlm
ZmVyZW50IGFsaWFzaW5nIHNjZW5hcmlvcyBhcw0KPiBkZWZpbmVkDQo+ID4+PiBpbiBwY2lfZm9y
X2VhY2hfZG1hX2FsaWFzKCkuIFByb2JhYmx5IHdlIGNhbiBnbyB0aGlzIHdheSBhcyB0aGUgZmly
c3QNCj4gc3RlcC4NCj4gPj4+DQo+ID4+PiBPbmNlIHRoZSBmbGFnIGlzIHNldCBvbiBhIGdyb3Vw
IG5vIG90aGVyIGV2ZW50IGNhbiBjaGFuZ2UgaXQuIElmIGEgbmV3DQo+ID4+PiBpZGVudGlmaWVk
IGRldmljZSBoaXRzIGFuIGV4aXN0aW5nIHNpbmdsZXRvbiBncm91cCBpbiBwY2lfZGV2aWNlX2dy
b3VwKCkNCj4gPj4+IHRoZW4gaXQncyBhIGJ1Zy4NCj4gPj4NCj4gPj4gSG93IGFib3V0IGJlbG93
IGltcGxlbWVudGF0aW9uPw0KPiA+Pg0KPiA+PiAvKiBjYWxsYmFjayBmb3IgcGNpX2Zvcl9lYWNo
X2RtYV9hbGlhcygpICovDQo+ID4+IHN0YXRpYyBpbnQgaGFzX3BjaV9hbGlhcyhzdHJ1Y3QgcGNp
X2RldiAqcGRldiwgdTE2IGFsaWFzLCB2b2lkICpvcGFxdWUpDQo+ID4+IHsNCj4gPj4gCXJldHVy
biAtRUVYSVNUOw0KPiA+PiB9DQo+ID4+DQo+ID4+IHN0YXRpYyBib29sIHBjaV9kZXZfaXNfaW1t
dXRhYmx5X2lzb2xhdGVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+PiB7DQo+ID4+IAkvKiBT
a2lwIGJyaWRnZXMuICovDQo+ID4+IAlpZiAocGNpX2lzX2JyaWRnZShwZGV2KSkNCj4gPj4gCQly
ZXR1cm4gZmFsc2U7DQo+ID4+DQo+ID4+IAkvKiBFaXRoZXIgY29ubmVjdCB0byByb290IGJyaWRn
ZSBvciB0aGUgQUNTLWVuYWJsZWQgYnJpZGdlLiAqLw0KPiA+PiAJaWYgKCFwY2lfaXNfcm9vdF9i
dXMocGRldi0+YnVzKSAmJg0KPiA+PiAJICAgICFwY2lfYWNzX2VuYWJsZWQocGRldi0+YnVzLT5z
ZWxmLCBSRVFfQUNTX0ZMQUdTKSkNCj4gPj4gCQlyZXR1cm4gZmFsc2U7DQo+ID4NCj4gPiBpdCdz
IG5vdCBzdWZmaWNpZW50IHRvIGp1c3QgY2hlY2sgdGhlIG5vbi1yb290IGJyaWRnZSBpdHNlbGYu
IFRoaXMgbmVlZHMgdG8NCj4gPiBjb3ZlciB0aGUgZW50aXJlIHBhdGggZnJvbSB0aGUgYnJpZGdl
IHRvIHRoZSByb290IHBvcnQsIGFzIHBjaV9kZXZpY2VfZ3JvdXAoKQ0KPiA+IGRvZXMuDQo+IA0K
PiBZZXMhIFlvdSBhcmUgcmlnaHQuDQo+IA0KPiA+DQo+ID4+DQo+ID4+IAkvKiBBQ1MgaXMgcmVx
dWlyZWQgZm9yIE1GRC4gKi8NCj4gPj4gCWlmIChwZGV2LT5tdWx0aWZ1bmN0aW9uICYmICFwY2lf
YWNzX2VuYWJsZWQocGRldiwgUkVRX0FDU19GTEFHUykpDQo+ID4+IAkJcmV0dXJuIGZhbHNlOw0K
PiA+DQo+ID4gQWJvdmUgdHdvIGNoZWNrcyBiZSByZXBsYWNlZCBieSBhIHNpbXBsZSBjaGVjayBh
cyBiZWxvdzoNCj4gPg0KPiA+IAlpZiAoIXBjaV9hY3NfcGF0aF9lbmFibGVkKHBkZXYsIE5VTEws
IFJFUV9BQ1NfRkxBR1MpKQ0KPiA+IAkJcmV0dXJuIGZhbHNlOw0KPiANCj4gSWYgIXBkZXYtPm11
bHRpZnVuY3Rpb24sIGRvIHdlIHN0aWxsIG5lZWQgdG8gc3RhcnQgZnJvbSB0aGUgZGV2aWNlDQo+
IGl0c2VsZj8gQUNTIGlzIG9ubHkgZm9yIE1GRHMgYW5kIGJyaWRnZXMsIGRvIEkgdW5kZXJzdGFu
ZCBpdCByaWdodD8NCj4gRG8gd2UgbmVlZCB0byBjb25zaWRlciB0aGUgU1JJT1YgY2FzZT8NCg0K
U1JJT1YgaXMgc2FtZSBhcyBNRkQuIGFuZCBhbGwgdGhvc2UgdHJpY2tzIGFyZSBhbHJlYWR5IGNv
bnNpZGVyZWQNCnByb3Blcmx5IGluIHBjaV9hY3NfZW5hYmxlZCgpLg0KDQo+IA0KPiA+DQo+ID4+
DQo+ID4+IAkvKiBNYWtlIHN1cmUgbm8gUENJIGFsaWFzLiAqLw0KPiA+PiAJaWYgKHBjaV9mb3Jf
ZWFjaF9kbWFfYWxpYXMocGRldiwgaGFzX3BjaV9hbGlhcywgTlVMTCkpDQo+ID4+IAkJcmV0dXJu
IGZhbHNlOw0KPiA+Pg0KPiA+PiAJcmV0dXJuIHRydWU7DQo+ID4+IH0NCj4gPj4NCj4gPj4gSSBk
aWRuJ3QgZ2V0IHdoeSBkbyB3ZSBuZWVkIHRvIGNoZWNrIHRoZSBQQ0lfRVhQX1RZUEVfRU5EUE9J
TlQgZGV2aWNlDQo+ID4+IHR5cGUuIENhbiB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBhIGJpdCBtb3Jl
Pw0KPiA+Pg0KPiA+DQo+ID4gSSBkaWRuJ3Qga25vdyB0aGVyZSBpcyBhIHBjaV9pc19icmlkZ2Uo
KSBmYWNpbGl0eSB0aHVzIGJlIGNvbnNlcnZhdGl2ZQ0KPiA+IHRvIHJlc3RyaWN0IGl0IHRvIG9u
bHkgZW5kcG9pbnQgZGV2aWNlLiBJZiBjaGVja2luZyBwY2lfaXNfYnJpZGdlKCkgYWxvbmUNCj4g
PiBleGNsdWRlcyBhbnkgaG90cGx1ZyBwb3NzaWJpbGl0eSwgdGhlbiBpdCdzIGRlZmluaXRlbHkg
YmV0dGVyLg0KPiANCj4gT2theSEgVGhhbmtzIQ0KPiANCj4gPiBUaGFua3MNCj4gPiBLZXZpbg0K
PiANCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0K
