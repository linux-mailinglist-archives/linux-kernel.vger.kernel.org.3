Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103004903F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiAQIgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:36:05 -0500
Received: from m1397.mail.163.com ([220.181.13.97]:45498 "EHLO
        m1397.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiAQIgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:36:04 -0500
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jan 2022 03:35:56 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=U6AJg
        RT9yEKALKqy71zPTJhLAEDKSAmRLqeRA/LEZqI=; b=og+G4EDMAh4i2EurjCB65
        teC8pAYUU5c4O0ADKf3qc8RxMr7UEwDepXJOswqKL5CyZcY+U93HKNLyFaB6+kLP
        us5VJOosw9eK37s4Ry1Nd8ZwGezVY7NMjnOXCAt/l5W6V5vBg75r7+48C6BSMI5P
        WDLiTOA9hIKs3f+JLqwlKY=
Received: from slark_xiao$163.com ( [112.97.53.17] ) by ajax-webmail-wmsvr97
 (Coremail) ; Mon, 17 Jan 2022 16:20:12 +0800 (CST)
X-Originating-IP: [112.97.53.17]
Date:   Mon, 17 Jan 2022 16:20:12 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Manivannan Sadhasivam" <mani@kernel.org>
Cc:     hemantk@codeaurora.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH net] bus: mhi: Add mru_default for Foxconn SDX55
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <20220117075323.GA4209@thinkpad>
References: <20220115103912.3775-1-slark_xiao@163.com>
 <20220117075323.GA4209@thinkpad>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <76f0a70a.2e7f.17e671f4eb0.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: YcGowABHbCu8JuVhoh8NAA--.52392W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiJRaLZGAJmDy6WgABsw
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTAxLTE3IDE1OjUzOjIzLCAiTWFuaXZhbm5hbiBTYWRoYXNpdmFtIiA8bWFuaUBr
ZXJuZWwub3JnPiB3cm90ZToKPk9uIFNhdCwgSmFuIDE1LCAyMDIyIGF0IDA2OjM5OjEyUE0gKzA4
MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+IEZvciBkZWZhdWx0IG1lY2hhbmlzbSwgcHJvZHVjdCB3
b3VsZCB1c2UgZGVmYXVsdCBNUlUgMzUwMCBpZgo+PiB0aGV5IGRpZG4ndCBkZWZpbmUgaXQuIEJ1
dCBmb3IgRm94Y29ubiBTRFg1NSwgdGhlcmUgaXMgYSBrbm93bgo+PiBpc3N1ZSB3aGljaCBNUlUg
MzUwMCB3b3VsZCBsZWFkIHRvIGRhdGEgY29ubmVjdGlvbiBsb3N0Lgo+PiBTbyB3ZSBhbGlnbiBp
dCB3aXRoIFF1YWxjb21tIGRlZmF1bHQgTVJVIHNldHRpbmdzLgo+PiAKPj4gU2lnbmVkLW9mZi1i
eTogU2xhcmsgWGlhbyA8c2xhcmtfeGlhb0AxNjMuY29tPgo+Cj5SZXZpZXdlZC1ieTogTWFuaXZh
bm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+Cj4KPllvdSBuZWVkIHRvIGFkZCBGaXhl
cyB0YWcgc28gdGhhdCBJIGNhbiBxdWV1ZSB0aGlzIHBhdGNoIGZvciB2NS4xNyBSQ3MuCj4KPlRo
YW5rcywKPk1hbmkKPgpIaSBNYW5pLAogIE5ldyBwYXRjaCBpcyBjb21taXR0ZWQuIFBsZWFzZSBo
ZWxwIGRvIGEgY2hlY2sgYWdhaW4uCgpUaGFua3MhCj4+IC0tLQo+PiAgZHJpdmVycy9idXMvbWhp
L3BjaV9nZW5lcmljLmMgfCAxICsKPj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+
PiAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZXJpYy5jIGIvZHJpdmVy
cy9idXMvbWhpL3BjaV9nZW5lcmljLmMKPj4gaW5kZXggM2EyNThhNjc3ZGY4Li43NGU4ZmMzNDJj
ZmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZXJpYy5jCj4+ICsrKyBi
L2RyaXZlcnMvYnVzL21oaS9wY2lfZ2VuZXJpYy5jCj4+IEBAIC0zNjYsNiArMzY2LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtaGlfcGNpX2Rldl9pbmZvIG1oaV9mb3hjb25uX3NkeDU1X2luZm8g
PSB7Cj4+ICAJLmNvbmZpZyA9ICZtb2RlbV9mb3hjb25uX3NkeDU1X2NvbmZpZywKPj4gIAkuYmFy
X251bSA9IE1ISV9QQ0lfREVGQVVMVF9CQVJfTlVNLAo+PiAgCS5kbWFfZGF0YV93aWR0aCA9IDMy
LAo+PiArCS5tcnVfZGVmYXVsdCA9IDMyNzY4LAo+PiAgCS5zaWRlYmFuZF93YWtlID0gZmFsc2Us
Cj4+ICB9Owo+PiAgCj4+IC0tIAo+PiAyLjI1LjEKPj4gCg==
