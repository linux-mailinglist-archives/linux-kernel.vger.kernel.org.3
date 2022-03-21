Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841924E2305
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbiCUJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiCUJOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:14:04 -0400
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43A81DB4BE;
        Mon, 21 Mar 2022 02:12:38 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(37793:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 21 Mar 2022 17:13:00 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 21 Mar 2022 17:12:54 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 21 Mar 2022 17:12:54 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v4 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Index: AQHYOzO6cpYNd+UZBku5eHHWG55gaqzHpeaAgAGhbhD//8C6gIAAiLaA
Date:   Mon, 21 Mar 2022 09:12:54 +0000
Message-ID: <65f7b13e2c9d4bf484ecfd29b6ab4cc7@sphcmbx02.sunplus.com.tw>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
 <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org>
 <c6ecbe40dc234454b41bcbc0bf073084@sphcmbx02.sunplus.com.tw>
 <ef173db6-4635-8a77-c3e3-d96b0c2fa7a3@kernel.org>
In-Reply-To: <ef173db6-4635-8a77-c3e3-d96b0c2fa7a3@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
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

RGVhciBrcnp5c3p0b2Y6DQoNCj4gPj4+ICsJaW50IGRtYV9pbnRfdGhyZXNob2xkOw0KPiA+Pj4g
KwlzdHJ1Y3Qgc2dfbWFwcGluZ19pdGVyIHNnX21pdGVyOyAvKiBmb3IgcGlvIG1vZGUgdG8gYWNj
ZXNzIHNnbGlzdCAqLw0KPiA+Pj4gKwlpbnQgZG1hX3VzZV9pbnQ7IC8qIHNob3VsZCByYWlzZSBp
cnEgd2hlbiBkbWEgZG9uZSAqLw0KPiA+Pj4gKwlzdHJ1Y3Qgc3BtbWNfdHVuaW5nX2luZm8gZW1t
Y190dW5pbmdfaW5mbzsNCj4gPj4+ICsJc3RydWN0IHNwc2RjX3R1bmluZ19pbmZvIHNkX3R1bmlu
Z19pbmZvOw0KPiA+Pj4gKwlpbnQgcmVzdG9yZV80Yml0X3NkaW9fYnVzOw0KPiA+Pj4gKwljb25z
dCBzdHJ1Y3Qgc3BtbWNfY29tcGF0aWJsZSAqZGV2X2NvbXA7IH07DQo+ID4+PiArDQo+ID4+PiAr
c3RydWN0IHNwc2RjX2hvc3Qgew0KPiA+Pg0KPiA+PiBXaGVyZSBpcyB0aGlzIHVzZWQ/DQo+ID4+
DQo+ID4NCj4gPiBzdHJ1Y3Qgc3BtbWNfaG9zdHt9IGZvciBlbW1jLg0KPiA+IHN0cnVjdCBzcHNk
Y19ob3N0e30gZm9yIFNEIGNhcmQuDQo+ID4gVGhlIHJlZ2lzdGVyIGJhc2UgYWRkcmVzcyBhbmQg
b2Zmc2V0IGFkZHJlc3Mgb2YgZW1tYyBhbmQgc2QgY2FyZHMgYXJlDQo+IGRpZmZlcmVudC4NCj4g
PiBlTU1DIGFuZCBzZGNhcmQgYXJlIHRoZWlyIHJlc3BlY3RpdmUgaGFyZHdhcmUgc2V0dGluZ3Mu
DQo+IA0KPiANCj4gVGhpcyBpcyBhIHdlaXJkIGFuc3dlci4gSSBhc2tlZCB3aGVyZSBpcyB0aGlz
IHVzZWQgKHN0cnVjdCBzcHNkY19ob3N0KS4NCj4gVGhlcmUgaXMgbm8gc2luZ2xlIHJlZmVyZW5j
ZSBvZiB0aGlzIHR5cGUuIFlvdXIgYW5zd2VyIGRvZXMgbm90IGNvdmVyIGl0IGFsbC4gSQ0KPiBr
bm93IHRoYXQgZU1NQyBhbmQgU0QgYXJlIGRpZmZlcmVudC4gVGhhdCB3YXMgbm90IHRoZSBxdWVz
dGlvbi4NCj4gVGhlIHF1ZXN0aW9uIGlzOiBwb2ludCBtZSB0byB0aGUgY29kZSB3aGljaCB1c2Vz
IHRoaXMgdHlwZS4NCj4gDQoNClNvcnJ5LCBJIHdpbGwgcmVtb3ZlIHN0cnVjdCBzcHNkY19ob3N0
IHt9Lg0KDQo=
