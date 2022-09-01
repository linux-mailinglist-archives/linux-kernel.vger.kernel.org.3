Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE415A9DE5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbiIARSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIARSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:18:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27B696E6;
        Thu,  1 Sep 2022 10:18:14 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:5d1b:508b:29e6:6ca1] (unknown [IPv6:2a00:23c6:c311:3401:5d1b:508b:29e6:6ca1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 622EC660036C;
        Thu,  1 Sep 2022 18:18:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662052692;
        bh=3PaggCDPBN6H9AVbZT2VWeKSAv/gx6GQM5tXy01Z52Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iL4nT3xtq3cb08IzKBPevAKs9C5StwebRErLIJDZmkd1Bp54xcX/FXN7OobDwhjUv
         wVEklYIkv9keoWG0edhHcihaZdtxfQRhenCth7FCCGHTpfIBzvU45i+1Ti73PsJrTI
         Slt5g/bGcbdtugBU+4ph4NGJI+72obzw9B36afxbVMbOXi5TTy9YTCMHG+dRpAdrLe
         vG9HLDsJvW+sHalBNLSXzW4MVeyQ1QTDNL5MiCA28Kr0UH9uV9rN3CIYIC4hhHlnlx
         TonOUPWP3/gXQg6q2UpvWDynEp9Nx/z3Du9FXjau3EqycHk9n4JUzeTU8UtvJW8uFQ
         3w7IZ6H5Lw3AA==
Message-ID: <ff085325437dbe1bd5397b40ecfe4697c5658f33.camel@collabora.com>
Subject: Re: [PATCH 5/5] gpio: pca953x: Add support for PCAL6534 and
 compatible
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Collabora Kernel ML <kernel@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 01 Sep 2022 18:18:10 +0100
In-Reply-To: <CAHp75VfZmmDGJJ5wxM8-pbqo+npOSZrPtyJnQhuGadLUYod=3A@mail.gmail.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
         <20220829133923.1114555-5-martyn.welch@collabora.com>
         <CAHp75VfZmmDGJJ5wxM8-pbqo+npOSZrPtyJnQhuGadLUYod=3A@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-1+b1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTAxIGF0IDAwOjAyICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gTW9uLCBBdWcgMjksIDIwMjIgYXQgNDo1MiBQTSBNYXJ0eW4gV2VsY2gKPiA8bWFydHlu
LndlbGNoQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+ID4gCj4gPiBBZGQgc3VwcG9ydCBmb3IgdGhl
IE5YUCBQQ0FMNjUzNCBhbmQgRGlvZGVzIEluYy4gUEk0SU9FNVY2NTM0US4KPiA+IFRoZXNlCj4g
PiBkZXZpY2VzLCB3aGljaCBoYXZlIGlkZW50aWNhbCByZWdpc3RlciBsYXlvdXRzIGFuZCBmZWF0
dXJlcywgYXJlCj4gPiBicm9hZGx5IGEKPiA+IDM0LWJpdCB2ZXJzaW9uIG9mIHRoZSBQQ0FMNjUy
NC4KPiA+IAo+ID4gSG93ZXZlciwgd2hpbHN0IHRoZSByZWdpc3RlcnMgYXJlIGJyb2FkbHkgd2hh
dCB5b3UnZCBleHBlY3QgZm9yIGEKPiA+IDM0LWJpdAo+ID4gdmVyc2lvbiBvZiB0aGUgUENBTDY1
MjQsIHRoZSBzcGFjaW5nIG9mIHRoZSByZWdpc3RlcnMgaGFzIGJlZW4KPiA+IGNvbXBhY3RlZC4g
VGhpcyBoYXMgdGhlIHVuZm9ydHVuYXRlIGVmZmVjdCBvZiBicmVha2luZyB0aGUgYml0Cj4gPiBz
aGlmdAo+ID4gYmFzZWQgbWVjaGFuaXNtIHRoYXQgaXMgZW1wbG95ZWQgdG8gd29yayBvdXQgcmVn
aXN0ZXIgbG9jYXRpb25zCj4gPiB1c2VkIGJ5Cj4gPiB0aGUgb3RoZXIgY2hpcHMgc3VwcG9ydGVk
IGJ5IHRoaXMgZHJpdmVyLCByZXN1bHRpbmcgaW4gc3BlY2lhbAo+ID4gaGFuZGxpbmcKPiA+IG5l
ZWRpbmcgdG8gYmUgaW50cm9kdWNlZCBpbiBwY2E5NTN4X3JlY2FsY19hZGRyKCkgYW5kCj4gPiBw
Y2E5NTN4X2NoZWNrX3JlZ2lzdGVyKCkuCj4gCj4gVGhpcyBzdGlsbCBuZWVkcyBhbiBhbHRlcm5h
dGl2ZSBkZWVwIHJldmlldy4gSSdsbCBkbyBteSBiZXN0IHRvIGdldAo+IGludG8gaXQgc29vbmVy
IHRoYW4gbGF0ZXIuCj4gCgpUaGFua3MgbXVjaCBhcHByZWNpYXRlZC4KCi4uLgoKPiA+IMKgc3Rh
dGljIHU4IHBjYTk1M3hfcmVjYWxjX2FkZHIoc3RydWN0IHBjYTk1M3hfY2hpcCAqY2hpcCwgaW50
IHJlZywKPiA+IGludCBvZmYpCj4gPiDCoHsKPiA+IC3CoMKgwqDCoMKgwqAgaW50IGJhbmtfc2hp
ZnQgPSBwY2E5NTN4X2Jhbmtfc2hpZnQoY2hpcCk7Cj4gPiAtwqDCoMKgwqDCoMKgIGludCBhZGRy
ID0gKHJlZyAmIFBDQUxfR1BJT19NQVNLKSA8PCBiYW5rX3NoaWZ0Owo+ID4gLcKgwqDCoMKgwqDC
oCBpbnQgcGluY3RybCA9IChyZWcgJiBQQ0FMX1BJTkNUUkxfTUFTSykgPDwgMTsKPiA+IC3CoMKg
wqDCoMKgwqAgdTggcmVnYWRkciA9IHBpbmN0cmwgfCBhZGRyIHwgKG9mZiAvIEJBTktfU1opOwo+
ID4gK8KgwqDCoMKgwqDCoCBpbnQgYWRkcjsKPiA+ICvCoMKgwqDCoMKgwqAgaW50IHBpbmN0cmw7
Cj4gPiArwqDCoMKgwqDCoMKgIHU4IHJlZ2FkZHI7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIGlm
IChQQ0FfQ0hJUF9UWVBFKGNoaXAtPmRyaXZlcl9kYXRhKSA9PSBQQ0FMNjUzWF9UWVBFKSB7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUaGUgUENBTDY1MzQgYW5kIGNvbXBh
dGlibGUgY2hpcHMgaGF2ZSBhbHRlcmVkCj4gPiBiYW5rIGFsaWdubWVudCB0aGF0IGRvZXNuJ3QK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBmaXQgd2l0aGluIHRoZSBiaXQg
c2hpZnRpbmcgc2NoZW1lIHVzZWQgZm9yCj4gPiBvdGhlciBkZXZpY2VzLgo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgYWRkciA9IChyZWcgJiBQQ0FMX0dQSU9fTUFTSykgKiBOQkFOSyhjaGlwKTsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN3aXRjaCAocmVnKSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDQUw5NTNYX09VVF9TVFJFTkdUSDoKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENBTDk1M1hfSU5fTEFUQ0g6Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDQUw5NTNYX1BVTExfRU46Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDQUw5NTNYX1BVTExfU0VMOgo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBQQ0FMOTUzWF9JTlRfTUFTSzoKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENBTDk1M1hfSU5UX1NUQVQ6Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFBDQUw5NTNYX09VVF9DT05GOgo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBpbmN0cmwg
PSAoKHJlZyAmIFBDQUxfUElOQ1RSTF9NQVNLKSA+PiAxKQo+ID4gKyAweDIwOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBQQ0FMNjUyNF9JTlRfRURHRToKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENBTDY1MjRfSU5UX0NMUjoKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENBTDY1MjRfSU5fU1RBVFVTOgo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBQQ0FMNjUyNF9PVVRfSU5EQ09ORjoKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgUENBTDY1MjRfREVCT1VOQ0U6Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGluY3RybCA9
ICgocmVnICYgUENBTF9QSU5DVFJMX01BU0spID4+IDEpCj4gPiArIDB4MWM7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZWdhZGRyID0gcGluY3RybCArIGFkZHIgKyAob2ZmIC8gQkFOS19TWik7Cj4gPiArwqDCoMKg
wqDCoMKgIH0gZWxzZSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgYmFu
a19zaGlmdCA9IHBjYTk1M3hfYmFua19zaGlmdChjaGlwKTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFkZHIgPSAocmVnICYgUENBTF9HUElPX01BU0spIDw8IGJhbmtf
c2hpZnQ7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwaW5jdHJsID0gKHJlZyAm
IFBDQUxfUElOQ1RSTF9NQVNLKSA8PCAxOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmVnYWRkciA9IHBpbmN0cmwgfCBhZGRyIHwgKG9mZiAvIEJBTktfU1opOwo+ID4gK8KgwqDC
oMKgwqDCoCB9Cj4gCj4gTG9va2luZyBhdCBhbGwgdGhlc2UsIHdoeSBub3QgYWRkIHRoZSBjYWxs
YmFja3MgZm9yIHJlY2FsY19hZGRyIGFuZAo+IGNoZWNrX3JlZyBhbmQgYXNzaWduIHRoZW0gaW4g
dGhlIC0+cHJvYmUoKT8KPiAKClllYWgsIHRoYXQgc291bmRzIGxpa2UgYSBnb29kIHBsYW4uIEkn
bGwgbG9vayBpbnRvIGRvaW5nIHRoYXQuCgpNYXJ0eW4K

