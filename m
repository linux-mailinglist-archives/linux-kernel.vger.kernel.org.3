Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0F554866
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353393AbiFVIt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351923AbiFVItz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:49:55 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2DBC37A00;
        Wed, 22 Jun 2022 01:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=w9smT
        9c7AimDj+0qXZ7d9XMDCS+o+Pqmaur0QQu32Rc=; b=YTUKCFSTAYSRF68e3j9a4
        T1WapaOY27khueUPi/l8Ec/pftVTLcy4EcKZUaseI9sFassBQXTEqgmx2wtGHY3N
        m3D48pfN6kJeMUVkAcnHtPV9hUb72gnulOKXrFv84ATkPT9R5ATjnuiFF/5J/+wo
        jU18qxzXdFWrkRpxNOTIJU=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Wed, 22 Jun 2022 16:49:43 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 16:49:43 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re:Re: [PATCH] memory/tegra: Add missing of_node_get() in
 tegra_emc_find_node_by_ram_code
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <2f3e843e-b72b-ee71-7465-b2b6c8d51b0d@linaro.org>
References: <20220622042824.4094625-1-windhl@126.com>
 <2f3e843e-b72b-ee71-7465-b2b6c8d51b0d@linaro.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <11875304.61a4.1818a9a66bb.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowABHTyeo17JiAdI6AA--.27634W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3AgoF1pEDxshpAAAsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTIyIDE2OjQxOjI4LCAiS3J6eXN6dG9mIEtvemxvd3NraSIgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6Cj5PbiAyMi8wNi8yMDIyIDA2OjI4LCBMaWFu
ZyBIZSB3cm90ZToKPj4gb2ZfZmluZF9ub2RlX2J5X25hbWUoKSB3aWxsIGRlY3JlYXNlIHRoZSBy
ZWZjb3VudCBvZiBpdHMgZmlyc3QgYXJnIGFuZAo+PiB3ZSBuZWVkIHRvIGFkZCBhIG9mX25vZGVf
cHV0KCkgdG8ga2VlcCByZWZjb3VudCBiYWxhbmNlLgo+PiAKPj4gQmVzaWRlcywgZHVyaW5nIHRo
ZSAnZm9yJyBsb29wIGV4ZWN1dGlvbiwgdGhlIHJlZmNvdW50IG9mICducCcgd2lsbCBiZQo+PiBh
dXRvbWF0aWNhbGx5IGluY3JlYXNlZCBhbmQgZGVjcmVhc2VkLiBUaGVyZSBpcyBubyBuZWVkIHRv
IGNhbGwKPj4gb2Zfbm9kZV9wdXQoKSBhZ2Fpbi4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5n
IEhlIDx3aW5kaGxAMTI2LmNvbT4KPj4gLS0tCj4+ICBkcml2ZXJzL21lbW9yeS90ZWdyYS90ZWdy
YTIwLWVtYy5jIHwgMyArKy0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4gCj4KPlRoZSBwYXRjaCB3YXMgbm90IGV2ZW4gY29tcGlsZWQuLi4gSSBj
b25zaWRlciBpdCBoYXJtZnVsIGFwcHJvYWNoLiBOQUsuCj5TZWU6IGh0dHBzOi8vbHduLm5ldC9B
cnRpY2xlcy84NTQ2NDUvCj4KPkJlc3QgcmVnYXJkcywKPktyenlzenRvZgoKU29ycnksIEtyenlz
enRvZi4KCkFzIHRoZSBwYXRjaCBpcyBzbyBzaW1wbGUgdHdvIGxpbmVzICwgSSB0aG91Z2h0IEkg
Y2FuIGhhbmRsZSBpdCB3aXRob3V0IGNvbXBpbGluZyBpdC4KClRoYW5rcyB2ZXJ5IG11Y2ggZm9y
IHlvdXIgbm90aWNlIGFib3V0IHRoZSBhcnRpY2xlIGFuZCBJIGhvcGUgSSBoYXZlIG5vdCBkb25l
IGFueW90aGVyIGhhcm1mdWwgdGhpbmdzLgoKQW5kIEkgd2lsbCB0YWtlIGNhcmUgb2YgbXkgcGF0
Y2ggY29kZSBpbiBmdXR1cmUgbm8gbWF0dGVyIGhvdyBzaW1wbGUgaXQgaXMuCgoK
