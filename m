Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A49154F071
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbiFQFOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFQFOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:14:44 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA8563BE6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=jb1Ts
        I3YAzg3cVvn0HNhE1i/twsgHL1eZDcM2Hc9Ia4=; b=AMr1R2uKl8n+0wnUiUMup
        VwNdXjghe+Vcp8N7MuU1yTKRMdAr+GJeQbUPtW9U+iOqRmOaHU8RSrQjSpA3gMLg
        xAvEBzJa2VSZAnLm+XtA29ulgJAnbXmZimZtwUhMLyas/F5hBZWEXBHys5zU88ii
        p1/KjUimuYx4BtBnZcKs3w=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Fri, 17 Jun 2022 13:13:36 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Fri, 17 Jun 2022 13:13:36 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Michael Ellerman" <mpe@ellerman.id.au>
Cc:     "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
        oss@buserror.net, paulus@samba.org, christophe.leroy@csgroup.eu,
        nixiaoming@huawei.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re:Re: [PATCH v2] arch: powerpc: platforms: 85xx: Add missing
 of_node_put in sgy_cts1000.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <87ilozc3qp.fsf@mpe.ellerman.id.au>
References: <20220616151901.3989078-1-windhl@126.com>
 <bc6eaf7e-ff88-9b82-eae7-7e6902c33a10@wanadoo.fr>
 <87o7ysb2ot.fsf@mpe.ellerman.id.au>
 <6af17369.1d3d.1816f7a9707.Coremail.windhl@126.com>
 <87ilozc3qp.fsf@mpe.ellerman.id.au>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <745d8407.37fa.1817014bd62.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAA3jPCBDaxib0w4AA--.59608W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgAjF1-HZUNwJAABsF
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgogMjAyMi0wNi0xNyAxMjoyOTowMu+8jCJNaWNoYWVsIEVsbGVybWFuIiA8bXBlQGVsbGVybWFu
LmlkLmF1PiDlhpnpgZPvvJoKPiJMaWFuZyBIZSIgPHdpbmRobEAxMjYuY29tPiB3cml0ZXM6Cj4+
IEF0IDIwMjItMDYtMTcgMDc6Mzc6MDYsICJNaWNoYWVsIEVsbGVybWFuIiA8bXBlQGVsbGVybWFu
LmlkLmF1PiB3cm90ZToKPj4+Q2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRA
d2FuYWRvby5mcj4gd3JpdGVzOgo+Pj4+IExlIDE2LzA2LzIwMjIgw6AgMTc6MTksIExpYW5nIEhl
IGEgw6ljcml0wqA6Cj4+Pj4+IEluIGdwaW9faGFsdF9wcm9iZSgpLCBvZl9maW5kX21hdGNoaW5n
X25vZGUoKSB3aWxsIHJldHVybiBhIG5vZGUgcG9pbnRlciB3aXRoCj4+Pj4+IHJlZmNvdW50IGlu
Y3JlbWVudGVkLiBXZSBzaG91bGQgdXNlIG9mX25vZGVfcHV0KCkgaW4gZWFjaCBmYWlsIHBhdGgg
b3Igd2hlbiBpdAo+Pj4+PiBpcyBub3QgdXNlZCBhbnltb3JlLgo+Pj4+PiAKPj4+Pj4gU2lnbmVk
LW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gICBjaGFu
Z2Vsb2c6Cj4+Pj4+IAo+Pj4+PiAgIHYyOiB1c2UgZ290by1sYWJlbCBwYXRjaCBzdHlsZSBhZHZp
c2VkIGJ5IENocmlzdG9waGUuCj4+Pj4+ICAgdjE6IGFkZCBvZl9ub2RlX3B1dCgpIGJlZm9yZSBl
YWNoIGV4aXQuCj4+Pj4+IAo+Pj4+PiAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9zZ3lf
Y3RzMTAwMC5jIHwgMjcgKysrKysrKysrKysrKysrLS0tLS0tLS0KPj4+Pj4gICAxIGZpbGUgY2hh
bmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPj4+Pj4gCj4+Pj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEwMDAuYyBiL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9zZ3lfY3RzMTAwMC5jCj4+Pj4+IGluZGV4IDk4YWU2NDA3
NTE5My4uZTI4MGY5NjNkODhjIDEwMDY0NAo+Pj4+PiAtLS0gYS9hcmNoL3Bvd2VycGMvcGxhdGZv
cm1zLzg1eHgvc2d5X2N0czEwMDAuYwo+Pj4+PiArKysgYi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1z
Lzg1eHgvc2d5X2N0czEwMDAuYwo+Pj4+PiBAQCAtNzMsNiArNzMsNyBAQCBzdGF0aWMgaW50IGdw
aW9faGFsdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQo+Pj4uLi4KPj4+Pj4g
QEAgLTEyMiw4ICsxMjcsMTIgQEAgc3RhdGljIGludCBncGlvX2hhbHRfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKPj4+Pj4gICAKPj4+Pj4gICAJcHJpbnRrKEtFUk5fSU5GTyAi
Z3Bpby1oYWx0OiByZWdpc3RlcmVkIEdQSU8gJWQgKCVkIHRyaWdnZXIsICVkIgo+Pj4+PiAgIAkg
ICAgICAgIiBpcnEpLlxuIiwgZ3BpbywgdHJpZ2dlciwgaXJxKTsKPj4+Pj4gKwlyZXQgPSAwOwo+
Pj4+PiAgIAo+Pj4+PiAtCXJldHVybiAwOwo+Pj4+PiArZXJyX3B1dDoKPj4+Pj4gKwlvZl9ub2Rl
X3B1dChoYWx0X25vZGUpOwo+Pj4+PiArCWhhbHRfbm9kZSA9IE5VTEw7Cj4+Pj4KPj4+PiBIaSwK
Pj4+PiBzbyBub3cgd2Ugc2V0ICdoYWx0X25vZGUnIHRvIE5VTEwgZXZlbiBpbiB0aGUgbm9ybWFs
IGNhc2UuCj4+Pj4gVGhpcyBpcyByZWFsbHkgc3B1cmlvdXMuCj4+Pj4KPj4+PiBMb29rIGF0IGdw
aW9faGFsdF9jYigpLCBidXQgSSB0aGluayB0aGF0IHRoaXMgaXMganVzdCB3cm9uZyBhbmQgYmFk
bHkgCj4+Pj4gYnJlYWtzIHRoaXMgZHJpdmVyLgo+Pj4KPj4+SSBhZ3JlZSwgdGhhbmtzIGZvciBy
ZXZpZXdpbmcuCj4+Pgo+Pj5JIHRoaW5rIHRoZSBjbGVhbmVzdCBzb2x1dGlvbiBpcyB0byB1c2Ug
YSBsb2NhbCB2YXJpYWJsZSBmb3IgdGhlIG5vZGUgaW4KPj4+dGhlIGJvZHkgb2YgZ3Bpb19oYWx0
X3Byb2JlKCksIGFuZCBvbmx5IGFzc2lnbiB0byBoYWx0X25vZGUgb25jZSBhbGwgdGhlCj4+PmNo
ZWNrcyBoYXZlIHBhc3NlZC4KPj4+Cj4+PlNvIHNvbWV0aGluZyBsaWtlOgo+Pj4KPj4+ICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxkX25vZGU7Cj4+Pgo+Pj4JY2hpbGRfbm9kZSA9IG9m
X2ZpbmRfbWF0Y2hpbmdfbm9kZShub2RlLCBjaGlsZF9tYXRjaCk7Cj4+PiAgICAgICAgLi4uCj4+
Pgo+Pj4JcHJpbnRrKEtFUk5fSU5GTyAiZ3Bpby1oYWx0OiByZWdpc3RlcmVkIEdQSU8gJWQgKCVk
IHRyaWdnZXIsICVkIgo+Pj4JICAgICAgICIgaXJxKS5cbiIsIGdwaW8sIHRyaWdnZXIsIGlycSk7
Cj4+PiAgICAgICAgcmV0ID0gMDsKPj4+ICAgICAgICBoYWx0X25vZGUgPSBvZl9ub2RlX2dldChj
aGlsZF9ub2RlKTsKPj4+Cj4+Pm91dF9wdXQ6Cj4+PiAgICAgICAgb2Zfbm9kZV9wdXQoY2hpbGRf
bm9kZSk7Cj4+PiAgICAgICAgCj4+PglyZXR1cm4gcmV0Owo+Pj59Cj4+Pgo+Pj4KPj4+Y2hlZXJz
Cj4+Cj4+IEhpLCBNaWNoYWVsIGFuZCBDaHJpc3RvcGhlLAo+Pgo+PiBJIGFtIHdyaXRpbmcgdGhl
IG5ldyBwYXRjaCBiYXNlZCBvbiBNaWNoYWVsJ3MgYWR2aWNlLiBIb3dldmVyLCBJIHdvbmRlciBp
ZiB0aGVyZSBpcwo+PiBhbnkgcGxhY2UgdG8gY2FsbCBvZl9ub2RlX3B1dChoYWx0X25vZGUpPyAg
QXMgSSBkbyBub3QgZXhhY3RseSBrbm93IGlmIGdwaW9faGFsdF9yZW1vdmUoKQo+PiBvciBhbnlv
dGhlciBwbGFjZSBjYW4gY29ycmVjdGx5IHJlbGVhc2UgdGhpcyBnbG9iYWwgcmVmZXJlbmNl77yf
Cj4+IElmIG5vdCwgaXQgaXMgY29ycmVjdCB0aGF0IEkgYWRkIGEgb2Zfbm9kZV9wdXQoaGFsdF9u
b2RlKSBpbiBncGlvX2hhbHRfcmVtb3ZlKCksIHJpZ2h0Pwo+Cj5ZZXMgSSB0aGluayBzbywganVz
dCBiZWZvcmUgaXQncyBzZXQgdG8gTlVMTCwgZWc6Cj4KPmRpZmYgLS1naXQgYS9hcmNoL3Bvd2Vy
cGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEwMDAuYyBiL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMv
ODV4eC9zZ3lfY3RzMTAwMC5jCj5pbmRleCA5OGFlNjQwNzUxOTMuLjdiZWIzY2Q0MjBiYSAxMDA2
NDQKPi0tLSBhL2FyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9zZ3lfY3RzMTAwMC5jCj4rKysg
Yi9hcmNoL3Bvd2VycGMvcGxhdGZvcm1zLzg1eHgvc2d5X2N0czEwMDAuYwo+QEAgLTEzOSw2ICsx
MzksNyBAQCBzdGF0aWMgaW50IGdwaW9faGFsdF9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikKPiAKPiAJCWdwaW9fZnJlZShncGlvKTsKPiAKPisJCW9mX25vZGVfcHV0KGhhbHRf
bm9kZSk7Cj4gCQloYWx0X25vZGUgPSBOVUxMOwo+IAl9Cj4gCj4KPmNoZWVycwoKCgpPaywgSSB3
aWxsIG1ha2UgdGhlIG5ldyBwYXRjaCBzb29uLg==
