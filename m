Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19239554603
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiFVIQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiFVIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:16:35 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4051B37BEC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=kN6/r
        hU/2QYB7HknJbEH3z7r4SRj8x+O+RgWXUCDTNs=; b=aUqqWwhqoHTQ646YOPpFs
        6fcaMZiAohrk7MVT9G/VR1fhkyH7cq9L+UzXWscyhgvZTKpuSvazkcmllAee1s1h
        n8GuJzlakeB4RfdMAIM12RTbl+LAx8DhiON8fiWYPM87rxkR0aRtPKmOWLRU3e3T
        3YwdJWFeDKHa/dvNvel/8I=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Wed, 22 Jun 2022 16:15:56 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 16:15:56 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Marc Zyngier" <maz@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Miaoqian Lin" <linmq006@gmail.com>
Subject: Re:Re: [PATCH] irqchip: Add missing of_ndoe_get() in its_of_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <87mte52khd.wl-maz@kernel.org>
References: <20220622062138.4095598-1-windhl@126.com>
 <87mte52khd.wl-maz@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <229e8ea9.5a09.1818a7b7a35.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowAAnfPC+z7JihnM7AA--.2131W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuB4oF2JVj-e7IgAAsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTIyIDE2OjAzOjI2LCAiTWFyYyBaeW5naWVyIiA8bWF6QGtlcm5lbC5vcmc+
IHdyb3RlOgo+KyBNaWFvcWlhbiBMaW4KPgo+T24gV2VkLCAyMiBKdW4gMjAyMiAwNzoyMTozOCAr
MDEwMCwKPkxpYW5nIEhlIDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+IAo+PiBXZSBuZWVkIHRv
IGFkZCBtaXNzaW5nIG9mX25vZGVfZ2V0KCkgZm9yIG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZSgpIHRv
Cj4+IGtlZXAgcmVmY291bnQgYmFsYW5jZS4KPj4gCj4+IE5vdGU6IG9mX2ZpbmRfbWF0Y2hpbmdf
bm9kZSgpIHdpbGwgZGVjcmVhc2UgdGhlIHJlZmNvdW50IG9mIGl0cyBmaXJzdAo+PiBhcmcuCj4+
IAo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5jb20+Cj4KPlsuLi5dCj4K
PlBsZWFzZSBzZW5kIHRoZXNlIHJlZmNvdW50IGZpeGVzIGFzIGEgc2VyaWVzIGZvciBhbGwgdGhl
IGlycWNoaXAKPmRyaXZlcnMsIG5vdCBvbmUgZXZlcnkgb3RoZXIgZGF5Lgo+CgpTb3JyeSwgSSB3
aWxsIGdyb3VwIHNpbWlsYXIgYnVncyAgaW4gZnV0dXJlLgoKCj5BbmQgcGxlYXNlIHN5bmNocm9u
aXNlIHdpdGggTWlhb3FpYW4gTGluLCBhcyB5b3UgYXJlIG9idmlvdXNseSBib3RoCj5jaGFzaW5n
IHRoZSBzYW1lIGJ1Z3MuCj4KPlRoYW5rcywKPgo+CU0uCgpZZXMsICBiZWZvcmUgSSBzZW5kIGFu
eSBuZXcgYnVnLCBJIHdpbGwgY29uZmlybSB0aGF0IHRoaXMgYnVnIGhhcyBub3QgYmVlbiByZXBv
cnRlZCBpbiBsb3JlLmtlcm5lbC5vcmcuCgpCeSB0aGUgd2F5LCB0aGlzIGlzIGEgYnVnIG1pc3Np
bmcgfEdFVHwsIG5vdCB8UFVUfCwgd2hpY2ggaXMgZGlmZmVyZW50IHdpdGggTWlhb3FpYW4ncyBh
bmQgbXkgcGF0Y2hlcyBiZWZvcmUuCgo+Cj4tLSAKPldpdGhvdXQgZGV2aWF0aW9uIGZyb20gdGhl
IG5vcm0sIHByb2dyZXNzIGlzIG5vdCBwb3NzaWJsZS4K
