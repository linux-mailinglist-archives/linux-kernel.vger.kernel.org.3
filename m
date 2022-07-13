Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACED572FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiGMH5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiGMH5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:57:16 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.109.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F394DDA995
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 00:57:15 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2049.outbound.protection.outlook.com [104.47.22.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-33-_M00SPT-O4CMuQhu70jn3w-2; Wed, 13 Jul 2022 09:57:10 +0200
X-MC-Unique: _M00SPT-O4CMuQhu70jn3w-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0082.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Wed, 13 Jul 2022 07:57:08 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c1d:4ad8:1fae:ae46]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8c1d:4ad8:1fae:ae46%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 07:57:08 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: update CAN clock to
 40MHz
Thread-Topic: [PATCH v1 1/2] arm64: dts: imx8mm-verdin: update CAN clock to
 40MHz
Thread-Index: AQHYksgvnx0ILUdEQ0iQZ7kCRUtdMa179rwA
Date:   Wed, 13 Jul 2022 07:57:08 +0000
Message-ID: <aabe30ae3e46d2e5be2d5d81dabff05d09c7370c.camel@toradex.com>
References: <20220708124205.59564-1-andrejs.cainikovs@toradex.com>
         <20220708124205.59564-2-andrejs.cainikovs@toradex.com>
In-Reply-To: <20220708124205.59564-2-andrejs.cainikovs@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0ab31ac-6918-4d74-a8d3-08da64a54925
x-ms-traffictypediagnostic: GV0P278MB0082:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: XxzWNuZpCWZhA5a4aezI/Rpk24Kj6wWxPDPoJQMkGp0vX/Z291Rtf0LPYTbg3Bsblg17Sg5oHMHj53nj9DHXWKY5qokac9k7ximCLgtcjQ/o3SQ7C698FsIbwMgrmSeLexSjx3xHPwKVazROrrZUwBOJEe8TvebFccrwno8XPB/l/Dc5ZJSoRNZMXbxc3UOpxKCwKRlUsCwuF/XHh/vSL/vIhoJaT9YDp0/7T+WYqpAad4uWsgk/4RoStVZls/hcbOMXC/LhNZcjBuxLI5fBDGObJOY9AWBQai7q39Y1+X5N5YDIT2QbNN7kzMY2TAOOPq5qv8kSTBL2vKC3N49shK+3OVffeyQGDoic/iNhDIJ+cFNnrlqhhTWB8JZoadQmffBG2YOxJMT8RjX78+s5sO5mhnTcoO1sR01aBv62bh66CXpV9jJU4GqhujDprTdfNvzTawlucxZWMRaE4926HssMgp/kykAxzAe4EF5h635b7zSvaXj4NHsDtCmVgBzcAqIDZQnjDiOoQw/YwK26/OUMg9k9yCX4nMqTCOxH2Ef6v4LawT7ZDYneTkqPiYArnKJQxQ81kWTYkiskCYx0qyblaaFm4lQEnTUvBtgS11TEIpq67MRm2uj4gObvr8OYXUt2NSE9U24ZAdTbRfXUAepfWASsysM/NjbQGfYxGjbCVkwHdvzC0b58KFDs2tJR/3liqFeXx8MHsrcCp1xcmXke7Cq/c14QI/ePz5KierIgEseMBVUG8fC/kb/7QLgNbTVrmK0uei9aVldjDWPHmkYmeY6WE9sZhwM8ocI/4fyPIg5hPqnar5GNNLLVcdVogD0SaOreXnJSlXHN6KwAFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39850400004)(366004)(8676002)(66476007)(66446008)(64756008)(66946007)(83380400001)(86362001)(4326008)(76116006)(2906002)(66556008)(15650500001)(36756003)(122000001)(38100700002)(5660300002)(8936002)(38070700005)(44832011)(41300700001)(316002)(478600001)(107886003)(6506007)(6512007)(6486002)(2616005)(71200400001)(54906003)(7416002)(186003)(26005)(110136005)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU5DTkVxeXk1eHI0a0kwaW9oWmMvRWNBdTdoclQza3AxcHVTaDY1RUhNQ25S?=
 =?utf-8?B?M3FCRC94Z2xRRnpnQ2Fpd1V6NnlZZ2dyeTI2cUs1c3VobFNMZmtEMlBhakV2?=
 =?utf-8?B?V090dFpqT2JtS3p4em1xWDVOVXFxZitsNSthcEN5NnFjRnJHb0I3b3NVaHI5?=
 =?utf-8?B?bGZqMHVtU1pOTW9QQ0t6VHRmQjR6NVZmRjdOZjNleVdGWFF3VkVXVHhrSmlO?=
 =?utf-8?B?TVM3U1FYVkYwU0lQUFlTdlFFZDg3V2FmcjJ4NFpmVTFyRGVlQ2g2TnFzTVls?=
 =?utf-8?B?WUo1cUw4Wmo5Y2gvUnlYY0swQVBZN2taYmg0VzNMZVRoZmpiY1JvTlJrZDNE?=
 =?utf-8?B?V05sUEZxRlBvME9WdmgxdXJDS2hkcVZ1TFRlZVFkRXlkL1B5TCt5NS9XbW1J?=
 =?utf-8?B?VTJEUlRqd3Vvc0lvV0p0VE53WTk3aXFlc2xaek1mRU11dHdRUGN4L2ZMQlFw?=
 =?utf-8?B?SzNKOVNpaGRmbUxqWnRyMEhqZnAvNEdHUlcweFN4aHFaZlgxSVBqQTk3WEEz?=
 =?utf-8?B?VVFKOTAzWURlOXh0V3pBRytFVWoxaWFVY2VDVXppQTQ5Z0psZ0lXWktMMjJE?=
 =?utf-8?B?WUdlQTFyZUx5K1BxTFVxT28xMHdGQUtZbmRPM3dHK01IRzZsaW1kdVpldVp1?=
 =?utf-8?B?NnhVdlNVWkZXSnBRKzdNNE9lSFhYc3N5NzBhdUJOenhJS1BselJMVmk1dkVk?=
 =?utf-8?B?YS9rZjIzcXIxcjNtelZQV3FZWnZrczc3TU5LWnpJa2NMTm1tUG04NW52NC8w?=
 =?utf-8?B?N0dpS3g1TmxDZ3QyVVZHb2pTbGovUnV5RW5WUXY2ZTAwTDlBNUlEeXp3TUJP?=
 =?utf-8?B?WnhwR1FpeVEySVNXeU8yOWtTdW9VTVlDSElFTk1jQ2N3TjdIWmxxeklUTkE0?=
 =?utf-8?B?eEVNNldQMkRRNzZjU0pnRERGSWgxRm1UejBhYmtKa3J0NXhqVmJzMDVweXJN?=
 =?utf-8?B?RWJmeTFQN0JneHlseTltT2crQzJHclZLcWFHamdlY0FwM1gwRUNQMmJ6QWhy?=
 =?utf-8?B?bWJrMXY4YzNGVU1PVkpkbkxBTWNPWi9scHRGWFYxUXBGaVYyZ3Ivc3lqY25L?=
 =?utf-8?B?NkVOU0lhU0FjOUxrMnlJQWZsbGEzU2xNbkY4RlNpM1JxKzZZYUZhaXVFL2tH?=
 =?utf-8?B?TUJrUGRJWCtpdXNsZ3ltV25yRkVzNnFmekNXcGNqbGxFQmFSK1NrcGlrUmMy?=
 =?utf-8?B?UUk4aC9VWldvZy9VQ2srOUc3d2JyTGlSTXhrR0dxeWl4cGJndWgyRDltSU9L?=
 =?utf-8?B?UW12UjlKQWZ2ZE5vZDJuRWJ6Z1BRbTBNQTZERFovZStTNkhuTjJnYm1FQVBJ?=
 =?utf-8?B?MGkvS0JycHpuZ3FVZDhiVGlTaXVaZkE2YmRTVEIvWkJqZHBQSlVpZFlzdG01?=
 =?utf-8?B?MEtXcDhjaVdZZWhtUjJrSjN2U1RTRUl1OTgwTmJRZUFMdzZZOWMvOGVBMm13?=
 =?utf-8?B?c0tkMDhQU0p2Vkh1WWFtSnBqd0I0eURlR1F0d3VhMy9tT3pBVWpHMnVxL0ZG?=
 =?utf-8?B?MzZSdFZTajJpM09UYzg3TzJmbUR0QlFQdXJkNmU2eTVab2Jac294aHVEWVJ4?=
 =?utf-8?B?R2IyOTVDY2dpcjJkdXJOSVVZZ2MrU2VTMEpaWjU0ekZHS1BBbS9pTDVNcDhM?=
 =?utf-8?B?aUxLcFQ3L3RnWlNMVXVtSzBHY0xhcDNEV0VYSm1DZFh3VzZ0ekpLeEZPcFp4?=
 =?utf-8?B?WVRZcTJvZHdBa2ZTM1dFYUs4aFA4NCtSYUlWZGppdSs2K0RUZVlYUFRqTVIz?=
 =?utf-8?B?eVhBbGlwRG5GYjBYazFRZG5uazA0VWhKaDJTY01jOUV6cEY3UDNUWW9jbVdO?=
 =?utf-8?B?T3FRb3ZYU2lyaUdmWFQ2dTR1aEI1aE96cWRLa0lGR2ZKVjNTZ0RDY0tGUDRr?=
 =?utf-8?B?a2N0Y3Yyd2hBaEdwWlRWMUREM2lrWCtMcURkM1ZqVEtlV0FnK2tpZ3ZzVWZO?=
 =?utf-8?B?WGZvMWh6NUlzUC93ZWx4L0JrK3hnc3B5dzczMXVKRWR4dElIZU13OC9CY28r?=
 =?utf-8?B?MERXOGQ2QU1kMmxNc2p6ZFl0Q2F1M1NFN2dJMXViR00vaVdrMy9HcjlzRUtn?=
 =?utf-8?B?cEFsSFhjSk5ydjUyZnNZVC9qQVM0RVFSaml3WFgxcUVvY2wvU0F6WUFCOE0z?=
 =?utf-8?B?MnRFNDE5UU52UHBPLzk5cWpDVmtZajBJUnhkLzBaTC9kMllzd2xiNmN4OHds?=
 =?utf-8?Q?I86UExP5n/hzGYfQODgEM9Q=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ab31ac-6918-4d74-a8d3-08da64a54925
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 07:57:08.5307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wi92h6qgqBfdYPQ4l+S+yROmiRrDMDbD998pfXRadLZqXaIt+kiXhn8TUNZTU7YW92wZeSQKKZa3qCddtmr+Vk1874MGTzOLm/8x47FxPA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0082
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <697BCCB5DF815742A5B803769AF4D87F@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA3LTA4IGF0IDE0OjQyICswMjAwLCBBbmRyZWpzIENhaW5pa292cyB3cm90
ZToKPiBVcGRhdGUgU1BJIENBTiBjb250cm9sbGVyIGNsb2NrIHRvIG1hdGNoIGN1cnJlbnQgaGFy
ZHdhcmUgZGVzaWduLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlanMgQ2Fpbmlrb3ZzIDxhbmRy
ZWpzLmNhaW5pa292c0B0b3JhZGV4LmNvbT4KCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4KCj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLQo+IHZlcmRpbi5kdHNpCj4gaW5kZXggZWFmYTg4
ZDk4MGIzLi4yODQxYzZiZmUzYTkgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpCj4gQEAgLTMyLDEwICszMiwxMCBAQCBiYWNrbGln
aHQ6IGJhY2tsaWdodCB7Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgLyogRml4ZWQgY2xvY2sgZGVkaWNhdGVkIHRvIFNQSSBDQU4gY29udHJvbGxlciAqLwo+IC3C
oMKgwqDCoMKgwqDCoGNsazIwbTogb3NjaWxsYXRvciB7Cj4gK8KgwqDCoMKgwqDCoMKgY2xrNDBt
OiBvc2NpbGxhdG9yIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGli
bGUgPSAiZml4ZWQtY2xvY2siOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2Ns
b2NrLWNlbGxzID0gPDA+Owo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9jay1m
cmVxdWVuY3kgPSA8MjAwMDAwMDA+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBj
bG9jay1mcmVxdWVuY3kgPSA8NDAwMDAwMDA+Owo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoGdwaW8ta2V5cyB7Cj4gQEAgLTE5NCw3ICsxOTQsNyBAQCAmZWNzcGkz
IHsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBjYW4xOiBjYW5AMCB7Cj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtY3AyNTF4ZmQiOwo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjbG9ja3MgPSA8JmNsazIwbT47Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrcyA9IDwmY2xrNDBtPjsKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmdwaW8xIDYgSVJR
X1RZUEVfRURHRV9GQUxMSU5HPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfY2FuMV9pbnQ+Owo=

