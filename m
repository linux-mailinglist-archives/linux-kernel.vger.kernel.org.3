Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73FB463B55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhK3QO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:14:56 -0500
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:6917
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243960AbhK3QOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:14:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0r8DIHLQo123YM2wWi32hJaaB7f5TCMxQsauJoHRY2ZgiHHQXlCNgx4Ax7beVioT5JH9mkaMl1FblkXiMJ5A+ClY3nSZDgSKSTlJgUR9H/Ttx1+e8AqK0XzqJuGviOvfj1Fa74fR/SNXJfO5J6QOR6K6vfQTthY/emKiNUY2Ka07HiG70cDjxXq6M7A7mXGE8CU6GAiqqnXaWbLAXF90VDYebEibmiUHqqcpa6dbBQhBS3pbY0j+Yro3n3gWRQ4BCcBRUQqYeS7YPmRb+o6lmxrqcZzU0kqHm8xoVV83iGXjeF9SxZ0+Hy0OrezYk2qpR+ED/oc+2nIP35Wqol35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfTBKL8S/AUK1lCBko2fMUnGNpoSz+xldQtmKHKVhNg=;
 b=BdrO7rOJeZMD/4kvmvz2Zax1gsNyLjXeuOiHX18yjuGNxiPvIdUspSIe7CHcETnxBxa8JlR/GHUYUNDqYoB6ItfLWv0d33xIueZ04Dz2GkcjFV7BQrRfq5HHS9pbyWsP8OAA+OiFOQ0nap5wraT4WxywajgGp2HeISt3duSPD/8opbBunt8XBm/taQPlxS5xMh5z7oLLugwz6B5Wgx9igusN3JtvaLYYjjRDOEPRSMpBW0e8EtTAaBcUF3c6mmYlYG04phlaRfxBcBSUvbCKk2vHRQuodZxJ/1HzLSMX3GkDi9bVzm64B0tBi5UNWLw7yohnerqCVkE6jq+MLo2JcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfTBKL8S/AUK1lCBko2fMUnGNpoSz+xldQtmKHKVhNg=;
 b=lEaz9v24jepULIsQT/RUHyo4+Fg4SkDKd98CcNJ+5Owvn3gW8c+WzM0N64WO7GL3iPBH5JY6BP6OojL24/IjMp+VV45db/ALiZFCi9NruBjdSsYWQohPKfaCuf+zr2PeNtgKjgpk/HCdNjvHiVR7LFnl3/vmK4SBVZTfGhvBvgs=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1398.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 16:11:06 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 16:11:06 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Andrej Picej <andrej.picej@norik.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Topic: [PATCH v2 3/4] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Index: AQHX5fAwp6aBl2Hn4kyu/pPkB5+TWawcImuAgAAZNOA=
Date:   Tue, 30 Nov 2021 16:11:06 +0000
Message-ID: <DB9PR10MB4652C8A69A6A3F38B93ED18880679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-3-andrej.picej@norik.com>
 <4591cdd6-9a7b-cd1d-817d-8950c8976d10@roeck-us.net>
In-Reply-To: <4591cdd6-9a7b-cd1d-817d-8950c8976d10@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b8aa8ec-eeee-423a-e1ad-08d9b41c03f1
x-ms-traffictypediagnostic: DB6PR1001MB1398:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB1398F099B8F53BBF7DB8D4F3A7679@DB6PR1001MB1398.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5uEIncwgEw7a/coAb+XR3b3Pr9EQuE+adJNAJonV+oY41eEFqXdCByfYt24Ot8ftWn7tVlDPVufzo67vVfJQregT7kvoau2znsG45WK70qqZbpPdOYdWd9W11WJMV3xUXmumg+2WLF/IVhQlC7XgLumQvVoS99XPa9wOKIDMxppNKHdQoKCSTwJVl38Frc85VV4ATuz+09C2wkEnVeNyFVdiNWa0fwA7BTIclSDMnYOAJCuZ419tlGHmVhHV2zMTmrQl3qJsikyU/A0EjEJD/KQ/aoVE7OwTtlKWxBTSxyq+jniJB9Mc0X7XMg/LvEx2EnQnmX0e88NZqDY4EIClZshALadlQYoeJ4UkqX9bmUIB38DG7hNYNdcz7HJUr5+Suv5cbjel+bQfCsA+JGZcSPfVfyOBfaQ6e3jT3xrFandTOZrQ3Joc74vTWohbc/l39ZfmvfvrbGpC085/m4VCekCIL+c2ziFN2RntcpMNtpMaRYnKmYS9Jx9oZ6WSpaACjiFDANUjXe27NVF6smK8v4kBWNfIU8WdKlIKTNPWKqJizT0NgeyiayNGTXEIWx2zquDwm6omlAcSqZ+wnet8dfY/Sng2BsmnGiO2WlW6DOEgeGWJDN88fanm9VBksY0MUlD2OQ1C3lncJ64cJb0mZSdfKeZQMFGuZX/L7SMoauWSL4BNzvi6JPCkBj5r2oIJhA5svAJGWOfA51i/3/QDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(66446008)(186003)(55016003)(66476007)(316002)(6506007)(26005)(4326008)(2906002)(66556008)(38070700005)(64756008)(71200400001)(66946007)(76116006)(86362001)(122000001)(8676002)(38100700002)(52536014)(83380400001)(7416002)(7696005)(33656002)(110136005)(8936002)(54906003)(9686003)(55236004)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTBKQkU4eC9ZYm1PaDRnMisvOC9jeWFsSXA4VXhLTk9LaDZmYU44a2tUaUdB?=
 =?utf-8?B?aW1yUHhIcGs3WVdPVExpL2xlMUExNkJONHZlU205Z2duNW53WjZVR3FHUy9K?=
 =?utf-8?B?cUt4bmtmVTh0ZzU1dE1PN21MbVpPUGxIOFEyZDBuZ3FpeXpsekkvMU9peTls?=
 =?utf-8?B?SGd1SHh6YVdyejMzVmpVWG9CN3dIVVNGbXVRVjcvTCtjWExkUXFsNmM0a1Q2?=
 =?utf-8?B?WTBaaUtkYnFqa3JqTjY5NzVZcEFBdVlMME4ydXZwSlQ2QmtheWZ0Qi9jdTlO?=
 =?utf-8?B?T2FQbk1EMU0zc0FxV1RBMGJwRFE5dEt2OGdBOTQ0TEdlZlYveE11aUR0N3JM?=
 =?utf-8?B?bXl5TzJaWEVpM3ExMjV4QUdJM05qSWtZRy80b25POVhMZWk5UUxkQjFKc3c1?=
 =?utf-8?B?RlNTT2wybHJiNytzZm9ZL2FuaUlUYklrUlQ5MXYwM2FiRnE5TEhRN1VzbzRp?=
 =?utf-8?B?aThZTWMrMUZIRE1ZZTZkUFdGbzFnenhYZXlWczJxUDloUHBIS1R3NWJUeFBS?=
 =?utf-8?B?SUVEc3k5aTdxTHdFa2VyN29ubkRzME9GT3hoOENhQndOakdvL09ieFZ4T1Zl?=
 =?utf-8?B?eG9aNFRHdi9VdEJVUzg0VlhYcFF0bWlPMDdkS1NFNElWbWF0MGc5YW02cGht?=
 =?utf-8?B?YXNEK0x4ekZKbVRIYTFSb0kxOGo2aFVCVFpweTAvNTlJTHVTQzdja1NrN0NK?=
 =?utf-8?B?Z25PTlkvUngyR3crc0didWdXTVA0ZzRjTzRYUHVYNStOKzBVdWlSelczYWdk?=
 =?utf-8?B?ajV0S3lIQkt1UGxhbW5xVytMTVpnMmQ5a1ZGdTVkdWlpNWh2MDdQNjRDdUc5?=
 =?utf-8?B?QUZDSFVad3FzWnVXWXhlUmRBVWdBaTdHTXFlc3hQZjNsVDFnVW5pSFlUMmFl?=
 =?utf-8?B?enlvVENKa1QrOEo3WE11aVZvWFdNMUxBUUZ5VUxOMU1EZW80NUtKT1hTQzlH?=
 =?utf-8?B?VEIybGY5dXkyQnJnVGVweTlmZXJMM1kxQ3JCYW56L2M2UTgwUXlqRlZrTUdx?=
 =?utf-8?B?b2l6M214aDhWN25TeC9UTHpkWHJQaXpXaDEzUnJId1M4RmJIT3RuZ251a2o1?=
 =?utf-8?B?SDBHWDNKR2FiTitzdnM1bVNLUS9RdWpzc1pGR3RaWUJxWFdtNDlta1BHUkE4?=
 =?utf-8?B?b1A0bUtma2NqZkR6TlVSMGtSTzRGbGVDbGhmUWY4V2NVNXZnaE55dkF2T3lQ?=
 =?utf-8?B?UlpHMjZNTm9mak5vT0JMc2hIeWNMVDd0TlRxMGQycUJIN3hFaDlSUzZaQ3lF?=
 =?utf-8?B?V2g3OWV0YWZVenpKTzMxcDJFVXRqNFROVm1aMFNuTXh1NlhPM24rbHFRQWhm?=
 =?utf-8?B?RFhxbHlIdG91bksySlZhUG52VWRkZS8yRjc0NVMrOUFPVTBCR0xwbzN0R0N3?=
 =?utf-8?B?U3Vzb0c3dXRLZXh5R1U4a3grNHZRa2FHelZYZkplaEZyR2hkQnNOOEx0bVNR?=
 =?utf-8?B?UDFiYzRSMTJZZTZsWFh5SzhtTGlFcE1mSzd0UUZ5ZEdpTStRRmQ2RUM0VFl1?=
 =?utf-8?B?bG5iVHY5ejlPQWZzanVmWVNEWUxqZ28vQjBRQjN5cWZMSUxtNkU2Vy9ZT29l?=
 =?utf-8?B?TGxNMDhleEQyVVUxdFZ6RU5aL1NEdjBkVVFVY0ZvOVY5b0ZBZHpldFdJZDNV?=
 =?utf-8?B?eWFoWHYrUElXMHFZZnVhVnQybExEZTZoZkdUcEVFT0w4QndBeFlLWDdIb3VB?=
 =?utf-8?B?Ty9ZNVltUUZYTHpFcGFpZGxCOElHLzk1ZVV4QW50VVI4N1g0Zkxha3JzaUNi?=
 =?utf-8?B?dzJmVEhrT0pOdjF3c1RkTUlDTVBqUEN4b3V0ajNJK00yNmdQenV5N0plTG9I?=
 =?utf-8?B?ZGJDdGtjaEpUUGpTRlJ0c1dndnAyMGpnWmtkajdybitVckFMSHlDeHRSVTZ6?=
 =?utf-8?B?eC9PSmd5Q1ZYOWh1ZFptYVUxT2JIUFRnOTVTSkk3Vi9qeVFQYVp5Z0NJNFhB?=
 =?utf-8?B?aVdPclQ1NFF5S1QyaVYwWGsramNTWUgwQlRFSjB6TzFRRkF4UXBvbkVIdE9P?=
 =?utf-8?B?N1A0T2tkU244RnFwWmhRdk90ZEtTdlNwRHFPMDU5TUhLSU1XeUxlRHFyUmpC?=
 =?utf-8?B?YWxCaC9GOS91bWRtK0w5YkZJRlI5WjdsYWY2bGNjQVg2bERhU0Q3Q3lwV3Br?=
 =?utf-8?B?WmpmbUI5bEhKZTlTZURIOGs3bUp0eGlwZ0RybVJDZ01ZMFJTVXhOUSt6bDhl?=
 =?utf-8?B?RGZjalRSbmJQcWdWVWFNaG9heEJxMFVMc25WcUlCRnNhd0lkbERHL2xiWHQ1?=
 =?utf-8?B?bGVGWk9JNVRoLzVobHhxMXNNY1JRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8aa8ec-eeee-423a-e1ad-08d9b41c03f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 16:11:06.6858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LNyPwhVrtyRJUQMMWOgd3jk6SGpQToQ6C8SqITcIvdRBWD/b/5dl3fFL0u34qXJDMZS3LhyJYNIYWRLQ7esjUM1n8HBAHT/AATCAcGIdHUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+IERvY3VtZW50IHRoZSB3YXRjaGRvZyB0aW1l
b3V0IG1vZGUgcHJvcGVydHkuIElmIHRoaXMgcHJvcGVydHkgaXMgdXNlZA0KPiA+IHRoZSB1c2Vy
IGNhbiBzZWxlY3Qgd2hhdCBoYXBwZW5zIG9uIHdhdGNoZG9nIHRpbWVvdXQuIFNldCB0aGlzIHBy
b3BlcnR5DQo+ID4gdG8gMSB0byBlbmFibGUgU0hVVERPV04gKHRoZSBkZXZpY2UgcmVzZXRzKSwg
c2V0IGl0IHRvIDAgYW5kIHRoZSBkZXZpY2UNCj4gPiB3aWxsIGdvIHRvIFBPV0VSRE9XTiBvbiB3
YXRjaGRvZyB0aW1lb3V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5kcmVqIFBpY2VqIDxh
bmRyZWoucGljZWpAbm9yaWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL2RhOTA2Mi13ZHQudHh0IHwgMyArKysNCj4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvZGE5MDYyLXdkdC50eHQNCj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvZGE5MDYyLXdkdC50
eHQNCj4gPiBpbmRleCA5NTBlNGZiYThkYmMuLmUzZTZlNTZjZWUyMSAxMDA2NDQNCj4gPiAtLS0g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvZGE5MDYyLXdkdC50
eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cv
ZGE5MDYyLXdkdC50eHQNCj4gPiBAQCAtMTAsNiArMTAsOSBAQCBPcHRpb25hbCBwcm9wZXJ0aWVz
Og0KPiA+ICAgLSBkbGcsdXNlLXN3LXBtOiBBZGQgdGhpcyBwcm9wZXJ0eSB0byBkaXNhYmxlIHRo
ZSB3YXRjaGRvZyBkdXJpbmcgc3VzcGVuZC4NCj4gPiAgIAlPbmx5IHVzZSB0aGlzIG9wdGlvbiBp
ZiB5b3UgY2FuJ3QgdXNlIHRoZSB3YXRjaGRvZyBhdXRvbWF0aWMgc3VzcGVuZA0KPiA+ICAgCWZ1
bmN0aW9uIGR1cmluZyBhIHN1c3BlbmQgKHNlZSByZWdpc3RlciBDT05UUk9MX0IpLg0KPiA+ICst
IGRsZyx3ZHQtc2Q6IFNldCB3aGF0IGhhcHBlbnMgb24gd2F0Y2hkb2cgdGltZW91dC4gSWYgdGhp
cyBiaXQgaXMgc2V0IHRoZQ0KPiA+ICsJd2F0Y2hkb2cgdGltZW91dCB0cmlnZ2VycyBTSFVURE9X
TiwgaWYgY2xlYXJlZCB0aGUgd2F0Y2hkb2cgdHJpZ2dlcnMNCj4gPiArCVBPV0VSRE9XTi4gQ2Fu
IGJlIDAgb3IgMS4NCj4gPg0KPiANCj4gV2h5IGRvZXMgaXQgbmVlZCBhIHZhbHVlID8gV2h5IG5v
dCBqdXN0IGJvb2wgPw0KDQpPbmUgYXJndW1lbnQgbWlnaHQgYmUgdGhhdCBpZiB0aGUgcHJvcGVy
dHkgaXNuJ3QgcHJvdmlkZWQgdGhlbiB0aGUgT1RQDQpjb25maWd1cmVkIHZhbHVlIGNhbiBwZXJz
aXN0IHdpdGhvdXQgbmVlZGluZyBhIEZXIGNoYW5nZSBhcm91bmQgdGhpcyBEVCBiaW5kaW5nLg0K
DQpNeSBiZWxpZWYgdGhvdWdoIGlzIHRoYXQgdGhlIG1ham9yaXR5IG9mIHVzZXJzIHdvdWxkIGhh
dmUgdGhpcyBwcm9wZXJ0eSBzZXQgdG8gMA0KYnkgZGVmYXVsdCBpbiBPVFAsIHNvIGEgYm9vbGVh
biB3b3VsZCBiZSBPSyBJIHRoaW5rIGhlcmUgdG8gZW5hYmxlIHdhdGNoZG9nDQpzaHV0ZG93bi4N
Cg==
