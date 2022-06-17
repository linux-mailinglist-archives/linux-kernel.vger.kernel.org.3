Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E20254EEC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 03:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379486AbiFQBY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 21:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379466AbiFQBY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 21:24:57 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56B9615A1C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 18:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=M5u9F
        uumN44frlGtgWzbrsQsNgfgfEAlG7T4FNPLl2s=; b=OndyYxKcSTp6ybDoemyPC
        PD5xNEuzuXVcQFFsW/2WgQ4T6V17Nj7QrCGP3fE15mc/dseFirPg2ce5Lkok5sKd
        4RQzVWDJ22LMvHz8Fy5EjKAsAjvHgaMRPrtDYbkLKYTmWiCJ17Fn1C50WMFAjK2M
        s+ZNycbzsM1SYrAe1iKJHI=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 09:24:06 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 09:24:06 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        oss@buserror.net, paulus@samba.org, christophe.leroy@csgroup.eu,
        nixiaoming@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] arch: powerpc: platforms: 85xx: Add missing
 of_node_put in sgy_cts1000.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <87o7ysb2ot.fsf@mpe.ellerman.id.au>
References: <20220616151901.3989078-1-windhl@126.com>
 <bc6eaf7e-ff88-9b82-eae7-7e6902c33a10@wanadoo.fr>
 <87o7ysb2ot.fsf@mpe.ellerman.id.au>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <731903bf.f56.1816f42a0cb.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADnPPG216tidA84AA--.53775W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgYiF1-HZUGFPAAEso
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNyAwNzozNzowNiwgIk1pY2hhZWwgRWxsZXJtYW4iIDxtcGVAZWxsZXJt
YW4uaWQuYXU+IHdyb3RlOgo+Q2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mcj4gd3JpdGVzOgo+PiBMZSAxNi8wNi8yMDIyIMOgIDE3OjE5LCBMaWFuZyBIZSBh
IMOpY3JpdMKgOgo+Pj4gSW4gZ3Bpb19oYWx0X3Byb2JlKCksIG9mX2ZpbmRfbWF0Y2hpbmdfbm9k
ZSgpIHdpbGwgcmV0dXJuIGEgbm9kZSBwb2ludGVyIHdpdGgKPj4+IHJlZmNvdW50IGluY3JlbWVu
dGVkLiBXZSBzaG91bGQgdXNlIG9mX25vZGVfcHV0KCkgaW4gZWFjaCBmYWlsIHBhdGggb3Igd2hl
biBpdAo+Pj4gaXMgbm90IHVzZWQgYW55bW9yZS4KPj4+IAo+Pj4gU2lnbmVkLW9mZi1ieTogTGlh
bmcgSGUgPHdpbmRobEAxMjYuY29tPgo+Pj4gLS0tCj4+PiAgIGNoYW5nZWxvZzoKPj4+IAo+Pj4g
ICB2MjogdXNlIGdvdG8tbGFiZWwgcGF0Y2ggc3R5bGUgYWR2aXNlZCBieSBDaHJpc3RvcGhlLgo+
Pj4gICB2MTogYWRkIG9mX25vZGVfcHV0KCkgYmVmb3JlIGVhY2ggZXhpdC4KPj4+IAo+Pj4gICBh
cmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEwMDAuYyB8IDI3ICsrKysrKysrKysr
KysrKy0tLS0tLS0tCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQo+Pj4gCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy84
NXh4L3NneV9jdHMxMDAwLmMgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEw
MDAuYwo+Pj4gaW5kZXggOThhZTY0MDc1MTkzLi5lMjgwZjk2M2Q4OGMgMTAwNjQ0Cj4+PiAtLS0g
YS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEwMDAuYwo+Pj4gKysrIGIvYXJj
aC9wb3dlcnBjL3BsYXRmb3Jtcy84NXh4L3NneV9jdHMxMDAwLmMKPj4+IEBAIC03Myw2ICs3Myw3
IEBAIHN0YXRpYyBpbnQgZ3Bpb19oYWx0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpCj4uLi4KPj4+IEBAIC0xMjIsOCArMTI3LDEyIEBAIHN0YXRpYyBpbnQgZ3Bpb19oYWx0X3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4+PiAgIAo+Pj4gICAJcHJpbnRrKEtF
Uk5fSU5GTyAiZ3Bpby1oYWx0OiByZWdpc3RlcmVkIEdQSU8gJWQgKCVkIHRyaWdnZXIsICVkIgo+
Pj4gICAJICAgICAgICIgaXJxKS5cbiIsIGdwaW8sIHRyaWdnZXIsIGlycSk7Cj4+PiArCXJldCA9
IDA7Cj4+PiAgIAo+Pj4gLQlyZXR1cm4gMDsKPj4+ICtlcnJfcHV0Ogo+Pj4gKwlvZl9ub2RlX3B1
dChoYWx0X25vZGUpOwo+Pj4gKwloYWx0X25vZGUgPSBOVUxMOwo+Pgo+PiBIaSwKPj4gc28gbm93
IHdlIHNldCAnaGFsdF9ub2RlJyB0byBOVUxMIGV2ZW4gaW4gdGhlIG5vcm1hbCBjYXNlLgo+PiBU
aGlzIGlzIHJlYWxseSBzcHVyaW91cy4KPj4KPj4gTG9vayBhdCBncGlvX2hhbHRfY2IoKSwgYnV0
IEkgdGhpbmsgdGhhdCB0aGlzIGlzIGp1c3Qgd3JvbmcgYW5kIGJhZGx5IAo+PiBicmVha3MgdGhp
cyBkcml2ZXIuCj4KPkkgYWdyZWUsIHRoYW5rcyBmb3IgcmV2aWV3aW5nLgo+Cj5JIHRoaW5rIHRo
ZSBjbGVhbmVzdCBzb2x1dGlvbiBpcyB0byB1c2UgYSBsb2NhbCB2YXJpYWJsZSBmb3IgdGhlIG5v
ZGUgaW4KPnRoZSBib2R5IG9mIGdwaW9faGFsdF9wcm9iZSgpLCBhbmQgb25seSBhc3NpZ24gdG8g
aGFsdF9ub2RlIG9uY2UgYWxsIHRoZQo+Y2hlY2tzIGhhdmUgcGFzc2VkLgo+Cj5TbyBzb21ldGhp
bmcgbGlrZToKPgo+ICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxkX25vZGU7Cj4KPglj
aGlsZF9ub2RlID0gb2ZfZmluZF9tYXRjaGluZ19ub2RlKG5vZGUsIGNoaWxkX21hdGNoKTsKPiAg
ICAgICAgLi4uCj4KPglwcmludGsoS0VSTl9JTkZPICJncGlvLWhhbHQ6IHJlZ2lzdGVyZWQgR1BJ
TyAlZCAoJWQgdHJpZ2dlciwgJWQiCj4JICAgICAgICIgaXJxKS5cbiIsIGdwaW8sIHRyaWdnZXIs
IGlycSk7Cj4gICAgICAgIHJldCA9IDA7Cj4gICAgICAgIGhhbHRfbm9kZSA9IG9mX25vZGVfZ2V0
KGNoaWxkX25vZGUpOwo+Cj5vdXRfcHV0Ogo+ICAgICAgICBvZl9ub2RlX3B1dChjaGlsZF9ub2Rl
KTsKPiAgICAgICAgCj4JcmV0dXJuIHJldDsKPn0KPgo+Cj5jaGVlcnMKClRoYW5rcywgTWljaGFl
bCBhbmQgQ2hyaXN0b3BoZS4KCkkgd2lsbCBzZW5kIGEgcGF0Y2ggYmFzZWQgb24geW91ciByZXZp
ZXdzLgoKTGlhbmcK
