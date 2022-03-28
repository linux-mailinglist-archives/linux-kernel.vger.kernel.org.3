Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20A54EA3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiC1XnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiC1XnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:43:21 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE813DEB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:41:37 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E7D732C03C7;
        Mon, 28 Mar 2022 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1648510893;
        bh=zd6sLGd9KzeKeuJg5bNahnkjJsMPW2on88ieV8eCP3g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=phFgwnWjfVZUR4k7YOUhpa9zra0HipDYgV0fd+utcg9yVT5ZY9rSIDkCqVH/7onDV
         EixjbH/0wzVzxLckEGvz8e3ux2BNpc25anSZcUhGrAG4RKvK5mdlKnrDlHc2XIK5kH
         p+T1bXcOrVOzue/CL4SlkSn7ArjGdUPbdIwMWamidoRqRv3gOF1kKb77y37DHQRqvi
         PcONTn9/NxeZLRRRo9+vADv7ZYZO8ZMVs8HpFE1ZiL45hwn3phtICva0azBGDLxf+z
         XFZXuTQQrBNcOc4Z+Dmws4oYeXwcy2WD8C5e9WLgMOjhcbQre7jPOitpfRUQrbrLS4
         n8z3y3XS191kQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B624247ad0001>; Tue, 29 Mar 2022 12:41:33 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 29 Mar 2022 12:41:34 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.033; Tue, 29 Mar 2022 12:41:34 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "huziji@marvell.com" <huziji@marvell.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 3/3] dt-bindings: mmc: xenon: add marvell,sdhci-xenon
 compatible
Thread-Topic: [PATCH v3 3/3] dt-bindings: mmc: xenon: add marvell,sdhci-xenon
 compatible
Thread-Index: AQHYP9xfIKBsD25f3Ee8lzl+NV4iRazPJzmAgAV51QA=
Date:   Mon, 28 Mar 2022 23:41:33 +0000
Message-ID: <7224b8bb-2f59-3b06-b4c3-0b86a6e4703f@alliedtelesis.co.nz>
References: <20220325000745.1708610-1-chris.packham@alliedtelesis.co.nz>
 <20220325000745.1708610-4-chris.packham@alliedtelesis.co.nz>
 <475d2af6-38cd-47a1-61b2-6b1298bf505d@kernel.org>
In-Reply-To: <475d2af6-38cd-47a1-61b2-6b1298bf505d@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F92C887757CA0499E265D9D286857E2@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Cfh2G4jl c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=jHPGDDJjT_i2t1f5GkIA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNi8wMy8yMiAwMTowNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMjUv
MDMvMjAyMiAwMTowNywgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IFRoZSBhcm1hZGEtMzd4eCBT
b0MgZHRzaSBpbmNsdWRlcyB0aGlzIGFzIGEgY29tcGF0aWJsZSBzdHJpbmcuIEFkZCBpdCB0bw0K
Pj4gdGhlIGR0LWJpbmRpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8
Y2hyaXMucGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPj4gLS0tDQo+Pg0KPj4gTm90ZXM6
DQo+PiAgICAgIENoYW5nZXMgaW4gdjM6DQo+PiAgICAgIC0gbmV3DQo+Pg0KPj4gICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvbWFydmVsbCx4ZW5vbi1zZGhjaS55YW1sICAgICAgICAgIHwg
NCArKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhl
bm9uLXNkaGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL21h
cnZlbGwseGVub24tc2RoY2kueWFtbA0KPj4gaW5kZXggMzI2YWMzZmEzNmI1Li43NzZiZWQ1MDQ2
ZmEgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1j
L21hcnZlbGwseGVub24tc2RoY2kueWFtbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9tYXJ2ZWxsLHhlbm9uLXNkaGNpLnlhbWwNCj4+IEBAIC0zMSw2ICsz
MSwxMCBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1h
ZGEtYXA4MDctc2RoY2kNCj4+ICAgICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFw
ODA2LXNkaGNpDQo+PiAgIA0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29u
c3Q6IG1hcnZlbGwsYXJtYWRhLTM3MDAtc2RoY2kNCj4+ICsgICAgICAgICAgLSBjb25zdDogbWFy
dmVsbCxzZGhjaS14ZW5vbg0KPiBEbyB5b3Uga25vdyBvZiBhbnkgdXNhZ2VzIG9mIG1hcnZlbGws
YXJtYWRhLTM3MDAtc2RoY2kgYWxvbmUgKHdpdGhvdXQNCj4gc2RoY2kteGVub24pPyBJZiBub3Qs
IGl0IHNob3VsZCBiZSByZW1vdmVkIGZyb20gdGhlIGVudW0gYmVmb3JlICh0aGUgb25lDQo+IGFk
ZGVkIGluIHlvdXIgcGF0Y2ggIzIpLiBJdCBkb2VzIG5vdCBsb29rIGNvcnJlY3QgdG8gaGF2ZSBp
dCBib3RoIGFzDQo+IHN0YW5kYWxvbmUgY29tcGF0aWJsZSBhbmQgb25lIGNvbXBhdGlibGUgd2l0
aCBzZGhjaS14ZW5vbi4gRWl0aGVyIGl0IGlzDQo+IGNvbXBhdGlibGUgd2l0aCBzZGhjaS14ZW5v
biBvciBub3QuIDopDQoNClRoZSBpbi10cmVlIHVzZXMgYWxsIGhhdmUgYm90aC4gSSdsbCByZW1v
dmUgaXQgZnJvbSB0aGUgZW51bS4NCg0KPg0KPiBJIHN1Z2dlc3RlZCBiZWZvcmUgdG8gbWFrZSB0
aGlzIGNoYW5nZSBoZXJlIGFzIHNlcGFyYXRlIHBhdGNoLCBidXQgSQ0KPiB0aGluayBJIG1pc3Nl
ZCB0aGUgZmFjdCB0aGF0IGl0IGlzIHNpbXBsZSBjb3JyZWN0aW9uIG9mDQo+IGFybWFkYS0zNzAw
LXNkaGNpIGNvbXBhdGlibGUuIFN1Y2ggc2ltcGxlIGNvcnJlY3Rpb25zIGNhbiBiZSBkb25lIHdp
dGhpbg0KPiBzYW1lIHBhdGNoIGFzIGNvbnZlcnNpb24sIHdpdGggZXhwbGFuYXRpb24gaW4gY29t
bWl0IG1zZyAod2hpY2ggd2FzDQo+IG1pc3NpbmcgaW4geW91ciB2MSkuDQo+DQo+IFRvIGF2b2lk
IHVubmVjZXNzYXJ5IHBhdGNoIGNoYW5nZXMgeW91IGNvdWxkIHNxdWFzaCBpdCB3aXRoIHYxIGFu
ZA0KPiBpbmNsdWRlIHRoaXMgaW4gdGhlIGNvbW1pdCBtc2cgKGFjdHVhbGx5IGV4dGVuZCBpdCB0
byBzYXkgdGhhdCB5b3UgYXJlDQo+IGNvcnJlY3RpbmcgdGhlIDM3MDAtc2RoY2kgY29tcGF0aWJs
ZSksIG9yIGNyZWF0ZSBwYXRjaCAjMiB0aGF0IHdheToNCj4NCj4gKyAgICBvbmVPZjoNCj4gKyAg
ICAgIC0gZW51bToNCj4gKyAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhLWNwMTEwLXNkaGNpDQo+
ICsgICAgICAgICAgLSBtYXJ2ZWxsLGFybWFkYS1hcDgwNi1zZGhjaQ0KPiArICAgICAgLSBpdGVt
czoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS1hcDgwNy1zZGhjaQ0KPiAr
ICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhLWFwODA2LXNkaGNpDQo+ICsgICAgICAt
IGl0ZW1zOg0KPiArICAgICAgICAgIC0gbWFydmVsbCxhcm1hZGEtMzcwMC1zZGhjaQ0KPg0KPiBz
byBub3cgeW91IHdpbGwgb25seSBhZGQgeGVub24gaGVyZS4gQnV0IHRoZW4gaXQgaXMgc28gc21h
bGwgcGF0Y2ggdGhhdA0KPiB3aXRoIGV4cGxhbmF0aW9uIHdlIHVzdWFsbHkgaW5jbHVkZSBpdCBp
biBjb252ZXJzaW9uLg0KT0sgd2lsbCBzcXVhc2ggYW5kIGFkZCBhbiBleHBsYW5hdGlvbiBmb3Ig
djQuDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
