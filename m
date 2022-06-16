Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDCC54DDEC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359555AbiFPJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359112AbiFPJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:10:56 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A0A0527EC;
        Thu, 16 Jun 2022 02:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Gs586
        khXITVsVMfZEq1LZJ5IRpiCyvubOmH4rmPCc6c=; b=DlTRC05uU1fBrOH95/ord
        oaTDb71ZdvRRpOM0LgLelxFQrg41iTNH/P/vL4ISmErkAG6EnvpLvUISHCfC43Ld
        cwYsp4KjjiEIm41gM2KfY4Y5Bx0LgND03wx/k6kZLX2IZ0WneHLlPf29dLgcWQrq
        3LVMNpWLnGyu3Xsf/d3utg=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Thu, 16 Jun 2022 17:09:48 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 17:09:48 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     Conor.Dooley@microchip.com
Cc:     sboyd@kernel.org, jonathanh@nvidia.com, mturquette@baylibre.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] clk: tegra: (clk-tegra30) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <f7f1e910-24e5-4bdf-f4ca-12f1a5293ef1@microchip.com>
References: <20220616033622.3975621-1-windhl@126.com>
 <20220616060037.5AEB8C34114@smtp.kernel.org>
 <1a776c99.5e5c.1816b98bfee.Coremail.windhl@126.com>
 <f7f1e910-24e5-4bdf-f4ca-12f1a5293ef1@microchip.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <6a979593.670b.1816bc69fd0.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowABHnfFd86piqMo3AA--.53459W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QsiF1pEANbjwwABs6
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNiAxNjo0MjoyNiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3Jv
dGU6Cj5PbiAxNi8wNi8yMDIyIDA5OjE5LCBMaWFuZyBIZSB3cm90ZToKPj4gQXQgMjAyMi0wNi0x
NiAxNDowMDozNSwgIlN0ZXBoZW4gQm95ZCIgPHNib3lkQGtlcm5lbC5vcmc+IHdyb3RlOgo+Pj4g
VGhlIHN1YmplY3Qgc2hvdWxkIG1hdGNoIGhpc3RvcmljYWwgc3ViamVjdHMKPj4+Cj4+PiAkIGdp
dCBsb2cgLS1vbmVsaW5lIC0zIC0tIGRyaXZlcnMvY2xrL3RlZ3JhL2Nsay10ZWdyYTMwLmMKPj4+
Cj4+PiBzaG93cyBtb3N0bHkgImNsazogdGVncmE6ICIuIENhbiB5b3UgYWxzbyBjb21iaW5lIHRo
aXMgd2l0aCB0aGUgb3RoZXIKPj4+IHRlZ3JhIHBhdGNoPyBEb24ndCB0aGluayB3ZSBuZWVkIHR3
byBwYXRjaGVzIGZvciBlc3NlbnRpYWxseSB0aGUgc2FtZQo+Pj4gdGhpbmcuCj4+Pgo+Pj4gUXVv
dGluZyBMaWFuZyBIZSAoMjAyMi0wNi0xNSAyMDozNjoyMikKPj4+PiBJbiB0ZWdyYTMwX2Nsb2Nr
X2luaXQsIG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIHdpbGwgcmV0dXJuIGEgbm9kZQo+Pj4+IHBv
aW50ZXIgd2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1
dCgpIHdoZW4KPj4+PiB0aGUgbm9kZSBwb2ludGVyIGlzIG5vdCB1c2VkIGFueW1vcmUuCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+Pj4gLS0tCj4+
Pj4gICBjaGFuZ2Vsb2c6Cj4+Pj4KPj4+PiAgIHYyOiB1c2UgcmVhbCBuYW1lIGZvciBTb2IKPj4+
Cj4+PiBUaGFua3MhCj4+Pgo+Pj4+ICAgdjE6IGZpeCBtaXNzaW5nIGJ1Zwo+PiAKPj4gU29ycnkg
Zm9yIG15IGZhdWx0LiBJIGhhdmUgYmVlbiBhZHZpc2VkIHRvIHVzZSByZWFsIG5hbWUgYW5kIEkg
cmVzZW5kIGEgUEFUQ0ggdjIgd2l0aCBteSByZWFsIG5hbWUsIGJ1dCByZWFsbHkgd2l0aCB0aGUg
c2FtZSBwYXRjaCBjb2RlLgo+PiAKPj4gU28gaG93IGNhbiBJIHdpdGhkcmF3IHRoZSBmaXJzdCBw
YXRjaCBvciByZXNlbmQgb3RoZXIgdGhpbmc/IEkgYW0gY29uZnVzZWQuCj4+IAo+PiBDYW4geW91
IGhlbHAgbWUsIENvbm9yPwo+Cj5ZZWFoLCBzdXJlLiBJIHRoaW5rIHlvdSdyZSBqdXN0IGdldHRp
bmcgYSBiaXQgY29uZnVzZWQgYnkgY29uZmxpY3RpbmcKPnJlc3BvbnNlcyBmcm9tIGRpZmZlcmVu
dCBwZW9wbGUuIFNvbWUgb2YgdGhlIHRoaW5ncyBJIHNhaWQgb24gd2hhdGV2ZXIKPnRoZSBvcmln
aW5hbCBwYXRjaCBJIHJlcGxpZWQgdG8gYXBwbHkgZXZlcnl3aGVyZSAtIGxpa2UgdXNpbmcgeW91
ciByZWFsCj5uYW1lIG9yIGFkZGluZyBjaGFuZ2Vsb2dzLgo+SG93ZXZlciwgZGlmZmVyZW50IHN1
YnN5c3RlbSBtYWludGFpbmVycyBoYXZlIGEgZGlmZmVyZW50IG9waW5pb25zIGFib3V0Cj5ob3cg
cGF0Y2hlcyBmb3IgdGhlaXIgc3Vic3lzdGVtIHNob3VsZCBsb29rLiBJIHdvdWxkIGltYWdpbmUg
dGhhdCBpdCB3YXMKPkd1ZW50ZXIgUm9lY2sgdGhhdCBhc2tlZCB5b3UgdG8gdXNlIHRoZSAic3Vi
c3lzdGVtOiAoZHJpdmVyKSBhY3Rpb24iCj5zdWJqZWN0LCB3aGljaCBpcyBob3cgaHdtb24gcGF0
Y2hlcyBhcmUgZG9uZSAtIGJ1dCBub3Qgb3RoZXIgc3Vic3lzdGVtcy4KPgo+V2hhdCBTdGVwaGVu
IGlzIGFza2luZywgaXMgdGhhdCB5b3UgcnVuCj4kIGdpdCBsb2cgLS1vbmVsaW5lIC0zIC0tIGRy
aXZlcnMvY2xrL3RlZ3JhL2Nsay10ZWdyYTMwLmMKPnRvIGZpZ3VyZSBvdXQgd2hhdCB0aGUgc3Vi
amVjdCBzaG91bGQgYmUsIGJhc2VkIG9uIHByZXZpb3VzIHN1YmplY3RzLgo+VGhhdCdzIGdvb2Qg
YWR2aWNlIHRvIGZvbGxvdyBmb3IgYW55IHBhdGNoIHlvdSBzZW5kIDopCj4KCgo+VGhpcyBvdGhl
ciBjb21tZW50IHdhczoKPj4gRG9uJ3QgdGhpbmsgd2UgbmVlZCB0d28gcGF0Y2hlcyBmb3IgZXNz
ZW50aWFsbHkgdGhlIHNhbWUgdGhpbmcuCj4KPkkgYXNzdW1lIHlvdSBzZW50IHR3byBkaWZmZXJl
bnQgcGF0Y2hlcyBmb3IgdGhlIHNhbWUgZHJpdmVyLCBvciB0aGUKPnNhbWUgZGlyZWN0b3J5IG9m
IGRyaXZlcnM/Cj5IZSdzIGp1c3QgYXNraW5nIHRoYXQgeW91IHNxdWFzaCB0aGUgdHdvIGNvbW1p
dHMgdG9nZXRoZXIgaW50byBvbmUKPmNvbW1pdC4KPgoKT2ssIHRoYW5rcywgQ29ub3IsIEkgZ290
IGl0IGFuZCBJIHdpbGwgcHJlcGFyZSBteSBuZXh0IG1lcmdlZCBwYXRjaCBmb3IKdGhlc2UgZmls
ZXMgd2hpY2ggYXJlIGluZGVlZCBpbiB0aGUgc2FtZSBkcml2ZXIgZGlyZWN0b3J5LgoKPiBGcm9t
IHlvdXIgb3RoZXIgZW1haWw6Cj4+IFNvcnJ5LCB3aGF0IGRvIHlvdSBtZWFuIHNhbWUgc3ViamVj
dCBsaW5lIGNvbW1lbnQ/Cj4+IEkgYWRkIGEgW1BBVENIIHYyXSB0YWcgd2hlbiBJIHVzZSAnZ2l0
IGZvcm1hdC1wYXRjaCAtdiAyJy4KPgo+SSBhc3N1bWUgU3RlcGhlbiBtZWFudDogdGhlIHNhbWUg
Y29tbWVudHMgYWJvdXQgIihjbGstdGVncmEzMCkiCj5mcm9tIHRoaXMgcGF0Y2ggYXBwbHkgdG8g
dGhhdCBwYXRjaCB0b28uIFRoZXJlJ3Mgbm90aGluZyB3cm9uZwo+d2l0aCBoYXZpbmcgIltQQVRD
SCB2Ml0iLgo+Cj4+IFlvdSBtZWFuIHRoZSB0d28gY29tbWl0IGhhcyBzYW1lIHN1YmplY3QgY29u
dGVudD8KPj4gU29ycnksIEkgYW0gYSBiZWdpbm5lciB0byBzdWJtaXQgcGF0Y2ggY29tbWl0Lgo+
Cj5PaGggZG9uJ3Qgd29ycnksIHdlIGhhdmUgYWxsIGJlZW4gdGhlcmUgKGFuZCBpbiBteSBjYXNl
IG5vdCB0b28KPmxvbmcgYWdvIGVpdGhlci4uLikKPgo+SG9wZSB0aGF0IGhlbHBzIQo+VGhhbmtz
LAo+Q29ub3IuCj4KPgoKCgpUaGFua3MgYWdhaW4sIENvbm9yLgoKTGlhbmcK
