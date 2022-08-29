Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EF5A4346
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiH2GbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2GbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:31:05 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B31D0CB;
        Sun, 28 Aug 2022 23:31:03 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5BTxa025955;
        Mon, 29 Aug 2022 02:30:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g671frf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 02:30:54 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27T6UriL053611
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 02:30:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Aug
 2022 02:30:52 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::2dba:a158:4c3b:96e0]) by
 ASHBMBX9.ad.analog.com ([fe80::2dba:a158:4c3b:96e0%20]) with mapi id
 15.02.0986.014; Mon, 29 Aug 2022 02:30:52 -0400
From:   "Regus, Ciprian" <Ciprian.Regus@analog.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH 2/3] drivers: iio: adc: LTC2499 support
Thread-Topic: [PATCH 2/3] drivers: iio: adc: LTC2499 support
Thread-Index: AQHYtiYOMtfr8u9TKEm/2BgqOAAqea27k/+AgAFK7ACACHwY8A==
Date:   Mon, 29 Aug 2022 06:30:52 +0000
Message-ID: <e13827526235412585f8b7d60257c5a2@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-3-ciprian.regus@analog.com>
 <20220822203731.29c4c33b@jic23-huawei>
 <CAHp75Vft2pvXtxZcpvyV38cR9gOdDxDfCae8g5Uf2q6npWpb+Q@mail.gmail.com>
In-Reply-To: <CAHp75Vft2pvXtxZcpvyV38cR9gOdDxDfCae8g5Uf2q6npWpb+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWTNKbFozVnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RNVEF3TW1ZNU9ERXRNamMyTkMweE1XVmtMV0kyWVdJdE5ERTFOalEx?=
 =?utf-8?B?TURBd01ETXdYR0Z0WlMxMFpYTjBYREV3TURKbU9UZ3lMVEkzTmpRdE1URmxa?=
 =?utf-8?B?QzFpTm1GaUxUUXhOVFkwTlRBd01EQXpNR0p2WkhrdWRIaDBJaUJ6ZWowaU1q?=
 =?utf-8?B?VTRNU0lnZEQwaU1UTXpNRFl5TWpneU1qUTVNRFV5TWpZeElpQm9QU0l6YmpO?=
 =?utf-8?B?RWNXMUpURkJWWlZVMmFURmpaREI1UWpFMFZUQXhNRFE5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUpzU1VoWVUyTk1kbGxCWW5rdlFrd3hjRmd4YVU1MlRE?=
 =?utf-8?B?aEZkbGRzWmxkSk1FUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlNFRkJRVUZFWVVGUlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UlVGQlVVRkNRVUZCUVZnMWJESkxkMEZCUVVGQlFVRkJRVUZCUVVGQlFVbzBR?=
 =?utf-8?B?VUZCUW1oQlIxRkJZVkZDWmtGSVRVRmFVVUpxUVVoVlFXTm5RbXhCUmpoQlkw?=
 =?utf-8?B?RkNlVUZIT0VGaFowSnNRVWROUVdSQlFucEJSamhCV21kQ2FFRkhkMEZqZDBK?=
 =?utf-8?B?c1FVWTRRVnBuUW5aQlNFMUJZVkZDTUVGSGEwRmtaMEpzUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdk?=
 =?utf-8?B?QlFVRkJRVUZ1WjBGQlFVZEZRVnBCUW5CQlJqaEJZM2RDYkVGSFRVRmtVVUo1?=
 =?utf-8?B?UVVkVlFWaDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVWhOUVZoM1FqQkJS?=
 =?utf-8?B?MnRCV2xGQ2VVRkVSVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVTkJRVUZCUVVGRFpVRkJRVUZaVVVKclFVZHJRVmgzUW5wQlIx?=
 =?utf-8?B?VkJXWGRDTVVGSVNVRmFVVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVG?=
 =?utf-8?B?amQwSm1RVWhSUVdGUlFteEJTRWxCVFdkQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRa0ZCUVVGQlFVRkJRVUZKUVVGQlFVRkJRVDA5SWk4K1BDOXRaWFJo?=
 =?utf-8?B?UGc9PQ==?=
x-dg-rorf: true
x-originating-ip: [10.48.65.119]
x-adiruleop-newscl: Rule Triggered
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: 0Uw777wdL7H96h4IXFTjv3hCHETh5v8T
X-Proofpoint-GUID: 0Uw777wdL7H96h4IXFTjv3hCHETh5v8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290031
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gcmVwbHkgdG8gb25lIG9mIEFuZHkncyBxdWVzdGlvbnMuDQoNCj4gT24gTW9uLCBBdWcgMjIs
IDIwMjIgYXQgMTE6MTMgUE0gSm9uYXRoYW4gQ2FtZXJvbiA8amljMjNAa2VybmVsLm9yZz4NCj4g
d3JvdGU6DQo+ID4gT24gTW9uLCAyMiBBdWcgMjAyMiAxNTo1MTowNSArMDMwMA0KPiA+IENpcHJp
YW4gUmVndXMgPGNpcHJpYW4ucmVndXNAYW5hbG9nLmNvbT4gd3JvdGU6DQo+IA0KPiBJbiByZXBs
eSB0byBKb25hdGhhbidzIGNvbW1lbnRzIHRvIGFuc3dlciBoaXMgcXVlc3Rpb24gYW5kIGFkZCBt
b3JlDQo+IGNvbW1lbnRzIGZyb20gbWUuDQo+IA0KPiAuLi4NCj4gDQo+ID4gPiBEYXRhc2hlZXQ6
IGh0dHBzOi8vd3d3LmFuYWxvZy5jb20vbWVkaWEvZW4vdGVjaG5pY2FsLQ0KPiBkb2N1bWVudGF0
aW9uL2RhdGEtc2hlZXRzLzI0OTlmZS5wZGYNCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBD
aXByaWFuIFJlZ3VzIDxjaXByaWFuLnJlZ3VzQGFuYWxvZy5jb20+DQo+IA0KPiBUYWcgYmxvY2sg
bXVzdG4ndCBoYXZlIHRoZSBibGFuayBsaW5lKHMpLg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gICNp
bmNsdWRlIDxsaW51eC9paW8vaWlvLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9kcml2
ZXIuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gPiArI2luY2x1ZGUg
PGxpbnV4L3Byb3BlcnR5Lmg+DQo+ID4gd2h5Pw0KPiANCj4gZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCkgcmVxdWlyZXMgaXQuDQo+IA0KPiBCdXQgd2h5IG5vdCBzb3J0IHRoZW0/DQo+IA0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNldGFibGUuaD4NCj4gDQo+IC4uLg0KPiANCj4gPiA+
IC0gICAgICAgICAgICAgKnZhbCA9IChiZTMyX3RvX2NwdShzdC0+YnVmKSA+PiAxNCkgLSAoMSA8
PCAxNyk7DQo+ID4NCj4gPiBPbGQgY29kZSBoZXJlIGlzIGxlc3MgdGhhbiBpZGVhbCwgc2hvdWxk
IGJlIHJlYWRpbmcgaW50byAzIGJ5dGVzIHRoZW4gdXNpbmcNCj4gPiB0aGUgYmUyNCBhY2Nlc29y
cy4gUGxlYXNlIGZpeCB3aGlsc3QgaGVyZS4gIFlvdSB3aWxsIG5lZWQgbXVsdGlwbGUgcGF0aHMg
aGVyZQ0KPiA+IGRlcGVuZGluZyBvbiBzaXplLg0KPiA+DQo+ID4gPiArICAgICAgICAgICAgICp2
YWwgPSAoYmUzMl90b19jcHUoc3QtPmJ1ZikgPj4gc3QtPnN1Yl9sc2IpIC0NCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBCSVQoZGRhdGEtPmNoaXBfaW5mby0+cmVzb2x1dGlvbiArIDEpOw0K
PiANCj4gU2hvdWxkbid0IHRoaXMgdXNlIHNvbWUga2luZCBvZiBzaWduX2V4dGVuZCgpPw0KVGhl
IEJJVChkZGF0YS0+Y2hpcF9pbmZvLT5yZXNvbHV0aW9uICsgMSkgc3VidHJhY3Rpb24gcGFydCBp
cyBhbHJlYWR5IGRvaW5nIHRoZSBzaWduIGV4dGVuc2lvbiwNCnNpbmNlIHRoYXQgYml0ICh3aGlj
aCBpcyB0aGUgbW9zdCBzaWduaWZpY2FudCBvbmUpIHdpbGwgYmUgMCBpZiB0aGUgcmVzdWx0IGlz
IDwgMCwgYW5kIDEgb3RoZXJ3aXNlLg0KDQpSZWdhcmRzLA0KQ2lwcmlhbg0KPg0KPiBBbHNvIHdp
dGggYSB0ZW1wb3JhcnkgdmFyaWFibGUgZm9yIGNoaXAgaW5mbyB0aGlzIGxpbmUgY2FuIGJlIHNp
bmdsZS4NCj4gDQo+ICAgIHN0cnVjdCAuLi4gKmNpID0gZGRhdGEtPmNoaXBfaW5mbzsNCj4gDQo+
ICAgIC4uLkJJVChjaS0+cmVzb2x1dGlvbiArIDEpDQo+IA0KPiAuLi4NCj4gDQo+ID4gPiArICAg
ICB1MzIgcmVzb2x1dGlvbjsNCj4gDQo+IEtlZXAgdGhpcyBpbiBhIHdheSB0aGF0IHRoZSAibG9u
Z2VyIGxpbmVzIGdvIGZpcnN0Ii4NCj4gDQo+IC4uLg0KPiANCj4gPiA+ICsgICAgIHJlc29sdXRp
b24gPSBzdC0+Y29tbW9uX2RkYXRhLmNoaXBfaW5mby0+cmVzb2x1dGlvbjsNCj4gPiA+ICsgICAg
IHN0LT5zdWJfbHNiID0gMzEgLSAocmVzb2x1dGlvbiArIDEpOw0KPiA+ID4gKyAgICAgc3QtPnJl
Y3Zfc2l6ZSA9IHJlc29sdXRpb24gLyBCSVRTX1BFUl9CWVRFICsgMTsNCj4gDQo+IEJJVFNfVE9f
QllURVMoKQ0KPiANCj4gLi4uDQo+IA0KPiA+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2Rl
dmljZV9pZCBsdGMyNDk3X2lkW10gPSB7DQo+ID4gPiAtICAgICB7ICJsdGMyNDk3IiwgMCB9LA0K
PiA+ID4gKyAgICAgeyAibHRjMjQ5NyIsIFRZUEVfTFRDMjQ5NyB9LA0KPiA+ID4gKyAgICAgeyAi
bHRjMjQ5OSIsIFRZUEVfTFRDMjQ5OSB9LA0KPiANCj4gVXNlIHBvaW50ZXJzIGhlcmUgbGlrZSB5
b3UgaGF2ZSBkb25lIGZvciB0aGUgT0YgdGFibGUuDQo+IA0KPiA+ID4gICAgICAgeyB9DQo+ID4g
PiAgfTsNCj4gDQo+IC4uLg0KPiANCj4gPiA+ICtlbnVtIGNoaXBfdHlwZSB7DQo+ID4gPiArICAg
ICBUWVBFX0xUQzI0OTYsDQo+ID4gPiArICAgICBUWVBFX0xUQzI0OTcsDQo+ID4gPiArICAgICBU
WVBFX0xUQzI0OTkNCj4gDQo+IEtlZXAgdHJhaWxpbmcgY29tbWEuDQo+IA0KPiA+ID4gK307DQo+
IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
