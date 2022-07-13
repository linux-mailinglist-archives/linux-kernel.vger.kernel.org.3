Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E231573995
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbiGMPEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiGMPDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:03:37 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DAF419B3;
        Wed, 13 Jul 2022 08:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657724593; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=QsT35ORXtAJeSTjFa44LEjzilNyWIl4p4gxCyf/T2JPrjhe0OI2Vrgbt2b3p4ven1RroyoQh0DUgDHdHPTrXz5JoOJ7v8pOV43BRCfkd0Y3ejdFLy3gV96mqWGS70L9ooh6xxAFSu5o9DCSRhZvoDak0X6pAg6aRmdEBFnw51kA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657724593; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=D+Gqc3YA/09OGd7O8cdC82y7eGf0+fzdFohMFXir6GM=; 
        b=KMJF86iuKoFqNGfKqUwq9uuGpK7xh2LNPc6cY3jRKcX00wr6vN7Spg2GcM3eWaoolaS1JG3s0IUMwk9CjOyEHGRFIBUxggmomVDF2f+zhNqx4XKJuXic+epuWIZuC7osVctU9ZXFKLh/JhT2Brb1Kvp70nPiffTlaidu4AHkFmU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657724593;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=D+Gqc3YA/09OGd7O8cdC82y7eGf0+fzdFohMFXir6GM=;
        b=M+8fCM4717k9RKSP85pMcH070evhI2Aytsbjh9G+vJ3c/ShxoUM+FMPJFRvPIzuY
        d5U/n/kFURwU7kt21dQMh77ZNhBkLJWAd/X56xLIDFIejpMqU/gUD8vj4HlRUgGgHp1
        YcIw7oBXyWkGvhRI897bHMP6VnJQ2FyQyuw+s/iM=
Received: from edelgard.icenowy.me (59.41.163.162 [59.41.163.162]) by mx.zohomail.com
        with SMTPS id 1657724591882157.92480341902512; Wed, 13 Jul 2022 08:03:11 -0700 (PDT)
Message-ID: <822ceff8a6e7f41179abde307ce59c2120684294.camel@icenowy.me>
Subject: Re: [PATCH v1 2/2] riscv: dts: starfive: add the missing monitor
 core
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, mail@conchuod.ie, kernel@esmil.dk,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Jul 2022 23:02:34 +0800
In-Reply-To: <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
References: <20220711184325.1367393-1-mail@conchuod.ie>
         <20220711184325.1367393-3-mail@conchuod.ie>
         <e8543838cd221ab6699da16c985eed7514daa786.camel@icenowy.me>
         <55e9da06-ccdb-f8e5-b5b9-8125b5fbb58a@microchip.com>
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

5ZyoIDIwMjItMDctMTPmmJ/mnJ/kuInnmoQgMTQ6NTUgKzAwMDDvvIxDb25vci5Eb29sZXlAbWlj
cm9jaGlwLmNvbeWGmemBk++8mgo+IE9uIDEzLzA3LzIwMjIgMTU6MjYsIEljZW5vd3kgWmhlbmcg
d3JvdGU6Cj4gPiAKPiA+IOWcqCAyMDIyLTA3LTEx5pif5pyf5LiA55qEIDE5OjQzICswMTAw77yM
Q29ub3IgRG9vbGV55YaZ6YGT77yaCj4gPiA+IEZyb206IENvbm9yIERvb2xleSA8Y29ub3IuZG9v
bGV5QG1pY3JvY2hpcC5jb20+Cj4gPiA+IAo+ID4gPiBUaGUgSkg3MTAwIGhhcyBhIDMyIGJpdCBt
b25pdG9yIGNvcmUgdGhhdCBpcyBtaXNzaW5nIGZyb20gdGhlCj4gPiA+IGRldmljZQo+ID4gPiB0
cmVlLiBBZGQgaXQgKGFuZCBpdHMgY3B1LW1hcCBlbnRyeSkgdG8gbW9yZSBhY2N1cmF0ZWx5IHJl
ZmxlY3QKPiA+ID4gdGhlCj4gPiA+IGFjdHVhbCB0b3BvbG9neSBvZiB0aGUgU29DLgo+ID4gPiAK
PiA+ID4gU2lnbmVkLW9mZi1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlw
LmNvbT4KPiA+ID4gLS0tCj4gPiA+IMKgYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcx
MDAuZHRzaSB8IDIxCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKwo+ID4gPiDCoDEgZmlsZSBj
aGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9y
aXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcxMDAuZHRzaQo+ID4gPiBiL2FyY2gvcmlzY3YvYm9v
dC9kdHMvc3RhcmZpdmUvamg3MTAwLmR0c2kKPiA+ID4gaW5kZXggYzYxN2E2MWUyNmUyLi45MmZj
ZTViNjZkM2QgMTAwNjQ0Cj4gPiA+IC0tLSBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvc3RhcmZpdmUv
amg3MTAwLmR0c2kKPiA+ID4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9zdGFyZml2ZS9qaDcx
MDAuZHRzaQo+ID4gPiBAQCAtNjcsNiArNjcsMjMgQEAgY3B1MV9pbnRjOiBpbnRlcnJ1cHQtY29u
dHJvbGxlciB7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfTsKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiA+IAo+
ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFMjQ6IGNwdUAyIHsKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAi
c2lmaXZlLGUyNCIsICJyaXNjdiI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8Mj47Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZpY2VfdHlwZSA9ICJjcHUiOwo+ID4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaS1jYWNoZS1ibG9jay1zaXpl
ID0gPDMyPjsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGktY2FjaGUtc2V0cyA9IDwyNTY+Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaS1jYWNoZS1zaXplID0gPDE2Mzg0PjsKPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpc2N2LGlzYSA9ICJydjMy
aW1hZmMiOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RhdHVzID0gImRpc2FibGVkIjsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1Ml9pbnRjOiBpbnRlcnJ1cHQtY29udHJvbGxl
ciB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJyaXNjdixjcHUtaW50YyI7Cj4gPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50ZXJydXB0LWNvbnRyb2xsZXI7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2ludGVycnVwdC1jZWxscyA9IDwxPjsK
PiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiA+ICsKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNwdS1tYXAgewo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsdXN0ZXIwIHsKPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29y
ZTAgewo+ID4gPiBAQCAtNzYsNiArOTMsMTAgQEAgY29yZTAgewo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3JlMSB7
Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjcHUgPSA8JlU3NF8xPjsKPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvcmUyIHsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y3B1ID0gPCZFMjQ+Owo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH07Cj4gPiAKPiA+IFNvcnJ5IGJ1dCBJIHRoaW5rIHRo
aXMgY2hhbmdlIG1ha2VzIHRoZSB0b3BvbG9neSBtb3JlIGluYWNjdXJhdGUuCj4gPiAKPiA+IFRo
ZSBFMjQgY29yZSBpcyB2ZXJ5IGluZGVwZW5kZW50LCBqdXN0IGFub3RoZXIgQ1BVIGNvcmUgY29u
bmVjdGVkCj4gPiB0aGUKPiA+IHNhbWUgYnVzIC0tIGV2ZW4gbm8gY29oZXJlbmN5IChFMjQgdGFr
ZXMgQUhCLCB3aGljaCBpcyBub3QKPiA+IGNvaGVyZW5jeS0KPiA+IHNlbnNpYmxlKS4gRXZlbiB0
aGUgVEFQIG9mIGl0IGlzIGluZGVwZW5kZW50IHdpdGggdGhlIFU3NCBUQVAuCj4gPiAKPiA+IEFu
ZCBieSBkZWZhdWx0IGl0IGRvZXMgbm90IGJvb3QgYW55IHByb3BlciBjb2RlIChpZiBhIGRlYnVn
Z2VyIGlzCj4gPiBhdHRhY2hlZCwgaXQgd2lsbCBkaXNjb3ZlciB0aGF0IHRoZSBFMjQgaXMgaW4g
Y29uc2lzdGVudGx5IGZhdWx0IGF0Cj4gPiAweDAKPiA+IChtdHZlYyBpcyAweDAgYW5kIHdoZW4g
ZmF1bHQgaXQganVtcHMgdG8gMHgwIGFuZCBmYXVsdCBhZ2FpbiksCj4gPiB1bnRpbAo+ID4gaXRz
IGNsb2NrIGlzIGp1c3Qgc2h1dGRvd24gYnkgTGludXggY2xlYW5pbmcgdXAgdW51c2VkIGNsb2Nr
cy4pCj4gPiAKPiA+IFBlcnNvbmFsbHkgSSB0aGluayBpdCBzaG91bGQgYmUgaW1wbGVtZW50ZWQg
YXMgYSByZW1vdGVwcm9jCj4gPiBpbnN0ZWFkLgo+IAo+IE1heWJlIEkgYW0gbWlzc2luZyBzb21l
dGhpbmcsIGJ1dCBJIGRvbid0IHF1aXRlIGdldCB3aGF0IHRoZSBkZXRhaWwKPiBvZiBob3cgd2Ug
YWNjZXNzIHRoaXMgaW4gY29kZSBoYXMgdG8gZG8gd2l0aCB0aGUgZGV2aWNldHJlZT8KPiBJdCBp
cyBhZGRlZCBoZXJlIGluIGEgZGlzYWJsZWQgc3RhdGUsIGFuZCB3aWxsIG5vdCBiZSB1c2VkIGJ5
IExpbnV4Lgo+IFRoZSB2YXJpb3VzIFNpRml2ZSBTb0NzICYgU2lGaXZlIGNvcmVjb21wbGV4IHVz
ZXJzIHRoYXQgaGF2ZSBhIGhhcnQKPiBub3QgY2FwYWJsZSBvZiBydW5uaW5nIExpbnV4IGFsc28g
aGF2ZSB0aGF0IGhhcnQgZG9jdW1lbnRlZCBpbiB0aGUKPiBkZXZpY2V0cmVlLgo+IFRvIG1lLCB3
aGF0IHdlIGFyZSBjaG9vc2luZyB0byBkbyB3aXRoIHRoaXMgaGFydCBkb2VzIG5vdCByZWFsbHkK
PiBtYXR0ZXIgdmVyeSBtdWNoLCBzaW5jZSB0aGlzIGlzIGEgZGVzY3JpcHRpb24gb2Ygd2hhdCB0
aGUgaGFyZHdhcmUKPiBhY3R1YWxseSBsb29rcyBsaWtlLgoKVGhlIEUyNCBpcyBub3QgaW4gdGhl
IGNvcmUgY29tcGxleCBhdCBhbGwuIEl0J3MganVzdCBhIGRlZGljYXRlIENQVQpjb25uZWN0ZWQg
dG8gYW5vdGhlciBidXMgKHdlbGwgYXMgSSBzYXcgdGhlIGRvY3VtZW50IHNheXMgdGhlIEUyNCBi
dXMKaXMgbWF4aW11bSAyRywgSSBkb3VidCB3aGV0aGVyIGl0J3MgdGhlIHNhbWUgYnVzIHdpdGgg
dGhlIFU3NCBvbmUpLgoKVGhlIFU3NCBNQyBvbmx5IGFsbG93cyBTNSBtYW5hZ2VtZW50IGNvcmVz
IHRvIGJlIHBhcnQgb2YgaXQsIG5vdCBFMjQuCgpCVFcgSSBkb24ndCB0aGluayBhIGNvcmUgY29t
cGxleCBjYW4gaGF2ZSBtdWx0aXBsZSBUQVBzIGZvciBtdWx0aXBsZQpoYXJ0cywgYnV0IEUyNCBo
YXMgaXRzIG93biBUQVAuCgo+IAo+IFRoYW5rcywKPiBDb25vci4KPiAKCg==


