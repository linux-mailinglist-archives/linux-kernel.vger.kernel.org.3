Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9307547D82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 03:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiFMBt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 21:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiFMBss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 21:48:48 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854201116A;
        Sun, 12 Jun 2022 18:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPgYzLsSXCFEGJBpHYdv52ccaT4ikW/7nKVfY+6r0zypS8CW4lCei1JeSh+JvqQbPrdRzva3fA0u+NbBAIL39IVeodk9Ktnsp3qeTvYSgfXgnuxubZ6tdWKEzeudRWcz5wPKHAjQ4uqlygzgeHggKoUnuOjNTBnvlBa1FkEYQd/0HZrxmfTaAPS4L+3d2ZlIMIgE3W+3Lp3gsiMEv063NRt4m8uDK+AyWTklUc1LP1We5u6MZ8kDRIH4SqoG9nuvP9v7tSAwwbeYVdtONDVd0WgR/Kw6yd6IuBgj0JOX124mOpc/j2GR6wc7uZsaX+f/ZHBL1XaeFPAwodRs1dHAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Llaoh9lET4S/OhAnOsW7ujDL8Mp+iVabaCQrrDpp6RU=;
 b=B9CLZ4klGD9HC/C8IHy79Mo4ce212g1ByaPmjjV9WsF1Ilyu19eU3ICWeX4dEc2aGTYpXrkPHGpB2IaZbEFOauc1lwK97thS5DJfMMwcXEJwzb9KLuUKgqXK4EfAFA3QQwYeP5ClPThN1MM9triFiSjjnwpqtlhsRCJGnT3foyXlcwsjYreZb2Um87RFTGumTCYTSsHdYE3BlliLWVzWq7iw7JRTkv8ioAjZlB2pOYXY2yJeOVe2umT480sbmxGxhIJtlN+4ytfdmoTbG74q78EFvBSguJVVgA0HWxROG4p8v/L0BSQSIrIVbmRoGgWlo/uFSzmJucY4kg7mDsEyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Llaoh9lET4S/OhAnOsW7ujDL8Mp+iVabaCQrrDpp6RU=;
 b=fehad8pzkLHpN+l10OjHMr56LXHlhUQkfZQt0q1qAirJCmUf8pobFcuq0Ucn9K0EXoiJXk9MBhjt++0vvtTNj0QZY2pcfYawnSHgZVu0skLuzKfg2QBjL/6vnBAoD/TuvugcAxl+ZZOcl0oCAjVxrsFjt8ajowzvbvZ4HsVSljHGEy2F0QRdF1/5j+xT+sToJAOx58n6La8Z1zyOGCFEjBmbXtybIdOjy0l2lq8kOUJrRvFxUHHZ/PspS3XaCv8oaBMc+bDr+5w7kZoEEqPvX4ksUYJeNNgu29XsWwc5HdD9s55WRTw+NnHo7eceLkxoI0mwNmv4pVRaUHR/URrQEQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYAPR06MB2350.apcprd06.prod.outlook.com (2603:1096:404:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 01:48:40 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 01:48:40 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/5] crypto: aspeed: add HACE crypto driver
Thread-Topic: [PATCH 5/5] crypto: aspeed: add HACE crypto driver
Thread-Index: AQHYdXplWC114bhAXUSzdjTWoGD8KK1F8lyAgAaw5zA=
Date:   Mon, 13 Jun 2022 01:48:40 +0000
Message-ID: <HK0PR06MB32022ABEDDDFD9FB24B8103D80AB9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-6-neal_liu@aspeedtech.com>
 <6f9e1481-db9c-cd5f-c38d-bdcd3040315f@linux.microsoft.com>
In-Reply-To: <6f9e1481-db9c-cd5f-c38d-bdcd3040315f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b91685ad-be78-4042-8188-08da4cded716
x-ms-traffictypediagnostic: TYAPR06MB2350:EE_
x-microsoft-antispam-prvs: <TYAPR06MB2350727C054A3F577E17A80380AB9@TYAPR06MB2350.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOpG5giejNQZwdqpXn+2Y4qAWb+x0ccp5bWI+YSPUCyWXXWzT7xddmpgJAZtESYvCJj01xepRTpYIUPSUMAf3xnLI80S+mPhEeObYjBge0asS4MxRVuE3cvtnVS+/4ipeZAdqaZXHgWyy5ayUbU/q2BGhHkP0jVC9rz+Gi5fEs/FGqUwrwoX2/gl8bmaJzy4zvYSRONmQPTWzmq85rkYDb0xyCVVZqCaNCOHQNMcSA3iWWXfBnA2FwgkmiYmmCD3678p3d7yk4t1EQ232IaTnYdVi9f8KLOfeQTEeSX2ad9eyd7Khcqjc4ztaXZowKc31dOarUO7K1evI+CCA2i4DgTyJKqoqUnXixx+Z5sxoBF3t5gRo01Q7G3cOSras5Ygt6kMVs1FdUoNSVCWwih6vIq3YHMst3tFL1QO3e28lRr2QrcSqr5e/tBWmOfE/qR/eAkBhyPgdugAngrUatyLrHrK2ulp2xAy55aRrpIcGCS3uYpKyEdEF4DBLvgTIXzy40ZY/k0SXXMPRHje2MOWTFIFsxAFLx0unakMtS22atTr+K+M8O0OWRWeGk+qibVYvqPiGkbktHiDZztPkQrxqMT3FvX45VHD2cD37kSofigpvpf8OKmQYYlrVRcmkXPYmuF88New7S9F+sDuyt6nQJss8UUv32dd7YflsQvCLbpAz6YYvjycC3rXTAI/x+QG+PJvuajaELTevpW1e3elyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39840400004)(41300700001)(26005)(53546011)(9686003)(7696005)(6506007)(54906003)(6636002)(66446008)(110136005)(76116006)(66946007)(66556008)(66476007)(316002)(64756008)(508600001)(71200400001)(86362001)(186003)(38100700002)(122000001)(38070700005)(52536014)(8676002)(2906002)(4326008)(33656002)(5660300002)(55016003)(8936002)(7416002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVRKNk1IU3g2M2dXVGlFdVJJcitocGx5TUNmVHMrSjFEZ0phRE1ubVRZQzAw?=
 =?utf-8?B?VWxxeGhnTHoreU5XU0FIbGJyU3dyazNMdTM0OFg0NVNkeHFSK3JjRTlyK2dS?=
 =?utf-8?B?TjZhaWFNb2h6WWNUeUVFNDNGUTc2VlBBeTFNZkQ4NjlYVHdzS3M0dlNueEJK?=
 =?utf-8?B?Tkk5U1JpQ1hYcXk4RGVVRFZNK1YzcGdoM01MbG44Tm5sQUpHY0VDL0ZGOS9a?=
 =?utf-8?B?RzVGOGVyalpua0xBbU1UdWQxREtjZnRPbk9uZU04WDkzc3JwTlZYMkFMK3JB?=
 =?utf-8?B?Uk1DQURiZDM1SDA5U2ZqalZWcks4TjVOdlRPT2Q2RWIzc3REYnBmVDYwaCt1?=
 =?utf-8?B?bGpiTnJpeS8rYmxoSU1WQ1NXb0cvV2R6bzF4RCtYdlhROHMzM2NBV1ZzVi95?=
 =?utf-8?B?bTlaaGtKVkVaWTkvcjdtd0o3ZTVCcFhoQW00ZXlRUU5uT3pCcnBJcTd5cWxp?=
 =?utf-8?B?RVBtNnBvQy95b0xpWlJYSm56YlJyWkN5YTdKZzlsUHdqbWFsK3V6dHkxVFFD?=
 =?utf-8?B?Q05VdGN3QXFucUVobGhsWElOYTExY2UzQVFPalk1SWJ3dTY4OTZpbDVxY0Iy?=
 =?utf-8?B?eUc3Sy9vSGxTQlVtbzVUeGZCRmxsK0FJekRmN1pEamJldEowTkhZdk9LZnNt?=
 =?utf-8?B?ZTFYZnoyR1dxSGE5T2MxYlBXWlJlYXYweFpNaUM2cTdzTTJDMFU4MFE0QlBH?=
 =?utf-8?B?R1JUWHNGc1UxTjNRczF2NFpPRURTR1JZUElrYjRVTzV6L2N2NE5YM1lETUU5?=
 =?utf-8?B?RE92UVQzN0RMai9sSXo0cTZmbHAwandlQXFDNjRYUlVaV21pcDdlWE9UYjRX?=
 =?utf-8?B?azk1UzFVRC82WDdzVmRrNWQzWWpXQTZEdGdEeEw2RXhSNVFib0VFK1huMURo?=
 =?utf-8?B?a0VSOGRjRmpwWnVWbVhSNDdaNkVUQVVvY0Z6MXpFeGZ3ZTJnbUNjVU1ZTEZJ?=
 =?utf-8?B?TG94MktpdDZuMFQrRmRUM1Nyd2todkxtbXZnQ1FqZkFnaCtsNkM0L1F6OEx0?=
 =?utf-8?B?ZTBTOWdhUElCbFFVZDZmY0xFMEE0UDZKcU1BYlYvT0ZKSU1PMEVPamd1SlFM?=
 =?utf-8?B?enlHRlpaU1B2NGo1d1FIYzFOV1FBZ013MTUvM29hdWJFMU9vOXdWOUZoNm1E?=
 =?utf-8?B?R2xQUWxxc1pPL3BFbVA4SG5TVUFsNTczN0ZzUmRBM2VnZSs2blFXR2VWV3VY?=
 =?utf-8?B?ZmQvN2RVcnhydHdEb3QzSkUyVmtJd1oxdkRJSHBZRzN4K29LTXBURGxUQzhp?=
 =?utf-8?B?cHpVc0VFWUQ4eFpjK3FiZjR4R3lTTUpKSUVUU0RUcm83RjQrS2t2ZjR5U3Fo?=
 =?utf-8?B?Vmw0eDZoWHpoZUliblB4Z2dqQnVvcTdPb1RMK1BSTmlhd0tvTTFxR1dKaEhP?=
 =?utf-8?B?bVhWOTNuUlZJVlRvSlNraFhRSTZvUDI3SUNkYmtSRHRIZWpla1RxQmRFMGVN?=
 =?utf-8?B?SytSNlZYeVpqN0x2SDJaRkZWK1AxTndtUDR1aUsxdjFWTENCeVVlQU1oYlht?=
 =?utf-8?B?QjI2eDU4aWp3aFhiZEF6UUFFNjM0d1lDWVJHT09IVlVEOXU5cXY3a0U0RXpJ?=
 =?utf-8?B?c3YrSzRjZ1p1bSs5WTFGeE5SQWtLRFhRL2pHa3hEQ3JaZXk3SzkvVDZKK3Zy?=
 =?utf-8?B?dzV2bGNad3lLNFNVaDVPN1o5ck81RGl0K0NQbWV1SXhmV1JXL2FXcnEvanVB?=
 =?utf-8?B?NUErdWRNREd1WWtETlZmRjJ1UG4vaTd2S21Oc0p6TDZnVkpRU2xLMmQvaTFR?=
 =?utf-8?B?Q2Uzakx2c1JLSE1FU0U4WU56WjdZRHVIaUpERTlnVTFwZUVUKzVqQ0I1c1pD?=
 =?utf-8?B?TXFxVEhFcE9TQWRFTXlrUExCWndiNE1RUHNtYWxGcDR2ZGl3RHdEbmF6VWRk?=
 =?utf-8?B?TUxKQ1FxK0FTcFI0UzgrZ20zYmh3eFRUSHJ5K0pTZEZUaWpGaCtuUHRlS0tT?=
 =?utf-8?B?NWJ3WmhVUGxIcTJwUW94NnlFT1lRT3FrcXdTbEhHVDdXWk5DRHdHbUdsZVA3?=
 =?utf-8?B?R043SEQrd3NaUXNObklBU3hld3JWaXMxMks5d3pQbmpqUkhJcWVHM2FrQTlp?=
 =?utf-8?B?N3huNFFqSE5pZ08xRCtmRGNNTG16L2RwbzBWTzcvOUZHSGkzYSs1bFBBMEhw?=
 =?utf-8?B?UVFUcmkvNGwreW5Pa1IxcXVHaGFyemFNMHpoQkNYdTBCT3lJSUFEZmRkN2xC?=
 =?utf-8?B?MmNUV1FPblZ4a0wwdjZmbVc2RGxoam9xT0xIK3R2d2RwYXo2ZVRtZWpuZnFT?=
 =?utf-8?B?NnBWTFpEUEVGYjN4RGkwc25sa0dPaHg1RjlwT3FCdnAvWlEvRDYxbFhlaTM4?=
 =?utf-8?B?WnI0OERFeWVRZlRSbmt6dHNoWXlRRnljR2pGSWpaajlJWUltU08ydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91685ad-be78-4042-8188-08da4cded716
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 01:48:40.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSZGZhqdm+kBFuGDfphxrzoK11mvbZGgYUT97z5OAYofrtOsOJZxkp0y98H+yLpi6HVdRyn4/aYQXVG0hlTovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA2LzYvMjAyMiA4OjQzIFBNLCBOZWFsIExpdSB3cm90ZToNCj4gPj4+ICtzdHJ1Y3QgYXNw
ZWVkX2hhY2VfYWxnIHsNCj4gPj4+ICsJc3RydWN0IGFzcGVlZF9oYWNlX2RldgkJKmhhY2VfZGV2
Ow0KPiA+Pj4gKwl1bmlvbiB7DQo+ID4+PiArCQlzdHJ1Y3Qgc2tjaXBoZXJfYWxnCXNrY2lwaGVy
Ow0KPiA+Pj4gKwkJc3RydWN0IGFlYWRfYWxnCQlhZWFkOw0KPiA+Pj4gKwkJc3RydWN0IGFoYXNo
X2FsZwlhaGFzaDsNCj4gPj4+ICsJCXN0cnVjdCBrcHBfYWxnCQlrcHA7DQo+ID4+PiArCQlzdHJ1
Y3QgYWtjaXBoZXJfYWxnCWFrY2lwaGVyOw0KPiA+Pg0KPiA+PiBZb3VyIHBhdGNoIGRvbnQgZG8g
YW55IGtwcCBvciBha2NpcGhlciAoYW5kIGFlYWQvc2tjaXBoZXIgYWxzbykuDQo+ID4+IFBsZWFz
ZSBkcm9wIHRoaXMuDQo+ID4NCj4gPiBJIG1pc3MgdGhpcyBwYXJ0LCBJJ2xsIHJldmlzZSBpdCBp
biBuZXh0IHBhdGNoLCB0aGFua3MuDQo+IA0KPiBIaSBOZWFsLA0KPiANCj4gQXJlIHlvdSBwbGFu
bmluZyB0byBzdWJtaXQgYWVhZCBzZXBhcmF0ZWx5PyBIVyBwcm9ncmFtbWluZyBpbnRlcmZhY2Ug
Zm9yDQo+IGFlcy1nY20gaXMgYWxtb3N0IHNhbWUgYXMgb3RoZXIgYWVzIG1vZGVzIGV4Y2VwdCBl
eHRyYSByZWdzL2ZpZWxkcyBmb3IgdGFnDQo+IGV0Yy4NCj4gDQo+IA0KPiBUaGFua3MsDQo+IERo
YW5hbmpheQ0KPiANClRoaXMgZW5naW5lIGRvIG5vdCBzdXBwb3J0IGFlYWQgY3VycmVudGx5LCBz
byBpdCBuZWVkcyB0byBiZSByZW1vdmVkLg0KVGhhbmtzDQoNCi1OZWFsDQoNCg0K
