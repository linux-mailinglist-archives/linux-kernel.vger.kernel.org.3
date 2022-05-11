Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C513652407C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348974AbiEKW7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbiEKW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:59:43 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF818A32B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:59:41 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E72C82C044A;
        Wed, 11 May 2022 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652309977;
        bh=dbiwv2rHTCHRWVF5902F3Nh4mqpnE8U2uwEkp+IcrNw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=lFeMiUjX1Yxq4bol/bKkC8pPOSkCWXZjKbKvV7X/XNh2NEpBPxIXqSJUkIk+t4mus
         jjCmYJUDHeu5bJBzGOkn+8UydxubJ+rpiSz1UQmruoeRQ5TqgrBydToI7Jvq7DslAN
         fXYDladwGGMCsVUCkqfkhQRK3k+NxB/d+vNcz1V0929B9Uirklm6voBnIKgaAPYsAk
         9T2OxP1OoQdgM5Rwtjb56rXOTDmTpI/anM3xP2Iq62EwTYyjMUIVTM7YtVj+fowJZW
         VHDq9hTJYPO0bKIoR/hcEKypR0Vl7v5BuydDiZGuEiAhN3KaQjgPu5aE1Qi8K9rqjo
         iUBt7l3C6KZSg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627c3fd90001>; Thu, 12 May 2022 10:59:37 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 12 May 2022 10:59:37 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Thu, 12 May 2022 10:59:37 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>,
        Vadym Kochan <vadym.kochan@plvision.eu>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYZVGaM5HNJyVFK0yMg5+dPH+INq0ZEh4AgABvp4A=
Date:   Wed, 11 May 2022 22:59:37 +0000
Message-ID: <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu> <YnviMOtXX+us+IA4@lunn.ch>
In-Reply-To: <YnviMOtXX+us+IA4@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <138E75DF91EDC7498F0C922C7C0ECE8A@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=nlR0Zc3rm02OJYrKWlIA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wNS8yMiAwNDoyMCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDEx
LCAyMDIyIGF0IDA3OjEwOjAzUE0gKzAzMDAsIFZhZHltIEtvY2hhbiB3cm90ZToNCj4+IEhpIENo
cmlzLA0KPj4NCj4+PiBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgICAgICAg
ICAgfCAgIDEgKw0KPj4+IC4uLi9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjUzMC5kdHNp
ICAgICB8IDMxMCArKysrKysrKysrKysrKysrKysNCj4+PiBhcmNoL2FybTY0L2Jvb3QvZHRzL21h
cnZlbGwvcmQtYWM1eC5kdHMgICAgICAgfCAgOTAgKysrKysNCj4+PiAzIGZpbGVzIGNoYW5nZWQs
IDQwMSBpbnNlcnRpb25zKCspDQo+PiBNYXJ2ZWxsIGlzIGdvaW5nIHRvIHN0YXJ0IHRoZSB1cHN0
cmVhbWluZyBvZiBBQzVYIGJvYXJkcyBzdXBwb3J0LA0KVGhhdCdzIGdvb2QgbmV3cy4gSSdtIHBy
b2JhYmx5IHRoZSBjdXN0b21lciB0aGF0J3MgYmVlbiBuYWdnaW5nIHRoZSANCk1hcnZlbGwgc3Vw
cG9ydCB0ZWFtLiBCdXQgSSdtIGFsc28gaW1wYXRpZW50IGhlbmNlIEkgc3RhcnRlZCB3b3JraW5n
IG9uIA0KdGhpcyBzZXJpZXMuIFRoZSBwaW5jdHJsIGFuZCBtdm5ldGEgY2hhbmdlcyBoYXZlIGFs
cmVhZHkgYmVlbiBhY2NlcHRlZC4NCj4+ICAgd2UgaGF2ZSBhbHNvIHBhdGNoZXMgd2l0aCBzaW1p
bGFyIC5kdHMoaSkgZmlsZXMNCj4+IGJ1dCB3aXRoIGRpZmZlcmVudCBuYW1pbmc6DQo+Pg0KPj4g
ICAgICBhYzUuZHRzaQ0KPj4gICAgICBhYzVfcmQuZHRzDQo+PiAgICAgIGFjNV9kYi5kdHMNCj4+
ICAgICAgYWM1eF9kYi5kdHMNCj4+DQo+PiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0byB1c2Ug
dGhlc2UgbmFtaW5nIHNjaGVtZSA/DQoNClBlcnNvbmFsbHkgSSB0aG91Z2h0IHRoZXknZCBiZSBy
ZWplY3RlZCB1cHN0cmVhbSBhcyBiZWluZyB0b28gdmFndWUgYW5kIA0KZ2VuZXJpYy4gSSBzZXR0
bGVkIG9uIGFybWFkYS05OGR4MjUzMCBhcyBJIHNhdyB0aGUgOThkeDI1MzAgbmFtZSB1c2VkIG9u
IA0KdGhlIE1hcnZlbGwgUG9ydGFsIHRvIHJlZmVyIHRvIHRoZSBDbk0gYmxvY2sgZm9yIHRoZSBB
QzUvQUM1WC4gSSB3YXMgDQpnb2luZyB0byBjYWxsIHRoZSBib2FyZCBmaWxlICJyZC1hYzV4LTMy
ZzE2aHZnNmhsZy5kdHMiIGFzIHRoYXQncyB3aGF0IA0KdGhlIHNpbGtzY3JlZW4gb24gdGhlIGJv
YXJkIEkgaGF2ZSBzYXlzIGJ1dCBJIHNob3J0ZW5lZCBpdCB0byAicmQtYWM1eCIgDQphcyB0aGUg
c3dpdGNoIHBvcnQgY29uZmlndXJhdGlvbiBpcyBsYXJnZWx5IGlycmVsZXZhbnQgdG8gdGhlIGJv
YXJkIA0Kc3VwcG9ydCBJJ20gdHJ5aW5nIHRvIGdldCBsYW5kZWQuDQoNCj4gQ2hyaXMgaGFzIGRv
bmUgYWxsIHRoZSBoYXJkIHdvcmssIGhlIGdldHMgdG8gcGljayB0aGUgbmFtaW5nLiBBbmQgZ2V0
DQo+IGhpcyBmaWxlcyBtZXJnZWQgZmlyc3QuDQoNCkknbSBub3QgYWdhaW5zdCBjaGFuZ2luZyBp
ZiB0aGVyZSBpcyBhIGNvbnNlbnN1cy4gT24gYW5vdGhlciB0aHJlYWQgdGhlIA0KaWRlYSBvZiBh
cm1hZGEtOThkeDI1eHgvYXJtYWRhLTk4ZHgzNXh4IHdhcyBtZW50aW9uZWQuIFRoYXQgbWlnaHQg
YmUgYSANCnJlYXNvbmFibGUgY29tcHJvbWlzZSAoYWx0aG91Z2ggdGVjaG5pY2FsbHkgdGhlcmUn
cyBubyBkaWZmZXJlbmNlIGluIHRoZSANCkNQVSBibG9jayBiZXR3ZWVuIHRoZSAyNXh4IGFuZCAz
NXh4KS4NCg0KPiBIb3dldmVyLCBub3cgdGhhdCBpIGNvbWUgdG8gbG9vayBpbiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21hcnZlbGwsIGkNCj4gdGhpbmsgbW9zdCBvZiB0aGUgY3VycmVudCBmaWxlbmFt
ZXMgcHJvcG9zZWQgZG9uJ3QgbWF0Y2ggdGhlIGN1cnJlbnQgbmFtZXMuDQo+DQo+IGFybWFkYS05
OGR4MjUzMC5kdHNpIGZpdHMgdGhlIGN1cnJlbnQgcGF0dGVybi4NCj4NCj4gSG93ZXZlciwgQ2hy
aXMncyBib2FyZCBmaWxlcyBzaG91bGQgcHJvYmFibHkgYmUNCj4NCj4gYXJtYWRhLTk4ZHgyNTMw
LXJkLmR0cw0KPg0KPiBhbmQgdGhlIG90aGVyIGZpbGVzIHNob3VsZCBiZQ0KPg0KPiBhcm1hZGEt
OThkeDI1MzAtZGIuZHRzDQo+DQo+IGFybWFkYS05OGR4MjUzMC14LWRiLmR0cw0KPg0KPiBXaGF0
IGRvZXMgdGhlIHggaW4geF9kYiBtZWFuPyBEb2VzIHRoYXQgcmVmZXIgdG8gdGhlIGJvYXJkIG9y
IHRoZSBTb0M/DQoNClRoZSB4IGlzIGZyb20gQUM1WCBzbyB3ZSdkIGFjdHVhbGx5IGhhdmUgYXJt
YWRhLTk4ZHgyNXh4LWRiLmR0cyBhbmQgDQphcm1hZGEtOThkeDM1eHgtZGIuZHRzLiBNeSBib2Fy
ZCB3b3VsZCBiZSBjYWxsZWQgYXJtYWRhLTk4ZHgzNXh4LXJkLmR0cyANCm9yIHBlcmhhcHMgYXJt
YWRhLTk4ZHgzNTUwLXJkLmR0cy4NCg0K
