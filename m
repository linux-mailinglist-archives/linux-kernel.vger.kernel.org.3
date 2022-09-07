Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E545B0D6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiIGTss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:48:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE51FA50FE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662580124; x=1694116124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hMrZcm3eg+oNhTCOjicPFv7gnxN6BSx1Iayd/nMiJfM=;
  b=fQzflzcNTi+1VQpzD028sOzFKsV2Z40AwaefDFQ+AkuQ5KRt2fKL9wSk
   wViDaqJzARxydZ4weXaKVGMfqlNwUZmyAr4CfilrgaROnCyQuo1JmFAOI
   PzH/iJoq/2o/QRXGaSL7/x2gwlqfZSYbTSW9kjpcGDwlMA932+3rh3elE
   Fl8AwF/vb9WxE6Hcf55BDnJ0xBlmliIVbxc5pnuAl+/VLvBwiwK4hoxFn
   w7EcRU8FpOPoGdhJARPCulmsclW7yHiIcTq7uUH1JoOGOpQB5Ye3Uviue
   vcYM7ZbYaXyAYAJU+RWCN4MIt+osuHeLRHaCq/fHIPTGzzOSM8xYFtZvt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="276717366"
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="276717366"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 12:48:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,297,1654585200"; 
   d="scan'208";a="676352859"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 12:48:44 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:48:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 12:48:44 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 12:48:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m67juGMe2umvbvVETPIBQ15Le4KCLhH1OMwiURGFpGEDm98UbsAEBB3jYQBN9hmf994EonOtln2WLc3jOlGLYRC3ft0ojfpDP3ug0xZ0jnz9ApTS0QJvRhZaDZviKEVsoWPVnzJn4P6JTk2KQiJOShHXgckfI5URJqO4lISB2EvjDPjpwMHY8QH8ukusNOKjq2O0vcX+MwB/FhpGc+xbcoH7AwcE6eqXvPmkD4EL5q7ioF0UctJ3dViSTGqVqApqThsGv3vtWwg0TQbWXijE9XSfQk3CX4bqEsBU9r8DwlPhLiSC9dOzUoeAnft4jwPA3pPTHvNHFE2cMuDyNv8J+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMrZcm3eg+oNhTCOjicPFv7gnxN6BSx1Iayd/nMiJfM=;
 b=eYAYXRX22mIxP4nWe6+PKSfTUFw4yYLP0Ek4lYAV3iVMt+0QF3ILqfYMP/FE3QT9Xhb/fro2RAvxj/LXJOZqiL+DQAtlp7dj/gmc5jZMC+OgOnHNEwnb23BYdH7EINMExv8TzvJZuC8du/O3kHj9byaRlnSPZtLloe3+7Vv9hbdkCXvFCY+cqdQ1mtqMAiq6NeV54IZ1lh4btENhVskFYAW0STXv/IL08bDeIOpXzEyEaGveotX5KNO9fYMHeF09C6VHUbe2qO/siHEG55bSIFzBvW/RqsQif0nkeeKHqIX+L4S4VmHDUlS5G63XrQZW0jFtVLQRz/neAvbgOZqvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by DM6PR11MB3388.namprd11.prod.outlook.com (2603:10b6:5:5f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 19:48:42 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::f18d:2e17:c60e:5aa3]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::f18d:2e17:c60e:5aa3%5]) with mapi id 15.20.5588.018; Wed, 7 Sep 2022
 19:48:42 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>
Subject: RE: [Intel-gfx] [PATCH v8 09/16] mei: bus: export common mkhi
 definitions into a separate header
Thread-Topic: [Intel-gfx] [PATCH v8 09/16] mei: bus: export common mkhi
 definitions into a separate header
Thread-Index: AQHYwtLRDS0FIZ+vhEWyyMKST7s8Yq3UV/SAgAAH49A=
Date:   Wed, 7 Sep 2022 19:48:42 +0000
Message-ID: <MN2PR11MB4093182E030B512E952F7384E5419@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20220907155813.1427526-1-tomas.winkler@intel.com>
 <20220907155813.1427526-10-tomas.winkler@intel.com>
 <d83d1cb9-961e-2f34-46d8-f46836261948@intel.com>
In-Reply-To: <d83d1cb9-961e-2f34-46d8-f46836261948@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10bb45fa-be1e-4000-9c21-08da9109f7a5
x-ms-traffictypediagnostic: DM6PR11MB3388:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dEr+b74ECZCsWCKjb/KxWWOhHj5YL8x8cqfQeDnmK5p00aGQWZ9MHsI+xiPV1U4cEbSUTaF8iDqRmzpGUOPDkcLfBwHJMrL/L19LZPuCxLGB9vXFfgPK879cE1qguhD5JGldmuR6hd1dFQyg97zhTEl5c+YsPTt65MZRzazFVBlGIVvdXlikq0YCMrMBU+yjr0IpnrSUPW/4p6AfKE3VtrSS6ZIX53HYP5gz86vqNreYtKSmg8jyu15nyz1l9ECECVN1BqvVegwYOFixUICM5jevOAriO6UZHcuRFBI1N69+V2OABeoN/EQqlDXziv4b0AE/oIuiTfHlcaLydVXmGkqYmuY6QbAa6fM1jxQWga8SiERMxtWK2cHQD/aOe8m/+4XLlXts/F+fUMedCHqzGStuOY4V0U5dLVz4tOYKP8o87McvhNO/bSXgdGS8CmoFWU8COZ24irhejscx4/234MIRN98Ud2TC5HV7c5mZb7LlkhSkDihr/iLZ9B8k+41ZRQv/aXQt8WsfX1mVIsVjHiYoWDu9tW3O8enm4KwqBVM0BzKPe+7ZAu1kn1R8MTwShDO8jwSYLQJwmHTolkwSOUWJ2RxNTeDopS2fcRRnuOH6V4iPZfEJAEXGASHEGQAJJvvew3GN3qy/CPhdCUvKC1YWEAhAi3UV+IpVNmp/kZznYoSowqAJbOS7PS9+vASNAWmb2GTvP+OQDLf5wjp4iN8rAdIIzOp+SNsziOYRBu5xJQWq1QOhhkn1g++/5/BXILB0i7H4jRzNbw/mMlFcvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(346002)(376002)(136003)(83380400001)(316002)(107886003)(110136005)(9686003)(478600001)(26005)(6506007)(7696005)(54906003)(52536014)(38070700005)(55016003)(8936002)(2906002)(53546011)(33656002)(86362001)(5660300002)(64756008)(122000001)(82960400001)(66476007)(4326008)(66446008)(66556008)(66946007)(76116006)(8676002)(186003)(41300700001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRZUWt5Sm1KRFcxbFVvelZqdjhoUng3MWhYME9YVCsvQjEvam9MNTRmcExP?=
 =?utf-8?B?Y29JWnJhYVlyc3BBbURSeXFwenVOc2ZnZ2FBQW5OQWlobEhlczJwQzNHdWFh?=
 =?utf-8?B?Z1d5V1JSQ0lYdXk2WWU0ZXF5a3hHSVRzNjNkRVB6VWpCV1cvRGhJNXFHbFN1?=
 =?utf-8?B?Qk95NDlvWjhUL2UvWUZ4ejcvak9LN0crYkIwak5yTCtWUmZyajNZVi9Lc2Fj?=
 =?utf-8?B?WVloZjZ4TmI3Tzl4WlVsZGtEQWMvaXpYS1Q2TU05L3NGWDNjN0FxbGt6aC9n?=
 =?utf-8?B?N0NjaXI0cnhOZ0laMXN0bkRjYm1vdWdZNjZ1dDRBT2JkZm53UzQ4TStBekpU?=
 =?utf-8?B?dkJ0R2FzUi85cXNKYWdLUEg2SkpHcEYxbDhiMVpmRlVCU1FLdnM1YXltVnlS?=
 =?utf-8?B?NVFGSE5rNTYyRmdQaGg3Q2tJaHo3d0NHM1ZxeExZTDMxem1QYWJMYm1scG8z?=
 =?utf-8?B?ZmQwdWNLQ2VGamlOcG1nTUxLWVZVNmkrejJwd3ZUSUJJbHBYYlJLaG9kRXc0?=
 =?utf-8?B?V1cwMDN0bk5PODNiMTlmZmNuSS9wMFBMaHhxbjdGNFp3UGxNcE5HUUdZNmlT?=
 =?utf-8?B?aXcxb1A0MVVwUUkyZDQvWEMwTGRJVjRaSzArOVYyMkxVWTdVblhnbEdlOGhS?=
 =?utf-8?B?UlowN2JuMS9DRnRMN0s4RzVVRXBIa2NSVUNUWExDd1FtMWdqMmNENGpib3Jz?=
 =?utf-8?B?SVhlbWVJV0tlRGRjRnUvcjBPVnZ2L3cyS1d3d3NXRlloT0hHZlJvMGJZbmVJ?=
 =?utf-8?B?eWd2eTF6TjV1bk13V0k3eHZRd0FUYXp6M2ZGNHJWWkJEcXd5NkdmZi9WS05F?=
 =?utf-8?B?TTZNbXpCSEhDdXN1TUg4M2w0WXhPb2hPMUV5MHRNTlNoUElWSzRucWx0VUky?=
 =?utf-8?B?SkpnemZxNWl6eVhJa2pLQVZxTFBmd2hhbkJyQURCQXdTc1g3QjB2R2F3eWVD?=
 =?utf-8?B?amdxcFY1SzFLbEw0L1FWMDdPZ004blkvSlgzNjhMdVRRb0I0czVKYjJHN0Zj?=
 =?utf-8?B?TjhuTCtVbHlMam5yU0FsOGVWcVRha2dVRTJFQkRpNFV5L2VmcldFdjJzMnR5?=
 =?utf-8?B?Znk2bmdSVEU0UU5WNFhOamNPOWs5M0QwTmVnbUlmY09lL2VPOGRHb21VR2xY?=
 =?utf-8?B?eFlQejhJRmhBTitQTGJDNDI2S1lXczNQUDkxVEVuREpTM1ZoN2VVSXVOTENr?=
 =?utf-8?B?VE0zWmVFWjc1OWdWZTl5VTkrekVDM0x4UUN2Y0VXVFZQdzhOTXFiRDI3aXV1?=
 =?utf-8?B?U29iU3FMaU5GSzZPRTBHSlJ4YjkrVms1SHhqSzZPZ2NacGdjUU5lcGhERkdp?=
 =?utf-8?B?L0I3Q1hGTjJSdGZTVXJkcDlPWDZWWC9kK0htbDlpdVJJVDB0ZCs4NHExRC8v?=
 =?utf-8?B?RlQrcDV5YTF4WElXV1gwRWF0U3QxNUZiL1lHRVFveHZMbVdCYmZhOE9scU5q?=
 =?utf-8?B?Rk5hTzdyZ2Z0c1FSbWRrczUrYlQwbkZiRGpZM0d0MTFrVUVPamxPMzFkaVFr?=
 =?utf-8?B?ZVB5MU4wS0NVY0RoV1pXNHhXcWtwRWUycytGcVllcllJY2RzaXdYcEV3TDF1?=
 =?utf-8?B?SHp3NWpJOUY3M3FndUN6N3d0RE5YSXBFWnYrNzhQYWJVanFWYm1RZVZTUHAy?=
 =?utf-8?B?WDhqSUZ4R0laUzBiTGVtU0RiejBsUkN1aFkrMVRMaG9uNDk5SkRyV3M1YXBi?=
 =?utf-8?B?Y2x1SU1rQVpFRndaeExDS3hFckgvN1VzNldxWitZUjV0akJUa3VqODFYQ083?=
 =?utf-8?B?TmRHc3RoRE00WDU3VitINEx1R2hWMG8vSGpFb2t3d20vWHN4MENhYTdkQVl4?=
 =?utf-8?B?U01NOGN3ckxoRlV1Y2djeVcyRFJMUDRCM2JzNnBuY3dJWVdrRDkwZGhGM0dI?=
 =?utf-8?B?VWFpYllWTkgwQzE5MVNMM1pkKzNmYTlsSTB3RkkyZ1pNaGk1Tys1NWN1Q0l3?=
 =?utf-8?B?Y3NOMjNENHgwam41WFB0YUUxbFNBZFUvMmJ1WlJSdW9lYlI4SjZ3cWQ0N0Qr?=
 =?utf-8?B?NWtCNUpoMFlZK0Y5K1NCR3pRb1Qyd0tJVk5VYmlYNGwzUXVEajBLSGdZeTFo?=
 =?utf-8?B?ODRWRk4zcVFIZ0lQaWNWNzhCdWE2T3o2RWN5T1dCWjhxWTM5b01NSnczaHdm?=
 =?utf-8?Q?CWeTFpWc7MioS8bUoM2mocxXz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bb45fa-be1e-4000-9c21-08da9109f7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 19:48:42.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LsJvHa58vYGvYzNCu2+PQaHWT3gXS77EDv0dDDx3/4tLGi/0hb0hFcsd0U0/xZ8y9N1E1wHluJ06iqHBFW7SQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gDQo+IA0KPiBPbiA5LzcvMjAyMiA4OjU4IEFNLCBUb21hcyBXaW5rbGVyIHdyb3RlOg0K
PiA+IEZyb206IFZpdGFseSBMdWJhcnQgPHZpdGFseS5sdWJhcnRAaW50ZWwuY29tPg0KPiA+DQo+
ID4gRXhwb3J0ZWQgY29tbW9uIG1raGkgZGVmaW5pdGlvbnMgZnJvbSBidXMtZml4dXAuYyBpbnRv
IGEgc2VwYXJhdGUNCj4gPiBoZWFkZXIgZmlsZSBta2hpLmggZm9yIG90aGVyIGRyaXZlciB1c2Fn
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpdGFseSBMdWJhcnQgPHZpdGFseS5sdWJhcnRA
aW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbWFzIFdpbmtsZXIgPHRvbWFzLndpbmts
ZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBVc3lza2luIDxhbGV4
YW5kZXIudXN5c2tpbkBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL21pc2MvbWVp
L2J1cy1maXh1cC5jIHwgMzEgKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGRyaXZlcnMvbWlz
Yy9tZWkvbWtoaS5oICAgICAgfCA1Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRp
b25zKC0pDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9taXNjL21laS9ta2hpLmgN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jDQo+ID4g
Yi9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jIGluZGV4IDM0NDU5OGZjZjhlOS4uYzRlNTI3
ODAzMjk5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWlzYy9tZWkvYnVzLWZpeHVwLmMNCj4g
PiArKysgYi9kcml2ZXJzL21pc2MvbWVpL2J1cy1maXh1cC5jDQo+ID4gQEAgLTE1LDYgKzE1LDcg
QEANCj4gPg0KPiA+ICAgI2luY2x1ZGUgIm1laV9kZXYuaCINCj4gPiAgICNpbmNsdWRlICJjbGll
bnQuaCINCj4gPiArI2luY2x1ZGUgIm1raGkuaCINCj4gPg0KPiA+ICAgI2RlZmluZSBNRUlfVVVJ
RF9ORkNfSU5GTyBVVUlEX0xFKDB4ZDJkZTE2MjUsIDB4MzgyZCwgMHg0MTdkLCBcDQo+ID4gICAJ
CQkweDQ4LCAweGE0LCAweGVmLCAweGFiLCAweGJhLCAweDhhLCAweDEyLCAweDA2KSBAQCAtDQo+
IDg5LDIwICs5MCw2DQo+ID4gQEAgc3RydWN0IG1laV9vc192ZXIgew0KPiA+ICAgCXU4ICByZXNl
cnZlZDI7DQo+ID4gICB9IF9fcGFja2VkOw0KPiA+DQo+ID4gLSNkZWZpbmUgTUtISV9GRUFUVVJF
X1BUVCAweDEwDQo+ID4gLQ0KPiA+IC1zdHJ1Y3QgbWtoaV9ydWxlX2lkIHsNCj4gPiAtCV9fbGUx
NiBydWxlX3R5cGU7DQo+ID4gLQl1OCBmZWF0dXJlX2lkOw0KPiA+IC0JdTggcmVzZXJ2ZWQ7DQo+
ID4gLX0gX19wYWNrZWQ7DQo+ID4gLQ0KPiA+IC1zdHJ1Y3QgbWtoaV9md2NhcHMgew0KPiA+IC0J
c3RydWN0IG1raGlfcnVsZV9pZCBpZDsNCj4gPiAtCXU4IGxlbjsNCj4gPiAtCXU4IGRhdGFbXTsN
Cj4gPiAtfSBfX3BhY2tlZDsNCj4gPiAtDQo+ID4gICBzdHJ1Y3QgbWtoaV9md192ZXJfYmxvY2sg
ew0KPiA+ICAgCXUxNiBtaW5vcjsNCj4gPiAgIAl1OCBtYWpvcjsNCj4gPiBAQCAtMTE1LDIyICsx
MDIsNiBAQCBzdHJ1Y3QgbWtoaV9md192ZXIgew0KPiA+ICAgCXN0cnVjdCBta2hpX2Z3X3Zlcl9i
bG9jayB2ZXJbTUVJX01BWF9GV19WRVJfQkxPQ0tTXTsNCj4gPiAgIH0gX19wYWNrZWQ7DQo+ID4N
Cj4gPiAtI2RlZmluZSBNS0hJX0ZXQ0FQU19HUk9VUF9JRCAweDMNCj4gPiAtI2RlZmluZSBNS0hJ
X0ZXQ0FQU19TRVRfT1NfVkVSX0FQUF9SVUxFX0NNRCA2IC0jZGVmaW5lDQo+ID4gTUtISV9HRU5f
R1JPVVBfSUQgMHhGRiAtI2RlZmluZQ0KPiBNS0hJX0dFTl9HRVRfRldfVkVSU0lPTl9DTUQgMHgy
DQo+ID4gLXN0cnVjdCBta2hpX21zZ19oZHIgew0KPiA+IC0JdTggIGdyb3VwX2lkOw0KPiA+IC0J
dTggIGNvbW1hbmQ7DQo+ID4gLQl1OCAgcmVzZXJ2ZWQ7DQo+ID4gLQl1OCAgcmVzdWx0Ow0KPiA+
IC19IF9fcGFja2VkOw0KPiA+IC0NCj4gPiAtc3RydWN0IG1raGlfbXNnIHsNCj4gPiAtCXN0cnVj
dCBta2hpX21zZ19oZHIgaGRyOw0KPiA+IC0JdTggZGF0YVtdOw0KPiA+IC19IF9fcGFja2VkOw0K
PiA+IC0NCj4gPiAgICNkZWZpbmUgTUtISV9PU1ZFUl9CVUZfTEVOIChzaXplb2Yoc3RydWN0IG1r
aGlfbXNnX2hkcikgKyBcDQo+ID4gICAJCQkgICAgc2l6ZW9mKHN0cnVjdCBta2hpX2Z3Y2Fwcykg
KyBcDQo+ID4gICAJCQkgICAgc2l6ZW9mKHN0cnVjdCBtZWlfb3NfdmVyKSkNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9taXNjL21laS9ta2hpLmggYi9kcml2ZXJzL21pc2MvbWVpL21raGkuaCBu
ZXcNCj4gPiBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uNDNjYWRmYjFiOTkw
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbWlzYy9tZWkvbWtoaS5oDQo+
ID4gQEAgLTAsMCArMSw1NyBAQA0KPiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCAqLw0KPiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMDMtMjAyMiwgSW50ZWwg
Q29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuDQo+ID4gKyAqIEludGVsIE1hbmFnZW1l
bnQgRW5naW5lIEludGVyZmFjZSAoSW50ZWwgTUVJKSBMaW51eCBkcml2ZXIgICovDQo+ID4gKw0K
PiA+ICsjaWZuZGVmIF9NRUlfTUtISV9IXw0KPiA+ICsjZGVmaW5lIF9NRUlfTUtISV9IXw0KPiA+
ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1L
SElfRkVBVFVSRV9QVFQgMHgxMA0KPiA+ICsNCj4gPiArI2RlZmluZSBNS0hJX0ZXQ0FQU19HUk9V
UF9JRCAweDMNCj4gPiArI2RlZmluZSBNS0hJX0ZXQ0FQU19TRVRfT1NfVkVSX0FQUF9SVUxFX0NN
RCA2ICNkZWZpbmUNCj4gPiArTUtISV9HRU5fR1JPVVBfSUQgMHhGRiAjZGVmaW5lDQo+IE1LSElf
R0VOX0dFVF9GV19WRVJTSU9OX0NNRCAweDINCj4gPiArDQo+ID4gKyNkZWZpbmUgTUtISV9HUk9V
UF9JRF9HRlggICAgICAgICAgICAgIDB4MzANCj4gPiArI2RlZmluZSBNS0hJX0dGWF9SRVNFVF9X
QVJOX0NNRF9SRVEgICAgMHgwDQo+ID4gKyNkZWZpbmUgTUtISV9HRlhfTUVNT1JZX1JFQURZX0NN
RF9SRVEgIDB4MQ0KPiA+ICsNCj4gPiArLyogQWxsb3cgdHJhbnNpdGlvbiB0byBQWFAgbW9kZSB3
aXRob3V0IGFwcHJvdmFsICovICNkZWZpbmUNCj4gPiArTUtISV9HRlhfTUVNX1JFQURZX1BYUF9B
TExPV0VEICAweDENCj4gPiArDQo+ID4gKyNkZWZpbmUgTUtISV9HUk9VUF9JRF9HRlggICAgICAg
ICAgICAgIDB4MzANCj4gPiArI2RlZmluZSBNS0hJX0dGWF9SRVNFVF9XQVJOX0NNRF9SRVEgICAg
MHgwDQo+ID4gKyNkZWZpbmUgTUtISV9HRlhfTUVNT1JZX1JFQURZX0NNRF9SRVEgIDB4MQ0KPiA+
ICsNCj4gPiArLyogQWxsb3cgdHJhbnNpdGlvbiB0byBQWFAgbW9kZSB3aXRob3V0IGFwcHJvdmFs
ICovICNkZWZpbmUNCj4gPiArTUtISV9HRlhfTUVNX1JFQURZX1BYUF9BTExPV0VEICAweDENCj4g
DQo+IFNvbWV0aGluZyB3ZWlyZCBpcyBoYXBwZW5pbmcgaGVyZS4gVGhvc2UgZGVmcyB3ZXJlIGFk
ZGVkIGJ5IHRoZSBuZXh0DQo+IHBhdGNoIGluIHRoZSBwcmV2aW91cyByZXYsIHdoaWxlIG5vdyB0
aGV5J3JlIGFkZGVkIGhlcmUgdHdpY2UgYW5kIHRoZW4gc3RpbGwNCj4gYWRkZWQgb25jZSBtb3Jl
IGluIHRoZSBuZXh0IHBhdGNoLCBzbyB0aGV5J3JlIGRlZmluZWQgMyB0aW1lcy4gSU1PIGxlYXZp
bmcNCj4gaXQgdG8gdGhlIG5leHQgcGF0Y2ggaXMgYmV0dGVyLCBzbyB0aGV5IHNob3VsZCBqdXN0
IGJlIGRyb3BwZWQgZnJvbSB0aGlzIG9uZS4NCg0KWW91IGFyZSByaWdodCwgYmFkIC0tYW1lbmQg
OigNCj4gDQo+IERhbmllbGUNCj4gDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbWtoaV9ydWxlX2lkIHsN
Cj4gPiArCV9fbGUxNiBydWxlX3R5cGU7DQo+ID4gKwl1OCBmZWF0dXJlX2lkOw0KPiA+ICsJdTgg
cmVzZXJ2ZWQ7DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbWtoaV9md2Nh
cHMgew0KPiA+ICsJc3RydWN0IG1raGlfcnVsZV9pZCBpZDsNCj4gPiArCXU4IGxlbjsNCj4gPiAr
CXU4IGRhdGFbXTsNCj4gPiArfSBfX3BhY2tlZDsNCj4gPiArDQo+ID4gK3N0cnVjdCBta2hpX21z
Z19oZHIgew0KPiA+ICsJdTggIGdyb3VwX2lkOw0KPiA+ICsJdTggIGNvbW1hbmQ7DQo+ID4gKwl1
OCAgcmVzZXJ2ZWQ7DQo+ID4gKwl1OCAgcmVzdWx0Ow0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsN
Cj4gPiArc3RydWN0IG1raGlfbXNnIHsNCj4gPiArCXN0cnVjdCBta2hpX21zZ19oZHIgaGRyOw0K
PiA+ICsJdTggZGF0YVtdOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArI2VuZGlmIC8q
IF9NRUlfTUtISV9IXyAqLw0KDQo=
