Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEBB5548EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350585AbiFVJVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiFVJVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:21:37 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CD6D340F6;
        Wed, 22 Jun 2022 02:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=uNDNB
        uOiBg9xW6xPfaSEVT4TuUR47+zLORH4BmKJBTY=; b=Zot7GZTW5+zy6sMHrMlIT
        73ZfpaBkRiJvIP/OKh5De1RI57p/TZFXiZTt/qGLaBmsUZgIjoY/TO8c7cQBbYWn
        0iKWif6PMqzgPH98xlJLrqDTAVON70oXqpCe+o6f+YsJfDsKrKtPvyDdj81mvw9s
        3xXlU5QkGgXErCn9x3/C9g=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Wed, 22 Jun 2022 17:20:33 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 17:20:33 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re:Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <b3a0b35e-33fc-f7f3-a111-1a88498b4019@linaro.org>
References: <20220622042824.4094625-1-windhl@126.com>
 <2f3e843e-b72b-ee71-7465-b2b6c8d51b0d@linaro.org>
 <11875304.61a4.1818a9a66bb.Coremail.windhl@126.com>
 <b3a0b35e-33fc-f7f3-a111-1a88498b4019@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <646ff210.68cc.1818ab69fb3.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAAXJibi3rJidtw6AA--.11331W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QYoF1pEAQTNRQACsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yMiAxNzowODozMiwgIktyenlzenRvZiBLb3psb3dza2kiIDxrcnp5c3p0
b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOgo+T24gMjIvMDYvMjAyMiAxMDo0OSwgTGlh
bmcgSGUgd3JvdGU6Cj4+IAo+PiAKPj4gQXQgMjAyMi0wNi0yMiAxNjo0MToyOCwgIktyenlzenRv
ZiBLb3psb3dza2kiIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOgo+Pj4g
T24gMjIvMDYvMjAyMiAwNjoyOCwgTGlhbmcgSGUgd3JvdGU6Cj4+Pj4gb2ZfZmluZF9ub2RlX2J5
X25hbWUoKSB3aWxsIGRlY3JlYXNlIHRoZSByZWZjb3VudCBvZiBpdHMgZmlyc3QgYXJnIGFuZAo+
Pj4+IHdlIG5lZWQgdG8gYWRkIGEgb2Zfbm9kZV9wdXQoKSB0byBrZWVwIHJlZmNvdW50IGJhbGFu
Y2UuCj4+Pj4KPj4+PiBCZXNpZGVzLCBkdXJpbmcgdGhlICdmb3InIGxvb3AgZXhlY3V0aW9uLCB0
aGUgcmVmY291bnQgb2YgJ25wJyB3aWxsIGJlCj4+Pj4gYXV0b21hdGljYWxseSBpbmNyZWFzZWQg
YW5kIGRlY3JlYXNlZC4gVGhlcmUgaXMgbm8gbmVlZCB0byBjYWxsCj4+Pj4gb2Zfbm9kZV9wdXQo
KSBhZ2Fpbi4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2LmNv
bT4KPj4+PiAtLS0KPj4+PiAgZHJpdmVycy9tZW1vcnkvdGVncmEvdGVncmEyMC1lbWMuYyB8IDMg
KystCj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4+Pgo+Pj4KPj4+IFRoZSBwYXRjaCB3YXMgbm90IGV2ZW4gY29tcGlsZWQuLi4gSSBjb25zaWRl
ciBpdCBoYXJtZnVsIGFwcHJvYWNoLiBOQUsuCj4+PiBTZWU6IGh0dHBzOi8vbHduLm5ldC9BcnRp
Y2xlcy84NTQ2NDUvCj4+Pgo+Pj4gQmVzdCByZWdhcmRzLAo+Pj4gS3J6eXN6dG9mCj4+IAo+PiBT
b3JyeSwgS3J6eXN6dG9mLgo+PiAKPj4gQXMgdGhlIHBhdGNoIGlzIHNvIHNpbXBsZSB0d28gbGlu
ZXMgLCBJIHRob3VnaHQgSSBjYW4gaGFuZGxlIGl0IHdpdGhvdXQgY29tcGlsaW5nIGl0Lgo+PiAK
Pj4gVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91ciBub3RpY2UgYWJvdXQgdGhlIGFydGljbGUgYW5k
IEkgaG9wZSBJIGhhdmUgbm90IGRvbmUgYW55b3RoZXIgaGFybWZ1bCB0aGluZ3MuCj4+IAo+PiBB
bmQgSSB3aWxsIHRha2UgY2FyZSBvZiBteSBwYXRjaCBjb2RlIGluIGZ1dHVyZSBubyBtYXR0ZXIg
aG93IHNpbXBsZSBpdCBpcy4KPgo+Cj5OZXZlciBzZW5kIHBhdGNoZXMgd2hpY2ggd2VyZSBub3Qg
YnVpbHQuIEl0IHNlZW1zIHlvdSBkaWRuJ3QgYnVpbGQgdGhlbQo+aW4gdGhlIHBhc3QgZWl0aGVy
LCBldmVuIHRob3VnaCBzZXR0aW5nIHVwIGNyb3NzIGNvbXBpbGUgaXMgdHJpdmlhbCAoZmV3Cj5j
b21tYW5kcykuIFFFTVUgaXMgYWxzbyBhbiBlYXN5IG9wdGlvbi4KPgo+RXZlbiB0aG91Z2ggeW91
ciBjb250cmlidXRpb24gbWlnaHQgYmUgdmFsdWFibGUsIGxhY2sgb2YgYnVpbGRpbmcgaXMgYQo+
c2lnbiBmb3IgbWUgdGhhdCBhcHByb2FjaCBpcyBub3Qgc2VyaW91cywgc28gSSBhbSBub3QgZ29p
bmcgdG8gdGFrZQo+cmlza3kgY29kZS4KPgo+QmVzdCByZWdhcmRzLAo+S3J6eXN6dG9mCgpUaGFu
a3MsIEtyenlzenRvZi4KClRoaXMgYSB2YWx1YWJsZSBsZXNzb24gZm9yIG1lLiAKCkxhc3QgZmV3
IGRheXMsIEkganVzdCB3YW50IHRvIHJlcG9ydCB0aGUgYnVncyBhcyBxdWlja2x5IGFzIEkgY2Fu
LgoKQW5kIEkgb25seSBmb2N1cyB0aGUgYnVncyBJIGZvdW5kIGJ1dCBub3QgdGhlIHBhdGNoIGNv
bXBpbGluZyBwcm9ibGVtLgoKWWVzLCBJIGFkbWl0IHRoaXMgYXBwcm9hY2ggKHdheSkgaXMgbm90
IHNlcmlvdXMgYW5kIHRoaXMgaXMgbXkgZmF1bHQsIHNvcnJ5IGFnYWluIGFuZCBzb3JyeSB0byB3
YXN0ZSB5b3VyIHRpbWUuCgpGcm9tIG5vdyBvbiwgSSB3aWxsIG5vdCBzZW5kIGFueSBuZXcgcGF0
Y2ggY29tbWl0IGJlZm9yZSBJIGNvbXBpbGUgdGhlIHBhdGNoIGNvZGUuCgpTb3JyeSBmb3IgbXkg
YmVoYXZpb3IuCg==
