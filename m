Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439B959FE51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiHXP1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHXP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:27:13 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 24 Aug 2022 08:27:08 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F05CC9A6A0;
        Wed, 24 Aug 2022 08:27:08 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,260,1654531200"; 
   d="scan'208";a="28042774"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 24 Aug 2022 23:26:04 +0800
Received: from yz-mbx05.mioffice.cn (10.237.88.125) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 23:26:03 +0800
Received: from BJ-MBX02.mioffice.cn (10.237.8.122) by yz-mbx05.mioffice.cn
 (10.237.88.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 24 Aug
 2022 23:26:03 +0800
Received: from BJ-MBX02.mioffice.cn ([fe80::7475:9ebf:d811:88c2]) by
 BJ-MBX02.mioffice.cn ([fe80::7475:9ebf:d811:88c2%17]) with mapi id
 15.02.0986.029; Wed, 24 Aug 2022 23:26:03 +0800
From:   =?utf-8?B?5p2O5L2z6ZOt?= <lijiaming3@xiaomi.com>
To:     Bean Huo <huobean@gmail.com>,
        Jiaming Li <lijiamingsofine@gmail.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIXSBzY3NpOiB1ZnM6?=
 =?utf-8?B?IHVmc2ZibzogSW50cm9kdWNlIEZpbGUgQmFzZWQgT3B0aW1pemF0aW9uIGZl?=
 =?utf-8?Q?ature?=
Thread-Topic: [External Mail]Re: [PATCH] scsi: ufs: ufsfbo: Introduce File
 Based Optimization feature
Thread-Index: AQHYt8Qh+RcVbZG0DEGTuktm+d7tza2+KseQ
Date:   Wed, 24 Aug 2022 15:26:03 +0000
Message-ID: <ce75888f5f2a412283a839ebd0015735@xiaomi.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
 <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
In-Reply-To: <347dae29c07fe13e6974b0e59e127c399f63ef69.camel@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_SOFTFAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVhbg0KVGhpcyBpcyBhIFVGUyBleHRlbmRlZCBmZWF0dXJlIGluIFVGUzQuMCBKRURFQyBT
dGFuZGFyZA0KVGhhbmtzDQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQmVh
biBIdW8gPGh1b2JlYW5AZ21haWwuY29tPg0K5Y+R6YCB5pe26Ze0OiAyMDIy5bm0OOaciDI05pel
IDIyOjE3DQrmlLbku7bkuro6IEppYW1pbmcgTGkgPGxpamlhbWluZ3NvZmluZUBnbWFpbC5jb20+
OyBhdnJpLmFsdG1hbkB3ZGMuY29tOyBhbGltLmFraHRhckBzYW1zdW5nLmNvbTsgamVqYkBsaW51
eC5pYm0uY29tOyBidmFuYXNzY2hlQGFjbS5vcmcNCuaKhOmAgTogbGludXgtc2NzaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IOadjuS9s+mTrSA8bGlqaWFt
aW5nM0B4aWFvbWkuY29tPg0K5Li76aKYOiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIXSBzY3Np
OiB1ZnM6IHVmc2ZibzogSW50cm9kdWNlIEZpbGUgQmFzZWQgT3B0aW1pemF0aW9uIGZlYXR1cmUN
Cg0KW+WklumDqOmCruS7tl0g5q2k6YKu5Lu25p2l5rqQ5LqO5bCP57Gz5YWs5Y+45aSW6YOo77yM
6K+36LCo5oWO5aSE55CG44CCDQoNCk9uIFdlZCwgMjAyMi0wOC0yNCBhdCAxNjo0NiArMDgwMCwg
SmlhbWluZyBMaSB3cm90ZToNCj4gRnJvbTogbGlqaWFtaW5nMyA8bGlqaWFtaW5nM0B4aWFvbWku
Y29tPg0KPg0KPiBJbXBsZW1lbnQgRmlsZSBCYXNlZCBPcHRpbWl6YXRpb24gaW5pdGlhbGl6YXRp
b24gYW5kIGFkZCBzeXNmcw0KPiBpbnRlcmZhY2UuDQo+DQo+IFN0b2FnZSBkZXZpY2VzIGhhdmUg
YSBsb25nIGxpZmVzcGFuLiBEZXZpY2UgcGVyZm9ybWFuY2Ugb3ZlciBpdHMNCj4gbGlmZXNwYW4g
aXMgbm90IGNvbnN0YW50IGFuZCBtYXkgZGV0ZXJpb3JhdGUgb3ZlciB0aW1lDQo+DQo+IFRoaXMg
ZmVhdHVyZSBkZXNjcmliZXMgYSBtZXRob2QgdG8gaW1wcm92ZSB0aGUgcGVyZm9ybWFuY2UgcmVn
cmVzc2lvbi4NCj4gVGhlIGhvc3QgbmVlZHMgdG8gcHJvdmlkZSBGaWxlIFN5c3RlbSBpbmZvcm1h
dGlvbiB0byBzdG9yYWdlIGRldmljZQ0KPiBmaXJzdC4gQmFzZWQgb24gdGhhdCBpbmZvcm1hdGlv
biBkZXZpY2UgYW5hbHl6ZXMgdGhlIGZpbGUgc3lzdGVtIGRhdGENCj4gYW5kIHByb3ZpZGVzIHRo
ZSBob3N0IHRoZSBsZXZlbCBvZiBwZXJmb3JtYW5jZSByZWdyZXNzaW9uLiBUaGUgaG9zdA0KPiB0
aGVuIG1heSBpbnN0cnVjdCB0aGUgZGV2aWNlIHRvIGV4ZWN1dGUgb3B0aW1pemF0aW9uIHByb2Nl
ZHVyZSB0bw0KPiBpbXByb3ZlIHRoZSByZWdyZXNzaW9uIGxldmVsLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBsaWppYW1pbmczIDxsaWppYW1pbmczQHhpYW9taS5jb20+DQo+IC0tLQ0KPiAgYXJjaC9h
cm02NC9jb25maWdzL2RlZmNvbmZpZyB8ICAgIDEgKw0KPiAgZHJpdmVycy9zY3NpL3Vmcy9LY29u
ZmlnICAgICB8ICAgIDkgKw0KPiAgZHJpdmVycy9zY3NpL3Vmcy9NYWtlZmlsZSAgICB8ICAgIDEg
Kw0KPiAgZHJpdmVycy9zY3NpL3Vmcy91ZnMuaCAgICAgICB8ICAgMTMgKw0KPiAgZHJpdmVycy9z
Y3NpL3Vmcy91ZnNmYm8uYyAgICB8IDEwMDcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgZHJpdmVycy9zY3NpL3Vmcy91ZnNmYm8uaCAgICB8ICAxNDMgKysrKysNCj4g
IGRyaXZlcnMvc2NzaS91ZnMvdWZzaGNkLmMgICAgfCAgIDE1ICsNCj4gIGRyaXZlcnMvc2NzaS91
ZnMvdWZzaGNkLmggICAgfCAgICA3ICstDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDExOTUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKSAgY3JlYXRlIG1vZGUNCj4gMTAwNjQ0IGRyaXZlcnMvc2Nz
aS91ZnMvdWZzZmJvLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBkcml2ZXJzL3Njc2kvdWZzL3Vm
c2Ziby5oDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+
IGIvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyBpbmRleCA0OTcyYTgxZDQwZDYuLjEzNjNj
MjM3YjZmMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZw0KPiAr
KysgYi9hcmNoL2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnDQo+IEBAIC0yODksNiArMjg5LDcgQEAg
Q09ORklHX1NDU0lfVUZTSENEX1BMQVRGT1JNPXkNCj4gQ09ORklHX1NDU0lfVUZTX1FDT009bSAg
Q09ORklHX1NDU0lfVUZTX0hJU0k9eQ0KPiBDT05GSUdfU0NTSV9VRlNfRVhZTk9TPXkNCj4gK0NP
TkZJR19TQ1NJX1VGU19GQk89eQ0KPiAgQ09ORklHX0FUQT15DQo+ICBDT05GSUdfU0FUQV9BSENJ
PXkNCj4gIENPTkZJR19TQVRBX0FIQ0lfUExBVEZPUk09eQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zY3NpL3Vmcy9LY29uZmlnIGIvZHJpdmVycy9zY3NpL3Vmcy9LY29uZmlnIGluZGV4DQo+IDQz
MmRmNzZlNjMxOC4uNTdiMGU4YjE0NTQzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Njc2kvdWZz
L0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy9LY29uZmlnDQo+IEBAIC0xOTksMyAr
MTk5LDEyIEBAIGNvbmZpZyBTQ1NJX1VGU19GQVVMVF9JTkpFQ1RJT04NCj4gICAgICAgICBoZWxw
DQo+ICAgICAgICAgICBFbmFibGUgZmF1bHQgaW5qZWN0aW9uIHN1cHBvcnQgaW4gdGhlIFVGUyBk
cml2ZXIuIFRoaXMgbWFrZXMNCj4gaXQgZWFzaWVyDQo+ICAgICAgICAgICB0byB0ZXN0IHRoZSBV
RlMgZXJyb3IgaGFuZGxlciBhbmQgYWJvcnQgaGFuZGxlci4NCj4gKw0KPiArY29uZmlnIFNDU0lf
VUZTX0ZCTw0KPiArICAgICAgIGJvb2wgIlN1cHBvcnQgVUZTIEZpbGUtYmFzZWQgT3B0aW1pemF0
aW9uIg0KPiArICAgICAgIGRlcGVuZHMgb24gU0NTSV9VRlNIQ0QNCj4gKyAgICAgICBoZWxwDQo+
ICsgICAgICAgIFRoZSBVRlMgRkJPIGZlYXR1cmUgaW1wcm92ZXMgU2VxdWVudGlhbCByZWFkIHBl
cmZvcm1hbmNlLg0KPiBUaGUgSG9zdCBjYW4NCj4gKyAgICAgICAgc2VuZCB0aGUgTEJBIHRvIGRl
dmljZS4gVGhlIGRldmljZSB3aWxsIHJldHVybiBhIGZyYWdtZW50ZWQNCj4gc3RhdGUuIEl0DQo+
ICsgICAgICAgIGlzIHVwIHRvIHRoZSBob3N0IHRvIGRlY2lkZSB3aGV0aGVyIHRvIGRlZnJhZy4g
QWZ0ZXINCj4gZGVmcmFnbWVudCwNCj4gKyAgICAgICAgU2VxdWVudGlhbCByZWFkIHBlcmZvcm1h
bmNlIGlzIGltcHJvdmVkDQo+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQ0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9zY3NpL3Vmcy9NYWtlZmlsZSBiL2RyaXZlcnMvc2NzaS91ZnMvTWFrZWZp
bGUNCj4gaW5kZXggYzQwN2RhOWI1MTcxLi45NTZiZTA3MzgyNjMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc2NzaS91ZnMvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9zY3NpL3Vmcy9NYWtlZmls
ZQ0KPiBAQCAtOSw2ICs5LDcgQEAgdWZzaGNkLWNvcmUtJChDT05GSUdfREVCVUdfRlMpICAgICAg
ICAgICs9IHVmcy0NCj4gZGVidWdmcy5vDQo+ICB1ZnNoY2QtY29yZS0kKENPTkZJR19TQ1NJX1VG
U19CU0cpICAgICArPSB1ZnNfYnNnLm8NCj4gIHVmc2hjZC1jb3JlLSQoQ09ORklHX1NDU0lfVUZT
X0NSWVBUTykgICs9IHVmc2hjZC1jcnlwdG8ubw0KPiAgdWZzaGNkLWNvcmUtJChDT05GSUdfU0NT
SV9VRlNfSFBCKSAgICAgKz0gdWZzaHBiLm8NCj4gK3Vmc2hjZC1jb3JlLSQoQ09ORklHX1NDU0lf
VUZTX0ZCTykgICAgICs9IHVmc2Ziby5vDQo+ICB1ZnNoY2QtY29yZS0kKENPTkZJR19TQ1NJX1VG
U19GQVVMVF9JTkpFQ1RJT04pICs9IHVmcy1mYXVsdC0NCj4gaW5qZWN0aW9uLm8NCj4NCj4gIG9i
ai0kKENPTkZJR19TQ1NJX1VGU19EV0NfVENfUENJKSArPSB0Yy1kd2MtZzIxMC1wY2kubyB1ZnNo
Y2QtZHdjLm8NCj4gdGMtZHdjLWcyMTAubyBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3Vmcy91
ZnMuaA0KPiBiL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmggaW5kZXggOGM2YjM4YjFiMTQyLi5iNzUw
Y2UzZjdkZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc2NzaS91ZnMvdWZzLmgNCj4gKysrIGIv
ZHJpdmVycy9zY3NpL3Vmcy91ZnMuaA0KPiBAQCAtMTcwLDYgKzE3MCw3IEBAIGVudW0gZGVzY19p
ZG4gew0KPiAgICAgICAgIFFVRVJZX0RFU0NfSUROX0dFT01FVFJZICAgICAgICAgPSAweDcsDQo+
ICAgICAgICAgUVVFUllfREVTQ19JRE5fUE9XRVIgICAgICAgICAgICA9IDB4OCwNCj4gICAgICAg
ICBRVUVSWV9ERVNDX0lETl9IRUFMVEggICAgICAgICAgID0gMHg5LA0KPiArICAgICAgIFFVRVJZ
X0RFU0NfSUROX0ZCTyAgICAgICAgICA9IDB4QSwNCkhpIEppYW1pbmcsDQoNCklzIHRoaXMgYSBV
RlMgZXh0ZW5kZWQgc3RhbmRhcmQgb3IgdmVuZG9yIHNwZWNpZmljIGZlYXR1cmU/DQoNCg0KDQoj
LyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/
oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaI
lue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWM
heaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaV
o+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7
tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOac
rOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlk
ZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZv
ciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55
IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNs
dWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCBy
ZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUg
aW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMg
ZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1h
aWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
