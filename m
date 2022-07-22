Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB857DC68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiGVIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbiGVIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:32:34 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE0BE9E793
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:32:33 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2112.outbound.protection.outlook.com [104.47.22.112]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-39-nDoMrt3LNwKCY1l2dEIiiA-2; Fri, 22 Jul 2022 10:32:29 +0200
X-MC-Unique: nDoMrt3LNwKCY1l2dEIiiA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0357.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 22 Jul 2022 08:32:28 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5ef:db38:ddca:db7c]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c5ef:db38:ddca:db7c%7]) with mapi id 15.20.5458.019; Fri, 22 Jul 2022
 08:32:28 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "dev@pschenker.ch" <dev@pschenker.ch>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Thread-Topic: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Thread-Index: AQHYnaCBpxVIgTEi90SaHb3zjZW4/K2KD+WA
Date:   Fri, 22 Jul 2022 08:32:28 +0000
Message-ID: <8f3b069dbca1a4f9b22ea6ca15f630fb4a6bf0cf.camel@toradex.com>
References: <20220722075600.10943-1-dev@pschenker.ch>
In-Reply-To: <20220722075600.10943-1-dev@pschenker.ch>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e013a8ea-0541-443f-0673-08da6bbcb63e
x-ms-traffictypediagnostic: GVAP278MB0357:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: HZpTeyVrHegk86j6Lw3NINewsBEOu3bZrlwqK6tSkSq1vJipp2CgDdZL76lG5BJzgc5XccB4bZ8aSTy0rgmOcR4JxUbzzDRiV6POT5jcOlp6JaX/6W3x2xxUdAT0+/FHIV/mF7Cw6p7kV0w1moDAZKeh1yAdR9b9+taP1RRkpgliAgr14Aar8ifDOJ40jGsABQQ4j41CiStRgkMaQ6Dlxnaned1tEgeNu8Sij3ZAB65cGrR026I5ulP3ntx/EboJa/96LsgIMGtWb44fP4DtFgI+mFzM12OoJUM72cKJGbAx6P/EX9SsZvGER2LQ+x0ZrDnhjwsHPaybGchb7iTKUIeNxnc8asy0y1b7M5Xccds/TVXRLAuo0Lky5P9HptFcchtd+NLgnCS9Tw5MNlDRifSnHtfHgZaqRHRWlzs8xBr6/bYQ1twZUcl9JbKVRA054pOc5XbO1jUoVDFnByQv7J3e8uXLmrD2OPEuaAtIeYxpC0QdvXph3RTAd5A3eIXnNxKwhdIFvyLZsp70KjUR+f/9gGvKbB+gVYV9A9Yp5oV6luCjJoYXpEOsSIX7zO51Omu3XB8kY8NJJAEuJ2WICge81YtnnJvHcqrZewf6rDmEhcOe6q25rYro5thD2LFcTV4JTGKBf8oP6LHv0nBFWKWlXhHjEDGiHNJzPjZkkrwpoQt+AvGOwk6F3PodlE74RpimST46Y4ePZIBCkGPJdRWWSDkMJbUbCEZEFBa33FAU+wA3azpIY9DK/XBiIYMsacwIBdPQc3V4ho/aewDt2+NaDnekXbFbEx7h3AHMayQkqtfm91rRp4F5GOsUxgT3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(366004)(39850400004)(26005)(38070700005)(6512007)(6506007)(83380400001)(186003)(2616005)(2906002)(36756003)(44832011)(122000001)(41300700001)(54906003)(8676002)(7416002)(110136005)(478600001)(5660300002)(8936002)(38100700002)(76116006)(64756008)(66446008)(66946007)(71200400001)(4326008)(66476007)(6486002)(316002)(66556008)(86362001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dnZlZTTittMFRqU3FpNUsxM0ZMbFVGeEs1RmlEcnAyVWZESGlaK1VxTmNa?=
 =?utf-8?B?YmRqOVhFYVFwTm5PS0U5TDlwYmQxNjhJWXJjcyszLzJQcno5R1BuaW42YTMy?=
 =?utf-8?B?SzlBSnFLdHkwTjJIODdtOVlsSlMvbkhleEc3SGNURlZrNnM0Ni9jL2J5ZHdW?=
 =?utf-8?B?RCt0Ukl2Z3ZCTm9WaGVEd1BjeC9ReWRFTmtjTzR6RTdvV0paWjRHYXl6ZUVL?=
 =?utf-8?B?ZlN4ak1iNVlpYUVSaDVOUkE5WW5tQVd5Z3orYXRRUkJKRlNSeGpIc0pDc05J?=
 =?utf-8?B?b212U1dRNzBKYmg0UEFYWGlsbjE4SmxQY1VVbTdwbmhPQnJodlk0cENuSTJS?=
 =?utf-8?B?SHBkbnV2SjRQb0pDaTF2UTE1NjVpU0RZRjJETmVsL2NpcElpSWJGZUVrMnZT?=
 =?utf-8?B?eElZZjFoK29GSzlSNU91a0RBNkNSUFVoMG9zU3lmcTJKZXVHeGN5dWtqSU1w?=
 =?utf-8?B?TUZ1R0tjZ2ZEelVZTWlPSFpEZU95SitIN2xnQi85ZHlxU1hjL0dhaVBoZ1Jq?=
 =?utf-8?B?SWhpcjZMWm9SK0o5SWplUkthZHpBZTZkQ2lLaXpjdW5XejYxcjZ5UGJyd0ww?=
 =?utf-8?B?VFRpalBGaHNUdkxkdS9DREZ6WXVWYWpkb2VOTk1jaWd0by9BeXBQNENPVkpJ?=
 =?utf-8?B?V1dKdHdZT1RLbkZFaHJhMDRZOEFHZlo2a0ZTbzIrRnZVK3c0TDJuRVZNWURu?=
 =?utf-8?B?Q3VRWU5MdlNwRm5yZWhBSTgxcGtCNndzSFR5dWtQdGp0MEIyRFRkSll6VFVy?=
 =?utf-8?B?UUZBb0ZIODZoazRrUnJDODFPcWxvZHpKUlNCUkd3NHdNWkdNd0NIYTBCNURN?=
 =?utf-8?B?elQzZEdRMWdldUFpQjZ4WlV6WFRxWVNWa0JQeVZqcVQwdWNrVUZMaVh5WmJP?=
 =?utf-8?B?aEt3dHhTY0h0bU1uZTdGL3ZZQXFiM1JnbkFzeDljSDVHUmpzWHNWWkhEam1j?=
 =?utf-8?B?VjVReGhjYkRxaHpMNHV0ekl1aStDNGg3WkZLamJnT1grVHRGSkpoWTFmbjZS?=
 =?utf-8?B?YXk5dTNuTS95MU1OVzVGRG5VUFAvbllhM0ZsNW5TbGszL2o5VDlObzNHdFZ5?=
 =?utf-8?B?S296Q0FZQURpZVNHTW9ocjFxM2tqckRKWGQ3bGpCWC9teDV0MjNnckJkdUFI?=
 =?utf-8?B?Mk03WTdjT2tXUXAxakVuOGM3cTlIRFNxZWd4T3JWTTJMQlpFSlpMSkQzTjNo?=
 =?utf-8?B?b0FVSzU2M2J4Zlh3VHNUcDlEL2wycytyREExOEFhUGVUamhhM3F4SS9McjRF?=
 =?utf-8?B?YnlSS3Jsbm5VcFJSZ3BweHE3QTVzdjFEY1pHbkFKMmlrNUdXVWpIS0J6SVhD?=
 =?utf-8?B?cUdpUGZibkUwb0RyQ2NxaE4rdExHZmk1WEF5Q1J1eDlTcXNoM3A2ZlVMbmFt?=
 =?utf-8?B?bTdTYTR1VldSSk13RUZjNGxOZWFpeVlvSGlMeW80L2JHWllSN1VSemxZVE80?=
 =?utf-8?B?cnRScEZNUGUxYUYzQ0hhV08vQWVQQ3hvYTJDSTdPbG1aZ09qaW54cjYyWVZX?=
 =?utf-8?B?TC9tR1ZjbUtrQ0JWV2FTVDZWMTBHZXlYSFB6NmVpVEMwc1RCTE4xdkRKVFBu?=
 =?utf-8?B?R0g1bGk0S3BRb0ZlcTAxekRGbUkyUi9mbGtGcFFBNndwNCttTXlzZ3lIY1ZB?=
 =?utf-8?B?bFlCR2R2YVBITGRkVU05bDdxY2NjWGlZbUVwemQwSmJLb1ZSWnpZU1grTDNa?=
 =?utf-8?B?b2pVeWR3czN2ZHNSSEw3elVwaURLa05WV0JFQ2U0TEhMY25GWXpQdFpDWXBK?=
 =?utf-8?B?MG50bENnWWhOeW8xRHpRSlVzbEdCdEFQcVF4aGRDV3luTVRmcnNBZmg5MlZX?=
 =?utf-8?B?c2RyN2x2UVVtUFRTVVd1bXJaVjZYRzVoWUV6ZkVmbXA2czkzTUJSckpQc1hk?=
 =?utf-8?B?NWk1eStRUUxSOU1FL3gvWkRGdTEvcTZzRTlNdTN3MkRVaVRuNUNNMVJhaVk1?=
 =?utf-8?B?ZTd0eHIxdG9wMm1mQjB4U2txMVZ4bmwrcEtWcnQ1UVZ2c1JBSTdzdkc5YjIw?=
 =?utf-8?B?Z3pFcm8xcWhDQUoyQ0MwL0VvTTZIMFFRVmJFQUtGTnRhdlJtUm9RazYvcUZ1?=
 =?utf-8?B?bHFRbGViT25QcENzTlNKOWh6Nk5zQnZrSXlBcitPaTNtc0kyeGZhdnVHd2FS?=
 =?utf-8?B?L0FJY2dCeFZrOGFhUFpGbzM3Y1FCQ2pHNVUvaVl3d0xYMERpTjN1cUFkdFhq?=
 =?utf-8?Q?Q1BogwNeVaCC8sQSw0fbBpE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e013a8ea-0541-443f-0673-08da6bbcb63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2022 08:32:28.1575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tLXzA1Y/bvyEB0MjALtKjp4ixlh1tPOuXgoL+s5LYnYOX/IXkUJsxaPcKIDH1K/Kzic2Vsqlw7krYftglorqQOUMDFa2g7wIBVVfbO4D7bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0357
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE13A77 smtp.mailfrom=marcel.ziswiler@toradex.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <454934E58F8BA04283CB38FEA1504470@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTIyIGF0IDA5OjU1ICswMjAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXgu
Y29tPg0KPiANCj4gVGhlIFZlcmRpbiBpTVg4TSBNaW5pIFN5c3RlbSBvbiBNb2R1bGUgZG9lcyBu
b3QgaGF2ZSBWQlVTIHNpZ25hbA0KPiBjb25uZWN0ZWQgb24gVmVyZGluIFVTQl8yICh1c2JvdGcy
KS4gT24gVmVyZGluIERldmVsb3BtZW50IGJvYXJkIHRoaXMgaXMNCj4gbm8gcHJvYmxlbSwgYXMg
d2UgaGF2ZSBjb25uZWN0ZWQgYSBVU0ItSHViIHRoYXQgaXMgYWx3YXlzIGNvbm5lY3RlZC4NCj4g
DQo+IEhvd2V2ZXIsIGlmIFZlcmRpbiBVU0JfMiBpcyBkZXNpcmVkIHRvIGJlIHVzZWQgYXMgYSBz
aW5nbGUgVVNCLUhvc3QgcG9ydA0KPiB0aGUgY2hpcGlkZWEgZHJpdmVyIGRvZXMgbm90IGRldGVj
dCBpZiBhIFVTQiBkZXZpY2UgaXMgcGx1Z2dlZCBpbnRvIHRoaXMNCj4gcG9ydCwgZHVlIHRvIHJ1
bnRpbWUgcG0gc2h1dHRpbmcgZG93biB0aGUgUEhZLg0KPiANCj4gQWRkIHRoZSBwb3dlci1kb21h
aW4gJnBnY19vdGcyIHRvICZ1c2JwaHlub3AyIGluIG9yZGVyIHRvIGRldGVjdA0KPiBwbHVnZ2lu
ZyBldmVudHMgYW5kIGVudW1lcmF0ZSB0aGUgdXNiIGRldmljZS4NCj4gDQo+IEZpeGVzOiA2YTU3
ZjIyNGY3MzQgKCJhcm02NDogZHRzOiBmcmVlc2NhbGU6IGFkZCBpbml0aWFsIHN1cHBvcnQgZm9y
IHZlcmRpbiBpbXg4bSBtaW5pIikNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIg
PHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KDQpUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3
aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPiAjIEd1bXN0aXggVmVyZGluIEVkZ2VB
aQ0KDQo+IC0tLQ0KPiANCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0t
dmVyZGluLmR0c2kgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVy
ZGluLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tDQo+IHZlcmRp
bi5kdHNpDQo+IGluZGV4IGVhZmE4OGQ5ODBiMy4uMTk3ZGE3NDgzN2NhIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpDQo+IEBA
IC03MzcsNiArNzM3LDcgQEAgJnVzYnBoeW5vcDEgew0KPiDCoH07DQo+IMKgDQo+IMKgJnVzYnBo
eW5vcDIgew0KPiArwqDCoMKgwqDCoMKgwqBwb3dlci1kb21haW5zID0gPCZwZ2Nfb3RnMj47DQo+
IMKgwqDCoMKgwqDCoMKgwqB2Y2Mtc3VwcGx5ID0gPCZyZWdfdmRkXzN2Mz47DQo+IMKgfTsNCg==

