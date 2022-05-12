Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898C65256F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358693AbiELVTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 17:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358689AbiELVTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 17:19:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D61A8E3A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 14:19:32 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BE39C2C00E8;
        Thu, 12 May 2022 21:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652390369;
        bh=CAJVfbLRnIberFA3/D7eHStqIi/ycjSlAeXdnxJB2ss=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=eg2LIM/3JBDJtb4ZdYqee367jH0rk96OveYu6CNWhuoVbogXy1tLZf8UVYKisaTqy
         TL1Y7BSna0rkygFbcHSnbbwZIWNdgfcUPXv0qvdV1fh3MVRKi3a5B0t6y5ysPOTrRR
         df+ksFT6yAseC1swu4fMWsCiUwcS26QnMT46ydTZtlkaIsRwL4RVaQuu1tR9ShcF5G
         DUIw8uwNicyljI34xqiTUAQUrPBBM3IwwRjfARQRUxoRcKLKYVGsjpmuEjbsJAFxVr
         BnRx7QMo/ylyig1bd4gYBWNNG7oTDjy1QeRvhfe2UqcDfxUeIyO696YA8vxMkkC898
         LOIQW8UdwFMYg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627d79e10001>; Fri, 13 May 2022 09:19:29 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 13 May 2022 09:19:30 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Fri, 13 May 2022 09:19:30 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>, Elad Nachman <enachman@marvell.com>
CC:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "Kostya Porotchkin" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530
 SoC and RD-AC5X board
Thread-Topic: [EXT] Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada
 98DX2530 SoC and RD-AC5X board
Thread-Index: AQHYZVGaM5HNJyVFK0yMg5+dPH+INq0ZEh4AgABvp4CAABwDAIAAaYGAgABhrgCAAI8oAA==
Date:   Thu, 12 May 2022 21:19:29 +0000
Message-ID: <65093185-dc36-af34-8fa7-6f7c08edabaa@alliedtelesis.co.nz>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu> <YnviMOtXX+us+IA4@lunn.ch>
 <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
 <YnxXWIloDzfg8bh0@lunn.ch>
 <BN9PR18MB4251F84C9D4C538DB6D63CFCDBCB9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <Yn0ByoU6Ta5Kmq0u@lunn.ch>
In-Reply-To: <Yn0ByoU6Ta5Kmq0u@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D1B9DC094DB79479ABC3CEEBA7718DA@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=oZkIemNP1mAA:10 a=trsHGxiVvyFGy2KKG6kA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMy8wNS8yMiAwMDo0NywgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBCYXNpY2FsbHksIHRo
ZSBjcHUtc3Vic3lzdGVtcyBvZiBQcmVzdGVyYSA5OERYMjV4eCAoQUM1KSBhbmQgUHJlc3RlcmEg
OThEWDM1eHggKEFDNVgpIGFyZSB0aGUgc2FtZS4NCj4gR3JlYXQsIHRoYW5rcyBmb3IgdGhlIGNv
bmZvcm1hdGlvbi4NCj4NCj4+IFRoZSBEVFNJIENocmlzIHByb3Bvc2VkIGhhZCB0aGUgUENJZSBw
b3J0aW9uIHJlbW92ZWQuDQo+PiBXZSBoYXZlIFBDSWUgc3VwcG9ydCBmb3IgQUM1L0FDNVggc28g
d2Ugd291bGQgb2J2aW91c2x5IGxpa2UgdG8NCj4+IGluY2x1ZGUgdGhpcyBwb3J0aW9uIGluIGJv
dGggdGhlIERUU0kgYW5kIGFzIGEgcGF0Y2ggdG8gdGhlIEFybWFkYThLDQo+PiBQQ0llIGRyaXZl
ci4NCj4gU28geW91IGNhbiBhZGQgdGhlIG5lZWRlZCBub2RlIHRvIHRoZSAuZHRzaSBhcyBwYXJ0
IG9mIHRoZSBwYXRjaCB0bw0KPiB0aGUgcGNpLWFhcmR2YXJrLmMgZHJpdmVyLiBUaGF0IHNvdW5k
cyBPLksuDQoNCkkgZGVsaWJlcmF0ZWx5IGxlZnQgdGhlIHBjaSBzdHVmZiBvdXQgb2YgbXkgc3Vi
bWlzc2lvbiB0byBrZWVwIHRoaW5ncyANCnNpbXBsZSBhbmQgYmVjYXVzZSBJIGhhdmUgbm8gd2F5
IG9mIHRlc3RpbmcgaXQuIEV2ZW50dWFsbHkgd2UgKGFsbGllZCANCnRlbGVzaXMpIGFyZSBwbGFu
bmluZyBhIHByb2R1Y3QgdmFyaWFudCB0aGF0IHdpbGwgbmVlZCBhIDJuZCBzd2l0Y2ggDQpjb25u
ZWN0ZWQgdmlhIHBjaSBzbyBJJ2xsIGJlIHJldmlzaXRpbmcgdGhlIHBjaSBzdHVmZiB0aGVuICh1
bmxlc3MgDQpzb21lb25lIGVsc2UgYmVhdHMgbWUgdG8gaXQpLg0KDQo=
