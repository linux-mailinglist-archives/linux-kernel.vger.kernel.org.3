Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E3754D87A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350143AbiFPCiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbiFPCiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:38:04 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A15627155;
        Wed, 15 Jun 2022 19:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=DJRHY
        5TULW6YiMhALFXgMhXjdupTtOS2pWbWnjCFRk4=; b=nq82c4fbSA//9e13HQNJe
        aXu/VpPsIElmf2Dzz6fR5PthpQZKYZZX0756uVqmB5IaZwvGw18/BYq0mafYpaCH
        9Gk/+oNu9cLmSDsfpnrmcbgy/l6cV/Na0koHmq6yKshuvdrBKM8yDDln2EI6zFy2
        ZrUzanRxaPOswqYPnRwb1s=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 10:37:41 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 10:37:41 +0800 (CST)
From:   =?GBK?B?us3BwQ==?= <windhl@126.com>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     tharvey@gateworks.com, rjones@gateworks.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] drivers: hwmon: Add missing of_node_put() in
 gsc-hwmon.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <01243e3e-f4d2-c1ba-98f5-db7bc0c62adc@roeck-us.net>
References: <20220615151856.3970186-1-windhl@126.com>
 <01243e3e-f4d2-c1ba-98f5-db7bc0c62adc@roeck-us.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2da49756.221e.1816a5fa3d3.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowADX3yd2l6piYtg2AA--.9223W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbiuBMiF2JVj40ZHAACss
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKQXQgMjAyMi0wNi0xNiAwMTo1Nzo0OSwgIkd1ZW50ZXIgUm9lY2siIDxsaW51eEByb2Vjay11
cy5uZXQ+IHdyb3RlOgo+Cj5QbGVhc2UgdXNlIHByb3BlciBzdWJqZWN0IGxpbmVzLiBIZXJlIGl0
IHNob3VsZCBoYXZlIGJlZW4KPgo+aHdtb246IChnc2MtaHdtb24pIEFkZCBtaXNzaW5nIG9mX25v
ZGVfcHV0KCkKCgoKVGhhbmtzLCBJIHdpbGwgY2hhbmdlIGl0IGluIG15IG5ldyBwYXRjaC4KCgo+
Pj4gICBkcml2ZXJzL2h3bW9uL2dzYy1od21vbi5jIHwgNiArKysrKy0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9od21vbi9nc2MtaHdtb24uYyBiL2RyaXZlcnMvaHdtb24vZ3NjLWh3bW9uLmMKPj4g
aW5kZXggMWZlMzc0MThmZjQ2Li4zNGMyMGQxMzYyN2EgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
aHdtb24vZ3NjLWh3bW9uLmMKPj4gKysrIGIvZHJpdmVycy9od21vbi9nc2MtaHdtb24uYwo+PiBA
QCAtMjY4LDEwICsyNjgsMTQgQEAgZ3NjX2h3bW9uX2dldF9kZXZ0cmVlX3BkYXRhKHN0cnVjdCBk
ZXZpY2UgKmRldikKPj4gICAKPj4gICAJLyogZmFuIGNvbnRyb2xsZXIgYmFzZSBhZGRyZXNzICov
Cj4+ICAgCWZhbiA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKGRldi0+cGFyZW50LT5vZl9ub2Rl
LCBOVUxMLCAiZ3csZ3NjLWZhbiIpOwo+Cj5BIHNpbmdsZSBvZl9ub2RlX3B1dChmYW4pIGhlcmUg
d291bGQgaGF2ZSBiZWVuIGJlIHN1ZmZpY2llbnQuCgoKCkkgdGhpbmsgb2Zfbm9kZV9wdXQgYWZ0
ZXIgc2hvdWxkIGNvbWUgYWZ0ZXIgaXRzIHVzYWdlLCByaWdodD8KCgo+Pj4gLQlpZiAoZmFuICYm
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGZhbiwgInJlZyIsICZwZGF0YS0+ZmFuX2Jhc2UpKSB7Cj4+
ICsJaWYgKGZhbiAmJiBvZl9wcm9wZXJ0eV9yZWFkX3UzMihmYW4sICJyZWciLCAmcGRhdGEtPmZh
bl9iYXNlKSkgewkJCj4+ICsJCW9mX25vZGVfcHV0KGZhbik7Cj4+ICAgCQlkZXZfZXJyKGRldiwg
ImZhbiBub2RlIHdpdGhvdXQgYmFzZVxuIik7Cj4+ICAgCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFM
KTsKPj4gICAJfQo+PiArCQo+PiArCS8qIGlmIGZhbiYmIW9mX3Byb3BlcnR5X3JlYWRfdTMyIGZh
aWwgKi8KPgoKPlRoaXMgY29tbWVudCBvbmx5IGFkZHMgY29uZnVzaW9uIGFuZCBkb2VzIG5vdCBh
ZGQgYW55IHZhbHVlLgoKClNvcnJ5LCBJIGp1c3Qgd2FudCB0byBzYXksIGlmICpmYW4qIGlzIG5v
dCBOVUxMLCBidXQgb2ZfcHJvcGVydHlfcmVhZF91MzIoKSByZXR1cm5zIDAuCkluIHRoYXQgY2Fz
ZSwgd2Ugc3RpbGwgbmVlZCBhIG9mX25vZGVfcHV0KCkgdG8gcmVsZWFzZSBmYW4sIHJpZ2h0PwoK
Pgo+R3VlbnRlcgo+Cj4+ICsJb2Zfbm9kZV9wdXQoZmFuKTsKPj4gICAKPj4gICAJLyogYWxsb2Nh
dGUgc3RydWN0dXJlcyBmb3IgY2hhbm5lbHMgYW5kIGNvdW50IGluc3RhbmNlcyBvZiBlYWNoIHR5
cGUgKi8KCj4+ICAgCWRldmljZV9mb3JfZWFjaF9jaGlsZF9ub2RlKGRldiwgY2hpbGQpIHsKCgpI
aSwgR3VlbnRlciwgSSBhbSBwcmVwYXJpbmcgbXkgbmV3IHBhdGNoIGFuZCBJIHdhbnQgdG8gZGlz
Y3VzcyB5b3VyIHN1Z2dlc3Rpb25zIGFzIGFib3ZlLgoK
