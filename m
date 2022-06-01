Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F263539EE6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350488AbiFAIBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350476AbiFAIBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:01:15 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57B95DF0;
        Wed,  1 Jun 2022 01:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM46PdQFo7frJWho+J3sopF+uXIwU6giU/RZdkV/9caM3qky1j5l1X9rNIuZCFolmOQSijucDi+PVRhhEzPXHOCYOPiXgeaZKfjUDlUe2IuuJzsilUPavLncRG1p6UJJE+di2qdleJYQ+hDjXBSYSGdt65JtY8bHBtkuXQwDaHNdj1jDg0EBnsAV01jXTOJfsxJSF2EEGNKfntu9RGDnVxWt7cj4Z9ZG1uTNlAw6QpKX32K0FbpPi8vbfWxtT95EkjSCAU+IBjjEddry2UNGbiuR4SbtCRONqxaeh+FeZsYHwcjZRBII4NwQsIrKmhKg3gylibSX9HZJIhyEKdxdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alGDkfdO1m/QvtJpueufTssFJzFdvbtMHYb4W3xTbCQ=;
 b=jKsw67n1cOe/DkuEDhX9Xzyb6UxOJi5DoEAkHbm33d2s2qIX08QcQQXOxA58Mm5G7ot5zd0ixt95tje7TcJdraUMob8hsf6+nrCnrYsH2gvmY9iQz8mzZZhSTHrnhZy6Kt0bv5+OdTEm8ObsYhmj+7DWul6bE34iV/cGef3MU4QNwpGwgfgKEy4jJVSZVVDFu6erF5fZfq3RxxeELN8byUbI0set+oH4JsPZ3E+G9c2g0zER2x4DNCfTOG8kcxzysyaMOJopRaiuJ5m0/48xg/xRv0Y9Y0Qsa8c0eMwYN2+w1VgEDU2AID9VavHFbIGbWEWxhQqtpqmr9anU4xMV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alGDkfdO1m/QvtJpueufTssFJzFdvbtMHYb4W3xTbCQ=;
 b=rI1KetiDcnNGJfbCjAQHHf+Zvie12GKKN7IHqFDH+plaC/XJLkK0pWQDEIkuo32CFsroQ5cVUzwQxP7ubvrQBwG97288QlnMtQBu/Y8dAhJPX0AculYFMLGks1hvtx/lrM7aCasdcclTKJlwogbgt/vePqTOvI1+KIxq5Kjl0L5Be9TUGsrnQWN+6lntd4HNVqsf8K6s12FWEhf3tjDEt9DWWUi/LssoCtkXg65jsa56Z+mIzfd1dwpGxCtP41E49sIMGHaaiPp411vHm2r8a/nOv2FE/dNXVRQHN4O/OPsMaIUVTXH9DGe64+Sv84GMM52hJqLZN9jkaKi2g5Zw5w==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TY2PR06MB2525.apcprd06.prod.outlook.com (2603:1096:404:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.18; Wed, 1 Jun
 2022 08:01:05 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 08:01:05 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Johnny Huang <johnny_huang@aspeedtech.com>
CC:     "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/5] dt-bindings: crypto: add documentation for aspeed
 hace
Thread-Topic: [PATCH 4/5] dt-bindings: crypto: add documentation for aspeed
 hace
Thread-Index: AQHYdXph6uXYRV5fyEGJ347eBg/o6K06K/0AgAADx6A=
Date:   Wed, 1 Jun 2022 08:01:05 +0000
Message-ID: <HK0PR06MB3202D6A6C66480BF60ED829080DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-5-neal_liu@aspeedtech.com>
 <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
In-Reply-To: <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b2a3412-10f7-455a-b917-08da43a4e0e1
x-ms-traffictypediagnostic: TY2PR06MB2525:EE_
x-microsoft-antispam-prvs: <TY2PR06MB25259681E60E8AEDAF366A7280DF9@TY2PR06MB2525.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLsG4nqhQXE26v21IvJ/lozOE4jThUQfpJdKdhOhTBkuTwlPo3mH1Op08JT0UKSSeHaPoUo5WetUTqGhqJa8Wx99Fl217lbQkF3HNd8IDA5yoxzP+ipDOKS7mP+Fh8oGMuRsUD+Vn0KcvXsIuOopIVkBuerLbckCDi3zo1FkvUdiDV/gTTLP5uktNhwIBQtbpMo/6lSa31u80QNbXsuH0yrKdD1pufbPNO2/vgQAjY52u3XhrNUzdcI5yWHsrJe5hJje1tF1J3Ak1E1a/ozMBQBbfa2Gnnh76PsaXgYD0Y2/YY0dXesBAzc0GgjbKhHSQ0bTYD08I/cOh48cCBHAssCiHWa+cY3r/B8RGBG+K3bAYXu34IS4bf1eyxSTgp9RGO73liy/67mHZmeSTuFHhmGrea7444gBWPG4oqn9ifT2IISsZrstf+4OCtLg6rgUJEXikAyfpZ9ej6X0gQVTVRX33Obgx2MxPwkaAfF9Iva7aYhkNVaJUrTC/ck80oXyJB6NTJ5pApQQA69wtVOdeif3mON8tTlRRMxMxhjquVOeo505eTHrMpRmZA63DS364e4vTE19Y93tJa4U2d/VETbhL3ZcoIN1WT3Tnm9A+Vzb5utAgJjpoCKRefAn1yKZgQFBpF1XfZt/LX/ZaLIIKxqrrKjS0w1pvhyeZvMEdAVv0Z5p36lvNcgLJau1a4WOq/IM15SM60b4qH1xPuH3VIzBEcOh0sfU7TdCMpoxGr2DjOEQhRagAyTeZu5YlUIM54ZW+oFvZOiz5g6/Xvf8XM5uXfJSs7n3M6ut2uQUiWLSGiefQylMh3JSd2/EQmJIN1jp4GTvM6brXfkvsqHrLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(8936002)(53546011)(71200400001)(110136005)(55016003)(66446008)(64756008)(33656002)(6636002)(66476007)(8676002)(66946007)(316002)(76116006)(66556008)(4326008)(54906003)(86362001)(38100700002)(38070700005)(186003)(9686003)(7416002)(83380400001)(26005)(5660300002)(966005)(2906002)(508600001)(52536014)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDN5WUNCM3FpZk9PSitvdFJPWVRhUHM2UVlMbjNlN1BrNDQrNVlNaUpkU211?=
 =?utf-8?B?YjluMWtTdm1oY3BvaGZJajlwbk1wV2toNnUwZ3hFT3NycEZqSWZlUm5SMWEz?=
 =?utf-8?B?MVg4Yms5cHVSRytoR0pUVVlpZTBPUXFPL2dxZXR4d2JjcTFUbFpFQjVHU1Mx?=
 =?utf-8?B?RFNUMkdOMUZ3dHVjUzgwa0FBbnQzQ2NqMm5nSUZmMjVxZmxvQURtc3A0YUJt?=
 =?utf-8?B?akdpODJqb3lEUmhabEF5ZVR5TDVubmZVcnVMWXFzVU5DcUpWMVQ0YzJiaVpp?=
 =?utf-8?B?bW1vRU9ncGpreGU3Sm9GOU5LckN0eXVOUHNycXJEUTNSelNXV1hVNUwxcnVW?=
 =?utf-8?B?a1dZZUpieUlaVTFaSy9UN2NGNFl3ak1NVlVVY2tGTk00cGQ3K3dUVjdONU0x?=
 =?utf-8?B?VGlEdDJFbzR5VTNqQnlqZTlvKzhJMCtXSlBCYjllVDZsU2NBMHFNRU5tTmJ3?=
 =?utf-8?B?RGlyUUhJS1MweHpRZGNzYnVZNm9sbGxpNU5qZEhSbE1PQURHY3hsVGdkNU5S?=
 =?utf-8?B?b2M5T0paSnZFN2pIVWdDcGt4RDRaL2JqZ3RqdEtUOThJcG9ING5GdjZCQ3hE?=
 =?utf-8?B?WkFiN0luS1FpRmJjSHhoTjdNVEt6SnR0RXl5Y3Z4Ync4b0dCTjhiUFZEbE1R?=
 =?utf-8?B?L2dkN2pjOG1QMmVoUTFxL3hydUxNaUxCNE9iSTRvdUt3Y1AxaEd1bHhyZGlu?=
 =?utf-8?B?a1NKYzJVMGR0a0NISUZ5R29SRTBmaVk2WjhleXBheWdTRjJuZTRudTdPOURK?=
 =?utf-8?B?UXh5K1R0d1IxTXhvRnhvUWhhRkMwKy96ZHozWGxZY2pHVUp5WXRGMnRTK2VC?=
 =?utf-8?B?WVUyWkJvLzdYbVlKZUFaaVRLN09RSmVoVUV2UEVhSXg2dTBOcVdtMXRlUi92?=
 =?utf-8?B?M2YxUlprb2NhcHlFV0UxUnh1TGJXSXVNSDFMaHRPVUluWSt4Rm8xR3lRTG82?=
 =?utf-8?B?ZDZ5T0U3U1Bsa2RrUzl0SXFVcVExT0N3RlFDaUZuWG5kSEVyelAwWmRubDl5?=
 =?utf-8?B?N0docG8wd0sybVhFOU5OeC96aXp6Zm4yVWE0b09odytncTZOVWpEUkpzYXIx?=
 =?utf-8?B?OE80Tm1WRXM3cjA5c0lzRHBHZU9VKzVXbjhONGxVekNWdHRBRFI5WHVNbVdv?=
 =?utf-8?B?UklUVDhMcU9BUlYvUXVVNnJNNXg0WlpEcUtqbmwwYkVNNjVMTVgwV3p5ODc2?=
 =?utf-8?B?L3dPcWhVSjRQZjBLeG5EOUhzTkU5V1NtSVZBWEYzQ0ZUbGJtOEVYMmhDN1A1?=
 =?utf-8?B?WFJDb1c3MmdJV1ZWQWtGNjcxa2s1NXZvVDhGM01MS1lsRlVMc2hQMmJISEpm?=
 =?utf-8?B?RDQvOTN4R0Zob0xQVjUzL0ZxK0dqNnhGWmdUUmNMRFNIc0FmNC81bGFJVXZv?=
 =?utf-8?B?YzU3QnZhSFhUQzVyNzRkdUwvUDZDS05DRjUwZjVxRTRLV09iMlMwbCtRZ2Vi?=
 =?utf-8?B?bHNMdENJazlyZGNXdGVGMDJxbGduVEhSQzRvNzdOajZ2OVdQUk5COTJTYUR0?=
 =?utf-8?B?dDVscDFzTFBRam5ZWVZ1RnVQSGJ2M2grWHlMVzlqR2JnRkpVNjhGVHBqY2Nq?=
 =?utf-8?B?SlFtSDdPeW9XMkVHbGE1TW9PUXROdTErWXJHMVZXdlZJeGh2dkZRS0R6VUNt?=
 =?utf-8?B?SlRXY284dEF4M2FsM0dDYSt6RFEyU1laUTEwU1I1UmpPU01YNSsrYTYwY0Jl?=
 =?utf-8?B?Mm03TjUvNjBjbGZCLzQ2WkZmMTlFRGpvcHpzMXo0RFZtVUQ5eEd5N2t2ckxN?=
 =?utf-8?B?dktmRXB4QXZwcy9QeUp6NkxCZ2lPTVZBMjh4MjEvb2V1TzdyNSsveUJydGk0?=
 =?utf-8?B?YlJvbXpFWFdrY2Q4OHpqRlJPN3VBdU5qZXdXU1pxeXNzbVB4N2kwTzFCNGNR?=
 =?utf-8?B?KzdSTDM5cTlBditQcElKU0tRamc1ZWxtdjRHaVdUV0IxTUZUeUdUczRPd1Av?=
 =?utf-8?B?Wk5PMWVLVUxxUGhaamZuc05iZmtKa3FTbEVTdGpwK1lVaW9kNU1XdWlEemZn?=
 =?utf-8?B?bDBhcmJGSGRnbTFqZ3B3NDMvWEUva2JzamJiRnB4bkZRaVRiR1lHVUM2ZEM2?=
 =?utf-8?B?YkxwMGpxd1ZwenBIcThWRllKQU85V1RGRTNpNTcvOHlSajlQSk9nMkxxVkp3?=
 =?utf-8?B?aitKd29zZE5PTnBORUhtOVh2SGJ4ZmFnMGxqS1BjaXdhckIvbW5FQlRVM0lk?=
 =?utf-8?B?RjM4UjB2YjQ4WTZUR2JRcGJiZzZFU1lCbnJrNUhhSWFhSTdiRnpMbU9Kc0Zl?=
 =?utf-8?B?d0ZOOW9vUTl6MGZVci9LTzgwZGdRdVIwUmFMU3dOL2dyajZCWXJCUTE0d1hj?=
 =?utf-8?B?Z0FER0FOYnR6NnpPOXBwWWp0Q2sramdaZXVCeTkwMFRIRHVvVkE2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a3412-10f7-455a-b917-08da43a4e0e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 08:01:05.2620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VS3JoPNFvQZ/qBCj0X17NCPRthOYhvMveIg4RsQVjR3I94TIqjv8rs6tHbs854vuZyD1aOxxRYfm9TWn7jJsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2525
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAwMS8wNi8yMDIyIDA3OjQyLCBOZWFsIExpdSB3cm90ZToNCj4gPiBBZGQgZGV2aWNlIHRy
ZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciB0aGUgQXNwZWVkIEhhc2ggYW5kIENyeXB0bw0K
PiA+IEVuZ2luZXMgKEhBQ0UpIENvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBO
ZWFsIExpdSA8bmVhbF9saXVAYXNwZWVkdGVjaC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm9o
bm55IEh1YW5nIDxqb2hubnlfaHVhbmdAYXNwZWVkdGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9iaW5kaW5ncy9jcnlwdG8vYXNwZWVkLGhhY2UueWFtbCAgICAgICAgICB8IDU4DQo+ICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2NyeXB0by9hc3BlZWQsaGFjZS55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NyeXB0by9hc3BlZWQsaGFjZS55YW1sDQo+ID4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3J5cHRvL2FzcGVlZCxoYWNlLnlh
bWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzZi
NGFkMGRjN2ZhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9jcnlwdG8vYXNwZWVkLGhhY2UueWFtbA0KPiANCj4gRmlsZW5hbWUg
c2hvdWxkIGJlIHJhdGhlciBmcm9tIHRoZSBmaXJzdCBjb21wYXRpYmxlLCBzbw0KPiAiYXNwZWVk
LGFzdDI1MDAtaGFjZS55YW1sIg0KPiANCkdvdCBpdCwgSSdsbCByZXZpc2UgaXQgYXMgeW91IHN1
Z2dlc3RlZC4NCg0KPiA+IEBAIC0wLDAgKzEsNTggQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jcnlwdG8vYXNwZWVk
LGhhY2UueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQVNQRUVEIEhBQ0UgaGFzaCBhbmQg
Y3J5cHRvIEhhcmR3YXJlIEFjY2VsZXJhdG9yIERldmljZSBUcmVlDQo+ID4gK0JpbmRpbmdzDQo+
IA0KPiBzL0RldmljZSBUcmVlIEJpbmRpbmdzLy8NCj4gDQpHb3QgaXQsIEknbGwgcmV2aXNlIGl0
IGFzIHlvdSBzdWdnZXN0ZWQuDQoNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0g
TmVhbCBMaXUgPG5lYWxfbGl1QGFzcGVlZHRlY2guY29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRp
b246IHwNCj4gPiArICBUaGUgSGFzaCBhbmQgQ3J5cHRvIEVuZ2luZSAoSEFDRSkgaXMgZGVzaWdu
ZWQgdG8gYWNjZWxlcmF0ZSB0aGUNCj4gPiArdGhyb3VnaHB1dA0KPiA+ICsgIG9mIGhhc2ggZGF0
YSBkaWdlc3QsIGVuY3J5cHRpb24sIGFuZCBkZWNyeXB0aW9uLiBCYXNpY2FsbHksIEhBQ0UNCj4g
PiArY2FuIGJlDQo+ID4gKyAgZGl2aWRlZCBpbnRvIHR3byBpbmRlcGVuZGVudGx5IGVuZ2luZXMg
LSBIYXNoIEVuZ2luZSBhbmQgQ3J5cHRvIEVuZ2luZS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6
DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gYXNwZWVk
LGFzdDI1MDAtaGFjZQ0KPiA+ICsgICAgICAtIGFzcGVlZCxhc3QyNjAwLWhhY2UNCj4gPiArDQo+
ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0K
PiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiANCj4gWW91IG5lZWQgdG8gbGlzdCBjbG9jayBuYW1lcywgaG93ZXZl
ciB1c3VhbGx5IGl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UgdG8gaGF2ZQ0KPiBuYW1lcyBmb3IganVz
dCBvbmUgbWFpbiBkZXZpY2UgY2xvY2suDQo+IA0KSSB0aGluayBsaXN0IGNsb2NrLW5hbWVzIGlz
IG9wdGlvbmFsLCBJJ2xsIHJlbW92ZSBpdCBmcm9tIHJlcXVpcmVkIGxpc3QuDQoNCj4gPiArDQo+
ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHJl
c2V0czoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiAr
ICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+ID4gKyAgLSBj
bG9jay1uYW1lcw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0gcmVzZXRzDQo+ID4gKw0K
PiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0K
PiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL2FzdDI2MDAt
Y2xvY2suaD4NCj4gPiArICAgIGhhY2U6IGhhY2VAMWU2ZDAwMDAgew0KPiANCj4gR2VuZXJpYyBu
b2RlIG5hbWVzIHNvICJjcnlwdG8iLg0KPiANCkdvdCBpdCwgSSdsbCByZXZpc2UgaXQgYXMgeW91
IHN1Z2dlc3RlZC4NCg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAt
aGFjZSI7DQo+ID4gKyAgICAgICAgcmVnID0gPDB4MWU2ZDAwMDAgMHgyMDA+Ow0KPiA+ICsgICAg
ICAgIGludGVycnVwdHMgPSA8ND47DQo+ID4gKyAgICAgICAgY2xvY2tzID0gPCZzeXNjb24gQVNQ
RUVEX0NMS19HQVRFX1lDTEs+Ow0KPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzID0gInljbGsiOw0K
PiA+ICsgICAgICAgIHJlc2V0cyA9IDwmc3lzY29uIEFTUEVFRF9SRVNFVF9IQUNFPjsNCj4gPiAr
ICAgIH07DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
