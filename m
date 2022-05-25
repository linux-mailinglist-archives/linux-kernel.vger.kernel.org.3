Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A09533467
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiEYAmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242341AbiEYAmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:42:47 -0400
Received: from mo-csw.securemx.jp (mo-csw1516.securemx.jp [210.130.202.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3425BD33;
        Tue, 24 May 2022 17:42:45 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 24P0g8OA027478; Wed, 25 May 2022 09:42:08 +0900
X-Iguazu-Qid: 34trSfAbwEXhT00Kjh
X-Iguazu-QSIG: v=2; s=0; t=1653439328; q=34trSfAbwEXhT00Kjh; m=WrncwomgaIZn9ThZbC4RkLuQxNhZSx9PZ9qic9N2SB8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 24P0g6ch021547
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 25 May 2022 09:42:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlEw4uOf1BK+0KBb/Ty4AA80Nx1YBPlskOSK93RgfChivq7MLvzLdKEkWf7jp9DUc5xOW4AiGZMf5sS5HAqn8DrT85Oa9PlQtPd+2Dq5GJ95k6oPC82xo81GK3soGPCgA6ca03/aXakJuDoOI4SJ3mLpwA1RBUWPimwMdif2suQHI3hF2+L7wVfJGgJaoZFwpcALGQInjLBaL+PH6CXTFLvkELNfBMtjpajETO/DlWwtEKeGcP6IucnBRAy6wD+I+ycwsXvtPvUnTjCGFbrUgTkLstlqNL8fs736fr5f0fymhhkblgspTF86H1oMpHq9QLmmekqYj6V5OgkVnmW8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR722t8JeStJnKCOoidoG3cCc3HvLSNLd2qim3XbGlY=;
 b=oZ1O5+geZmVrEEKI7oAtjxLx+Elt+NLNcAJYtpvRoutij5814+yrBaL7FqDOk4QE+mmy8DasnYD6B0iSpomtEsnntnAaGAN0o0TOk63pUFYQ7kmj0wm4x3at4jnzgDHmXpG0SC06upbV7s5S8hW1vwJmNu42BjEi4m+1rLj4pug99KoHbLcVNkVUM0q2WIoTBTltUtwaPhVvIPKQQ+ZQD4hARYpAUZsSGETNqzM3ad2fFfgs7+EsuV7s6querd7/kE9VRfE/KlpRWJGanPqKKX46IXuQvuyFz9G0DZYicXwkBGp4mtXYhty0qsmmsHUjeiGOEJrP6bYeJzTd8MTfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <linux@roeck-us.net>, <wim@linux-watchdog.org>
CC:     <linux-watchdog@vger.kernel.org>, <yuji2.ishikawa@toshiba.co.jp>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>
Subject: RE: [PATCH v2] dt-bindings: watchdog: toshiba,visconti-wdt: Update
 the common clock properties
Thread-Topic: [PATCH v2] dt-bindings: watchdog: toshiba,visconti-wdt: Update
 the common clock properties
Thread-Index: AQHYbCgX1nI0T0APlEa1ib/ej/b6NK0nesGAgAdMrnA=
Date:   Wed, 25 May 2022 00:41:59 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420E232FCA29F1CB07C0C8C92D69@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220520090024.620928-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <6e0f7f48-ecfd-16be-8672-aa4ba11b0c91@roeck-us.net>
In-Reply-To: <6e0f7f48-ecfd-16be-8672-aa4ba11b0c91@roeck-us.net>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d050a1a-29a5-45ab-6b7f-08da3de760a0
x-ms-traffictypediagnostic: OS3PR01MB9691:EE_
x-microsoft-antispam-prvs: <OS3PR01MB9691ECAE3F1FE99D2664EBF892D69@OS3PR01MB9691.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rD3tDMnkICpY0FSaCZFpLikzuDMJndxBxXJdE4xyvNnPLqzeXRHJ6JUCL0pIfSmzlQq4QT/qNRxUqjRrCz2hpF2ofjeMrkMjIPGRHLbhWolfO6Wcuj2O83BqLL6CS2WcaRAF2YE4VVuQKZONHsxMQ58xvNz0F+8/izx48nTYP20JQeKgK9opPSkfLpv9UlcSDlvltCK1aJTDk1Ujz2Stf/MUtcSvKQJfc0/5k/hCraFClHuBx3qn6WkNpkmU/SW2fBWd/uUhunxZtiHehSLbRmb8uuCP4qDcoOX9kCzKwrhcFP0JhSfG5RaJgVybXU0IX9rBmeRuaSbm/h7QQ8F/rVPs08y+pviIN2nNP27bIxN3EVZCE8lkNSjCQSfvKdeDzWTxFr9xsS/54I7CcMLNi1z8QbA3hoH+0hNE1I6ta5jn+YmjrgsNBTHMBSGVg9U6awQRm/eGPf88f1VvH2e5agPywyHMO5tLbOHmqfN3XbPmlcPfSUeWSHcQR/jZ+P9NL7QhF+n5HeEy7XngfE+kG0x/7ZGnLbsvJ9aq0+h4/MrlA8n9enRK5wB5jGuYpgyEGxcNa/sbGe6NUlTt2+QwIETBTwWSCXrXZUWoDNJaJbNhl5f432gTj9ruLb4s6XuJY+gsrkO/6bHk4mxDHHNNomjAqgplIGuYO0NIdaSU7CT7gHUU/zJ2vshd3M5IougoVmz+IY+IInNCR4xjdbJUCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(4326008)(66446008)(86362001)(55016003)(64756008)(6506007)(66476007)(122000001)(8676002)(66556008)(5660300002)(9686003)(71200400001)(38070700005)(26005)(15650500001)(186003)(110136005)(8936002)(52536014)(83380400001)(53546011)(76116006)(66946007)(2906002)(7696005)(316002)(33656002)(54906003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGhPZlVXcm1teUtwYktQMkpMVENuU0ZwSkFPV1Zpako3Y01jZUNQM3F3bHN3?=
 =?utf-8?B?dHkrRXFVR1BzTWtQK1M4TzlKMjN6ZE1wcUpLQzBlMmQyUkdQWlYxbFByRU53?=
 =?utf-8?B?VEF3V0FJdWZFTnlXSnE3QjB6djI0VkhtNGFvcUZKKzBYTFRndUJONDNONjY2?=
 =?utf-8?B?U3FndDhPMGs1b2pqUUtZMDdnRWc4ZEs1TlFVMHIvVlgyWkFBMmhZcmlCbWFy?=
 =?utf-8?B?NDlrOHFOVDhLcnRHODNJUmNVbzlPVkl2MWc5djlCMzFya0ZPd2NvcEF5Qndn?=
 =?utf-8?B?cXBybzdxbUQ4UER3R0tOTm5Vc0tqT2ZBUFFlMHk2U2dFZ3gwZUdKb2t2UDd0?=
 =?utf-8?B?cjF2cENSNXlOZmFQSkZpUVhVbDFlN3M1bDU0ZGp6RnNhak5EbktTQjVkOWJv?=
 =?utf-8?B?SDlMSXhGRDErQ0x6RGJxRkFkenA4SjhlbG5qQUh5OW96SUZyTVVTbkxqNGRa?=
 =?utf-8?B?NkRLOVFsWkFGVXkzL2xlcDdsK2FocUpOaDhOQkIrMGxHS2VFcE4rNEVqUFpU?=
 =?utf-8?B?YVJwQXhDQmNhZVN5Y0RVVm5xdU9vMFZRc1Q4ZEtsS3BKcHhCOGloSGRLdEVB?=
 =?utf-8?B?dGRNYmxSOFlWWW9FdC9wWmRJZ0hHL0RKU2Q1RzdreTBGRUpUcDNpc3BTMWlh?=
 =?utf-8?B?dGsxUFNkcnRGZ0lxK2orVWIzcUsxam5HVWRKbXZadXZGU2NpaS9pNG0yc1FP?=
 =?utf-8?B?R1ZVK3ZMY1RhUWZpSmRydklMQ3hpeGhFNVc5WmhRbE14bFQ4ZTlsRlJZZ2s2?=
 =?utf-8?B?RWczbmZTK1ljaUpXZ0lvNHFpVEN0ZmhwTXhuR3Q4MlMxK2NveSs0YmNuZjkx?=
 =?utf-8?B?bUdvWGc0N1l0WSt1djJsWGkyVGpVZmhqdjFhYmV1VWg4YTVINGRpUEgvWDJy?=
 =?utf-8?B?WGtjdytaWkMyWlZ5UTVEYnhnV0R5bkhmZURDOXZ5b3BTc0pySU5ZTFg5dlI0?=
 =?utf-8?B?Q1RFeXRMODRFdTBCemJURktDWE1ZVkNWVzhqbUF6K3BQR3E0ZTRXbUhobFVP?=
 =?utf-8?B?MHJMSHF1VlpHbGlZSTNSL2RFOWgyNWNlL0h1eTBCWktPZkVDTXJNQVhtYkJx?=
 =?utf-8?B?Vzlld284TjZ1QVVDT0pwV3FwYlJWM3hRR09rclFpWVdBWlRlaVkySHpOYjFC?=
 =?utf-8?B?UklBS1hsajFlUmtGdmZrcDhnRUV5bDhjc3FSVE9xeC9XcmNYdGRGaFZGUUNM?=
 =?utf-8?B?S0tHT1Mrb0N4UDlCbFZ3ZmJORjlpT0JMSEU1TU1kS2pmT1ZNb1hTMXhNWkxh?=
 =?utf-8?B?bzgwcnNyanZHTUNBeWF2S2RVS09mNWZLdXYya2JHMHRKWm4zSXYzT1V6SEJD?=
 =?utf-8?B?aGwwLzRDZmJ1Y1Zoei81ZFRadXdISmZkd2l4SnoxeWI2VFliY05YQ3d5ekkw?=
 =?utf-8?B?QTBObnE2WDdKSGJDaWhhM05QR1VGU2ZWdnExNTVNR0ZTbWNBUWxwaVJlM01C?=
 =?utf-8?B?endoeG9NeXV3dXJXbXZ6ajNScnRzTlRKakpZYjllNG9pMi9MYWRaUHZxeVJO?=
 =?utf-8?B?UlI4ZXd3T3BzNCtmbVFqWHF1Q3BHUk43K0Q0aFJraHpSRHBiL1VWZW5iNE9a?=
 =?utf-8?B?OUkyK1pRVmZaUFBjWUJpSkRNOERQcldXTXZncktOYXN5a2lST3hHUSs2d0Zl?=
 =?utf-8?B?ODc2Y2RYbmx6NnRacUY2azQwRkNRTXAvMlZoTzhJRm9WRkZRR2xobnhTelJK?=
 =?utf-8?B?TkdJTUVVQnZ4d3cwQzlNSkNhbVZhNlVrbkNTYkVCQkgzcFV2ekU5RENzMDJY?=
 =?utf-8?B?UDRBRkdYZUpwVnhnNUh5YmZXVXhXa0tIMWlNKzdUTzREblBiek53QU12ZG01?=
 =?utf-8?B?cXdYZExsVGdiYU1xdDVZZWhVMzF6bGRNVkVTZFhsOTQzbzlpdXgvcEZvOU5l?=
 =?utf-8?B?RGlOU1NZOGlEQk11ZVhPajVENGlHdWVIRjBLcDBUM1E1ajZyamxKSmtnaG56?=
 =?utf-8?B?ZXlLUG1pSWU3Sk5HUG5zRm4zYTdrak5wNFg5TGkvcUl4dEt4dzRDRERaZTR5?=
 =?utf-8?B?OHpjMEljb2MvWlhPRmFLZ0hiaEp5OHEzelI2dUtzQ1EvK1MwYVNsRUFnbFJj?=
 =?utf-8?B?MzMyMjhhZndsNmNtMjR5THJ3TDRKL0Z1a1VLc1NHZTRYZlVxbVNVTHJ1V2kr?=
 =?utf-8?B?YnBPcHFCRGtXa1F2aWVsc2VxS013VWRZM2dtTGY2enQwbVBOV0VDN0tmZHhS?=
 =?utf-8?B?WndDY2c4WXJlTDBPVmdMeUJvN2F6Q09PcysrZFpZRm5tWGgrNG84MGpSMkNL?=
 =?utf-8?B?YWtrOSs4MG95RG9CUVpiVkljRldicHVab1dFRWhPMENHM0xmQmNtK0daVlFX?=
 =?utf-8?B?dy9nRUdKZElkeW0ybEZXUFRzSnppMHVlbCt6a3FVQWRkZHljWWRNY21UbXM2?=
 =?utf-8?Q?/7oOLhiFX+JuS8DI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d050a1a-29a5-45ab-6b7f-08da3de760a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 00:41:59.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mka389DqEZigZXqEJV4Ug6CpQ+R/y1waDr5V9PgvRHOYnF8ZKfW0qygWg+V4ynIYyPsegHnIEzg5yDXoQiB4H6xijwDRGZti5yT1gTp61qxYbGpBAE4vfWlLl4OQuqgm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9691
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3VlbnRlciwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIDxncm9lY2s3QGdtYWlsLmNvbT4g
T24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNCj4gU2VudDogRnJpZGF5LCBNYXkgMjAsIDIwMjIg
NjoxMSBQTQ0KPiBUbzogaXdhbWF0c3Ugbm9idWhpcm8o5bKp5p2+IOS/oea0iyDilqHvvLPvvLfv
vKPil6/vvKHvvKPvvLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD47IFdp
bSBWYW4gU2Vicm9lY2sNCj4gPHdpbUBsaW51eC13YXRjaGRvZy5vcmc+DQo+IENjOiBsaW51eC13
YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGlzaGlrYXdhIHl1amko55+z5bedIOaCoOWPuCDil4vv
vLLvvKTvvKPilqHvvKHvvKkNCj4g77y077yj4peL77yl77yh6ZaLKSA8eXVqaTIuaXNoaWthd2FA
dG9zaGliYS5jby5qcD47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YNCj4gS296bG93
c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkdC1iaW5kaW5nczogd2F0Y2hkb2c6IHRvc2hpYmEs
dmlzY29udGktd2R0OiBVcGRhdGUNCj4gdGhlIGNvbW1vbiBjbG9jayBwcm9wZXJ0aWVzDQo+IA0K
PiBPbiA1LzIwLzIyIDAyOjAwLCBOb2J1aGlybyBJd2FtYXRzdSB3cm90ZToNCj4gPiBUaGUgY2xv
Y2sgZm9yIHRoaXMgZHJpdmVyIHN3aXRjaGVkIHRvIHRoZSBjb21tb24gY2xvY2sgY29udHJvbGxl
ciBkcml2ZXIuDQo+ID4gVGhlcmVmb3JlLCB1cGRhdGUgY29tbW9uIGNsb2NrIHByb3BlcnRpZXMg
Zm9yIHdhdGNoZG9nIGluIHRoZSBiaW5kaW5nDQo+IGRvY3VtZW50Lg0KPiA+IEFuZCB0aGlzIG1h
dGNoZWQgdGhpcyBleGFtcGxlIHdpdGggdGhlIGFjdHVhbCBkdHMuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBOb2J1aGlybyBJd2FtYXRzdSA8bm9idWhpcm8xLml3YW1hdHN1QHRvc2hpYmEuY28u
anA+DQo+ID4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0t
DQo+ID4gICAuLi4vYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13ZHQueWFtbCAg
ICAgfCAxMw0KPiArKysrLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+DQo+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3Rvc2hpYmEsdmlzY29udGkt
d2R0LnlhbWwNCj4gPg0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRj
aGRvZy90b3NoaWJhLHZpc2NvbnRpLXdkdC55YW1sDQo+ID4gaW5kZXggNjkwZTE5Y2U0Yjg3Li41
MmMwZTBjMDIyZWEgMTAwNjQ0DQo+ID4gLS0tDQo+ID4NCj4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13ZHQueWFtbA0KPiA+ICsr
Kw0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy90b3NoaWJh
LHZpc2NvbnRpLXdkdC4NCj4gPiArKysgeWFtbA0KPiA+IEBAIC0zNSwyMCArMzUsMTUgQEAgYWRk
aXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4NCj4gPiAgIGV4YW1wbGVzOg0KPiA+ICAgICAt
IHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay90b3NoaWJhLHRtcHY3NzB4
Lmg+DQo+ID4gKw0KPiA+ICAgICAgIHNvYyB7DQo+ID4gICAgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDI+Ow0KPiA+ICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPg0KPiA+IC0gICAg
ICAgIHdkdF9jbGs6IHdkdC1jbGsgew0KPiA+IC0gICAgICAgICAgICBjb21wYXRpYmxlID0gImZp
eGVkLWNsb2NrIjsNCj4gPiAtICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0gPDE1MDAwMDAw
MD47DQo+ID4gLSAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwwPjsNCj4gPiAtICAgICAgICB9
Ow0KPiA+IC0NCj4gPiAtICAgICAgICB3YXRjaGRvZ0AyODMzMDAwMCB7DQo+ID4gKyAgICAgICAg
d2R0OiB3YXRjaGRvZ0AyODMzMDAwMCB7DQo+ID4gICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
InRvc2hpYmEsdmlzY29udGktd2R0IjsNCj4gPiAgICAgICAgICAgICAgIHJlZyA9IDwwIDB4Mjgz
MzAwMDAgMCAweDEwMDA+Ow0KPiA+IC0gICAgICAgICAgICBjbG9ja3MgPSA8JndkdF9jbGs+Ow0K
PiA+IC0gICAgICAgICAgICB0aW1lb3V0LXNlYyA9IDwyMD47DQo+ID4gKyAgICAgICAgICAgIGNs
b2NrcyA9IDwmcGlzbXUgVE1QVjc3MFhfQ0xLX1dEVENMSz47DQo+ID4gICAgICAgICAgIH07DQo+
ID4gICAgICAgfTsNCj4gDQo+IHdkdDogaXNuJ3QgbmVlZGVkIGluIHRoZSBleGFtcGxlLCBhbmQg
SSBxdWVzdGlvbiBpZiBpdCByZWFsbHkgaW1wcm92ZXMgdGhlIHF1YWxpdHkNCj4gb2YgdGhlIGV4
YW1wbGUgdG8gcmVtb3ZlIHRpbWVvdXQtc2VjLg0KDQpPSywgSSBtYWtlIGEgZml4IHRoYXQgZG9l
c24ndCByZW1vdmUgdGltZW91dC1zZWMuDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg==

