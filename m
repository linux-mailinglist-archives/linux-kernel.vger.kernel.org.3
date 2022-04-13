Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459704FEC92
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiDMByY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiDMByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:54:22 -0400
X-Greylist: delayed 142 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 18:52:00 PDT
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79DC52C651;
        Tue, 12 Apr 2022 18:52:00 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(27729:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Wed, 13 Apr 2022 09:49:15 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Wed, 13 Apr 2022 09:49:11 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Wed, 13 Apr 2022 09:49:11 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v7 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Thread-Topic: [PATCH v7 2/2] dt-bindings:thermal: Add Sunplus SP7021 schema
Thread-Index: AQHYTYGRBrvPBaFpFkWb1HIe0r3aqqzrcwCAgAGhdOA=
Date:   Wed, 13 Apr 2022 01:49:11 +0000
Message-ID: <15d27f6131994b2d981b3fcaebdfbb3b@sphcmbx02.sunplus.com.tw>
References: <cover.1649662002.git.lhjeff911@gmail.com>
 <f24781413a8a305b28a1e9c3861263975eebaee6.1649662002.git.lhjeff911@gmail.com>
 <36b7de46-7e8b-fbb5-6eeb-89180d358d84@kernel.org>
In-Reply-To: <36b7de46-7e8b-fbb5-6eeb-89180d358d84@kernel.org>
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

SGkgTXIuIEtyenlzenRvZg0KDQpJJ20gc29ycnkgZm9yIHRoYXQuIEkgbWlzdW5kZXJzdG9vZCBh
dCB0aGUgYmVnaW5uaW5nDQoNCkkgd2lsbCBjaGFuZ2UgdGhlIG5hbWUgdG8gc3VucGx1cyx0aGVy
bWFsLnlhbWwgaW4gdGhlIG5leHQgY29tbWl0Lg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudC4N
Cg0KQmVzdCByZWdhcmRzLA0KTGkgSGFvIEt1bw0KDQo+IFlvdSBzZW50IHY2IHdpdGhvdXQgaW1w
bGVtZW50aW5nIHRoZSBjaGFuZ2VzLiBJIHBvaW50ZWQgb3V0IHRoYXQgeW91IGRpZCBub3QgZm9s
bG93IHdoYXQgSSBhc2tlZCBmb3IuDQo+IE5vdyB5b3Ugc2VudCB2NyBhbHNvIHdpdGhvdXQgaW1w
bGVtZW50aW5nIHRoZXNlIGNoYW5nZXMsIGFnYWluLg0KPiANCj4gWW91IGFsc28gZGlkIG5vdCBk
aXNjdXNzIGl0IHdpdGggbWUsIGRpZCBub3QgY29tZSB3aXRoIGNvdW50ZXIgYXJndW1lbnRzLCBv
dGhlciBwcm9wb3NhbHMuIFRoZXJlZm9yZSBpdA0KPiBsb29rcyBsaWtlIGVpdGhlciB5b3UgbWlz
dW5kZXJzdG9vZCBtZSBvciB5b3UgaWdub3JlZCBteSBjb21tZW50cy4NCj4gDQo+IExldCdzIGFz
c3VtZSBmaXJzdCBjYXNlLCBzbyBJIHdpbGwgcmVwZWF0LiBOYW1lIHNob3VsZCBiZSBvbmUgb2Y6
DQo+IDEuIHN1bnBsdXMsdGhlcm1hbC55YW1sDQo+IDIuIHN1bnBsdXMsc3A3MDIxLXRoZXJtYWwu
eWFtbA0KDQoNCg0KDQoNCg==
