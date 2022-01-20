Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A51494AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359601AbiATJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 04:40:38 -0500
Received: from mail-os0jpn01on2132.outbound.protection.outlook.com ([40.107.113.132]:26646
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229545AbiATJkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 04:40:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci3jr/n3oQyc/+4VZQEGLIBCXQdTRDqJuwuAV+6Xk34TAoi20kgMGHMwynqDw7JNK3lM+P/Cdkz+v6/VMRqhgtg7kxXrMR0LgHAB+6l88MxtvBs0fbgMu1DQWX1898ljr7IbXuSeN6E/GcXSc0YuEOYiPI+/PC7fXpa+3iQVoZqf2C6gL0Z5g/cJMWxaFPYoVwNTm3AIkrgWN6KODlTrkQskoDXfwmoCwaidrmVmTGyKpOBjvW61K/nO2VmfXCK+MuAXP2Ll1FlE4mVoqy+jJX24HCvzBl1nGVOjSNqiXzaiO/wNHSFvB6mbJLNAizdAkjdfX/cv8tbJT/DAPXdiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPUQvZkqoF8nVLqvW/6CyODKQoX3GjGBD26XuogNb2U=;
 b=mtwNXamOtfrpTxnWeaJDzNpFTTtIh/wscLGumn5mcoKbnYMamxNJ6ZNhc5gAUG+XTvAMnTKDQZ48470qobpKeS7xYDL4LFAYQDVIWzqhglqHHyRD4Myqxlm9kdQTHr9fFZ1TSbOElzMUJbTUzPpl/bwHRRW5SO7P49zUwBSQylbxi4eDns3vKcBPAeKVycU7N+xxxc/taVfUbYkmmWPRDVUvsEFpRevMIldYBmeVuueevdwmQHyfXjmI3GCb0RsHxUFtnOUC0BqOsF4lR3Az+5RdIdbeazdmxDrIhIBWhYzXkbK4NGQVxGAHU/+gKHMalxdsU16XnjMvOSHDnhkMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPUQvZkqoF8nVLqvW/6CyODKQoX3GjGBD26XuogNb2U=;
 b=lymJxIy1KUGj45b+FZ98RHhMfBaGaoEIvTQlA4Kwga3ZT8I82aNGeyM9gtRTj5f25WhMUfquqOB82i5J0k+sc7CvBHhDOxbP4iGWqmdymvQr6cgKfOM1/7KpUB5Bad39q65ftYQH1DK6Fc5MxbSIJnV7wIjUc3UoGfLBNEFsR50=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OSBPR01MB3319.jpnprd01.prod.outlook.com (2603:1096:604:4e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 09:40:31 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::2182:43e9:3f29:1b3e%7]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 09:40:31 +0000
From:   Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: renesas: Add support for reading product revision
 for RZ/G2L family
Thread-Topic: [PATCH] soc: renesas: Add support for reading product revision
 for RZ/G2L family
Thread-Index: AQHX9cOdXgspbzKjZUeTM80BoN3XkaxryICAgAAORJA=
Date:   Thu, 20 Jan 2022 09:40:31 +0000
Message-ID: <OSZPR01MB70195EF2FA516C31752CD046AA5A9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20211220170357.7899-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXKRNDAGqwz0oqJyCWq6LyTdJ7BEe2uCmek60x3Ec2-GA@mail.gmail.com>
In-Reply-To: <CAMuHMdXKRNDAGqwz0oqJyCWq6LyTdJ7BEe2uCmek60x3Ec2-GA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 422afaff-8638-4905-c8d6-08d9dbf8e662
x-ms-traffictypediagnostic: OSBPR01MB3319:EE_
x-microsoft-antispam-prvs: <OSBPR01MB3319ECDC84DCF38A17287D09AA5A9@OSBPR01MB3319.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncPhnNdpTaK1HAbzcBbnyoGy3rOh0gP0o53Scpj6vg4SjxHK4t6dvAzFFnlo2pUao6w/LkbfmZbP0fqH1PBpctBUdb6M+/6ApxKWIMHvvo+Rz5HNe3Adfzp0uPeMBztiw/aj7ZJqieLq5eZewhTHgN417sHKfcDg+NVant5eZvuflnD8I9sE1exp1ubECVmtkmFvQBH95AHnoMK7O9qQM5qXSPYOCv54hWyJXaRKspEvg4FI6PsFYyB3Zt2hTSgnDtzbCak4vqeDc3amsnAKM4fQ+pJSgkNtVAYyDzTjg5s7ghFdFIbntNZy66KKjxQHIu4/QIPtr5weVr+WkY1wP7MthuOuZF8cR3nrGQjYgUzztm7fe3ETE2G6fnu9E1nvUOH4tA54ft/5aDr6RkAsb41jc5QwJT56PauvKSTlmH/D/N4zHh49e4x9soVUKuoNdrA7ddkoelFwUzVgEd2zzuVNnlG2fGjxdzMLwoSFvCzbp6nYUysmCNaR4m4vEBbzrumN1j0hBUoxAoB6r10dV7el4MHBS1jErSFWL1KhHPTYfg3UZl2LkgnTL0a4MCgD/fUN10U7PYTay6tHSC9qF227I+vTWVEnlM/zG7rOVoomPJeyAeZkQdrP9R9X0j54psP5XQB3J7KDtLyeYNjl1EH3sCAPVFhCtAgew2YwaG17ubPtn640U3jGsUJORVHqoRE0DPdbk0nChf1jjPfRUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(9686003)(38070700005)(122000001)(66556008)(83380400001)(4326008)(6506007)(33656002)(2906002)(6916009)(64756008)(66476007)(8676002)(66446008)(76116006)(66946007)(186003)(55016003)(71200400001)(7696005)(52536014)(26005)(316002)(5660300002)(54906003)(53546011)(38100700002)(86362001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UG5OUzR3a0QydlNFRnN2TjZtdWpQN0VkTVhNeEo0NTkveExMamUveHNrVEx4?=
 =?utf-8?B?bnN5RzVBVGk4a2Q1SU1QQjNYbHdOUTMydThNdmszQlg2SmNwSlUveVVLUlcv?=
 =?utf-8?B?RXY0MG1KM1JYVmpFTU5XSGRLbWpQdTdpUDl6SG5CTlBBY1EwYnlRaER5cm00?=
 =?utf-8?B?OHFiVXFjcHE0NGV1aStHZDVWb203c2FtdStrVkw0TFNzWFhlT2djK283Mnh6?=
 =?utf-8?B?OUJzVjJDUUdtVDY4dkptQUY5QlBWYnFaSUpXdVZFMjR4NjgrTDFGU2hjMGVx?=
 =?utf-8?B?dFNNcFJISnM5eDNtSlhXdmF0L1dzT0syODRWdURCY1psZDc1N1ozMkYrSGhj?=
 =?utf-8?B?NDNMYWZRYXhCN2RXSEdKeDVzcFJtc2JCN2JobW5DcXo0VU1mK3FZY3NxWk5x?=
 =?utf-8?B?Z1hwYVRzenIvZVRyYVlhY25LS3cyKzFXOUU2TzN2YnB5OURFTkh0MmE5MlQw?=
 =?utf-8?B?QklGMkFlM1hEdXVLK2Ewbzd3REZYa242a052eGRLRDMrSjFYV0Uxd09BbUgv?=
 =?utf-8?B?eHRvcHVuMHc4OElNSEoxVmZFaDkvdWRvQ0Y3R2FGWUlmdlZXTmhZWExDcklp?=
 =?utf-8?B?NVpPdDZsbUV4WnA3WkdwRW5sVUN3Q2xFWkhvUElGckh4dGNVdzdBU3ZsN29D?=
 =?utf-8?B?VmZKemNYdHErZzNBdldxdFZ5ZVhYd2VNUnJMby84cnJxM3dzYW9pM0M5SGgz?=
 =?utf-8?B?MFdXanlNQVlsRUVteTNIVXUyRzNjVnhaWlI0OHZkSzk0Z04rem1Sb3FFS2hL?=
 =?utf-8?B?dWRpNG41MUErblJGY0pZeXdGY2NMWlBlYkpUbndoeS9GbWFtRExxZDgwWmNQ?=
 =?utf-8?B?Yk03RVdzTGVGd0s1MWQra2J2bU9GOWJFdy9DZkMxRCs3Mm9aVTZyNW5ZYUR6?=
 =?utf-8?B?am9BZUdGd2pCQzFXNkMrTHNVbUZHNm5yYng2SlF3UDlIUTkrOXQwZEcvaUdL?=
 =?utf-8?B?UTUrMlZlY3RyMDRSazNQOG9iUS9IQ2hsOHBqZ2dkaXlFMTBYdGZCNlpIWENQ?=
 =?utf-8?B?cXZFVnZzUHdBOVlRL1ByaUttT3lDTEdKbEt1VmRPNkJUYmJtYUZNVC9oYU9W?=
 =?utf-8?B?R1k2WXFlOElObWhlWlcyOVhKSDFtRHN0TjJTcFRIMi83dENVZUcrWU5oOEZv?=
 =?utf-8?B?NGF1dy9QUi9uckZkYkV3K3gwNFA4VS81cmRqWDZKb3M1dGl3M20wR0cxT0xq?=
 =?utf-8?B?cWx1bmVSTExHZkdrU1g3TXJ6WnpzWTcwcnNhMkIxNEJqYVIrK2hGdE1UYmNJ?=
 =?utf-8?B?V2J4L3pOeUYrRjhyUHFjYmFYdlVBL011QjdxRjFuMGMxRzlMY21mTXFEOGph?=
 =?utf-8?B?RkdmcWdpRHQrMXlBTHVTYnV6K3dXbzdYU3lhbEVqRklDNGw5cEV4TnllOGlh?=
 =?utf-8?B?YkFlZnMxVy9aQWErVUNLRjl5emJmaExFanNTQXVlaVQrNnhoa3NhdG9mZ1BI?=
 =?utf-8?B?TGd3NjhiMEllMkJRS1FZUXRibXJBQXVYK3UrVTVNdUFzVUtTTzRwU1FIZ0xl?=
 =?utf-8?B?dFZmNHRqRDlOanlrekt2WFYrZSszcFNlT2hpeDJ2M2hBK2wwMjNwWkZzNWV3?=
 =?utf-8?B?U2xvY3FyaURYWmVLVFFQTExkOUE3VTBod09kL2dtT3pNWW9MVGx4dU1KR2h4?=
 =?utf-8?B?c2QzdHhxSGdab041VVR6UmpUNDdCOS9SbytlQzU4czAwMXhUUXhvejJnZzFC?=
 =?utf-8?B?V0Y3RjQ0Z1dGV1BBcDJmWXQ3V0ljQzRLbENYajVMTXVqQnNoWWtxb2xhYWFS?=
 =?utf-8?B?cDBEVDMyMjlLTXdFem9id3JjNmExTG1RM29KcEVrcE1GRnpjWEpUQ1dMS1NM?=
 =?utf-8?B?QjIrdDVwanhUQmt6SlVzbmdWSCtNQU4yVDE0T0lYaWgweEFkR3pzd3ZYbm9q?=
 =?utf-8?B?V2ZuUFBUTnJwM2xvOXBZOHlYWlRFdlZBZnpGQlBxVjl2ZXQzbnoxcVJBQlI5?=
 =?utf-8?B?Y2NtYjF0dVJjWXB6MC94NW52MmZyeVFIYVZyOTFHQlNiK0c3V0ZLRXVSL3Q2?=
 =?utf-8?B?KzV0b3NhdG85UjFNNmZMaWJZUVVvLy9BZ3dROTQrQVlHRXJ2WHdqOUNwTHdH?=
 =?utf-8?B?NHR4dVhuY0YwOTF5eU9uVkxZcGlHMDk0aDlkUGdackJuRDR0ZUlhT3lxdmJv?=
 =?utf-8?B?T1BVVTBkeWluR0M3K3RoTVVISWdDVENwTnVPM3RHT21VbkJINXNGN1RCZzFv?=
 =?utf-8?B?blMwSWVHV04xcVpuNlc1ZlJ0aVBlS3dtVk92VjdvOFhFdzB3NkVKRDhtQmFF?=
 =?utf-8?B?QUZzTnNiWHdpOHhXNmhWZzQ3TUgzOXVZbUFJS1FIUE8rdkZnWDMyVm82ZGh6?=
 =?utf-8?B?WWVENjM5c1FkbTQ2QXFZOHVJbjdYLzM2NDc2dzk0VWlLRG9qb3NWZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422afaff-8638-4905-c8d6-08d9dbf8e662
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 09:40:31.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZAHu4wgwFJTHkehbAlaAiQ2hZueiBzMT8idn2dsYmJWBfxmuNO5qvzN+OsykrX0o+NwcTmg5fQEPOvKS9spxIqKQaPRt13vlUySzhPaJzsp+ADOE98kK01m6yRwkQvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVydCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02
OGsub3JnPg0KPiBTZW50OiAyMCBKYW51YXJ5IDIwMjIgMDg6NDUNCj4gVG86IFByYWJoYWthciBN
YWhhZGV2IExhZCA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiBD
YzogTWFnbnVzIERhbW0gPG1hZ251cy5kYW1tQGdtYWlsLmNvbT47IEJpanUgRGFzIDxiaWp1LmRh
cy5qekBicC5yZW5lc2FzLmNvbT47IExpbnV4LVJlbmVzYXMgPGxpbnV4LQ0KPiByZW5lc2FzLXNv
Y0B2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzb2M6IHJlbmVzYXM6
IEFkZCBzdXBwb3J0IGZvciByZWFkaW5nIHByb2R1Y3QgcmV2aXNpb24gZm9yIFJaL0cyTCBmYW1p
bHkNCj4gDQo+IEhpIFByYWJoYWthciwNCj4gDQo+IE9uIE1vbiwgRGVjIDIwLCAyMDIxIGF0IDY6
MDQgUE0gTGFkIFByYWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMu
Y29tPiB3cm90ZToNCj4gPiBGcm9tOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+DQo+ID4NCj4gPiBBcyBwZXIgUlovRzJMIEhXIG1hbnVhbCAoUmV2LjEuMDAgU2VwLCAyMDIx
KSBERVZfSUQgWzMxOjI4XSBpbmRpY2F0ZXMNCj4gPiBwcm9kdWN0IHJldmlzaW9uLiBVc2UgdGhp
cyBpbmZvcm1hdGlvbiB0byBwb3B1bGF0ZSB0aGUgcmV2aXNpb24gaW5mbw0KPiA+IGZvciBSWi9H
MkwgZmFtaWx5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXIgPHByYWJo
YWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgeW91
ciBwYXRjaCENCj4gDQo+ID4gQmVsb3cgaXMgdGhlIGxvZyBmcm9tIFJlbmVzYXMgUlovRzJMIFNN
QVJDIEVWSzoNCj4gPg0KPiA+IHJvb3RAc21hcmMtcnpnMmw6fiMNCj4gPiBhdCAvc3lzL2Rldmlj
ZXMvc29jMC8kaTsgZG9uZW1hY2hpbmUgZmFtaWx5IHNvY19pZCByZXZpc2lvbjsgZG8gZWNobw0K
PiA+IC1uICIkaTogIjtjYQ0KPiANCj4gVGhpcyBsb29rcyBhIGJpdCBtYW5nbGVkIDstKQ0KPiAN
ClR5cGljYWwgVGVyYSBUZXJtLg0KDQo+ID4gbWFjaGluZTogUmVuZXNhcyBTTUFSQyBFVksgYmFz
ZWQgb24gcjlhMDdnMDQ0bDINCj4gPiBmYW1pbHk6IFJaL0cyTA0KPiA+IHNvY19pZDogcjlhMDdn
MDQ0DQo+ID4gcmV2aXNpb246IFJldiAxDQo+ID4gcm9vdEBzbWFyYy1yemcybDp+Iw0KPiA+DQo+
ID4gQ2hlZXJzLA0KPiA+IFByYWJoYWthcg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9yZW5l
c2FzL3JlbmVzYXMtc29jLmMgfCAzMQ0KPiA+ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3JlbmVzYXMvcmVuZXNhcy1zb2Mu
Yw0KPiA+IGIvZHJpdmVycy9zb2MvcmVuZXNhcy9yZW5lc2FzLXNvYy5jDQo+ID4gaW5kZXggOGY4
Mjc0OWYxODJmLi42ZWNkMjc2M2QxMDAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvcmVu
ZXNhcy9yZW5lc2FzLXNvYy5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvcmVuZXNhcy9yZW5lc2Fz
LXNvYy5jDQo+ID4gQEAgLTQxNiw2ICs0MTYsMTcgQEAgc3RhdGljIGludCBfX2luaXQgcmVuZXNh
c19zb2NfaW5pdCh2b2lkKQ0KPiA+ICAgICAgICAgICAgICAgICBjaGlwaWQgPSBpb3JlbWFwKGZh
bWlseS0+cmVnLCA0KTsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgc29jX2Rldl9h
dHRyID0ga3phbGxvYyhzaXplb2YoKnNvY19kZXZfYXR0ciksIEdGUF9LRVJORUwpOw0KPiANCj4g
VGhpcyBpcyBub3QgZnJlZWQgaW4gY2FzZSBvZiBTb0MgbWlzbWF0Y2ggZXJyb3IgYmVsb3cuDQo+
IA0KT3VjaC4NCg0KPiA+ICsgICAgICAgaWYgKCFzb2NfZGV2X2F0dHIpDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4gPiArICAgICAgIG5wID0gb2ZfZmluZF9u
b2RlX2J5X3BhdGgoIi8iKTsNCj4gPiArICAgICAgIG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKG5w
LCAibW9kZWwiLCAmc29jX2Rldl9hdHRyLT5tYWNoaW5lKTsNCj4gPiArICAgICAgIG9mX25vZGVf
cHV0KG5wKTsNCj4gPiArDQo+ID4gKyAgICAgICBzb2NfZGV2X2F0dHItPmZhbWlseSA9IGtzdHJk
dXBfY29uc3QoZmFtaWx5LT5uYW1lLCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICAgIHNvY19kZXZf
YXR0ci0+c29jX2lkID0ga3N0cmR1cF9jb25zdChzb2NfaWQsIEdGUF9LRVJORUwpOw0KPiA+ICsN
Cj4gPiAgICAgICAgIGlmIChjaGlwaWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgcHJvZHVjdCA9
IHJlYWRsKGNoaXBpZCArIGlkLT5vZmZzZXQpOw0KPiA+ICAgICAgICAgICAgICAgICBpb3VubWFw
KGNoaXBpZCk7DQo+ID4gQEAgLTQzMCw2ICs0NDEsMTIgQEAgc3RhdGljIGludCBfX2luaXQgcmVu
ZXNhc19zb2NfaW5pdCh2b2lkKQ0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZXNo
aSA9ICgocHJvZHVjdCA+PiA0KSAmIDB4MGYpICsgMTsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICBlc2xvID0gcHJvZHVjdCAmIDB4ZjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBz
b2NfZGV2X2F0dHItPnJldmlzaW9uID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJFUyV1LiV1IiwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGVzaGksIGVzbG8pOw0KPiA+ICsgICAgICAgICAgICAgICB9ICBlbHNlIGlmIChpZCA9
PSAmaWRfcnpnMmwpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBlc2hpID0gICgocHJv
ZHVjdCA+PiAyOCkgJiAweDBmKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzb2NfZGV2
X2F0dHItPnJldmlzaW9uID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICJSZXYgJXUiLA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ZXNoaSk7DQo+IA0KPiBUaGVzZSBhcmUgbm90IGZyZWVkIGluIGNhc2Ugb2YgU29DIG1pc21hdGNo
IGVycm9yIGJlbG93Lg0KPiANCldpbGwgZml4IHRoYXQuDQoNCkNoZWVycywNClByYWJoYWthcg0K
DQo=
