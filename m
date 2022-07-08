Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB856B270
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiGHFxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbiGHFxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:53:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E4675A0;
        Thu,  7 Jul 2022 22:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657259586; x=1688795586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=B88OI13T9AOCl2xRmH19O9YQwbidXqcydy2l6bCFZAM=;
  b=OFN8VXNf3ol4noEJ5ORJ0/wIqZRkYSmp7Xf/aAwuIxugZptIwiluL5I8
   u5K+yDt6sbldPjxFn4NM/B2WcbpHgrtPME7WGSMM2Za/bmiD/4NY75A6l
   3FjoxaycItzloEy5sr1IbWut51R6V/2W/WUgPgzUCD2GcHlZoKn9nr5Cq
   nHZGZq/lwKE7fFfO7DwY0EbpFoDgF96LQkN1RouQ7bnGUi8SxH0T0mjZ6
   LrFnxzGS3l5Im3kWvRu1jqQFNf0pSF8boOXG882UAW0feqANc5aTk95a/
   ynAiocl6tpePXzxxyoLl3rdU8TH0GOhg3JgW2W2OHPdyouyVWFzg9WoGB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="267228956"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="267228956"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 22:53:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="621086427"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 22:53:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 22:53:05 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Jul 2022 22:53:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 7 Jul 2022 22:53:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 7 Jul 2022 22:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRFIuXOskab9w8HXdvg0M2Mrnu7gMp/vs7Zj6lWeiX5c50l0TuAmudQznPfkeshkamaC+3Y13740MP6fP1AMwy7Jbw/rVMLnXUBge0ypzZ9243jfpLgoLwhGdNjiDgRtbMnsrfAKwI04i7Toy17MtHzt469wh/ez5QnaZO+2g6paPMonSjdWAAhRm9uW+eU1Sl5aJQpYInK5SMLYUKiZd6ZnRwHbSJ66sxyxtLvVcI+dSrx8llwOojzpA2q0NNHDuvrHTPlXMoFXp2CSEF0FLiQNdM/bFpy2DfozI4AG23ldHrm5EtTiyepYt2IjW/bGeKvbi+XjSOxiDyxKbz0PlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B88OI13T9AOCl2xRmH19O9YQwbidXqcydy2l6bCFZAM=;
 b=B+cy9JFTKiCla13g1GcdWsBmaKcnH6zClYtxZIaAZNvhihxYXiPy+6ogDFf3jmSclzTJUnQ5+z9qhAHmW4KeqBrejRKraAvllZfhhCplMTjIxMBNxzXXXW1/D5RE3QrzPxmrQdbQTTxWYfXU0fVVrMBcWczRRJFTJBo/x7P4YAVqoKBeoDZiceF77EQA37BzqH9CfGYVG+MP5NAER1BOmDQwKlphyBMNu2PNOS8EwbLrrKkPqT57vSqbvNvAuJN6IKGdaf60AspZqM2FyF32dpJnhFZbRiSbDTjozgnpmeEbU4/yJQ6fgebhlX+egxvftGjflxoRJFebYIdNBz8MVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN6PR11MB1474.namprd11.prod.outlook.com (2603:10b6:405:c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Fri, 8 Jul
 2022 05:52:32 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.021; Fri, 8 Jul 2022
 05:52:32 +0000
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
Subject: RE: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Thread-Topic: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Thread-Index: AQHYkJHwF7q1lwdLwUOXyHWeZ9Wy4K1ydjbAgABJkwCAATzSgA==
Date:   Fri, 8 Jul 2022 05:52:32 +0000
Message-ID: <BN9PR11MB5276C1C35BB1E22D68C3E2A08C829@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
 <BN9PR11MB5276ECD0D25C09D6A3686A3B8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
 <569e97f6-f78c-1eae-1023-2d5e2df2d40f@arm.com>
In-Reply-To: <569e97f6-f78c-1eae-1023-2d5e2df2d40f@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3074ca75-7f30-4f1b-3538-08da60a60cce
x-ms-traffictypediagnostic: BN6PR11MB1474:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YGRyykkyiOxSVq1+Byd4JdTyYE/dT5BqHql190+ZMAKus5GFsx74VxIVLEpcWwobeoId0WsPEAWNmgaWII4WhkhzhBrXe2r0ilBcxDRii8D/xZhnvFHPcJc4MbS53F9GB+ZqQFbTuYeLtFptTHvn2j+h6oeQmkxKkg2m7hstaJeLlwC2DXhL6aZ5MZklYaVdQZH5LtpLoE4kiCZag5uJHTymqUcydDflnTEIuywQFSh9Arplip7hg25awn3d43UWURrumbffl/IamAnOOxXSWDr7TKd1VQiWDKQ1kxUyXdcu+HlrxuoT4yI+QgeQJPabwjO6/8/6YzvKKI2Yb135ucgpuujM4nGesoFK8ikooMAdHirN8uMninpjJn8bA20VtbZdVYNV1dqV668KMry47kDNXmsz+JD3nQvpNVYVKeQYnOnNOGtFg+5SWd+rx7L4BJ00l8IBaKZF0YoXUeSIZFF3SzG+3cIGnQSJjvwIPJvOWPpBBXAgoLJih0TRqiHoGUK7kYqVaKWmsTJI2mSeBHdbXhW1MrJ4w5arvWnBI8GwBZt1EE0fIPJRaFK4aWS599l4MWD3GYC7nnm/cg66QhyS/QRq9QOFgulMDc9VZ4T10fpG/Mm4/VzqOymBmy+le8TA2KAlTTxBeJxtB1Lj3DbgnFW0FreseNb/sv+5APLxjLH2jHLtrjKQJDZe9SjVotpZF4+KXZl/evA8E44RzZ09hdGZ9LMK5ssn3WXFBeG1oYyf0folbzuhWOlkerBI9Vb6XgCPLORjlW6JbQyyz4amQl643OtARd6N6aDQBSM0AXWMmT9gMnDUSr+MyaEk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(376002)(366004)(136003)(86362001)(83380400001)(38070700005)(8676002)(71200400001)(4326008)(53546011)(26005)(52536014)(66556008)(2906002)(41300700001)(478600001)(66946007)(8936002)(66446008)(66476007)(82960400001)(76116006)(64756008)(33656002)(122000001)(5660300002)(6506007)(9686003)(186003)(7696005)(55016003)(7416002)(316002)(54906003)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTM3M2gxTDJ5aTUycGlOdU43M05UaE51Y0JuUlZTTjQvK2RlVWZJaDZ6NWhw?=
 =?utf-8?B?SlhLeWpxRlNkMG9Cc01FNFAwKzVreVlwQWxVdXlEQUFZdGw4MTlzUXlsVGR0?=
 =?utf-8?B?azk3WllVRFNTWWhoUldaak5QcjIrTnhKaTQ5VlBjdHgwdmoyMnVBNjR2WDJu?=
 =?utf-8?B?V25sM1dtSHZoZXRXVHJGYXpVZkJOdW4yRUIwdTdwOUwwMGJKbHBvNXNONUl4?=
 =?utf-8?B?cXZQWFUyelRRWllSQzRwMHVlWVNpREx4ZXRwZ3p0ZjNQRHN3R1UxNFZheXE0?=
 =?utf-8?B?Qm4vZUJTSTd0RHM3SDcxTC9MZDZVUWhDaGtrZjA5a2Zid3Yybk9kY1RGLzRK?=
 =?utf-8?B?ZXN5MDc4Q0dlZXJnOHdEOHkzeE01cjI5OU1YOExRV09SSDJvMGVTaU15VUNC?=
 =?utf-8?B?aUpkUWIxU1Q2WnRJR2J0RmR6dUJNVU5TS29yUDRDWHhXc0NuRmVhSVZYeHdv?=
 =?utf-8?B?N0tyRWVBSmhPVitvN2tiTGxtc09UOWNTdmlBaWh0cTA4ZU5UMFV0OWU0U3pC?=
 =?utf-8?B?SHRqTG5HTDB1N3VPVkVwWEs0SVF4UzBvVDZpam94MEVxajVWTDBiU3VyUlBt?=
 =?utf-8?B?LzNzV25pS0pNbjY3TkwxRTJYN1krdFhRRE1kNVovV3FRM1QzUlJtbUVSanJ3?=
 =?utf-8?B?a01oS3dpQXViYnRtMlNBK2lwYWt4cEtSekFTQ0dnanZ2cm1kWnJhWHlHNldn?=
 =?utf-8?B?bTk3SE12SnNwbmZRSGY0dlE5WDNKeHdQUC90Z2pWN1d2dVU2WkVsSEFvRjZU?=
 =?utf-8?B?WTc4UUo1TzlmbldNeWwxTmdoR1c1V2hZRTNEMllUTTNoSFBJeFJSZTNHaFd5?=
 =?utf-8?B?aEtrOC9ZSGNYUWswS1ZQVWR2Vk5NZUVBb2VRaXFYTjJNTWJYK0lTRVcxUW0r?=
 =?utf-8?B?bnFFL01wVTJTSXdQTkF3KzRIdnlNell1QWlqYThvd3gvOE96Skh4a0xsM1A5?=
 =?utf-8?B?S2hlZ1VkK0FVZXZiVWlvZGhjWStXVlEwNWFEbEZuNExlUk1OQm9QL3MxaU9r?=
 =?utf-8?B?RTYxaWlobVpWbHdMNDVoN00wbENiZTBqWDg0QjVpNVB1amcwUVVaUWZxVTdU?=
 =?utf-8?B?Zkg4bVl4WmxFMmxBV1Y3azhKZ0RqR3oxOFRJSjZVajlKSXFnVEM3Y1dVZ2xO?=
 =?utf-8?B?RE94UG10VWZJQVJ0L3VJQXpQQ3V0R0p2dUhwUDJtWElIdXR6RHYycUlvR0lv?=
 =?utf-8?B?OVBEaXZ4NDJtUWx0aWxWTlZsQTluYmlzZVVLZEF6OFlVM1FhOG9vWWRPcWJZ?=
 =?utf-8?B?eGVUYitBTnlHOVJKZDQ1RGE2MmYzb0xHNEhoRFJ5RFBjR2s5UEJ2czAzbzB1?=
 =?utf-8?B?bnJuVjIwbWo4Mk1PNG5TRUpOUlFjR2Y1YnRsVTZERytRU1FLMTkySU5qbENI?=
 =?utf-8?B?UXJwVmZwUWFsTzliWGkwVXVhUXJEQlJ1N1VTUmNxWjZLSmorZ3NBLy9kRDNv?=
 =?utf-8?B?bjFuQW1QNjM4c2pzaWVYRmdzVDBqSjNER2ZSZ0hwT3k2MGFHUVFrSm5yYnVI?=
 =?utf-8?B?T2ZNZ0tONWdBTGVNV2hEQlhtT0ROYytIa0NWVkdKRk9JSFl5d3M3eUFlNjdM?=
 =?utf-8?B?NTIrcmhUSU5URjNHN1laU3ZqMzFXaUg2RUxtRXVaSjN4ZzFhVVNDVXpLb0pP?=
 =?utf-8?B?am1LRlllUDh6cjkzQVJjeFcydldyVDBGVGZ5NU1yN05UOStoK3dPR1B0bGVx?=
 =?utf-8?B?R3ExZzYzcndabnR5bVBnSFA2a2M4WnhlQ1J2SktXY21GRWJNRzBZdFJnOXU1?=
 =?utf-8?B?Nng4ekt3bWp5OGtodG1WV2hYdG8zOXhWbitXd0pQVzdrb3pod241dzV5S05R?=
 =?utf-8?B?bTcwNEkzWXNjbVNyUS9rZGVIKzV6YXBoZWhjdnpXOUp5djdlelk4SXZZbWs0?=
 =?utf-8?B?RmMrSndRaGluZzIydEc3YzRodmZrVG5BL1NFYzlWcFF0djc3VEpkS0phYzk3?=
 =?utf-8?B?N0VETEtLd1YrVjJ1T3UyRjBqbVIxbDFjNlB3NkFTUUtlOVBNVlZWUy8vdE5j?=
 =?utf-8?B?VlZ1Vm91ckVQdVZaWnk0T1lkZXlFV3MrMlV2UzRwN21PK0RGa0wxdnl4c0pl?=
 =?utf-8?B?OHlIMTZnL0tJak5tOUNDNlZLQnQ5RnNRTTlLWC9RMmZOK3Bjc2NXK1N2UC9Y?=
 =?utf-8?Q?gd3HNjyT7lf3yRs0X8hFl6xZg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3074ca75-7f30-4f1b-3538-08da60a60cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 05:52:32.1869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuN8cy0QWtpFjSitLOZoe+a3dZ4IBPZHruO64pi+dZ/2kAZ9odcztTdQvnZEIr3x4LS0sOKfOw2CGnBogzLoxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSnVseSA3LCAyMDIyIDY6NTggUE0NCj4gDQo+IE9uIDIwMjItMDctMDcgMDc6NTEsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPg0KPiA+PiBTZW50OiBXZWRuZXNkYXksIEp1bHkgNiwgMjAyMiAxOjA4IEFNDQo+ID4+
DQo+ID4+IEBAIC0yMDIsMTIgKzIxMCwzMiBAQCBpbnQgaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKHN0
cnVjdA0KPiBpb21tdV9kZXZpY2UNCj4gPj4gKmlvbW11LA0KPiA+PiAgIAlzcGluX2xvY2soJmlv
bW11X2RldmljZV9sb2NrKTsNCj4gPj4gICAJbGlzdF9hZGRfdGFpbCgmaW9tbXUtPmxpc3QsICZp
b21tdV9kZXZpY2VfbGlzdCk7DQo+ID4+ICAgCXNwaW5fdW5sb2NrKCZpb21tdV9kZXZpY2VfbG9j
ayk7DQo+ID4+ICsNCj4gPj4gKwlmb3IgKGludCBpID0gMDsgaSA8IEFSUkFZX1NJWkUoaW9tbXVf
YnVzZXMpOyBpKyspIHsNCj4gPj4gKwkJc3RydWN0IGJ1c190eXBlICpidXMgPSBpb21tdV9idXNl
c1tpXTsNCj4gPj4gKwkJaW50IGVycjsNCj4gPj4gKw0KPiA+PiArCQlpZiAoYnVzLT5pb21tdV9v
cHMgJiYgYnVzLT5pb21tdV9vcHMgIT0gb3BzKSB7DQo+ID4+ICsJCQllcnIgPSAtRUJVU1k7DQo+
ID4+ICsJCX0gZWxzZSB7DQo+ID4+ICsJCQlidXMtPmlvbW11X29wcyA9IG9wczsNCj4gPj4gKwkJ
CWVyciA9IGJ1c19pb21tdV9wcm9iZShidXMpOw0KPiA+PiArCQl9DQo+ID4+ICsJCWlmIChlcnIp
IHsNCj4gPj4gKwkJCWlvbW11X2RldmljZV91bnJlZ2lzdGVyKGlvbW11KTsNCj4gPj4gKwkJCXJl
dHVybiBlcnI7DQo+ID4+ICsJCX0NCj4gPj4gKwl9DQo+ID4+ICsNCj4gPg0KPiA+IFByb2JhYmx5
IG1vdmUgYWJvdmUgaW50byBhIG5ldyBmdW5jdGlvbiBidXNfaW9tbXVfcHJvYmVfYWxsKCk6DQo+
ID4NCj4gPiAJLyogcHJvYmUgYWxsIGJ1c2VzIGZvciBkZXZpY2VzIGFzc29jaWF0ZWQgd2l0aCB0
aGlzIGlvbW11ICovDQo+ID4gCWVyciA9IGJ1c19pb21tdV9wcm9iZV9hbGwoKTsNCj4gPiAJaWYg
KGVycikgew0KPiA+IAkJaW9tbXVfZGV2aWNlX3VucmVnaXN0ZXIoaW9tbXUpOw0KPiA+IAkJcmV0
dXJuIGVycjsNCj4gPiAJfQ0KPiA+DQo+ID4gSnVzdCAgbXkgcGVyc29uYWwgcHJlZmVyZW5jZSBv
biBsZWF2aW5nIGxvZ2ljIGluIGlvbW11X2RldmljZV9yZWdpc3RlcigpDQo+ID4gbW9yZSByZWxl
dmFudCB0byB0aGUgaW9tbXUgaW5zdGFuY2UgaXRzZWxmLg0KPiANCj4gT24gcmVmbGVjdGlvbiBJ
IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIHB1bGwgdGhlDQo+IGlvbW11X2RldmljZV91bnJlZ2lz
dGVyKCkgb3V0IG9mIHRoZSBsb29wIGFueXdheSAtIEkgdGhpbmsgdGhhdCdzIHJlYWxseQ0KPiBh
IGxlZnQtb3ZlciBmcm9tIGJldHdlZW4gdjEgYW5kIHYyIHdoZW4gdGhhdCBlcnJvciBjYXNlIGJy
aWVmbHkganVtcGVkDQo+IHRvIGFub3RoZXIgY2xlYW51cCBsb29wLCBiZWZvcmUgSSByZWFsaXNl
ZCBpdCB3YXMgYWN0dWFsbHkgdHJpdmlhbCBmb3INCj4gaW9tbXVfZGV2aWNlX3VucmVnaXN0ZXIo
KSB0byBjbGVhbiB1cCBmb3IgaXRzZWxmLg0KPiANCj4gSG93ZXZlciBJIG5vdyBzZWUgSSd2ZSBh
bHNvIG1pc3NlZCBhbm90aGVyIG9wcG9ydHVuaXR5LCBhbmQgdGhlIC1FQlVTWQ0KPiBjYXNlIHNo
b3VsZCBiZSBob2lzdGVkIG91dCBvZiB0aGUgbG9vcCBhcyB3ZWxsLCBzaW5jZSBjaGVja2luZw0K
PiBpb21tdV9idXNlc1swXSBpcyBzdWZmaWNpZW50LiBUaGVuIGl0J3MgaG9wZWZ1bGx5IG11Y2gg
Y2xlYXJlciB0aGF0IG9uY2UNCj4gdGhlIGJ1cyBvcHMgZ28gYXdheSB3ZSdsbCBiZSBsZWZ0IHdp
dGgganVzdCBhIHNpbmdsZSBleHRyYSBsaW5lIGZvciB0aGUNCj4gbG9vcCwgYXMgaW4gaW9tbXVf
ZGV2aWNlX3VucmVnaXN0ZXIoKS4gRG9lcyB0aGF0IHNvdW5kIHJlYXNvbmFibGU/DQo+IA0KDQpZ
ZXMsIHNvdW5kcyBnb29kIHRvIG1lLg0K
