Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6109A51D1E5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388279AbiEFHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388114AbiEFHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:07:15 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E81C666CB5
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:03:13 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24038:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 06 May 2022 15:01:02 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Fri, 6 May 2022 15:01:00 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2507.006; Fri, 6 May 2022 15:01:00 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v14 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Topic: [PATCH v14 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Index: AQHYYPmoKr87uTd0mUKH1SxX+WAEFK0Q3wAAgACMdMA=
Date:   Fri, 6 May 2022 07:01:00 +0000
Message-ID: <d4ec03ed722349dda9fa3357449ac612@cqplus1.com>
References: <cover.1651805790.git.qinjian@cqplus1.com>
 <56fb5e9a35a901f15d8e9721385c7e916c181377.1651805790.git.qinjian@cqplus1.com>
 <550cd907-be2a-4e90-350c-fbc3bdc03728@linaro.org>
In-Reply-To: <550cd907-be2a-4e90-350c-fbc3bdc03728@linaro.org>
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

PiBPbiAwNi8wNS8yMDIyIDA1OjIzLCBRaW4gSmlhbiB3cm90ZToNCj4gPiBBZGQgZG9jdW1lbnRh
dGlvbiB0byBkZXNjcmliZSBTdW5wbHVzIFNQNzAyMSBpbnRlcnJ1cHQgY29udHJvbGxlciBiaW5k
aW5ncy4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3Jn
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpbiBKaWFuIDxxaW5qaWFuQGNxcGx1czEuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vc3VucGx1cyxzcDcwMjEtaW50Yy55YW1sICAgICAgICAgICAgICAgICAg
fCA2MiArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2MyBpbnNl
cnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvc3VucGx1cyxzcDcwMjEtaW50Yy55YW1s
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2ludGVycnVwdC1jb250cm9sbGVyL3N1bnBsdXMsc3A3MDIxLWludGMueWFtbA0KPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9zdW5wbHVz
LHNwNzAyMS1pbnRjLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAw
MDAwMDAwMC4uZjI2ZDhiMjEzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9zdW5wbHVzLHNw
NzAyMS1pbnRjLnlhbWwNCj4gPiBAQCAtMCwwICsxLDYyIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICsjIENvcHly
aWdodCAoQykgU3VucGx1cyBDby4sIEx0ZC4gMjAyMQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0t
DQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaW50ZXJydXB0LWNvbnRy
b2xsZXIvc3VucGx1cyxzcDcwMjEtaW50Yy55YW1sIw0KPiA+ICskc2NoZW1hOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiArDQo+ID4gK3RpdGxlOiBT
dW5wbHVzIFNQNzAyMSBTb0MgSW50ZXJydXB0IENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGlu
Z3MNCj4gDQo+IFJlbW92ZSAiRGV2aWNlIFRyZWUgQmluZGluZ3MiLiBUaGlzIGFwcGxpZXMgdG8g
YWxsIGJpbmRpbmdzIHBhdGNoZXMsIG5vdA0KPiBvbmx5IHRvIG9uZS4NCj4gDQoNCkRpZCB5b3Ug
bWVhbnMgY2hhbmdlDQoidGl0bGU6IFN1bnBsdXMgU1A3MDIxIFNvQyBJbnRlcnJ1cHQgQ29udHJv
bGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncyINCnRvIA0KInRpdGxlOiBTdW5wbHVzIFNQNzAyMSBT
b0MgSW50ZXJydXB0IENvbnRyb2xsZXIiPw0KDQoNCg==
