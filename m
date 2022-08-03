Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A166B589409
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbiHCV0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 17:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbiHCV0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:26:37 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A8313FA1E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:26:35 -0700 (PDT)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2042.outbound.protection.outlook.com [104.47.22.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-8-4bgh4LgDOy-A8FX46d3XWg-1; Wed, 03 Aug 2022 23:26:32 +0200
X-MC-Unique: 4bgh4LgDOy-A8FX46d3XWg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0443.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:31::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Wed, 3 Aug 2022 21:26:31 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cd78:5df6:612c:455f%2]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 21:26:30 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "dev@pschenker.ch" <dev@pschenker.ch>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Thread-Topic: [PATCH] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Thread-Index: AQHYnaCBpxVIgTEi90SaHb3zjZW4/K2aBSwAgAO+9wA=
Date:   Wed, 3 Aug 2022 21:26:30 +0000
Message-ID: <48e83d4f3755ebef722734f65777822529ab08f9.camel@toradex.com>
References: <20220722075600.10943-1-dev@pschenker.ch>
         <7ef6812e-5732-e8c7-e796-f568de4eef62@kontron.de>
In-Reply-To: <7ef6812e-5732-e8c7-e796-f568de4eef62@kontron.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93ec190c-ff7a-4dc8-62f0-08da7596d529
x-ms-traffictypediagnostic: ZR0P278MB0443:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: IKIwNSTtQpMvZi73E0MzyZXHyTpU0xhl1OoEUoE0+EERSiV6XiT4OV3IxBn2sTpSl3vxIV3RnUM85350EEuyMWlYpnXMjvVH6mWl9JArQ/EvoNcK1OYkEbWLGL/eT7/R1x9y0zfKFoNrHYC7YclPLF8VlS1omdxstcehhnPWValgaaZuLt/OcQdIfxEzwBl7HVOKzTYFpcq++CXUuoTczvZWnTCa2a5wUER6GBCMaiWEfk8YGyuhJujdqitEYXgOympRfD5vClTdYuEyTWK4aYXCIa4mcC80WWlixlPvXuIUaL0XEvRPsk+r/QVoZOX4ZoVisAv8YtPf3xHLvdGRcY7pHVT8jwvPc8kruKr6VCHNbmJVoMBh1BpWR0xa8wSwwOE9rVJUb+VedIWQWTDbRWwiTL/QfhD5Jpo4lgWv87SKwaCZg5KEVj6DVWI/t9PjN1joCWJERniZucInvxfDumGaK0JNi1+T9nP/mbF8XaIV/FtWIjk4wR6INuH+OgVxH3KEJ3DVdsv/jlthdc7nsHLlhNvDLD1xHriM7ACl6yt0icWcu6G5ysK29wgdo+Tgoms/CU6e8QvswUPmkRsynLTGB+NtpRgpfOsuczlZvpZaOFC/HPVr7wz+WGtS86s3aqNixu+3bfsNf2TWzhv94hUVeabWmvIn4r7jRG5tfUbWw4MaUUPP0wt6c3QmqIY7A7NRgsFjk/owy36nnsfXN12xfdZ2i8t6nkOmjjdUb8u7PO2woGLfAMzEyMFCDDYvG7nKKWOiWVthXoFS13YVAzjsHcReGjhNtceBJiVvg9Y4VrRk8eEnxNQ2K9EqTN8x40nJ3HBZtpOxJtRNS3jirw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39840400004)(136003)(396003)(346002)(376002)(8936002)(316002)(5660300002)(7416002)(2616005)(83380400001)(186003)(64756008)(36756003)(8676002)(44832011)(4326008)(66446008)(66556008)(2906002)(66946007)(66476007)(76116006)(54906003)(6486002)(966005)(478600001)(110136005)(71200400001)(6506007)(6512007)(26005)(86362001)(41300700001)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFJPUm1HN1hHdnBjcEFpc0xYQ085SEdsRStIa3d1bUFFSTU4UnIrbWNnK3ly?=
 =?utf-8?B?cXdqcmNseTJ0SzkvN2Y1MWhEdVpoVzQyditSOVAxNU94a0hKVFJYYXJteGg0?=
 =?utf-8?B?Z1NrSG1BOStLVlIrUjhSd2FRZ0xEMEd5SldXSEZQNzdTY3M0Y1IyWUJURFcy?=
 =?utf-8?B?UGVNWFdWTWtEWUE3d09WcjE1Wlc5WHR4TVh2UGxQdmpVbTdnL1pUU2s5QitZ?=
 =?utf-8?B?Vk9STzRSQ3dkbFpNMVByQWtxcXVOSkpQMnB2bXVtRE0yb0JBZk5xcURudmZw?=
 =?utf-8?B?dnNHcUtlRlZpZ3dEU25TTElNR011OWl4OUY5WEU3YkFVa1h5dVdJVmVhM0lC?=
 =?utf-8?B?dUY2aW5UVHQyaUlLT1ZObTdEQWNpZUMwbkVpMjFtVHRHTTBGN21ucVYvL2gz?=
 =?utf-8?B?dXM2NE5wR2V3TmZLZkxEUXVQN2YwTXRYRUNCSzZGSlFIMnBDbkViOGg4NjN0?=
 =?utf-8?B?WU13R3p2ZmZwWmZrcDc4cDhMUUUxTkR5eTMxcVd1czViQlNxU0Fmei9kMWVs?=
 =?utf-8?B?bTFWQUJZZk4xQXROZUw2RkxtcHEreXhDS0QwcEQ4c0ptWDJBTkdyRXJaa2Vo?=
 =?utf-8?B?VW81SEMyZngwelJiWWJ5Y3hkenFhOWduWUpQcWpsbk8ydWhlcXN1eHV1RXZN?=
 =?utf-8?B?V0w3MitVNFRNTDU2MHBCcks3NytlSFJCdHJmZjlESWRNSXBFckZkeUFuRnYv?=
 =?utf-8?B?b05ZanVNSzIraDJOamJZTFc2cUJLN3hlVTk3dE10akxsVEdkVnpEbnlCbGpr?=
 =?utf-8?B?OFNMc2ZWZmFHazBCaW1PWDRDSW1Td3NxR2VNS09KYWdKZ1dsWUNnVVlJU3Vt?=
 =?utf-8?B?Y0pSYXlMUG8ya2kyU2FUM1FzSVJwRG90RERrdFJqTE1UYXlleG9ubVRLVUxQ?=
 =?utf-8?B?WGowTmFxd2lZNFA5TWpOM2tYaGRvZThnRE1PVG9tVFlVWHR6VmJrRFFlTUht?=
 =?utf-8?B?ZitUSk1Fb3R2bjZTZ1hNNkNlV2RLeWJXNzBvOEZWdHpRRjVCTlZlUVBHakZ4?=
 =?utf-8?B?MFB5Sy8wQ2xYSTZuYWx6MTQ5MTJxNGllellMRHo0OGl1cHhMUXNsVXVyOGRE?=
 =?utf-8?B?M1hYZi9kWTNDVWtJQVhVTzB3S0l0c1l5Q1V4NkU4elVaWGVmVElOSmxXODVB?=
 =?utf-8?B?M1htY3htYmoxUytnblRxQ1g3cDJoTHlMVUpvVVFtVEhPV2JXZ01hODdRdHRO?=
 =?utf-8?B?VGtkNmhnZDZpY2syUnRqblR4VzNybW1ReXFBNldjejlGcVRCQk9CdXczVVpr?=
 =?utf-8?B?N2xWSkRYMFlsTXRSc0huV3o0ZzNyL1V6ZjF1L1REY0ZWMXpzYkdBd0ZHYkYy?=
 =?utf-8?B?M0VMUnZYbFZnS2lLMDZua2E4SjJoVFJyaTEvOExNUk5TdVgyWDJoaG16bnZY?=
 =?utf-8?B?U091SEsvRU1TSTlTRjZBTW4zZS9DSTcrbG1oa1hVSDJycXVGR0pCQmdpWm9J?=
 =?utf-8?B?Wkt3MFl4T2lsbGx3cnlFSjhyRytUSzBqbEpaQ05IMlhwU0lkOGxJVHVnRkll?=
 =?utf-8?B?bEZkYzMxYU0zb2l1N0RGWEFCNElSMDJHeXdBT1hZSUo1NGxQWGxiNWp6Mk1K?=
 =?utf-8?B?SGs1YXJSUHY2dmJjOGV1U3c0RGZQKzJDYzlOQ0xaZWFZMXl0YjZkQURyZGxi?=
 =?utf-8?B?RXlXeENiOGtjY1N1blBPeFhaQmlvSVNPZkJhcnJ0bDZQYkx4L1BUMUdFWkFn?=
 =?utf-8?B?WTd1eFQ5ZmlVbzhGeDM0b2FNM3BoMDk0YVp2YXZqMkEvT0U4UHJJZlhTL1BH?=
 =?utf-8?B?UFBjM3MwVkw5UTVDMHpQRmxPTHpBNC9LUlBzanhRWS9JSnoyajVvWGFsNGhv?=
 =?utf-8?B?eVBrRCtMUEtCT3Z3NUJHcVJuSkN4bnlGYlJQSHZPNWRrS2hNYU0zOFA2Rmlj?=
 =?utf-8?B?d3RzcHF2cFVOallteDVPZVNaMnVGSlVCcFdyaTJpRUE4aFdLRlhmNDQ3Qzdn?=
 =?utf-8?B?cEcvK1hHRnh0aEtTL3crUVlwQVZ1QUFuWE5SZElTaEtGRzNkbkdpTmcyNnQ3?=
 =?utf-8?B?RHFPS1ZrZWpNWlBjOTY3d1JjZm5oNEg5RUx3Vzd1dTJPeGdEU1VxUi9WWHhG?=
 =?utf-8?B?NGtmMmo0NllCanVndytwQ0E5bitYK1dpek5EUkFyY055MVcrQ3VCQTdQaW9q?=
 =?utf-8?B?cytPcXJ5eXBtUS9ZUnhJaHliUFpITER3UTF6OHJFWGdIZWdGWHo5eFc5eWtB?=
 =?utf-8?Q?VN7LnAL1GCK9rWs6C+KJgyg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ec190c-ff7a-4dc8-62f0-08da7596d529
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 21:26:30.7836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ix5dgA+B6RgpI/uwDk/shoGGY4iGDPdyvcL/x2UlrqmV4adsrU75HKlEjuz/SxgCE+Me7Msp1iZNx1MVw48Ap00aWpDwI3KJaaism7iW1wA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0443
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <C5712B808B9FD949AC4D794B29BAD11A@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlcg0KDQpBcyBQaGlsaXBwZSBpcyBhYm91dCB0byBnbyBvbiBoaXMgd2VsbC1kZXNl
cnZlZCB2YWNhdGlvbiBoZSBhc2tlZCBteSB0byBoZWxwIGFuc3dlcmluZyB5b3VyIHF1ZXN0aW9u
cy4gQXMgSSB3YXMNCmFsc28gaW52b2x2ZWQgaW4gdGhlIGluaXRpYWwgYW5hbHlzaXMgb2YgdGhp
cyBpc3N1ZSBJIGFtIGhhcHB5IHRvIGhlbHAuDQoNCk9uIE1vbiwgMjAyMi0wOC0wMSBhdCAxNDox
NCArMDIwMCwgRnJpZWRlciBTY2hyZW1wZiB3cm90ZToNCj4gK0NDOiBMaSBKdW4sIEphY2t5IEJh
aSwgTHVjYXMgU3RhY2gNCj4gDQo+IEhpIFBoaWxpcHBlLA0KPiANCj4gQW0gMjIuMDcuMjIgdW0g
MDk6NTUgc2NocmllYiBQaGlsaXBwZSBTY2hlbmtlcjoNCj4gPiBGcm9tOiBQaGlsaXBwZSBTY2hl
bmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gVGhlIFZlcmRp
biBpTVg4TSBNaW5pIFN5c3RlbSBvbiBNb2R1bGUgZG9lcyBub3QgaGF2ZSBWQlVTDQoNCkl0J3Mg
YWN0dWFsbHkgdGhlIElEIHBpbiB3ZSBhcmUgdGFsa2luZyBhYm91dC4gVkJVUyBpcyBjb25uZWN0
ZWQganVzdCBmaW5lLg0KDQo+ID4gc2lnbmFsDQo+ID4gY29ubmVjdGVkIG9uIFZlcmRpbiBVU0Jf
MiAodXNib3RnMikuIE9uIFZlcmRpbiBEZXZlbG9wbWVudCBib2FyZCB0aGlzIGlzDQo+ID4gbm8g
cHJvYmxlbSwgYXMgd2UgaGF2ZSBjb25uZWN0ZWQgYSBVU0ItSHViIHRoYXQgaXMgYWx3YXlzIGNv
bm5lY3RlZC4NCj4gPiANCj4gPiBIb3dldmVyLCBpZiBWZXJkaW4gVVNCXzIgaXMgZGVzaXJlZCB0
byBiZSB1c2VkIGFzIGEgc2luZ2xlIFVTQi1Ib3N0IHBvcnQNCj4gPiB0aGUgY2hpcGlkZWEgZHJp
dmVyIGRvZXMgbm90IGRldGVjdCBpZiBhIFVTQiBkZXZpY2UgaXMgcGx1Z2dlZCBpbnRvIHRoaXMN
Cj4gPiBwb3J0LCBkdWUgdG8gcnVudGltZSBwbSBzaHV0dGluZyBkb3duIHRoZSBQSFkuDQo+ID4g
DQo+ID4gQWRkIHRoZSBwb3dlci1kb21haW4gJnBnY19vdGcyIHRvICZ1c2JwaHlub3AyIGluIG9y
ZGVyIHRvIGRldGVjdA0KPiA+IHBsdWdnaW5nIGV2ZW50cyBhbmQgZW51bWVyYXRlIHRoZSB1c2Ig
ZGV2aWNlLg0KPiA+IA0KPiA+IEZpeGVzOiA2YTU3ZjIyNGY3MzQgKCJhcm02NDogZHRzOiBmcmVl
c2NhbGU6IGFkZCBpbml0aWFsIHN1cHBvcnQgZm9yIHZlcmRpbiBpbXg4bSBtaW5pIikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBTY2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRl
eC5jb20+DQo+IA0KPiBJJ20gcHJvYmFibHkgaGF2aW5nIHRoZSBzYW1lIGlzc3VlIG9uIG91ciBo
YXJkd2FyZS4NCg0KRG9lcyB5b3VyIGhhcmR3YXJlIGFsc28gTk9UIGNvbm5lY3QgdGhlIElEIHBp
biAoc29ycnksIFBoaWxpcHBlIGluaXRpYWxseSBjb25mdXNlZCBpdCB3aXRoIHRoZSBWQlVTIHBp
bik/DQoNCkJUVzogQWNjb3JkaW5nIHRvIGEgbGVuZ3RoeSBkaXNjdXNzaW9uIHVuZGVyIE5EQSB3
aXRoIE5YUCB0aGUgSUQgcGluIHdvdWxkIG5lZWQgY29ubmVjdGluZyBldmVuIGZvciBob3N0IG9u
bHkNCm9wZXJhdGlvbiBidXQgb3VyIGN1cnJlbnQgUENCIGRvZXMgcmVhbGx5IG5vdCBhbGxvdyBm
b3IgdGhpcyB0byBiZSBlYXNpbHkgZG9uZSBldmVuIGp1c3QgZm9yIHZlcmlmeWluZyBOWFAncw0K
Y2xhaW0uDQoNCj4gVGhlcmUgd2FzIGEgcHJldmlvdXMNCj4gYXR0ZW1wdCB0byBmaXggdGhpcyBn
bG9iYWxseSBmb3IgYWxsIHRoZSBpLk1YOE1NIGJvYXJkcyBoZXJlOiBbMV0uDQo+IA0KPiBVbmZv
cnR1bmF0ZWx5IHRoaXMgZGlkbid0IHNlZW0gdG8gd29yayBhcyBpbnRlbmRlZCBpbiBteSBjYXNl
IChzZWUNCj4gZGlzY3Vzc2lvbiBmb3IgdGhhdCBwYXRjaCkuIExvb2tpbmcgYXQgeW91ciBwYXRj
aCBJIHdvbmRlciBpZiBub3QgaGF2aW5nDQo+IHRoZSB2Y2Mtc3VwcGx5IGZvciB0aGUgdXNicGh5
bm9wIGNhdXNlcyBwcm9ibGVtcyBpbiBteSBjYXNlLiBEbyB5b3UNCj4gaGFwcGVuIHRvIGtub3cg
dGhlIGVmZmVjdCBvZiBhZGRpbmcgdGhlIHJlZ3VsYXRvciBoZXJlPyBJIGRvbid0IHNlZSB0aGlz
DQo+IGluIGFueSBvdGhlciBpLk1YOE1NIGJvYXJkIGRldmljZXRyZWUuDQo+IA0KPiBDb3VsZCB5
b3UgdGVzdCBMaSdzIHBhdGNoIGluc3RlYWQgb2YgdGhpcyBib2FyZCBzcGVjaWZpYyBmaXggYW5k
IHNlZSBpZg0KPiBpdCB3b3JrcyBmb3IgeW91Pw0KDQpJIHJlYWQgdGhhdCBhbmQgZG9pbmcgc29t
ZSBtb3JlIHRlc3RpbmcgSSBqdXN0IHJlYWxpc2VkIHRoYXQgZGV0ZWN0aW9uIGRvZXMgaW5kZWVk
IG5vdCBzZWVtIHRvIHdvcmsgb24gdXNib3RnMQ0KbmVpdGhlciwgZXZlbiB0aG91Z2ggdGhhdCBv
bmUgaGFzIHRoZSBJRCBwaW4gY29ubmVjdGVkIGp1c3QgZmluZSEgU28gaXQgaW5kZWVkIHNlZW1z
IHRvIGJlIGEgbW9yZSBnZW5lcmljDQppc3N1ZS4NCg0KT2theSwgZm9yIG1lIExpJ3MgcGF0Y2gg
YWN0dWFsbHkgZml4ZWQgdGhhdCBkZXRlY3Rpb24gaXNzdWUgb24gdXNib3RnMS4gWWVhaCEgVGhh
dCBpcyBvbiBvbmUgb2Ygb3VyIGNhcnJpZXINCmJvYXJkcyBlaXRoZXIgRGFobGlhIG9yIHRoZSBW
ZXJkaW4gZGV2ZWxvcG1lbnQgYm9hcmQgd2hlcmUgdXNib3RnMSBnb2VzIHRvIGEgcmVndWxhciBm
dWxseSBPVEcgcmVzcC4NCmRldmljZS9ob3N0LXN3aXRjaGFibGUgVVNCLUMgcG9ydCAod2l0aCBJ
RCBhbmQgVkJVUyBwaW5zIGJlaW5nIGNvbm5lY3RlZCkuIHVzYm90ZzIgY29ubmVjdHMgdG8gYW4g
YWx3YXlzDQpjb25uZWN0ZWQgVVNCIGh1Yiwgc28gbm8gZGV0ZWN0aW9uIGlzc3VlcyBldmVyIHRo
ZXJlIGFzIHRoYXQgaHViIGhhbmRsZXMgaXQganVzdCBmaW5lLg0KDQpOb3cgdGhlIGlzc3VlIFBo
aWxpcHBlJ3MgcGF0Y2ggYWRkcmVzc2VzIGlzIG9uIGEgZGlmZmVyZW50IGN1c3RvbSBjYXJyaWVy
IGJvYXJkIHdoZXJlIHVzYm90ZzEgaXMgYSBkZXZpY2Utb25seQ0KbWljcm8tVVNCIHBvcnQgd2hp
bGUgdXNib3RnMiBpcyBhIHJlZ3VsYXIgVVNCLUEgaG9zdC1vbmx5IHBvcnQuIFRoZXJlLCB1bmZv
cnR1bmF0ZWx5LCBMaSdzIHBhdGNoIGRvZXMgbm90IGZpeA0KdGhlIGlzc3VlLiBIb3dldmVyLCBh
cyBzdGF0ZWQgYWJvdmUsIGFjY29yZGluZyB0byBOWFAgdGhhdCBJRCBwaW4gd291bGQgcmVhbGx5
IG5lZWQgdG8gYmUgY29ubmVjdGVkLiBTbw0KYmFzaWNhbGx5IHRoaXMgcGF0Y2ggaGVyZSBmcm9t
IFBoaWxpcHBlIGFkZHJlc3NlcyBhbiBpc3N1ZSB3aXRoIG91ciBicm9rZW4gaGFyZHdhcmUgdG8g
bWFrZSBkZXRlY3Rpb24gd29yaw0KcmVnYXJkbGVzcyAoYnkgYmFzaWNhbGx5IGluZGlyZWN0bHkg
ZGlzYWJsaW5nIGF1dG8tc3VzcGVuZCkuDQoNCj4gT24geW91ciBoYXJkd2FyZSwgZG8geW91IGhh
dmUgYW4gYWx3YXlzLW9uIGRldmljZSBvbg0KPiB0aGUgdXNib3RnMSBwb3J0Pw0KDQpObywgYXMg
bWVudGlvbmVkIGFib3ZlLCBvdXIgRGFobGlhIGFuZCBWZXJkaW4gZGV2ZWxvcG1lbnQgYm9hcmQg
aGF2ZSBhIHJlZ3VsYXIgZnVsbHkgT1RHIHJlc3AuIGRldmljZS9ob3N0LQ0Kc3dpdGNoYWJsZSBV
U0ItQyBwb3J0LiBXaGlsZSB0aGF0IGN1c3RvbSBjYXJyaWVyIGJvYXJkIGhhcyBhIGRldmljZSBv
bmx5IG1pY3JvLVVTQiBwb3J0Lg0KDQo+IElmIHllcywgZG9lcyB0aGUgZGV0ZWN0aW9uIG9uIHRo
ZSB1c2JvdGcyIHBvcnQgc3RpbGwNCj4gd29yayBpZiB0aGUgdXNib3RnMSBwb3J0IGlzIGRpc2Fi
bGVkIGluIHRoZSBkZXZpY2V0cmVlPw0KDQpJIGJlbGlldmUgdGhpcyBtaWdodCBiZSBhIHNlcGFy
YXRlIGlzc3VlIHJlY2VudGx5IGFsc28gcmVwb3J0ZWQgdG8gdXMgYnkgYSBjdXN0b21lci4gSG93
ZXZlciwgbW9zdCBsaWtlbHkgdGhhdA0KaXMvd2FzIG9uIGRvd25zdHJlYW0gYW5kIG1heWJlIGV2
ZW4gb24gYSBkaWZmZXJlbnQgaS5NWCA4IHNlcmllcyBiYXNlZCBtb2R1bGUsIG5vdCBxdWl0ZSBz
dXJlLiBMZXQgbWUgY2hlY2suLi4NCg0KQW55d2F5LCBmb3IgdXMgb24gdGhhdCBjdXN0b20gY2Fy
cmllciBib2FyZCBkZXRlY3Rpb24gZG9lcyBub3QgZXZlbiB3b3JrIGluIHRoZSByZWd1bGFyIGNh
c2Ugd2l0aCB1c2JvdGcxIGJlaW5nDQphdmFpbGFibGUgKGFsYmVpdCBtaWNyby1VU0IgZGV2aWNl
LW1vZGUgb25seSkuIFVuZm9ydHVuYXRlbHksIHdlIGRvbid0IGhhdmUgYW55IGNhcnJpZXIgYm9h
cmQgd2hlcmUgdGhlIGZ1bGwNCnJhbmdlIG9mIFVTQiB0ZXN0cyBjb3VsZCBlYXNpbHkgYmUgY29u
ZHVjdGVkLg0KDQo+IFRoYW5rcw0KPiBGcmllZGVyDQoNClRoYW5rIHlvdSENCg0KQ2hlZXJzDQoN
Ck1hcmNlbA0KDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2Vy
bmVsL2Y0ODc5ZWVkLTc5YTctM2ExYS04ZGQwLWMxYTZlZDM2N2YzNEBrb250cm9uLmRlDQo+IA0K
PiA+IA0KPiA+IC0tLQ0KPiA+IA0KPiA+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1tLXZlcmRpbi5kdHNpIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1tLXZlcmRpbi5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLQ0KPiA+IHZlcmRpbi5kdHNpDQo+ID4gaW5kZXggZWFmYTg4ZDk4MGIzLi4xOTdkYTc0ODM3
Y2EgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LXZlcmRpbi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLXZlcmRpbi5kdHNpDQo+ID4gQEAgLTczNyw2ICs3MzcsNyBAQCAmdXNicGh5bm9wMSB7DQo+
ID4gwqB9Ow0KPiA+IMKgDQo+ID4gwqAmdXNicGh5bm9wMiB7DQo+ID4gK8KgwqDCoMKgwqDCoMKg
cG93ZXItZG9tYWlucyA9IDwmcGdjX290ZzI+Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqB2Y2Mtc3Vw
cGx5ID0gPCZyZWdfdmRkXzN2Mz47DQo+ID4gwqB9Ow0K

