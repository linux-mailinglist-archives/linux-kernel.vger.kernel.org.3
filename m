Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650CC59BCE8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiHVJeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiHVJeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:34:05 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19B3056D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:34:03 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2107.outbound.protection.outlook.com [104.47.22.107]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-52-PaoHaJAPOA-PClQx9v18jQ-2; Mon, 22 Aug 2022 11:33:59 +0200
X-MC-Unique: PaoHaJAPOA-PClQx9v18jQ-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0020.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.16; Mon, 22 Aug 2022 09:33:57 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f%2]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 09:33:57 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "max.oss.09@gmail.com" <max.oss.09@gmail.com>,
        Max Krummenacher <max.krummenacher@toradex.com>
CC:     "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Thread-Topic: [PATCH] arm64: dts: imx8mp-verdin: add cpu-supply
Thread-Index: AQHYtfxXyCA2zZWBu0ue6vTfegxv4626qJ4A
Date:   Mon, 22 Aug 2022 09:33:56 +0000
Message-ID: <ba07beb3bc498cc3ab7c1eb46052ac3c8110b515.camel@toradex.com>
References: <20220822075342.2611279-1-max.oss.09@gmail.com>
In-Reply-To: <20220822075342.2611279-1-max.oss.09@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 848ce84f-566c-409e-4921-08da84216fc4
x-ms-traffictypediagnostic: GV0P278MB0020:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: +WkbfIPdkWSGiiRYw3Gaw1lStju4w0N8PgX4BZd1j0crxkGVFkztlLSxkjJsIxgFVdtYOu14lzJJGYHggEAlbxbsBh/SOXS5lQh4mEuUgKApt4Fi40vPUgu7T3kjf4sjbQ4+9aayxVVs3zNdQ/dz/vw3ewdhvMtQm9ZX+Z4scuL8S13Y45e87TInXp1wG7GhLSmoiUXAQ6YEfm87YxOcBkeTqtAGvzC4vbJNu+pjAaawLNXFJ3qGrwCaGqNawQYR+xLFhdHbMfgXGtMhODqa7nMTYOwMsWZVa7qYti5w6xucTBK91z0il8xjx+txN3QnTQk2G+5o4jEcPKwNLnHrlpupbRfvQYxVGo7/03yiv/66JQG4YVHXzL7FwKKgFqqQH9ZB9Ux+2GNS3fsGnEH5pJHoG9CUWWOsDfI+KiiKtE9eFXTicpyKIH/ZYzCSS8Bx2J/dJFc6JwVMKIPRhdxGxULl6D2mv2Df1mQhxbU2gXPpN9Lxy4WI1kQeoKTrmL1i9Ecx6/KfR/OMvFBtPU6uArAepyyos8crEzPg18/QPKxRYAccQUCwPudVXyBlDA1X9Rh9xEHaIb2BITsiasr045wY4V/zfNmv7hX2hHz7Qc8AFwRsVt+L77E4U6/9AUKANqRKXfeLL6t5Qmn89Nx5/wUfuUwEg726GsYVRTYsJPHauTaohvt1EwF6AONF31P7dYt1ocAc9TzxT1e4PSJyc/GGEMdi7um6vBk0yvdq91wSPqPY9BhAccQCqCyluJiD0mbRyAJmQrXK6P4K2F+mACrB8a3BvaVKAfNL47Mp23g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39840400004)(366004)(396003)(4326008)(8676002)(64756008)(316002)(66446008)(110136005)(66556008)(54906003)(6636002)(91956017)(76116006)(66946007)(66476007)(5660300002)(8936002)(7416002)(44832011)(2906002)(122000001)(38100700002)(86362001)(36756003)(38070700005)(478600001)(6506007)(71200400001)(6486002)(186003)(41300700001)(83380400001)(6512007)(26005)(2616005)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmhiMEVSTHNJYzBhZE9YSDVtVDlDT2t5b09NVzlzR2h5b2pycHJjSGlvZy95?=
 =?utf-8?B?QWIyTFNLd1JOaFIyZXdlVmxseXZ3bUxsVkJuZktzRXhGZ1l3eWpuRlY3K25u?=
 =?utf-8?B?TVAyakFuMU9hcnZkQkVCK2NDSmszajE5K2hYZlRXY3U5aURTejQ4UHRFQ1lO?=
 =?utf-8?B?aFUwcWxvd1hhMXhWK0t4ZW1WVTlmRVNGYlJ0WVNNekxOdVB3ZFp4dnVIMTFq?=
 =?utf-8?B?WlAxNk5wS3JqNGtlKzQzOG9USFc2UEtMcnRxL1hvSzJyWjRwaEE1citadms3?=
 =?utf-8?B?bE9hd295NVprUm56OS9QcHA1MXFGb0JLL3ljNXZiSGNjWTZ6MENxV0c5dDIw?=
 =?utf-8?B?TW14ZHJ1M0wvREUwR1dOcG5pQ3p6NnpZdjNrb3laTExzLzRXTXA2WnZ3VDVH?=
 =?utf-8?B?V1g1aml3WWJxbHJ0bkxEY0pYaHRzL0NOMmFZTDVIMWg3dzc2a0FnUWZuNitv?=
 =?utf-8?B?YXh2WENoQVJ5VFByb2E0MU16OXdaY3NyNlRyeHc1dkZiTk9DdGdPR3ViUUdh?=
 =?utf-8?B?R0kwWGxUNTArQVdKOE5CZ3JrK2Y3TVNneGdBOVFqbmUvQ0UyeSswaXQrTlFr?=
 =?utf-8?B?SWNkQ1ZLMVlKcGxJTlRkSXlvZ2JaTThpNUZRM1gzUHNxL1haK2ZoU043QzVk?=
 =?utf-8?B?N0NnbTRndS9DOGFvVWJ1OE9EdmhCcmNEWVFxaVZHSkNVeGVvQWRhQlQ3K3cx?=
 =?utf-8?B?aWNqajdtcyt5NHBOcEJyZTRRTEU2aHdFNElJb2ZzbzJnUGw2cm1zT0tIOTE3?=
 =?utf-8?B?bXNqbjV1MUllTlNqUldSNTFWa1hzNndHSWtUdWJrUTljM3JWUlNJNnFibUZj?=
 =?utf-8?B?NEU1cnUwbytqempNanRXV0VnYVBmNFhMd3Qwak16NzhWdkxlaEIwSERmSVNx?=
 =?utf-8?B?UnFFVlMxdmNxWldYK1NyQ21aSmlheG5sNG9NbUZEb3h1Yll6MzlvS2U2b0tK?=
 =?utf-8?B?Tk12SktaQkdKRDBSbVkxVEluMXBBREVZQ3QreWdIczMrSlh0RmVQdlFwazhr?=
 =?utf-8?B?WDdaNnp3Znc0VWtLR2RHTDdBWFUyYTQvVmowV243QnF1UHFtb3h6cWZ4T0hx?=
 =?utf-8?B?aUJyQmpFL0NhSUpBdmwyc3JWOFJBRkZvRGVZU09zdmp2ZWFweFMvc2JNU1Jk?=
 =?utf-8?B?VGhSU3ZYaDZuMUdQUEtvK1VjbGllRWFZMy9mVWY0VnlYb3JCZ3NWbVNRTzlC?=
 =?utf-8?B?bm1aVDlGK3E4MlJJNngrY2FidXQ5S0htVllUVGhuNkx1c2JaSXlIenduMUMz?=
 =?utf-8?B?N2poQ2NYWk1wdUc4dkY3OXI0SGk0MDJuQm5YN01qTGp1SlRyY3FMc0JpeDdu?=
 =?utf-8?B?SmhUbVA2THBlTmlXK2FUVFZlK3EyY3laU1ZEK1lXWEJkeXI2UjN6L3NRMkJz?=
 =?utf-8?B?Y0pQaGxRaHJUUHM2RzBvZWc4alc1SEVuWjQ1TmV6OXFNdlBRNisxM3R0a3lT?=
 =?utf-8?B?a1lCVHc5WmorRlRqb0VuU01ZYk1JQjFsK3gweUpkZVVKMHNTMVEzRkt4ZXpk?=
 =?utf-8?B?YnQraksyVzNYVEk3K0lSaFRYV2lPOTBCSnY1NHAvb1dHdUVmSmdCb2hLSmxT?=
 =?utf-8?B?VndpeEZkUjNrM0g5VHF2UkVpbFdtSFFkb0Z6Y0ZTbnZNNFBWM1pDNVk2R0FH?=
 =?utf-8?B?WGQzY0hsaURrYmlZZGFzZm5oY2c3TDZYekxvbEFxb1FoU1BJZnVDN0IxMVF3?=
 =?utf-8?B?dWh1YnFaYlJXZWc5R3Y0cVJrZHR0VTFncW5ESjJHSXJwRmVNNjhGRVFBbSs1?=
 =?utf-8?B?dWVwY2JnYXhiQm4rVWozcjFybGFpQU0wV0tDZWZsc1dZME8vRG9pTXRQN3J2?=
 =?utf-8?B?SjF2anBUdWpCNnVmd0M4c2tiTVR0dEVMb3BhWVRMdml2Q3pSNXJRUU1sUGxX?=
 =?utf-8?B?cWdUekFOVXV6cHIrSjljUGhLSDJkMWVFaElKcWdOZjFsZDNJZkEyK0U5VTAz?=
 =?utf-8?B?MkRic053WUxlSTZPbk1SdGpTcHlIYTVMQVFkTytnN3IzYlZxVWh0WFVIMW9R?=
 =?utf-8?B?WXlQTFRwMHh4amc5Y3RGOGxHT0RvWkx6NFFNU3UxNW9NWW1pb1VZYU1YOHBM?=
 =?utf-8?B?bFN5TWJvYTRPVGIrUms4UlkrT09CeUdQWlFFYUZYRWdvejdsVmtERkhtV3lp?=
 =?utf-8?B?RHRpR3p6ZE13amhFYU10U1pOY0F1NnNoeXJFbjA1ZS9jdnJqZ0pCb0JYcGk2?=
 =?utf-8?B?Wnc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 848ce84f-566c-409e-4921-08da84216fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 09:33:57.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cu6j92a+kkbYheSTSTtO0XmjZ+MBXUJTlPwu8QFAB+4jhVG2ZYg8QxrYOc5AUP6c528OUD9Uq63AjPw2KSG7PCFB99rXSJspL8HwNTxg0ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0020
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <EA39AAE2C22761488196B365588889BD@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDA5OjUzICswMjAwLCBNYXggS3J1bW1lbmFjaGVyIHdyb3Rl
Ogo+IEZyb206IE1heCBLcnVtbWVuYWNoZXIgPG1heC5rcnVtbWVuYWNoZXJAdG9yYWRleC5jb20+
Cj4gCj4gQWRkIHRoZSBjcHUtc3VwcGx5IHByb3BlcnR5IHRvIGFsbCBDUFUgbm9kZXMgdG8gZW5h
YmxlIHRoZSBjcHVmcmVxCj4gZHJpdmVyLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1heCBLcnVtbWVu
YWNoZXIgPG1heC5rcnVtbWVuYWNoZXJAdG9yYWRleC5jb20+CgpBY2tlZC1ieTogTWFyY2VsIFpp
c3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+Cgo+IC0tLQo+IAo+IMKgLi4uL2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLmR0c2nCoMKgwqDCoMKgIHwgMTggKysrKysr
KysrKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4bXAtdmVyZGluLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAt
Cj4gdmVyZGluLmR0c2kKPiBpbmRleCBmMDYyZmRiYjI3MTkuLmRiYzIyYjY3MmZiMyAxMDA2NDQK
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLmR0c2kK
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtdmVyZGluLmR0c2kK
PiBAQCAtMTQ2LDYgKzE0NiwyMiBAQCByZXNlcnZlZC1tZW1vcnkgewo+IMKgwqDCoMKgwqDCoMKg
wqB9Owo+IMKgfTsKPiDCoAo+ICsmQTUzXzAgewo+ICvCoMKgwqDCoMKgwqDCoGNwdS1zdXBwbHkg
PSA8JnJlZ192ZGRfYXJtPjsKPiArfTsKPiArCj4gKyZBNTNfMSB7Cj4gK8KgwqDCoMKgwqDCoMKg
Y3B1LXN1cHBseSA9IDwmcmVnX3ZkZF9hcm0+Owo+ICt9Owo+ICsKPiArJkE1M18yIHsKPiArwqDC
oMKgwqDCoMKgwqBjcHUtc3VwcGx5ID0gPCZyZWdfdmRkX2FybT47Cj4gK307Cj4gKwo+ICsmQTUz
XzMgewo+ICvCoMKgwqDCoMKgwqDCoGNwdS1zdXBwbHkgPSA8JnJlZ192ZGRfYXJtPjsKPiArfTsK
PiArCj4gwqAmY3B1X2FsZXJ0MCB7Cj4gwqDCoMKgwqDCoMKgwqDCoHRlbXBlcmF0dXJlID0gPDk1
MDAwPjsKPiDCoH07Cj4gQEAgLTQ1Myw3ICs0NjksNyBAQCBCVUNLMSB7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3Vs
YXRvci1yYW1wLWRlbGF5ID0gPDMxMjU+Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoEJVQ0syIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJlZ192ZGRfYXJtOiBCVUNLMiB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG54cCxkdnMt
cnVuLXZvbHRhZ2UgPSA8OTUwMDAwPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbnhwLGR2cy1zdGFuZGJ5LXZvbHRhZ2Ug
PSA8ODUwMDAwPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVndWxhdG9yLWFsd2F5cy1vbjsK

