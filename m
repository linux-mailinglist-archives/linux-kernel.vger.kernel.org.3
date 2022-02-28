Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4FB4C6304
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 07:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiB1Gff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 01:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiB1Gfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 01:35:34 -0500
Received: from mx1.cqplus1.com (unknown [113.204.237.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB6C266C8F
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 22:34:47 -0800 (PST)
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(26025:0:AUTH_RELAY)
        (envelope-from <qinjian@cqplus1.com>); Mon, 28 Feb 2022 14:31:28 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 28 Feb 2022 14:31:48 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.018; Mon, 28 Feb 2022 14:31:48 +0800
From:   =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Topic: [PATCH v9 05/10] dt-bindings: clock: Add bindings for SP7021
 clock driver
Thread-Index: AQHYJtROb4p9p9dJDEiPbzM3WmTlw6ygfv2AgAgL80A=
Date:   Mon, 28 Feb 2022 06:31:47 +0000
Message-ID: <97cf98c598a04b77bb6de6e91fcdcc0b@cqplus1.com>
References: <cover.1645413746.git.qinjian@cqplus1.com>
 <2089471296584b527f1e08f51f5216d1e733741f.1645413746.git.qinjian@cqplus1.com>
 <498e89dd-c438-68dc-69b5-8de82045ffbd@canonical.com>
In-Reply-To: <498e89dd-c438-68dc-69b5-8de82045ffbd@canonical.com>
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

PiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIGNsa2M6IGNsb2NrLWNvbnRyb2xs
ZXJAOWMwMDAwMDAgew0KPiA+ICsgICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIxLWNs
a2MiOw0KPiA+ICsgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgIHJlZyA9IDww
eDljMDAwMDAwIDB4MjgwPjsNCj4gPiArICAgICAgY2xvY2tzID0gPCZleHRjbGs+LCA8JmNsa2Mg
UExMX1NZUz47DQo+IA0KPiBFeGNlcHQgdGhlIHdhcm5pbmcgcG9pbnRlZCBvdXQgYnkgUm9iJ3Mg
Ym90LCBpdCBsb29rcyBsaWtlIHlvdSBmZWVkIHRoaXMNCj4gY2xvY2stY29udHJvbGxlciB3aXRo
IGEgY2xvY2sgZnJvbSBpdHNlbGYuIElzIHRoZXJlIGEgcG9pbnQgdG8gZXhwcmVzcw0KPiBpdCBp
biBEVFMgYXQgYWxsPw0KIA0KWWVzLCBwbGxzeXMgaXMgYW4gaW50ZXJuYWwgY2xvY2ssIGJ1dCBp
dCBhbHNvIGFzIGEgcGFyZW50IGNsb2NrIGZvciBzb21lIG90aGVyDQpjbG9ja3MgaW4gdGhpcyBj
bG9jay1jb250cm9sbGVyLg0KDQoNCg==
