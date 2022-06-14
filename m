Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415CC54A7BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbiFNED4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFNEDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:03:53 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20908286FC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:03:51 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 36A162C0240;
        Tue, 14 Jun 2022 04:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1655179427;
        bh=BR6aqDZmIjW+L+RECqiQdzMSKaRwgplEd1esaMRfeYI=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=UW2o1kVxXeamqv/1A9Pb5FfkNasKn94DUpXoDDtzmqmH+MZwh+4OEgMI3WxMVrmOH
         +ZxeyuOBiYsB78B4XGIHEX9ifXZefZC/uNmgn/spKiWdBOwXwPO5/6c1DX9m2Dxjmc
         VmWNyCaz+1/Q/+pXu5Pf698qURIe4Mt2kV7RUrIwv6F8ZQ1kVqk4lO4VuP2/HyFyeD
         dRKswN+63AQPo++97BJmhhpirntl+mct9/ZymW+frzA6N2OZtttaXciLTEN6+qoo8B
         kqq0ELiHDjxv8h2vg2m7Vp7rQyHrkzv9yyITw2EpZPkf9szdXgplzc0rqAcvuD2ybp
         XWeaTXL4cgq4A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62a808a20000>; Tue, 14 Jun 2022 16:03:46 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.36; Tue, 14 Jun 2022 16:03:45 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.036; Tue, 14 Jun 2022 16:03:45 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Topic: [PATCH v9 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Thread-Index: AQHYf3ikRLNO7hBr8U2k829yckVsjq1Nf14A
Date:   Tue, 14 Jun 2022 04:03:44 +0000
Message-ID: <9c36db86-e48c-4e24-4da9-9d85c9fe7341@alliedtelesis.co.nz>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-2-vadym.kochan@plvision.eu>
In-Reply-To: <20220613225338.393-2-vadym.kochan@plvision.eu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA990F35C82F7F4E8CB6CE155E7901F1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=G+Ni7Os5 c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=JPEYwPQDsx4A:10 a=g8kJ_gb0AAAA:8 a=62ntRvTiAAAA:8 a=gEfo2CItAAAA:8 a=ri33yk18AI7hAU26Vw0A:9 a=QEXdDO2ut3YA:10 a=ecSNLfPMzbq-p5zXJZOg:22 a=pToNdpNmrtiFLRE6bQ9Z:22 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxNC8wNi8yMiAxMDo1MywgVmFkeW0gS29jaGFuIHdyb3RlOg0KPiBGcm9tOiBDaHJpcyBQ
YWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+DQo+IERlc2NyaWJl
IHRoZSBjb21wYXRpYmxlIHByb3BlcnRpZXMgZm9yIHRoZSBNYXJ2ZWxsIEFsbGV5Y2F0NS81WCBz
d2l0Y2hlcw0KPiB3aXRoIGludGVncmF0ZWQgQ1BVcy4NCj4NCj4gQWxsZXljYXQ1Og0KPiAqIDk4
RFgyNTM4OiAyNHgxRyArIDJ4MTBHICsgMngxMEcgU3RhY2sNCj4gKiA5OERYMjUzNTogMjR4MUcg
KyA0eDFHIFN0YWNrDQo+ICogOThEWDI1MzI6IDh4MUcgKyAyeDEwRyArIDJ4MUcgU3RhY2sNCj4g
KiA5OERYMjUzMTogOHgxRyArIDR4MUcgU3RhY2sNCj4gKiA5OERYMjUyODogMjR4MUcgKyAyeDEw
RyArIDJ4MTBHIFN0YWNrDQo+ICogOThEWDI1MjU6IDI0eDFHICsgNHgxRyBTdGFjaw0KPiAqIDk4
RFgyNTIyOiA4eDFHICsgMngxMEcgKyAyeDFHIFN0YWNrDQo+ICogOThEWDI1MjE6IDh4MUcgKyA0
eDFHIFN0YWNrDQo+ICogOThEWDI1MTg6IDI0eDFHICsgMngxMEcgKyAyeDEwRyBTdGFjaw0KPiAq
IDk4RFgyNTE1OiAyNHgxRyArIDR4MUcgU3RhY2sNCj4gKiA5OERYMjUxMjogOHgxRyArIDJ4MTBH
ICsgMngxRyBTdGFjaw0KPiAqIDk4RFgyNTExOiA4eDFHICsgNHgxRyBTdGFjaw0KPg0KPiBBbGxl
eWNhdDVYOg0KPiAqIDk4RFgzNTAwOiAyNHgxRyArIDZ4MjVHDQo+ICogOThEWDM1MDE6IDE2eDFH
ICsgNngxMEcNCj4gKiA5OERYMzUxMDogNDh4MUcgKyA2eDI1Rw0KPiAqIDk4RFgzNTIwOiAyNHgy
LjVHICsgNngyNUcNCj4gKiA5OERYMzUzMDogNDh4Mi41RyArIDZ4MjVHDQo+ICogOThEWDM1NDA6
IDEyeDVHLzZ4MTBHICsgNngyNUcNCj4gKiA5OERYMzU1MDogMjR4NUcvMTJ4MTBHICsgNngyNUcN
Cj4NCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0
ZWxlc2lzLmNvLm56Pg0KPiBTaWduZWQtb2ZmLWJ5OiBWYWR5bSBLb2NoYW4gPHZhZHltLmtvY2hh
bkBwbHZpc2lvbi5ldT4NCj4gLS0tDQo+DQo+IE5vdGVzOg0KPiAgICAgIENoYW5nZXMgaW4gdjk6
DQo+ICAgICAgLSBSZW5hbWVkICRpZCB3aXRoICJhYzUiIHByZWZpeA0KPiAgICAgIENoYW5nZXMg
aW4gdjg6DQo+ICAgICAgLSBBZGQgcmV2aWV3IGZyb20gS3J6eXN6dG9mDQo+ICAgICAgQ2hhbmdl
cyBpbiB2NzoNCj4gICAgICAtIEFkZCByZC1hYzUgYW5kIHJkLWFjNXggYm9hcmRzIHRvIGJpbmRp
bmcuDQo+ICAgICAgLSBSZW5hbWUgdG8gYXJtYWRhLTk4ZHgyNXh4LnlhbWwNCj4gICAgICBDaGFu
Z2VzIGluIHY2Og0KPiAgICAgIC0gTmV3DQo+DQo+ICAgLi4uL2JpbmRpbmdzL2FybS9tYXJ2ZWxs
L2FjNS05OGR4MjV4eC55YW1sICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hYzUtOThkeDI1eHgueWFt
bA0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9tYXJ2ZWxsL2FjNS05OGR4MjV4eC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tYXJ2ZWxsL2FjNS05OGR4MjV4eC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMWQ4ZGQ3YzAwYzFhDQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2Fj
NS05OGR4MjV4eC55YW1sDQo+IEBAIC0wLDAgKzEsMzIgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlBTUwgMS4yDQo+
ICstLS0NCj4gKyRpZDogaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9MjA5ODgmZD0w
c0NuNHJTa204WWUxd2dvand6RXVEZ05LeHk4eG9hSkpCT0hvM3VoWEEmdT1odHRwJTNhJTJmJTJm
ZGV2aWNldHJlZSUyZW9yZyUyZnNjaGVtYXMlMmZhcm0lMmZtYXJ2ZWxsJTJmYWM1LTk4ZHgyNXh4
JTJleWFtbCUyMw0KPiArJHNjaGVtYTogaHR0cDovL3NjYW5tYWlsLnRydXN0d2F2ZS5jb20vP2M9
MjA5ODgmZD0wc0NuNHJTa204WWUxd2dvand6RXVEZ05LeHk4eG9hSkpCZUc4aTcyV1EmdT1odHRw
JTNhJTJmJTJmZGV2aWNldHJlZSUyZW9yZyUyZm1ldGEtc2NoZW1hcyUyZmNvcmUlMmV5YW1sJTIz
DQo+ICsNCg0KQXBvbG9naWVzIGZvciB0aGUgYWJvdmUuIE91ciBpbmNvbWluZyBlbWFpbCBsaWtl
cyB0byBldmVuIHRoZSBwbGF5aW5nIA0KZmllbGQgYnkgbWFraW5nIGFsbCBsaW5rcyBsb29rIGxp
a2UgcGhpc2hpbmcgYXR0ZW1wdHMuDQoNCj4gK3RpdGxlOiBNYXJ2ZWxsIEFsbGV5Y2F0NS81WCBQ
bGF0Zm9ybXMNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gQ2hyaXMgUGFja2hhbSA8Y2hy
aXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KRG8geW91IHdhbnQgdG8gYWRkIHlvdXJz
ZWxmIGhlcmU/DQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsgICRub2RlbmFtZToNCj4gKyAgICBj
b25zdDogJy8nDQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgb25lT2Y6DQo+ICsgICAgICAtIGRl
c2NyaXB0aW9uOiBBbGxleWNhdDUgKDk4RFgyNXh4KSBSZWZlcmVuY2UgRGVzaWduDQo+ICsgICAg
ICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAgICAgLSBtYXJ2
ZWxsLHJkLWFjNQ0KPiArICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYWM1DQo+ICsNCj4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IEFsbGV5Y2F0NVggKDk4RFgzNXh4KSBSZWZlcmVuY2UgRGVzaWdu
DQo+ICsgICAgICAgIGl0ZW1zOg0KPiArICAgICAgICAgIC0gZW51bToNCj4gKyAgICAgICAgICAg
ICAgLSBtYXJ2ZWxsLHJkLWFjNXgNCj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFjNXgN
Cj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFjNQ0KPiArDQo+ICthZGRpdGlvbmFsUHJv
cGVydGllczogdHJ1ZQ0KPiArDQo+ICsuLi4=
