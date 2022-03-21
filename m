Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3DA4E207C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344541AbiCUGMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiCUGMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:12:33 -0400
Received: from mail.meizu.com (unknown [14.29.68.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866766CB5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:11:07 -0700 (PDT)
Received: from IT-EXMB-1-123.meizu.com (172.16.1.123) by mz-mail04.meizu.com
 (172.16.1.16) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 21 Mar
 2022 14:11:08 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-123.meizu.com (172.16.1.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Mar 2022 14:11:05 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Mon, 21 Mar 2022 14:11:05 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     Jiri Slaby <jirislaby@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "elder@linaro.org" <elder@linaro.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
CC:     "johan@kernel.org" <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSB0cnk6IHN5bmNsaW5rX2NzOiBVc2UgYml0d2lzZSBp?=
 =?gb2312?Q?nstead_of_arithmetic_operator_for_flags?=
Thread-Topic: [PATCH] try: synclink_cs: Use bitwise instead of arithmetic
 operator for flags
Thread-Index: AQHYPNBZEhoykAqSLkulA+PKC4psb6zI0vCAgACH/2Y=
Date:   Mon, 21 Mar 2022 06:11:05 +0000
Message-ID: <605e037edcdb403d99427ad66a203860@meizu.com>
References: <1647831852-28973-1-git-send-email-baihaowen@meizu.com>,<c7e6ca16-87a6-dbff-a2ad-852671b81b84@kernel.org>
In-Reply-To: <c7e6ca16-87a6-dbff-a2ad-852671b81b84@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIHNpcg0KDQpPaywgdGhhbmsgeW91IGZvciB5b3VyIHJlbWluZGVyLg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBKaXJpIFNsYWJ5IDxqaXJpc2xh
YnlAa2VybmVsLm9yZz4NCreiy83KsbzkOiAyMDIyxOoz1MIyMcjVIDE0OjAzOjA5DQrK1bz+yMs6
ILDXusbOxDsgYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IGRzdGVy
YmFAc3VzZS5jb207IGVsZGVyQGxpbmFyby5vcmc7IGpjbXZia2JjQGdtYWlsLmNvbQ0Ks63LzTog
am9oYW5Aa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6
IFtQQVRDSF0gdHJ5OiBzeW5jbGlua19jczogVXNlIGJpdHdpc2UgaW5zdGVhZCBvZiBhcml0aG1l
dGljIG9wZXJhdG9yIGZvciBmbGFncw0KDQpIaSwNCg0KdGhlICRTVUJKIHNheXM6DQoNCiJ0cnk6
IHN5bmNsaW5rX2NzOiAuLi4iDQoNCmJ1dCB5b3UgYWN0dWFsbHkgbWVhbnQgInR0eToiLg0KDQpP
biAyMS4gMDMuIDIyLCA0OjA0LCBIYW93ZW4gQmFpIHdyb3RlOg0KPiBUaGlzIHNpbGVuY2VzIHRo
ZSBmb2xsb3dpbmcgY29jY2luZWxsZSB3YXJuaW5nOg0KPiBkcml2ZXJzL3MzOTAvY2hhci90YXBl
XzM0eHguYzozNjA6MzgtMzk6IFdBUk5JTkc6IHN1bSBvZiBwcm9iYWJsZSBiaXRtYXNrcywgY29u
c2lkZXIgfA0KPg0KPiB3ZSB3aWxsIHRyeSB0byBtYWtlIGNvZGUgY2xlYW5lcg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBIYW93ZW4gQmFpIDxiYWloYW93ZW5AbWVpenUuY29tPg0KPiAtLS0NCj4gICBk
cml2ZXJzL2NoYXIvcGNtY2lhL3N5bmNsaW5rX2NzLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2NoYXIvcGNtY2lhL3N5bmNsaW5rX2NzLmMgYi9kcml2ZXJzL2NoYXIvcGNtY2lhL3N5bmNs
aW5rX2NzLmMNCj4gaW5kZXggNzhiYWJhNS4uZTZmMjE4NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9jaGFyL3BjbWNpYS9zeW5jbGlua19jcy5jDQo+ICsrKyBiL2RyaXZlcnMvY2hhci9wY21jaWEv
c3luY2xpbmtfY3MuYw0KPiBAQCAtOTIyLDcgKzkyMiw3IEBAIHN0YXRpYyB2b2lkIHJ4X3JlYWR5
X2FzeW5jKE1HU0xQQ19JTkZPICppbmZvLCBpbnQgdGNkKQ0KPiAgICAgICAgICAgICAgIC8vIEJJ
VDc6cGFyaXR5IGVycm9yDQo+ICAgICAgICAgICAgICAgLy8gQklUNjpmcmFtaW5nIGVycm9yDQo+
DQo+IC0gICAgICAgICAgICAgaWYgKHN0YXR1cyAmIChCSVQ3ICsgQklUNikpIHsNCj4gKyAgICAg
ICAgICAgICBpZiAoc3RhdHVzICYgKEJJVDcgfCBCSVQ2KSkgew0KPiAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHN0YXR1cyAmIEJJVDcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGljb3VudC0+cGFyaXR5Kys7DQo+ICAgICAgICAgICAgICAgICAgICAgICBlbHNlDQoNCg0KLS0N
CmpzDQpzdXNlIGxhYnMNCg==
