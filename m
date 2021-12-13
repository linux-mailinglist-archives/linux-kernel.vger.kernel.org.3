Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62852472FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbhLMOx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:53:58 -0500
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:20842
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231349AbhLMOx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:53:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNtwHl6a2gcT+xCGG3lhlIRb3A8lbEQbdHWxwa309oRVfxUSfPTRgm/1WjiSFgDnRb3ArJbC9eIHHMYYLkiBweWl+Fffuhjfsc37VTPSOq99T5IIZJQ3b6IWvW/4u3gMqdVcj7klPaxmL5Wl6hsowOUzOWfdZkLo0LkuCpIBIhDhNIw3u2Gl4jIDD7Dn+qcRN4rDrgOs8tfvj40Q95PNzmxBKKdWZYWAJzgN/bDxgM/WoW+tSQCZs9OU59BNim7ZziO1mxT6Cy8W1Lt9IwiZfQk8CTHk0VpF4ax1iccBYFGUFrdve7QkjQI2SA5NDg61jDEtCcwtsLrvyQmleU9Aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mfTp2DVJurz2yY/CIE2XC4xv4kNtDtiQgv/JVFNH2Y=;
 b=I6G4YV4zkAnlCUvdRre1gKDRggN9A/y6NKsppgcTOQ0Yex77RfE+DCTIzMnhyWpCX67wC5I+6ik/ti/vOb/cHQYyGWJq7520mUx+AbRTfYilFzHX1gsmW7qEK/Ss5cf6t867fQ0naRSB2L6k78ThiXSQzrMf1xhhFxgPYA+b/Aes4BdmwzRboNR81SOM2V08NuPQdpBWtvMlIB47MELhmvnpKQ+SrV4E2QtH3V7UM8ZwgQDaF8/BssKEfjRXJ8pysnq4cuiAFd7DmvwvJ+yGGUxo7mGl2Bkz380u4a0oDFXVfu7gGoRRzNY7nJoubqEs0rKi9kdP9WXOnRSto1zlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mfTp2DVJurz2yY/CIE2XC4xv4kNtDtiQgv/JVFNH2Y=;
 b=MpJsVLYKngV6V5nrAVjf/3LSUve3WOQuLdNZXYqaDj5aJbjjaiU3J2EOmsT9IHOo2eRnXdcBrlhnEBUpLsxelpQXj/26+58UQWL0aQBEV8zPh/jAkLG5eygZtZDtmisGFZx14dvRohMvTjyIOjfNk/jDATtMWF1+vail8dIbiAY=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB0967.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 14:53:52 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2082:9a35:28f4:9328]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2082:9a35:28f4:9328%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 14:53:52 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Andrej Picej <andrej.picej@norik.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: RE: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Topic: [RFC PATCH] watchdog: da9062: Correct the timeout values
 [Klartext]
Thread-Index: AdfwANztWgHN3oJ0TZqwlPeCV8dlmAAL2e8Q
Date:   Mon, 13 Dec 2021 14:53:52 +0000
Message-ID: <DB9PR10MB4652D761596216F84AFF95EB80749@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
In-Reply-To: <4254747d8cde4c5dbcbfdd00a3ecf701@dh-electronics.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ce29af8-df85-46b5-9c35-08d9be4860ef
x-ms-traffictypediagnostic: DB6PR1001MB0967:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB096726F8EF535C6E348C63CFA7749@DB6PR1001MB0967.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cf/3cC72H4cTXWhrFucu5cDyU3gmXj/iJtAB/HTpQ7jpv1OOMkjXploX8b0LtG+3mXd7xLg9HLQiBLyp/mezqQ7AcEzxuOq+EAYHIcSAGj5jcI1iuFp/Sp+gOeMUP1gI1yDSadS5uzGGLAYn2zfkmmlwK/k6kzfrc5zPWexc8kIvfpkeNwFW/fAjMnqxbYdoliioACabn0zqvgt1WakVlTroLzjlwhlZbsWeVAXHLiemfRN77EN6zuJCTxSamEkoobzel9ReMNZiCcKqoXfAoupS+pi0nm+k37BgTO4kRRXCvyhr/u6R4hDv3zK9Dsa5TwFqhKADlsVm3aCCJBJt2yuJbAQ3Z8IVF2v4Dnq7m4dWmkODt0JLzLE3geL6WS3i7EVVyGI3rmOsODsW3baIeRE9uimNiyco5mBcDvKPnRpj94sjhYBg3QVSsQ3Cm7XKB0RqsrxbN5I6JmIGC2pw03Hb2AXWTi4oCB1wHVQ1ZX1XWTa8ec6vSP4McfiSr0s2OwhnPmZY+F/QDMB9c+ox7nZgoT+7Qt2fsFXLpHO7qzRzpK6fgA91RAOogsUFcfnak8ZRGafo4WcftP0blbgoYIV9NrCn77P8hWHC2lW2wYDb8RvhYcDxZArtj2yaHPZYkTa0rhNG0l068seNsUpO2zN5DTtRLKEvpTKaF1IuJWRHDeGnaB95/5dVGYiZo85t1nMB92hyOuL43g+ljvlU6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66556008)(76116006)(508600001)(66446008)(5660300002)(83380400001)(2906002)(316002)(55016003)(71200400001)(122000001)(7696005)(38100700002)(8676002)(4326008)(64756008)(6506007)(38070700005)(26005)(8936002)(53546011)(110136005)(55236004)(9686003)(186003)(52536014)(54906003)(33656002)(86362001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzFQVENDN1NsdWJmaGtSSUYrTExzcWJaQmZxdEVkUVc1MWhORWRyOUtsV2w1?=
 =?utf-8?B?QjVkZytDd2ZJSU10cXY1S2oxTXZjYVpzNU1hNU91ZFJqb2ZIcWltMXNnSHAy?=
 =?utf-8?B?Y0kwWlhUaklnVjVNS3hodTcvbmVZbTVnOU5GZDlsYlUrc2VqVjhad1FlN3dp?=
 =?utf-8?B?NzZ1ci91ck1kNkNybVZMVS9wQ1Z4b3kyZlg1L3BJb1g1N283MU5Jd0UweGw1?=
 =?utf-8?B?Zng5SFhSbkg3V2RhSTJRM05Gc2NOcXVIMzQzakRScXYvVkZvM1pKeUx1NzM3?=
 =?utf-8?B?SzREWk92WmJENHdlOEhGd2RISHNoYjRBSDlQcXI4TmsyVWRia1RhUzkweWFR?=
 =?utf-8?B?Ujk2TEJLOWFJc1RLdHgzYVkrZ3l6VGxJaUFSREJsdVJjMDVLRkphdCtrck9S?=
 =?utf-8?B?WEFiS3poVkcySkxEcHYzb3pWdVkwc01yN3NnTFF5OXJJV3FHSWl4dUphMDY2?=
 =?utf-8?B?c1hlMlBGdzJyMG5ycG1sVHpNcjdUNlRBdVYxVStaK0dvV0FwZ0VxTGgrTUtE?=
 =?utf-8?B?RHZmWlRsOHR0Y0R0QVdzT2EyZi9zSG92dkYxOG5HVHNNcjIxVHlya242alhT?=
 =?utf-8?B?bWhFQXhMQy9mL2grVm12RlFaZVVGUHBkdi84ZTdkOUxBSzhKOFZLZ0RnbExo?=
 =?utf-8?B?RkFSU3lhT0NtSFVlcEx2VWlvOXpVTkFwNEZVU1ZWTG1UOUNtTy96NUx3ZFdP?=
 =?utf-8?B?ZWtEajVQUUdrUFJ0Mmcvd0orTVcyUUlqWmtNTDU1ZXNqMHJWTlVYOUF4TFZq?=
 =?utf-8?B?cjVBMTJVVngremJIVGJlMlVoT2c3Q21OeEJFQlVGdDFZYmJPSHR2RWllSUhE?=
 =?utf-8?B?ZXRrNGl5NWcrc2RyblA4VFJRWnZ3V1ZzU0pHKzVxRjBFdWRHU2Vzd1QxL3lt?=
 =?utf-8?B?cUl5ZEVEVy91ZDJZaFBLdmJnSXhEeGdkb1RUdG11QUVSbUREYU5pSmhvVHdB?=
 =?utf-8?B?MVU1aWJneHRQOFlsVzlxWkd0Q1JqZDE4cnE4eDkzRTVEazNyTERLZml0NjVu?=
 =?utf-8?B?U0pUL0V1R3NxUnQ3WW9wU1N6ZGV2c1d2MmlFb0pmb3haNnZWN1NNc1ZsQmJy?=
 =?utf-8?B?cmtPSVVlMGFPQ1E3eUFQMUkyWW9jc0QrU1pxWU0wS082MW1LWVBmQVlveG9V?=
 =?utf-8?B?NHpKemphUXJySHBjZlZodHBZdTR1NjV2dWtPdFNYLy92RktoOGhYVldmSnA5?=
 =?utf-8?B?RnM0emNNcTdPMGpvUGhwMWdFQVNoQk5rL1lLM0l6TmYxSFJ6WVhtVlpvbU1z?=
 =?utf-8?B?NjlUZTNtWXA0UDZRbG1xcThVWmZuUENxTnR1eGxkRFlSQjhzcHNLRjJ0dEZw?=
 =?utf-8?B?UEU1dUQxKzJ3MVRPU0lKTmtpcVpic0k5ejM5TDdKWllLTDE2bXFzb0EzcWt4?=
 =?utf-8?B?UHZrL2Z0VE1ka2JYV3d2Wm52RHhvZkU4Q2FlSFRXblVSMEh2QXBVclZYZkVB?=
 =?utf-8?B?S1FGL05TM0Vwc3BuN0pHSGx4QVpUbXYwc25wUW1jampiQjJNdi96SFNRL1hN?=
 =?utf-8?B?ZUJ5VmlxTmo3aGxUVjJZcGNPUDljaTBOTzZIZmtYaUZmMnpYa3gvK3o4YU5z?=
 =?utf-8?B?MkdhM0x6V2lGSDBnNENyMVMvTUdxYlJDdzQvdlMrRnlSOVdiaHBTNkJKTEQx?=
 =?utf-8?B?MGlIVGlkbFhzNFRjTFdCOFVKMklGcnRCSHVMQWRUZzVGTGNZaFhiYnVnZTlP?=
 =?utf-8?B?enlqeDUvdjEwdUlNWWM4VjhsbEJZdmFDcW9MdmN2Y24yU01ZRTQzcGFZT0N6?=
 =?utf-8?B?U1ByeFA4SUJvMUVBTlh2L3hJbHpUQ0FUMTJaMWplb2cxeTcvd0h6dkV1M3JG?=
 =?utf-8?B?SzVxZXFVWXlPZzNVMkNJUEM4dUcvS3dTV010K052Nzk4Y1NlRjRBckNRUEdm?=
 =?utf-8?B?M2FDT25XSHk2S0o4QzlQb2FYOTFYQTVaV0hpeFloeHN2YVJhWm12ZmxqYXZw?=
 =?utf-8?B?Z0NhZThQREpYVnFJK2tiWmRldGVtQ1g2Z2ZoaTV6RW53WHliYjZrSjcwVHNs?=
 =?utf-8?B?MlArWDVWMGhHQUpIT3BhQzJ0QjZPWmJrcWxhcUtjSVAyT2ZuRWxaL3c1anFR?=
 =?utf-8?B?ZXRnelFMNVNyRVlkYUVIdkV2NmtscUt5VlAvdW5uZnRuQWtpTTVMMkJ5Qll6?=
 =?utf-8?B?WGsyT0NTbzVMRlVKRm5nQzdMcEN0WjI0NGFTREZ0UmZmSlY2TjRQV0NsaEg5?=
 =?utf-8?B?VTlJNWRRbC9mckNTcVluRXZGdlpkMjdvRkVubmlKTEtRYlB4eGdWczFXdTVs?=
 =?utf-8?B?cEJRTkw3elFyQkhicmQ3cnZ5Y3VnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce29af8-df85-46b5-9c35-08d9be4860ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 14:53:52.0999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /yUOmNCxgyUaVQwwzr6ymAhKYxGOYs43VRaFRTHmcaC3V/NiHUVQmQuIYT1sl2gcJJfrfkDlBpx+2gMPdNpo0yNKDcyBVPny0dRgtlK7rW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB0967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTMgRGVjZW1iZXIgMjAyMSAwOToxMSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0K
DQo+IFJlc2VuZCB3aXRoIFtLbGFydGV4dF0gdG8gdHVybiBvZmYgVExTIGVuY3J5cHRpb24uDQo+
DQo+IEZyb206IEFkYW0gVGhvbXNvbg0KPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDYsIDIwMjEg
NTozOCBQTQ0KPiA+PiBUaGFua3MgYW55d2F5LCBzbyBub3cgSSBrbm93IGl0IG11c3QgYmUNCj4g
Pj4gcHJvYmxlbSB3aXRoIG15IERBOTA2MSBjaGlwLg0KPiA+Pg0KPiA+PiBAQWRhbQ0KPiA+PiBX
aGVyZSBjYW4gaXQgY29tZSBmcm9tPw0KPiA+PiBDYW4geW91IGdpdmUgd2UgYSBoaW50IHdoYXQg
dG8gY2hlY2s/DQo+ID4NCj4gPiBJJ3ZlIHNwb2tlbiBpbnRlcm5hbGx5IGFuZCBoYXZlIGJlZW4g
aW5mb3JtZWQgdGhhdCB0aGlzIGlzIGRvd24gdG8gdGhlIGZhY3QgdGhhdA0KPiA+IERBOTA2MSBy
dW5zIG9ubHkgZnJvbSBhbiBpbnRlcm5hbCBvc2NpbGxhdG9yIHdoaWNoIG1heSBiZSBzbG93ZXIu
IFRoZQ0KPiBpbmRpY2F0aW9uDQo+ID4gaXMgdGhhdCB0aGUgdmFsdWVzIGZvciBUV0RTQ0FMRSBk
ZXNjcmliZSB0aGUgd2luZG93IHdoZXJlIGlmIGEga2ljay9waW5nDQo+IG9jY3Vycw0KPiA+IHdp
dGhpbiB0aGF0IHBlcmlvZCB0aGVuIHRoZSB3YXRjaGRvZyBpcyBndWFyYW50ZWVkICpub3QqIHRv
IHRpbWVvdXQuIFRoZQ0KPiBhY3R1YWwNCj4gPiB0aW1lb3V0IHdvdWxkIGJlIGF0IHNvbWUgcG9p
bnQgYWZ0ZXIgdGhlIHNlbGVjdGVkIHRpbWVvdXQgcGVyaW9kLCBhc3N1bWluZw0KPiBubw0KPiA+
IHBpbmcva2ljayBvY2N1cnJlZC4NCj4gPg0KPiA+IFRhYmxlIDggaW4gdGhlIGRhdGFzaGVldCBz
cGVjaWZpZXMgYSBtaW5pbXVtIHdhdGNoZG9nIHRpbWVvdXQgb2YgMi41cw0KPiAodFdETUFYKQ0K
PiA+IHVuZGVyIHNwZWNpZmljIG9wZXJhdGluZyBjb25kaXRpb25zLCBzbyBpZiB0aGUgbWluaW11
bSAycyB3aW5kb3cgd2FzIGNob3Nlbg0KPiA+IChUV0RTQ0FMRSA9IDEpIHRoZW4gZWFybGllc3Qg
dGhlIHdhdGNoZG9nIHdvdWxkIGFjdHVhbGx5IHRpbWVvdXQsIGZvbGxvd2luZyBhDQo+ID4gcGlu
ZywgaXMgMi41cywgYXNzdW1pbmcgdGhlIGNvbmRpdGlvbnMgbWF0Y2hlZCB0aG9zZSBkZXNjcmli
ZWQuDQo+ID4NCj4gPiBJZiB5b3UgaGF2ZSBmdXJ0aGVyIHF1ZXN0aW9ucyBpdCBwcm9iYWJseSBt
YWtlcyBzZW5zZSB0byBjb250YWN0DQo+IERpYWxvZy9SZW5lc2FzDQo+ID4gc3VwcG9ydCBhcyB0
aGV5IHdpbGwgYmUgYWJsZSB0byBwcm92aWRlIG1vcmUgZGV0YWlsZWQgaW5mbyBvbiB0aGlzLg0K
Pg0KPiBTbyBhIERBOTA2MSBydW5zIG9ubHkgZnJvbSBhbiBpbnRlcm5hbCBvc2NpbGxhdG9yLCB3
aGVyZWFzIGEgREE5MDYyDQo+IGNhbiBydW4gb24gZWl0aGVyIGFuIGludGVybmFsIG9yIGFuIGV4
dGVybmFsIG9zY2lsbGF0b3IuIFNvIHRoaXMNCj4gbWVhbnMgdGhhdCB0aGUgREE5MDYxIHRpbWVv
dXQgdmFsdWVzIGFyZSBkaWZmZXIgZnJvbSB0aGUgREE5MDYyDQo+IHdpdGggYW4gZXh0ZXJuYWwg
b3NjaWxsYXRvciBub3Qgb25seSBvbiBteSBkZXZpY2UgYnV0IG9uIGFsbCBEQTkwNjENCj4gZGV2
aWNlcy4NCj4NCj4gVGhpcyBhcmUgdGhlIHZhbHVlcyAoaW4gc2Vjb25kcykgaW4gY29tcGFyaXNv
bjoNCj4gREE5MDYyIChmcm9tIGRyaXZlcik6IDAgIDIgIDQgICA4ICAxNiAgMzIgIDY1IDEzMQ0K
PiBEQTkwNjEgKG1lYXN1cmVkKTogICAgMCAgMyAgNiAgMTIgIDI1ICA1MSAxMDIgMjA0DQo+ID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gRGlmZmVy
ZW5jZTogICAgICAgICAgIDAgKzEgKzIgICs0ICArOSArMTkgKzM3ICs3Mw0KPg0KPiBJbiBteSBv
cGluaW9uLCB0aGUgZGlmZmVyZW5jZXMgaW4gdGhlIGhpZ2hlciB2YWx1ZXMgYXJlIHZlcnkgaHVn
ZS4NCj4gSWYgSSBleHBlY3QgdGhhdCB0aGUgd2F0Y2hkb2cgdHJpZ2dlcnMgYW5kIEkgaGF2ZSB0
byB3YWl0IG1vcmUgdGhhbg0KPiBhIG1pbnV0ZSBmb3IgdGhhdCB0byBoYXBwZW4gSSBhc2sgbXlz
ZWxmIGlzIHRoZXJlIHNvbWV0aGluZyB3cm9uZy4NCj4NCj4gQEFuZHJlag0KPiBJIGd1ZXNzLCB5
b3UgYXJlIHVzaW5nIGFuIGV4dGVybmFsIG9zY2lsbGF0b3IsIGFyZW4ndCB5b3U/DQo+DQo+IEBB
ZGFtDQo+IElzIHRoZXJlIGEgd2F5IHRvIGNoZWNrIGluIHRoZSBkcml2ZXIgd2hpY2ggb3NjaWxs
YXRvciBpcyBpbiB1c2U/DQoNCkEgcXVpY2sgc2NhbiBvZiB0aGUgREE5MDYyIGRhdGFzaGVldCBz
aG93cyB0aGF0IHJlZy9maWVsZCBFTl8zMksvQ1JZU1RBTCB3aWxsDQppbmRpY2F0ZSB0aGUgcHJl
c2VuY2Ugb2YgYSAzMktIeiBjcnlzdGFsIG9zY2lsbGF0b3IuIE9idmlvdXNseSBvbiBEQTkwNjEg
dGhhdA0Kb3B0aW9uIGlzbid0IGF2YWlsYWJsZS4NCg0KSSB0aGluayB0aGUgcHJvYmxlbSBzZWVt
cyB0byBsaWUgYXJvdW5kIGRldGVybWluaW5nIHRoZSBpbnRlcm5hbCBvc2NpbGxhdG9yJ3MNCmZy
ZXF1ZW5jeS4gRGF0YXNoZWV0IHJlZmVyZW5jZXMgMjVNaHogaW4gVGFibGUgOSAoV2F0Y2hkb2cg
RWxlY3RyaWNhbA0KQ2hhcmFjdGVyaXN0aWNzKSwgYnV0IHRoYXQgZG9lc24ndCBzZWVtIHRvIHRh
bGx5IHdpdGggeW91ciB0aW1pbmdzIGFuZCBJIGRvbid0DQpzZWUgYW4gb2J2aW91cyB3YXkgaW4g
dGhlIHJlZ21hcCB0byBjYWxjdWxhdGUgdGhpcyBhdCBydW4gdGltZS4gKklmKiB0aGUNCm9zY2ls
bGF0b3IgZnJlcXVlbmN5IHZhcmllcyBmcm9tIHBhcnQgdG8gcGFydCwgb3IgdW5kZXIgZGlmZmVy
ZW50IGVudmlyb25tZW50YWwNCmNvbmRpdGlvbnMsIHRoZW4gaXQncyBnb2luZyB0byBiZSB0b3Vn
aCB0byB0aWUgdGhpcyBkb3duLCBhbmQgeW91IHdvdWxkbid0IHdhbnQNCnRvIHN0YXRlIGEgdGlt
ZW91dCB2YWx1ZSB0aGF0J3MgbG9uZ2VyIHRoYW4gcmVhbGl0eS4NCg==
