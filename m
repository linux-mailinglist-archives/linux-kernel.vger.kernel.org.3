Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A7515B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiD3IRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiD3IRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:17:05 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671F862BDF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:13:39 -0700 (PDT)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: YHTLUubWl24Q37pL9zyMyetOwVg0bciU1lNjE8xH1EJaAUgnWhItRY26azBDM
        q+5G8y5H5aasD1JxZIgt2ED/fz1YQA/4QSWnsxh4tHgUtew2uN2DtZjr1YujxQHRskB9Ovh
        5E7dIlYES88wwMgtYH1HZp7ZVkxBbqPK6Csw3nD+Q+u7plNzAckeUwGjhaUrB0Z5D+rmV+d
        W+vQV6fZWA73tOz6q6SVRyOZT1JEFHq+oVMMMEpDbCBw3eGWkAGA2NzLQZ1ONjyediUiDh4
        lEciRpR9KR1BLSiE1do1bose8wAAXbKIx1unJLAmlLSRNbwO7+wKMMbDMYTshsmmCu0G/bg
        mn2TGCXTFluZue8QUM9GZzkH624HP8plE56ttygzVJaEqGe2OlEdA/d8OZ8OAVNWdom9bCl
        x1bi6wBvg1U=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.17.66.222
X-QQ-STYLE: 
X-QQ-mid: llogic72t1651306404t281577
From:   "=?utf-8?B?U2hlbmdob25nIEhhbg==?=" 
        <hanshenghong2019@email.szu.edu.cn>
To:     "=?utf-8?B?QWtpcmEgWW9rb3Nhd2E=?=" <akiyks@gmail.com>,
        "=?utf-8?B?Sm9uYXRoYW4gQ29yYmV0?=" <corbet@lwn.net>
Cc:     "=?utf-8?B?YWtwbQ==?=" <akpm@linux-foundation.org>,
        "=?utf-8?B?YmFpaGFvd2Vu?=" <baihaowen@meizu.com>,
        "=?utf-8?B?c2Vha2VlbA==?=" <seakeel@gmail.com>,
        "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?Y2FveWl4dWFuMjAxOQ==?=" <caoyixuan2019@email.szu.edu.cn>,
        "=?utf-8?B?eWVqaWFqaWFuMjAxOA==?=" <yejiajian2018@email.szu.edu.cn>,
        "=?utf-8?B?5Yav6ICB5biI?=" <yuhongf@szu.edu.cn>
Subject: Re: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and Describe details using table
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 30 Apr 2022 16:13:24 +0800
X-Priority: 3
Message-ID: <tencent_088763F35CE233FB6C9CEB80@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20220429181926.10658-1-hanshenghong2019@email.szu.edu.cn>
        <ea37d4f9-26e2-272a-01d6-fa7e8c62687e@gmail.com>
In-Reply-To: <ea37d4f9-26e2-272a-01d6-fa7e8c62687e@gmail.com>
X-QQ-ReplyHash: 897282373
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Sat, 30 Apr 2022 16:13:26 +0800 (CST)
Feedback-ID: llogic:email.szu.edu.cn:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCkgSWYgeW91IGhhdmUgcmVjZWl2ZWQgYSBzaW1pbGFyIHJlcGx5LCBwbGVhc2UgcmVmZXIg
dG8gdGhlIGxhdGVzdCByZXBseS4xKSBBY2NpZGVudGFsbHkgdXNlZCBDaGluZXNlIElucHV0
IE1ldGhvZCBFZGl0b3IsIGxlYXZpbmcgZnVsbC13aWR0aCBzeW1ib2xzIGR1cmluZyB0aGUg
dGVzdCwgY2F1c2luZyB0aGUgZG91YmxlIGRhc2hlcyBvZiAiLS0iIGNoYW5nZWQgaW50byAi
bG9uZyBzaW5nbGUgZGFzaCIgd2hpY2ggc2hvdWxkIG5vdCBoYXZlIG9jY3VycmVkLjIpIElu
IHRoZSBjdXJyZW50IGRvY3VtZW50LCB0aGUgIlNUQU5EQVJEIEZPUk1BVCBTUEVDSUZJRVJT
IiB0YWJsZSBkb2VzIG5vdCBjb3JyZWN0bHkgdXNlIHRoZSBmb3JtYXQgb2YgdGhlIHJzdCBk
b2N1bWVudCwgc28gaW4gdGhlIHdlYnNpdGUgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2Mv
aHRtbC9sYXRlc3Qvdm0vcGFnZV9vd25lci5odG1sLCBpdCBkb2VzIG5vdCBsb29rIGdvb2Qu
IFRoZXJlZm9yZSwgdGhlICJTVEFOREFSRCBGT1JNQVQgU1BFQ0lGSUVSUyIgaGFzIGJlZW4g
YWRqdXN0ZWQgdXNpbmcgdGhlIGZvcm1hdCBvZiB0aGUgcnN0IHRhYmxlLiAqVGhpcyogaXMg
dGhlIG1haW4gcHVycG9zZS4zKSBJbiB2ZXJzaW9uIDEgYmVmb3JlLCB0aGUgc2VudGVuY2Ug
bG9vayBsaWtlOiJUYWJsZSAxIHh4eChzb21lIGV4cGxhaW5hdGlvbikuIiBhbmQgIlRhYmxl
IDIgeHh4KHNvbWUgZXhwbGFpbmF0aW9uKS4iLCBpbiB0aGVzZSAyICJsb25nIiBzZW50ZW5j
ZXMsIHVzaW5nICIuIiBpbnN0ZWFkIG9mICI6Ii5Ib25lc3RseSwgY29tcGxleCBzZW50ZW5j
ZSBpcyB1bm5lY2Vzc2FyeS4gV2hlbiBJIHRyaWVkIHRvIG1vZGlmeSB0aGUgc2VudGVuY2Us
IEkgaWdub3JlIHRoZSBzdHJpY3QgZGlzdGluY3Rpb24gYmV0d2VlbiAiLiIgYW5kICI6Ii5J
biBzaG9ydCwgVGhpcyBtb2RpZmljYXRpb24gaXMgdW5uZWNlc3NhcnkuSSdtIHRlcnJpYmx5
IHNvcnJ5IGFib3V0IHRoYXQuNCkgVGhhbmtzLCBTaGVuZ2hvbmcgSGFuLS0tLS0tLS0tLS0t
LS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLUZyb206ICAiQWtpcmEgWW9rb3Nh
d2EiO0RhdGU6ICBTYXQsIEFwciAzMCwgMjAyMiAwMjo0MCBQTVRvOiAgIlNoZW5naG9uZyBI
YW4iOyAiSm9uYXRoYW4gQ29yYmV0IjsgQ2M6ICAiYWtwbSI7ICJiYWloYW93ZW4iOyAic2Vh
a2VlbCI7ICJsaW51eC1kb2MiOyAibGludXgta2VybmVsIjsgImNhb3lpeHVhbjIwMTkiOyAi
eWVqaWFqaWFuMjAxOCI7ICLlhq/ogIHluIgiOyBTdWJqZWN0OiAgUmU6IFtQQVRDSF0gRG9j
dW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJzdDogRml4IHN5bnRheCBlcnJvciBhbmQgRGVz
Y3JpYmUgZGV0YWlscyB1c2luZyB0YWJsZSBPbiAyMDIyLzA0LzMwIDM6MTksU2hlbmdob25n
IEhhbiB3cm90ZTo+IFNvbWUgc3ludGF4IGVycm9ycyBleGlzdCBpbiAicGFnZV9vd25lci5y
c3QiLiBUaGFua3MgdG8gQWtpcmEgWW9rb3Nhd2EgYW5kPiBIYW93ZW4gQmFpIGZvciB0aXBz
IHRvIGhlbHAgaW1wcm92ZSB0aGUgZG9jdW1lbnRhdGlvbi4+ID4gV2UgdHJ5IHRvIGZpeCB0
aGVtLiBIb3BlIHRoYXQgdGhlIERvY3VtZW50YXRpb24gaXMgc2hvd2VkIGFzIHdlIGV4cGVj
dC4+ID4gU2lnbmVkLW9mZi1ieTogU2hlbmdob25nIEhhbiA+IEZpeGVzOiBlZGM5M2FiYmNj
NmQgKCJ0b29scy92bS9wYWdlX293bmVyX3NvcnQuYzogc3VwcG9ydCBzb3J0aW5nIGJsb2Nr
cyBieSBtdWx0aXBsZSBrZXlzIik+ID4gLS0tPiBUaGFua3MgSm9uYXRoYW4ncyBzdWdnZXN0
aW9uLj4gPiBUaGlzIGZpeCBpcyBhIHNpbXBsZXIgdGhhbiBiZWZvcmUuPiBBbmQgeWVzLCBJ
dCBoYXMgYnVpbHQgaW4gbXkgbWFjaGluZS4+ID4gQmVzdCw+ID4gCVNoZW5naG9uZyBIYW4+
IC0tLT4gLS0tPiAgRG9jdW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJzdCB8IDE1ICsrKysr
KysrKystLS0tLT4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKT4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJz
dCBiL0RvY3VtZW50YXRpb24vdm0vcGFnZV9vd25lci5yc3Q+IGluZGV4IDI1NjIyYzcxNS4u
MGVjYjRhNzM5IDEwMDY0ND4gLS0tIGEvRG9jdW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJz
dD4gKysrIGIvRG9jdW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJzdD4gQEAgLTE3MSwxMSAr
MTcxLDEyIEBAIFVzYWdlPiAgPiAgU1RBTkRBUkQgRk9STUFUIFNQRUNJRklFUlM+ICA9PT09
PT09PT09PT09PT09PT09PT09PT09PT4gLTo6PiAgPiAtRm9yIC0tc29ydCBvcHRpb246PiAr
MSkgRm9yIC0tc29ydCBvcHRpb24uPiAgPiArCT09PT0JCT09PT09PT09PT0JPT09PT09PT09
PT0+ICAJS0VZCQlMT05HCQlERVNDUklQVElPTj4gKwk9PT09CQk9PT09PT09PT09CT09PT09
PT09PT09PiAgCXAJCXBpZAkJcHJvY2VzcyBJRD4gIAl0ZwkJdGdpZAkJdGhyZWFkIGdyb3Vw
IElEPiAgCW4JCW5hbWUJCXRhc2sgY29tbWFuZCBuYW1lPiBAQCAtMTgzLDE0ICsxODQsMTgg
QEAgRm9yIC0tc29ydCBvcHRpb246PiAgCVQJCXR4dAkJZnVsbCB0ZXh0IG9mIGJsb2NrPiAg
CWZ0CQlmcmVlX3RzCQl0aW1lc3RhbXAgb2YgdGhlIHBhZ2Ugd2hlbiBpdCB3YXMgcmVsZWFz
ZWQ+ICAJYXQJCWFsbG9jX3RzCXRpbWVzdGFtcCBvZiB0aGUgcGFnZSB3aGVuIGl0IHdhcyBh
bGxvY2F0ZWQ+IC0gICAgICAgIGF0b3IgICAgICAgICAgICBhbGxvY2F0b3IgICAgICAgbWVt
b3J5IGFsbG9jYXRvciBmb3IgcGFnZXM+ICsJYXRvcgkJYWxsb2NhdG9yCW1lbW9yeSBhbGxv
Y2F0b3IgZm9yIHBhZ2VzPiArCT09PT0JCT09PT09PT09PT0JPT09PT09PT09PT0+ICA+IC1G
b3IgLS1jdXJsIG9wdGlvbjo+ICsyKSBGb3IgLS1jdXJsIG9wdGlvbi4+ICA+ICsJPT09PQkJ
PT09PT09PT09PQk9PT09PT09PT09PT4gIAlLRVkJCUxPTkcJCURFU0NSSVBUSU9OPiArCT09
PT0JCT09PT09PT09PT0JPT09PT09PT09PT0+ICAJcAkJcGlkCQlwcm9jZXNzIElEPiAgCXRn
CQl0Z2lkCQl0aHJlYWQgZ3JvdXAgSUQ+ICAJbgkJbmFtZQkJdGFzayBjb21tYW5kIG5hbWU+
ICAJZgkJZnJlZQkJd2hldGhlciB0aGUgcGFnZSBoYXMgYmVlbiByZWxlYXNlZCBvciBub3Q+
ICAJc3QJCXN0YWNrdHJhY2UJc3RhY2sgdHJhY2Ugb2YgdGhlIHBhZ2UgYWxsb2NhdGlvbj4g
LSAgICAgICAgYXRvciAgICAgICAgICAgIGFsbG9jYXRvciAgICAgICBtZW1vcnkgYWxsb2Nh
dG9yIGZvciBwYWdlcz4gKwlhdG9yCQlhbGxvY2F0b3IJbWVtb3J5IGFsbG9jYXRvciBmb3Ig
cGFnZXM+ICsJPT09PQkJPT09PT09PT09PQk9PT09PT09PT09PVNvLCBJIGhhdmUgYWN0dWFs
bHkgdGVzdGVkIHRoaXMuQXJlIHlvdSBPSyB3aXRoIHRoZSBsb29rIG9mICAxKSBGb3IgLS1z
b3J0IG9wdGlvbi5hbmQgIDIpIEZvciAtLWN1cmwgb3B0aW9uLmluIGdlbmVyYXRlZCBIVE1M
IG9yIFBERiBkb2NzP0luIGxpdGVyYWwgYmxvY2tzLCB5b3Ugd291bGQgc2VlIGRvdWJsZSBk
YXNoZXMgb2YgIi0tIi5Ob3cgdGhleSBhcmUgY29udmVydGVkIHRvIHNvLWNhbGxlZCBlbmRh
c2gsIHdoaWNoIGlzIGEgc2luZ2xlIGRhc2hzbGlnaHRseSBsb25nZXIgdGhhbiBhIG5vcm1h
bCBoeXBoZW4uICBJdCBsb29rcyBjb25mdXNpbmcgdG8gbWUuVG8gcmVtZWR5IHRoaXMsIHlv
dSBuZWVkIGlubGluZSBsaXRlcmFsIG1hcmtlcnMgb2YgIDEpIEZvciBgYC0tc29ydGBgIG9w
dGlvbi5hbmQgIDIpIEZvciBgYC0tY3VybGBgIG9wdGlvbi5CeSB0aGUgd2F5LCB0aGlzIHBh
dGNoIGNoYW5nZXMgIjoiIHRvICIuIiBhdCB0aGUgZW5kIG9mIHRoZW0uQXJlIHRoZXkgaW50
ZW50aW9uYWwgY2hhbmdlcz8gIElmIHNvLCB3aHk/ICAgICAgICBUaGFua3MsIEFraXJh



