Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1854452E277
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbiETC30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiETC3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:29:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38E13F40F;
        Thu, 19 May 2022 19:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzM14gsVgD/zIDD0qWNOx8b9I/QR+6yVHqmSSt7qLQAHMulREGDZLqXzYonWvQYRlWJ8aqOokzQ04AOYW8C7eqI1VmMViysF8zfP1cttdMJzUvSaUUvVkDbuq6oiCMv57algm9z3G2dokKfBqjveUpqLX6hkeyK9BhdG01mKbEUs7ez8kPJbKWc6dRod51QpsHJ1ohTvKem3Z466BQmPS0yoOu4Q0MtkLjyLhxwjCEm0bQ8jqhmsO8Jvk47UXVNm8ChtkI68O0GHOW8A2bhXDG1vAx8Se1oQOW/SCC2PdQ/IV1GYJx9F68K8gvGYvqcmAeUUnnvEQMHKa1TXp3BwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1lCLbEh89EP+nAvKn6R8icT5loT3Aw2wRHKlorjC3A=;
 b=fdC3SnP/VHjOZcuqvsSwtQ79Z2PsFHyBDHyrDOqHPxwRGRuXP/xa9KJjlRjHb7EiiVmbWvPsHFtBMA162nmu4MyrRUVZsV+RL+xuHN3oe7xcjLwEB1UAh6u5iuvxdYe3xbqTGlYbyYVrvgaWz7AJi+ts2j14p+X1n8LEjDQNrXQ2Is7M88zh6mrYEKW0mTE5D9N1yWMzb651zhLHR8DJNCzsLo4sbpSyi4vhuHQk1BSrCsvB98QqeQbwgRl4Pjkeqz26Eh3NQPjVqBa34EFfzhKyai7+vipA4XGwHccs8EkVxJqtHlxHeW87JuO/zRaIecSpL8diTYJQGa2lI+XXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1lCLbEh89EP+nAvKn6R8icT5loT3Aw2wRHKlorjC3A=;
 b=E0oDzYdoUrppoBKRkVYT7O3ssonpTG0nZpYbnHUTNJEAd8OYr6fRBokeyU0v9bHY+h21Egh8n3u4Z0eOsJ2trvEqJt2rTe8CYHejoL/uSl4oFfLy3whJoJBgxH08+dcWV8cto8g9alLf136FtOSB6JhOXVKGuqW3lcuzVIHKCtgPYwj7Ao1ppE6FXiWq3QlZ4S1/4QSt83EAqdpNTH4/oXOVktyI64RagsHVHJWun3WGhSMgom7upWRXVJVGa03SDBxvSuQYRZPusKlvwh+lWilVpWXnl2D0UfygJvEjlol0DIYKc3+lljet1+tsFGK9SqQ85TBq+pQMXHV9hvQqOA==
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com (2603:1096:4:b::19) by
 PU1PR06MB2232.apcprd06.prod.outlook.com (2603:1096:803:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.17; Fri, 20 May 2022 02:29:12 +0000
Received: from SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::c5c2:d3e1:f0af:4a19]) by SG2PR06MB2315.apcprd06.prod.outlook.com
 ([fe80::c5c2:d3e1:f0af:4a19%3]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 02:29:12 +0000
From:   Howard Chiu <howard_chiu@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>
CC:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Topic: [PATCH v4 3/3] ARM: dts: aspeed: ast2600-evb: Enable virtual hub
Thread-Index: AdhDHCPizwz11c+oTYCkTWVlcfbcawoZmX2AABt5OcA=
Date:   Fri, 20 May 2022 02:29:11 +0000
Message-ID: <SG2PR06MB2315E86259B3751AE8C47E39E6D39@SG2PR06MB2315.apcprd06.prod.outlook.com>
References: <SG2PR06MB23155E8A6193118544A7DBF3E61E9@SG2PR06MB2315.apcprd06.prod.outlook.com>
 <CACPK8Xev-AYtrWzZyMGj8eBkTP2YXjnX=M+4UUGgfRZYeGMPtA@mail.gmail.com>
In-Reply-To: <CACPK8Xev-AYtrWzZyMGj8eBkTP2YXjnX=M+4UUGgfRZYeGMPtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ef66b65-8711-411e-6e55-08da3a0886aa
x-ms-traffictypediagnostic: PU1PR06MB2232:EE_
x-microsoft-antispam-prvs: <PU1PR06MB22329C673573CCE6EF2A27F7E6D39@PU1PR06MB2232.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t2B7jPSczywnig/igj5PDx//MBGkyb+jub6XnfKfiEsT5LOzkwIVkHIUCH8Pgg+a4g1aiLQzB/ifEWQAOOBTW9ZdrC/oMZ5wywmR/xEqB345j/hrqELv/duihIn8mZYnMHQJtwhxNKh7gRNjd3cFTxxzR1HZpeLu0hX7x7pJdz42yNx9XutTkVu54M9NfBP8QibDKZEef4FVew6II+rAOFaecK0X6E2n1YQF4tYV8R4gc2s4QXr9vZMHevkTpAIrpGroqZEr2xBQbsu0Nb/U1Ko/GK/QeGQ5XxYrqhCYueSv3J8SBMNZesIj+uC3vcmRX29XBmLvfenw73EmhiqLmL1AGjPLiF3UOJTvD4R7TrEimgzaheXfF3RFyK9wVwhVZTBcHaBtjMRQQk2dwCQXyZwfOG9+eB3Z0on3zpxKxdcC8V02q9+u+uCxpjtaDRNfRLRnyEpzCOHF/d5c5PNgT5OeFCXJfn49VYwN7LjzrBNe8lbTXzUbbevqN1qk+UKMf8Hmtv/hBotbPijaa0Mk71EHKDHLF5+K+AjGICAwBhxFn6Rm6kcjfPmSgGpCU3Q3dx+5Oq2aqyB0RgTrEPqKevqY16rL5xOhPIspHW43VMTjhMm4neefMkdsZ6QoF3KMm2FcFBHprVUj/QKtnQZUoi++plZcUueGhz+Nsfo16Nw5D1l1vIjF3suJD02jIIur6Squc2AY05eSfTOA4yLXyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2315.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(39850400004)(136003)(376002)(366004)(346002)(8936002)(508600001)(52536014)(55016003)(5660300002)(186003)(7696005)(6506007)(41300700001)(9686003)(86362001)(26005)(107886003)(2906002)(83380400001)(33656002)(71200400001)(66556008)(66476007)(66446008)(8676002)(4326008)(64756008)(66946007)(122000001)(316002)(76116006)(38100700002)(54906003)(6916009)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OStwOXhpOEpUVmF6VnR0dmVLbXRUak9yYVJRNFdyendEaUpZYkVDUVhMNnRW?=
 =?utf-8?B?cVFUU0tuNUt1M0dQZnY2cE5ycm54UG1wK0YrS3A4OGlZSmRheE9jcDdoUDVx?=
 =?utf-8?B?NEh1N2sxNy82TldqVVplbWdqTXJ6NHdNTTBYVkRVdHBoTDNMUi8rN1BXNUJB?=
 =?utf-8?B?WXovTHlXd1JxdmVwSVRIOUJ5SGRpSUw5UzBtS0VvRXd0SnhGR0w4aGMramp3?=
 =?utf-8?B?YjVuRi85OHdEZExtc0RUbG1uSy9BcXo1dXdudmNSSDlabFA4NWxoMDFGNy9x?=
 =?utf-8?B?YW43LzVUeURLeXUwcWxzQzNPUmh6WjZMajMwdjZCUmttdVNmdExkR21pZCtQ?=
 =?utf-8?B?YnUvTlpPdno2azZuTzJrU0VXUnN2Sm5XWEhtWVdnVGlDZFBadWh1RUphU3dI?=
 =?utf-8?B?SXBCb2h1TW05eEVQTFJGdzRwWWRxcmVkcUJuaVVOZGNsc0FOZDY5dVh6R1gr?=
 =?utf-8?B?SEZkRmd4NjRQcFlUcGhiclFuaFo1emFPN3grOFhjeWMwc2Z6cGRGcWVtZG9X?=
 =?utf-8?B?Uy8zTU4zU0d3Z1Z4dkFIeTJCenZROE03Z3A3cWNkWi93Wm1UQUF1dkp0K2pY?=
 =?utf-8?B?QkVBaG50Mk5rT2pZUTIxOXZ4OHpYaXlTNVBDTDZzMC9GSkdrZ2VTTjhhU015?=
 =?utf-8?B?cEgzREw3cEFzSitBL1hsZFp1dXhoRE5rQlF1OXVibkRQMmdrMGpkNVNTbU1W?=
 =?utf-8?B?RkF6aGcyKzNUemRPM2Y3VHVOMnZ6YlQvdVhYNVh6dU5uanVVcWZlcFpUSEIz?=
 =?utf-8?B?djNmVFNCam5wM2R0R2dNTnQva0tVY0tzMmNQRlVJdmh4Yk5WSVZxVDFSR2Nt?=
 =?utf-8?B?QkNjeWtQMzRtMEtLT2FNTnJaeE1FTnpTWDBrKzlpNXZaRXlUWEJBNTJFWGJt?=
 =?utf-8?B?bjgwOGZVSHBLTFYxWUE3eVVvMFZKNFRVbFplWmp0K2lXQlBjcmF1ZmFjRUlM?=
 =?utf-8?B?aGN2L3FTUEc3YWhjVjVDb2lRWFVERFRnYndBNW5UUnBmcW9qMzBDY3AvdGY0?=
 =?utf-8?B?cUdkSCtaWmpJMkVWbVNwZHN5OFNPNlBQWGx4OTVDYS9lUVVqK1MxUU1WbmN2?=
 =?utf-8?B?cUE0ZTRDbjlaMmNGWkdnQVlEa3NrWitjRTVCZ09pV0hTdm5FU25VVnI2REZ6?=
 =?utf-8?B?dS9rS2xiOXFydXJMN1A2U1pONHNyRy9iYWZpa0ZNdFk4bDVSTmk3ZDBpamNS?=
 =?utf-8?B?SjZncVcrT3RzczdhckNXZ0xYSFFoVWdDdGtYZWlqK0QrZVZLTFFaY1RsUEdy?=
 =?utf-8?B?cGJWUHcrUlpMeVFOcUVOTXQ4a1JGQmxSZWFSTklxWXlPMnZtSDZyeTZHN3pu?=
 =?utf-8?B?VEw0cWlqZWQ5M2VjakJDamNoWGYyQ0lyRFZtWEVhajlXL3FObmxyaWlRK2ZE?=
 =?utf-8?B?TEw4ZjdmeHZQOE1QU1BGL25oUjRoRUxqOFBYTllvcUNFdUJjb2o4VmU2VVRr?=
 =?utf-8?B?VzYrWXpqbkErdU5zd1AvblJscmxjYzdYaGFTZzhPUWFlZU1MdUF0VWFneSs5?=
 =?utf-8?B?RGxpQ21XRmZ3QnljbittWFYxRTAvV1FBaExjS1hoeTNpZ2dEZ0xiczFjaVdR?=
 =?utf-8?B?S2Y1VlhiK25VZUhqRXg2amI1QVFGbUE2QTYvbWRCbm1WWjlkVFRzWmt5QUNj?=
 =?utf-8?B?TFBQNngvK1BTSmx0UXZaZG0rOVZ1Z2E4RFZHVzdncXhRaTlJbERQUGMvSmF4?=
 =?utf-8?B?dVgvNkdFM0Rhd2J2Rjd1U0NLV2ZtbVVGR1phZGlmOGxRMmNCNDlPaWx3a1dv?=
 =?utf-8?B?N3UvMHRlUkRQdzQ1SjBPN1l6K0ZPeE1IWHluT0ZiZ3RZZXNNTVpFU2J3SFVm?=
 =?utf-8?B?VlJNamdJSDZyT0NBYzJNd0REazlPdmVYUE5odFQ0a3NsdGpKSTJjMHVCOVZv?=
 =?utf-8?B?a1l1bnJKNEFiTHpaa2haQWtONmpYa2NRTllKajdHeVhDZWZKUXU1b1pVWmtW?=
 =?utf-8?B?V0xucVovZituQmJUdzQzVGZ0RmNJcnJ4bVNUMkpTNEZ2MHpzNUtOYXpqcENI?=
 =?utf-8?B?aFdSTVV0enlXRng3Mlh5dUFwREJ6K1R4NUs1SmFNa3FxbWVtM01tcUpTb1Bl?=
 =?utf-8?B?MFVJQ1hzZWJyaURNTzRKT3J1UW0rSDRNUHRTNFR1VmR2N0lCbjZrQ1cxNFpr?=
 =?utf-8?B?SWU2TkVFTCtWRG1vbnJJeUZTM2hUVTltQ0lOUzFWdFlNNjR3Y2hMWWF5a2s5?=
 =?utf-8?B?NUFOb3JKcldCbE4wejFKLzZHZTc4T09Rb1RLY09pNHM5a1VTU1VYZ0FGSVdM?=
 =?utf-8?B?WFVhcU9BZ1B2SXZFTC9HZXF2S0s5MkZGdExxRjJudFRQNGZ2YzVKVUlmNmU5?=
 =?utf-8?B?VE13TWNkWUJPc2RDQkhUQmkzN3pXQ3FXQWRDdWR6aXZVd1REa1IvZnVEMjFt?=
 =?utf-8?Q?QROGm4nVoj1HgenA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2315.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef66b65-8711-411e-6e55-08da3a0886aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 02:29:11.9655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlAdltmL7eEwYDXLmESCW2jMUpk6YQHwXUvASKTIwuuTJasRgPFoUVN2aGkLwNJEgJic1ht4Chz04c4gup6ap+Jhx6o1MTXBv7ui1pjFojs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2232
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIDI5IE1hciAyMDIyIGF0IDAzOjI0LCBIb3dhcmQgQ2hpdSA8aG93YXJkX2NoaXVA
YXNwZWVkdGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRW5hYmxlIEFzcGVlZCBWSHViIGZv
ciBISUQgZW11bGF0aW9uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3dhcmQgQ2hpdSA8aG93
YXJkX2NoaXVAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRz
L2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9h
c3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkLWFzdDI2
MDAtZXZiLmR0cw0KPiA+IGluZGV4IDE1OGI4OGYzOGQyYy4uYjk4Y2RhZDg2ZTkwIDEwMDY0NA0K
PiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1hc3QyNjAwLWV2Yi5kdHMNCj4gPiAr
KysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtYXN0MjYwMC1ldmIuZHRzDQo+ID4gQEAgLTMx
NCw2ICszMTQsMTEgQEAgJnNkaGNpMSB7DQo+ID4gICAgICAgICBjbGstcGhhc2Utc2QtaHMgPSA8
Nz4sIDwyMDA+Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZ2aHViIHsNCj4gPiArICAgICAgIHN0YXR1
cyA9ICJva2F5IjsNCj4gPiArICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4g
K307DQo+IA0KPiBXaGVuIGJvb3Rpbmcgd2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQgd2Ugc2VlOg0K
PiANCj4gWyAgICAxLjU5NjM3N10gYXNwZWVkLWc2LXBpbmN0cmwgMWU2ZTIwMDAuc3lzY29uOnBp
bmN0cmw6IHBpbiBBNA0KPiBhbHJlYWR5IHJlcXVlc3RlZCBieSAxZTZhMTAwMC51c2I7IGNhbm5v
dCBjbGFpbSBmb3IgMWU2YTAwMDAudXNiLXZodWINCj4gWyAgICAxLjU5NjY3OF0gYXNwZWVkLWc2
LXBpbmN0cmwgMWU2ZTIwMDAuc3lzY29uOnBpbmN0cmw6IHBpbi0yNTINCj4gKDFlNmEwMDAwLnVz
Yi12aHViKSBzdGF0dXMgLTIyDQo+IFsgICAgMS41OTY5NDddIGFzcGVlZC1nNi1waW5jdHJsIDFl
NmUyMDAwLnN5c2NvbjpwaW5jdHJsOiBjb3VsZCBub3QNCj4gcmVxdWVzdCBwaW4gMjUyIChBNCkg
ZnJvbSBncm91cCBVU0JBICBvbiBkZXZpY2UgYXNwZWVkLWc2LXBpbmN0cmwNCj4gWyAgICAxLjU5
NzIzOF0gYXNwZWVkX3ZodWIgMWU2YTAwMDAudXNiLXZodWI6IEVycm9yIGFwcGx5aW5nIHNldHRp
bmcsDQo+IHJldmVyc2UgdGhpbmdzIGJhY2sNCj4gDQpUaGUgZWhjaTAgc2hvdWxkIGJlIGRpc2Fi
bGVkLCBJIHdpbGwgcmVtb3ZlIGl0Lg0KQW5kIEkgYWxzbyBmaW5kIHRoZXJlIGlzIGEgZHVwbGlj
YXRlZCBlaGNpMSBub2RlIGluIC5kdHMsIEkgd2lsbCByZW1vdmUgb25lIG9mIHRoZW0gdG9vLg0K
PiANCj4gPiArDQo+ID4gICZ2aWRlbyB7DQo+ID4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
ID4gICAgICAgICBtZW1vcnktcmVnaW9uID0gPCZ2aWRlb19lbmdpbmVfbWVtb3J5PjsNCj4gPiAt
LQ0KPiA+IDIuMjUuMQ0KPiA+DQoNCg==
