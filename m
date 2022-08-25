Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955DF5A0FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241291AbiHYMKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233743AbiHYMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:10:25 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43C2E87681;
        Thu, 25 Aug 2022 05:10:21 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,263,1654531200"; 
   d="scan'208";a="28157514"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 25 Aug 2022 20:10:20 +0800
Received: from BJ-MBX06.mioffice.cn (10.237.8.126) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 20:10:19 +0800
Received: from BJ-MBX02.mioffice.cn (10.237.8.122) by BJ-MBX06.mioffice.cn
 (10.237.8.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 25 Aug
 2022 20:10:18 +0800
Received: from BJ-MBX02.mioffice.cn ([fe80::7475:9ebf:d811:88c2]) by
 BJ-MBX02.mioffice.cn ([fe80::7475:9ebf:d811:88c2%17]) with mapi id
 15.02.0986.029; Thu, 25 Aug 2022 20:10:18 +0800
From:   =?utf-8?B?5p2O5L2z6ZOt?= <lijiaming3@xiaomi.com>
To:     Avri Altman <Avri.Altman@wdc.com>,
        Jiaming Li <lijiamingsofine@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbRXh0ZXJuYWwgTWFpbF1SRTogW1BBVENIXSBzY3NpOiB1ZnM6?=
 =?utf-8?B?IHVmc2ZibzogSW50cm9kdWNlIEZpbGUgQmFzZWQgT3B0aW1pemF0aW9uIGZl?=
 =?utf-8?Q?ature?=
Thread-Topic: [External Mail]RE: [PATCH] scsi: ufs: ufsfbo: Introduce File
 Based Optimization feature
Thread-Index: AQHYt5Yd7MdiBMU/V0WwXjppS39zs62/UTVAgAAxe1A=
Date:   Thu, 25 Aug 2022 12:10:18 +0000
Message-ID: <8500789bbd0b4a5b8452ee15d8530a32@xiaomi.com>
References: <20220824084633.14428-1-lijiamingsofine@gmail.com>
 <DM6PR04MB657511C55B06E40552C03378FC729@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB657511C55B06E40552C03378FC729@DM6PR04MB6575.namprd04.prod.outlook.com>
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

RGVhciBBdnJpDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIHdpbGwgbW9kaWZ5IGl0IGFjY29y
ZGluZyB0byB5b3VyIHN1Z2dlc3Rpb24uDQpBZnRlciB0aGUgbW9kaWZpY2F0aW9uLCBJIHdpbGwg
dHJ5IHRvIHN1Ym1pdCBpdCB0byBNYWlubGluZS4gVGhlcmVmb3JlLA0KdGhpcyBwYXRjaCBjYW4g
YmUgaWdub3JlZCwgSG93IGRvIEkgZGVsZXRlIGl0IG9uOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9wcm9qZWN0L2xpbnV4LXNjc2kvbGlzdC8gPw0KVGhhbmtzDQoNCi0tLS0t6YKu5Lu2
5Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQXZyaSBBbHRtYW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+
DQrlj5HpgIHml7bpl7Q6IDIwMjLlubQ45pyIMjXml6UgMTY6NTcNCuaUtuS7tuS6ujogSmlhbWlu
ZyBMaSA8bGlqaWFtaW5nc29maW5lQGdtYWlsLmNvbT47IGFsaW0uYWtodGFyQHNhbXN1bmcuY29t
OyBqZWpiQGxpbnV4LmlibS5jb20NCuaKhOmAgTogbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IOadjuS9s+mTrSA8bGlqaWFtaW5nM0B4aWFv
bWkuY29tPg0K5Li76aKYOiBbRXh0ZXJuYWwgTWFpbF1SRTogW1BBVENIXSBzY3NpOiB1ZnM6IHVm
c2ZibzogSW50cm9kdWNlIEZpbGUgQmFzZWQgT3B0aW1pemF0aW9uIGZlYXR1cmUNCg0KW+WklumD
qOmCruS7tl0g5q2k6YKu5Lu25p2l5rqQ5LqO5bCP57Gz5YWs5Y+45aSW6YOo77yM6K+36LCo5oWO
5aSE55CG44CCDQoNCj4gKw0KPiArLyogU1lTRlMgREVGSU5FICovDQo+ICsjZGVmaW5lIGRlZmlu
ZV9zeXNmc19ybyhfbmFtZSkgX19BVFRSKF9uYW1lLCAwNDQ0LCAgICAgICAgICAgICAgICAgICAg
IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1ZnNmYm9fc3lzZnNf
c2hvd18jI19uYW1lLCBOVUxMKQ0KPiArI2RlZmluZSBkZWZpbmVfc3lzZnNfd28oX25hbWUpIF9f
QVRUUihfbmFtZSwgMDIwMCwgICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwsIHVmc2Zib19zeXNmc19zdG9yZV8jI19uYW1l
KQ0KPiArI2RlZmluZSBkZWZpbmVfc3lzZnNfcncoX25hbWUpIF9fQVRUUihfbmFtZSwgMDY0NCwg
ICAgICAgICAgICAgICAgICAgICBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWZzZmJvX3N5c2ZzX3Nob3dfIyNfbmFtZSwgICAgICAgIFwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1ZnNmYm9fc3lzZnNfc3RvcmVfIyNfbmFtZSkNCj4g
K3N0YXRpYyBzdHJ1Y3QgdWZzZmJvX3N5c2ZzX2VudHJ5IHVmc2Zib19zeXNmc19lbnRyaWVzW10g
PSB7DQo+ICsgICAgICAgZGVmaW5lX3N5c2ZzX3JvKGZib19yZWNfbHJzKSwNCj4gKyAgICAgICBk
ZWZpbmVfc3lzZnNfcm8oZmJvX21heF9scnMpLA0KPiArICAgICAgIGRlZmluZV9zeXNmc19ybyhm
Ym9fbWluX2xycyksDQo+ICsgICAgICAgZGVmaW5lX3N5c2ZzX3JvKGZib19tYXhfbHJjKSwNCj4g
KyAgICAgICBkZWZpbmVfc3lzZnNfcm8oZmJvX2xyYSksDQo+ICsgICAgICAgZGVmaW5lX3N5c2Zz
X3JvKGZib19wcm9nX3N0YXRlKSwNCj4gKyAgICAgICBkZWZpbmVfc3lzZnNfcm8oZmJvX2dldF9s
cl9mcmFnX2xldmVsKSwNCj4gKyAgICAgICBkZWZpbmVfc3lzZnNfcm8oZmJvX3N1cHBvcnQpLA0K
PiArICAgICAgIGRlZmluZV9zeXNmc19ybyhmYm9fdmVyc2lvbiksDQo+ICsgICAgICAgZGVmaW5l
X3N5c2ZzX3dvKGZib19vcGVyYXRpb25fY29udHJvbCksDQo+ICsgICAgICAgZGVmaW5lX3N5c2Zz
X3dvKGZib19zZW5kX2xyX2xpc3QpLA0KPiArICAgICAgIGRlZmluZV9zeXNmc19ydyhmYm9fZXhl
X3RocmVzaG9sZCksDQo+ICsgICAgICAgZGVmaW5lX3N5c2ZzX3J3KGZib193aG9sZWZpbGVfZW5h
YmxlKSwNCj4gKyAgICAgICAvKiBkZWJ1ZyAqLw0KPiArICAgICAgIGRlZmluZV9zeXNmc19ydyhk
ZWJ1ZyksDQo+ICsgICAgICAgLyogQXR0cmlidXRlIChSQVcpICovDQo+ICsgICAgICAgZGVmaW5l
X3N5c2ZzX3J3KGJsb2NrX3N1c3BlbmQpLA0KPiArICAgICAgIGRlZmluZV9zeXNmc19ydyhhdXRv
X2hpYmVybjhfZW5hYmxlKSwNCj4gKyAgICAgICBfX0FUVFJfTlVMTA0KPiArfTsNCkxldHMgc3Rp
Y2sgdG8gdGhlIF9zdG9yZSAvIF9zaG93IG5hbWluZyBjb252ZW50aW9ucyAtIHBlb3BsZSByZWx5
IG9uIHRoYXQgd2hlbiB0aGV5IGFyZSBncmVwcGluZyB0aGUgY29kZS4NCkFsc28sIHlvdSBuZWVk
IHRvIGRvY3VtZW50IHRoZSBBQkkuDQoNClRoYW5rcywNCkF2cmkNCiMvKioqKioq5pys6YKu5Lu2
5Y+K5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO
5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i
5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO
5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB5oiW5pWj5Y+R77yJ5pys6YKu5Lu2
5Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+35oKo56uL5Y2z
55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu277yBIFRoaXMg
ZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3Ig
ZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZv
cm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBs
aW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3Ig
ZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGll
bnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3Is
IHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBh
bmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
