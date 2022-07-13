Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31E5739D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbiGMPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiGMPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:13:42 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E445F7C;
        Wed, 13 Jul 2022 08:13:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657725163; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mrMKngAQqYCwk9A6pjbMNJmdEdqEncHNWUCIiEPv7YY7v6wLy4mYaennVmlxF4QIU62C+4FF6tdHgvahy5ect4AijcSUe1bBj0kyUecDnIvatcMt1o2mDHjowMjH6vVRHYpV5+nwEB24XIIW+icwpJLVBP9HLlorvy/1kziPAO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657725163; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CnSF4bwZCO7HwMz0t9IeSlJK915Bpdc93+QOSjaDgvA=; 
        b=Q8KUiHjc4rzW+Rq8O2B3NxHx8gz31Y0w9ZFyALSPXXkkvkRbXn2IuK5GsYpBSAZZbjsJ3vEBt8LS6ax5WKFa7ufZ7e9KTQ6hfIn/JqXYI4q4wQxZxbC+xlR/LQMieukqDB9jUR9Hp2KryK5yUPSOnMF9U0GcucuySss8l6vtTLU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657725163;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=CnSF4bwZCO7HwMz0t9IeSlJK915Bpdc93+QOSjaDgvA=;
        b=a00vBSbSx5AU2hSnDYZ0aJNajpswuEXPi7Zh9gLaOvgiFnjcZrk2pw+8Ncs/oBlM
        OA6r6q8GyOLZcYNHh+5E2hNIf9jm2kIIdrW9EmHpn3ucIvoVwU78B4InyiXv0GS7JK9
        lJ/rJBIrHQrC1xpZQiinrPaljREkHpQ4KsF84j0k=
Received: from edelgard.icenowy.me (59.41.163.162 [59.41.163.162]) by mx.zohomail.com
        with SMTPS id 1657725162649448.10627286230283; Wed, 13 Jul 2022 08:12:42 -0700 (PDT)
Message-ID: <1dc0f29b40d34bc6472ba4139ff36f63e9cc9e84.camel@icenowy.me>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jul 2022 23:12:37 +0800
In-Reply-To: <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
         <20220711184325.1367393-3-mail@conchuod.ie>
         <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
         <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
         <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
         <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjItMDctMTPmmJ/mnJ/kuInnmoQgMTU6MDkgKzAwMDDvvIxDb25vci5Eb29sZXlAbWlj
cm9jaGlwLmNvbeWGmemBk++8mgo+IAo+IAo+IE9uIDEzLzA3LzIwMjIgMTY6MDIsIEljZW5vd3kg
Wmhlbmcgd3JvdGU6Cj4gPiDlnKggMjAyMi0wNy0xM+aYn+acn+S4ieeahCAxNDo1NSArMDAwMO+8
jENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ6YGT77yaCj4gPiA+IE9uIDEzLzA3LzIwMjIg
MTU6MjYsIEljZW5vd3kgWmhlbmcgd3JvdGU6Cj4gPiA+ID4gCj4gPiA+ID4g5ZyoIDIwMjItMDct
MTHmmJ/mnJ/kuIDnmoQgMTk6NDMgKzAxMDDvvIxDb25vciBEb29sZXnlhpnpgZPvvJoKPiA+ID4g
PiA+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+Cj4gPiA+
ID4gPiAKPiA+ID4gPiA+IFRoZSBKSDcxMDAgaGFzIGEgMzIgYml0IG1vbml0b3IgY29yZSB0aGF0
IGlzIG1pc3NpbmcgZnJvbSB0aGUKPiA+ID4gPiA+IGRldmljZQo+ID4gPiA+ID4gdHJlZS4gQWRk
IGl0IChhbmQgaXRzIGNwdS1tYXAgZW50cnkpIHRvIG1vcmUgYWNjdXJhdGVseQo+ID4gPiA+ID4g
cmVmbGVjdAo+ID4gPiA+ID4gdGhlCj4gPiA+ID4gPiBhY3R1YWwgdG9wb2xvZ3kgb2YgdGhlIFNv
Qy4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4KPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gwqBhcmNoL3Jp
c2N2L2Jvb3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpIHwgMjEKPiA+ID4gPiA+ICsrKysrKysr
KysrKysrKysrKysrKwo+ID4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygr
KQo+ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0cy9z
dGFyZml2ZS9qaDcxMDAuZHRzaQo+ID4gPiA+ID4gYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL3N0YXJm
aXZlL2poNzEwMC5kdHNpCj4gPiA+ID4gPiBpbmRleCBjNjE3YTYxZTI2ZTIuLjkyZmNlNWI2NmQz
ZCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3
MTAwLmR0c2kKPiA+ID4gPiA+ICsrKyBiL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUvamg3
MTAwLmR0c2kKPiA+ID4gPiA+IEBAIC02Nyw2ICs2NywyMyBAQCBjcHUxX2ludGM6IGludGVycnVw
dC1jb250cm9sbGVyIHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB9Owo+ID4gPiA+ID4gCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBF
MjQ6IGNwdUAyIHsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInNpZml2ZSxlMjQiLCAicmlzY3YiOwo+ID4gPiA+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwyPjsK
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXZpY2VfdHlwZSA9ICJjcHUiOwo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGktY2FjaGUtYmxvY2stc2l6ZSA9IDwzMj47Cj4gPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaS1jYWNoZS1zZXRz
ID0gPDI1Nj47Cj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaS1jYWNoZS1zaXplID0gPDE2Mzg0PjsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByaXNjdixpc2EgPSAicnYzMmltYWZjIjsK
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dGF0dXMgPSAiZGlzYWJsZWQiOwo+ID4gPiA+ID4gKwo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdTJfaW50YzogaW50ZXJydXB0LWNvbnRy
b2xsZXIgewo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gInJpc2N2LGNwdS0KPiA+ID4gPiA+
IGludGMiOwo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQtY29udHJvbGxlcjsKPiA+ID4gPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsKPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBjcHUtbWFwIHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjAgewo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29yZTAgewo+
ID4gPiA+ID4gQEAgLTc2LDYgKzkzLDEwIEBAIGNvcmUwIHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUx
IHsKPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHUgPSA8JlU3NF8xPjsKPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH07Cj4gPiA+ID4gPiArCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUyIHsKPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IDwmRTI0PjsKPiA+ID4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+
ID4gPiAKPiA+ID4gPiBTb3JyeSBidXQgSSB0aGluayB0aGlzIGNoYW5nZSBtYWtlcyB0aGUgdG9w
b2xvZ3kgbW9yZQo+ID4gPiA+IGluYWNjdXJhdGUuCj4gPiA+ID4gCj4gPiA+ID4gVGhlIEUyNCBj
b3JlIGlzIHZlcnkgaW5kZXBlbmRlbnQsIGp1c3QgYW5vdGhlciBDUFUgY29yZQo+ID4gPiA+IGNv
bm5lY3RlZAo+ID4gPiA+IHRoZQo+ID4gPiA+IHNhbWUgYnVzIC0tIGV2ZW4gbm8gY29oZXJlbmN5
IChFMjQgdGFrZXMgQUhCLCB3aGljaCBpcyBub3QKPiA+ID4gPiBjb2hlcmVuY3ktCj4gPiA+ID4g
c2Vuc2libGUpLiBFdmVuIHRoZSBUQVAgb2YgaXQgaXMgaW5kZXBlbmRlbnQgd2l0aCB0aGUgVTc0
IFRBUC4KPiA+ID4gPiAKPiA+ID4gPiBBbmQgYnkgZGVmYXVsdCBpdCBkb2VzIG5vdCBib290IGFu
eSBwcm9wZXIgY29kZSAoaWYgYSBkZWJ1Z2dlcgo+ID4gPiA+IGlzCj4gPiA+ID4gYXR0YWNoZWQs
IGl0IHdpbGwgZGlzY292ZXIgdGhhdCB0aGUgRTI0IGlzIGluIGNvbnNpc3RlbnRseQo+ID4gPiA+
IGZhdWx0IGF0Cj4gPiA+ID4gMHgwCj4gPiA+ID4gKG10dmVjIGlzIDB4MCBhbmQgd2hlbiBmYXVs
dCBpdCBqdW1wcyB0byAweDAgYW5kIGZhdWx0IGFnYWluKSwKPiA+ID4gPiB1bnRpbAo+ID4gPiA+
IGl0cyBjbG9jayBpcyBqdXN0IHNodXRkb3duIGJ5IExpbnV4IGNsZWFuaW5nIHVwIHVudXNlZCBj
bG9ja3MuKQo+ID4gPiA+IAo+ID4gPiA+IFBlcnNvbmFsbHkgSSB0aGluayBpdCBzaG91bGQgYmUg
aW1wbGVtZW50ZWQgYXMgYSByZW1vdGVwcm9jCj4gPiA+ID4gaW5zdGVhZC4KPiA+ID4gCj4gPiA+
IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1dCBJIGRvbid0IHF1aXRlIGdldCB3aGF0
IHRoZQo+ID4gPiBkZXRhaWwKPiA+ID4gb2YgaG93IHdlIGFjY2VzcyB0aGlzIGluIGNvZGUgaGFz
IHRvIGRvIHdpdGggdGhlIGRldmljZXRyZWU/Cj4gPiA+IEl0IGlzIGFkZGVkIGhlcmUgaW4gYSBk
aXNhYmxlZCBzdGF0ZSwgYW5kIHdpbGwgbm90IGJlIHVzZWQgYnkKPiA+ID4gTGludXguCj4gPiA+
IFRoZSB2YXJpb3VzIFNpRml2ZSBTb0NzICYgU2lGaXZlIGNvcmVjb21wbGV4IHVzZXJzIHRoYXQg
aGF2ZSBhCj4gPiA+IGhhcnQKPiA+ID4gbm90IGNhcGFibGUgb2YgcnVubmluZyBMaW51eCBhbHNv
IGhhdmUgdGhhdCBoYXJ0IGRvY3VtZW50ZWQgaW4KPiA+ID4gdGhlCj4gPiA+IGRldmljZXRyZWUu
Cj4gPiA+IFRvIG1lLCB3aGF0IHdlIGFyZSBjaG9vc2luZyB0byBkbyB3aXRoIHRoaXMgaGFydCBk
b2VzIG5vdCByZWFsbHkKPiA+ID4gbWF0dGVyIHZlcnkgbXVjaCwgc2luY2UgdGhpcyBpcyBhIGRl
c2NyaXB0aW9uIG9mIHdoYXQgdGhlCj4gPiA+IGhhcmR3YXJlCj4gPiA+IGFjdHVhbGx5IGxvb2tz
IGxpa2UuCj4gPiAKPiA+IFRoZSBFMjQgaXMgbm90IGluIHRoZSBjb3JlIGNvbXBsZXggYXQgYWxs
LiBJdCdzIGp1c3QgYSBkZWRpY2F0ZSBDUFUKPiA+IGNvbm5lY3RlZCB0byBhbm90aGVyIGJ1cyAo
d2VsbCBhcyBJIHNhdyB0aGUgZG9jdW1lbnQgc2F5cyB0aGUgRTI0Cj4gPiBidXMKPiA+IGlzIG1h
eGltdW0gMkcsIEkgZG91YnQgd2hldGhlciBpdCdzIHRoZSBzYW1lIGJ1cyB3aXRoIHRoZSBVNzQg
b25lKS4KPiA+IAo+ID4gVGhlIFU3NCBNQyBvbmx5IGFsbG93cyBTNSBtYW5hZ2VtZW50IGNvcmVz
IHRvIGJlIHBhcnQgb2YgaXQsIG5vdAo+ID4gRTI0Lgo+IAo+IFNvIGlzIHRoZSBjb3JyZWN0IHRv
cG9sb2d5IG1vcmUgbGlrZToKPiBjcHUtbWFwIHsKPiDCoMKgwqDCoMKgwqDCoCBjbHVzdGVyMCB7
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUwIHsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IDwmVTc0XzA+Owo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb3JlMSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjcHUgPSA8JlU3NF8xPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsK
PiDCoMKgwqDCoMKgwqDCoCB9Owo+IMKgwqDCoMKgwqDCoMKgIGNsdXN0ZXIxIHsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29yZTAgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1ID0gPCZFMjQ+Owo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Owo+IMKgwqDCoMKgwqDCoMKgIH07Cj4gfTsKCkNvbnNpZGVyaW5nIEUy
NCBzZWVtcyB0byBzZWUgYSB0b3RhbCBkaWZmZXJlbnQgYnVzIGNvbm5lY3RlZCB0byBpdCwgSQpk
b24ndCB0aGluayBpdCBldmVuIHByb3BlciB0byBhZGQgaXQgdG8gY3B1cyBub2RlLgoKQW5kIEkg
ZG9uJ3QgdGhpbmsgaXQgaGFzIGEgaGFydCBpZCBvZiAyLCBhcyB5b3VyIG5vZGUgZGVzY3JpYmVz
LgoKPiDCoAoK


