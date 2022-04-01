Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA24EEABC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 11:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbiDAJve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 05:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbiDAJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 05:51:32 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 804FCC6EEF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 02:49:19 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1179:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 17:46:50 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 17:47:49 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 17:47:49 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: RE: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
Thread-Topic: [PATCH v12 5/9] clk: Add Sunplus SP7021 clock driver
Thread-Index: AQHYRNqOjCd6CVvOR0G759g8P20c0KzYsc4AgAIYlbA=
Date:   Fri, 1 Apr 2022 09:47:48 +0000
Message-ID: <2fa0ce6048f6449d883e2454ceea9540@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <fe4f4c3b0c768d1cd66fb648d74fa302e86787c0.1648714851.git.qinjian@cqplus1.com>
 <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com>
In-Reply-To: <CAK8P3a0OGM4aiaE2Nfc=7XGkGwAbnB99-j3PhVUmuA1z2FWeKg@mail.gmail.com>
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

PiANCj4gPiArc3RhdGljIGludCBzcF9wbGxfZW5hYmxlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiA+
ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3BfcGxsICpjbGsgPSB0b19zcF9wbGwoaHcpOw0KPiA+
ICsgICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArDQo+ID4gKyAgICAgICBzcGluX2xv
Y2tfaXJxc2F2ZShjbGstPmxvY2ssIGZsYWdzKTsNCj4gPiArICAgICAgIHdyaXRlbChCSVQoY2xr
LT5wZF9iaXQgKyAxNikgfCBCSVQoY2xrLT5wZF9iaXQpLCBjbGstPnJlZyk7IC8qIHBvd2VyIHVw
ICovDQo+ID4gKyAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKGNsay0+bG9jaywgZmxhZ3Mp
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgdm9pZCBzcF9wbGxfZGlzYWJsZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiArew0KPiA+ICsg
ICAgICAgc3RydWN0IHNwX3BsbCAqY2xrID0gdG9fc3BfcGxsKGh3KTsNCj4gPiArICAgICAgIHVu
c2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKw0KPiA+ICsgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUo
Y2xrLT5sb2NrLCBmbGFncyk7DQo+ID4gKyAgICAgICB3cml0ZWwoQklUKGNsay0+cGRfYml0ICsg
MTYpLCBjbGstPnJlZyk7IC8qIHBvd2VyIGRvd24gKi8NCj4gPiArICAgICAgIHNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoY2xrLT5sb2NrLCBmbGFncyk7DQo+ID4gK30NCj4gDQo+IFdoYXQgZG9lcyB0
aGUgc3BpbmxvY2sgYWN0dWFsbHkgcHJvdGVjdCBoZXJlPyBBcyB3cml0ZWwoKSBpcyBwb3N0ZWQs
IGl0DQo+IGNhbiBhbHJlYWR5IGxlYWsgb2Ygb2YgdGhlIGxvY2ssIGFuZCB0aGUgaW5wdXRzIHdv
dWxkIGFwcGVhciB0byBiZQ0KPiBjb25zdGFudC4NCj4gDQoNClRoZXNlIGNvZGUgaXMgcmVmZXJl
ZCBmcm9tIG90aGVyIGNsayBkcml2ZXIuDQpCdXQsIG90aGVyIGRyaXZlciBuZWVkIHJlYWQgdGhl
biB3cml0ZSwgc28gbmVlZCBsb2NrIHByb3RlY3RlZC4NCk91ciAgSFcgaXMgSElXT1JEX01BU0tF
RF9SRUcsIG1lYW5zIG1vZGlmeSBiaXRzIG5vIG5lZWQgdG8gcmVhZCwganVzdCAxIHdyaXRlIG9u
bHkuDQpTbywgdGhlIGxvY2sgaXMgdXNlbGVzcy4NCkRpZCBJIHJpZ2h0Pw0KDQo+ID4gKyAgICAg
ICAvKiBUaGlzIG1lbW9yeSByZWdpb24gaW5jbHVkZSBtdWx0aSBIVyByZWdzIGluIGRpc2NvbnRp
bnVvdXMgb3JkZXIuDQo+ID4gKyAgICAgICAgKiBjbGsgZHJpdmVyIHVzZWQgc29tZSBkaXNjb250
aW51b3VzIGFyZWFzIGluIHRoZSBtZW1vcnkgcmVnaW9uLg0KPiA+ICsgICAgICAgICogVXNpbmcg
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgd291bGQgY29uZmxpY3RlZCB3aXRoIG90
aGVyIGRyaXZlcnMuDQo+ID4gKyAgICAgICAgKi8NCj4gPiArICAgICAgIHJlcyA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ID4gKyAgICAgICBzcF9j
bGtfYmFzZSA9IGRldm1faW9yZW1hcChkZXYsIHJlcy0+c3RhcnQsIHJlc291cmNlX3NpemUocmVz
KSk7DQo+ID4gKyAgICAgICBpZiAoIXNwX2Nsa19iYXNlKQ0KPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVOWElPOw0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHRoaXMgY29tbWVudCBpbiBtb3Jl
IGRldGFpbD8gR2VuZXJhbGx5LCB0aGUgJ3JlZycgcHJvcGVydGllcw0KPiBvZiBkcml2ZXJzIHNo
b3VsZCBub3Qgb3ZlcmxhcCwgc28gaXQgaXMgc3VwcG9zZWQgdG8gYmUgc2FmZSB0byBjYWxsDQo+
IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIGhlcmUuDQo+IA0KPiBXZSBkaXNjdXNz
ZWQgdGhpcyBpbiB0aGUgY29udGV4dCBvZiB0aGUgaW9wIGRyaXZlciB0aGF0IGRpZCBoYXZlIG92
ZXJsYXBwaW5nDQo+IHJlZ2lzdGVycyB3aXRoIHRoaXMgZHJpdmVyLCBhbmQgdGhhdCB3YXMgaW5j
b3JyZWN0LiBBcmUgdGhlcmUgYW55IG90aGVyIGRyaXZlcnMNCj4gdGhhdCBjb25mbGljdCB3aXRo
IHRoZSBjbGsgZHJpdmVyPw0KPiANCj4gICAgICAgQXJuZA0KDQpJIG1lYW5zLCBJIG11c3Qgc3Bs
aXQgdXAgdGhlIG9yaWdpbiByZWcgcmVnaW9uIGludG8gNCBzbWFsbCBwaWVjZXMsDQphbmQgY2Fs
bCBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UoKSA0IHRpbWVzLg0KRGlkIEkgc2hvdWxk
IGZvbGxvdyB0aGlzIHdheT8NCg==
