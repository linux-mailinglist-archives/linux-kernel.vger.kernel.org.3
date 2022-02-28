Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73844C66CD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiB1KGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiB1KGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:06:09 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C69DF2C65C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:05:21 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26018:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Mon, 28 Feb 2022 18:04:15 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 28 Feb 2022 18:04:34 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Mon, 28 Feb 2022 18:04:34 +0800
From:   =?utf-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Subject: RE: [PATCH v6 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Topic: [PATCH v6 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Index: AQHYKVJTp9Up30rwj02N8d6jm1zUlayj+OgAgATCP5A=
Date:   Mon, 28 Feb 2022 10:04:34 +0000
Message-ID: <f61d99bff64e4a49b2a2943d01d9b6d2@cqplus1.com>
References: <20220224074242.6944-1-xt.hu@cqplus1.com>
 <20220224074242.6944-3-xt.hu@cqplus1.com>
 <6620b35b-5475-fe6d-5149-d8cb4fb834d5@roeck-us.net>
In-Reply-To: <6620b35b-5475-fe6d-5149-d8cb4fb834d5@roeck-us.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.16]
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

Li4uDQo+ID4gKw0KPiA+ICsvKiBUSU1FT1VUX01BWCA9IGZmZmYwLzkwa0h6ID0xMS42NSxzbyBs
b25nZXIgdGhhbiAxMSBzZWNvbmRzIHdpbGwgdGltZSBvdXQgKi8NCj4gPiArc3RhdGljIGludCBz
cF93ZHRfcGluZyhzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGV2KQ0KPiA+ICt7DQo+ID4gKwlz
dHJ1Y3Qgc3Bfd2R0X3ByaXYgKnByaXYgPSB3YXRjaGRvZ19nZXRfZHJ2ZGF0YSh3ZGV2KTsNCj4g
PiArCXZvaWQgX19pb21lbSAqYmFzZSA9IHByaXYtPmJhc2U7DQo+ID4gKwl1MzIgY291bnQ7DQo+
ID4gKwl1MzIgYWN0dWFsOw0KPiA+ICsNCj4gPiArCWFjdHVhbCA9IG1pbih3ZGV2LT50aW1lb3V0
LCBTUF9XRFRfTUFYX1RJTUVPVVQpOw0KPiA+ICsNCj4gPiArCWlmIChhY3R1YWwgPiBTUF9XRFRf
TUFYX1RJTUVPVVQpIHsNCj4gDQo+IFRoaXMgaXMgbmV2ZXIgdHJ1ZS4gYmVjYXVzZSBhY3R1YWwg
aXMgc2V0IHRvIHRoZSBtaW5pbXVtIG9mIHdkZXYtPnRpbWVvdXQNCj4gYW5kIFNQX1dEVF9NQVhf
VElNRU9VVC4gSXQgaXMgYWxzbyBub3QgY2xlYXIgdG8gbWUgd2hhdCB0aGlzIGNvZGUgcGF0aA0K
PiBpcyBzdXBwb3NlZCB0byBiZSBkb2luZywgY29tcGFyZWQgdG8gdGhlIGNvZGUgYmVsb3cuIFBs
ZWFzZSBmaXggYW5kIGFkZA0KPiBhIGNvbW1lbnQgZXhwbGFpbmluZyB0aGUgY29kZSAoaWUgd2hh
dCBkb2VzIHdyaXRpbmcgV0RUX0NPTk1BWCBpbnRvDQo+IHRoZSBjb250cm9sIHJlZ2lzdGVyIGRv
ID8pDQo+IA0KDQpJIHdpbGwgZml4ICJpZiAoYWN0dWFsID4gU1BfV0RUX01BWF9USU1FT1VUKSIg
dG8gImlmICh3ZGV2LT50aW1lb3V0ID4gDQpTUF9XRFRfTUFYX1RJTUVPVVQpIi4gSSB3aWxsIGFk
ZCBjb21tZW50ICJXRFRfQ09OTUFYIHNldHMgdGhlIA0KY291bnQgdG8gdGhlIG1heGltdW0gKGRv
d24tY291bnRpbmcpLiINCldoZW4gdGltZW91dCA+IFNQX1dEVF9NQVhfVElNRU9VVCwgSSB0cnkg
dG8gc2V0IGEgc21hbGxlciB2YWx1ZSBvciANCmRvIG5vdGhpbmcuIFdhdGNoZG9nIGRyaXZlciBk
b24ndCB3b3JrIHByb3Blcmx5Lg0KDQo+ID4gKwkJd3JpdGVsKFdEVF9DT05NQVgsIGJhc2UgKyBX
RFRfQ1RSTCk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXdyaXRlbChXRFRfVU5MT0NLLCBiYXNl
ICsgV0RUX0NUUkwpOw0KPiA+ICsJCS8qIHRpZW1yd19jbnRbMzowXWNhbid0IGJlIHdyaXRlLG9u
bHkgWzE5OjRdIGNhbiBiZSB3cml0ZS4gKi8NCj4gDQo+IHRpbWVyd19jbmQgPywgc3BhY2UgYmVm
b3JlIGNhbid0LCBhbmQgcy93cml0ZS93cml0dGVuL2cuDQo+IA0KPiA+ICsJCWNvdW50ID0gKGFj
dHVhbCAqIFNUQ19DTEspID4+IDQ7DQo+IA0KPiBzbyB0aGlzIGlzIChhY3R1YWwgKiA5MDAwMCkg
Pj4gNCBhbmQgZG9lcyBzZXQgYml0IDAuLjMuIElzIHRoYXQgaW50ZW50aW9uYWwNCj4gb3IgaXMg
aXQgc3VwcG9zZWQgdG8gYmUgPDwgNCA/IFRoZSBjb21tZW50IGFib3ZlIGRvZXMgbm90IHJlYWxs
eSBleHBsYWluDQo+IHRoZSBjYWxjdWxhdGlvbjsgaWYgYW55dGhpbmcsIGl0IGp1c3QgY3JlYXRl
cyBjb25mdXNpb24uDQo+IA0KDQpJIHdpbGwgYWRkIGNvbW1lbnQgIldhdGNoZG9nIHRpbWVyIGlz
IGEgMjAtYml0IGRvd24tY291bnRpbmcgYmFzZWQgDQpvbiBTVENfQ0xLLiBUaGlzIHJlZ2lzdGVy
IGJpdHNbMTZdflswXSBpcyBmcm9tIGJpdFsxOV1+Yml0WzRdIG9mIHRoZSANCndhdGNoZG9nIHRp
bWVyIGNvdW50ZXIuICINCg0KVGhhbmtzLA0KQmVzdCBSZWdhcmRzDQo=
