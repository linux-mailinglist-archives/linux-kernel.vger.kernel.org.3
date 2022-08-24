Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A451C59FD94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbiHXOyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiHXOyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:54:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D6792EF;
        Wed, 24 Aug 2022 07:54:35 -0700 (PDT)
Received: from [10.3.2.12] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 94B596601E78;
        Wed, 24 Aug 2022 15:54:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661352874;
        bh=CVvG9u5fZgNaOo7ULIGJkLzIljQ//NxCzX6yHS/62rg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NR7CNznfTPjbBb6Ysl26B0Dw9uhrILYohGczNHFHvapI7yJufzs8OtN84tqRAnA/G
         6H9BUd7yACXyNZgjw6iGl+ukq0+5dDfO5ICfre3puaM6NKFBF6rBAWeDbnRHc18ndy
         FCASu+2JCVK2RpNizY8Dmu+TTJN8qyADhHchH3pA/mIdLXVzAbnbA3pgOyS9vKaXc3
         a0DeUsG6SejB8qoohy2Y3Kqny/JCkOi3lH7Ra90ttntGvYQACjXgM3IaiE1Hl8dGEi
         AM441ay1cffjemUG1UE9Q6N+Y0kU+MRtQPz0JjSB5n8JKyxN/IUkt3jX+pptqIB1wW
         sjR161ZHWLEzw==
Message-ID: <8d8413be9ec10852ca40e091a26db19436d23b71.camel@collabora.com>
Subject: Re: [RFC PATCH] gpio: pca953x: Support for pcal6534
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Aug 2022 15:54:30 +0100
In-Reply-To: <CAHp75Vc84yV40XwHdzHyWR7iM383iwvtQrxEXroJ6Lb41piCxA@mail.gmail.com>
References: <20220817112818.787771-1-martyn.welch@collabora.com>
         <CAHp75Vc1bnUGt66LYRAVuJP+OnhLTaU=AN1JdvfiH44O9_eO8g@mail.gmail.com>
         <370beac7c85da4f1b57d8d78715d2a0676d19cf9.camel@collabora.com>
         <CAHp75Vc84yV40XwHdzHyWR7iM383iwvtQrxEXroJ6Lb41piCxA@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDExOjU2ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gCj4gCj4gT24gTW9uZGF5LCBBdWd1c3QgMjIsIDIwMjIsIE1hcnR5biBXZWxjaCA8bWFydHlu
LndlbGNoQGNvbGxhYm9yYS5jb20+Cj4gd3JvdGU6Cj4gPiBPbiBTYXQsIDIwMjItMDgtMjAgYXQg
MDE6MzUgKzAzMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMTcs
IDIwMjIgYXQgMjoyOSBQTSBNYXJ0eW4gV2VsY2gKPiA+ID4gPG1hcnR5bi53ZWxjaEBjb2xsYWJv
cmEuY29tPiB3cm90ZToKPiA+ID4gPiDCoAo+ID4gPiA+IC3CoMKgwqDCoMKgwqAgaW50IGJhbmtf
c2hpZnQgPSBwY2E5NTN4X2Jhbmtfc2hpZnQoY2hpcCk7Cj4gPiA+ID4gLcKgwqDCoMKgwqDCoCBp
bnQgYmFuayA9IChyZWcgJiBSRUdfQUREUl9NQVNLKSA+PiBiYW5rX3NoaWZ0Owo+ID4gPiA+IC3C
oMKgwqDCoMKgwqAgaW50IG9mZnNldCA9IHJlZyAmIChCSVQoYmFua19zaGlmdCkgLSAxKTsKPiA+
ID4gPiArwqDCoMKgwqDCoMKgIGludCBiYW5rOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqAgaW50IG9m
ZnNldDsKPiA+ID4gPiArCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBpZiAoY2hpcC0+ZHJpdmVyX2Rh
dGEgJiBQQ0FMNjUzNF9BTElHTikgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJhbmsgPSAocmVnICYgUkVHX0FERFJfTUFTSykgLyBOQkFOSyhjaGlwKTsKPiA+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvZmZzZXQgPSByZWcgLSAoYmFuayAqIE5CQU5L
KGNoaXApKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gPiA+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGJhbmtfc2hpZnQgPSBwY2E5NTN4X2Jhbmtfc2hpZnQo
Y2hpcCk7Cj4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFuayA9IChyZWcg
JiBSRUdfQUREUl9NQVNLKSA+PiBiYW5rX3NoaWZ0Owo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG9mZnNldCA9IHJlZyAmIChCSVQoYmFua19zaGlmdCkgLSAxKTsKPiA+ID4g
PiArwqDCoMKgwqDCoMKgIH0KPiA+ID4gCj4gPiA+IEknbSB3b25kZXJpbmcgaWYgaXQgY2FuIGJl
IG1vdmVkIHRvIGJhbmtfc2hpZnQoKcKgIGFuZCBwb3NzaWJseSBhCj4gPiA+IG5ldwo+ID4gPiBo
ZWxwZXIgdG8gZ2V0IGFuIG9mZnNldC4KPiA+ID4gCj4gPiAKPiA+IER1ZSB0byB0aGUgZGlmZmVy
ZW50IHJlZ2lzdGVyIHNwYWNpbmcsIEkgZG9uJ3QgdGhpbmsgdGhlc2UgY2hpcHMKPiA+IG9iZXkK
PiA+IGFueSBvZmZzZXQgYmFzZWQgcnVsZXMuIEZvciB0aGUgcmVjb3JkLCBJJ3ZlIGRvbmUgYSBi
aXQgbW9yZSB3b3JrCj4gPiBoZXJlCj4gPiB0byBnZXQgaXQgcmV0dXJuaW5nIHRoZSBjb3JyZWN0
IHZhbHVlcyBmb3IgYWxsIHRoZSBleHRlbmRlZAo+ID4gcmVnaXN0ZXJzLgo+ID4gV2hhdCBJIGN1
cnJlbnRseSBoYXZlIGlzIHRoaXMgKHdoaWNoIEkgZG9uJ3QgcGFydGljdWxhcmx5IGxpa2UgYW5k
Cj4gPiB3b3VsZCBiZSBvcGVuIHRvIGFsdGVybmF0aXZlIGltcGxlbWVudGF0aW9ucyk6Cj4gPiAK
PiA+IAo+ID4gwqBzdGF0aWMgdTggcGNhOTUzeF9yZWNhbGNfYWRkcihzdHJ1Y3QgcGNhOTUzeF9j
aGlwICpjaGlwLCBpbnQgcmVnLAo+ID4gaW50Cj4gPiBvZmYpCj4gPiDCoHsKPiA+IC3CoCDCoCDC
oCDCoGludCBiYW5rX3NoaWZ0ID0gcGNhOTUzeF9iYW5rX3NoaWZ0KGNoaXApOwo+ID4gLcKgIMKg
IMKgIMKgaW50IGFkZHIgPSAocmVnICYgUENBTF9HUElPX01BU0spIDw8IGJhbmtfc2hpZnQ7Cj4g
PiAtwqAgwqAgwqAgwqBpbnQgcGluY3RybCA9IChyZWcgJiBQQ0FMX1BJTkNUUkxfTUFTSykgPDwg
MTsKPiA+IC3CoCDCoCDCoCDCoHU4IHJlZ2FkZHIgPSBwaW5jdHJsIHwgYWRkciB8IChvZmYgLyBC
QU5LX1NaKTsKPiA+ICvCoCDCoCDCoCDCoGludCBiYW5rX3NoaWZ0Owo+ID4gK8KgIMKgIMKgIMKg
aW50IGFkZHI7Cj4gPiArwqAgwqAgwqAgwqBpbnQgcGluY3RybDsKPiA+ICvCoCDCoCDCoCDCoHU4
IHJlZ2FkZHI7Cj4gPiArCj4gPiArwqAgwqAgwqAgwqBpZiAoY2hpcC0+ZHJpdmVyX2RhdGEgJiBQ
Q0FMNjUzNF9BTElHTikgewo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWRkciA9IChyZWcg
JiBQQ0FMX0dQSU9fTUFTSykgKiBOQkFOSyhjaGlwKTsKPiA+ICsKPiA+ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN3aXRjaChyZWcpIHsKPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2Ug
UENBTDk1M1hfT1VUX1NUUkVOR1RIOgo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBQ
Q0FMOTUzWF9JTl9MQVRDSDoKPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUENBTDk1
M1hfUFVMTF9FTjoKPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUENBTDk1M1hfUFVM
TF9TRUw6Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFBDQUw5NTNYX0lOVF9NQVNL
Ogo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBQQ0FMOTUzWF9JTlRfU1RBVDoKPiA+
ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUENBTDk1M1hfT1VUX0NPTkY6Cj4gPiArwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwaW5jdHJsID0gKChyZWcgJiBQQ0FMX1BJ
TkNUUkxfTUFTSykgPj4gMSkKPiA+ICsKPiA+IDB4MjA7Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2Ug
UENBTDY1MjRfSU5UX0VER0U6Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFBDQUw2
NTI0X0lOVF9DTFI6Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFBDQUw2NTI0X0lO
X1NUQVRVUzoKPiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgUENBTDY1MjRfT1VUX0lO
RENPTkY6Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIFBDQUw2NTI0X0RFQk9VTkNF
Ogo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGluY3RybCA9ICgocmVn
ICYgUENBTF9QSU5DVFJMX01BU0spID4+IDEpCj4gPiArCj4gPiAweDFjOwo+ID4gK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB9Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWdhZGRyID0gcGluY3RybCArIGFk
ZHIgKyAob2ZmIC8gQkFOS19TWik7Cj4gPiArwqAgwqAgwqAgwqB9IGVsc2Ugewo+ID4gK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYmFua19zaGlmdCA9IHBjYTk1M3hfYmFua19zaGlmdChjaGlwKTsK
PiA+ICvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZHIgPSAocmVnICYgUENBTF9HUElPX01BU0sp
IDw8IGJhbmtfc2hpZnQ7Cj4gPiArwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwaW5jdHJsID0gKHJl
ZyAmIFBDQUxfUElOQ1RSTF9NQVNLKSA8PCAxOwo+ID4gK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmVnYWRkciA9IHBpbmN0cmwgfCBhZGRyIHwgKG9mZiAvIEJBTktfU1opOwo+ID4gK8KgIMKgIMKg
IMKgfQo+ID4gCj4gPiDCoCDCoCDCoCDCoCByZXR1cm4gcmVnYWRkcjsKPiA+IMKgfQo+ID4gCj4g
PiBBcyBJIHNhaWQsIHdoaWxzdCB0aGUgZnVuY3Rpb25hbGl0eSBvZiB0aGlzIGNoaXAgc2VlbXMg
dG8gY2xvc2VseQo+ID4gbWF0Y2gKPiA+IHNvbWUgb2YgdGhlIG90aGVycyBkcml2ZW4gYnkgdGhp
cyBkcml2ZXIsIHRoZSByZWdpc3RlciBvZmZzZXRzIGFyZQo+ID4gcXVpdGUgZGlmZmVyZW50IGFu
ZCBoYXJkIHRvIGluY29ycG9yYXRlIGNsZWFubHkgaW4gdGhpcyBkcml2ZXIgZHVlCj4gPiB0bwo+
ID4gdGhlIHdheSBpdCBkZXRlcm1pbmVzIHJlZ2lzdGVyIGxvY2F0aW9ucy4KPiA+IAo+IAo+IAo+
IEkgdGhpbmsgaXQgY2FuIGJlIGRvbmUgbXVjaCBlYXNpZXIgd2l0aCB0aGUgc3BlY2lmaWMgcmVn
bWFwIGNhbGxiYWNrcwo+IHNwZWNpZmljIHRvIHRoZXNlIGtpbmQgb2YgY2hpcHMuCj4gwqAKCkFy
ZSB5b3UgdGhpbmtpbmcgb2YgZGVmaW5pbmcgZnVuY3Rpb25zIHZpYSBzdHJ1Y3QgcmVnbWFwX2J1
cz8gwqBJZiBzbywKSSdtIG5vdCBzdXJlIGhvdyB0aGlzIGhlbHBzLiBVbmxlc3MgSSd2ZSBtaXNz
IHVuZGVyc3Rvb2QgaG93IHRoYXQgd291bGQKd29yaywgdGhvc2Ugd291bGQgY29tZSBpbnRvIHBs
YXkgYWZ0ZXIgcmVnbWFwX2J1bGtfd3JpdGUoKSwgZXRjIGFyZQpjYWxsZWQsIGJ5IHdoaWNoIHBv
aW50IHRoZSBkZXNpcmVkIChhbmQgaW4gdGhpcyBjYXNlIHdyb25nKSBvZmZzZXQgd2lsbApoYXZl
IGFscmVhZHkgYmVlbiBjYWxjdWxhdGVkIGluIHBjYTk1M3hfcmVjYWxjX2FkZHIoKS4KCkFtIEkg
bWlzc2luZyBzb21ldGhpbmc/CgpNYXJ0eW4K

