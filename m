Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A101247A5CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhLTIO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:14:56 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23160 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbhLTIOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639988092; x=1671524092;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=vdoSu5cFk0X2JoG+qHuE+BptJtfCkKTePwsS5lpx/oQ=;
  b=mcJNhuBb9hLsUN6ZDrbvaOKKIExLt0db3QZgd8SQAjaIMPpba8/bnjrz
   +Ehq3Lr/e2t8DouVvpeWKHFiudSZUz/7HstVadQi7aj8I7sedSwmWxxz8
   ih1+3rugg8o0FxIysoh530DLNobc5Y54agDbgTMRhuDhQuidkXHtiT0uP
   JZn88yyZEhb3x8tFMLCrSq3Yatw2C1og6DjNYYLRrexhZE87HEC2NH7lz
   q6JaXC8MbBxBipE8N9xtozU+qrf5r8PLE70zW8gX1/kXNbC4CdsAA1/Om
   26lEBYJpjrrDGfB3dbAwcmaV2orYME91kvK7M2GU00vE0um1O21ugMcLE
   g==;
IronPort-SDR: V3X24efi0mlxrIQS9+EmeyCIQ94xalFbIAXC/TtaYy/XWwutw8oz2f7QQ5cIS3rlN3qmH4d3fa
 fpmj2FGzfc+75luPskUTG2UzDuEMbpOBIymYCKQVm+ZrA01Ecj/797b4W0MDGGmI0Dg/hIRMxI
 rGMoD2z09+wCaNbYjYhMzWknpA/11bJiCzGXqG8DPhRNb/7gKPrBJ5E0TBVisTRIZaI7gRq/Mh
 UKPcO/fp1HWF6PUCAs5ykfnxBo4McXqMyFYZe0QXbqADcuUhCE/v/8zMVpvQZOYH/T6jCV8r3+
 s2PRiXEsvJ4uQG/vsdPSmG3W
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="156079119"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Dec 2021 01:14:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Dec 2021 01:14:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Dec 2021 01:14:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5SkX6jmNfAMUPljD5aeK0l5C09iWSnzOWT7sKmYCiniAuQtmcWn3jlkRTW1LR9nYEakcvwzGc2uZ7kf7JyxYExhaM5pXZmjq+MjVNxxKOgRxZeDPF/K8u8gUAlN8xwOO2aVSUbRAJf6xYMCPWLeF9/K2b8G7DETCHowXxNvR/XcJeRMdZIqzSRVtqAg3P85f3OLyTBffWz3mIARrdPY0L8lcaBqMxxqf/w4WzxD+rPFE7VloVHe1kYYJf8FohPVLh5KvZt8PEws3f+w3ua9mLiW8cAQ1TmdaJzIoSGuDvHFkSr2cNilA+o6lESvwzo5UYlysFfrhFdbn88ejYNCfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdoSu5cFk0X2JoG+qHuE+BptJtfCkKTePwsS5lpx/oQ=;
 b=lbVXxdbua6qB69Zzr1IEmTIzDl2n2cME8c1hJO0ItZ6TeRc3hGx97gNKwWG2enhygQcG+B8aXi4fohMw7zFSTzzQxIYN49zWdo4vVx1eiyGk820pN6xgcMIPjtz25MYwiK3ukMF7ArBcO3XXsZPbpGB/ezHrCANWFKqPgd2Prkon0WlERP5nnh07CdFoOPun65772jQusK/gyXPKZsgMAv4w7z372P+5s5ZqfZc/liS7Z6n2o+l0GVa+m6GgD8hWjOPj7hFwO+fpX6gFi5DSovcn+YK3ikVtaRwWY/sQkSqaRIm/ClHdtsMsV0/fDhKwv6GFjXdk+rrhibKVkQh7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdoSu5cFk0X2JoG+qHuE+BptJtfCkKTePwsS5lpx/oQ=;
 b=pu7pGZe0r3GO8Or9MeuHbYP+T9gJkGcl13R5FQtrrCDu0Mvw3ebUtTdCc8BgnTvtyDk9X5Th8daDaZY5B4sxjo81pXPXt3VCr+3Y5qYZf4EMQbPWTQmV8/icTnVkwLMI9a0iBvFm6MuscSh2rAknZbpL4eaQwEJlV5FLL9NXTIo=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.20; Mon, 20 Dec
 2021 08:14:31 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::1f6:467f:69d9:e0b3]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::1f6:467f:69d9:e0b3%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 08:14:31 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] ARM: configs: at91: sama7: enable cpu idle
Thread-Topic: [PATCH 7/8] ARM: configs: at91: sama7: enable cpu idle
Thread-Index: AQHX9XmdNwEL0uroDkSw1qRbfPJ7yw==
Date:   Mon, 20 Dec 2021 08:14:30 +0000
Message-ID: <a3998908-9d45-cf5f-5b6d-8f4884cfff0c@microchip.com>
References: <20211216141338.35144-1-claudiu.beznea@microchip.com>
 <20211216141338.35144-8-claudiu.beznea@microchip.com>
 <YcA0uxt8O/kO3Bo5@ada-deb-carambola.ifak-system.com>
In-Reply-To: <YcA0uxt8O/kO3Bo5@ada-deb-carambola.ifak-system.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34943000-c989-4abc-ebeb-08d9c390bfd5
x-ms-traffictypediagnostic: MWHPR11MB1789:EE_
x-microsoft-antispam-prvs: <MWHPR11MB178966AADA792D0F89437DDF877B9@MWHPR11MB1789.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0IvFVph5YJlpCfPO5PuWCEnR2OdEcyaGBlkpCjA4yNYfMJxMzjz34IS1mcZLfsfQPm4MHt3islA/woQLr2uOwX3jMzZwRvpd0+1/4ctjRQWTu90HrmTcJwSINGajLerWOm5v+w4gkjX9Is0GfnflcWY4cvYUB5co3gdUMVOofKJp5ewlDrW3seA6vupvV9jm5YjItHsrCq/lyYhvvnzIwdObhD9rtVsr29+8G8rAg3as4CiEVQx7TqGm2jrbYpY2GTnzYojpUzC4PV8xIp/4RGuoOhIy6XWXTOAVkIl84F5w8NX6poLcvsBpa039dwkBqaixKmNNw+MnJRko+TGNOxcSCmicc5PzyLwGE6qGNS1VKMOM9GdIMFM1NHQTWFBF75Ro8y5QWKLa/bthVXd/cHdhr1dBV/Z77XrxCKK9ubB8O05FkV83IPzmEltnUE22secvJj6zzizLgR5WuXdBFNg9VNlekO7JgKPb0uwZWwP6Er9ykkbSqTkEVMkYSdncIluK/A9nUiDElSN0/k52n1TFWH9uforMy+bFhZ/IHiN1nrG/P0GC3NGrb4ossi6CBwAPI2WiDOEw85UJl0e511UBoiD6FAENxxjpLOEMygkB0Ipblp/hRzKAHXKYYfWFAkj4oFRbcA8ZwLs7WLCbAjdKvPJUOsPreQJZ6mo4I/Ix7wRq68C20UeUv0zAbKYJOqdPDJQQpw7MXs6vzIJj1UFNzaM1gARo7v92c2ISRkewtllDqXXumR5NiNQcy/YnO/qNmCJXat/qZMukpBDfm+QKKXJvlA5hStIHoHbjMY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(26005)(6486002)(91956017)(76116006)(86362001)(508600001)(186003)(5660300002)(83380400001)(316002)(66946007)(2616005)(31686004)(36756003)(31696002)(110136005)(38070700005)(71200400001)(8936002)(8676002)(2906002)(38100700002)(122000001)(53546011)(6506007)(66476007)(66556008)(66446008)(64756008)(921005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlU1VUlpRkZmNVczYXEwcXM5WkpRQ3Q4Wmp2bUNDY3pFdFNXTWxaelNWUWVZ?=
 =?utf-8?B?eXFGWmF3RWlXUGo5NVRPbW5lZUJNNEdiaDFCR3RVQkxVQmZtaFQrd2FpUTFk?=
 =?utf-8?B?QWhDU1A2VGo0VXF2S3RWbjZDSHdGTFZqZ013WUNrNG9veFo2YVFOQVR0QlZG?=
 =?utf-8?B?N1ZBdWtQVGEzaFNhYXF0S1Y5b1VCaG5DUmhhZEVVTUlsYTNIOWJneW5laVJm?=
 =?utf-8?B?TUtzY3lBM20vZkFaVE9NNTVzWHkwT2grWWVyc21xd082aWx3amhzaXkxYUFO?=
 =?utf-8?B?ZDRNQjlFenpDcUJXSDZsVCtzRnljZk5pZktEVkVoZCtwTUN2OXFhQ21JVWRu?=
 =?utf-8?B?WnZaQlhJQWZlUUZRdFRRU3ZoSVlGb21CRzAyaWZFTFdXSUF1anVxeHErY05i?=
 =?utf-8?B?OTNWQkMybUdGVkFMOE1xbkZlT3lEc1pyamw0V1RQT3plRVFMSUc3ODVhcVhn?=
 =?utf-8?B?WXRmSDA3dm9xdnovODA0ajMyb0w5SEdPSVdGUWpFRzQ2bTBUNzhwNEVFbGc1?=
 =?utf-8?B?V0lhWVU0Yk93Z09TOFdwNGxFOXdhNEhnSmcyaXhUQThZWkxNczVORE5jTVc1?=
 =?utf-8?B?WTRvMnZBME5XajRxeDcrZjdMYVk5U3BtWFZmQXRJRU1mR0UrTXNic1RWQ1Vk?=
 =?utf-8?B?OEY0Skh4M09SSGtuNUgzdnpvT3VxOGRvNnFNbUk0bHNpVXI1REtkR2JFQ3dV?=
 =?utf-8?B?SDQ0eHhnL0ZMZWNHWWFhZ2NRN3NaaTlEQ0xFRlVBWGhjSkhQcTFhMWtNVDJp?=
 =?utf-8?B?UEl5aFFOWWovbXNBN2RMYURSU3NoL2FUU2dRK1BQMFg4NmNCb1RyY3Bub1ZW?=
 =?utf-8?B?SnJRaVpsRWlzNVhQdnBFQnlJTWZNcURTdURvcUE5d0EvaHhjL28zZzdnbklS?=
 =?utf-8?B?YjFueWhSd0dSU3p6QnVlbVRQWlBLMmQxZllkMk1KMFRZSXQxMER2aGFpMlBq?=
 =?utf-8?B?dHdYRm92N3ZwNmJ6bVgrSUZOZDVqNlljeUN5NURucGNQNVdmcDQ5cnAvSkRk?=
 =?utf-8?B?dnAzQnZXSGRvV29McGJCMkg1MGtYY1hNOVhwa21HS0JmN2ZybTQ4cjE3VWo5?=
 =?utf-8?B?UVVtTmlpMUplWFVDSmFzRWdDWkttSFYveTBBY3l2em1iOUVFVkxRaW5VMWNC?=
 =?utf-8?B?YVZ5b1FQUkRnUHNudzJBbS9YQzBLME9FWXNmeUl4dXJ0UFZxVmJpY3JmbDZE?=
 =?utf-8?B?djJzU3RRV3JINUVYRTNscTc2M0lNSjl1YVlvOVFLMW1WUGpsUEtCaHJGTGFC?=
 =?utf-8?B?WmVnMGxwS01Ham9TLzBNMGRtQkpJNldhS3hvSm5UakcwcE1Ucy8rVmJoTDlz?=
 =?utf-8?B?dlNhTVlHWWpFa29zUHY4MG5jRzhzaTRlaGUyUWtXcHZJbVIrUVpRcVp6YlFr?=
 =?utf-8?B?NkU4d1hFbk9QVWFJZFYxWmJmU0lFTVRWYmg3NjhLbWJUTmpyeXREOGxyVlhJ?=
 =?utf-8?B?R3N2aThobEZCV3EyUEU2R2NlUGV6QlhuL3lidGk5eG5zWlRRT2tUbDNHN2l3?=
 =?utf-8?B?VnhVcWpLTElMU2wzYUtBZFIwL3VWRzdTRTI2NlVoMHNFVjFCWlNVaUdvVExV?=
 =?utf-8?B?aVVaODI1WkRkWGNHOEo3QmVzNWJNMmlaUVpMOFQvSUxtNExvKzBhMGpyMDlY?=
 =?utf-8?B?YURhbmhVY2J2K1JuRlE1THcrWTYzbVVSazZJaFB0TUV0THEvNGtaUFJkTVlv?=
 =?utf-8?B?RnZOdnN4VkRhLzF5NUs2aVdDa2pIM1pKUHJlZjRqdE5sa0FOR3Ird1JIMVFy?=
 =?utf-8?B?UFNzdFpHaTVEYmR5dkNNZTZXUmxZOWd4OUErTys0ck5UWjRxWEVsUE1QV2ly?=
 =?utf-8?B?VTRSSDkrUkhXcnNIblFobFJjMTB0S0FHUm0wcExHRmFqeUFMYnFPZllURE5k?=
 =?utf-8?B?cENUc3BQYjl2MStIWHBwaUJneUxFSERMRExjbUluQUVMZDlQRWZoODVoQnhI?=
 =?utf-8?B?bDdhT04zS1h1ZitUYnpJTVRjQnM5M0IxamlyRC9kS2pSSTc2cnFvSk02Tmo0?=
 =?utf-8?B?dFBQQzd2QktKSkJvL0RmK1FiSW1lK3NxVzFCUEZWNkRzdTMramZ1RFhOZTdZ?=
 =?utf-8?B?ekN5WTNPZ25Sdjl0U3pmOWZyZVEyeWExYUIrU0Fmdk1id1o1OWp1WTJBa3Jw?=
 =?utf-8?B?aXRVSE52ZDVSOVhDczJSVUVBbi8yNDhwbjdNWXREZm9XK3VVM3JHNWZxTjFi?=
 =?utf-8?B?UEo0Rk8wRlpDaFU5c08vVjRSZndObTFzQ0ZzWSszc29VRDNRY0VhSTJnbEVt?=
 =?utf-8?B?bjlmVS9vaDNzcE85dm5FSjZUL01nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0351E73DFC475B43857CD12B6CB38304@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34943000-c989-4abc-ebeb-08d9c390bfd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 08:14:30.9560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KbeIMl08Fp+Sc37M1Fd+C4rzObd6rCLW4/bsssHuw04ZVK9IVduNGUlmcJAuynh7fmbQpl7Zqbf5tybgTW+fFyVplJA+mBBNeo71Mx1Eyyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMTIuMjAyMSAwOTo0NiwgQWxleGFuZGVyIERhaGwgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8gQ2xhdWRpdSwNCj4gDQo+IEFtIFRo
dSwgRGVjIDE2LCAyMDIxIGF0IDA0OjEzOjM3UE0gKzAyMDAgc2NocmllYiBDbGF1ZGl1IEJlem5l
YToNCj4+IEVuYWJsZSBDUFUgaWRsZSBzdXBwb3J0IGZvciBTQU1BNyBjb25maWcuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5j
b20+DQo+PiAtLS0NCj4+ICBhcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZyB8IDMgKyst
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZyBiL2FyY2gv
YXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmlnDQo+PiBpbmRleCA5MzhhYWU0YmQ4MGIuLjk1YzJh
N2VkNDgxNiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3Mvc2FtYTdfZGVmY29uZmln
DQo+PiArKysgYi9hcmNoL2FybS9jb25maWdzL3NhbWE3X2RlZmNvbmZpZw0KPj4gQEAgLTI2LDYg
KzI2LDcgQEAgQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVI9MTUNCj4+ICBDT05GSUdfVUFDQ0VT
U19XSVRIX01FTUNQWT15DQo+PiAgIyBDT05GSUdfQVRBR1MgaXMgbm90IHNldA0KPj4gIENPTkZJ
R19DTURMSU5FPSJjb25zb2xlPXR0eVMwLDExNTIwMCBlYXJseXByaW50ayBpZ25vcmVfbG9nbGV2
ZWwiDQo+PiArQ09ORklHX0NQVV9JRExFPXkNCj4+ICBDT05GSUdfVkZQPXkNCj4+ICBDT05GSUdf
TkVPTj15DQo+PiAgQ09ORklHX0tFUk5FTF9NT0RFX05FT049eQ0KPj4gQEAgLTMzLDcgKzM0LDYg
QEAgQ09ORklHX01PRFVMRVM9eQ0KPj4gIENPTkZJR19NT0RVTEVfRk9SQ0VfTE9BRD15DQo+PiAg
Q09ORklHX01PRFVMRV9VTkxPQUQ9eQ0KPj4gIENPTkZJR19NT0RVTEVfRk9SQ0VfVU5MT0FEPXkN
Cj4+IC0jIENPTkZJR19CTEtfREVWX0JTRyBpcyBub3Qgc2V0DQo+PiAgQ09ORklHX1BBUlRJVElP
Tl9BRFZBTkNFRD15DQo+PiAgIyBDT05GSUdfRUZJX1BBUlRJVElPTiBpcyBub3Qgc2V0DQo+PiAg
IyBDT05GSUdfQ09SRURVTVAgaXMgbm90IHNldA0KPj4gQEAgLTkwLDYgKzkwLDcgQEAgQ09ORklH
X0JMS19ERVZfUkFNX1NJWkU9ODE5Mg0KPj4gIENPTkZJR19FRVBST01fQVQyND15DQo+PiAgQ09O
RklHX1NDU0k9eQ0KPj4gIENPTkZJR19CTEtfREVWX1NEPXkNCj4+ICsjIENPTkZJR19CTEtfREVW
X0JTRyBpcyBub3Qgc2V0DQo+IA0KPiBUaGF0IG1vdmUgb2YgdGhlIENPTkZJR19CTEtfREVWX0JT
RyBlbnRyeSBpcyBub3QgcmVsYXRlZCB0byBlbmFibGluZw0KPiB0aGUgQ09ORklHX0NQVV9JRExF
IG9wdGlvbiwgcmlnaHQ/DQoNCkhpIEFsZXgsDQoNClllcywgaXQgaXMgbm90IHJlbGF0ZWQgdG8g
Q09ORklHX0NQVV9JRExFLCBpdCBoYXMganVzdCBiZWVuIG1vdmVkIGRvd24gaGVyZQ0KYXMgYSBy
ZXN1bHQgb2YgdXNpbmcgIm1ha2UgbWVudWNvbmZpZyArIG1ha2Ugc2F2ZWRlZmNvbmZpZyIgd2hl
biBlbmFibGluZw0KQ09ORklHX0NQVV9JRExFLg0KDQpUaGFuayB5b3UsDQpDbGF1ZGl1IEJlem5l
YQ0KDQo+IA0KPiBHcmVldHMNCj4gQWxleA0KPiANCj4+ICBDT05GSUdfTkVUREVWSUNFUz15DQo+
PiAgQ09ORklHX01BQ0I9eQ0KPj4gIENPTkZJR19NSUNSRUxfUEhZPXkNCj4+IC0tDQo+PiAyLjMy
LjANCj4+DQoNCg==
