Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70EA4E1FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiCUE4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238723AbiCUE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:56:31 -0400
X-Greylist: delayed 8364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 20 Mar 2022 21:55:05 PDT
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61626193DC;
        Sun, 20 Mar 2022 21:55:04 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10891:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 21 Mar 2022 12:55:17 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 21 Mar 2022 12:55:12 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 21 Mar 2022 12:55:12 +0800
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
Thread-Index: AQHYOzO6cpYNd+UZBku5eHHWG55gaqzHpeaAgAGhbhA=
Date:   Mon, 21 Mar 2022 04:55:11 +0000
Message-ID: <c6ecbe40dc234454b41bcbc0bf073084@sphcmbx02.sunplus.com.tw>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <f954fb1c0d1c4950b71a8fc360c78edcca9954de.1647652688.git.tonyhuang.sunplus@gmail.com>
 <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org>
In-Reply-To: <e5426768-1dd0-0bef-25e8-2ab494f7723d@kernel.org>
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

RGVhciBLcnp5c3p0b2Y6DQo+IA0KPiA+ICsJaW50IGRtYV9pbnRfdGhyZXNob2xkOw0KPiA+ICsJ
c3RydWN0IHNnX21hcHBpbmdfaXRlciBzZ19taXRlcjsgLyogZm9yIHBpbyBtb2RlIHRvIGFjY2Vz
cyBzZ2xpc3QgKi8NCj4gPiArCWludCBkbWFfdXNlX2ludDsgLyogc2hvdWxkIHJhaXNlIGlycSB3
aGVuIGRtYSBkb25lICovDQo+ID4gKwlzdHJ1Y3Qgc3BtbWNfdHVuaW5nX2luZm8gZW1tY190dW5p
bmdfaW5mbzsNCj4gPiArCXN0cnVjdCBzcHNkY190dW5pbmdfaW5mbyBzZF90dW5pbmdfaW5mbzsN
Cj4gPiArCWludCByZXN0b3JlXzRiaXRfc2Rpb19idXM7DQo+ID4gKwljb25zdCBzdHJ1Y3Qgc3Bt
bWNfY29tcGF0aWJsZSAqZGV2X2NvbXA7IH07DQo+ID4gKw0KPiA+ICtzdHJ1Y3Qgc3BzZGNfaG9z
dCB7DQo+IA0KPiBXaGVyZSBpcyB0aGlzIHVzZWQ/DQo+IA0KDQpzdHJ1Y3Qgc3BtbWNfaG9zdHt9
IGZvciBlbW1jLgkJCQ0Kc3RydWN0IHNwc2RjX2hvc3R7fSBmb3IgU0QgY2FyZC4JCQkNClRoZSBy
ZWdpc3RlciBiYXNlIGFkZHJlc3MgYW5kIG9mZnNldCBhZGRyZXNzIG9mIGVtbWMgYW5kIHNkIGNh
cmRzIGFyZSBkaWZmZXJlbnQuCQkJDQplTU1DIGFuZCBzZGNhcmQgYXJlIHRoZWlyIHJlc3BlY3Rp
dmUgaGFyZHdhcmUgc2V0dGluZ3MuDQoNCg0K
