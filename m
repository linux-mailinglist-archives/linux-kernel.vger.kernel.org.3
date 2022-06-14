Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE6754AA59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354209AbiFNHUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354387AbiFNHUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:20:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449363EF07
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655191198; x=1686727198;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6qoHrge2tJN/HBZIP6N70XBUUrzvbgMGf3fqS0/230Y=;
  b=YUbnw5f3cUk1tzZyU9zNV4kQBTP1BDXNiuZZgeiap89AbcBiWekZUbPm
   vrl2RRhCGlUOe8DM/BZvNa5B3YQ2CJlEf6gAyAB5WX5L9tuVvcvvGSxG9
   DmGz667uW3oj0FS0W3tTTkSakM8pC0ML+pVWmKJbgo2By/GrR9BcCv2eh
   7W4TFeKO95YJr1z+azmJdzEEne4EwxZUgGwywgNCYtMbznHE2NjO8/OmF
   T6G04py13SvsTm8UKATk7B8rVFhpVIHxEhfv57uNAwLb0ujh60ICVADHS
   /+ipA1nx6Wsl1PkMYb3KieDXXJsETSuGcLVXuXTjUF1o+Z6dfry6/05YX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258984323"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258984323"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 00:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="640190369"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 00:19:44 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 00:19:44 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 00:19:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 00:19:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHS4IqwXBLFVc6mEXoRSqJwVd4MNAS25chohmY9lWmYiBNVM01NOEUZEySoS/4Tj2Douv+QT6QLTLgND8yWk2DaPRzp5jPU1HbjMqKkR+CqEMlfLd6jS3fclu5fUkwCf7VuA0inL4D6SJVwE1QIwCpakIZGGIe1K4Q2Hj7ALuFRM38FXq0SVBDDBxFOUgkzw1BK5wNEeYZQDhr3O2+gdwjfLLvxJopbPxYPNHwQI5W7YmD1hb3ahMXGIkIkdM+S2xGJEfCSxecXkM3dfWyS40gewnSVaoVXASPfUbaH0ZKTl+uaBBvCCPoGIT+ZocZSLIkaZZ9XCthffDsBSHtxHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qoHrge2tJN/HBZIP6N70XBUUrzvbgMGf3fqS0/230Y=;
 b=N7/fr1aoPGUVsIBlHRNX2GqNGmyw3VU/K39KqpMbc5QRHXQIZWGeJghM6sDoklNp0AvFg4EW9uToxPOQn8WmPBnmgsfBI0C+nkUmS9E7Ks9MubERLdWXflMfCX4rVoEnLyInf0Em3OXnu22/GQO58/2uk9i1UxuITSfncHp6xK+rTP0lc9R0Px70LG+rkXRo+wVN686LCV1b5CtO3Ri3sRPmpn9FVcMMULm7ByqK/OlVQGtZIEk93mlwmZyy+Ypfd1WTFsMPz6dibfK6tVGYZ6iAxeEJ2QLIuMWWP2bUpWJAa+y73WIp4YM8jgGHUqp0XdfIbhQsuEzM2zktWhs90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 07:19:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 07:19:41 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Index: AQHYf6GWvMc4HxovbUuxK/w7aTPg8K1ORtLggAANygCAAAb88IAAEMWAgAASR1A=
Date:   Tue, 14 Jun 2022 07:19:41 +0000
Message-ID: <BN9PR11MB5276C675063DAF7349D3966E8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
 <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3e2e6ee7-984f-254e-7a3e-e32d6256c8f2@linux.intel.com>
In-Reply-To: <3e2e6ee7-984f-254e-7a3e-e32d6256c8f2@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc7c517-16b5-4991-44be-08da4dd63fa5
x-ms-traffictypediagnostic: CO1PR11MB4929:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CO1PR11MB492928F0BAE312BDF5466FA38CAA9@CO1PR11MB4929.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IIPpNQXr297n6caS3y8UEMnptMIcuUxpoHnz6nqWa2IMfaIlvhq/E+sTs4ZAQY3AhaBATNifwK9pbadKVslAjQjEC3v5xmHW2r5hrTdPWa4GrKWmHfXwQQmIEwbfBO8kb0IlWKVrCa80pX9ToLjIJ/35KQTiPsL7pD9SYdLqCb+srZsAPOzZLSS9I0A9C0cZHKp6IPtwnBD2pEdioyppEmaeVvOaE7KCMOjiOIumbX4heSRj3rNvSoxX2cZF1oIAlxSlJxRNcNeJAxhynqZbWl6R0sa4Re6OvLm5eKCOqt4WVLw87YnwTo03pWB3JtIy6iIiJRmMaXmFkKibfNdjUMwT51MirdYJ5pG/nhbjsFuoXzwqb6rioiYNSQiV+065g28NeJUGD8+kS56sSogvYHylom/eoyPZS3FI1poZ+s7+dsNPXobeSG/TyI66UU9KEkWhFqeFKQpBHNBOsvlVDc5Vi+W4Lor2nL8uNADZPKdZZEnqCYIlMxjo2xb9xPNyf6POVChL+Y5CoLltipPiQl9Vh6d+W8dgE89FybRTr2/2cOVNv7E8oR1JvDid4JTrYILLuo8Fw8xtQ5Y9rL+W4t+sKxP8Ce5RnBuY4Uf7m+LHlS6fHOMKbMOc6qSKxlk2t41moHMX9W/pJZzDcaVtIQSQ4QeRFaoaEs97cwh3sdTsEQAJc2c8z68cmHefaWQfrzVdIwJsejGcjcQzkk46Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(66446008)(8676002)(76116006)(66476007)(316002)(64756008)(8936002)(52536014)(55016003)(5660300002)(66556008)(508600001)(122000001)(71200400001)(110136005)(38070700005)(4326008)(86362001)(54906003)(6506007)(38100700002)(82960400001)(9686003)(26005)(33656002)(186003)(53546011)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmlIZ2wwQzh6Vk8wRHZwUEVnMSs0WHhLenk5T1pjNWVNWnpPTFArTjI2b2Fa?=
 =?utf-8?B?N1lNdUFVNllyR0g4Y2xmd1pNOTR1dHIveWgyZTFQOTJWNktsb0cwNFZtU3ZD?=
 =?utf-8?B?bWNuU2xZd3RjRm1RU1lsMkxCZkxwdTNUUTNubE8vTmhtV3lscWU0VEs1NmJs?=
 =?utf-8?B?a1pMN3JGR05YVC91ZWZLR0hLZmNEVk4wR1krVjhMUUVkK2pySlR1d1FkZ3Nx?=
 =?utf-8?B?NkV5VU54UlJzU1hJeEw3dDlmbDRjN1dDM2dmalVZSVVXbGJMcEh1NXlKZito?=
 =?utf-8?B?N0daVjZaU3hCTjM1eGIrbXFFUm5BQnkvN1NPL1BrTHRPTDJJdGltVHNtVW9r?=
 =?utf-8?B?OURuVkJ0aG84OUZvcUJPck9WeFRPMGhNMVljckE4U0hJK0JYYmNnNHZXT0NM?=
 =?utf-8?B?WUQ3M1BDaDJ4enVXeVhIMHgwODk5RUhMRlprTE5ESUFJWnZub0xSNVFRQk5k?=
 =?utf-8?B?ZTNjUldFeHlzVHhBb0dUWnRTQUU3em5hTjIwditNeUlRZ3ZMMkFkeU45djlx?=
 =?utf-8?B?blY1bzk2SlNET0pqcVZPWTArd2xPN2ZqM1ZCYWNxVTgwQzB3WVJRcjltWld0?=
 =?utf-8?B?WHpkaHBtdnhKeDlKOTVDL1ZsQkVRQUZ5U2ZOVHpyZE1oM0VKMlJINEhKUUxu?=
 =?utf-8?B?MjNDWnNNbWIyUXVoL21pOXg1bktBcjJLSGlFckJ5VVFJMkZjRlc2R0JkVlpz?=
 =?utf-8?B?WVdQWXVLeDRGV3NPVUYxRlRDdnVGV3BzbFJ4a00xVzEzbmh3cGNveGQ4RXg2?=
 =?utf-8?B?TGRtb1htNlRJMEhMNVhjaWNlOFdYeGttWi9wc0ZRZFhzWWJTV1l5aFNUd0x1?=
 =?utf-8?B?WXNucWFvSUx6MFRzajhoSk9iRnRzUUl6YnFCZ1NydDF3TnA4dDFLU3F5UXNR?=
 =?utf-8?B?d3dMMlg0TFR5TnQ0Zm9ZOU4xdFFwZXhqRUc0cG0yRDVyQ3J4TVM5YVBkMFhY?=
 =?utf-8?B?R0NBZmFKODF5alJOcXNNQnJPL2FKbDZkdlVneGZZU2VwVGMzVUxnSlFhRWVr?=
 =?utf-8?B?MllQRnJpYlpzU00rc2xhRVVXU3p6V0wzd1l0cjM5Yk1mRk9vZzl5ai9jcjZZ?=
 =?utf-8?B?VkRoUG9JWi8vYk42NTR3cUJDMGZGU2RIR1dsQk8zVHg1Qkh4NkRaK0YwZzFh?=
 =?utf-8?B?WEZuNXdwbVNKVUZMSnI1YmE0NEpHVC9qSnhhVUVPandCaGxubHBUK1F0YWYw?=
 =?utf-8?B?M0hESkpLVHVHaS80UW1ia0RxYUVpeitRbXJjYUpUNmtrOVByVDF0bG1YQ2dZ?=
 =?utf-8?B?U1JIcEJzYnlBRjBGTHhrY0YzZGc0SmV2U09TOXhiTVp3cXVzWW4zbW9jVm5t?=
 =?utf-8?B?ait1L2RvSlpLQzFCYUVIaG9NYlpXcVp3cUtNblByM1NVVUN2aHR0Nkw4enJQ?=
 =?utf-8?B?TUwwVUFwWFl1eENDT3pTRHpFS1IyY21jZzk1RG40ZG11TlExZjdJMFJscVdX?=
 =?utf-8?B?a0NwU0QyT0NlMEswMU9xaCtoR01JTlorTUlza0RRZGlWb0xKblgyNndBQTR2?=
 =?utf-8?B?REhTaU5Ua0M3aU5HRDBzRFl1Z0lRcWx5NEc3RUlUYVQxZXV5SXJvTDFwN3RM?=
 =?utf-8?B?a2pObTBiS052azErb2R4NWxzd3RZWjJPa2J1Z0Eya3RsNkJZaTVjdUUrZXJh?=
 =?utf-8?B?MjgyY1JxNU9DSlcvWSt2VDE2Rmc3ZDY2cy9xeFgzaWZmSzlwaGg2NVYvelIy?=
 =?utf-8?B?SFo3clpER3dWeEtXS2FRTzNWeWdBUU8xWjNGYWhlYmU4NWJhWXpBQWVrcVRQ?=
 =?utf-8?B?NkVKS0lab3BCNEZQdGx1YmtMNDJjODFXUjFoK05aOEVEYzdIV2VPQjJwQU5G?=
 =?utf-8?B?M1pmZjgwY3NMTkhHcXFUZG42NU1nMlAzUXBreE52azJvSk45YS9TUmFLRUxP?=
 =?utf-8?B?S2Y3dDE1aUZXWWlyQm9aU1lpTGZKQ1NETGdkOWdRM2tUVHJ5Q3hJNmRGVW1t?=
 =?utf-8?B?V0lKRUxUUlBaci9ZZHJtZU9oU0ZOSVUwZnNSdVNzVDhUdm91VWJ4WHA5R0F3?=
 =?utf-8?B?TG9nam1sQk53Lzdjamh5T3Rld2xVZVc0RzZlRXpHME04bjI5L2dIRVl2a2RH?=
 =?utf-8?B?aWZoWGNZTklNUDFqL2ovbVYzRGZ6dXJvZ1htZ1JtOFBrRHpFYlJkVWNwdUVY?=
 =?utf-8?B?Ulh4VzA1QTIzdkJ5V09maGlqK2ZCS0E0VCtrSDJsTEd0b1pnOUNJY2lzN1ov?=
 =?utf-8?B?d1ZmdDJEQld4OFRVekJWUFJIQ0JSQ1JjbGFDWTl4TG1mWTAxVmQ0WkpwcWpn?=
 =?utf-8?B?WTQ5c3F6OWNlYjRPTkRWWTRpZ3BFZUEzVThWWWloU2xWYnp5aHZBUER2cGRX?=
 =?utf-8?B?NWYvUEh0VDZ6Z2YwUG5GSURGZlZBUFUwUjRTWk4yUi9zMnFDZDZFdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc7c517-16b5-4991-44be-08da4dd63fa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 07:19:41.2013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhgxZuqvs0x3JcWyWl5Fuv1YiSOxT02SKIIP76fJ1Kac0QrYdJwrAFkw9vC5iyIlE5t/JCfLupbnZn+/VHbdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4929
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDE0LCAyMDIyIDI6MTMgUE0NCj4gDQo+IE9uIDIwMjIvNi8xNCAxMzozNiwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVuZSAxNCwgMjAyMiAxMjo0OCBQTQ0KPiA+Pg0K
PiA+PiBPbiAyMDIyLzYvMTQgMTI6MDIsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IEZyb206
IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBUdWVzZGF5
LCBKdW5lIDE0LCAyMDIyIDExOjQ0IEFNDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGFsbG93cyB0aGUg
dXBwZXIgbGF5ZXJzIHRvIHNldCBhIGRvbWFpbiB0byBhIFBBU0lEIG9mIGEgZGV2aWNlDQo+ID4+
Pj4gaWYgdGhlIFBBU0lEIGZlYXR1cmUgaXMgc3VwcG9ydGVkIGJ5IHRoZSBJT01NVSBoYXJkd2Fy
ZS4gVGhlIHR5cGljYWwNCj4gPj4+PiB1c2UgY2FzZXMgYXJlLCBmb3IgZXhhbXBsZSwga2VybmVs
IERNQSB3aXRoIFBBU0lEIGFuZCBoYXJkd2FyZQ0KPiA+Pj4+IGFzc2lzdGVkIG1lZGlhdGVkIGRl
dmljZSBkcml2ZXJzLg0KPiA+Pj4+DQo+ID4+PiB3aHkgaXMgaXQgbm90IHBhcnQgb2YgdGhlIHNl
cmllcyBmb3IgdGhvc2UgdXNlIGNhc2VzPyBUaGVyZSBpcyBubyBjb25zdW1lcg0KPiA+Pj4gb2Yg
YWRkZWQgY2FsbGJhY2tzIGluIHRoaXMgcGF0Y2guLi4NCj4gPj4gSXQgY291bGQgYmUuIEkganVz
dCB3YW50ZWQgdG8gbWFpbnRhaW4gdGhlIGludGVncml0eSBvZiBJbnRlbCBJT01NVQ0KPiA+PiBk
cml2ZXIgaW1wbGVtZW50YXRpb24uDQo+ID4gYnV0IGxldCdzIG5vdCBhZGQgZGVhZCBjb2RlLiBh
bmQgdGhpcyBwYXRjaCBpcyBhY3R1YWxseSBhIHJpZ2h0IHN0ZXANCj4gPiBzaW1wbHkgZnJvbSBz
ZXRfZGV2X3Bhc2lkKCkgcC5vLnYgaGVuY2UgeW91IHNob3VsZCBpbmNsdWRlIGluIGFueQ0KPiA+
IHNlcmllcyB3aGljaCBmaXJzdCB0cmllcyB0byB1c2UgdGhhdCBpbnRlcmZhY2UuDQo+ID4NCj4g
DQo+IFllcywgdGhhdCdzIG15IGludGVudGlvbi4gSWYgaXQgcmV2aWV3cyB3ZWxsLCB3ZSBjYW4g
aW5jbHVkZSBpdCBpbiB0aGUNCj4gZHJpdmVyJ3MgaW1wbGVtZW50YXRpb24uDQo+IA0KDQpUaGVu
IHlvdSBzaG91bGQgbWFrZSBpdCBjbGVhciBpbiB0aGUgZmlyc3QgcGxhY2UuIG90aGVyd2lzZSBh
IHBhdGNoDQpsaWtlIHRoaXMgaW1wbGllcyBhIHJldmlldyBmb3IgbWVyZ2UuIPCfmIoNCg==
