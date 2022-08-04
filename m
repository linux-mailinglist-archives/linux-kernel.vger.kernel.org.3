Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039B0589B75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbiHDMIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 08:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239565AbiHDMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:08:38 -0400
Received: from spam.unicloud.com (gw.haihefund.cn [220.194.70.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC0A51A0E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 05:08:25 -0700 (PDT)
Received: from eage.unicloud.com ([220.194.70.35])
        by spam.unicloud.com with ESMTP id 274C7r4m014658;
        Thu, 4 Aug 2022 20:07:53 +0800 (GMT-8)
        (envelope-from luofei@unicloud.com)
Received: from zgys-ex-mb09.Unicloud.com (10.10.0.24) by
 zgys-ex-mb10.Unicloud.com (10.10.0.6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Thu, 4 Aug 2022 20:07:53 +0800
Received: from zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa]) by
 zgys-ex-mb09.Unicloud.com ([fe80::eda0:6815:ca71:5aa%16]) with mapi id
 15.01.2375.017; Thu, 4 Aug 2022 20:07:53 +0800
From:   =?gb2312?B?wt63yQ==?= <luofei@unicloud.com>
To:     "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBtbSwgaHdwb2lzb24sIGh1Z2V0bGI6IENoZWNrIGh1?=
 =?gb2312?B?Z2V0bGIgaGVhZCBwYWdlIGh3cG9pc29uIGZsYWcgd2hlbiB1bnBvaXNvbiBw?=
 =?gb2312?Q?age?=
Thread-Topic: [PATCH] mm, hwpoison, hugetlb: Check hugetlb head page hwpoison
 flag when unpoison page
Thread-Index: AQHYp/YA2P+b2sgj8UGtO/UrSrrbAq2epYGn
Date:   Thu, 4 Aug 2022 12:07:53 +0000
Message-ID: <85ab16d0a56c4942bb8a3e67b9d55858@unicloud.com>
References: <20220804113308.2901178-1-luofei@unicloud.com>
In-Reply-To: <20220804113308.2901178-1-luofei@unicloud.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.1.7]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam.unicloud.com 274C7r4m014658
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIHdyb25nIHBhdGNoLCBwbGVhc2UgaWdub3JlIHRoaXMgZW1haWwuDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IMLet8kNCreiy83KsbzkOiAy
MDIyxOo41MI0yNUgMTk6MzM6MDgNCsrVvP7IyzogbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IGFr
cG1AbGludXgtZm91bmRhdGlvbi5vcmcNCrOty806IGxpbm1pYW9oZUBodWF3ZWkuY29tOyBsaW51
eC1tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IMLet8kNCtb3zOI6
IFtQQVRDSF0gbW0sIGh3cG9pc29uLCBodWdldGxiOiBDaGVjayBodWdldGxiIGhlYWQgcGFnZSBo
d3BvaXNvbiBmbGFnIHdoZW4gdW5wb2lzb24gcGFnZQ0KDQpXaGVuIHNvZnR3YXJlLXBvaXNvbiBh
IGh1Z2UgcGFnZSwgaWYgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBmYWlsZWQsDQp0aGUgaHVn
ZSBwYWdlIHdpbGwgYmUgYWRkZWQgdG8gaHVnZXBhZ2VfZnJlZWxpc3RzLiBJbiB0aGlzIGNhc2Us
IHRoZQ0KaGVhZCBwYWdlIHdpbGwgaG9sZCB0aGUgaHdwb2lzb24gZmxhZywgYnV0IHRoZSByZWFs
IHBvaXNvbmVkIHRhaWwgcGFnZQ0KaHdwb2lzb24gZmxhZyBpcyBub3Qgc2V0LCB0aGlzIHdpbGwg
Y2F1c2UgdW5wb2lzb25fbWVtb3J5KCkgZmFpbCB0bw0KdW5wb2lzb24gdGhlIHByZXZpb3VzbHkg
cG9pc29uZWQgcGFnZS4NCg0KU28gYWRkIGEgY2hlY2sgb24gaHVnZXRsYiBoZWFkIHBhZ2UsIGFu
ZCBhbHNvIG5lZWQgdG8gZW5zdXJlIHRoZQ0KcHJldmlvdXNseSBwb2lzb25lZCB0YWlsIHBhZ2Ug
aW4gaHVnZSBwYWdlIHJhd19od3BfbGlzdC4NCg0KU2lnbmVkLW9mZi1ieTogbHVvZmVpIDxsdW9m
ZWlAdW5pY2xvdWQuY29tPg0KLS0tDQogbW0vbWVtb3J5LWZhaWx1cmUuYyB8IDI0ICsrKysrKysr
KysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVtb3J5
LWZhaWx1cmUuYw0KaW5kZXggMTQ0Mzk4MDZiNWVmLi5mYzU3MWIwY2ViOWQgMTAwNjQ0DQotLS0g
YS9tbS9tZW1vcnktZmFpbHVyZS5jDQorKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQpAQCAtMjI5
Myw2ICsyMjkzLDI4IEBAIGNvcmVfaW5pdGNhbGwobWVtb3J5X2ZhaWx1cmVfaW5pdCk7DQogICAg
ICAgICAgICAgICAgcHJfaW5mbyhmbXQsIHBmbik7ICAgICAgICAgICAgICAgICAgICAgIFwNCiB9
KQ0KDQorc3RhdGljIGJvb2wgaHVnZXRsYl9wYWdlX2hlYWRfcG9pc29uKHN0cnVjdCBwYWdlICpo
cGFnZSwgc3RydWN0IHBhZ2UgKnBhZ2UpDQorew0KKyAgICAgICBzdHJ1Y3QgbGxpc3RfaGVhZCAq
aGVhZDsNCisgICAgICAgc3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9kZTsNCisgICAgICAgc3Ry
dWN0IHJhd19od3BfcGFnZSAqcDsNCisNCisgICAgICAgaWYgKFBhZ2VIdWdlKHBhZ2UpICYmIFBh
Z2VIV1BvaXNvbihocGFnZSkgJiYgSFBhZ2VGcmVlZChocGFnZSkpDQorICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KKw0KKyAgICAgICBpZiAoSFBhZ2VSYXdId3BVbnJlbGlhYmxlKGhwYWdl
KSkNCisgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQorDQorICAgICAgIGhlYWQgPSByYXdf
aHdwX2xpc3RfaGVhZChocGFnZSk7DQorICAgICAgIGxsaXN0X2Zvcl9lYWNoX3NhZmUodG5vZGUs
IHQsIGhlYWQtPmZpcnN0KSB7DQorICAgICAgICAgICAgICAgcCA9IGNvbnRhaW5lcl9vZih0bm9k
ZSwgc3RydWN0IHJhd19od3BfcGFnZSwgbm9kZSk7DQorICAgICAgICAgICAgICAgaWYgKHAtPnBh
Z2UgPT0gcGFnZSkNCisgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KKyAgICAg
ICB9DQorDQorICAgICAgIHJldHVybiBmYWxzZTsNCit9DQorDQogLyoqDQogICogdW5wb2lzb25f
bWVtb3J5IC0gVW5wb2lzb24gYSBwcmV2aW91c2x5IHBvaXNvbmVkIHBhZ2UNCiAgKiBAcGZuOiBQ
YWdlIG51bWJlciBvZiB0aGUgdG8gYmUgdW5wb2lzb25lZCBwYWdlDQpAQCAtMjMzMCw3ICsyMzUy
LDcgQEAgaW50IHVucG9pc29uX21lbW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCiAgICAgICAgICAg
ICAgICBnb3RvIHVubG9ja19tdXRleDsNCiAgICAgICAgfQ0KDQotICAgICAgIGlmICghUGFnZUhX
UG9pc29uKHApKSB7DQorICAgICAgIGlmICghUGFnZUhXUG9pc29uKHApICYmICFodWdldGxiX3Bh
Z2VfaGVhZF9wb2lzb24ocGFnZSwgcCkpIHsNCiAgICAgICAgICAgICAgICB1bnBvaXNvbl9wcl9p
bmZvKCJVbnBvaXNvbjogUGFnZSB3YXMgYWxyZWFkeSB1bnBvaXNvbmVkICUjbHhcbiIsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwZm4sICZ1bnBvaXNvbl9ycyk7DQogICAgICAg
ICAgICAgICAgZ290byB1bmxvY2tfbXV0ZXg7DQotLQ0KMi4yNy4wDQoNCg==
