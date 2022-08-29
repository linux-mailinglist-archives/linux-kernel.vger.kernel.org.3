Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAE35A4307
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiH2GOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiH2GOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:14:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805E491C3;
        Sun, 28 Aug 2022 23:14:20 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T4xscP026949;
        Mon, 29 Aug 2022 02:13:54 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3j7g671db0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 02:13:54 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 27T6DrvV052061
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Aug 2022 02:13:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 29 Aug
 2022 02:13:52 -0400
Received: from ASHBMBX9.ad.analog.com ([fe80::2dba:a158:4c3b:96e0]) by
 ASHBMBX9.ad.analog.com ([fe80::2dba:a158:4c3b:96e0%20]) with mapi id
 15.02.0986.014; Mon, 29 Aug 2022 02:13:52 -0400
From:   "Regus, Ciprian" <Ciprian.Regus@analog.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Thread-Topic: [PATCH 3/3] drivers: iio: adc: Rename the LTC249x iio device
Thread-Index: AQHYtiYPWfCKOlH/P0SQaqSt0f4qzq27N/wAgAXzPnA=
Date:   Mon, 29 Aug 2022 06:13:52 +0000
Message-ID: <c76a746e0a6448b2a39a4ce7e5baa285@analog.com>
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-4-ciprian.regus@analog.com>
 <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
In-Reply-To: <0f778952-1909-1038-8f9a-3a7d7f12d6e1@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWTNKbFozVnpYR0Z3Y0dSaGRHRmNjbTloYldsdVoxd3dPV1E0TkRsaU5p?=
 =?utf-8?B?MHpNbVF6TFRSaE5EQXRPRFZsWlMwMllqZzBZbUV5T1dVek5XSmNiWE5uYzF4?=
 =?utf-8?B?dGMyY3RZV1kzWWprME9EVXRNamMyTVMweE1XVmtMV0kyWVdJdE5ERTFOalEx?=
 =?utf-8?B?TURBd01ETXdYR0Z0WlMxMFpYTjBYR0ZtTjJJNU5EZzJMVEkzTmpFdE1URmxa?=
 =?utf-8?B?QzFpTm1GaUxUUXhOVFkwTlRBd01EQXpNR0p2WkhrdWRIaDBJaUJ6ZWowaU16?=
 =?utf-8?B?TTVPQ0lnZEQwaU1UTXpNRFl5TWpjeU1ETTVPVE0xTXpFMElpQm9QU0pIYjBK?=
 =?utf-8?B?a1UyWlplbVl3VUZoWE9EWkdNMkZaVFdKS1VuVk9WVFE5SWlCcFpEMGlJaUJp?=
 =?utf-8?B?YkQwaU1DSWdZbTg5SWpFaUlHTnBQU0pqUVVGQlFVVlNTRlV4VWxOU1ZVWk9R?=
 =?utf-8?B?MmRWUVVGRmIwTkJRVUpUV0daS2VHSnlkbGxCVTNkUFRUZE1hVzB4U1daTVFU?=
 =?utf-8?B?UjZjM1ZMWWxWb09FUkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
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
X-Proofpoint-ORIG-GUID: B709vKWLsbg2GVQRuEjXRnTCPkFH-HJo
X-Proofpoint-GUID: B709vKWLsbg2GVQRuEjXRnTCPkFH-HJo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290030
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGFycywNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiBJIGhhdmUgb25lIHF1ZXN0aW9uIGJl
Zm9yZSBnb2luZyBmdXJ0aGVyDQp3aXRoIHRoaXMgcGF0Y2guDQoNCj4gT24gOC8yMi8yMiAxNDo1
MSwgQ2lwcmlhbiBSZWd1cyB3cm90ZToNCj4gPiBTZXQgdGhlIGlpbyBkZXZpY2UncyBuYW1lIGJh
c2VkIG9uIHRoZSBjaGlwIHVzZWQuDQo+IA0KPiBXaGlsZSB0aGUgY2hhbmdlIGlzIGNvcnJlY3Qg
aXQgYnJlYWtzIHRoZSBBQkkuIFRoaXMgbmVlZHMgYSBiaXQgb2YgYQ0KPiBiZXR0ZXIgZXhwbGFu
YXRpb24gd2hhdCBpcyBiZWluZyBkb25lLCB3aHksIHdoYXQgYXJlIHRoZSBwb3RlbnRpYWwNCj4g
cHJvYmxlbXMsIHdoeSBkbyB3ZSB3YW50IHRvIGRvIGl0IGFueXdheS4NCg0KVGhlIHJlYXNvbiBm
b3IgdGhpcyBjaGFuZ2UgaXMgdG8gbWFrZSBpdCBlYXNpZXIgdG8gaWRlbnRpZnkgdGhlIGRldmlj
ZQ0KKGJ5IGhhdmluZyBhIGdlbmVyaWMgbmFtZSkgd2hlbiB1c2luZyBhbiBJSU8gY2xpZW50LiBU
aGUgY3VycmVudCBuYW1lIGlzDQpiYXNlZCBvbiB0aGUgaTJjX2NsaWVudCdzIGtvYmogbmFtZSwg
d2hpY2ggaGFzIHRoZSBmb3JtYXQNCiJpMmNfaW5zdGFuY2UgLWkyY19hZGRyZXNzICIgKGUuZy4g
MS0wMDc2KS4gU28sIHRoZSByZW5hbWluZyB3b3VsZCBhbGxvdw0KZm9yIGludGVyYWN0aW5nIHdp
dGggdGhlIGRldmljZSB3aXRob3V0IGtub3dpbmcgd2hpY2ggYnVzIGl0J3MgY29ubmVjdGVkDQp0
by4NCg0KQWxzbywgYXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIElJTyBBQkkgc3RhdGVzIHRoYXQg
dGhlIGRldmljZSdzIG5hbWUgaXMNCiJUeXBpY2FsbHkgYSBwYXJ0IG51bWJlciIuDQoNCkZvciB0
aGUgcmVhc29uIGdpdmVuLCB3b3VsZCB0aGlzIGNoYW5nZSBiZSBjb25zaWRlcmVkIGFuDQppbXBy
b3ZlbWVudCwgb3IgaXMgdGhlIEFCSSBicmVha2luZyB0b28gbXVjaCBvZiBhIGRyYXdiYWNrPw0K
KGluIHdoaWNoIGNhc2UgSSdsbCBqdXN0IGRyb3AgdGhpcyBwYXRjaCkNCg0KVGhhbmtzLA0KQ2lw
cmlhbg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENpcHJpYW4gUmVndXMgPGNpcHJpYW4u
cmVndXNAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvaWlvL2FkYy9sdGMyNDk2
LmMgICAgICB8IDEgKw0KPiA+ICAgZHJpdmVycy9paW8vYWRjL2x0YzI0OTctY29yZS5jIHwgMiAr
LQ0KPiA+ICAgZHJpdmVycy9paW8vYWRjL2x0YzI0OTcuYyAgICAgIHwgMiArKw0KPiA+ICAgZHJp
dmVycy9paW8vYWRjL2x0YzI0OTcuaCAgICAgIHwgMSArDQo+ID4gICA0IGZpbGVzIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaWlvL2FkYy9sdGMyNDk2LmMgYi9kcml2ZXJzL2lpby9hZGMvbHRjMjQ5Ni5jDQo+ID4g
aW5kZXggOTgzMzgxMDRjMjRhLi44NjQ3MGY0OWU4Y2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9paW8vYWRjL2x0YzI0OTYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMyNDk2LmMN
Cj4gPiBAQCAtODksNiArODksNyBAQCBzdGF0aWMgdm9pZCBsdGMyNDk2X3JlbW92ZShzdHJ1Y3Qg
c3BpX2RldmljZSAqc3BpKQ0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGNoaXBfaW5mbyBsdGMy
NDk2X2luZm8gPSB7DQo+ID4gICAJLnJlc29sdXRpb24gPSAxNiwNCj4gPiArCS5uYW1lID0gImx0
YzI0OTYiDQo+ID4gICB9Ow0KPiA+DQo+ID4gICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rldmlj
ZV9pZCBsdGMyNDk2X29mX21hdGNoW10gPSB7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlv
L2FkYy9sdGMyNDk3LWNvcmUuYyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMyNDk3LWNvcmUuYw0KPiA+
IGluZGV4IGIyNzUyMzk5NDAyYy4uNmRkOWFiNjAxOTA0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvaWlvL2FkYy9sdGMyNDk3LWNvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMy
NDk3LWNvcmUuYw0KPiA+IEBAIC0xNjksNyArMTY5LDcgQEAgaW50IGx0YzI0OTdjb3JlX3Byb2Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+IGlpb19kZXYgKmluZGlvX2RldikNCj4gPiAg
IAlzdHJ1Y3QgbHRjMjQ5N2NvcmVfZHJpdmVyZGF0YSAqZGRhdGEgPSBpaW9fcHJpdihpbmRpb19k
ZXYpOw0KPiA+ICAgCWludCByZXQ7DQo+ID4NCj4gPiAtCWluZGlvX2Rldi0+bmFtZSA9IGRldl9u
YW1lKGRldik7DQo+ID4gKwlpbmRpb19kZXYtPm5hbWUgPSBkZGF0YS0+Y2hpcF9pbmZvLT5uYW1l
Ow0KPiA+ICAgCWluZGlvX2Rldi0+aW5mbyA9ICZsdGMyNDk3Y29yZV9pbmZvOw0KPiA+ICAgCWlu
ZGlvX2Rldi0+bW9kZXMgPSBJTkRJT19ESVJFQ1RfTU9ERTsNCj4gPiAgIAlpbmRpb19kZXYtPmNo
YW5uZWxzID0gbHRjMjQ5N2NvcmVfY2hhbm5lbDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
aW8vYWRjL2x0YzI0OTcuYyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMyNDk3LmMNCj4gPiBpbmRleCBi
YjVlMGQ0MzAxZTIuLmEwYWFkNzFjODEzMCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9h
ZGMvbHRjMjQ5Ny5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL2x0YzI0OTcuYw0KPiA+IEBA
IC05OSw5ICs5OSwxMSBAQCBzdGF0aWMgaW50IGx0YzI0OTdfcmVtb3ZlKHN0cnVjdCBpMmNfY2xp
ZW50ICpjbGllbnQpDQo+ID4gICBzdGF0aWMgc3RydWN0IGNoaXBfaW5mbyBsdGMyNDk3X2luZm9b
XSA9IHsNCj4gPiAgIAlbVFlQRV9MVEMyNDk3XSA9IHsNCj4gPiAgIAkJLnJlc29sdXRpb24gPSAx
NiwNCj4gPiArCQkubmFtZSA9ICJsdGMyNDk3Ig0KPiA+ICAgCX0sDQo+ID4gICAJW1RZUEVfTFRD
MjQ5OV0gPSB7DQo+ID4gICAJCS5yZXNvbHV0aW9uID0gMjQsDQo+ID4gKwkJLm5hbWUgPSAibHRj
MjQ5OSINCj4gPiAgIAl9DQo+ID4gICB9Ow0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
aWlvL2FkYy9sdGMyNDk3LmggYi9kcml2ZXJzL2lpby9hZGMvbHRjMjQ5Ny5oDQo+ID4gaW5kZXgg
ZjRkOTM5Y2ZkNDhiLi4wZTg2ZTM4MjQ4ZWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL2x0YzI0OTcuaA0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9sdGMyNDk3LmgNCj4gPiBA
QCAtMTIsNiArMTIsNyBAQCBlbnVtIGNoaXBfdHlwZSB7DQo+ID4NCj4gPiAgIHN0cnVjdCBjaGlw
X2luZm8gew0KPiA+ICAgCXUzMiByZXNvbHV0aW9uOw0KPiA+ICsJY2hhciAqbmFtZTsNCj4gPiAg
IH07DQo+ID4NCj4gPiAgIHN0cnVjdCBsdGMyNDk3Y29yZV9kcml2ZXJkYXRhIHsNCj4gDQoNCg==
