Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE77C46B2F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236873AbhLGGhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:37:46 -0500
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:63808
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236561AbhLGGhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:37:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDxofNfZYjVNKllfbI8E1sGTp9fKd6OZLY5gDla5RAlrlNt8pdQuBeTXALoAccSxDKAjoea5r90b9hkrgSpGrOkKbWR0GRRxtlLN/6kiU8jzuznrY8AFYPiC00Jq7GkzFgyb2Q3R1eOdNfYKfs9r6u/S8XNhnR0kpPhPwP6jnVMTG1ti7iWTnpKtTJ1isiMLfFSVvktapuV95YuMKVlJMdMbggEbDRNlFzNWTa1+dJ4lA+p0iDmspz5ulZJDcpnIzRG9gAYcr1dAKjcoedcBoUch1GkW2cEX3XNDe3rRetzaxQ9WAGqnL2R6Sz1rk5M1HKYVML89fg2gfdX+VvohSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kiWwBuuuz0iC9wQznbBPlATAtjttKqoO42NUaVV79A=;
 b=mRA1jUSyZaiOxZ2/AoIsR02Rd6hZ7gwmGr/j95Y6H4W1cHxVKd4S38pkG9DPf43/hUP9rBbwxu18vg6eT5hDauVfCWQXMFPnhSOnf008iDprmc2xIQjqQAGcpfTfW/lnSUoipv5mKXiaHqkQip0LKmBtnSo1VB2H/lhHoFZgXIWIAG84tGawXcA5zKxpjQCP82l9tS2B439/+3GuJ7hzOD3uLGNeipYbmK9SsQGyod+kJ1qda0ucfD1sNaYlBB5vW35mohR5qKEmaWuNuHTBOMiavPfpVkJ5B1tW1muxQy02MCqIWs3Hs4iynapphpqYms6MD7xsumHVy8lzT46JvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantatw.com; dmarc=pass action=none header.from=quantatw.com;
 dkim=pass header.d=quantatw.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kiWwBuuuz0iC9wQznbBPlATAtjttKqoO42NUaVV79A=;
 b=y0fjo+AKXmgxT71UeGu14mHxkEwHQooCKznAXWPH4zCV17Ts8m461H6FJzJecQpXvtNRL3MyRLnr8SSDyTg0jGktDaErC07RUHgduHLj/gEjrGlpb3dealDrfz2M6kf1jVn7oFH2aAnQGYLz0vS9hMekdx/isLRvi4jftaKCgAo=
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com (2603:1096:203:df::11)
 by HK0PR04MB2515.apcprd04.prod.outlook.com (2603:1096:203:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 06:34:06 +0000
Received: from HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194]) by HKAPR04MB4003.apcprd04.prod.outlook.com
 ([fe80::50ac:5788:d373:7194%5]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 06:34:06 +0000
From:   =?utf-8?B?SG93YXJkIENoaXUgKOmCseWGoOedvyk=?= 
        <Howard.Chiu@quantatw.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Patrick Williams <patrick@stwcx.xyz>,
        Howard Chiu <howard10703049@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Topic: [PATCH v6] ARM: dts: aspeed: Adding Facebook Bletchley BMC
Thread-Index: AQHX6vPlDf93t8kSvkG92vOctn4vNawmU+qQgAALh4CAAC/pcA==
Date:   Tue, 7 Dec 2021 06:34:06 +0000
Message-ID: <HKAPR04MB4003DBD7D21B59723CDC5718966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
References: <20211201033738.121846-1-howard.chiu@quantatw.com>
 <Ya5/v+VhOM9o9BtQ@heinlein>
 <CACPK8XdCjqB+HZ_g9O=gjnSne3=iV44i6jKP5M8yWcsjnttaog@mail.gmail.com>
 <HKAPR04MB40033D58E2C1F96DDF16C13C966E9@HKAPR04MB4003.apcprd04.prod.outlook.com>
 <CACPK8Xd93Kmvh7kT+4tbMO0+6LWa-2ORmt_KNB_hpqMYhso46A@mail.gmail.com>
In-Reply-To: <CACPK8Xd93Kmvh7kT+4tbMO0+6LWa-2ORmt_KNB_hpqMYhso46A@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 129b374b-ef6c-47b0-eee5-08d9b94b91af
x-ms-traffictypediagnostic: HK0PR04MB2515:EE_
x-microsoft-antispam-prvs: <HK0PR04MB2515423F8420AA8003A0E350966E9@HK0PR04MB2515.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b/Mb9bEPDA7wi86qVk7N3fJex6+DgYbNt3AtyS06M23EkX+jC7mX91f+tP2OQULOPT6MKEWMVTG5kzcgjF/vgo79yjsKN4P2NHht8nhl1aKt/oG0DQGD0jV2umQy3GeaFHf9P9shm/897UwO47kzOKqh7mCGETde/w7dZe6K7Vod8wyZereLM2UCa+XiP4btBfI3o3VWjhoM0SOXWkSPeaztH4xDPNZbE1/Wd9VmmR3MSPllEYeiKLsW1FODEr0E05OJfXGvHRpNGvUyUYrGEPYkOqQCPWQkiRpXwC5xHa+pSy0rLG9JBzFcuTair0liBuUAfWtZdNtkOYXqzk3R0SgXMWkKtyLOkyKQrk+gdSdwyMDCQDgHKsV1tWML2xFjRnVb/KJ9MD/zMfFgijaIbXQB27w3GBrU9PlpXvRSQTleaQYOQAZp/+79rkYXR8inQsYTg4IfmQcjry9n3NpIGkT+j265bInDOY9N/biurmXZFZ4zsdjOsWx6MkIl2WcTJaocClED2+m2FUzLBhXclZRExvhCyTjNxdTTbjr8GRgbGxkO45dPvAVvOloRcd6xP3DS+ZQFsWATheWtmDTdqKmz13svXao5yTuK9460Li9P6YJGYwWNsKm7bQR8DZRen1zSbqHGGQFEjmVhSdtYqip0pqR4+bms+5sualjfLaDPQlp2dajMWbVWxWphWIgCOA+RV5pIx3QeHGooL+gDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HKAPR04MB4003.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(47680400002)(38100700002)(66446008)(8676002)(316002)(9686003)(508600001)(122000001)(64756008)(7696005)(2906002)(66476007)(66946007)(66556008)(76116006)(7416002)(38070700005)(52536014)(71200400001)(33656002)(53546011)(6506007)(4326008)(5660300002)(8936002)(6916009)(85182001)(54906003)(186003)(86362001)(26005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWJtK2pSYXhnbHA0eTJMVkFVL00veVczVTFvd3piY1ZVQTJkQ2ZsKzVISG1C?=
 =?utf-8?B?VlpvYWxHVjRFVmhSYWhpU3RqNlBScnVGcjgra1d5aWNCc0xGSnFpZk4wWllH?=
 =?utf-8?B?QjB6S0dHc1JOVjZKNENxQ29jNDdDL3FtZWZCWGlBSGtDbTdNalJaSURzVzlz?=
 =?utf-8?B?ZlFVM0JGY1lST0dZRUNwT1dHZk1VQTJaWXRCL3Q5V2M3bTFYWi93YUVTN24r?=
 =?utf-8?B?VXd3Nzd5VVFhSUxtSWlGK0FYR01oakVVTXlhak0rN2FmbklML1Bqbkk5WVhJ?=
 =?utf-8?B?V3pVYkkvUjdHQ0UxNU9OMUpjL0ova3dCazFwOWhUVERqUzVOaFBiSDRJVTVB?=
 =?utf-8?B?SkxNWGF3dzFaYkxSMUErT1ZzRWtidmNhZlJBOXVweDdOazU1TFRvVnJuY1Qw?=
 =?utf-8?B?WE4yMCtZWjNiT0dlV2llVXNnRTBNVU1oOWY2NUlZWjAySkRMVmR5QWV1aW1a?=
 =?utf-8?B?UW9Ua2VlSXREQTJCZjltTWpEazhQMmxiVElWdzZkY1FZaUZab0JvNlhTdzhF?=
 =?utf-8?B?MTNrbXBBNGZsc0ZKZ1VlY0N1dGZKWW85NkM2SksvZUtXTHZpOW9LOFJWQ1RS?=
 =?utf-8?B?UUhlMmlsV0cwZXhaN1hCTEQyT1IxUkljMEtsVjdlRDFuUVNHL000NTFLM3NI?=
 =?utf-8?B?UitESWhEOTloUVZYRnZmS0p1UGM4T0tCeTlVWjBuVWl5emdqYjBDZzFyL1J3?=
 =?utf-8?B?NkNmL1U4VTJXZ0hYOW9ZdjVOTjBQd2hGMWJIWm96ek81Z1NtL2lEQ01pdGFZ?=
 =?utf-8?B?Tk1LRjlFVS81L1lIeFJrM0xnTzRMNlJzUVZ4SWxncm9Vc21yeGU0ZW9DeFNN?=
 =?utf-8?B?eS9sREMrM1BsdytWZ0hJcWdKc21POHZyU05NV29CcGpQVWF0N1FpN0FmNGxH?=
 =?utf-8?B?Rk1NWUM4VWxsWG50aDdKc1FwVGlJTllqQUZlS0NCY0pPMEVxNDZkVmovdzhS?=
 =?utf-8?B?Q2xBeEVOSG5OZWdXRkZQblJKZ2dFU0JOZVZ3TWNPSUszNks3UEV1T3ppQzJK?=
 =?utf-8?B?LzMzL25pYmlSd1p5ekFZdG9hRG5nOXlHeHZFSk1XRm1jaFU0WnEvZ20vbi9v?=
 =?utf-8?B?MURoNWQrOTRrLzRsclZDOXFqb0V2dmF6SnI2TFZIK2dBbGM0S3NGb0VGcVFt?=
 =?utf-8?B?TTJSU1Vaa2d3VlI4WDFxTkZ3SzQ2WElIQzJaeWV0blp3cmRndTVDYTlKcUlV?=
 =?utf-8?B?eWduUTF0OUtEL0lqa0cvUXdmdXcvUmJLMXgrMFR4bEd5QXgzSko0bVhjQi9I?=
 =?utf-8?B?b1grUENKblk1cUJLYnRvRXF4VGhVbDRtZGQ1ZVh5eWdoZkxPT1NjZXM0UXdR?=
 =?utf-8?B?ZE9ZZjhFYWtQMVJENEpBOUVsQXlUeHIwNVU0NjFNVExPRkFnc3BYZko5aEcz?=
 =?utf-8?B?SWxWTjJQanRXU1J6angrUVZoeEdMaVFZNGdMWWpIUTUyWFJDbC9FWVM4Rmxr?=
 =?utf-8?B?d2VHbTZ4ek5YRDc1U0hmZUpsdWhtVHlmQjhwVDJaRExVbTNOZ2x5VDJoN01m?=
 =?utf-8?B?Vks1bU1tQ3l6UEswT3RKdG9LZGVBeWxueVZuRmhsVFZ2a1NHb25LZ1BGMTdo?=
 =?utf-8?B?TFppUzJCckVad3dncVBMYnovY01KSjBMSFBxYTVORmdzQ3VqYnJVd0kzT2NE?=
 =?utf-8?B?a1JjYi92cDdoa1RicHo5ZE9Ucmd2T3h0cm9JQ281eWlEU2xLKzJoeGtUSTcx?=
 =?utf-8?B?azFEYjAvVHhGa2tpWVIwMlZUYXQwa0ZUTXVXUFh3cXdVeFVQVFZTU1lYOE05?=
 =?utf-8?B?SE5IYnpwbk5ydTZWejZKRFpjU3dOMkJnYlBjbENIUGl6UW9nSXNEVTEyVzkz?=
 =?utf-8?B?QmE2MjYwTE1uWDhyMHk5VURZMWRleGgxNWg3S0VpejNpNFJMZVo2SG1FWTZZ?=
 =?utf-8?B?YXlUcnN1UmlDdWdVU2N2TVMyNXltUWRHVTJ0ZnN3NTZWcW1wTDhka2tkT0Nt?=
 =?utf-8?B?bjFTVXpHWVBVbUZSdnZKYjFGbmc2KzNRSUFMak1qM1NXQmxReWtkeXJVRU82?=
 =?utf-8?B?MFBqU01iSEpZNnBCamtCZURwRHArL2k2YXkvenZ2WG1nVkVBcHppclBBTCs4?=
 =?utf-8?B?TjNnSDV2SG9rSDhseEN5QVNwRmwvNUFTblBNY25KTnRhMkJ5YUI5UVlJTGhN?=
 =?utf-8?B?L2lXVmt3Tjc4bFlyZGRBQ1EvM0VYUnE0MHBxRHBObjdtM051NlhkVDQrYXVl?=
 =?utf-8?B?eHM3dmFDSFk0WVBZK1cyZ3ZwcjZsTTdmeDIrQWpJWjB2LzYxMitPaDhvQjRJ?=
 =?utf-8?B?dTRQTThqOHVVZi9lcUhaTElxd2RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HKAPR04MB4003.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129b374b-ef6c-47b0-eee5-08d9b94b91af
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 06:34:06.6454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNPMtTLmknPjSlXh/hiQUIYaVX92+tNy7cfC2fID9RmwAWqBtvKuUauIFX4Xi1wDdg0WejqNKbc+ZzPo4giVn9GpRbbo6S3d6eZuLjWjJzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbA0KDQo+IEknZCBzdWdnZXN0IG5vLCBvbWl0IHRob3NlIGZlYXR1cmVzIGZvciBub3cs
IGFuZCB5b3UgY2FuIGFkZCB0aGVtIGluDQo+IG9uY2Ugd2UgaGF2ZSBhIGRyaXZlci4gVGhlIGRl
dmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgdGFjaC9wd20gbmVlZA0KPiBzb21lIHdvcmsgYmVm
b3JlIHRoZXkgY2FuIGJlIGFwcHJvdmVkLg0KDQpUaGUgZHJpdmVyIHlvdSBtZW50aW9uZWQgaXMg
Zm9yIE9wZW5CTUMgTGludXggb3IgdXBzdHJlYW0/DQpJZiBpdCBpcyBmb3IgT3BlbkJNQywgdGhl
IHVwc3RyZWFtIHJvYm90IHdpbGwgcmVqZWN0IG15IERUUyBiZWNhdXNlIHRoZSBhc3BlZWQtZzYu
ZHRzaSBkaWQgbm90IGNvbnRhaW4gcHdtL3RhY2ggbm9kZS4NCg0KSWYgaXQgaXMgZm9yIHVwc3Ry
ZWFtLCBpdCB3aWxsIGJlIGEgbG9uZyB0aW1lIHRoYXQgT3BlbkJNQyBMaW51eCB3b24ndCBoYXZl
IHRhY2ggZHJpdmVyIGZvciBhc3QyNjAwIHNlcmllcywgYW5kIG15IHBhdGNoIHRvIGNvbW1pdCB3
aXRoIEJpbGx5J3MgZWFybHkgZHJpdmVyIGZvciBPcGVuQk1DIExpbnV4IGlzIGFsc28gbWVhbmlu
Z2xlc3MuDQoNCj4gV2hlbiBJIGFza2VkIHlvdSB0byBmaXggdGhlIHBhdGNoLCBJIHdhcyByZWZl
cnJpbmcgdG8gdGhlIHVzYi1jDQo+IHdhcm5pbmdzIHRoYXQgSSBwb3N0ZWQgYWJvdXQgdGhlIG90
aGVyIHdlZWsuDQpJIHdpbGwgZml4IGl0IGFuZCBvdGhlcnMgeW91IG1lbnRpb25lZCBpbiB0aGUg
djcgcGF0Y2guDQoNCkhvd2FyZA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2Vt
YmVyIDcsIDIwMjEgMTE6MzAgQU0NCj4gVG86IEhvd2FyZCBDaGl1ICjpgrHlhqDnnb8pIDxIb3dh
cmQuQ2hpdUBxdWFudGF0dy5jb20+DQo+IENjOiBQYXRyaWNrIFdpbGxpYW1zIDxwYXRyaWNrQHN0
d2N4Lnh5ej47IEhvd2FyZCBDaGl1DQo+IDxob3dhcmQxMDcwMzA0OUBnbWFpbC5jb20+OyBBcm5k
IEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgT2xvZg0KPiBKb2hhbnNzb24gPG9sb2ZAbGl4b20u
bmV0PjsgU29DIFRlYW0gPHNvY0BrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmgrZHRA
a2VybmVsLm9yZz47IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAYWouaWQuYXU+OyBMaW51eCBBUk0N
Cj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IGRldmljZXRyZWUNCj4g
PGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdA0K
PiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFzcGVlZCA8bGludXgtYXNw
ZWVkQGxpc3RzLm96bGFicy5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjZdIEFSTTogZHRz
OiBhc3BlZWQ6IEFkZGluZyBGYWNlYm9vayBCbGV0Y2hsZXkgQk1DDQo+IA0KPiBPbiBUdWUsIDcg
RGVjIDIwMjEgYXQgMDI6NTMsIEhvd2FyZCBDaGl1ICjpgrHlhqDnnb8pDQo+IDxIb3dhcmQuQ2hp
dUBxdWFudGF0dy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgSm9lbA0KPiA+DQo+ID4gQmxldGNo
bGV5IHBsYXRmb3JtIG5lZWRzIHRvIHN1cHBvcnQgZmFuIGNvbnRyb2wuDQo+ID4gU2luY2UgQmls
bHkncyBwYXRjaCBmb3IgdXBzdHJlYW0gaXMgc3RpbGwgdW5kZXIgcmV2aWV3LCBJIGNhbid0IGFk
ZCBwd20vdGFjaA0KPiBub2RlIGludG8gZHRzIG9yIHRoZSBidWlsZCB3b3VsZCBmYWlsLg0KPiA+
DQo+ID4gQXMgeW91IGtub3csIEkgaGFkIGNvbW1pdHRlZCB0aGUgcHdtL3RhY2ggZHJpdmVyIGZv
ciBhc3QyNnh4IHRvIE9wZW5CTUMNCj4gbGludXgsIGNvdWxkIEkgY29tbWl0IHRoZSBkdHMgdG8g
T3BlbkJNQyBsaW51eCBpbnN0ZWFkIG9mIHVwc3RyZWFtIGZvciBlYXJseQ0KPiBidWlsZD8NCj4g
DQo+IEknZCBzdWdnZXN0IG5vLCBvbWl0IHRob3NlIGZlYXR1cmVzIGZvciBub3csIGFuZCB5b3Ug
Y2FuIGFkZCB0aGVtIGluDQo+IG9uY2Ugd2UgaGF2ZSBhIGRyaXZlci4gVGhlIGRldmljZSB0cmVl
IGJpbmRpbmdzIGZvciB0aGUgdGFjaC9wd20gbmVlZA0KPiBzb21lIHdvcmsgYmVmb3JlIHRoZXkg
Y2FuIGJlIGFwcHJvdmVkLg0KPiANCj4gV2hlbiBJIGFza2VkIHlvdSB0byBmaXggdGhlIHBhdGNo
LCBJIHdhcyByZWZlcnJpbmcgdG8gdGhlIHVzYi1jDQo+IHdhcm5pbmdzIHRoYXQgSSBwb3N0ZWQg
YWJvdXQgdGhlIG90aGVyIHdlZWsuDQo+IA0KPiA+DQo+ID4gSG93YXJkDQo+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiA+ID4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgNywgMjAyMSA2OjUyIEFN
DQo+ID4gPiBUbzogUGF0cmljayBXaWxsaWFtcyA8cGF0cmlja0BzdHdjeC54eXo+DQo+ID4gPiBD
YzogSG93YXJkIENoaXUgPGhvd2FyZDEwNzAzMDQ5QGdtYWlsLmNvbT47IEFybmQgQmVyZ21hbm4N
Cj4gPiA+IDxhcm5kQGFybmRiLmRlPjsgT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pjsg
U29DIFRlYW0NCj4gPiA+IDxzb2NAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtl
cm5lbC5vcmc+OyBBbmRyZXcgSmVmZmVyeQ0KPiA+ID4gPGFuZHJld0Bhai5pZC5hdT47IExpbnV4
IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj4gPiA+IGRldmlj
ZXRyZWUgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcg
TGlzdA0KPiA+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1hc3BlZWQN
Cj4gPGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnPjsNCj4gPiA+IEhvd2FyZCBDaGl1ICjp
grHlhqDnnb8pIDxIb3dhcmQuQ2hpdUBxdWFudGF0dy5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2XSBBUk06IGR0czogYXNwZWVkOiBBZGRpbmcgRmFjZWJvb2sgQmxldGNobGV5IEJN
Qw0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgNiBEZWMgMjAyMSBhdCAyMToyNSwgUGF0cmljayBXaWxs
aWFtcyA8cGF0cmlja0BzdHdjeC54eXo+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBXZWQs
IERlYyAwMSwgMjAyMSBhdCAxMTozNzozOEFNICswODAwLCBIb3dhcmQgQ2hpdSB3cm90ZToNCj4g
PiA+ID4gPiBJbml0aWFsIGludHJvZHVjdGlvbiBvZiBGYWNlYm9vayBCbGV0Y2hsZXkgZXF1aXBw
ZWQgd2l0aA0KPiA+ID4gPiA+IEFzcGVlZCAyNjAwIEJNQyBTb0MuDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBIb3dhcmQgQ2hpdSA8aG93YXJkLmNoaXVAcXVhbnRhdHcuY29t
Pg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IC4uLg0KPiA+ID4gPg0KPiA+ID4gPiA+IENo
YW5nZSBzaW5jZSB2MjoNCj4gPiA+ID4gPiAtIFJlbW92ZSB1YXJ0NSB3b3JrYXJvdW5kDQo+ID4g
PiA+ID4gLSBSZW1vdmUgZ3BpbyBub2RlcyBvZiBwY2E5NTUyL3BjYTk1MzkNCj4gPiA+ID4gPiAt
IE1vZGlmeSBncGlvLWxpbmUtbmFtZSBvZiBsZWQvcG93ZXIvcHJlc2VuY2UgcGlucyB3aXRoIG9w
ZW5ibWMNCj4gPiA+IHBhdHRlcm4NCj4gPiA+ID4NCj4gPiA+ID4gQSBudW1iZXIgb2YgdGhlIEdQ
SU9zIGRvIG5vdCBoYXZlIGRlZmluZWQgb3BlbmJtYyBwYXR0ZXJucyBmb3IgdGhlbQ0KPiB5ZXQu
DQo+ID4gPiBUaGUNCj4gPiA+ID4gbmFtZXMgeW91IGhhdmUgY2hvc2VuIGFyZSBvayBmb3Igbm93
LCBidXQgd2Ugd2lsbCBiZSBjaGFuZ2luZyB0aGVtIGFzDQo+IHdlDQo+ID4gPiByZWZpbmUNCj4g
PiA+ID4gZGV2ZWxvcG1lbnQgb2YgdGhpcyBtYWNoaW5lIGZ1cnRoZXIuDQo+ID4gPiA+DQo+ID4g
PiA+ID4gKyAgICAgICAgICAgICBncGlvLWxpbmUtbmFtZXMgPQ0KPiA+ID4gPiA+ICsNCj4gPiA+
DQo+ICJTTEVEMF9NU19ERVRFQ1QxIiwiU0xFRDBfVkJVU19CTUNfRU4iLCJTTEVEMF9JTkEyMzBf
QUxFUlQiLCJTTEUNCj4gPiA+IEQwX1AxMlZfU1RCWV9BTEVSVCIsDQo+ID4gPiA+ID4gKw0KPiA+
ID4NCj4gIlNMRUQwX1NTRF9BTEVSVCIsIlNMRUQwX01TX0RFVEVDVDAiLCJTTEVEMF9SU1RfQ0NH
NSIsIlNMRUQwX0ZVU0INCj4gPiA+IDMwMl9JTlQiLA0KPiA+ID4gPiA+ICsNCj4gPiA+DQo+ICJT
TEVEMF9NRF9TVEJZX1JFU0VUIiwiU0xFRDBfTURfSU9FWFBfRU5fRkFVTFQiLCJTTEVEMF9NRF9E
SVIiLCINCj4gPiA+IFNMRUQwX01EX0RFQ0FZIiwNCj4gPiA+ID4gPiArDQo+ID4gPg0KPiAiU0xF
RDBfTURfTU9ERTEiLCJTTEVEMF9NRF9NT0RFMiIsIlNMRUQwX01EX01PREUzIiwicG93ZXItaG8N
Cj4gPiA+IHN0MCI7DQo+ID4gPiA+DQo+ID4gPiA+IFN1Y2ggYXMgdGhlc2UuLi4NCj4gPiA+ID4N
Cj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMjUuMQ0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4g
PiA+IE90aGVyd2lzZSwNCj4gPiA+ID4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IFBhdHJpY2sgV2ls
bGlhbXMgPHBhdHJpY2tAc3R3Y3gueHl6Pg0KPiA+ID4NCj4gPiA+IFRoYW5rcyBmb3IgcmV2aWV3
aW5nLg0KPiA+ID4NCj4gPiA+IEhvd2FyZCwgSSdtIG1lcmdpbmcgcGF0Y2hlcyBmb3IgdjUuMTcg
YnV0IEkgY2FuJ3QgYXBwbHkgdGhpcyB1bnRpbCB5b3UNCj4gPiA+IGZpeCB0aGUgd2FybmluZ3Mg
SSBtZW50aW9uZWQuDQo+ID4gPg0KPiA+ID4gQ2hlZXJzLA0KPiA+ID4NCj4gPiA+IEplb2wNCj4g
PiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gUGF0cmljayBXaWxsaWFtcw0K
