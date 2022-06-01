Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BC53A07D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351115AbiFAJdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242772AbiFAJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:33:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB08AE42;
        Wed,  1 Jun 2022 02:33:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDLihKblQxBe+dOw5tSt5hWYFrh5sSTWoX0Uxb40JJSLsolBJImDapfyY4AHW/pm/jtQr4Sf6NR9KokrMzZoeWRyBWtVOuIkUAlSYw4Izm6pE+LLOYJONbbePhz4S3Dl0TZah8qnLRGM4l4o/nELlGDrgHm/8Qvnj/ftp8swmIMeg+ReNJQ331+W/mIDfSZjj02zycY9W3DxelEV6sPjV0B5guS/pZkeYA0UxNyYpFqjUKNrEunTm80MiS5XZysl8G0Wf/3vIU7WMJGP6kfex+HvfzGp9VlgA3yOd41B8DE987FvQ7K2nk8ceRwyWsD4RNUJ9CxGzglDsSQrohm5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W78C9PTxdlJqBpq536MDL3ASYZDdGLCiFHQwzSeQ+gE=;
 b=gLdEmqueS/50EpLTvDSd+Pz71x9F1yKJBa8xouYsDUtmVj267YgYXHfPrE7qoZUM1GF+ep+6cOaAcv5bEx02vHt1PpCU28BxskPHD/CaFCTL0sM39l0BiSmeKcBDpFSFn3YhSUJ0lbwD469Z1ilmC5XeIZBBHw02oggFxh/fWTnL1pMES0rOhqRtHm10OyxBwT8oh1rAfPrOlYskfN55ajR8Z6pe9cvghZ8/w4briD3YIZCRmvihXR0sGL4G13o7WpSItNQ72G4v6g1M9Rz/eBSSydxoqwsu23Di+xYu3yPb7RdS5XNiv5+XodGoQZu1nAMi1IA+r6lrW+GwCk1w6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W78C9PTxdlJqBpq536MDL3ASYZDdGLCiFHQwzSeQ+gE=;
 b=N9iN2lRTnD65kXXTltt34BsMjOlUfUijNDl1s5IkM50lEAXt5rCaBQr9hSilOqtji7JU/OSFIDD/dRDDPFt6qr+i9LB1I/d+r+BE2Wrk6T28ukwahdFrqIkd1fiOneQS6VtG1wzSEoEOoIBLDRfrrnQgscTn7J1sVXvKYDzb2qpxZjcDAXrIg/wA9LAl2lUmaAy+jNYR3n2DlZU5xvMoeRkV0aXm1wYgg/taCE+1tJ/hRkKfsO0VJFT0Gy3UM52ML6pKj7ua0B/2kEI6+FXRDwV00XBbCv1J9galZByMaaNs/X8FSa+/6CdY4m1zBVzlw54JWABlrLdT9FQw85LKaQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB3775.apcprd06.prod.outlook.com (2603:1096:4:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Wed, 1 Jun
 2022 09:33:31 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c42:9783:92c9:f237%7]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:33:31 +0000
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
Thread-Index: AQHYdXph6uXYRV5fyEGJ347eBg/o6K06K/0AgAADx6CAABaRgIAAAtqA
Date:   Wed, 1 Jun 2022 09:33:30 +0000
Message-ID: <HK0PR06MB3202B752ADB99468D8DC4ADE80DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220601054204.1522976-1-neal_liu@aspeedtech.com>
 <20220601054204.1522976-5-neal_liu@aspeedtech.com>
 <dca283db-0b2e-1fc1-bc76-811c4c918fb5@linaro.org>
 <HK0PR06MB3202D6A6C66480BF60ED829080DF9@HK0PR06MB3202.apcprd06.prod.outlook.com>
 <d1ffbc04-0c80-369e-a1dc-e47e50f52340@linaro.org>
In-Reply-To: <d1ffbc04-0c80-369e-a1dc-e47e50f52340@linaro.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b670ed9d-f6db-41f5-0b6e-08da43b1ca61
x-ms-traffictypediagnostic: SG2PR06MB3775:EE_
x-microsoft-antispam-prvs: <SG2PR06MB3775E06D17724AFD8488096280DF9@SG2PR06MB3775.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PUd3Awz6rmUIY9KLn/Yg/5CvGpLLEV0pvstaHmA74pey8ov9i3GZlz52zOwYKZ5GNfOn9d0FYXW8H1hC4Il690f7EHxQOQzu7Pgje9O0RzckXnOhrTX4UwHDORzhBdhsl4CPToAyM3RXuSqZsPcdf0dVbA3x0zKn9OLZBNRrWLtxMgFePOjvxPfETkfiRlWiXAs3Hu3EWPtpnsFX6lxPd2nVthdGI1JB9NNGCOOYnh+uGrWReKuBEamCga0XI09/3/UuxLmbc6s+bk2ieUqNmq+eFnQ/OjVYzKzhXGly7Frm3EngDfZBuuVHopEITcddItvHVAna0tKqn+VECjfy4RFWTT96MA2q7ZiXipstn+bT63y3WUty6/heX/4Gmnx6f0NF4n3ymjJKlRQCo6y1+7/hqBWKfwFhT8FFb0JaRVMg23UYLm4Lvupgr2rcwKQ1gCaEaY77RgCQvCyBCV11HuD1Nu37uQqId4k8U65tTPXiuimJcR6p0cPsSiOk1Zjpem8m3iVrrZt9RS9FWofyz2t7SY+Ix5hcQDgqX4LTINvObC1eJpb3H/1zyGyK3aeUakY+xUcbjxyVoDWK0gN/e7nLA8Un0gtT++WPn/dlUXMas9BfOtN7qFb15eYoVRQ6ljP70Ch8Et/7+AgWwqCUE2a71NrdEn3CnxcWTXxYO2aTddufZq1FsxOiBj3dw3Nj+rNxHOMJ7XGNojgWs21k2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(4326008)(6506007)(83380400001)(5660300002)(9686003)(76116006)(26005)(4744005)(8936002)(8676002)(55016003)(2906002)(52536014)(66476007)(66946007)(7696005)(53546011)(66556008)(38070700005)(66446008)(64756008)(508600001)(6636002)(316002)(71200400001)(110136005)(54906003)(122000001)(86362001)(186003)(33656002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkJMTWJnYVh3dGV0andBaXovRWxWSUcxcHJqNVVQY3RJZDRRODBFTzZzKzhz?=
 =?utf-8?B?amRsamxJd0p6UzMvTnJiNTlQWDdsTWxqZVE3N1FMbXdqdWlxQ3FodkhZNHNi?=
 =?utf-8?B?ckg4VGg5MFBRVXRxYW85UHNnL1M4SDRTeWhKMm5Mc2owbXNKZmJpR2Q1ZUlI?=
 =?utf-8?B?UkR3Nm1UYlluSXFZc1RiZ0VlTDZaQlR0K0o2eU1yZlkxMTQyN0h1d0NSclp1?=
 =?utf-8?B?cXNxeEkydGV5UnNKdk1JSDVGNW1rb0VvdlIwNTBtL2draVZvRmMweDhrQWoz?=
 =?utf-8?B?WFkrS3orbVNoQXkwOWxaT2NUZ3BKYUU0aEtDMEduT3c1ZjZsckk0R3NtcG03?=
 =?utf-8?B?NkdqTFlGL0VSSVhrQXgxMHMvRVoreFdGMVlrSXd2YlhkdUVuRkJLWEx2d25P?=
 =?utf-8?B?MnZYNEh0M3JIbXY3MzdFdmQyMGh1bWNDQ0NrUUVnampVcTZLT1R3YWJaK2Fu?=
 =?utf-8?B?bVZIcWNWSWRQSWhtZXJsMXJBMEQ0NlZzVXdoLzBSRGhMQmdrK0cySGNGamx6?=
 =?utf-8?B?REE5K1NYWCtLTE1YQXdKTEc1aFBZUXVqc3NEVVNaUGI3UjhmRU5iRWsvTmhO?=
 =?utf-8?B?R1h5cXdNcktMMDVHNU5qWGpzcWRkTjhGTmlkYkdERFlId1pGUGpsS0pqUDZo?=
 =?utf-8?B?WityYkxnODBYNXl3SVcxWVlYMWwvVHErekQ3ZERvbTVGcS9abUJ5cFdpY255?=
 =?utf-8?B?L2JwblBWVjFlRnY3ZlFWSHd3YnNYTWtIM3R1S1pTQUNEWGpTMkxrb0V0OWFK?=
 =?utf-8?B?LzE3akw4aFpQakYrSTFOSHFkV0YyakMwamc0WnZqT0NZWnhrZTg3aGJYbExC?=
 =?utf-8?B?dEtmTytOQ0tOSHR5V2dTNDN6SjA4NUJabWNraDl2emtHeHVRbTFSRFF5MTcz?=
 =?utf-8?B?dmRNaWo1YzZvUzFMc2hRSmFJZUdFSHlJL0ZLSlFnS1BiNGlJRGQxeUJ5Lys2?=
 =?utf-8?B?eFJLQm56M0Fsd01PVUp4OTFQcDI4Rm1nYi9ZRnVYTnlibGcwRndheEluc3kx?=
 =?utf-8?B?clcra0R6c24rbkJSQ3ZCSzJEWW4zNzFTSFlGSEdLTEhaMmZUMjlGQXJ1akdI?=
 =?utf-8?B?bXJiTmNOVnN0UGp4bExnOU1wejZsZWZWZFBkcHlyQVJzdGZXN0cyTUNLQ2t2?=
 =?utf-8?B?ZnlSSGtZclN1cDNOQlV4MGhtMmlWbnZicWlndldMZDJLZ1crNXNZQzViM1d6?=
 =?utf-8?B?VmovaVRJSGptK3R3Z3BpanMzOWhrVVRBRkFXeUxXNjlSZ3dMU1ZiYzVvcVJ6?=
 =?utf-8?B?VEZSQmtOUXo2UWFnSGJFN056R1ZycGdpbHFPT1h1TFdYSk1ZWFF6ZUl5bElJ?=
 =?utf-8?B?djdFRXFXSnZlYVVVZFRLcTAwdGJtNFJubFVhZEJ0b25QMEFTRjIwY01JRkdK?=
 =?utf-8?B?U0FGVm5IT0k3dFJkbnMwY1V3aFh6ckRZYWU4Mk80YzFxTE4wVVlheHVYQ1JW?=
 =?utf-8?B?QUpwMXFqU0hVRW03ZnJsWjk5cWNxRHNqMWhlR2R0eEpTRm0zaDNCc1Byb2g4?=
 =?utf-8?B?K2VhS0crTlYzN0krVEU1MzY0NVBDMWV2SHhqYTFuaDB1dk1WYmpIUmJHTTli?=
 =?utf-8?B?d2hULzUyTHVZWXc1VGFwV0hQbFJzaTNDVkViazkrU21DdWoxMmF0amt6bmZ3?=
 =?utf-8?B?aEFjQVZwcTRLUG9KQWd5bEdWbzhEa0xMTzJqUEYyTW9CS1VUT0x5NldYK0Q3?=
 =?utf-8?B?dlArVk9HMXd5UDArSXMyRlFhZmNuUm9TaTNEWFJJV0FvK3lXWjVXWG5Kc2lk?=
 =?utf-8?B?d0FhWHhEWDBSNk1nRzhkVGNYYzducDVJU3ArRGRLK3BsYmFGVTVHRllnQk5H?=
 =?utf-8?B?aDVIYXhmRThQVVA4QXZ4UnNsUDNZUEp4eERDNnB6SlhEclBFTW9pZ3NJQVc5?=
 =?utf-8?B?MWp2blhCcm91QmFXVHAvL0dxWksvQ05CQUNJbGdiRUV1K0dKbFhvdUhGTk1P?=
 =?utf-8?B?a0xyQ0RlSEM1cEdwRnVGcjhRQTJZQmREODJSV2dnUG9PZW9nR0FOaHgwYmNT?=
 =?utf-8?B?bFZOcklURXQxT0Z1ZGJGN3pYenY1SE41SHo3NU5wTWdzQ0xVRWZCUkhIUkMx?=
 =?utf-8?B?S1RpUzVic0hYWHZueWxLT05ZL2Y5UVNKNnZud3pVcnFIWjlaanozREZzb0VF?=
 =?utf-8?B?N211UXJYb0g3RDJZV3VLSTVGb2p4VFB1TWk5Uk80QnF4NXY3MGFTc0Vub2Fi?=
 =?utf-8?B?bmtGOG1NU0hlcThRKzJaeGtZall4UXYxKzZTYm91UHMxeUNCREhzR3g0d05n?=
 =?utf-8?B?TmhMakNuYldkSnBVaDV5QlFqakMzY1pYdHArWTJ1RGhqTEo0K2ZCVWJkbFdT?=
 =?utf-8?B?amxISGhVTVNHUk5CbnVDSVAzQ3c1U0ZNZXJob2c0U0g4a1QzVmVlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b670ed9d-f6db-41f5-0b6e-08da43b1ca61
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 09:33:30.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: neq8GIaPDEDgUK3Ndv2/Bg/ykMh826q2OMkAiz8IxXwOOMU3iEHBGBY/l7uuAazQrwHkvY+z9fkDWKaDZqom1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3775
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gZHQtYmluZGluZ3M6IGNyeXB0bzogYWRkIGRvY3Vt
ZW50YXRpb24gZm9yIGFzcGVlZA0KPiBoYWNlDQo+IA0KPiBPbiAwMS8wNi8yMDIyIDEwOjAxLCBO
ZWFsIExpdSB3cm90ZToNCj4gPj4+ICsgIGNsb2NrczoNCj4gPj4+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPj4+ICsNCj4gPj4+ICsgIGNsb2NrLW5hbWVzOg0KPiA+Pj4gKyAgICBtYXhJdGVtczogMQ0K
PiA+Pg0KPiA+PiBZb3UgbmVlZCB0byBsaXN0IGNsb2NrIG5hbWVzLCBob3dldmVyIHVzdWFsbHkg
aXQgZG9lcyBub3QgbWFrZSBzZW5zZQ0KPiA+PiB0byBoYXZlIG5hbWVzIGZvciBqdXN0IG9uZSBt
YWluIGRldmljZSBjbG9jay4NCj4gPj4NCj4gPiBJIHRoaW5rIGxpc3QgY2xvY2stbmFtZXMgaXMg
b3B0aW9uYWwsIEknbGwgcmVtb3ZlIGl0IGZyb20gcmVxdWlyZWQgbGlzdC4NCj4gDQo+IEkgYWN0
dWFsbHkgc3VnZ2VzdCB0byByZW1vdmUgdGhlIGNsb2NrLW5hbWVzIHByb3BlcnR5IGVudGlyZWx5
LCBpZiBpcyBoYXMgb25lDQo+IGdlbmVyaWMgZW50cnkgY2FsbGVkICJjbGsiIChvciAidmNsayIg
LSB0aGUgc2FtZSkuIERvIHlvdSBhbHJlYWR5IGV4cGVjdCBhZGRpbmcNCj4gaGVyZSBtb3JlIGNs
b2Nrcz8NCj4gDQoNCllvdSBhcmUgcmlnaHQuIEN1cnJlbnRseSwgaXQgaGFzIG9ubHkgb25lIGNs
b2NrLiBJJ2xsIHJlbW92ZSBib3RoIG9mIHRoZW0uDQpUaGFua3MNCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCg==
