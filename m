Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94B515C3E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiD3K3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiD3K3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:29:07 -0400
X-Greylist: delayed 61554 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Apr 2022 03:25:38 PDT
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037332C67A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:25:35 -0700 (PDT)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: Xs7QaUu06a2lj95B5oQFRrsICijAH5lskblvcoVIxFiZWt9b/ijJkh6MlehDr
        5AGDedKCGkcVASAik5h1HcdfH5H2SGIPzFLKjXUoVbDc+8RNgqtLqbQyFO/KOSBQDN5e13M
        LbIq4rIBUuq6y9c1xlqgbQOrO5ZnIibckKIQE1khKjbDYqDQNjF6E8XSif5XADY5w7I9QdK
        ry7ONUBRdF/j28iktSQsFBLoB5nJSTsyQZPXcbBou96C3bNXx+tF4Iy+vkYomwAcJGK75mH
        5LwgoKEyRxY64mCyAU5ZtiMb0M7se4b5uo+9uGKHlyl9wCRGQyicQEkyZCS453FUoht5IkP
        WY8Xgv1vPDyT0rNqTc0FY7E4sOUJv36hPMGLvXdR34F5041G9mrgw7jDwO3cK8S3Znn25SH
        4bNAzFDbdmCPQZ6xyuiMeQ==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 218.17.66.222
X-QQ-STYLE: 
X-QQ-mid: llogic72t1651314329t6396239
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
        "=?utf-8?B?eXVob25nZg==?=" <yuhongf@szu.edu.cn>
Subject: Resend: [PATCH] Documentation/vm/page_owner.rst: Fix syntax error and Describe details using table
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 30 Apr 2022 18:25:29 +0800
X-Priority: 3
Message-ID: <tencent_640F24F90BA09A5302AA9BD7@qq.com>
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
        id ; Sat, 30 Apr 2022 18:25:31 +0800 (CST)
Feedback-ID: llogic:email.szu.edu.cn:qybgforeign:qybgforeign9
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIG9uZSByZXBseSBhcmNoaXZlZCBhdCAiaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtZG9jL3RlbmNlbnRfMDg4NzYzRjM1Q0UyMzNGQjZDOUNFQjgwQHFxLmNvbS8iKE9uIDIw
MjIvMDQvMzAgMTY6MTMpIGlzIGJyb2tlbi1sb29raW5nLiANCg0KQXBvbG9naXplIGZvciB0
aGF0IQ0KDQpSZXNlbmQgdGhhdCByZXBseToNCg0KMCkgSWYgeW91IGhhdmUgcmVjZWl2ZWQg
YSBzaW1pbGFyIHJlcGx5LCBwbGVhc2UgcmVmZXIgdG8gdGhlIGxhdGVzdCByZXBseS4NCg0K
MSkgQWNjaWRlbnRhbGx5IHVzZWQgQ2hpbmVzZSBJbnB1dCBNZXRob2QgRWRpdG9yLCBsZWF2
aW5nIGZ1bGwtd2lkdGggc3ltYm9scyBkdXJpbmcgdGhlIHRlc3QsIGNhdXNpbmcgdGhlIGRv
dWJsZSBkYXNoZXMgb2YgIi0tIiBjaGFuZ2VkIGludG8gImxvbmcgc2luZ2xlIGRhc2giIHdo
aWNoIHNob3VsZCBub3QgaGF2ZSBvY2N1cnJlZC4NCg0KMikgSW4gdGhlIGN1cnJlbnQgZG9j
dW1lbnQsIHRoZSAiU1RBTkRBUkQgRk9STUFUIFNQRUNJRklFUlMiIHRhYmxlIGRvZXMgbm90
IGNvcnJlY3RseSB1c2UgdGhlIGZvcm1hdCBvZiB0aGUgcnN0IGRvY3VtZW50LCBzbyBpbiB0
aGUgd2Vic2l0ZSBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC92bS9w
YWdlX293bmVyLmh0bWwsIGl0IGRvZXMgbm90IGxvb2sgZ29vZC4gVGhlcmVmb3JlLCB0aGUg
IlNUQU5EQVJEIEZPUk1BVCBTUEVDSUZJRVJTIiBoYXMgYmVlbiBhZGp1c3RlZCB1c2luZyB0
aGUgZm9ybWF0IG9mIHRoZSByc3QgdGFibGUuICpUaGlzKiBpcyB0aGUgbWFpbiBwdXJwb3Nl
Lg0KDQozKSBJbiB2ZXJzaW9uIDEgYmVmb3JlKE9uIDIwMjIvMDQvMzAgMToxOSksIHRoZSBz
ZW50ZW5jZSBsb29rIGxpa2U6IlRhYmxlIDEgeHh4KHNvbWUgZXhwbGFpbmF0aW9uKS4iIGFu
ZCAiVGFibGUgMiB4eHgoc29tZSBleHBsYWluYXRpb24pLiIsIGluIHRoZXNlIDIgImxvbmci
IHNlbnRlbmNlcywgdXNpbmcgIi4iIGluc3RlYWQgb2YgIjoiLkhvbmVzdGx5LCBjb21wbGV4
IHNlbnRlbmNlIGlzIHVubmVjZXNzYXJ5LiBXaGVuIEkgdHJpZWQgdG8gbW9kaWZ5IHRoZSBz
ZW50ZW5jZSwgSSBpZ25vcmUgdGhlIHN0cmljdCBkaXN0aW5jdGlvbiBiZXR3ZWVuICIuIiBh
bmQgIjoiLkluIHNob3J0LCBUaGlzIG1vZGlmaWNhdGlvbiBpcyB1bm5lY2Vzc2FyeS4NCg0K
NCkgQXBvbG9naXplIGFnYWluIGZvciB0aGUgdHJvdWJsZXMgdGhhdCBteSBjbHVtc3kgYmVo
YXZpb3JzIGhhdmUgY2F1c2VkLg0KDQpUaGFua3MsIA0KDQpTaGVuZ2hvbmcgSGFuDQogDQot
LS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAg
IkFraXJhIFlva29zYXdhIjxha2l5a3NAZ21haWwuY29tPjsNCkRhdGU6ICBTYXQsIEFwciAz
MCwgMjAyMiAwMjo0MCBQTQ0KVG86ICAiU2hlbmdob25nIEhhbiI8aGFuc2hlbmdob25nMjAx
OUBlbWFpbC5zenUuZWR1LmNuPjsgIkpvbmF0aGFuIENvcmJldCI8Y29yYmV0QGx3bi5uZXQ+
Ow0KQ2M6ICAiYWtwbSI8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47ICJiYWloYW93ZW4i
PGJhaWhhb3dlbkBtZWl6dS5jb20+OyAic2Vha2VlbCI8c2Vha2VlbEBnbWFpbC5jb20+OyAi
bGludXgtZG9jIjxsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnPjsgImxpbnV4LWtlcm5lbCI8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47ICJjYW95aXh1YW4yMDE5IjxjYW95aXh1
YW4yMDE5QGVtYWlsLnN6dS5lZHUuY24+OyAieWVqaWFqaWFuMjAxOCI8eWVqaWFqaWFuMjAx
OEBlbWFpbC5zenUuZWR1LmNuPjsgInl1aG9uZ2YiPHl1aG9uZ2ZAc3p1LmVkdS5jbj47DQpT
dWJqZWN0OiAgUmU6IFtQQVRDSF0gRG9jdW1lbnRhdGlvbi92bS9wYWdlX293bmVyLnJzdDog
Rml4IHN5bnRheCBlcnJvciBhbmQgRGVzY3JpYmUgZGV0YWlscyB1c2luZyB0YWJsZQ0KIA0K
T24gMjAyMi8wNC8zMCAzOjE5LA0KU2hlbmdob25nIEhhbiB3cm90ZToNCj4gU29tZSBzeW50
YXggZXJyb3JzIGV4aXN0IGluICJwYWdlX293bmVyLnJzdCIuIFRoYW5rcyB0byBBa2lyYSBZ
b2tvc2F3YSBhbmQNCj4gSGFvd2VuIEJhaSBmb3IgdGlwcyB0byBoZWxwIGltcHJvdmUgdGhl
IGRvY3VtZW50YXRpb24uDQo+DQo+IFdlIHRyeSB0byBmaXggdGhlbS4gSG9wZSB0aGF0IHRo
ZSBEb2N1bWVudGF0aW9uIGlzIHNob3dlZCBhcyB3ZSBleHBlY3QuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IFNoZW5naG9uZyBIYW4gPGhhbnNoZW5naG9uZzIwMTlAZW1haWwuc3p1LmVkdS5j
bj4NCj4gRml4ZXM6IGVkYzkzYWJiY2M2ZCAoInRvb2xzL3ZtL3BhZ2Vfb3duZXJfc29ydC5j
OiBzdXBwb3J0IHNvcnRpbmcgYmxvY2tzIGJ5IG11bHRpcGxlIGtleXMiKQ0KPg0KPiAtLS0N
Cj4gVGhhbmtzIEpvbmF0aGFuJ3Mgc3VnZ2VzdGlvbi4NCj4NCj4gVGhpcyBmaXggaXMgYSBz
aW1wbGVyIHRoYW4gYmVmb3JlLg0KPiBBbmQgeWVzLCBJdCBoYXMgYnVpbHQgaW4gbXkgbWFj
aGluZS4NCj4NCj4gQmVzdCwNCj4NCj4gU2hlbmdob25nIEhhbg0KPiAtLS0NCj4gLS0tDQo+
ICBEb2N1bWVudGF0aW9uL3ZtL3BhZ2Vfb3duZXIucnN0IHwgMTUgKysrKysrKysrKy0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdm0vcGFnZV9vd25lci5yc3QgYi9E
b2N1bWVudGF0aW9uL3ZtL3BhZ2Vfb3duZXIucnN0DQo+IGluZGV4IDI1NjIyYzcxNS4uMGVj
YjRhNzM5IDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZtL3BhZ2Vfb3duZXIucnN0
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vdm0vcGFnZV9vd25lci5yc3QNCj4gQEAgLTE3MSwx
MSArMTcxLDEyIEBAIFVzYWdlDQo+IA0KPiAgU1RBTkRBUkQgRk9STUFUIFNQRUNJRklFUlMN
Cj4gID09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC06Og0KPiANCj4gLUZvciAtLXNv
cnQgb3B0aW9uOg0KPiArMSkgRm9yIC0tc29ydCBvcHRpb24uDQo+IA0KPiArID09PT0gPT09
PT09PT09PSA9PT09PT09PT09PQ0KPiAgS0VZIExPTkcgREVTQ1JJUFRJT04NCj4gKyA9PT09
ID09PT09PT09PT0gPT09PT09PT09PT0NCj4gIHAgcGlkIHByb2Nlc3MgSUQNCj4gIHRnIHRn
aWQgdGhyZWFkIGdyb3VwIElEDQo+ICBuIG5hbWUgdGFzayBjb21tYW5kIG5hbWUNCj4gQEAg
LTE4MywxNCArMTg0LDE4IEBAIEZvciAtLXNvcnQgb3B0aW9uOg0KPiAgVCB0eHQgZnVsbCB0
ZXh0IG9mIGJsb2NrDQo+ICBmdCBmcmVlX3RzIHRpbWVzdGFtcCBvZiB0aGUgcGFnZSB3aGVu
IGl0IHdhcyByZWxlYXNlZA0KPiAgYXQgYWxsb2NfdHMgdGltZXN0YW1wIG9mIHRoZSBwYWdl
IHdoZW4gaXQgd2FzIGFsbG9jYXRlZA0KPiAtICAgICAgICBhdG9yICAgICAgICAgICAgYWxs
b2NhdG9yICAgICAgIG1lbW9yeSBhbGxvY2F0b3IgZm9yIHBhZ2VzDQo+ICsgYXRvciBhbGxv
Y2F0b3IgbWVtb3J5IGFsbG9jYXRvciBmb3IgcGFnZXMNCj4gKyA9PT09ID09PT09PT09PT0g
PT09PT09PT09PT0NCj4gDQo+IC1Gb3IgLS1jdXJsIG9wdGlvbjoNCj4gKzIpIEZvciAtLWN1
cmwgb3B0aW9uLg0KPiANCj4gKyA9PT09ID09PT09PT09PT0gPT09PT09PT09PT0NCj4gIEtF
WSBMT05HIERFU0NSSVBUSU9ODQo+ICsgPT09PSA9PT09PT09PT09ID09PT09PT09PT09DQo+
ICBwIHBpZCBwcm9jZXNzIElEDQo+ICB0ZyB0Z2lkIHRocmVhZCBncm91cCBJRA0KPiAgbiBu
YW1lIHRhc2sgY29tbWFuZCBuYW1lDQo+ICBmIGZyZWUgd2hldGhlciB0aGUgcGFnZSBoYXMg
YmVlbiByZWxlYXNlZCBvciBub3QNCj4gIHN0IHN0YWNrdHJhY2Ugc3RhY2sgdHJhY2Ugb2Yg
dGhlIHBhZ2UgYWxsb2NhdGlvbg0KPiAtICAgICAgICBhdG9yICAgICAgICAgICAgYWxsb2Nh
dG9yICAgICAgIG1lbW9yeSBhbGxvY2F0b3IgZm9yIHBhZ2VzDQo+ICsgYXRvciBhbGxvY2F0
b3IgbWVtb3J5IGFsbG9jYXRvciBmb3IgcGFnZXMNCj4gKyA9PT09ID09PT09PT09PT0gPT09
PT09PT09PT0NCg0KU28sIEkgaGF2ZSBhY3R1YWxseSB0ZXN0ZWQgdGhpcy4NCg0KQXJlIHlv
dSBPSyB3aXRoIHRoZSBsb29rIG9mDQoNCiAgMSkgRm9yIC0tc29ydCBvcHRpb24uDQoNCmFu
ZA0KDQogIDIpIEZvciAtLWN1cmwgb3B0aW9uLg0KDQppbiBnZW5lcmF0ZWQgSFRNTCBvciBQ
REYgZG9jcz8NCg0KSW4gbGl0ZXJhbCBibG9ja3MsIHlvdSB3b3VsZCBzZWUgZG91YmxlIGRh
c2hlcyBvZiAiLS0iLg0KTm93IHRoZXkgYXJlIGNvbnZlcnRlZCB0byBzby1jYWxsZWQgZW5k
YXNoLCB3aGljaCBpcyBhIHNpbmdsZSBkYXNoDQpzbGlnaHRseSBsb25nZXIgdGhhbiBhIG5v
cm1hbCBoeXBoZW4uICBJdCBsb29rcyBjb25mdXNpbmcgdG8gbWUuDQoNClRvIHJlbWVkeSB0
aGlzLCB5b3UgbmVlZCBpbmxpbmUgbGl0ZXJhbCBtYXJrZXJzIG9mDQoNCiAgMSkgRm9yIGBg
LS1zb3J0YGAgb3B0aW9uLg0KDQphbmQNCg0KICAyKSBGb3IgYGAtLWN1cmxgYCBvcHRpb24u
DQoNCg0KQnkgdGhlIHdheSwgdGhpcyBwYXRjaCBjaGFuZ2VzICI6IiB0byAiLiIgYXQgdGhl
IGVuZCBvZiB0aGVtLg0KQXJlIHRoZXkgaW50ZW50aW9uYWwgY2hhbmdlcz8gIElmIHNvLCB3
aHk/DQoNCiAgICAgICAgVGhhbmtzLCBBa2lyYQ==



