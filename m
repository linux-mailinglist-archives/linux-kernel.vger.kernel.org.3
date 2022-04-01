Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB514EE611
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244105AbiDACdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbiDACdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:33:10 -0400
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38A0C255AA9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:30:58 -0700 (PDT)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(1172:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Fri, 01 Apr 2022 10:28:59 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 1 Apr 2022 10:29:58 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Fri, 1 Apr 2022 10:29:58 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Rob Herring <robh@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Topic: [PATCH v12 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Thread-Index: AQHYRNqIBkj2YEKP8ka+VOn6WZsX66zZcIoAgADkMAA=
Date:   Fri, 1 Apr 2022 02:29:58 +0000
Message-ID: <3373b11528214394baae71198df3adff@cqplus1.com>
References: <cover.1648714851.git.qinjian@cqplus1.com>
 <ff5bfd5611ab0defe0c98f98edbbf655e33cd16d.1648714851.git.qinjian@cqplus1.com>
 <YkYSyHVGsXkGs0uf@robh.at.kernel.org>
In-Reply-To: <YkYSyHVGsXkGs0uf@robh.at.kernel.org>
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

PiANCj4gT24gVGh1LCAzMSBNYXIgMjAyMiAxNjoyOTo1MyArMDgwMCwgUWluIEppYW4gd3JvdGU6
DQo+ID4gQWRkIGRvY3VtZW50YXRpb24gdG8gZGVzY3JpYmUgU3VucGx1cyBTUDcwMjEgaW50ZXJy
dXB0IGNvbnRyb2xsZXIgYmluZGluZ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBRaW4gSmlh
biA8cWluamlhbkBjcXBsdXMxLmNvbT4NCj4gPiAtLS0NCj4gPiBNb3ZlICdyZWcnIGFmdGVyICdj
b21wYXRpYmxlJw0KPiA+IC0tLQ0KPiA+ICAuLi4vc3VucGx1cyxzcDcwMjEtaW50Yy55YW1sICAg
ICAgICAgICAgICAgICAgfCA2MiArKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA2MyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvc3VucGx1cyxz
cDcwMjEtaW50Yy55YW1sDQo+ID4NCj4gDQo+IA0KPiBQbGVhc2UgYWRkIEFja2VkLWJ5L1Jldmll
d2VkLWJ5IHRhZ3Mgd2hlbiBwb3N0aW5nIG5ldyB2ZXJzaW9ucy4gSG93ZXZlciwNCj4gdGhlcmUn
cyBubyBuZWVkIHRvIHJlcG9zdCBwYXRjaGVzICpvbmx5KiB0byBhZGQgdGhlIHRhZ3MuIFRoZSB1
cHN0cmVhbQ0KPiBtYWludGFpbmVyIHdpbGwgZG8gdGhhdCBmb3IgYWNrcyByZWNlaXZlZCBvbiB0
aGUgdmVyc2lvbiB0aGV5IGFwcGx5Lg0KPiANCj4gSWYgYSB0YWcgd2FzIG5vdCBhZGRlZCBvbiBw
dXJwb3NlLCBwbGVhc2Ugc3RhdGUgd2h5IGFuZCB3aGF0IGNoYW5nZWQuDQoNCkNoYW5nZXM6IE1v
dmUgJ3JlZycgYWZ0ZXIgJ2NvbXBhdGlibGUnDQpJIGRpZCBhIG1vZGlmaWNhdGlvbiBiYXNlZCBv
biBjb21tZW50cyBmcm9tIGtyenlzenRvZi5rb3psb3dza2lAY2Fub25pY2FsLmNvbSBbMV0NCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC82ZGJlZGExOC1hMTFjLTYwOWQtN2E4Zi1i
ZjJlNmYyN2FlYTdAa2VybmVsLm9yZy8NCg0K
