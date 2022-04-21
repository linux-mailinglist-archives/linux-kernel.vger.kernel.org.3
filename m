Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A620A509479
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 03:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383567AbiDUBDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 21:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383539AbiDUBD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:03:28 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56206635A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 18:00:37 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(26448:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Thu, 21 Apr 2022 09:00:30 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 21 Apr
 2022 09:00:29 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0986.022; Thu, 21 Apr 2022
 09:00:29 +0800
From:   =?utf-8?B?Y3lfaHVhbmco6buD5ZWf5Y6fKQ==?= <cy_huang@richtek.com>
To:     "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH -next] usb: typec: rt1719: Fix build error without
 CONFIG_POWER_SUPPLY
Thread-Topic: [PATCH -next] usb: typec: rt1719: Fix build error without
 CONFIG_POWER_SUPPLY
Thread-Index: AQHYUv3jFuNUpuVhu0m8/3w4zMWNwaz3/8cAgAEKg4A=
Date:   Thu, 21 Apr 2022 01:00:29 +0000
Message-ID: <1650502829.3170.4.camel@richtek.com>
References: <20220418082425.41566-1-renzhijie2@huawei.com>
         <Yl/NHAaXFh1UzFdI@kuha.fi.intel.com>
In-Reply-To: <Yl/NHAaXFh1UzFdI@kuha.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
x-originating-ip: [192.168.18.182]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B109A5E77EE694C943C1D31BADFFCCC@rt.l>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5pa8IOS4ie+8jDIwMjItMDQtMjAg5pa8IDEyOjA2ICswMzAw77yMSGVpa2tpIEtyb2dlcnVzIOaP
kOWIsO+8mg0KPiBNb24sIEFwciAxOCwgMjAyMiBhdCAwNDoyNDoyNVBNICswODAwLCBSZW4gWmhp
amllIGtpcmpvaXR0aToNCj4gPg0KPiA+IEJ1aWxkaW5nIHdpdGhvdXQgQ09ORklHX1BPV0VSX1NV
UFBMWSB3aWxsIGZhaWw6DQo+ID4NCj4gPiBkcml2ZXJzL3VzYi90eXBlYy9ydDE3MTkubzogSW4g
ZnVuY3Rpb24gYHJ0MTcxOV9wc3lfc2V0X3Byb3BlcnR5JzoNCj4gPiBydDE3MTkuYzooLnRleHQr
MHgxMGEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBwb3dlcl9zdXBwbHlfZ2V0X2RydmRhdGEn
DQo+ID4gZHJpdmVycy91c2IvdHlwZWMvcnQxNzE5Lm86IEluIGZ1bmN0aW9uIGBydDE3MTlfcHN5
X2dldF9wcm9wZXJ0eSc6DQo+ID4gcnQxNzE5LmM6KC50ZXh0KzB4MmM4KTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgcG93ZXJfc3VwcGx5X2dldF9kcnZkYXRhJw0KPiA+IGRyaXZlcnMvdXNiL3R5
cGVjL3J0MTcxOS5vOiBJbiBmdW5jdGlvbiBgZGV2bV9ydDE3MTlfcHN5X3JlZ2lzdGVyJzoNCj4g
PiBydDE3MTkuYzooLnRleHQrMHgzZTkpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBkZXZtX3Bv
d2VyX3N1cHBseV9yZWdpc3RlcicNCj4gPiBkcml2ZXJzL3VzYi90eXBlYy9ydDE3MTkubzogSW4g
ZnVuY3Rpb24gYHJ0MTcxOV9pcnFfaGFuZGxlcic6DQo+ID4gcnQxNzE5LmM6KC50ZXh0KzB4Zjlm
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgcG93ZXJfc3VwcGx5X2NoYW5nZWQnDQo+ID4gZHJp
dmVycy91c2IvdHlwZWMvcnQxNzE5Lm86IEluIGZ1bmN0aW9uIGBydDE3MTlfdXBkYXRlX3B3cl9v
cG1vZGUucGFydC45JzoNCj4gPiBydDE3MTkuYzooLnRleHQrMHg2NTcpOiB1bmRlZmluZWQgcmVm
ZXJlbmNlIHRvIGBwb3dlcl9zdXBwbHlfY2hhbmdlZCcNCj4gPiBkcml2ZXJzL3VzYi90eXBlYy9y
dDE3MTkubzogSW4gZnVuY3Rpb24gYHJ0MTcxOV9hdHRhY2gnOg0KPiA+IHJ0MTcxOS5jOigudGV4
dCsweDgzZSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHBvd2VyX3N1cHBseV9jaGFuZ2VkJw0K
PiA+DQo+ID4gQWRkIFBPV0VSX1NVUFBMWSBkZXBlbmRlbmN5IHRvIEtjb25maWcuDQpUaGFua3Mu
DQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+
ID4gRml4ZXM6IDI1ZDI5Yjk4MDkxMiAoInVzYjogdHlwZWM6IHJ0MTcxOTogQWRkIHN1cHBvcnQg
Zm9yIFJpY2h0ZWsgUlQxNzE5IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSZW4gWmhpamllIDxyZW56
aGlqaWUyQGh1YXdlaS5jb20+DQo+IFJldmlld2VkLWJ5OiBIZWlra2kgS3JvZ2VydXMgPGhlaWtr
aS5rcm9nZXJ1c0BsaW51eC5pbnRlbC5jb20+DQpSZXZpZXdlZC1ieTogQ2hpWXVhbiBIdWFuZyA8
Y3lfaHVhbmdAcmljaHRlay5jb20+DQoNCg0KLS0tDQogZHJpdmVycy91c2IvdHlwZWMvS2NvbmZp
ZyB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvdHlwZWMvS2NvbmZpZyBiL2RyaXZlcnMvdXNiL3R5cGVjL0tjb25maWcNCmlu
ZGV4IDhmOTIxMjEzYjE3ZC4uYmEyNDg0N2ZiMjQ1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
dHlwZWMvS2NvbmZpZw0KKysrIGIvZHJpdmVycy91c2IvdHlwZWMvS2NvbmZpZw0KQEAgLTU2LDYg
KzU2LDcgQEAgY29uZmlnIFRZUEVDX1JUMTcxOQ0KIHRyaXN0YXRlICJSaWNodGVrIFJUMTcxOSBT
aW5rIE9ubHkgVHlwZS1DIGNvbnRyb2xsZXIgZHJpdmVyIg0KIGRlcGVuZHMgb24gVVNCX1JPTEVf
U1dJVENIIHx8ICFVU0JfUk9MRV9TV0lUQ0gNCiBkZXBlbmRzIG9uIEkyQw0KK2RlcGVuZHMgb24g
UE9XRVJfU1VQUExZDQogc2VsZWN0IFJFR01BUF9JMkMNCiBoZWxwDQogICBTYXkgWSBvciBNIGhl
cmUgaWYgeW91ciBzeXN0ZW0gaGFzIFJpY2h0ZWsgUlQxNzE5IHNpbmsgb25seQ0KLS0NCjIuMTcu
MQ0KDQoNCg0KDQoqKioqKioqKioqKioqIEVtYWlsIENvbmZpZGVudGlhbGl0eSBOb3RpY2UgKioq
KioqKioqKioqKioqKioqKioNCg0KVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlzIGUt
bWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBtYXkgYmUgY29uZmlkZW50
aWFsLCBwcm9wcmlldGFyeSwgcHJpdmlsZWdlZCwgb3Igb3RoZXJ3aXNlIGV4ZW1wdCBmcm9tIGRp
c2Nsb3N1cmUgdW5kZXIgYXBwbGljYWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZSBjb252
ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVkIHJlY2lwaWVudChzKS4gQW55IHVzZSwgZGlzc2Vt
aW5hdGlvbiwgZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2Yg
dGhpcyBlLW1haWwgKGluY2x1ZGluZyBpdHMgYXR0YWNobWVudHMpIGJ5IHVuaW50ZW5kZWQgcmVj
aXBpZW50KHMpIGlzIHN0cmljdGx5IHByb2hpYml0ZWQgYW5kIG1heSBiZSB1bmxhd2Z1bC4gSWYg
eW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLCBvciBiZWxp
ZXZlIHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBu
b3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSAoYnkgcmVwbHlpbmcgdG8gdGhpcyBlLW1haWwp
LCBkZWxldGUgYW55IGFuZCBhbGwgY29waWVzIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55
IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVtLCBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBj
b250ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCg==
