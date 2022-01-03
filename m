Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B775482FB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiACJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:55:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:62961 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232501AbiACJzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641203712; x=1672739712;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mZ81ZLEM6FdCq1mfHSRzztli5Q1kGw+CWn2zfhOdFNw=;
  b=T+oUF82PJ+zfUyupS5k1efm3FIdmfd2NpzVLy3eVrN/Cqjmz92hjFOy1
   rcPPOlywXUOF5jTraV8UYD2Gsk6XWXYnc8HOrfn2giOe1Zn/7FFdu1i2C
   KnhSaYnXXHrRj5KYLAqhsYe2pAau3OzN3RX1En1MMkjxqIyu58WTdXGx2
   uH+MyePhIpGpzEOfUeKosBQaHvcCex+XRTZmaLHsgBrG64Zl/IY2w72My
   o7rKjtu6B44dpUgf6rOPVuR0Y9IshCmXW/DqWLE1kRwTpHQEdyU8AbGht
   afDKVUJlDkvxeLxxXRoJJyiT0xOF4zB2dsjYSGNp3d14m3hB2DCso3TME
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="241994214"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="241994214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 01:55:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="667348376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2022 01:55:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 01:55:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 01:55:11 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 3 Jan 2022 01:55:10 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 3 Jan 2022 01:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYAUq4+8ElJp1d7qw8eX6gn8ToHEc7ZyOBDXszkjofoUCpde/dj5aqjZIyoRfy3txlTjCQAgd/zp/Z8hF4J77P4sUQMTpWxJ6cxdNMLwhXUGiGd0fJLgWANMF6zKTqz6JswT6VFXoB6Mzj3LsOTncCxqxHEaoz8dNb1/um5Psqpv/hBNuYlsWi32se0vYGYMFcXdjDvuB59Ds7f6WOS2UGlBGoFsvZcHomet5nHKhjAiNDJCzrCStR2tzW4gd1fv2YBrzSAsO2EAGT8BS82Xap112+9v4eGZ174LYsnjBIk/7gHUuZTldq1HVl6Dc/OE9jTbHs7LXwtQrxiBuVKnjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ81ZLEM6FdCq1mfHSRzztli5Q1kGw+CWn2zfhOdFNw=;
 b=nrfP/H2qMC0qDmaRIwk8kit4ePx9/ZYMdeTTl82MToDIdxU5FCGC9UfXiI33Oo2qqslIjvMYEwqmzg+hAkfdNrdmqEeKfK7zpYRAu72oUIOIuONG9g38YzdR3vuFN8VfN24aQE4aaYuTj+OQjnO53vhZZrRvtSh8v5027W5y7fVTbQmE3LkqepHPSasOsXtV3tC5V566QUkVLm6azZEMpV7OpohRr7UIy+Ha89gY+h/yHkqQGLjPbgtOUV9YEbYqYI4gx82eFfL6nSMydcRmNwG9i3ZDQmBV/AkFqXjdFsjlKR5gMS85gZNTsHv0gm/jiLa2K3YZmjcPCEAWaG+s6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.14; Mon, 3 Jan 2022 09:55:04 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::843c:97bf:61fd:5151]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::843c:97bf:61fd:5151%4]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 09:55:04 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Chris Clayton <chris2553@googlemail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: 5.16.0-rc7+ Bluetooth error
Thread-Topic: 5.16.0-rc7+ Bluetooth error
Thread-Index: AQHX/V6zighUTtrYhE6/IHJGh6jloqxMIqOAgADis4CABA7ecA==
Date:   Mon, 3 Jan 2022 09:55:04 +0000
Message-ID: <DM8PR11MB55735DD3A1EA9132E1A71733F5499@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <02077a37-46d6-c94f-fa08-9da7ee99e42c@googlemail.com>
 <50ea1b0e-28d7-6d04-9c03-4becc4db143b@googlemail.com>
 <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
In-Reply-To: <CABBYNZLc9Pj=LYhL5MUUVkhenHb_xfT59aDDkdk14k7+ojeUzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b38cb0ec-76e4-40d7-6003-08d9ce9f1de6
x-ms-traffictypediagnostic: DM8PR11MB5637:EE_
x-microsoft-antispam-prvs: <DM8PR11MB5637061AFE4DBDB6D89006FCF5499@DM8PR11MB5637.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KY4BOadmyx7vkcSiVt7E3u+0r4nTyBJSBAehW78zDngWhBnXAJyY49kD2Bb0nge/CjGuSjlk9xpeTzI7/102bAGmKsePPTaa6+OQYZWx/NJnTjcXmf3ySL/WRjQvA46hUJH7SJjK/0RHrCEqhlkA2DCzeZnyO9Xdxxv4PWUQdnhWJB6o8ZbBN4mo+zV1/NTEXDREy2Ee3tAYpNMtDBmRXMEpQfRJRKaK9VAx3D2gQWyBu9N207phYeaVQryjBrILShFAdRCDjWiCEn3GYOmpO85jlDTVov4UCafSZLkvuxWyMqPDPxgp6w5H473MyF0F9kfrtX/z+33WeGoCoxqj/6yGoU+0sWEADDlPWXkl9/WDgLAOjinUS0hWKLs8k5PgLCO+YHpZdNZtX/rjZjFpEPXYD6m/2F0QD38wbS3eymWaYfHQv+lTKn5HD8CXYLZlYO0llie97AhuXJHKi9LM3teLSIvU0nCTF1ySAFytbxLM68eg2/jyXmFlRsuHyVtOE8dku9iDCktL+V7jNq6v4FPVJ5tdTde7bTzgpTlQHCaVn1Tz2jq5aBrx/IiAC7QZ7wMxnlo1qYzYOF8vYx7R1KQ247bTEANzJNg/nNEbpUM1dvYZ1anznbnGXq7Ad3NIK7Sl/KbBgCuv1HYkn0++DVBbYPjpRQufBBQBFmL3Pp9wSEdNiYt5UOXdI8LZJM7rSJlX6BtBtYkxpthCp9SqGFK32pV9XVmHQeXCQLbD8hOe+SAZn1Y6iYVppbffzt1qlC7cVieLbG7j6Eh4EUFn7L1h11K9kU79CQMoByApqa8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38070700005)(8936002)(2906002)(316002)(52536014)(66556008)(66476007)(9686003)(71200400001)(38100700002)(66946007)(7696005)(76116006)(4326008)(8676002)(54906003)(5660300002)(6506007)(508600001)(53546011)(82960400001)(110136005)(966005)(83380400001)(66446008)(64756008)(186003)(33656002)(55016003)(26005)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmRzZEJPbHl1eVBWczRQektTNitRWjNGVkFxQ2JYL3QvZzgxVkZ4Q0dGZ2tR?=
 =?utf-8?B?T0NIODR6cU1lbXVoL2hjb3RKNUNoUEFaRXdaVlZVcWpBODNpWVZrYjVmUGFa?=
 =?utf-8?B?WDVUL3pSR1UxUVNHYkw1dXUyMDJCQXczS212T3hxMytwRG5JQklSUTV2cFJG?=
 =?utf-8?B?TFdOcWVUTHkyRHpHVWE0Y0E5SkdKS25GOXJvTElLN05Ma0pvL3hRNllzMTdY?=
 =?utf-8?B?eklyK01RQ3Z5WWlKR3VCZFpBSC81MzZwRDZ0WDd4VnR1ekhTcEtzNXgyeTJG?=
 =?utf-8?B?NHN1STJzQ0Jldi9BZldUMllreEl0YStraGpCa1F4NkU2YWR6SGp1NjBkb3M3?=
 =?utf-8?B?UVhuV21MUEhCM2JiVC81QmdoQzhyUGtqSlVEck1ITEhLY0xRTnlVV1N2eWNN?=
 =?utf-8?B?Rm5OZ09wN01iNEN1K2xVV3JHVXc2aUsyTkRjSnhHMDFJeHNHTkJORE9DR1V1?=
 =?utf-8?B?eVBHMmh3NGNvMHNRczlyY0wxQ3FSUVZpdlBtdFYwbnR3NnphdW51SGJMK0ww?=
 =?utf-8?B?clhKVk1EZFZhaFhxVUdVWWJsTUxrWnNmci9zTUZoS3dDVm92RlFpdjZ5UGpM?=
 =?utf-8?B?c2FKQmlCRzVHYVhlaXRicGl5bGx5QWh5aGNGSWpvRGV6RU9JR21HWGtNeUVQ?=
 =?utf-8?B?WFNndmVxNGtTeUZGNldkSUROT2RRalZOT09UK0hBQSt3V2huY08zUTNTR2VB?=
 =?utf-8?B?d0xhK1V0SldyZDhHcERwS051cTdpbTVaYmZmS25LT0pDQ1VCcUl4RGFKUG5a?=
 =?utf-8?B?Vk90SE82MHgyNUZJTFFsMEVDbU9EbjFpZmpYNCtmWG9oMzRjWmlpbXExajRl?=
 =?utf-8?B?OEdJSVV3UjlGSjZ5cGtCWjY0OVpvMUluNjZ3c1RQaFdxK0kraHRyWkdZVCt0?=
 =?utf-8?B?OGhIUTlLSXplS2lpY0haL2pmMFBNTHduNE5ZQnRhaFRXeU5acDVYOTFUTll6?=
 =?utf-8?B?c3JyaU9KMG5CK0tZWFIyVmxHeTBZZ3d1SkxINDczYTRCdTdvQ2ZTVktyUW8v?=
 =?utf-8?B?TWI3YWZVOHM3eXRmcFBPUllwdkdLZGtkU2EybWF2UGxHa0ZpUEZUZDFzekVh?=
 =?utf-8?B?cjIxeU9YTzZVMnJYWU5PSDg5SExsT1ovN0U4clFLWDBuWXNSWkY4VVpHZTAz?=
 =?utf-8?B?Y2pNaXhCNWQwZlI3QlRPT2tBVG9WSjcvQUxEOXJTaUhrT0RWYTMwUVZsd1Fo?=
 =?utf-8?B?b01EVUxmTlZhRlBHcURvMHUvY2ZZNjhsRWxrT01NT3FjeGd2bWR3eG5HbzVr?=
 =?utf-8?B?TWd2bm85OWd1emlFbGgrUUt6STJjeU4yVXNnaERnbTBUbGhiWEpjUDdCamlR?=
 =?utf-8?B?aWI4YVNWUlNRUHJNV1B3RjQwVTRDVDBZYzVjekFoNmdCcFNZeFVVOGVtMDI3?=
 =?utf-8?B?Z2taN1ZoMnUvYkhFRGREN2FHbzZDUW11TUhhdUYwcSs5N1lQUjNLYUlsYjBl?=
 =?utf-8?B?MkZ3eldrZ0FtOWJ6L0huZmRBdzFvd2hXNlZwNmZJWG9JRjRCenpSblZoMGR4?=
 =?utf-8?B?NUw3d0hnSHdMMkJHWFhEcGFlZm81Y2x1K2VMdkNnYlRvMVI0d0cwR2NVcVpP?=
 =?utf-8?B?K2U4a3pqckxWZmtDMWJienNwdGhTY1JDUGd0eHVPdG5adXlrOHllcWZuUEd4?=
 =?utf-8?B?cFpKSE9kT2tIUjNOU2dDYXhwWkxocXpVNDMzYkZlUDRYVEkwalp5djJlU1Fk?=
 =?utf-8?B?SjJQbjVxcHFmK3lWbng5bEdKQ0U3LzhpMmtvSWpKOG4ycHJuNEpQRmZHUGFr?=
 =?utf-8?B?U2QyaWFXUitVR2JxTm04cjF4blFkOEZIUjJPeFdweDVveTFjczg1Vjgxdm9n?=
 =?utf-8?B?UWtiaDJpbmd1US9nbUNEWUZScCs4dkRWUVFuTDNTNHNZNjh5dGN1MWdUUUlM?=
 =?utf-8?B?TWVkTWRpRUQxczhFclZvNVM0WU95eUhNNVliVVlkaW9BMjdZdS90bFJ4Y1Fq?=
 =?utf-8?B?VG1jU3E3QWlkVWxPYU1oZVAvYVJtdGs3dXJSZWhFVjZVVUN6Y0xOT1dYcXln?=
 =?utf-8?B?ck5yTkRmZDlQNGYwVXpyOFJUS1ROd01QRGkrRlRLQ0VJY3lXUlMwaUlFRUFQ?=
 =?utf-8?B?NmY2bmlUNVNGZlAvR0xKRDBpelpsSG93bXhOLzVQTytmTHFLVUw0RExHaUl2?=
 =?utf-8?B?dzFaVVRFWE5zcUV4R1dKR24weEcva0tSMHIvRStWOTNtdGV4dHFtajQ4L3p1?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38cb0ec-76e4-40d7-6003-08d9ce9f1de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 09:55:04.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mD0UtWDPydoWCTWAD2nAM93Q62Rc12bg1RtyIyK7WKvxXWux2BBAVgpu0QeCm02LoxaSRWZJC5DrZB0DUL7IFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVpeiwgQ2hyaXMsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
THVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFNlbnQ6IFNh
dHVyZGF5LCBKYW51YXJ5IDEsIDIwMjIgMToyMyBBTQ0KPiBUbzogQ2hyaXMgQ2xheXRvbiA8Y2hy
aXMyNTUzQGdvb2dsZW1haWwuY29tPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7DQo+IEssIEtpcmFuIDxr
aXJhbi5rQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IDUuMTYuMC1yYzcrIEJsdWV0b290aCBl
cnJvcg0KPiANCj4gSGkgQ2hyaXMsDQo+IA0KPiBPbiBGcmksIERlYyAzMSwgMjAyMSBhdCAyOjM1
IEFNIENocmlzIENsYXl0b24gPGNocmlzMjU1M0Bnb29nbGVtYWlsLmNvbT4NCj4gd3JvdGU6DQo+
ID4NCj4gPiBPbiAzMC8xMi8yMDIxIDA5OjIxLCBDaHJpcyBDbGF5dG9uIHdyb3RlOg0KPiA+ID4g
SGksDQo+ID4gPg0KPiA+ID4gSSBwdWxsZWQgdGhlIGxhdGVzdCBjaGFuZ2VzIGludG8gbXkgY2xv
bmUgb2YgTGludXMnIHRyZWUgYW5kIGJ1aWx0DQo+ID4gPiBhbmQgaW5zdGFsbGVkIHRoZSBrZXJu
ZWwuIChnaXQgZGVzY3JpYmUgZ2l2ZXMNCj4gPiA+IHY1LjE2LXJjNy05LWdlN2MxMjRiZDA0NjMp
LiBJJ20gc2VlaW5nIGVycm9ycyByZXBvcnRlZCBieSB0aGUNCj4gPiA+IGJsdWV0b290aCBzdWJz
eXN0ZW0gdGhhdCBpIGRvbid0IHNlZSBpbiA1LjE1LjEyIG9yIDUuMTAuODkNCj4gPiA+DQo+ID4g
PiBUaGUgcHJvYmxlbSBzZWVtcyB0byBvY2N1ciB0d2ljZSBkdXJpbmcgc3lzdGVtIHN0YXJ0dXAg
YW5kIG9uIGVhY2gNCj4gb2NjYXNpb24gSSBzZWUgYSBiYXRjaCBvZiBpZGVudGljYWwgZXJyb3Ig
bWVzc2FnZXM6DQo+ID4gPg0KPiA+ID4gWyAgICAzLjk4MDgyMl0gQmx1ZXRvb3RoOiBoY2kwOiBG
YWlsZWQgdG8gcmVhZCBjb2RlYyBjYXBhYmlsaXRpZXMgKC01NikNCj4gPiA+IFsgICAgMy45ODI4
MTJdIEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIHJlYWQgY29kZWMgY2FwYWJpbGl0aWVzICgt
NTYpDQo+ID4gPiBbICAgIDMuOTg0ODEyXSBCbHVldG9vdGg6IGhjaTA6IEZhaWxlZCB0byByZWFk
IGNvZGVjIGNhcGFiaWxpdGllcyAoLTU2KQ0KPiA+ID4gWyAgICAzLjk4NjYwOF0gQmx1ZXRvb3Ro
OiBoY2kwOiBGYWlsZWQgdG8gcmVhZCBjb2RlYyBjYXBhYmlsaXRpZXMgKC01NikNCj4gPiA+IFsg
ICAgMy45ODc2MjFdIEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIHJlYWQgY29kZWMgY2FwYWJp
bGl0aWVzICgtNTYpDQo+ID4gPiBbICAgIDMuOTg4NjA2XSBCbHVldG9vdGg6IGhjaTA6IEZhaWxl
ZCB0byByZWFkIGNvZGVjIGNhcGFiaWxpdGllcyAoLTU2KQ0KPiA+ID4gWyAgICAzLjk4OTY1MF0g
Qmx1ZXRvb3RoOiBoY2kwOiBGYWlsZWQgdG8gcmVhZCBjb2RlYyBjYXBhYmlsaXRpZXMgKC01NikN
Cj4gPiA+DQo+ID4NCj4gPiBTb3JyeSwgSSBzaG91bGQgaGF2ZSBzYWlkIHRoYXQgZGVzcGl0ZSB0
aGUgYWJvdmUgZXJyb3JzLCBteSBibHVldG9vdGgNCj4gZGV2aWNlcyBzdGlsbCB3b3JrIGZpbmUu
DQo+IA0KPiBXb3VsZCBiZSBncmVhdCB0byBoYXZlIHRoZSBIQ0kgdHJhY2UgKGJ0bW9uKS4NCj4g
DQo+IEBLaXJhbiBLIElzIHRoaXMgdG8gYmUgZXhwZWN0ZWQ/DQoNCk1heSBiZSB0aGUgQlQgY29u
dHJvbGxlciBoZXJlIGlzIG5vdCBzdXBwb3J0aW5nIEhDSV9SRUFEX0NPREVDX0NBUEFCSUxJVElF
UyBjb21tYW5kLg0KDQpUaGlzIGhhcyBiZWVuIGZpeGVkIC0gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYmx1ZXRvb3RoL2JsdWV0b290aC1uZXh0LmdpdC9j
b21taXQvP2lkPTEwN2ZlMDQ4MmI1NDlhMGU0M2E5NzFlNWZkMTA0NzE5YzZlNDk1ZWYNCg0KQSBj
aGVjayBoYXMgYmVlbiBhZGRlZCB0byByZWFkIGNvZGVjIGNhcGFiaWxpdGllcyBvbmx5IGlmIHN1
cHBvcnRlZC4NCg0KVGhhbmtzLA0KS2lyYW4NCg0K
