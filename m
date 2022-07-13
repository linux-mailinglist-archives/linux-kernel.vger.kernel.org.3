Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C6A573A20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiGMP2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiGMP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:27:34 -0400
Received: from sender4-op-o17.zoho.com (sender4-op-o17.zoho.com [136.143.188.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E4D4D163;
        Wed, 13 Jul 2022 08:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657726017; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=LhJgxT+qJ2VwLECTwjahxTY8hbuKH4xstpFKH7C45io3nIpxG+thnWZzoyZWXSM8l7teTiml4evsjl8m3c8dHREwkD+L+s7WdZdOmtqQzOR0Xhk8cQAdxpHuuPkW9+2J2G4A2QiWYwLhx7jhUgDV48HtYWjTuhlDwkKCcq5QxsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657726017; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=cVzBen4uhhPFOCnlR7WXnffAGte55IWfzltR+NmpT0w=; 
        b=JasKhg8Uc1NHhE+GvGRzp2Y4Q9qOeb3UMehHHoJESXc2tapbrHRVXlkyB9G+H9Qk4tFX5TGPSXSBM0UXoPnsydPyAj4FoqsTBfeC4EDjhrtIIo9vcOStKfRimRmWg3wkbrhdxRJMxily5mrxPyF+RaWYwfkX1N3HeL722Qz74ME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657726017;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=cVzBen4uhhPFOCnlR7WXnffAGte55IWfzltR+NmpT0w=;
        b=CHhgfCGITZlhF5DcNAXv3BFGoaSb7XKuXh466G+1rpIJfEV71AaIfwywXeBffFAh
        h3ll3L+5emQsSqX8xIYS6oUiK15+LGlLFoteKsnJlmfAcAw+cRYqctZPy479VzKYstG
        2P9SDQ9J+UgHxwpquemN4gPUi0Ba8c4IYw20kMgA=
Received: from edelgard.icenowy.me (59.41.163.162 [59.41.163.162]) by mx.zohomail.com
        with SMTPS id 1657726015801697.9878975415504; Wed, 13 Jul 2022 08:26:55 -0700 (PDT)
Message-ID: <b983267d05f4acefb2a37f2ab8dd5d5a1742d9ff.camel@icenowy.me>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jul 2022 23:26:41 +0800
In-Reply-To: <b8fd1440-12f3-05af-5d6c-7938adf66344@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
         <20220711184325.1367393-3-mail@conchuod.ie>
         <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
         <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
         <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
         <6f6fae32-e3dc-4b9b-21b1-cc2ab0c67de6@microchip.com>
         <1dc0f29b40d34bc6472ba4139ff36f63e9cc9e84.camel@icenowy.me>
         <b8fd1440-12f3-05af-5d6c-7938adf66344@microchip.com>
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

5ZyoIDIwMjItMDctMTPmmJ/mnJ/kuInnmoQgMTU6MjEgKzAwMDDvvIxDb25vci5Eb29sZXlAbWlj
cm9jaGlwLmNvbeWGmemBk++8mgo+IE9uIDEzLzA3LzIwMjIgMTY6MTIsIEljZW5vd3kgWmhlbmcg
d3JvdGU6Cj4gPiDlnKggMjAyMi0wNy0xM+aYn+acn+S4ieeahCAxNTowOSArMDAwMO+8jENvbm9y
LkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ6YGT77yaCj4gPiA+IAo+ID4gPiAKPiA+ID4gT24gMTMv
MDcvMjAyMiAxNjowMiwgSWNlbm93eSBaaGVuZyB3cm90ZToKPiA+ID4gPiDlnKggMjAyMi0wNy0x
M+aYn+acn+S4ieeahCAxNDo1NSArMDAwMO+8jENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t5YaZ
6YGT77yaCj4gPiA+ID4gPiBPbiAxMy8wNy8yMDIyIDE1OjI2LCBJY2Vub3d5IFpoZW5nIHdyb3Rl
Ogo+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4g5ZyoIDIwMjItMDctMTHmmJ/mnJ/kuIDnmoQgMTk6
NDMgKzAxMDDvvIxDb25vciBEb29sZXnlhpnpgZPvvJoKPiA+ID4gPiA+ID4gPiBGcm9tOiBDb25v
ciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29tPgo+ID4gPiA+ID4gPiA+IAo+ID4g
PiA+ID4gPiA+IFRoZSBKSDcxMDAgaGFzIGEgMzIgYml0IG1vbml0b3IgY29yZSB0aGF0IGlzIG1p
c3NpbmcgZnJvbQo+ID4gPiA+ID4gPiA+IHRoZQo+ID4gPiA+ID4gPiA+IGRldmljZQo+ID4gPiA+
ID4gPiA+IHRyZWUuIEFkZCBpdCAoYW5kIGl0cyBjcHUtbWFwIGVudHJ5KSB0byBtb3JlIGFjY3Vy
YXRlbHkKPiA+ID4gPiA+ID4gPiByZWZsZWN0Cj4gPiA+ID4gPiA+ID4gdGhlCj4gPiA+ID4gPiA+
ID4gYWN0dWFsIHRvcG9sb2d5IG9mIHRoZSBTb0MuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNv
bT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiDCoGFyY2gvcmlzY3YvYm9vdC9kdHMv
c3RhcmZpdmUvamg3MTAwLmR0c2kgfCAyMQo+ID4gPiA+ID4gPiA+ICsrKysrKysrKysrKysrKysr
KysrKwo+ID4gPiA+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKykKPiA+
ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQo+ID4gPiA+ID4gPiA+IGIvYXJjaC9yaXNjdi9ib290L2R0
cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQo+ID4gPiA+ID4gPiA+IGluZGV4IGM2MTdhNjFlMjZlMi4u
OTJmY2U1YjY2ZDNkIDEwMDY0NAo+ID4gPiA+ID4gPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9k
dHMvc3RhcmZpdmUvamg3MTAwLmR0c2kKPiA+ID4gPiA+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2Jv
b3QvZHRzL3N0YXJmaXZlL2poNzEwMC5kdHNpCj4gPiA+ID4gPiA+ID4gQEAgLTY3LDYgKzY3LDIz
IEBAIGNwdTFfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgewo+ID4gPiA+ID4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+ID4gPiAKPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFMjQ6IGNwdUAyIHsKPiA+ID4g
PiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29t
cGF0aWJsZSA9ICJzaWZpdmUsZTI0IiwKPiA+ID4gPiA+ID4gPiAicmlzY3YiOwo+ID4gPiA+ID4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8
Mj47Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGRldmljZV90eXBlID0gImNwdSI7Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGktY2FjaGUtYmxvY2stc2l6ZSA9IDwzMj47
Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGktY2FjaGUtc2V0cyA9IDwyNTY+Owo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpLWNhY2hlLXNpemUgPSA8MTYzODQ+Owo+ID4g
PiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
aXNjdixpc2EgPSAicnYzMmltYWZjIjsKPiA+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ID4gPiA+
ID4gPiArCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNwdTJfaW50YzogaW50ZXJydXB0LWNvbnRyb2xsZXIgewo+ID4gPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtCj4gPiA+ID4gPiA+ID4gaW50YyI7Cj4gPiA+
ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpbnRlcnJ1cHQtY29udHJvbGxlcjsKPiA+ID4gPiA+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNp
bnRlcnJ1cHQtY2VsbHMgPSA8MT47Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdS1tYXAgewo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjAgewo+ID4gPiA+ID4g
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGNvcmUwIHsKPiA+ID4gPiA+ID4gPiBAQCAtNzYsNiArOTMsMTAgQEAgY29yZTAg
ewo+ID4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUxIHsKPiA+ID4gPiA+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3B1ID0gPCZVNzRfMT47Cj4gPiA+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+
ID4gPiArCj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlMiB7Cj4gPiA+ID4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY3B1ID0gPCZFMjQ+Owo+ID4gPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+IFNvcnJ5IGJ1dCBJIHRoaW5rIHRoaXMgY2hhbmdlIG1ha2VzIHRoZSB0
b3BvbG9neSBtb3JlCj4gPiA+ID4gPiA+IGluYWNjdXJhdGUuCj4gPiA+ID4gPiA+IAo+ID4gPiA+
ID4gPiBUaGUgRTI0IGNvcmUgaXMgdmVyeSBpbmRlcGVuZGVudCwganVzdCBhbm90aGVyIENQVSBj
b3JlCj4gPiA+ID4gPiA+IGNvbm5lY3RlZAo+ID4gPiA+ID4gPiB0aGUKPiA+ID4gPiA+ID4gc2Ft
ZSBidXMgLS0gZXZlbiBubyBjb2hlcmVuY3kgKEUyNCB0YWtlcyBBSEIsIHdoaWNoIGlzIG5vdAo+
ID4gPiA+ID4gPiBjb2hlcmVuY3ktCj4gPiA+ID4gPiA+IHNlbnNpYmxlKS4gRXZlbiB0aGUgVEFQ
IG9mIGl0IGlzIGluZGVwZW5kZW50IHdpdGggdGhlIFU3NAo+ID4gPiA+ID4gPiBUQVAuCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gPiBBbmQgYnkgZGVmYXVsdCBpdCBkb2VzIG5vdCBib290IGFueSBw
cm9wZXIgY29kZSAoaWYgYQo+ID4gPiA+ID4gPiBkZWJ1Z2dlcgo+ID4gPiA+ID4gPiBpcwo+ID4g
PiA+ID4gPiBhdHRhY2hlZCwgaXQgd2lsbCBkaXNjb3ZlciB0aGF0IHRoZSBFMjQgaXMgaW4gY29u
c2lzdGVudGx5Cj4gPiA+ID4gPiA+IGZhdWx0IGF0Cj4gPiA+ID4gPiA+IDB4MAo+ID4gPiA+ID4g
PiAobXR2ZWMgaXMgMHgwIGFuZCB3aGVuIGZhdWx0IGl0IGp1bXBzIHRvIDB4MCBhbmQgZmF1bHQK
PiA+ID4gPiA+ID4gYWdhaW4pLAo+ID4gPiA+ID4gPiB1bnRpbAo+ID4gPiA+ID4gPiBpdHMgY2xv
Y2sgaXMganVzdCBzaHV0ZG93biBieSBMaW51eCBjbGVhbmluZyB1cCB1bnVzZWQKPiA+ID4gPiA+
ID4gY2xvY2tzLikKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFBlcnNvbmFsbHkgSSB0aGluayBp
dCBzaG91bGQgYmUgaW1wbGVtZW50ZWQgYXMgYSByZW1vdGVwcm9jCj4gPiA+ID4gPiA+IGluc3Rl
YWQuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IE1heWJlIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsIGJ1
dCBJIGRvbid0IHF1aXRlIGdldCB3aGF0IHRoZQo+ID4gPiA+ID4gZGV0YWlsCj4gPiA+ID4gPiBv
ZiBob3cgd2UgYWNjZXNzIHRoaXMgaW4gY29kZSBoYXMgdG8gZG8gd2l0aCB0aGUgZGV2aWNldHJl
ZT8KPiA+ID4gPiA+IEl0IGlzIGFkZGVkIGhlcmUgaW4gYSBkaXNhYmxlZCBzdGF0ZSwgYW5kIHdp
bGwgbm90IGJlIHVzZWQgYnkKPiA+ID4gPiA+IExpbnV4Lgo+ID4gPiA+ID4gVGhlIHZhcmlvdXMg
U2lGaXZlIFNvQ3MgJiBTaUZpdmUgY29yZWNvbXBsZXggdXNlcnMgdGhhdCBoYXZlCj4gPiA+ID4g
PiBhCj4gPiA+ID4gPiBoYXJ0Cj4gPiA+ID4gPiBub3QgY2FwYWJsZSBvZiBydW5uaW5nIExpbnV4
IGFsc28gaGF2ZSB0aGF0IGhhcnQgZG9jdW1lbnRlZAo+ID4gPiA+ID4gaW4KPiA+ID4gPiA+IHRo
ZQo+ID4gPiA+ID4gZGV2aWNldHJlZS4KPiA+ID4gPiA+IFRvIG1lLCB3aGF0IHdlIGFyZSBjaG9v
c2luZyB0byBkbyB3aXRoIHRoaXMgaGFydCBkb2VzIG5vdAo+ID4gPiA+ID4gcmVhbGx5Cj4gPiA+
ID4gPiBtYXR0ZXIgdmVyeSBtdWNoLCBzaW5jZSB0aGlzIGlzIGEgZGVzY3JpcHRpb24gb2Ygd2hh
dCB0aGUKPiA+ID4gPiA+IGhhcmR3YXJlCj4gPiA+ID4gPiBhY3R1YWxseSBsb29rcyBsaWtlLgo+
ID4gPiA+IAo+ID4gPiA+IFRoZSBFMjQgaXMgbm90IGluIHRoZSBjb3JlIGNvbXBsZXggYXQgYWxs
LiBJdCdzIGp1c3QgYSBkZWRpY2F0ZQo+ID4gPiA+IENQVQo+ID4gPiA+IGNvbm5lY3RlZCB0byBh
bm90aGVyIGJ1cyAod2VsbCBhcyBJIHNhdyB0aGUgZG9jdW1lbnQgc2F5cyB0aGUKPiA+ID4gPiBF
MjQKPiA+ID4gPiBidXMKPiA+ID4gPiBpcyBtYXhpbXVtIDJHLCBJIGRvdWJ0IHdoZXRoZXIgaXQn
cyB0aGUgc2FtZSBidXMgd2l0aCB0aGUgVTc0Cj4gPiA+ID4gb25lKS4KPiA+ID4gPiAKPiA+ID4g
PiBUaGUgVTc0IE1DIG9ubHkgYWxsb3dzIFM1IG1hbmFnZW1lbnQgY29yZXMgdG8gYmUgcGFydCBv
ZiBpdCwKPiA+ID4gPiBub3QKPiA+ID4gPiBFMjQuCj4gPiA+IAo+ID4gPiBTbyBpcyB0aGUgY29y
cmVjdCB0b3BvbG9neSBtb3JlIGxpa2U6Cj4gPiA+IGNwdS1tYXAgewo+ID4gPiDCoMKgwqDCoMKg
wqDCoCBjbHVzdGVyMCB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3Jl
MCB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3B1ID0gPCZVNzRfMD47Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29yZTEgewo+ID4gPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IDwmVTc0XzE+Owo+
ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTsKPiA+ID4gwqDCoMKgwqDCoMKg
wqAgfTsKPiA+ID4gwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjEgewo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29yZTAgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdSA9IDwmRTI0PjsKPiA+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH07Cj4gPiA+IMKgwqDCoMKgwqDCoMKgIH07Cj4gPiA+IH07Cj4gPiAK
PiA+IENvbnNpZGVyaW5nIEUyNCBzZWVtcyB0byBzZWUgYSB0b3RhbCBkaWZmZXJlbnQgYnVzIGNv
bm5lY3RlZCB0byBpdCwKPiA+IEkKPiA+IGRvbid0IHRoaW5rIGl0IGV2ZW4gcHJvcGVyIHRvIGFk
ZCBpdCB0byBjcHVzIG5vZGUuCj4gCj4gV2VsbCwgaXQgaXMgYSBDUFUgaXMgaXQgbm90PyBIb3cg
b25lIGlzIHN1cHBvc2VkIHRvIGRvY3VtZW50IHRoYXQgYQo+IENQVSBpcyBub3QgYXR0YWNoZWQg
dG8gdGhlIHNhbWUgYnVzZXMgSSBkbyBub3Qga25vdyBob3dldmVyLgoKSSBkb24ndCB0aGluayB0
aGlzIGtpbmQgb2YgQ1BVcyBzaG91bGQgZXhpc3QgaW4gL2NwdXMsIHRoZXkgc2hvdWxkIGp1c3QK
YmUgc2VlbiBhcyBwZXJpcGhlcmFscyBhcyB0aGUgbWFpbiBzeXN0ZW0uIFRoZSBzcGVjaWFsaXR5
IG9mIEZVWzU3XTQwJ3MKbWFuYWdlbWVudCBjb3JlIGlzIHRoYXQgdGhleSdyZSBpbiB0aGUgc2Ft
ZSBjb3JlIGNvbXBsZXggd2l0aCB0aGUgQ1BVCmNvcmVzIHRoYXQgcnVuIExpbnV4LCBqdXN0IGNv
cmVzIHdpdGggYSBkaWZmZXJlbnQgY2FwYWJpbGl0eSB0aGF0IHdlCmNvdWxkIG5vdCBleHBhbmQg
TGludXggdG8gdGhlbS4KCj4gCj4gPiAKPiA+IEFuZCBJIGRvbid0IHRoaW5rIGl0IGhhcyBhIGhh
cnQgaWQgb2YgMiwgYXMgeW91ciBub2RlIGRlc2NyaWJlcy4KPiAKPiBEbyB5b3UgaGF2ZSBhbnkg
aWRlYSB3aGF0IGl0IHdvdWxkIGJlIHRoZW4/CgpBcyBJIGFza2VkIG9uZSBvZiBteSBmcmllbmQg
d2hvIGhhcyBKVEFHIGFjY2VzcyB0byBKSDcxMTAsIHRoZSBoYXJ0IGlkCmlzIDAsIHRoZSBzYW1l
IHdpdGggdGhlIGZpcnN0IGhhcnQgaW4gVTc0LU1DLgo=


