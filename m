Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31344EE8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiDAHNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343773AbiDAHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:12:54 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC79A1D67D2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:10:40 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1184:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 15:07:40 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 15:08:39 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 15:08:39 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Russell King - ARM Linux" <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v12 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021
 defconfig
Thread-Topic: [PATCH v12 9/9] ARM: sp7021_defconfig: Add Sunplus SP7021
 defconfig
Thread-Index: AQHYRNqKgpvhY+D7NEGLNwOJ/bBEBKzYrlGAgAGgdnA=
Date:   Fri, 1 Apr 2022 07:08:39 +0000
Message-ID: <334463c7f78b4b25a62ddd01bba5fe06@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <84a0839e7724fa39dd07fef491cf6bb357db2e7d.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a2SQCj8pqyJvS+TpgqQu51+YyB4SOi2cd_WU9ObgAjZOw@mail.gmail.com>
In-Reply-To: <CAK8P3a2SQCj8pqyJvS+TpgqQu51+YyB4SOi2cd_WU9ObgAjZOw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHUsIE1hciAzMSwgMjAyMiBhdCAxMDoyOSBBTSBRaW4gSmlhbiA8cWluamlhbkBjcXBs
dXMxLmNvbT4gd3JvdGU6DQo+ID4gQWRkIGdlbmVyaWMgU3VucGx1cyBTUDcwMjEgYmFzZWQgYm9h
cmQgZGVmY29uZmlnDQo+IA0KPiBIZXJlLCB5b3Ugc2hvdWxkIGV4cGxhaW4gd2h5IHlvdSBuZWVk
IGEgY3VzdG9tIGRlZmNvbmZpZyBmb3IgdGhpcyBTb0MsIGFzDQo+IG1vc3QgcGxhdGZvcm1zIGFy
ZSBmaW5lIGp1c3QgdXNpbmcgdGhlIGdlbmVyaWMgb25lLiBBcmUgeW91IHRvbyBtZW1vcnkNCj4g
Y29uc3RyYWluZWQsDQo+IG9yIGFyZSB0aGVyZSBvdGhlciBwcm9ibGVtcz8NCj4gDQoNCkZvciBt
ZW1vcnkgY29uc3RyYWluZWQgYm9hcmQgb25seS4NCg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdf
ZGVmY29uZmlnDQo+ID4gaW5kZXggODg2M2ZhOTY5Li5hM2JkOWRiZDggMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcNCj4gPiArKysgYi9hcmNoL2Fy
bS9jb25maWdzL211bHRpX3Y3X2RlZmNvbmZpZw0KPiA+IEBAIC04Niw2ICs4Niw3IEBAIENPTkZJ
R19NQUNIX1NQRUFSMTMxMD15DQo+ID4gIENPTkZJR19NQUNIX1NQRUFSMTM0MD15DQo+ID4gIENP
TkZJR19BUkNIX1NUST15DQo+ID4gIENPTkZJR19BUkNIX1NUTTMyPXkNCj4gPiArQ09ORklHX0FS
Q0hfU1VOUExVUz15DQo+ID4gIENPTkZJR19BUkNIX1NVTlhJPXkNCj4gPiAgQ09ORklHX0FSQ0hf
VEVHUkE9eQ0KPiA+ICBDT05GSUdfQVJDSF9VTklQSElFUj15DQo+IA0KPiBEb24ndCB5b3UgbmVl
ZCBhbnkgZHJpdmVycyBoZXJlPw0KPiANCg0KQ3VycmVudGx5LCBhbGwgYmFzaWMgZHJpdmVycyBh
dXRvIGVuYWJsZWQgYnkgbWFjaC1zdW5wbHVzL0tjb25maWc6DQouLi4NCmNvbmZpZyBTT0NfU1A3
MDIxDQoJYm9vbCAiU3VucGx1cyBTUDcwMjEgU29DIHN1cHBvcnQiDQoJZGVwZW5kcyBvbiBBUkNI
X1NVTlBMVVMNCglkZWZhdWx0IEFSQ0hfU1VOUExVUw0KCXNlbGVjdCBBUk1fR0lDDQoJc2VsZWN0
IEFSTV9QU0NJDQoJc2VsZWN0IFBJTkNUUkwNCglzZWxlY3QgUElOQ1RSTF9TUFBDVEwNCglzZWxl
Y3QgU0VSSUFMX1NVTlBMVVMNCglzZWxlY3QgU0VSSUFMX1NVTlBMVVNfQ09OU09MRQ0KDQphbmQg
ZHJpdmVyJ3MgS2NvbmZpZzoNCi4uLg0KY29uZmlnIFJFU0VUX1NVTlBMVVMNCiAgICAgICAgYm9v
bCAiU3VucGx1cyBTb0NzIFJlc2V0IERyaXZlciIgaWYgQ09NUElMRV9URVNUDQogICAgICAgIGRl
ZmF1bHQgQVJDSF9TVU5QTFVTDQouLi4NCg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9jb25m
aWdzL3NwNzAyMV9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3NwNzAyMV9kZWZjb25maWcN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMC4uY2RhMTZkMzNh
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3Mvc3A3MDIxX2Rl
ZmNvbmZpZw0KPiAuLi4NCj4gPiArQ09ORklHX0hBVkVfQVJNX0FSQ0hfVElNRVI9eQ0KPiANCj4g
SSBjaGVja2VkIHRoaXMgb25lIGFnYWluLCBhcyBtb3N0IG90aGVycyBkb24ndCBlbmFibGUgaXQg
aW4gdGhlIGRlZmNvbmZpZy4NCj4gDQo+IEkgZG9uJ3QgcmVtZW1iZXIgaWYgSSByZWNvbW1lbmRl
ZCByZW1vdmluZyB0aGUgJ3NlbGVjdCcgZnJvbSBLY29uZmlnDQo+IGluIGEgcHJldmlvdXMgcm91
bmQsIGJ1dCBhcyB0aGF0IGlzIHdoZXJlIG90aGVyIHBsYXRmb3JtcyBoYXZlIGl0LCBJJ2QgYWRk
DQo+IGl0IHRoZXJlIGFzIHdlbGwuDQo+IA0KDQpJJ2xsIG1vdmUgdGhpcyB0byBtYWNoLXN1bnBs
dXMvS2NvbmZpZy4NCg0KPiA+ICtDT05GSUdfU1RBR0lORz15DQo+IA0KPiBEbyB5b3UgYWN0dWFs
bHkgZW5hYmxlIGFueSBzdGFnaW5nIGRyaXZlcnMgaGVyZT8gSWYgbm90LCBJJ2QgZHJvcCB0aGF0
IGJpdC4NCj4gDQoNCknigJlsbCBkcm9wIGl0Lg0KDQoNClRoYW5rcyBhbGwgeW91ciBjb21tZW50
cy4NCg==
