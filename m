Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315134DA78A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353005AbiCPBth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbiCPBtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:49:35 -0400
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7B340CB;
        Tue, 15 Mar 2022 18:48:20 -0700 (PDT)
Received: from IT-EXMB-1-123.meizu.com (172.16.1.123) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 16 Mar
 2022 09:48:19 +0800
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by
 IT-EXMB-1-123.meizu.com (172.16.1.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 16 Mar 2022 09:48:18 +0800
Received: from IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575]) by
 IT-EXMB-1-125.meizu.com ([fe80::7481:7d92:3801:4575%3]) with mapi id
 15.01.2308.014; Wed, 16 Mar 2022 09:48:18 +0800
From:   =?gb2312?B?sNe6xs7E?= <baihaowen@meizu.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        "freude@linux.ibm.com" <freude@linux.ibm.com>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "gor@linux.ibm.com" <gor@linux.ibm.com>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>
CC:     "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyXSBzMzkwOiBjcnlwdG86IFVzZSBtaW4oKSBpbnN0?=
 =?gb2312?Q?ead_of_doing_it_manually?=
Thread-Topic: [PATCH v2] s390: crypto: Use min() instead of doing it manually
Thread-Index: AQHYOELSbEbPEn7rqU+2mKCQuuOLcqy/sb0AgAGNOSc=
Date:   Wed, 16 Mar 2022 01:48:18 +0000
Message-ID: <9291974f2d914f68b037d79f7fe505e2@meizu.com>
References: <1647331264-13853-1-git-send-email-baihaowen@meizu.com>,<cc26b079f808420592cfea19580e34f5@AcuMS.aculab.com>
In-Reply-To: <cc26b079f808420592cfea19580e34f5@AcuMS.aculab.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.137.70]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aGksIERhdmlkDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSwgYWxsIGlzIG9rLCBqdXN0IGEg
Y29kaW5nIHN0eWxlLg0KSWdub3JlIG15IHBhdGNoLg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXw0Kt6K8/sjLOiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VM
QUIuQ09NPg0Kt6LLzcqxvOQ6IDIwMjLE6jPUwjE1yNUgMTg6MDU6MjQNCsrVvP7IyzogsNe6xs7E
OyBmcmV1ZGVAbGludXguaWJtLmNvbTsgaGNhQGxpbnV4LmlibS5jb207IGdvckBsaW51eC5pYm0u
Y29tOyBhZ29yZGVldkBsaW51eC5pYm0uY29tDQqzrcvNOiBsaW51eC1zMzkwQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K1vfM4jogUkU6IFtQQVRDSCB2Ml0g
czM5MDogY3J5cHRvOiBVc2UgbWluKCkgaW5zdGVhZCBvZiBkb2luZyBpdCBtYW51YWxseQ0KDQpG
cm9tOiBIYW93ZW4gQmFpDQo+IFNlbnQ6IDE1IE1hcmNoIDIwMjIgMDg6MDENCj4NCj4gRml4IGZv
bGxvd2luZyBjb2NjaWNoZWNrIHdhcm5pbmc6DQo+IGRyaXZlcnMvczM5MC9jcnlwdG8vemNyeXB0
X2VwMTFtaXNjLmM6MTExMjoyNS0yNjogV0FSTklORyBvcHBvcnR1bml0eSBmb3IgbWluKCkNCj4N
Cj4gU2lnbmVkLW9mZi1ieTogSGFvd2VuIEJhaSA8YmFpaGFvd2VuQG1laXp1LmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL3MzOTAvY3J5cHRvL3pjcnlwdF9lcDExbWlzYy5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3MzOTAvY3J5cHRvL3pjcnlwdF9lcDExbWlzYy5jIGIvZHJpdmVycy9zMzkw
L2NyeXB0by96Y3J5cHRfZXAxMW1pc2MuYw0KPiBpbmRleCA5Y2U1YTcxLi5iYjJhNTI3IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3MzOTAvY3J5cHRvL3pjcnlwdF9lcDExbWlzYy5jDQo+ICsrKyBi
L2RyaXZlcnMvczM5MC9jcnlwdG8vemNyeXB0X2VwMTFtaXNjLmMNCj4gQEAgLTExMDksNyArMTEw
OSw3IEBAIHN0YXRpYyBpbnQgZXAxMV93cmFwa2V5KHUxNiBjYXJkLCB1MTYgZG9tYWluLA0KPiAg
ICAgICBpZiAoa2ItPmhlYWQudHlwZSA9PSBUT0tUWVBFX05PTl9DQ0EgJiYNCj4gICAgICAgICAg
IGtiLT5oZWFkLnZlcnNpb24gPT0gVE9LVkVSX0VQMTFfQUVTKSB7DQo+ICAgICAgICAgICAgICAg
aGFzX2hlYWRlciA9IHRydWU7DQo+IC0gICAgICAgICAgICAga2V5c2l6ZSA9IGtiLT5oZWFkLmxl
biA8IGtleXNpemUgPyBrYi0+aGVhZC5sZW4gOiBrZXlzaXplOw0KPiArICAgICAgICAgICAgIGtl
eXNpemUgPSBtaW4oKHNpemVfdClrYi0+aGVhZC5sZW4sIGtleXNpemUpOw0KDQpJJ20gc3VyZSB0
aGF0IHdvdWxkIGxvb2sgYmV0dGVyIGFzOg0KICAgICAgICAgICAgICAgIGlmIChrZXlzaXplID4g
a2ItPmhlYWQubGVuKQ0KICAgICAgICAgICAgICAgICAgICAgICAga2V5c2l6ZSA9IGtiLT5oZWFk
LmxlbjsNCndoaWNoIG1ha2VzIGl0IG11Y2ggbW9yZSBvYnZpb3VzIHRoYXQgdGhlIGV4aXN0aW5n
IHZhbHVlDQppcyBiZWluZyBsaW1pdGVkIGJ5IGEgbmV3IGJvdW5kLg0KDQogICAgICAgIERhdmlk
DQoNCj4gICAgICAgfQ0KPg0KPiAgICAgICAvKiByZXF1ZXN0IGNwcmIgYW5kIHBheWxvYWQgKi8N
Cj4gLS0NCj4gMi43LjQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5
IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRp
b24gTm86IDEzOTczODYgKFdhbGVzKQ0KDQo=
