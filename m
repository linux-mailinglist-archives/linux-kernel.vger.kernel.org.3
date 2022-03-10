Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC4D4D53E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344127AbiCJVwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243713AbiCJVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:52:45 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3FE11798E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 13:51:43 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D9FA22C0DBB;
        Thu, 10 Mar 2022 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646949098;
        bh=VGLgMS22T/CFXdXMR0ETZ74wLgaMhUSaNW4mF575a+0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=FpJNbd1+O7HvTbTQk+wAT635D60r/dPTkzEEmII6e+UB4ryTlnEF61Mt+nVHiMTit
         w0hwu32RvYs01NOyjRXL076hniAImPjrFLAQJommZWHV0FmkJYsnaKO4wPiGzMR4gr
         IG0ayLxq6lr+IdoK9SUo+jDRVGt96UFf6Zow9JVuJIQKIg8nSQikG+5Vd1qPcichnL
         qsl+VmMwC5k2zNR3MA17PMt69ri+r/K5inMl844PQjyatjaNKmMcbFtTca5606a4mC
         2S3fiugacERGBeVHJCh83/zGiFPgWluLPHPId/BHoU+w8xi4u+tfV8WR2ZhD/k+5Gr
         zuV99wc7FlZ5Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622a72ea0001>; Fri, 11 Mar 2022 10:51:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 11 Mar 2022 10:51:38 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 11 Mar 2022 10:51:38 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v1 2/4] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Thread-Topic: [PATCH v1 2/4] pinctrl: mvebu: pinctrl driver for 98DX2530 SoC
Thread-Index: AQHYNCsIX4et5eL/YEuMPbt14dnKyay3y92AgACD4oA=
Date:   Thu, 10 Mar 2022 21:51:37 +0000
Message-ID: <dad15ad0-1095-d19c-7cd7-06810cb1dbc2@alliedtelesis.co.nz>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-3-chris.packham@alliedtelesis.co.nz>
 <YioEQ3g1LlqEv5BY@lunn.ch>
In-Reply-To: <YioEQ3g1LlqEv5BY@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F42014D393D66F42B6220B30D735B983@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=0ko1PimIvnl0ftmBtkkA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMS8wMy8yMiAwMjo1OSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFRodSwgTWFyIDEw
LCAyMDIyIGF0IDA0OjAwOjM3UE0gKzEzMDAsIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBUaGlz
IHBpbmN0cmwgZHJpdmVyIHN1cHBvcnRzIHRoZSA5OERYMjV4eCBhbmQgOThEWDM1eHggZmFtaWx5
IG9mIGNoaXBzDQo+PiBmcm9tIE1hcnZlbGwuIEl0IGlzIGJhc2VkIG9uIHRoZSBNYXJ2ZWxsIFNE
SyB3aXRoIGFkZGl0aW9ucyBmb3IgdmFyaW91cw0KPj4gKG5vbi1ncGlvKSBwaW4gY29uZmlndXJh
dGlvbnMgYmFzZWQgb24gdGhlIGRhdGFzaGVldC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJp
cyBQYWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IEhpIENocmlz
DQo+DQo+IFBhc3QgZXhwZXJpZW5jZSB3aXRoIHBpbmN0cmwgYW5kIGdwaW8gZm9yIG12ZWJ1IGlz
IHRoYXQgZGV2ZWxvcGVycyBnZXQNCj4gR1BJIGFuZCBHUE8gcGlucyB3cm9uZy4gQXJlIHRoZXJl
IGFueSBwaW5zIHdoaWNoIGFyZSBub3QgR1BJTyBidXQgb25seQ0KPiBhIHN1YnNldCwgc28gb25s
eSBHUEkgb3IgR1BPPw0KQWNjb3JkaW5nIHRvIHRoZSBkYXRhc2hlZXQgdGhleSBhcmUgYWxsIEdQ
SU8uIFNvbWUgYXJlIHNhbXBsZWQgYXQgcmVzZXQgDQpzbyBoYXZlIG5vdGVzIGFib3V0IGJlaW5n
IGNhcmVmdWwgbm90IHRvIGRyaXZlIHRoZW0gZGlmZmVyZW50bHkgZHVyaW5nIA0KcmVzZXQuDQo+
ICAgIEFuZHJldw==
