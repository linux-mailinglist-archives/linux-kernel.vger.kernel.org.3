Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA04E217E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344995AbiCUHlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344992AbiCUHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:41:28 -0400
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEF8425E89;
        Mon, 21 Mar 2022 00:40:00 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(37794:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 21 Mar 2022 15:40:15 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 21 Mar 2022 15:40:09 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 21 Mar 2022 15:40:09 +0800
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
Thread-Index: AQHYOzO6cpYNd+UZBku5eHHWG55gaqzHpeaAgAGhbhCAAC9fIA==
Date:   Mon, 21 Mar 2022 07:40:09 +0000
Message-ID: <540322dcc7b246c5939e14abd3064cde@sphcmbx02.sunplus.com.tw>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
 <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org> 
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

RGVhciBLcnp5c3p0b2Y6DQoNCj4gPg0KPiA+ID4gKwlpbnQgZG1hX2ludF90aHJlc2hvbGQ7DQo+
ID4gPiArCXN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIgc2dfbWl0ZXI7IC8qIGZvciBwaW8gbW9kZSB0
byBhY2Nlc3Mgc2dsaXN0ICovDQo+ID4gPiArCWludCBkbWFfdXNlX2ludDsgLyogc2hvdWxkIHJh
aXNlIGlycSB3aGVuIGRtYSBkb25lICovDQo+ID4gPiArCXN0cnVjdCBzcG1tY190dW5pbmdfaW5m
byBlbW1jX3R1bmluZ19pbmZvOw0KPiA+ID4gKwlzdHJ1Y3Qgc3BzZGNfdHVuaW5nX2luZm8gc2Rf
dHVuaW5nX2luZm87DQo+ID4gPiArCWludCByZXN0b3JlXzRiaXRfc2Rpb19idXM7DQo+ID4gPiAr
CWNvbnN0IHN0cnVjdCBzcG1tY19jb21wYXRpYmxlICpkZXZfY29tcDsgfTsNCj4gPiA+ICsNCj4g
PiA+ICtzdHJ1Y3Qgc3BzZGNfaG9zdCB7DQo+ID4NCj4gPiBXaGVyZSBpcyB0aGlzIHVzZWQ/DQo+
ID4NCj4gDQo+IHN0cnVjdCBzcG1tY19ob3N0e30gZm9yIGVtbWMuDQo+IHN0cnVjdCBzcHNkY19o
b3N0e30gZm9yIFNEIGNhcmQuDQo+IFRoZSByZWdpc3RlciBiYXNlIGFkZHJlc3MgYW5kIG9mZnNl
dCBhZGRyZXNzIG9mIGVtbWMgYW5kIHNkIGNhcmRzIGFyZQ0KPiBkaWZmZXJlbnQuDQo+IGVNTUMg
YW5kIHNkY2FyZCBhcmUgdGhlaXIgcmVzcGVjdGl2ZSBoYXJkd2FyZSBzZXR0aW5ncy4NCj4gDQoN
Ckkgd2lsbCByZW1vdmUgc3RydWN0IHNwc2RjX2hvc3R7fS4NCg==
