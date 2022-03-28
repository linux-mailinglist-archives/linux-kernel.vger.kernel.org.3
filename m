Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF84E90C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiC1JJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238346AbiC1JJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:09:28 -0400
Received: from mail.meizu.com (edge01.meizu.com [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103A613CC7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 02:07:47 -0700 (PDT)
Received: from IT-EXMB-1-123.meizu.com (172.16.1.123) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 28 Mar
 2022 17:07:45 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-123.meizu.com (172.16.1.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 28 Mar 2022 17:07:44 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Mon, 28 Mar 2022 17:07:44 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "straube.linux@gmail.com" <straube.linux@gmail.com>,
        "martin@kaiser.cx" <martin@kaiser.cx>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFYyXSBzdGFnaW5nOiByODE4OGV1OiBEaXJlY3RseSBy?=
 =?gb2312?B?ZXR1cm4gX1NVQ0NFU1MgaW5zdGVhZCBvZiB1c2luZyBsb2NhbCByZXQgdmFy?=
 =?gb2312?Q?iable?=
Thread-Topic: [PATCH V2] staging: r8188eu: Directly return _SUCCESS instead of
 using local ret variable
Thread-Index: AQHYQn/ynpKI+ybssEqkIpZT65/a3qzT9eCAgACLIh4=
Date:   Mon, 28 Mar 2022 09:07:44 +0000
Message-ID: <be09d628f09041ac8f2c7bf2e9d5a13d@meizu.com>
References: <1648457028-4226-1-git-send-email-baihaowen@meizu.com>,<YkF2MRdxlUWow0UC@kroah.com>
In-Reply-To: <YkF2MRdxlUWow0UC@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEdyZWcgS0gNCg0KWWVzLCBJIHRoaW5rIHN5bmMgcnRsODcyM2JzIGFuZCByODE4OGV1IHdp
bGwgYmUgYmV0dGVyIGFzIHRoZXkgaGF2ZSBzYW1lIHByb2JsZW0uDQoNCmNvbW1pdCAwNjc3NTZh
Y2RhYzhlMGRkOTFlZGY0ODAwZTg0NGZjYjZlMGNjNzJhDQpBdXRob3I6IEhhcmlwcmFzYWQgS2Vs
YW0gPGhhcmlwcmFzYWQua2VsYW1AZ21haWwuY29tPg0KRGF0ZTogICBNb24gSnVsIDE1IDIzOjE2
OjE4IDIwMTkgKzA1MzANCg0KICAgIHN0YWdpbmc6IHJ0bDg3MjNiczogY29yZTogQ2hhbmdlIHJl
dHVybiB0eXBlIG9mIGluaXRfbWxtZV9leHRfcHJpdg0KDQogICAgQXMgaW5pdF9tbG1lX2V4dF9w
cml2IGZ1bmN0aW9uIGFsd2F5cyByZXR1cm5zIFNVQ0NFU1MgLCBXZSBjYW4gY2hhbmdlDQogICAg
cmV0dXJuIHR5cGUgZnJvbSBpbnQgdG8gdm9pZC4NCg0KICAgIEZpeGVzIGJlbG93IGlzc3VlIGlk
ZW50aWZpZWQgYnkgY29jY2ljaGVjaw0KICAgIGRyaXZlcnMvc3RhZ2luZy9ydGw4NzIzYnMvY29y
ZS9ydHdfbWxtZV9leHQuYzo0NjQ6NS04OiBVbm5lZWRlZA0KICAgIHZhcmlhYmxlOiAicmVzIi4g
UmV0dXJuICJfU1VDQ0VTUyIgb24gbGluZSA0OTINCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZz4NCreiy83KsbzkOiAyMDIyxOoz1MIyOMjVIDE2OjQ3OjQ1DQrK1bz+yMs6ILDXusbOxA0K
s63LzTogTGFycnkuRmluZ2VyQGx3ZmluZ2VyLm5ldDsgcGhpbEBwaGlscG90dGVyLmNvLnVrOyBz
dHJhdWJlLmxpbnV4QGdtYWlsLmNvbTsgbWFydGluQGthaXNlci5jeDsgbGludXgtc3RhZ2luZ0Bs
aXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBb
UEFUQ0ggVjJdIHN0YWdpbmc6IHI4MTg4ZXU6IERpcmVjdGx5IHJldHVybiBfU1VDQ0VTUyBpbnN0
ZWFkIG9mIHVzaW5nIGxvY2FsIHJldCB2YXJpYWJsZQ0KDQpPbiBNb24sIE1hciAyOCwgMjAyMiBh
dCAwNDo0Mzo0OFBNICswODAwLCBIYW93ZW4gQmFpIHdyb3RlOg0KPiBmaXhlcyBjb2NjaW5lbGxl
IHdhcm5pbmc6DQo+IC4vZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfbWxtZV9leHQu
YzozNTc6NS04OiBVbm5lZWRlZCB2YXJpYWJsZTogInJlcyIuDQo+ICBSZXR1cm4gIl9TVUNDRVNT
IiBvbiBsaW5lIDM4MA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBIYW93ZW4gQmFpIDxiYWloYW93ZW5A
bWVpenUuY29tPg0KPiAtLS0NCj4gVjEtPlYyOiBzcGxpdCBpbnRvIHR3byBwYXRjaGVzLg0KPg0K
PiAgZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfbWxtZV9leHQuYyB8IDMgKy0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3JlL3J0d19tbG1lX2V4dC5jIGIv
ZHJpdmVycy9zdGFnaW5nL3I4MTg4ZXUvY29yZS9ydHdfbWxtZV9leHQuYw0KPiBpbmRleCA5MzFl
NmYyLi40YjdiMGVlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvcjgxODhldS9jb3Jl
L3J0d19tbG1lX2V4dC5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9yODE4OGV1L2NvcmUvcnR3
X21sbWVfZXh0LmMNCj4gQEAgLTM1NCw3ICszNTQsNiBAQCBzdGF0aWMgdTggaW5pdF9jaGFubmVs
X3NldChzdHJ1Y3QgYWRhcHRlciAqcGFkYXB0ZXIsIHU4IENoYW5uZWxQbGFuLCBzdHJ1Y3QgcnRf
Yw0KPg0KPiAgaW50ICBpbml0X21sbWVfZXh0X3ByaXYoc3RydWN0IGFkYXB0ZXIgKnBhZGFwdGVy
KQ0KPiAgew0KPiAtICAgICBpbnQgICAgIHJlcyA9IF9TVUNDRVNTOw0KPiAgICAgICBzdHJ1Y3Qg
cmVnaXN0cnlfcHJpdiAqcHJlZ2lzdHJ5cHJpdiA9ICZwYWRhcHRlci0+cmVnaXN0cnlwcml2Ow0K
PiAgICAgICBzdHJ1Y3QgbWxtZV9leHRfcHJpdiAqcG1sbWVleHQgPSAmcGFkYXB0ZXItPm1sbWVl
eHRwcml2Ow0KPiAgICAgICBzdHJ1Y3QgbWxtZV9wcml2ICpwbWxtZXByaXYgPSAmcGFkYXB0ZXIt
Pm1sbWVwcml2Ow0KPiBAQCAtMzc3LDcgKzM3Niw3IEBAIGludCAgICAgICBpbml0X21sbWVfZXh0
X3ByaXYoc3RydWN0IGFkYXB0ZXIgKnBhZGFwdGVyKQ0KPg0KPiAgICAgICBwbWxtZWV4dC0+YWN0
aXZlX2tlZXBfYWxpdmVfY2hlY2sgPSB0cnVlOw0KPg0KPiAtICAgICByZXR1cm4gcmVzOw0KPiAr
ICAgICByZXR1cm4gX1NVQ0NFU1M7DQoNCklmIGEgZnVuY3Rpb24gY2FuIG9ubHkgZXZlciBzdWNj
ZWVkLCB3aHkgcmV0dXJuIGFueXRoaW5nPyAgUGxlYXNlIG1ha2UNCnRoaXMgYSBmdW5jdGlvbiBy
ZXR1cm4gdm9pZC4NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0K
