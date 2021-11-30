Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F98C463D33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245164AbhK3Rus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 12:50:48 -0500
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:3970
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239347AbhK3Rtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:49:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3PzodjXp0Fs09qG/g1iw1431+59h2heN6+8LBwOpDsLv2Z3MO/cwSHPmepiAMBR8J09e8iw5hrqjjI/LLQYfke5Wh4Elyxs04d6yhJSJF4sov5s4bRc6cAchX/ZdzUPHAg6/lHm/L+xBX7acA/eH7JRaQwFXz+FOVB2HBRjg7SL5TdMGuyEEgwuDf4jW6ywRX44U1GWmyd2zavwq1rp8xXWLljDK4JfpyvomgqqvDoOT3CEylVKkpcxeFMyL2uAELktv759rvlyoWNKwW1Rs2N03db+D4Hx2vhihoxSB86SuAfIfBrsBb4y9eM9gv26L946H7k7X+ub4J6ljFGsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCnQwPvHidGFysNXGzvXyj8xvMNWP68mM1SlK5+uiGs=;
 b=FbOuQCeTFThtsWXoGVgyF1dvCzQ5myFTvBhGsNL6S4hzNdU7HnmHQsIl0P0irGV3IlYuRovICCUa93Op7bBXrRdvc/pFn9gSbcpXK6HQRDccDffzi9So7N8NO5210aCGorZDeUGzaopEyiZzy0ET010mk+qWUHV3cakveVmaHy4C4YwCeu4I5UxIcJnElS3h0m8S/ZHjxn5sG4M5u2SHHJBgb8pMZ+2Ihq57W42uyA79LT4nAi8UJO66LIRcr84PIsRtw78tj1ARLMP4O9dMtentafwXBHSqIb5w7uYhZPdJPYE2LHIg+Lmsz1FgZqNxdgAsCaRldS/WgKqWIjV8SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCnQwPvHidGFysNXGzvXyj8xvMNWP68mM1SlK5+uiGs=;
 b=qOQ6C3GyMif2Tlk6xEivSjFSbWmFCW+OUn3mS9ToPguvohGUqXT7h/2m0CtNCN0n1cwjitr5LGq1QI/+feyeVSCm8i9AlHgeBpGDV4S6zzx17lgHZJOA63aKDyOUccMNaCCYXMOF/HgxhblWgg9uzt+LCBi5RHUAaST6C31EYo0=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4476.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 17:46:23 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 17:46:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
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
Thread-Index: AQHX5fAwp6aBl2Hn4kyu/pPkB5+TWawcImuAgAAZNOCAAAppgIAADhYg
Date:   Tue, 30 Nov 2021 17:46:23 +0000
Message-ID: <DB9PR10MB46521F419F43685F7103D32480679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211130134242.3516619-1-andrej.picej@norik.com>
 <20211130134242.3516619-3-andrej.picej@norik.com>
 <4591cdd6-9a7b-cd1d-817d-8950c8976d10@roeck-us.net>
 <DB9PR10MB4652C8A69A6A3F38B93ED18880679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <dcd75a82-5837-8d78-0a9f-6e5b7eafff28@roeck-us.net>
In-Reply-To: <dcd75a82-5837-8d78-0a9f-6e5b7eafff28@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8e9c642-41fe-4ebb-2048-08d9b429538f
x-ms-traffictypediagnostic: DB9PR10MB4476:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB4476EEF166E70A7061EA867AA7679@DB9PR10MB4476.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1j1MO/eKMHyli1z5RY/hzDLpe48ObvFX8I/BRSNkGHiJpRYI9oApwqjSr7icdoYIEaVtU5WlQZzCztSPQpRhctBpDeA5ToLTyKvhbEj5R31HGhpkSjztSzKD4BS1g8VuHv2rcUZ7mIMnu6gVCZ4TNv+ZT7nxIMhdPJVJkGQ/5M7apTfnXINMFH9hVIvtPRfZ9PlqtlRpaGM/3BVDfkvWllEEvUbJvP36MxYurv/fp1jj1u3FSuqaiIMHIwiuNxq0MvB6lkK8xFxe8Q0NrCorl6s14XX3vz6ea57zKJ542qetAbGP/jNxEGCa/zX5qDx7mVpqRsa3wYCH6xHd8eEohfyuWNaN1obtSOnAS6Q6DOA1mdVtin/wW9B8cCbAsZb5CV3CG2PdYHiiXAWap0X2S74/5yvY6VnbCx9XlPSSHP9fwo9GESJBBpGyQxcZcEr3Un+fVenQ2HsaIObL47CE7XGDLEECUoEWq8aKbX1bKlX0Zxm5ZOrKdB2ZLMH85PUHCmM20zaA2ae3C7XqxaU2QP4ZnXewlW/QKbcSQys3Rwvyk+sK3c5dyGF2Lj+XbJgj5Kd5OScOjHzoy3Gh+49vIrVao/4K/aWoPDVeK9UoFKoAP1UdpE3XplQMewLJuIBTY0JxlQYkOah8V6rtLhJBZW1H1OhnSKpWY6+DM4iDWxeCx/LBBTatgT+Vp19K8p0QpOVUAoBK3kkjwouKJfWJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(9686003)(86362001)(7696005)(66556008)(186003)(5660300002)(110136005)(33656002)(6506007)(53546011)(71200400001)(122000001)(38100700002)(83380400001)(7416002)(2906002)(55236004)(316002)(66446008)(26005)(38070700005)(54906003)(66476007)(52536014)(4326008)(508600001)(55016003)(76116006)(64756008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVlJTUszWFdJZk9pK2JsR2FZbHhxSktRUVVWV0FVRCtGd0dqU3hOQU9ua0E0?=
 =?utf-8?B?Z04zTUdIaXlmQTZWR3pJYjBEVjY4OEZQVXlTQkl0STRqQXdjOEZPRitLUWlU?=
 =?utf-8?B?aytTYW9Kd2dNaENhTzFrSFZVWmhOTU9MeFQxMFplYmYrSjlUbmdQaENxcW1M?=
 =?utf-8?B?dmEyWFNIUm1zNlpibVRCNDEzRytSYUR2WjR4aUkzRmpzdllqTW10Q1RqQlZL?=
 =?utf-8?B?Nll5QTYxRDlEUjJUVkt2YTQ4a1o1LzlOeENNa1NDL3lKb1JPcksvb0YwSXA2?=
 =?utf-8?B?RTVZUlZYZnhsaUdYb2c5bnNIcERjVVpXdzZSRmk0VnFTTml3UFptVDI1bHNp?=
 =?utf-8?B?dENmbWNvYitJNWZPYW1uelcra2tHSDA3UDRuU3BZbDZWQmlTdG9TaTQxclJ6?=
 =?utf-8?B?dlBXRWtkc3ByZ2U2dWYyME8xb2JUTXE5SnhOUXFETloxSFBRMlNOWmk3Mjli?=
 =?utf-8?B?VnNZOGRnOUxpQy9rbTY0NXFmOHhTQ3JqbHVEK0Jsa2hYaEJ4cFZNQmhsSENE?=
 =?utf-8?B?V0EwTUgycnVuQ2lEeFVRTGxnalcrejR1RUwraUVhN1hFUDFSbDZsTGRZbzBH?=
 =?utf-8?B?alErTlVab2lRT2phdTJscXY5Tnd0TXd6bmdFdER2ZHFkTy8wQlpBNGdaakRV?=
 =?utf-8?B?RTRFVVpqZkdkd3JudlVMajZ0b0ZFUUpVVWRyTUUyb3I1WTI1dUViWTRsMWt0?=
 =?utf-8?B?ei82NDUwY25pbjd2V3RxNnluSWViMlVnMklCYlcrR1Vnd04zSzFpYkpiSDVq?=
 =?utf-8?B?R1VzV2wvVjI5ZVVmUEdYWmhiZDlWemZ3NjlYN0FzSjljYUtYN3BDaStaQm4v?=
 =?utf-8?B?aXZJWVhxbGJueEhQWndTSjhrUmJmaVQzQXJQcWJraEI4QlRSb3UwejRkU2xW?=
 =?utf-8?B?SDBSWWpFU2kzbjYvemxxL3Bxc1RFVmFZckJLOWdUTlp2OUttL3ZhTjlvUnZp?=
 =?utf-8?B?UjBMNXFkNUZCYXV0VjNrSVlqekhDcjlxMkgrNHhTTXo5WXdKUWpxTldOWSt4?=
 =?utf-8?B?MFZqK1cvYmFyTys3UmYrZEtGMWpGWHByVS9xQktTci9BQU50NlRaQnpBck9a?=
 =?utf-8?B?QWNudkN1UEcxYWRQL2JMczVFdEVKZzVwOUtZeElSakE1QzZ1TGRWc1FLNExl?=
 =?utf-8?B?eHNEYmNiVFhjL3pVcVBJQm8zK1J3MXgrY05oOEZwb2dEY01BNmdPZHR6bFVS?=
 =?utf-8?B?OW5iTlFjbUhxeTBhN2JzZmlRNnptVCtLMTg0VWhxaVMzWHJoVXJyTE9GM1dY?=
 =?utf-8?B?U2NIeDNQbmk4RjRvaTFxU2l6TUUxVC8vakRqOGhNcVVYWDlhWGdDWlJYZFFv?=
 =?utf-8?B?S1pmSmpyMWNYUFpMY280ZVRPTnQ0MUhvNlY4ZDI1STBTNXlJNmhBVGZUdm91?=
 =?utf-8?B?bGRXQktXUzQvWXJzQ0lId2R5a2s2dmZDVG9SMkNUSWYrY0pCOVF5Yy9EN2or?=
 =?utf-8?B?V3dweFBNdG9FQTlOVXloeFBtSmxGQnVUTm1DTDlFSjFlUlhzZmQ4T2Y5bFFS?=
 =?utf-8?B?NVZ4U3lyOXh0d0J1R1d3dXV6U1lPVWpJblFBYTdFa2M4ZlkvZ3JBcUU1M3BS?=
 =?utf-8?B?N0FJVVpobzNzQnNRckZ1RjA0NWJVb1VkR1pyRXB1MTB2bU96dGpjVERTdHJq?=
 =?utf-8?B?YjduSWZMalRRNkpOWCtOTWJLdUNzZElEVUpUR2gyeCs1U0NwSVRNSWJ3MlNl?=
 =?utf-8?B?OElDcjNaQXBJS1JtMzhPOUtsNmJDdkUwNEYvVzBsUm1sRjFwWERwcUNGRjNK?=
 =?utf-8?B?VzZRZGY2RGQrbTBIU2ZuRHovSVNiU0VHUXRrMzNmcWs3bXl3ZlpJbnVremV0?=
 =?utf-8?B?K28rc0RnVUFKSFU0SHpFc2VVUUNlWHhSUVJEaTVMUHNIOEdLTHFBM0Fzd1hh?=
 =?utf-8?B?UGg3VWFyRXpCQnVGVlhxS05mRGc2ekdGc2pGeno3eVQ3SWNvcUExRFA1cGZQ?=
 =?utf-8?B?NHZYUnJkaExKTnlsL0lNMms5V1V4Y0FKTytPc3BiN1JJcGVoVktOT0IrQWs5?=
 =?utf-8?B?ZXZXMUpOa0Y3ZG8zUGN1UzJzRGlwMnVJVk53enlZQUVUOWxISlRQakp0UG40?=
 =?utf-8?B?bS9rcERBcFBjSTlZVDBiU25XYjZoSzI4dUVWYmpmOExkT3FLU0RyaEhQV09r?=
 =?utf-8?B?aXgrTzIrUy9QUEpDZ2MzN2c0ZkQvODdYdnRlZnQ4Z2E0d3pyNWt3ekQzRDBS?=
 =?utf-8?B?dkRjck5RZWE4cFg5SHBkWkgzRGJEOHUzUW4zNncyaVRYSlpnTzJGMlV0NXJm?=
 =?utf-8?B?cStmcUJQUkxrYWZwVzFrbzV1UFFBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e9c642-41fe-4ebb-2048-08d9b429538f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 17:46:23.6411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jIxY9x/5fhSmatzbXgQnpNUfpyBov8qj04OgTXG9CfQW8T5DPu1efO6TqBIgR+DqsWUEl0fD3VbL9TcEG/ovr28TdI1BMHX9lxa5WjKXhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4476
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAgTm92ZW1iZXIgMjAyMSAxNjo0MCwgR3VlbnRlciBSb2VjayB3cm90ZToNCg0KPiA+PiBX
aHkgZG9lcyBpdCBuZWVkIGEgdmFsdWUgPyBXaHkgbm90IGp1c3QgYm9vbCA/DQo+ID4NCj4gPiBP
bmUgYXJndW1lbnQgbWlnaHQgYmUgdGhhdCBpZiB0aGUgcHJvcGVydHkgaXNuJ3QgcHJvdmlkZWQg
dGhlbiB0aGUgT1RQDQo+ID4gY29uZmlndXJlZCB2YWx1ZSBjYW4gcGVyc2lzdCB3aXRob3V0IG5l
ZWRpbmcgYSBGVyBjaGFuZ2UgYXJvdW5kIHRoaXMgRFQNCj4gYmluZGluZy4NCj4gPg0KPiA+IE15
IGJlbGllZiB0aG91Z2ggaXMgdGhhdCB0aGUgbWFqb3JpdHkgb2YgdXNlcnMgd291bGQgaGF2ZSB0
aGlzIHByb3BlcnR5IHNldCB0byAwDQo+ID4gYnkgZGVmYXVsdCBpbiBPVFAsIHNvIGEgYm9vbGVh
biB3b3VsZCBiZSBPSyBJIHRoaW5rIGhlcmUgdG8gZW5hYmxlIHdhdGNoZG9nDQo+ID4gc2h1dGRv
d24uDQo+ID4NCj4gDQo+IFNvcnJ5LCB5b3UgbG9zdCBtZS4NCj4gCWRsZyx3ZHQtc2QgPSA8MD47
DQo+IGlzIHRoZSBjdXJyZW50IHNpdHVhdGlvbiwgYW5kIGlkZW50aWNhbCB0byBub3QgaGF2aW5n
IHRoZSBwcm9wZXJ0eSBpbg0KPiB0aGUgZmlyc3QgcGxhY2UuDQo+IAlkbGcsd2R0LXNkID0gPDE+
Ow0KPiBpcyBuZXcuIEkgZG9uJ3Qgc2VlIHRoZSBkaWZmZXJlbmNlIHRvDQo+IAlkbGcsd2R0LXNk
Ow0KPiB2cy4gbm90IGhhdmluZyB0aGUgcHJvcGVydHkgYXQgYWxsICh3aGljaCBpcywgYWdhaW4s
IHRoZSBjdXJyZW50IHNpdHVhdGlvbikuDQo+IFNpbmNlIGl0IGhhcyB0byBiZSBiYWNrd2FyZCBj
b21wYXRpYmxlLA0KPiAJZGxnLHdkdC1zZCA9IDwwPjsNCj4gd2lsbCBhbHdheXMgYmUgaWRlbnRp
Y2FsIHRvIG5vdCBoYXZpbmcgdGhlIHByb3BlcnR5IGF0IGFsbC4NCj4gSSBjYW4gbm90IGZpbmQg
YSBzaXR1YXRpb24gd2hlcmUgYW4gaW50ZWdlciB3b3VsZCBoYXZlIGFueSBiZW5lZml0cyBvdmVy
IGENCj4gYm9vbGVhbi4NCg0KU28gaWYgeW91IGhhdmUgYSBiaW5hcnkgRFQgYmluZGluZywgaXQn
cyBlaXRoZXIgdGhlcmUgb3IgaXQgaXNuJ3Qgd2hpY2ggaW1wbGllcw0KdGhlIGJpdCB0byBiZSBz
ZXQgdG8gMC8xIGluIHRoaXMgY2FzZS4gSWYgeW91IGhhdmUgYSBiaW5kaW5nIHdoaWNoIGhhcyBh
IHZhbHVlLA0KdGhlcmUgY2FuIGJlIDMgb3V0Y29tZXMgaW4gdGhpcyBkaXNjdXNzaW9uOg0KDQog
MSkgQmluZGluZyA9IDAsIGJpdCBpcyBzZXQgdG8gMA0KIDIpIEJpbmRpbmcgPSAxLCBiaXQgaXMg
c2V0IHRvIDENCiAzKSBCaW5kaW5nIE5PVCBwcmVzZW50IGluIERULCBPVFAgZGVmYXVsdCB2YWx1
ZSBpbiBIVyByZW1haW5zIHVudG91Y2hlZA0KDQpTYXkgYSBwbGF0Zm9ybSB1cGRhdGVzIHRvIGEg
bGF0ZXIga2VybmVsIHZlcnNpb24sIGJ1dCBzdGlja3Mgd2l0aCBleGlzdGluZyBEVA0KRlcgKGku
ZS4gdGhlIG5ldyBib29sZWFuIGJpbmRpbmcgaXNuJ3QgcHJlc2VudCBpbiBGVyksIHRoZW4gdGhl
IGZvbGxvd2luZyBjb3VsZA0KaGFwcGVuOg0KDQogMSkgT1RQIGZvciBEQTkwNjEvMiBoYXMgdGhp
cyBiaXQgc2V0IHRvIDEsIHN5c3RlbSBleHBlY3RhdGlvbiBpcyB0aGF0IHdhdGNoZG9nDQogICAg
dHJpZ2dlcnMgU0hVVERPV04uDQogMikgTmV3IGRyaXZlciBjaGVja3MgZXhpc3RhbmNlIG9mICdk
bGcsd2R0LXNkJyBidXQgaXQncyBvYnZpb3VzbHkgbm90IHRoZXJlIHNvDQogICAgYXNzdW1lcyB0
aGUgYml0IHNob3VsZCBiZSBzZXQgdG8gMCBhbmQgZG9lcyBzbw0KIDMpIFdoZW4gdGhlIHdhdGNo
ZG9nIGZpcmVzLCBpdCB3aWxsIG5vIGxvbmdlciB0cmlnZ2VyIFNIVVRET1dOIGJ1dCBpbnN0ZWFk
DQogICAgUE9XRVItRE9XTiBkdWUgdG8gYmluYXJ5IGhhbmRsaW5nIG9mIG5ldyBib29sZWFuIGJp
bmRpbmcuDQo=
