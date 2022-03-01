Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4D4C85E2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiCAIFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiCAIFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:05:08 -0500
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F9C270CDC;
        Tue,  1 Mar 2022 00:04:25 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59936:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Tue, 01 Mar 2022 16:04:29 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 1 Mar 2022 16:04:23 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 1 Mar 2022 16:04:23 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v4 1/2] thermal: Add thermal driver for Sunplus SP7021
Thread-Topic: [PATCH v4 1/2] thermal: Add thermal driver for Sunplus SP7021
Thread-Index: AQHYCPBYT2nt6KgunEqzmIXgO8c/PKykAUMAgAZvzrA=
Date:   Tue, 1 Mar 2022 08:04:23 +0000
Message-ID: <eb063f1a287049a1942625b846c0764d@sphcmbx02.sunplus.com.tw>
References: <cover.1642127137.git.lhjeff911@gmail.com>
 <2847f96335da1c74dfbee7ba67939bdc474ba2a4.1642127137.git.lhjeff911@gmail.com>
 <48c9fecc-67eb-891c-fb07-30ae4691031c@linaro.org>
In-Reply-To: <48c9fecc-67eb-891c-fb07-30ae4691031c@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXIgRGFuaWVsIExlemNhbm86DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXcgDQoNCj4g
UGxlYXNlIGNoZWNrIHRoZSBoZWFkZXJzIGFib3ZlLiBTb21lIGFyZSBub3QgbmVjZXNzYXJ5IChl
ZyBjcHVmcmVxLA0KPiBkZWxheSwgcnRjIC4uLikgQUZBSUNUDQo+IA0KPiA+ICsjZGVmaW5lIERJ
U0FCTEVfVEhSRU1BTAkJKEJJVCgzMSkgfCBCSVQoMTUpKQ0KPiA+ICsjZGVmaW5lIEVOQUJMRV9U
SFJFTUFMCQlCSVQoMzEpDQo+ID4gKyNkZWZpbmUgU1BfVEhSRU1BTF9NQVNLCQlHRU5NQVNLKDEw
LCAwKQ0KPiANCj4gVEhSRU1BTCA/DQo+IA0KPiBzL1RIUkVNQUwvVEhFUk1BTC8gPw0KDQpTb3Jy
eSwgSSdsbCBjb3JyZWN0IGl0IGluIG5leHQgY29tbWl0Lg0KDQo+ID4gK3N0YXRpYyBjaGFyICpz
cDcwMjFfb3RwX2NvZWZfcmVhZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHNzaXplX3QgKmxlbikNCj4g
PiArew0KPiA+ICsJY2hhciAqcmV0ID0gTlVMTDsNCj4gPiArCXN0cnVjdCBudm1lbV9jZWxsICpj
ID0gbnZtZW1fY2VsbF9nZXQoZGV2LCAiY2FsaWIiKTsNCj4gPiArDQo+ID4gKwlpZiAoSVNfRVJS
X09SX05VTEwoYykpDQo+ID4gKwkJcmV0dXJuIE5VTEw7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbnZt
ZW1fY2VsbF9yZWFkKGMsIGxlbik7DQo+ID4gKwludm1lbV9jZWxsX3B1dChjKTsNCj4gDQo+IFRo
YXQgaXMgd3JvbmcuIFBsZWFzZSByZWZlciB0byB0aGUgZG9jdW1lbnRhdGlvbiBkcml2ZXItYXBp
L252bWVtLnJzdA0KPiANCj4gbnZtZW1fY2VsbF9wdXQoKSBtdXN0IGJlIGNhbGxlZCB3aGVuIHRo
ZSBwb2ludGVyIHJldHVybmVkIGJ5DQo+IG52bWVtX2NlbGxfcmVhZCgpIGlzIG5vIGxvbmdlciB1
c2VkLg0KPg0KDQpTb3JyeSBmb3IgdGhhdC4gSSBkb24ndCBrbm93IHdoaWNoIHBhcnQgaXMgd3Jv
bmcuDQpudm1lbV9jZWxsX3B1dCgpIGhhcyBiZWVuIGNhbGxlZCBhZnRlciBudm1lbV9jZWxsX3Jl
YWQoKQ0KSSBhbSBjb2RpbmcgYWNjb3JkaW5nIHRvIHRoZSBleGFtcGxlLg0KDQoNCj4gZHVwbGlj
YXRlIGxpbmUNCj4gDQo+ID4gKwlzcF9kYXRhLT5vdHBfdGVtcDAgPSBGSUVMRF9HRVQoU1BfVEhS
RU1BTF9NQVNLLCBzcF9kYXRhLT5vdHBfdGVtcDApOw0KPiA+ICsJc3BfZGF0YS0+b3RwX3RlbXAx
ID0gKG90cF92WzFdID4+IDMpIHwgKG90cF92WzJdIDw8IDUpOw0KPiA+ICsJc3BfZGF0YS0+b3Rw
X3RlbXAxID0gRklFTERfR0VUKFNQX1RIUkVNQUxfTUFTSywgc3BfZGF0YS0+b3RwX3RlbXAxKTsN
Cj4gPiArCWlmIChzcF9kYXRhLT5vdHBfdGVtcDAgPT0gMCkNCj4gPiArCQlzcF9kYXRhLT5vdHBf
dGVtcDAgPSBURU1QX09UUF9CQVNFOw0KPiANCj4gQ2FuIHlvdSBhZGQgYSBjb21tZW50IGV4cGxh
aW5pbmcgaG93IGlzIHN0b3JlZCB0aGUgY29lZiBpbiB0aGUgbnZjZWxsLA0KPiBzbyB3ZSBjYW4g
dW5kZXJzdGFuZCB0aGUgYWJvdmUgYWN0aW9ucyA/DQo+IA0KPg0KDQpJcyB0aGUgY29tbWVudCBi
ZWxvdyBvaz8NCg0KLyoNCiAqV2hlbiByZW1hbnVmYWN0dXJpbmcsIHRoZSAzNSBkZWdyZWUgVF9D
T0RFIHdpbGwgYmUgcmVhZCBhbmQgc3RvcmVkIGluIG52Y2VsbC4NCiAqVEVNUF9SQVRFIGlzIHRo
ZSBTUDcwMjEgdGVtcGVyYXR1cmUgc2xvcGUuDQogKlRfQ09ERSA6IDExIGRpZ2l0cyBpbiB0b3Rh
bA0KKi8NCg0KDQoNCg==
