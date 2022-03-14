Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268344D790E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiCNBNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiCNBNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:13:31 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50AA7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 18:12:19 -0700 (PDT)
Received: from IT-EXMB-1-126.meizu.com (172.16.1.126) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 14 Mar
 2022 09:12:17 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-126.meizu.com (172.16.1.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 14 Mar 2022 09:12:16 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Mon, 14 Mar 2022 09:12:16 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "vireshk@kernel.org" <vireshk@kernel.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "elder@kernel.org" <elder@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzdGFnaW5nOiBncmV5YnVzOiBGaXggcG90ZW50aWFs?=
 =?gb2312?Q?_NULL_dereference?=
Thread-Topic: [PATCH] staging: greybus: Fix potential NULL dereference
Thread-Index: AQHYNSL4iVqrOrm/80ClDX0ZeDDii6y5huUAgASPw4I=
Date:   Mon, 14 Mar 2022 01:12:16 +0000
Message-ID: <5bbec145aa454874a8ae45091e26c3ca@meizu.com>
References: <1646987730-7597-1-git-send-email-baihaowen@meizu.com>,<20220311113208.GK3293@kadam>
In-Reply-To: <20220311113208.GK3293@kadam>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQq3orz+yMs6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3Jh
Y2xlLmNvbT4NCreiy83KsbzkOiAyMDIyxOoz1MIxMcjVIDE5OjMyOjA4DQrK1bz+yMs6ILDXusbO
xA0Ks63LzTogdmlyZXNoa0BrZXJuZWwub3JnOyBqb2hhbkBrZXJuZWwub3JnOyBlbGRlckBrZXJu
ZWwub3JnOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbGludXgtc3RhZ2luZ0BsaXN0cy5s
aW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBbUEFUQ0hd
IHN0YWdpbmc6IGdyZXlidXM6IEZpeCBwb3RlbnRpYWwgTlVMTCBkZXJlZmVyZW5jZQ0KDQpPbiBG
cmksIE1hciAxMSwgMjAyMiBhdCAwNDozNTozMFBNICswODAwLCBIYW93ZW4gQmFpIHdyb3RlOg0K
PiBGaXggZm9sbG93aW5nIGNvY2NpY2hlY2sgd2FybmluZzoNCj4gZHJpdmVycy9zdGFnaW5nL2dy
ZXlidXMvYm9vdHJvbS5jOjMwMTozNS0zOTogRVJST1I6IGZ3IGlzIE5VTEwgYnV0IGRlcmVmZXJl
bmNlZC4NCj4NCj4gV2hlbiBnb3RvIHF1ZXVlX3dvcmsgYnV0IGRlcmVmZXJlbmNlIFVuaW5pdGlh
bGl6ZWQgZncgd2lsbCB0cmlnZ2VyIGEgTlVMTA0KPiBkZXJlZmVyZW5jZS4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogSGFvd2VuIEJhaSA8YmFpaGFvd2VuQG1laXp1LmNvbT4NCg0KWW91ciBwYXRjaCBj
bGFpbXMgdG8gZml4IGEgYnVnLCBidXQgdGhlIHdhcm5pbmcgaXMgYSBmYWxzZSBwb3NpdGl2ZS4N
CldoZW4gd2UgImdvdG8gcXVldWVfd29yazsiIHRoZW4gInJldCA9IC1FSU5WQUwiIHNvIHRoYXQg
bWVhbnMgdGhhdCB3ZQ0Kd2lsbCBub3QgZGVyZWZlcmVuY2UgImZ3Ii4NCg0KWW91IHNob3VsZCBp
Z25vcmUgZmFsc2UgcG9zaXRpdmUgd2FybmluZ3MuDQoNCldlIHdvdWxkIGFwcGx5IHRoZSBwYXRj
aCBvbmx5IGlmIGl0IG1hZGUgdGhlIGNvZGUgbW9yZSByZWFkYWJsZSBidXQgSQ0KZG8gbm90IHRo
aW5rIHRoYXQgaXMgdGhlIGNhc2UgaGVyZS4gIEkgZG8gbm90IHJlYWxseSBldmVuIHNlZSBob3cg
dGhlDQpwYXRjaCBzaWxlbmNlcyB0aGUgZmFsc2UgcG9zaXRpdmUgd2FybmluZywgYnV0IGl0IG1h
eSBkby4uLg0KDQpBbnl3YXksIHRoZSBwb2ludCBpczogIEZhbHNlIHBvc2l0aXZlLiAgSWdub3Jl
IGl0Lg0KDQpyZWdhcmRzLA0KZGFuIGNhcnBlbnRlcg0KDQo=
