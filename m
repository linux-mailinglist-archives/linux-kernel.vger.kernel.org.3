Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3337C524E72
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354520AbiELNll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354511AbiELNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:41:37 -0400
Received: from de-smtp-delivery-63.mimecast.com (de-smtp-delivery-63.mimecast.com [194.104.109.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B69E53B46
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:41:35 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2109.outbound.protection.outlook.com [104.47.22.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-fuWSDwRMNGaG6RWj_rlm3A-2; Thu, 12 May 2022 15:41:32 +0200
X-MC-Unique: fuWSDwRMNGaG6RWj_rlm3A-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0626.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Thu, 12 May 2022 13:41:30 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c52f:2a3f:8cf5:6144%4]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 13:41:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Thread-Topic: [PATCH v1] arm64: dts: imx8mm-verdin: update CAN clock to 40MHz
Thread-Index: AQHYZez2bqSZHJ9SC0Ckq6PGKt2xHq0bQB4A
Date:   Thu, 12 May 2022 13:41:30 +0000
Message-ID: <173a6bedbcf7be31c9bbc923c04c9af945b5c5c5.camel@toradex.com>
References: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
In-Reply-To: <20220512104019.19725-1-andrejs.cainikovs@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b001220-bfcb-4b4f-2341-08da341d1f31
x-ms-traffictypediagnostic: ZRAP278MB0626:EE_
x-microsoft-antispam-prvs: <ZRAP278MB06266E9A652C39E4C341381CFBCB9@ZRAP278MB0626.CHEP278.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: GPO4fZlfCwFddiJRNAaYAZgih9DYKR+Si2roTgQQWipe5cVLk2OX9DHet4MYHzUu+yCirGYNooXc4gdI0ubZsN69QoG1try4hLeF34SMyua8lOeSt5JCirSi6oWJQmrdq0peSrzhQxg31pPqDJd+RhI86iKZ0OmhhUJpSHAMLrJsZpKssJ7w8CoAlCLamziChzp27nChBYHeFt7uZjQNfGOPqpNGOR02vFQucJyEDk0/0MVaiWydPB/gSD5WwTpFGn7NWUU1t3C3jz1Fb0vkNILjzP66xBCQuTyDqYgf8ozdD2Sh1Y6p6uzlsoaARaTuYGGorPv7L7DllF/xDYxF1gFSzTFgK8bBpzCx+hp3qp4VnpJhyEJnjMap9Y5j78p5MAnWLuSJZV3KWtZZeaaQF4yL/5FzOgbRB807uIzEZSeqTA2/kRnhbnSMGIvLiiT8yoG2gMGB13NlNsV/cvLD9SZjb8NpoctyqxsZ3oQ8UfQXQg6B0JTbp378YZwOANOeRoeZ+JAfpUIYFtSWaiTjU+UeWe7sVD6l+sv9d1oyIhX07uMDkhOV3FLKdlqRC5iTloKNQRxuJnrBxqHEHOrl3G6PLWR5pwOZkyWgMc0T9eRpo1lhqWu8FZWKYvcjGqRw4atG2aPK2BOEcocEJaoooj0+y5Xz0SqM4jtyMlcdXi/gYU+QyGU29LLt5vTw8KDXUEBCZVp7/mLRPtfZ9m4duNroC0vXFw8SAXzLOMNqZ0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(136003)(366004)(346002)(39850400004)(396003)(376002)(2616005)(316002)(36756003)(186003)(2906002)(15650500001)(26005)(6512007)(54906003)(110136005)(64756008)(5660300002)(8676002)(83380400001)(122000001)(6506007)(38070700005)(66476007)(4326008)(71200400001)(86362001)(38100700002)(76116006)(66946007)(66446008)(66556008)(44832011)(8936002)(7416002)(6486002)(508600001)(32563001);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzdnS2h3YU1QamZwcERITFJkcmpwd1RRVUI5Q1lhSUpSVEt1MjdiRFpiZEZG?=
 =?utf-8?B?UmM4VVV5RU5SdU55ZUEvZ3Q1SnBCdmdJWXRyckFEb0pPM3lqZDQyZlN3dzU2?=
 =?utf-8?B?Yk91VU1aUkZkcjVMZjdTQS9uSEhqRlhmTGVvZ3QyS2Ewb1BzZmJrU1FvL1JE?=
 =?utf-8?B?SkplQmg1ak56TkJpYkRqRlRHcXN2Z1lsOFpFUFZGQVptbmF5Ni95Q0ZiZldn?=
 =?utf-8?B?WmlacTArNWk0eWhkWk1rOWxmNk01cXF3dUt4TWVJVzJEKzArSW1LcjcybUFD?=
 =?utf-8?B?OW0zTktUajNLUHhCcGZNeG16Vm9Penl5YlBRSDJDeFZDSGtDWG53UHZLbWhX?=
 =?utf-8?B?VDdXTjNXU00vOER2Q2R2alcxRmMvVEFtcjFtL014K25NcXFoZTZaUVhwMUdZ?=
 =?utf-8?B?clRVN3FkdEZoQWtrSzdZVTlRR0k2cmh3WUdlSStCdFQ5RWkxMnVCQjBQYWQ3?=
 =?utf-8?B?OVZQMTcxRlVuWVdNV0FEdGR6Z0wvMlpPSzRxMFJoQTJSM0l3aFBNMlpGM0Ny?=
 =?utf-8?B?NytrbnQ5azJsOTJLNmh5U29vZ0dnU2xWcTY1QVd2SjBFRmVyZVpzbDRCMXBL?=
 =?utf-8?B?NTRUNXJwL2NZSGdKWXZNRlF1aEorN21LV1lEQWZrUjM2VVFkL0M0TlVYaTJ5?=
 =?utf-8?B?dVBZdndsTCtJM0UxUFpQWU1zWno4Ums4MVpyS0VTTk1URTRrK21VTkVxN3h0?=
 =?utf-8?B?UXFIYUl0QmduVkNXMEtnZXMxbHZwb1JkaTNhYjJLU0tiUzhneS9Wc21Pb01t?=
 =?utf-8?B?RHh2bEM3M0lSVzkwcndUUXRydi9kdHhndWI1OHA3ZEVtaUczeWdXeFJOVDFZ?=
 =?utf-8?B?WW9Yai9BMnlxK2tMdyt4alpiczJJMEQycUlNVnh4TTNWYlR0cHR1UDN6SWlS?=
 =?utf-8?B?MnJhK09Eb0s5QjlYM3g2ZkpVQ1E3ZHdSNGxZY0hkSGp3ckkya09XeG1MR3lK?=
 =?utf-8?B?ODVHeS95dEcySXlUa1RwSHR6aytOUzZXZTlxd29lT1YzNGJ6bFc3SnNpZzR0?=
 =?utf-8?B?V2I2UXJld2VLQ0dMR0J4Y0NYWlFiY214bWV0b2duSzNmdzEzbVhuUzNiVXBW?=
 =?utf-8?B?Y0dRVE8zSVZTdFovS085bHF2S3lmSVJFOWNDZlM1bEZVeU53VlFTbC90WVJY?=
 =?utf-8?B?elU1b3J6NUxPQ3JybzZXdTFFZTltQmNSVnpxdUdTVXVBZ2dsbW16YVhJRUJn?=
 =?utf-8?B?eU9qTDA5R1oyWFBtdzZDaTFjVnpvaXlKTXhBNnRkdXFDcTY0U0FyTmcyTmZw?=
 =?utf-8?B?UkRvbXRzaGVhbS9TWFJCQUsySHF5dE1EeFh4NmpLOXNqZTU0eVpCcnhkN2JO?=
 =?utf-8?B?WmZyZFVkL29LenhTaSs2cFdqRVpXeXRmdkMyN0E1Q1JGT0hjOEhxcEpIL25x?=
 =?utf-8?B?Yk4rNjZjaXhHN1RUL1NTbHZ3L3ZqSzBuMWgvQ1NXTktBY0Jmd0E1YnZCUzFV?=
 =?utf-8?B?N0ZkZXl4YjJMMk5vSkJRZU4vRENxTkZ3K1FTZVNlZXlWTENFdGVXOUV5UDY5?=
 =?utf-8?B?M3BRdS94UkZjcUdxWjd0UUxxTFhUVVRxaXNGNGM2d25lNitkNERPc25udGlH?=
 =?utf-8?B?UVE0dlBWMmpCWUxkcWpyK3YwelZZOFRqMEY0dVZmS3JjbXZDSFVEUGtCVm5S?=
 =?utf-8?B?WDlrVEtTdndzc3c0MWdBYWNVSTN3RjU5THJaVXNjNC9YcGd3SDcvTS90bHMx?=
 =?utf-8?B?c09aYnV1c0ZFS3NESUtwT1poZm0xNUt5Zkxud2k3a2dCZkdPSUZjaGJnYldD?=
 =?utf-8?B?YlVzMEFuL0tvMkhTemw0eGE1WXBjSjJVdU1KaGxyKzNPMGRxTGNFMHdsbFdH?=
 =?utf-8?B?N0VUWi9IcFUrYlg2WmQydTVaeU1WdlVDRmR1OW5VWHgydU5nYjlkSExrdzJQ?=
 =?utf-8?B?a2p2WlduSy9DRkRPejZKUGVFRS9GbU5KZnAxcnByUVJ1a3NCRkN1TmY0Z3Nv?=
 =?utf-8?B?a0VBcVgxOHFYMzIzeGxzQ2hFdUx2L0Zla3l6bXlpaHNFeHFiUHFETEM0S3dL?=
 =?utf-8?B?UlZSamVZemRuY1lNZUxLdXRZWlA2WXIwWE95bHlYOFhwenk0R09BbXBHNVEy?=
 =?utf-8?B?Y2FYOTQwRTErVU5kMkFFTFQvZlFGRTNrT1grRUtCbzM1UGJoMmMybUtJUGpk?=
 =?utf-8?B?a2VTRTBZTGs4dzE5MG5FaFcrWDN1dHl6alZ2TXZUMmpIQVJwRWhzUTBIcDFF?=
 =?utf-8?B?Q1pxWVUzOHdpa0pLUUVjL0JKdXZzdVdCQkJIN0RyT3ZRQ1ZRMXNtVWdCYW9B?=
 =?utf-8?B?OTQ1QXhCdHZtSTdmOWszdXE3S25aOU5hanNpdXFmNWNZdU90VVg4TmZkRTMy?=
 =?utf-8?B?TVU5NU1vZ2dUSW43Ly9WbFhsemVwdVNSR0paRW9NMUkzVzUxVGt1aFViZXl0?=
 =?utf-8?Q?qutzUIjnSz9DQdBZ0ZLfZcpf/PTNXmh72+/LK?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b001220-bfcb-4b4f-2341-08da341d1f31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 13:41:30.7887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KeNL22PZyXLcEdwQqVfNiM0jTaSq1Znpvs1/jQup7EfA6+7u8PX67OAMToQ0IMG26yMujUaLT9bYsJVTKtX9RutRrNzWfPKM00TmeLlSzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0626
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <780653C0CBF2B24EA5C5A4A0AFD6BB19@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA1LTEyIGF0IDEyOjQwICswMjAwLCBBbmRyZWpzIENhaW5pa292cyB3cm90
ZToKPiBVcGRhdGUgU1BJIENBTiBjb250cm9sbGVyIGNsb2NrIHRvIG1hdGNoIGN1cnJlbnQgaGFy
ZHdhcmUgZGVzaWduLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlanMgQ2Fpbmlrb3ZzIDxhbmRy
ZWpzLmNhaW5pa292c0B0b3JhZGV4LmNvbT4KCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2lsZXIgPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4KCj4gLS0tCj4gwqBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg4bW0tdmVyZGluLmR0c2kgfCA2ICsrKy0tLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLQo+IHZlcmRpbi5kdHNpCj4gaW5kZXggMGQ4NGQy
OWU3MGYxLi5kMzA5YmMwYWI4ZjYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
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

