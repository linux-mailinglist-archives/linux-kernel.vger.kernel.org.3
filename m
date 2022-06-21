Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D70553626
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiFUPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiFUPdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:33:13 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D456654B;
        Tue, 21 Jun 2022 08:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=9VZGf
        79RSfusZpOmSyRtMDiWqSh9xMMOEKRSR6xpo/0=; b=G8ljdWdJf4WzfbMSHoyLm
        zgLJMH9DocVUCfLW1MILDPPwt+o5QbxgFWjufjsMB+kX4rqhstF3zAy8olzkpMQ3
        CN+Vc3iSMRmJZPCv94R7k/fbHP1x1KIVSoLZZVtxExYnGOg1a1LZC1ps+/H6H9/+
        /z5DAWaBB0r/QWNPIAd1NU=
Received: from windhl$126.com ( [123.112.70.164] ) by ajax-webmail-wmsvr50
 (Coremail) ; Tue, 21 Jun 2022 23:32:41 +0800 (CST)
X-Originating-IP: [123.112.70.164]
Date:   Tue, 21 Jun 2022 23:32:41 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Cc:     john@phrozen.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] mips: lantiq: Add missing of_node_put() in irq.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220621152119.GB12322@alpha.franken.de>
References: <20220615153339.3970658-1-windhl@126.com>
 <20220621152119.GB12322@alpha.franken.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <5b777944.84cc.18186e4f5ba.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADHHPGa5LFiN+g6AA--.2303W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi7QknF1pEAP6xCQADsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTIxIDIzOjIxOjE5LCAiVGhvbWFzIEJvZ2VuZG9lcmZlciIgPHRzYm9nZW5k
QGFscGhhLmZyYW5rZW4uZGU+IHdyb3RlOgo+T24gV2VkLCBKdW4gMTUsIDIwMjIgYXQgMTE6MzM6
MzlQTSArMDgwMCwgTGlhbmcgSGUgd3JvdGU6Cj4+IEluIGljdV9vZl9pbml0KCksIG9mX2ZpbmRf
Y29tcGF0aWJsZV9ub2RlKCkgd2lsbCByZXR1cm4gYSBub2RlCj4+IHBvaW50ZXIgd2l0aCByZWZj
b3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxkIHVzZSBvZl9ub2RlX3B1dCgpCj4+IHdoZW4gaXQg
aXMgbm90IHVzZWQgYW55bW9yZS4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IExpYW5nIEhlIDx3aW5k
aGxAMTI2LmNvbT4KPj4gLS0tCj4+ICBhcmNoL21pcHMvbGFudGlxL2lycS5jIHwgNiArKysrKysK
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4gCj4+IGRpZmYgLS1naXQgYS9h
cmNoL21pcHMvbGFudGlxL2lycS5jIGIvYXJjaC9taXBzL2xhbnRpcS9pcnEuYwo+PiBpbmRleCBi
NzMyNDk1ZjEzOGEuLjYyZjFiMjBhMjE2OSAxMDA2NDQKPj4gLS0tIGEvYXJjaC9taXBzL2xhbnRp
cS9pcnEuYwo+PiArKysgYi9hcmNoL21pcHMvbGFudGlxL2lycS5jCj4+IEBAIC0zOTYsNiArMzk2
LDkgQEAgaW50IF9faW5pdCBpY3Vfb2ZfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsIHN0
cnVjdCBkZXZpY2Vfbm9kZSAqcGFyZW50KQo+PiAgCj4+ICAJCXJldCA9IG9mX3Byb3BlcnR5X3Jl
YWRfdTMyX2FycmF5KGVpdV9ub2RlLCAibGFudGlxLGVpdS1pcnFzIiwKPj4gIAkJCQkJCWx0cV9l
aXVfaXJxLCBleGluX2F2YWlsKTsKPj4gKwkJCQkJCQo+Cj50cmFpbGluZyB3aGl0ZXNwYWNlcwo+
Cj4+ICsJCW9mX25vZGVfcHV0KGVpdV9ub2RlKTsKPj4gKwkJCQkJCQo+Cj50cmFpbGluZyB3aGl0
ZXNwYWNlcwo+Cj4+ICAJCWlmIChyZXQpCj4+ICAJCQlwYW5pYygiZmFpbGVkIHRvIGxvYWQgZXh0
ZXJuYWwgaXJxIHJlc291cmNlcyIpOwo+PiAgCj4+IEBAIC00MDksNiArNDEyLDkgQEAgaW50IF9f
aW5pdCBpY3Vfb2ZfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsIHN0cnVjdCBkZXZpY2Vf
bm9kZSAqcGFyZW50KQo+PiAgCQkJcGFuaWMoIkZhaWxlZCB0byByZW1hcCBlaXUgbWVtb3J5Iik7
Cj4+ICAJfQo+PiAgCj4+ICsJLyogaWYgZWl1X25vZGUmb2ZfYWRkcmVzc190b19yZXNvdXJjZSAq
Lwo+PiArCW9mX25vZGVfcHV0KGVpdV9ub2RlKTsKPj4gKwo+Cj5pZiBJJ20gbm90IG1pc3Rha2Vu
IHlvdSBhcmUgZnJlZWluZyB0aGUgdGFrZW4gcmVmZXJlbmNlIHR3aWNlLiBTaG91bGRuJ3QKPml0
IHdvcmsgYnkgb25seSBhZGRpbmcgdGhlIGxhc3Qgb2Zfbm9kZV9wdXQoKSA/Cj4KPlRob21hcy4K
CkhpLCBUaG9tYXMuCgpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIGVmZm9ydCB0byByZXZpZXcg
YW5kIGFwcGx5IG15IHBhdGNoZXMuCgpZb3UgYXJlIHJpZ2h0LCB0aGlzIHBhdGNoIGlzIHdyb25n
IGFuZCBvbmx5IHRoZSBsYXN0IHB1dCBpcyBuZWVkZWQuCgpJIHdpbGwgc2VuZCBhIG5ldyBwYXRj
aDogcmVtb3ZpbmcgdHJhaWxpbmcgd2hpdHNwYWNlIGFuZCB0aGUgZmlyc3QgcHV0LgoKVGhhbnMg
YWdhaW4uCgpMaWFuZwoKPgo+LS0gCj5DcmFwIGNhbiB3b3JrLiBHaXZlbiBlbm91Z2ggdGhydXN0
IHBpZ3Mgd2lsbCBmbHksIGJ1dCBpdCdzIG5vdCBuZWNlc3NhcmlseSBhCj5nb29kIGlkZWEuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgWyBSRkMxOTI1LCAy
LjMgXQo=
