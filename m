Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C6E55E687
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbiF1N7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347158AbiF1N5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:57:41 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD6C733E11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:57:33 -0700 (PDT)
Received: by ajax-webmail-mail-app2 (Coremail) ; Tue, 28 Jun 2022 21:57:26
 +0800 (GMT+08:00)
X-Originating-IP: [10.190.70.91]
Date:   Tue, 28 Jun 2022 21:57:26 +0800 (GMT+08:00)
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
In-Reply-To: <YrrxlT0KVCGY8zaq@kroah.com>
References: <20220628034458.17384-1-duoming@zju.edu.cn>
 <YrqbAgM6aR8OKpZj@kroah.com>
 <5a9830c1.18fd7.181a9fded00.Coremail.duoming@zju.edu.cn>
 <YrrxlT0KVCGY8zaq@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1fae34eb.1981d.181aa9a48c5.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: by_KCgDH3EDGCLtiCAbFAg--.64642W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAg4PAVZdtacaTgABsO
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

SGVsbG8sCgpPbiBUdWUsIDI4IEp1biAyMDIyIDE0OjE4OjI5ICswMjAwIGdyZWcgS0ggd3JvdGU6
Cgo+ID4gPiA+IFRoZSBkZXZfY29yZWR1bXB2KCkgYW5kIGRldl9jb3JlZHVtcG0oKSBjb3VsZCBu
b3QgYmUgdXNlZCBpbiBhdG9taWMKPiA+ID4gPiBjb250ZXh0LCBiZWNhdXNlIHRoZXkgY2FsbCBr
dmFzcHJpbnRmX2NvbnN0KCkgYW5kIGtzdHJkdXAoKSB3aXRoCj4gPiA+ID4gR0ZQX0tFUk5FTCBw
YXJhbWV0ZXIuIFRoZSBwcm9jZXNzIGlzIHNob3duIGJlbG93Ogo+ID4gPiA+IAo+ID4gPiA+IGRl
dl9jb3JlZHVtcHYoLi4sIGdmcF90IGdmcCkKPiA+ID4gPiAgIGRldl9jb3JlZHVtcG0oLi4sIGdm
cF90IGdmcCkKPiA+ID4gPiAgICAga3phbGxvYyguLiwgZ2ZwKTsKPiA+ID4gPiAgICAgZGV2X3Nl
dF9uYW1lCj4gPiA+ID4gICAgICAga29iamVjdF9zZXRfbmFtZV92YXJncwo+ID4gPiA+ICAgICAg
ICAga3Zhc3ByaW50Zl9jb25zdChHRlBfS0VSTkVMLCAuLi4pOyAvL21heSBzbGVlcAo+ID4gPiA+
ICAgICAgICAgICBrc3RyZHVwKHMsIEdGUF9LRVJORUwpOyAvL21heSBzbGVlcAo+ID4gPiA+IAo+
ID4gPiA+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgZ2ZwX3QgcGFyYW1ldGVyIG9mIGt6YWxsb2Mo
KSBpbiBkZXZfY29yZWR1bXBtKCkgdG8KPiA+ID4gPiBHRlBfS0VSTkVMIGluIG9yZGVyIHRvIHNo
b3cgdGhleSBjb3VsZCBub3QgYmUgdXNlZCBpbiBhdG9taWMgY29udGV4dC4KPiA+ID4gPiAKPiA+
ID4gPiBXaGF0J3MgbW9yZSwgdGhpcyBwYXRjaCBkb2VzIG5vdCByZW1vdmUgdGhlIGdmcF90IHBh
cmFtZXRlciBpbgo+ID4gPiA+IGRldl9jb3JlZHVtcHYoKSBhbmQgZGV2X2NvcmVkdW1wbSgpIGlu
IG9yZGVyIHRoYXQgaXQgd2lsbCBub3QgaW5mbHVlbmNlCj4gPiA+ID4gb3RoZXIgbmV3IHVzZXJz
IHRoYXQgYXJlIGFkZGVkIGluIG90aGVyIHRyZWVzLgo+ID4gPiA+IAo+ID4gPiA+IEZpeGVzOiA4
MzNjOTU0NTZhNzAgKCJkZXZpY2UgY29yZWR1bXA6IGFkZCBuZXcgZGV2aWNlIGNvcmVkdW1wIGNs
YXNzIikKPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVk
dS5jbj4KPiA+ID4gPiAtLS0KPiA+ID4gPiBDaGFuZ2VzIGluIHY3Ogo+ID4gPiA+ICAgLSBjaGFu
Z2UgZ2ZwX3QgcGFyYW1ldGVyIG9mIGt6YWxsb2MgaW4gZGV2X2NvcmVkdW1wbSgpIHRvIEdGUF9L
RVJORUwuCj4gPiA+ID4gCj4gPiA+ID4gIGRyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jIHwgMiAr
LQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
PiA+ID4gPiAKPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMg
Yi9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYwo+ID4gPiA+IGluZGV4IGY0ZDc5NGQ2YmI4Li5j
ZjYwYWFjZjhhOCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAu
Ywo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jCj4gPiA+ID4gQEAgLTI2
OCw3ICsyNjgsNyBAQCB2b2lkIGRldl9jb3JlZHVtcG0oc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgbW9kdWxlICpvd25lciwKPiA+ID4gPiAgCWlmICghdHJ5X21vZHVsZV9nZXQob3duZXIpKQo+
ID4gPiA+ICAJCWdvdG8gZnJlZTsKPiA+ID4gPiAgCj4gPiA+ID4gLQlkZXZjZCA9IGt6YWxsb2Mo
c2l6ZW9mKCpkZXZjZCksIGdmcCk7Cj4gPiA+ID4gKwlkZXZjZCA9IGt6YWxsb2Moc2l6ZW9mKCpk
ZXZjZCksIEdGUF9LRVJORUwpOwo+ID4gPiAKPiA+ID4gTm8sIHlvdSBjYW4ndCBqdXN0IGlnbm9y
ZSB0aGUgZmxhZyBlbnRpcmVseSwgdGhhdCBkb2Vzbid0IGhlbHAgYW55b25lCj4gPiA+IG91dCB3
aG8gdHJpZXMgdG8gc2V0IGl0IGFuZCBpcyB0b3RhbGx5IGNvbmZ1c2VkIGFzIHRvIHdoeSB0aGUg
ZmllbGQgaXMKPiA+ID4gaWdub3JlZC4KPiA+ID4gCj4gPiA+IFlvdSBuZWVkIHRvIGV2b2x2ZSB0
aGUgZnVuY3Rpb24gb3ZlciB0aW1lIHRvIG5vdCBuZWVkIHRoZSBwYXJhbWV0ZXIgYXQKPiA+ID4g
YWxsLCB0aGlzIGp1c3QgcGFwZXJzIG92ZXIgdGhlIGVudGlyZSBpc3N1ZSwgd2hpY2ggbWFrZXMg
dGhlIGFwaSBsaWUgdG8KPiA+ID4gdGhlIGNhbGxlciwgbm90IHNvbWV0aGluZyB5b3UgZXZlciB3
YW50IHRvIGRvLgo+ID4gCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgdGltZSBhbmQgcmVwbHkuCj4g
PiAKPiA+IEJ1dCBpZiB0aGVyZSBhcmUgbmV3IGRldmljZXMgY29tZSBpbnRvIGtlcm5lbCwgaXQg
bWF5IHVzZSBkZXZjb3JlZHVtcCBhcGkuCj4gPiBXaGF0IGlzIHRoZSBwcm9wZXIgdGltZSB0byBy
ZW1vdmUgdGhlIGdmcF90IHBhcmFtZXRlciBvZiBkZXZfY29yZWR1bXB2KCkKPiA+IGFuZCBkZXZf
Y29yZWR1bXBtKCk/Cj4gCj4gTm9ybWFsbHkgeW91IHByZXBhcmUgc29tZSBwYXRjaGVzIHRoYXQg
ZG9lcyB0aGUgY29udmVyc2lvbiBhcyBhIHBhdGNoCj4gc2VyaWVzIGFuZCBJIHF1ZXVlIHRoZW0g
dXAgaW4gbXkgdHJlZSwgYW5kIGdldCB0aGVtIG1lcmdlZCBpbiAtcmMxLCB0aGVuCj4gYW55IHN0
cmFnZ2xlcnMgYXJlIHRoZW4gZml4ZWQgdXAgaW4gLXJjMiBhbG9uZyB3aXRoIHRoZSBmaW5hbCBy
ZW5hbWUgb2YKPiB0aGUgb2xkIHdheSBhbmQgdGhlbiBhbGwgaXMgZ29vZC4gIFNlZSBsb3RzIG9m
IGV4YW1wbGVzIG9mIGNoYW5naW5nIGFwaXMKPiBvdmVyIHRpbWUgb24gdGhlIG1haWxpbmcgbGlz
dHMgZm9yIGhvdyB0byBkbyB0aGlzLgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIHJlcGx5
LCBJIHVuZGVyc3RhbmQuCgpJIHdpbGwgcmVzZW5kIHRoZSBwYXRjaCB0aGF0IHJlbW92ZXMgdGhl
IGdmcF90IHBhcmFtZXRlciBvZiBkZXZfY29yZWR1bXB2KCkgYW5kIGRldl9jb3JlZHVtcG0oKQp1
bnRpbCBjb21taXQgb2MzZDg3ODVmNmMwNGEgKCJkcm0vYW1kZ3B1OiBhZGRpbmcgZGV2aWNlIGNv
cmVkdW1wIHN1cHBvcnQiKSBoYXMgYmVlbiBtZXJnZWQgaW50bwptYWlubGluZS4gTWF5YmUgYWZ0
ZXIgdjUuMTktcmM1IG9yIHY1LjE5LXJjNi4KCkJlc3QgcmVnYXJkcywKRHVvbWluZyBaaG91
