Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0F5554971
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiFVIeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbiFVIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:34:41 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A91B3878F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=keVJx
        ideL7zo39jGAWrquWLN4izWYfoDVnJA7Z3cP0s=; b=eYZxsp2UBo/n9HvIfyBKH
        hXNa2lysKsaT0LSWPp2LvFV453/QPahH8fhYgH/nW7OJu2EJ7fJuC7k/fJAf11RC
        L6lIt/AAXZxTsPpU1pgpI1ien0Kk7iVofQKlo0hPaFQyigBlm95Y3tTmvIoPTwug
        FCkQ/qsZ+pG0+gqr8qKlqY=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Wed, 22 Jun 2022 16:34:25 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Wed, 22 Jun 2022 16:34:25 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Marc Zyngier" <maz@kernel.org>,
        "Miaoqian Lin" <linmq006@gmail.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] irqchip: Add missing of_ndoe_get() in its_of_probe()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <87letp2j9e.wl-maz@kernel.org>
References: <20220622062138.4095598-1-windhl@126.com>
 <87mte52khd.wl-maz@kernel.org>
 <229e8ea9.5a09.1818a7b7a35.Coremail.windhl@126.com>
 <87letp2j9e.wl-maz@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <1b3e9050.5eb9.1818a8c64d3.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADnPPES1LJiZXo7AA--.4949W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgcoF18RPWVO2wABs0
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0yMiAxNjoyOTo0OSwgIk1hcmMgWnluZ2llciIgPG1hekBrZXJuZWwub3Jn
PiB3cm90ZToKPk9uIFdlZCwgMjIgSnVuIDIwMjIgMDk6MTU6NTYgKzAxMDAsCj4iTGlhbmcgSGUi
IDx3aW5kaGxAMTI2LmNvbT4gd3JvdGU6Cj4+IAo+PiAKPj4gCj4+IEF0IDIwMjItMDYtMjIgMTY6
MDM6MjYsICJNYXJjIFp5bmdpZXIiIDxtYXpAa2VybmVsLm9yZz4gd3JvdGU6Cj4+ID4rIE1pYW9x
aWFuIExpbgo+PiA+Cj4+ID5PbiBXZWQsIDIyIEp1biAyMDIyIDA3OjIxOjM4ICswMTAwLAo+PiA+
TGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPiB3cm90ZToKPj4gPj4gCj4+ID4+IFdlIG5lZWQgdG8g
YWRkIG1pc3Npbmcgb2Zfbm9kZV9nZXQoKSBmb3Igb2ZfZmluZF9tYXRjaGluZ19ub2RlKCkgdG8K
Pj4gPj4ga2VlcCByZWZjb3VudCBiYWxhbmNlLgo+PiA+PiAKPj4gPj4gTm90ZTogb2ZfZmluZF9t
YXRjaGluZ19ub2RlKCkgd2lsbCBkZWNyZWFzZSB0aGUgcmVmY291bnQgb2YgaXRzIGZpcnN0Cj4+
ID4+IGFyZy4KPj4gPj4gCj4+ID4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5kaGxAMTI2
LmNvbT4KPj4gPgo+PiA+Wy4uLl0KPj4gPgo+PiA+UGxlYXNlIHNlbmQgdGhlc2UgcmVmY291bnQg
Zml4ZXMgYXMgYSBzZXJpZXMgZm9yIGFsbCB0aGUgaXJxY2hpcAo+PiA+ZHJpdmVycywgbm90IG9u
ZSBldmVyeSBvdGhlciBkYXkuCj4+ID4KPj4gCj4+IFNvcnJ5LCBJIHdpbGwgZ3JvdXAgc2ltaWxh
ciBidWdzICBpbiBmdXR1cmUuCj4+IAo+PiAKPj4gPkFuZCBwbGVhc2Ugc3luY2hyb25pc2Ugd2l0
aCBNaWFvcWlhbiBMaW4sIGFzIHlvdSBhcmUgb2J2aW91c2x5IGJvdGgKPj4gPmNoYXNpbmcgdGhl
IHNhbWUgYnVncy4KPj4gPgo+PiA+VGhhbmtzLAo+PiA+Cj4+ID4JTS4KPj4gCj4+IFllcywgYmVm
b3JlIEkgc2VuZCBhbnkgbmV3IGJ1ZywgSSB3aWxsIGNvbmZpcm0gdGhhdCB0aGlzIGJ1ZyBoYXMg
bm90Cj4+IGJlZW4gcmVwb3J0ZWQgaW4gbG9yZS5rZXJuZWwub3JnLgo+Cj5UaGlzIGlzIG5vdCB3
aGF0IEkgbWVhbnQuIEkgYW0gYXNraW5nIHlvdSB0byBhY3RpdmVseSBjb29yZGluYXRlIHdpdGgK
Pk1pYW9xaWFuLCB3b3JraW5nIHdpdGggdGhlbSBhcyBhIHRlYW0gaW5zdGVhZCBvZiB5b3UgYm90
aCBzZW5kaW5nCj5jb21wZXRpbmcgc2VyaWVzLiBJIHdvdWxkIGxpa2UgdG8gc2VlIG9uZSBzZXJp
ZXMgd2l0aCBwYXRjaGVzIGZyb20geW91Cj5ib3RoLgoKT0ssIEkgZ2V0IGl0LiBUaGlzIGRlcGVu
ZHMgb24gTWlhb3FpYW4uCgpAbGlubTAwNkBnbWFpbC5jb20KCj4KPj4gQnkgdGhlIHdheSwgdGhp
cyBpcyBhIGJ1ZyBtaXNzaW5nIHxHRVR8LCBub3QgfFBVVHwsIHdoaWNoIGlzCj4+IGRpZmZlcmVu
dCB3aXRoIE1pYW9xaWFuJ3MgYW5kIG15IHBhdGNoZXMgYmVmb3JlLgo+Cj5XZWxsLCB5ZXQgYW5v
dGhlciByZWFzb24gZm9yIHlvdSBib3RoIHRvIHdvcmsgdG9nZXRoZXIsIGFzIHlvdSBhcmUKPmNv
bXBsZW1lbnRpbmcgZWFjaCBvdGhlci4KPgo+VGhhbmtzLAo+Cj4JTS4KPgo+LS0gCj5XaXRob3V0
IGRldmlhdGlvbiBmcm9tIHRoZSBub3JtLCBwcm9ncmVzcyBpcyBub3QgcG9zc2libGUuCg==
