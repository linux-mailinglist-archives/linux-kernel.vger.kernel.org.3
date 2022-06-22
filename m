Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F94554326
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 09:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbiFVG5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346267AbiFVG5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:57:04 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9F7611170;
        Tue, 21 Jun 2022 23:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=zogoA
        n+yN5BMbClxTPpORdmKdvToRmCB4hLDgQbunzE=; b=N+Oj3fC9rOi4sSbLydqfk
        xuFSrkVf2hII0nnri0zz5g5H0YKN9Ig/q9IEaIl2B8HIjQGA6b5ztkRsxWWu+FrJ
        2/VcivMGxhCI3VHnvpGzrQpql3JKFQA4QZrFs4A3t+aATUERZIR433s+uV+Z2/hL
        itZxjZDpPuMoBqT+K6iytE=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Wed, 22 Jun 2022 14:56:54 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 14:56:54 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re:Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <bdfc94d0-c634-c391-d74b-2104cbf82b22@linaro.org>
References: <20220622042824.4094625-1-windhl@126.com>
 <bdfc94d0-c634-c391-d74b-2104cbf82b22@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <61741b61.46f3.1818a331e3d.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowAC3vyc3vbJiXqw6AA--.27316W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3BIoF1pEDxpG0wABsu
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTIyIDE0OjUwOjQxLCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6Cj5PbiAyMi8wNi8yMDIyIDA2OjI4LCBMaWFu
ZyBIZSB3cm90ZToKPj4gb2ZfZmluZF9ub2RlX2J5X25hbWUoKSB3aWxsIGRlY3JlYXNlIHRoZSBy
ZWZjb3VudCBvZiBpdHMgZmlyc3QgYXJnIGFuZAo+PiB3ZSBuZWVkIHRvIGFkZCBhIG9mX25vZGVf
cHV0KCkgdG8ga2VlcCByZWZjb3VudCBiYWxhbmNlLgo+Cj5XZSBkbyBOT1QgbmVlZCB0byBhZGQg
YW4gb2Zfbm9kZV9wdXQ/Cj4KClNvcnJ5LCB0aGlzIGlzIGEgdHlwbywgSSB3YW50IHRvIHNheSB3
ZSBuZWVkIHRvIGFkZCBhICdvZl9ub2RlX2dldCgpJwoKPkFueXdheSB3aHkgZG8geW91IGFkZCBv
Zl9ub2RlX2dldCB3aGljaCBpcyBub3QgZXhwbGFpbmVkIGhlcmU/Cj4KClRoaXMgaXMgYSBjb21t
b24gbWlzdGFrZSB0aGF0IG1pc3NpbmcgdGhlIG9mX25vZGVfZ2V0KFgpIGJlZm9yZSB3ZSBjYWxs
Cm9mX2ZpbmRfbm9kZV9ieV9uYW1lKFgsLi4pIGFzIHRoZSBvZl9maW5kX3h4eCB3aWxsIGRlY3Jl
YXNlIHRoZSByZWZjb3VudCBvZiBYLgoKQSBzaW1pbGFyIGVycm9yIGlzOgoKaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjAwNzIwMTUyODA2LjQ0MzI2MjY0OEBsaW51eGZvdW5kYXRpb24u
b3JnLwoKSWYgSSBhbSB3cm9uZywgcGxlYXNlIGNvcnJlY3QgbWUsIHRoYW5rcy4KPj4gCj4+IEJl
c2lkZXMsIGR1cmluZyB0aGUgJ2ZvcicgbG9vcCBleGVjdXRpb24sIHRoZSByZWZjb3VudCBvZiAn
bnAnIHdpbGwgYmUKPj4gYXV0b21hdGljYWxseSBpbmNyZWFzZWQgYW5kIGRlY3JlYXNlZC4gVGhl
cmUgaXMgbm8gbmVlZCB0byBjYWxsCj4+IG9mX25vZGVfcHV0KCkgYWdhaW4uCj4+IAo+PiBTaWdu
ZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4+IC0tLQo+PiAgZHJpdmVycy9t
ZW1vcnkvdGVncmEvdGVncmEyMC1lbWMuYyB8IDMgKystCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZW1vcnkvdGVncmEvdGVncmEyMC1lbWMuYyBiL2RyaXZlcnMvbWVtb3J5L3RlZ3JhL3RlZ3JhMjAt
ZW1jLmMKPj4gaW5kZXggMjViYTNjNWU0YWQ2Li5lNDNhNWY4ZTE4OGUgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvbWVtb3J5L3RlZ3JhL3RlZ3JhMjAtZW1jLmMKPj4gKysrIGIvZHJpdmVycy9tZW1v
cnkvdGVncmEvdGVncmEyMC1lbWMuYwo+PiBAQCAtNDc3LDYgKzQ3Nyw3IEBAIHRlZ3JhX2VtY19m
aW5kX25vZGVfYnlfcmFtX2NvZGUoc3RydWN0IHRlZ3JhX2VtYyAqZW1jKQo+PiAgCj4+ICAJcmFt
X2NvZGUgPSB0ZWdyYV9yZWFkX3JhbV9jb2RlKCk7Cj4+ICAKPj4gKwlvZl9nZXRfbm9kZShkZXYt
Pm9mX25vZGUpOwo+PiAgCWZvciAobnAgPSBvZl9maW5kX25vZGVfYnlfbmFtZShkZXYtPm9mX25v
ZGUsICJlbWMtdGFibGVzIik7IG5wOwo+PiAgCSAgICAgbnAgPSBvZl9maW5kX25vZGVfYnlfbmFt
ZShucCwgImVtYy10YWJsZXMiKSkgewo+PiAgCQllcnIgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihu
cCwgIm52aWRpYSxyYW0tY29kZSIsICZ2YWx1ZSk7Cj4+IEBAIC00ODQsNiArNDg1LDcgQEAgdGVn
cmFfZW1jX2ZpbmRfbm9kZV9ieV9yYW1fY29kZShzdHJ1Y3QgdGVncmFfZW1jICplbWMpCj4+ICAJ
CQlzdHJ1Y3QgZGV2aWNlX25vZGUgKmxwZGRyMl9ucDsKPj4gIAkJCWJvb2wgY2ZnX21pc21hdGNo
ZXMgPSBmYWxzZTsKPj4gIAo+PiArCQkJb2Zfbm9kZV9nZXQobnApOwo+PiAgCQkJbHBkZHIyX25w
ID0gb2ZfZmluZF9ub2RlX2J5X25hbWUobnAsICJscGRkcjIiKTsKPj4gIAkJCWlmIChscGRkcjJf
bnApIHsKPj4gIAkJCQljb25zdCBzdHJ1Y3QgbHBkZHIyX2luZm8gKmluZm87Cj4+IEBAIC01MjEs
NyArNTIzLDYgQEAgdGVncmFfZW1jX2ZpbmRfbm9kZV9ieV9yYW1fY29kZShzdHJ1Y3QgdGVncmFf
ZW1jICplbWMpCj4+ICAJCQl9Cj4+ICAKPj4gIAkJCWlmIChjZmdfbWlzbWF0Y2hlcykgewo+PiAt
CQkJCW9mX25vZGVfcHV0KG5wKTsKPj4gIAkJCQljb250aW51ZTsKPj4gIAkJCX0KPj4gIAkJfQo+
Cj4KPkJlc3QgcmVnYXJkcywKPktyenlzenRvZgo=
