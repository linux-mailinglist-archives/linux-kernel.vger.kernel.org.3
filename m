Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC694D9276
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCOCNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiCOCNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:13:12 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3A42A0D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:11:59 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F201B2C072F;
        Tue, 15 Mar 2022 02:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1647310317;
        bh=AVsCUcW1Pbwxc17pi8qVOG5z7q4ceR23WPd92uzUgXw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=qn3zc4VazfLr/TfKzvZsAVlRXH5RZ9xppQ5Ag3c8WDxDaXDC0rT7jI7SOgFMMVH+a
         rO9ukHZUioX6ImVQjMF8UmQ31Zngi9LmATZooiCp1fDjhhr7iNbHA5sjLnL9O/U/2H
         xUpgS02eCWh4eVctGvYtvEBGDQq4iUlNbrSab/VeB68A2WD6hUahYu7Chy6oR2q+5H
         Y5LVvA/uKMHuXXDhTMCNDO64rKVebt5tp1t/WOQPEkUEhe2t4qI4yRrpkqd+TuWvIC
         bvdIsw7iJwj/JXgP7G+SCbyPFPJzkdm1nVRonLCnJugGaUjNBHdkDBNba90YWegTn0
         3j0wxQs3/P+Aw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B622ff5ed0001>; Tue, 15 Mar 2022 15:11:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 15 Mar 2022 15:11:57 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Tue, 15 Mar 2022 15:11:57 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 7/8] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Topic: [PATCH v2 7/8] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Thread-Index: AQHYN+r1ZmR8jfENvE+HCb0E4rqs96y+vFuAgAAd8wA=
Date:   Tue, 15 Mar 2022 02:11:56 +0000
Message-ID: <7b78853e-71ec-7c57-4cac-5cd6303f3b13@alliedtelesis.co.nz>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-8-chris.packham@alliedtelesis.co.nz>
 <Yi/cyUJ6oIs96UW2@lunn.ch>
In-Reply-To: <Yi/cyUJ6oIs96UW2@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA0237A93182384FA910254A8F03FB41@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=zO8ZZgZcihizO_F2bSoA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNS8wMy8yMiAxMzoyNCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjUzMC5kdHNpIGIvYXJjaC9h
cm02NC9ib290L2R0cy9tYXJ2ZWxsL2FybWFkYS05OGR4MjUzMC5kdHNpDQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lYmU0NjRiOWViZDINCj4+IC0tLSAv
ZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9hcm1hZGEtOThk
eDI1MzAuZHRzaQ0KPj4gQEAgLTAsMCArMSwzNDMgQEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjArIE9SIE1JVCkNCj4+ICsvKg0KPj4gKyAqIERldmljZSBUcmVlIEZv
ciBBQzUuDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjEgTWFydmVsbA0KPj4gKyAq
DQo+PiArICovDQo+PiArDQo+PiArL2R0cy12MS87DQo+PiArCW1lbW9yeUAwIHsNCj4+ICsJCWRl
dmljZV90eXBlID0gIm1lbW9yeSI7DQo+PiArCQlyZWcgPSA8MHgyIDB4MDAwMDAwMDAgMHgwIDB4
NDAwMDAwMDA+Ow0KPj4gKwkJLy8gbGludXgsdXNhYmxlLW1lbW9yeSA9IDwweDIgMHgwMDAwMDAw
MCAweDAgMHg4MDAwMDAwMD47DQo+PiArCX07DQo+IElzIHRoZSBtZW1vcnkgcGFydCBvZiB0aGUg
U29DLCBvciBpcyBpdCBvbiB0aGUgYm9hcmQ/IE5vcm1hbGx5IGl0IGlzDQo+IG9uIHRoZSBib2Fy
ZCwgc28gc2hvdWxkIGJlIGluIHRoZSAuZHRzIGZpbGUuIEJ1dCBBcHBsZSBNMSBldGMuLi4NCg0K
SXQncyBvbiB0aGUgYm9hcmQuIE1hcnZlbGwncyBTREsgY29uZmxhdGVzIHRoZSBTb0MgYW5kIHRo
ZSBjb21tb24gDQplbGVtZW50cyBiZXR3ZWVuIHRoZWlyIGJvYXJkIGRlc2lnbnMgKGhlbmNlIHRo
ZSBTUEkgYW5kIEV0aGVybmV0IHN0dWZmIA0KaW4gdjEpLiBJJ2xsIG1vdmUgaXQgZm9yIHRoZSBu
ZXh0IHJvdW5kLg0KDQpJIGFsc28gd2Fzbid0IHN1cmUgYWJvdXQgbGludXgsdXNhYmxlLW1lbW9y
eS4gSXQncyBjb21tZW50ZWQgb3V0IHNvIGl0J3MgDQpvYnZpb3VzbHkgZG9pbmcgbm90aGluZyBi
dXQgc2hvdWxkIGl0PyBObyBvdGhlciBpbi10cmVlIGR0cyBmaWxlcyBoYXZlIGl0Lg0KDQo+PiAr
Jm1kaW8gew0KPj4gKwlwaHkwOiBldGhlcm5ldC1waHlAMCB7DQo+PiArCQlyZWcgPSA8MCAwPjsN
Cj4gcGh5IHJlZyB2YWx1ZXMgYXJlIGEgc2luZ2xlIG51bWJlciwgdGhlIGFkZHJlc3Mgb24gdGhl
IGJ1cywgaW4gdGhlDQo+IHJhbmdlIDAgdG8gMzEuDQpXaWxsIGZpeC4NCj4gICAgICAgIEFuZHJl
dw==
