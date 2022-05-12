Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE36524ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352809AbiELKrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241206AbiELKrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:47:45 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED30C7A467
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:47:32 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26396:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Thu, 12 May 2022 18:45:58 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Thu, 12 May 2022 18:45:55 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Thu, 12 May 2022 18:45:55 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v15 04/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYZcsP5QfLdHxDWUuwmqTXvmezs60ag04AgACLAGA=
Date:   Thu, 12 May 2022 10:45:54 +0000
Message-ID: <8a9fa13f66ce4ef9a8f8c9200e1fac5f@cqplus1.com>
References: <cover.1652329411.git.qinjian@cqplus1.com>
 <b5ca5d417be079a2a40a6e79ac1b246b6359a49e.1652329411.git.qinjian@cqplus1.com>
 <e9a39eb6-d8e2-bac6-27e2-f63ef8519917@linaro.org>
In-Reply-To: <e9a39eb6-d8e2-bac6-27e2-f63ef8519917@linaro.org>
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

PiBPbiAxMi8wNS8yMDIyIDA4OjMwLCBRaW4gSmlhbiB3cm90ZToNCj4gPiBBZGQgZG9jdW1lbnRh
dGlvbiB0byBkZXNjcmliZSBTdW5wbHVzIFNQNzAyMSBjbG9jayBkcml2ZXIgYmluZGluZ3MuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBRaW4gSmlhbiA8cWluamlhbkBjcXBsdXMxLmNvbT4NCj4g
PiAtLS0NCj4gPiBSZW1vdmUgIkJpbmRpbmciIGZyb20geWFtbCB0aXRsZQ0KPiA+IFJlbmFtZSBz
cC1zcDcwMjEuaCB0byBzdW5wbHVzLHNwNzAyMS1jbGtjLmgNCj4gDQo+IFRoYW5rcy4NCj4gDQo+
ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9jbG9jay9zdW5wbHVzLHNwNzAyMS1jbGtjLnlhbWwg
ICB8IDUxICsrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICsNCj4gPiAgLi4uL2R0LWJpbmRpbmdzL2Nsb2NrL3N1bnBsdXMs
c3A3MDIxLWNsa2MuaCAgIHwgODggKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNo
YW5nZWQsIDE0MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svc3VucGx1cyxzcDcwMjEtY2xrYy55YW1s
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL3N1bnBs
dXMsc3A3MDIxLWNsa2MuaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9jbG9jay9zdW5wbHVzLHNwNzAyMS1jbGtjLnlhbWwNCj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svc3VucGx1cyxzcDcwMjEtY2xrYy55
YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAuLjExOTk2
MWExNw0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvY2xvY2svc3VucGx1cyxzcDcwMjEtY2xrYy55YW1sDQo+ID4gQEAgLTAsMCAr
MSw1MSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9S
IEJTRC0yLUNsYXVzZSkNCj4gPiArIyBDb3B5cmlnaHQgKEMpIFN1bnBsdXMgQ28uLCBMdGQuIDIw
MjENCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL2Nsb2NrL3N1bnBsdXMsc3A3MDIxLWNsa2MueWFtbCMNCj4gPiArJHNjaGVt
YTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0K
PiA+ICt0aXRsZTogU3VucGx1cyBTUDcwMjEgU29DIENsb2NrIENvbnRyb2xsZXINCj4gPiArDQo+
ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gUWluIEppYW4gPHFpbmppYW5AY3FwbHVzMS5jb20+
DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBj
b25zdDogc3VucGx1cyxzcDcwMjEtY2xrYw0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBt
YXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0K
PiA+ICsNCj4gPiArICAiI2Nsb2NrLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAxDQo+ID4gKw0K
PiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsg
IC0gY2xvY2tzDQo+ID4gKyAgLSAiI2Nsb2NrLWNlbGxzIg0KPiA+ICsNCj4gPiArYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4g
PiArDQo+IA0KPiBTYW1lIGFzIGluIHYxNC4gUGxlYXNlIGdvIHRocm91Z2ggdGhlIGNvbW1lbnRz
IHRob3JvdWdobHkgc28gcmV2aWV3ZXJzDQo+IHdpbGwgbm90IHdhc3RlIHRpbWUgcmVwZWF0aW5n
IHRoZSBzYW1lIHR3aWNlLg0KPiANCg0KU29ycnksIEkgZG9u4oCZdCB1bmRlcnN0YW5kIHlvdXIg
bWVhbmluZy4NCkNvdWxkIHlvdSBleHBsYWluIG1vcmUsIHRoYW5rcy4NCg0KDQo=
