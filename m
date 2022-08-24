Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C8159F641
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiHXJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbiHXJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:30:53 -0400
Received: from m13131.mail.163.com (m13131.mail.163.com [220.181.13.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DB59895C6;
        Wed, 24 Aug 2022 02:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=jYbWW
        wWJU1UZELsnMoadaD8lwGOGXDDJJHvX5F9D2o4=; b=fRmdBMAhj2cSHI7Q6gNEz
        P2q12XNavxDgiIWHs6OZLrK8buB6sTcsdivuBB94K52mVtKi2ACXw172u3I6J+8d
        642WqDixCzjL3p+JPIxWivt3ADV5vg5C4tXJdrr7sru+2UXZ17Vi8u3WsjO1k7Er
        M0IHOgW0f3Y/U/K6Ma8W6k=
Received: from slark_xiao$163.com ( [112.97.50.93] ) by
 ajax-webmail-wmsvr131 (Coremail) ; Wed, 24 Aug 2022 17:29:33 +0800 (CST)
X-Originating-IP: [112.97.50.93]
Date:   Wed, 24 Aug 2022 17:29:33 +0800 (CST)
From:   "Slark Xiao" <slark_xiao@163.com>
To:     "Johan Hovold" <johan@kernel.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re:Re: Re: [PATCH] USB: serial: option: add support for Cinterion
 MV32-WA/WB RmNet mode
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
In-Reply-To: <YwXu3ZDozZczJxuh@hovoldconsulting.com>
References: <20220810033050.3117-1-slark_xiao@163.com>
 <54f2b923.341c.182a606bab3.Coremail.slark_xiao@163.com>
 <YvtoSQUVuUkMCXtl@kroah.com>
 <7491a855.2224.182cf117a99.Coremail.slark_xiao@163.com>
 <YwXu3ZDozZczJxuh@hovoldconsulting.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <60adb407.24aa.182cf2f836c.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: g8GowACHA3l97wVjU2gdAA--.52833W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbBDQZnZFaEKgHe4gABsM
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgoKCgoKCgoKCgoKCkF0IDIwMjItMDgtMjQgMTc6MjY6NTMsICJKb2hhbiBIb3ZvbGQiIDxq
b2hhbkBrZXJuZWwub3JnPiB3cm90ZToKPk9uIFdlZCwgQXVnIDI0LCAyMDIyIGF0IDA0OjU2OjQ1
UE0gKzA4MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4KPj4gQXQgMjAyMi0wOC0xNiAxNzo1MDowMSwg
ImdyZWdraCIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPj4gPk9uIFR1ZSwg
QXVnIDE2LCAyMDIyIGF0IDA1OjQwOjM1UE0gKzA4MDAsIFNsYXJrIFhpYW8gd3JvdGU6Cj4+ID4+
IEFueSByZXNwb25zZaO/Cj4+ID4KPj4gPlRvIHdoYXQ/Cj4+ID4KPj4gPkl0IHdhcyB0aGUgbWlk
ZGxlIG9mIHRoZSBtZXJnZSB3aW5kb3csIHdlIGNhbid0IGRvIGFueXRoaW5nIHdpdGggbmV3Cj4+
ID5wYXRjaGVzIHVudGlsIGFmdGVyIC1yYzEgaXMgb3V0LCBhbmQgdGhlbiB3ZSBoYXZlIGEgZmV3
IHRob3VzYW5kIHRvIGRpZwo+PiA+dGhyb3VnaCBhZnRlcndhcmQuCj4+ID4KPj4gPlJlbGF4LCB0
aGVyZSBpcyBubyBydXNoIGhlcmUuCj4+ID4KPj4gPnRoYW5rcywKPj4gPgo+PiA+Z3JlZyBrLWgK
Pj4gSGkgR3JlZywKPj4gICBOb3cgdjYuMC1yYzIgaXMgb3V0IGZvciBzZXZlcmFsIGRheXMuIEkg
c3RpbGwgZGlkbid0IGZpbmQgYW55IHByb2dyZXNzIGFib3V0IHRoaXMgY29tbWl0Lgo+PiBOb3Jt
YWxseSBzdWNoIGNvbW1pdCB3b3VsZCBiZSBjb21taXR0ZWQgaW50byBKb2hhbiBIb3ZvbGQncyBw
ZXJzb25hbCBwcm9qZWN0IGZpcnN0bHk6Cj4+IGluZGV4OiBrZXJuZWwvZ2l0L2pvaGFuL3VzYi1z
ZXJpYWwuZ2l0IGFuZCB3YWl0dGluZyBmb3IgbWVyZ2Ugd2luZG93Lgo+PiAgIEluIHNvbWUgc3Vi
LXN5c3RlbSwgdGhlIG1lcmdlIHdpbmRvdyB3b3VsZCBiZSBjbG9zZWQgYWZ0ZXIgcmM0Lgo+PiBT
byBKb2hhbiBvciBHcmVnICwgY291bGQgeW91IGhlbHAgaGFuZGxlIHRoaXMgYXNhcD8KPgo+QWdh
aW4sIHJlbGF4LiBJIGhhdmVuJ3QgaGFkIHRpbWUgdG8gcHJvY2VzcyBteSBxdWV1ZSBhZnRlciB0
aGUgbWVyZ2UKPndpbmRvdyBhbmQgc29tZSBob2xpZGF5LiBOb3RoaW5nIGlzIGxvc3QgYW5kIEkn
bGwgZ2V0IHRvIHlvdXIgcGF0Y2ggaW4KPnRpbWUuCj4KPkpvaGFuCgpPSywgZ290IGl0LCB0aGFu
a3Mh
