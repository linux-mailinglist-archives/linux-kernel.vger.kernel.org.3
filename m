Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47429581D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiG0CIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiG0CIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:08:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F9D31395;
        Tue, 26 Jul 2022 19:08:00 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lsxv96chkzkXtx;
        Wed, 27 Jul 2022 10:05:25 +0800 (CST)
Received: from dggpeml500007.china.huawei.com (7.185.36.75) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 10:07:58 +0800
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500007.china.huawei.com (7.185.36.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 10:07:58 +0800
Received: from dggpeml500005.china.huawei.com ([7.185.36.59]) by
 dggpeml500005.china.huawei.com ([7.185.36.59]) with mapi id 15.01.2375.024;
 Wed, 27 Jul 2022 10:07:58 +0800
From:   chenxingdi <chenxingdi@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chunkeey@googlemail.com" <chunkeey@googlemail.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSB1c2I6IHJlbmVzYXMteGhjaTogVXNlIHBy?=
 =?gb2312?Q?=5Finfo_while_fw_verify_success?=
Thread-Topic: [PATCH -next] usb: renesas-xhci: Use pr_info while fw verify
 success
Thread-Index: AQHYoLWpFBjmP7RVKUWD9Qj5rHB24K2QWGuAgAEeAjA=
Date:   Wed, 27 Jul 2022 02:07:57 +0000
Message-ID: <30a7a7e3a74b4b169ba47e100be44ee8@huawei.com>
References: <20220726060509.20748-1-chenxingdi@huawei.com>
 <YuAbm09hv4ZGXIw5@kroah.com>
In-Reply-To: <YuAbm09hv4ZGXIw5@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.218]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIGFkdmljZSwgSSB3aWxsIGRlbGV0ZSB0aGUgbG9nIGFuZCBzZW5kIGEg
bmV3IHBhdGNoLiANCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IEdyZWcgS0ggPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPiANCreiy83KsbzkOiAyMDIyxOo31MIyN8jVIDA6NTINCsrV
vP7IyzogY2hlbnhpbmdkaSA8Y2hlbnhpbmdkaUBodWF3ZWkuY29tPg0Ks63LzTogbWF0aGlhcy5u
eW1hbkBpbnRlbC5jb207IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGNodW5rZWV5QGdvb2dsZW1haWwuY29tDQrW98ziOiBSZTogW1BBVENI
IC1uZXh0XSB1c2I6IHJlbmVzYXMteGhjaTogVXNlIHByX2luZm8gd2hpbGUgZncgdmVyaWZ5IHN1
Y2Nlc3MNCg0KT24gVHVlLCBKdWwgMjYsIDIwMjIgYXQgMDI6MDU6MDlQTSArMDgwMCwgQ2hlbiBY
aW5nZGkgd3JvdGU6DQo+IFdoaWxlIGZ3IHZlcmlmeSBzdWNjZXNzLCBpdCBpcyBjb25mdXNlZCB0
byBwcmludCBhbiBlcnJvciBsb2cgd2hpY2ggaXMgDQo+IGFjdHVhbGx5IG5vdCBhbiBlcnJvciwg
c28gdXNlIHByX2luZm8gdG8gcHJpbnQgZmlybXdhcmUgdmVyc2lvbiANCj4gaW5zdGVhZCBvZiBw
cl9lcnIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFhpbmdkaSA8Y2hlbnhpbmdkaUBodWF3
ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2ktcmVuZXNhcy5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXBjaS1yZW5lc2FzLmMgDQo+
IGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXBjaS1yZW5lc2FzLmMNCj4gaW5kZXggNTI1OTlkOTY2
MzRmLi4xZWIxZDg2M2Q1NDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1w
Y2ktcmVuZXNhcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2ktcmVuZXNhcy5j
DQo+IEBAIC0xNTEsNyArMTUxLDcgQEAgc3RhdGljIGludCByZW5lc2FzX2Z3X3ZlcmlmeShjb25z
dCB2b2lkICpmd19kYXRhLA0KPiAgCX0NCj4gIA0KPiAgCWZ3X3ZlcnNpb24gPSBnZXRfdW5hbGln
bmVkX2xlMTYoZndfZGF0YSArIGZ3X3ZlcnNpb25fcG9pbnRlcik7DQo+IC0JcHJfZXJyKCJnb3Qg
ZmlybXdhcmUgdmVyc2lvbjogJTAyeC4iLCBmd192ZXJzaW9uKTsNCj4gKwlwcl9pbmZvKCJnb3Qg
ZmlybXdhcmUgdmVyc2lvbjogJTAyeC4iLCBmd192ZXJzaW9uKTsNCg0KV2h5IHByaW50IGFueXRo
aW5nIGF0IGFsbD8gIFdoZW4gZHJpdmVycyBhcmUgd29ya2luZyBwcm9wZXJseSwgdGhleSBzaG91
bGQgYmUgcXVpZXQuICBXaG8gcmVsaWVzIG9uIHRoaXMgbWVzc2FnZSBiZWluZyBzZW50IHRvIHRo
ZSBrZXJuZWwgbG9nPw0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=
