Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805D455CC50
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345300AbiF1LG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiF1LGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:06:54 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0FC431230
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:06:51 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Tue, 28 Jun 2022 19:06:39
 +0800 (GMT+08:00)
X-Originating-IP: [10.190.65.172]
Date:   Tue, 28 Jun 2022 19:06:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   duoming@zju.edu.cn
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        johannes@sipsolutions.net
Subject: Re: [PATCH v7] devcoredump: change gfp_t parameter of kzalloc to
 GFP_KERNEL
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <YrqbAgM6aR8OKpZj@kroah.com>
References: <20220628034458.17384-1-duoming@zju.edu.cn>
 <YrqbAgM6aR8OKpZj@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5a9830c1.18fd7.181a9fded00.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgCHOAi_4LpiEEbDAg--.62789W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgsPAVZdtacQswAAs9
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGVsbG8sCgpPbiBUdWUsIDI4IEp1biAyMDIyIDA4OjA5OjA2ICswMjAwIGdyZWcgS0ggd3JvdGU6
Cgo+IE9uIFR1ZSwgSnVuIDI4LCAyMDIyIGF0IDExOjQ0OjU4QU0gKzA4MDAsIER1b21pbmcgWmhv
dSB3cm90ZToKPiA+IFRoZSBkZXZfY29yZWR1bXB2KCkgYW5kIGRldl9jb3JlZHVtcG0oKSBjb3Vs
ZCBub3QgYmUgdXNlZCBpbiBhdG9taWMKPiA+IGNvbnRleHQsIGJlY2F1c2UgdGhleSBjYWxsIGt2
YXNwcmludGZfY29uc3QoKSBhbmQga3N0cmR1cCgpIHdpdGgKPiA+IEdGUF9LRVJORUwgcGFyYW1l
dGVyLiBUaGUgcHJvY2VzcyBpcyBzaG93biBiZWxvdzoKPiA+IAo+ID4gZGV2X2NvcmVkdW1wdigu
LiwgZ2ZwX3QgZ2ZwKQo+ID4gICBkZXZfY29yZWR1bXBtKC4uLCBnZnBfdCBnZnApCj4gPiAgICAg
a3phbGxvYyguLiwgZ2ZwKTsKPiA+ICAgICBkZXZfc2V0X25hbWUKPiA+ICAgICAgIGtvYmplY3Rf
c2V0X25hbWVfdmFyZ3MKPiA+ICAgICAgICAga3Zhc3ByaW50Zl9jb25zdChHRlBfS0VSTkVMLCAu
Li4pOyAvL21heSBzbGVlcAo+ID4gICAgICAgICAgIGtzdHJkdXAocywgR0ZQX0tFUk5FTCk7IC8v
bWF5IHNsZWVwCj4gPiAKPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgZ2ZwX3QgcGFyYW1ldGVy
IG9mIGt6YWxsb2MoKSBpbiBkZXZfY29yZWR1bXBtKCkgdG8KPiA+IEdGUF9LRVJORUwgaW4gb3Jk
ZXIgdG8gc2hvdyB0aGV5IGNvdWxkIG5vdCBiZSB1c2VkIGluIGF0b21pYyBjb250ZXh0Lgo+ID4g
Cj4gPiBXaGF0J3MgbW9yZSwgdGhpcyBwYXRjaCBkb2VzIG5vdCByZW1vdmUgdGhlIGdmcF90IHBh
cmFtZXRlciBpbgo+ID4gZGV2X2NvcmVkdW1wdigpIGFuZCBkZXZfY29yZWR1bXBtKCkgaW4gb3Jk
ZXIgdGhhdCBpdCB3aWxsIG5vdCBpbmZsdWVuY2UKPiA+IG90aGVyIG5ldyB1c2VycyB0aGF0IGFy
ZSBhZGRlZCBpbiBvdGhlciB0cmVlcy4KPiA+IAo+ID4gRml4ZXM6IDgzM2M5NTQ1NmE3MCAoImRl
dmljZSBjb3JlZHVtcDogYWRkIG5ldyBkZXZpY2UgY29yZWR1bXAgY2xhc3MiKQo+ID4gU2lnbmVk
LW9mZi1ieTogRHVvbWluZyBaaG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gPiAtLS0KPiA+IENo
YW5nZXMgaW4gdjc6Cj4gPiAgIC0gY2hhbmdlIGdmcF90IHBhcmFtZXRlciBvZiBremFsbG9jIGlu
IGRldl9jb3JlZHVtcG0oKSB0byBHRlBfS0VSTkVMLgo+ID4gCj4gPiAgZHJpdmVycy9iYXNlL2Rl
dmNvcmVkdW1wLmMgfCAyICstCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1
bXAuYyBiL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jCj4gPiBpbmRleCBmNGQ3OTRkNmJiOC4u
Y2Y2MGFhY2Y4YTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYwo+
ID4gKysrIGIvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMKPiA+IEBAIC0yNjgsNyArMjY4LDcg
QEAgdm9pZCBkZXZfY29yZWR1bXBtKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IG1vZHVsZSAq
b3duZXIsCj4gPiAgCWlmICghdHJ5X21vZHVsZV9nZXQob3duZXIpKQo+ID4gIAkJZ290byBmcmVl
Owo+ID4gIAo+ID4gLQlkZXZjZCA9IGt6YWxsb2Moc2l6ZW9mKCpkZXZjZCksIGdmcCk7Cj4gPiAr
CWRldmNkID0ga3phbGxvYyhzaXplb2YoKmRldmNkKSwgR0ZQX0tFUk5FTCk7Cj4gCj4gTm8sIHlv
dSBjYW4ndCBqdXN0IGlnbm9yZSB0aGUgZmxhZyBlbnRpcmVseSwgdGhhdCBkb2Vzbid0IGhlbHAg
YW55b25lCj4gb3V0IHdobyB0cmllcyB0byBzZXQgaXQgYW5kIGlzIHRvdGFsbHkgY29uZnVzZWQg
YXMgdG8gd2h5IHRoZSBmaWVsZCBpcwo+IGlnbm9yZWQuCj4gCj4gWW91IG5lZWQgdG8gZXZvbHZl
IHRoZSBmdW5jdGlvbiBvdmVyIHRpbWUgdG8gbm90IG5lZWQgdGhlIHBhcmFtZXRlciBhdAo+IGFs
bCwgdGhpcyBqdXN0IHBhcGVycyBvdmVyIHRoZSBlbnRpcmUgaXNzdWUsIHdoaWNoIG1ha2VzIHRo
ZSBhcGkgbGllIHRvCj4gdGhlIGNhbGxlciwgbm90IHNvbWV0aGluZyB5b3UgZXZlciB3YW50IHRv
IGRvLgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIHJlcGx5LgoKQnV0IGlmIHRoZXJlIGFy
ZSBuZXcgZGV2aWNlcyBjb21lIGludG8ga2VybmVsLCBpdCBtYXkgdXNlIGRldmNvcmVkdW1wIGFw
aS4KV2hhdCBpcyB0aGUgcHJvcGVyIHRpbWUgdG8gcmVtb3ZlIHRoZSBnZnBfdCBwYXJhbWV0ZXIg
b2YgZGV2X2NvcmVkdW1wdigpCmFuZCBkZXZfY29yZWR1bXBtKCk/CgpCZXN0IHJlZ2FyZHMsCkR1
b21pbmcgWmhvdQ==
