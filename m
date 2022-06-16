Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B69954D9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358554AbiFPFeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiFPFeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:34:08 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F2DB5932B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=9MDip
        Lrpd5JRZQGbE6vmUYyDP7y4PjKLjY8Ac4hTgbw=; b=jeskCLV9M4Fp5CPCm+CMS
        QYsyHd2RVSmoprQLks38+vQZ02/nv8iW5Rk1/8yfjdxvuSVrQSEsDThS+qoQ60EO
        irWEvG5vWbJvBsWZJeHcQuRijI3n9GMGTc2tpelUYfW+VUc3cseV0yL2btf5bfVb
        3pxYf/YUMvGgQIAqznrBoU=
Received: from windhl$126.com ( [117.136.38.48] ) by ajax-webmail-wmsvr50
 (Coremail) ; Thu, 16 Jun 2022 13:33:49 +0800 (CST)
X-Originating-IP: [117.136.38.48]
Date:   Thu, 16 Jun 2022 13:33:49 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] drivers: soc: sifive: Add missing of_node_put() in
 sifive_l2_cache.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <a5f6f76d-efc1-b421-7623-ad46996f5b94@wanadoo.fr>
References: <20220615122315.3965435-1-windhl@126.com>
 <a5f6f76d-efc1-b421-7623-ad46996f5b94@wanadoo.fr>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7321db1e.3902.1816b00e5e6.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowACn9fG+wKpigIc3AA--.51548W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BUiF1pEDuu4PAACsB
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNiAxMzoxMjoyMSwgIkNocmlzdG9waGUgSkFJTExFVCIgPGNocmlzdG9w
aGUuamFpbGxldEB3YW5hZG9vLmZyPiB3cm90ZToKPkxlIDE1LzA2LzIwMjIgw6AgMTQ6MjMsIExp
YW5nIEhlIGEgw6ljcml0wqA6Cj4+IEluIHNpZml2ZV9sMl9pbml0KCksIG9mX2ZpbmRfbWF0Y2hp
bmdfbm9kZSgpIHdpbGwgcmV0dXJuIGEgbm9kZSBwb2ludGVyCj4+IHdpdGggcmVmY291bnQgaW5j
cmVtZW50ZWQuIFdlIHNob3VsZCB1c2Ugb2Zfbm9kZV9wdXQoKSBpbiBlYWNoIGZhaWwgcGF0aAo+
PiBvciB3aGVuIGl0IGlzIG5vdCB1c2VkIGFueW1vcmUuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBM
aWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvc29jL3NpZml2ZS9z
aWZpdmVfbDJfY2FjaGUuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPj4gCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMgYi9kcml2ZXJz
L3NvYy9zaWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMKPj4gaW5kZXggNTk2NDBhMWQwYjI4Li4yYjlj
OTUyMmVmMjEgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfbDJfY2Fj
aGUuYwo+PiArKysgYi9kcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMKPj4gQEAg
LTE5OCwyOSArMTk4LDQxIEBAIHN0YXRpYyBpbnQgX19pbml0IHNpZml2ZV9sMl9pbml0KHZvaWQp
Cj4+ICAgCXN0cnVjdCByZXNvdXJjZSByZXM7Cj4+ICAgCWludCBpLCByYywgaW50cl9udW07Cj4+
ICAgCj4KPkhpLAo+dGhpcyBlbXB0eSBsaW5lIGlzIG5vdCBuZWVkZWQuCj4KPj4gKwlpbnQgcmV0
Owo+PiArCj4+ICAgCW5wID0gb2ZfZmluZF9tYXRjaGluZ19ub2RlKE5VTEwsIHNpZml2ZV9sMl9p
ZHMpOwo+PiAgIAlpZiAoIW5wKQo+PiAgIAkJcmV0dXJuIC1FTk9ERVY7Cj4+ICAgCj4+ICAgCWlm
IChvZl9hZGRyZXNzX3RvX3Jlc291cmNlKG5wLCAwLCAmcmVzKSkKPj4gLQkJcmV0dXJuIC1FTk9E
RVY7Cj4+ICsJewo+Cj50aGlzIHNob3VsZCBiZSBhdCB0aGUgZW5kIG9mIHRoZSBwcmV2aW91cyBs
aW5lLgo+Cj4+ICsJCXJldCA9IC1FTk9ERVY7Cj4+ICsJCWdvdG8gb3V0X3B1dDsKPj4gKwl9Cj4+
ICAgCj4+ICAgCWwyX2Jhc2UgPSBpb3JlbWFwKHJlcy5zdGFydCwgcmVzb3VyY2Vfc2l6ZSgmcmVz
KSk7Cj4+ICAgCWlmICghbDJfYmFzZSkKPj4gLQkJcmV0dXJuIC1FTk9NRU07Cj4+ICsJewo+Pgo+
Cj5TYW1lIGhlcmUuCj4KPiAgKwkJcmV0ID0gLUVOT01FTTsKPj4gKwkJZ290byBvdXRfcHV0Owo+
PiArCX0KPj4gICAKPj4gICAJaW50cl9udW0gPSBvZl9wcm9wZXJ0eV9jb3VudF91MzJfZWxlbXMo
bnAsICJpbnRlcnJ1cHRzIik7Cj4+IC0JaWYgKCFpbnRyX251bSkgewo+PiArCWlmICghaW50cl9u
dW0pIHsJCQo+PiAgIAkJcHJfZXJyKCJMMkNBQ0hFOiBubyBpbnRlcnJ1cHRzIHByb3BlcnR5XG4i
KTsKPj4gLQkJcmV0dXJuIC1FTk9ERVY7Cj4+ICsJCXJldCA9IC1FTk9ERVYKPgo+TWlzc2luZyAi
OyIgYXMgcmVwb3J0ZWQgYnkgdGhlIGJvdC4KPgo+PiArCQlnb3RvIG91dF9wdXQ7Cj4+ICAgCX0K
Pj4gICAKPj4gICAJZm9yIChpID0gMDsgaSA8IGludHJfbnVtOyBpKyspIHsKPj4gICAJCWdfaXJx
W2ldID0gaXJxX29mX3BhcnNlX2FuZF9tYXAobnAsIGkpOwo+PiAgIAkJcmMgPSByZXF1ZXN0X2ly
cShnX2lycVtpXSwgbDJfaW50X2hhbmRsZXIsIDAsICJsMl9lY2MiLCBOVUxMKTsKPj4gKwkJCj4+
ICAgCQlpZiAocmMpIHsKPj4gKwkJCQo+Cj5XaHkgYSBuZXcgZW1wdHkgbGluZSBoZXJlPwo+Cj4+
ICAgCQkJcHJfZXJyKCJMMkNBQ0hFOiBDb3VsZCBub3QgcmVxdWVzdCBJUlEgJWRcbiIsIGdfaXJx
W2ldKTsKPj4gLQkJCXJldHVybiByYzsKPj4gKwkJCXJldCA9IHJjOwo+PiArCQkJZ290byBvdXRf
cHV0Owo+PiAgIAkJfQo+PiAgIAl9Cj4+ICAgCj4+IEBAIC0yMzIsNiArMjQ0LDExIEBAIHN0YXRp
YyBpbnQgX19pbml0IHNpZml2ZV9sMl9pbml0KHZvaWQpCj4+ICAgI2lmZGVmIENPTkZJR19ERUJV
R19GUwo+PiAgIAlzZXR1cF9zaWZpdmVfZGVidWcoKTsKPj4gICAjZW5kaWYKPj4gLQlyZXR1cm4g
MDsKPj4gKwlyZXQgPSAwOwo+PiArCQo+PiArCQo+Cj5ObyBuZWVkIGZvciAyIGVtcHR5IGxpbmVz
IGhlcmUuCj4KPgo+VGhlcmUgYXJlIGFsc28gc29tZSB0cmFpbGluZyB3aGl0ZSBzcGFjZXMgb24g
c29tZSBsaW5lcy4KPgo+Ii4vc2NyaXB0cy9jaGVja3BhdGNoIDxuYW1lX29mX3RoZV9wYXRjaD4i
IGNhdGNoZXMgc29tZSBvZiB0aGVzZSB0aW55IAo+aXNzdWVzLiBVc2luZyAtLXN0cmljdCBjYXRj
aGVzIGV2ZW4gbW9yZSBvZiB0aGVzZSBpc3N1ZXMuCj4KPllvdSBzaG91bGQgYWxzbyBhbHdheXMg
YXQgbGVhc3QgY29tcGlsZSB0ZXN0IHlvdXIgcGF0Y2hlcywgZXZlbiBpZiB0aGV5IAo+bG9vayBv
YnZpb3VzLAo+Cj5DSgo+Cj4KPj4gK291dF9wdXQ6Cj4+ICsJb2Zfbm9kZV9wdXQobnApOwo+PiAr
CXJldHVybiByZXQ7Cj4+ICAgfQo+PiAgIGRldmljZV9pbml0Y2FsbChzaWZpdmVfbDJfaW5pdCk7
CgoKU29ycnkgZm9yIG15IHRyb3VibGVzLiBJIHdpbGwgY2hlY2sgbXkgcGF0Y2ggbW9yZSBjYXJl
ZnVsbHkuCg==
