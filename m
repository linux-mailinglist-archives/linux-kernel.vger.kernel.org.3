Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04194C0798
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbiBWCIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbiBWCIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:08:00 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id BD9E242A32;
        Tue, 22 Feb 2022 18:07:31 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Wed, 23 Feb 2022 10:06:48
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Wed, 23 Feb 2022 10:06:48 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     balbi@kernel.org, bilbao@vt.edu, corbet@lwn.net,
        laurent.pinchart@ideasonboard.com, mchehab+huawei@kernel.org,
        pawell@cadence.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        "Jing Leng" <jleng@ambarella.com>
Subject: Re: Re: [PATCH v2] usb: gadget: uvc: add framebased stream support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <Yg5pb1A9QlgoKYnm@kroah.com>
References: <20220216081651.9089-1-3090101217@zju.edu.cn>
 <20220217104450.14372-1-3090101217@zju.edu.cn> <Yg5pb1A9QlgoKYnm@kroah.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7b3d8dad.b85c3.17f2454bf49.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cC_KCgDnX_O4lhViJo65DQ--.13863W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwUKBVNG3FoJcQABsj
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKCj4gV2h5IG5vdCB1c2UgYSB1bmlvbiBoZXJlIGFzIHRoaXMgaXMgY29taW5n
IGZyb20gdGhlIGhhcmR3YXJlLCByaWdodD8KPgoKSSB1c2VkIGEgdW5pb24gaW4gUEFUQ0ggdjEK
KGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC11c2IvcGF0Y2gvMjAy
MjAyMTYwODE2NTEuOTA4OS0xLTMwOTAxMDEyMTdAemp1LmVkdS5jbi8pLApJIGNvbXBpbGVkIGl0
IHRvIGFybTY0IGJpbmFyeSB3aXRoIEdDQyAxMS4yLjEsIHRoZSBiaW5hcnkgd29ya3MgcHJvcGVy
bHkuCkJ1dCAia2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+IiByZXBvcnRlZCBhIHdh
cm5pbmdzOgogPj4gZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3V2Y19jb25maWdmcy5jOjEw
OTE6Mzogd2FybmluZzogCiBmaWVsZCAgd2l0aGluICdzdHJ1Y3QgdXZjZ19mcmFtZTo6KHVubmFt
ZWQgYXQgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3V2Y19jb25maWdmcy5jOjEwNjg6Mikn
IAogaXMgbGVzcyBhbGlnbmVkIHRoYW4gJ3VuaW9uIHV2Y2dfZnJhbWU6Oihhbm9ueW1vdXMgYXQg
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3V2Y19jb25maWdmcy5jOjEwOTE6MyknIAogYW5k
IGlzIHVzdWFsbHkgZHVlIHRvICdzdHJ1Y3QgdXZjZ19mcmFtZTo6KHVubmFtZWQgYXQgZHJpdmVy
cy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3V2Y19jb25maWdmcy5jOjEwNjg6MiknIAogYmVpbmcgcGFj
a2VkLCB3aGljaCBjYW4gbGVhZCB0byB1bmFsaWduZWQgYWNjZXNzZXMgWy1XdW5hbGlnbmVkLWFj
Y2Vzc10KICAgICAgICAgICAgICAgICAgIHVuaW9uIHsKICAgICAgICAgICAgICAgICAgIF4KICAg
MSB3YXJuaW5nIGdlbmVyYXRlZC4KU28gSSB1c2UgYW5vdGhlciB3YXkgdG8gaGFuZGxlIHRoZSBm
cmFtZSBzdHJ1Y3R1cmUuCgo+IFdoeSBpcyB0aGlzIHdyaXRhYmxlLCBidXQgdGhlIG90aGVyIHZh
cmlhYmxlcyBhcmUgbm90Pwo+IAoKMS4gYkZvcm1hdEluZGV4IGlzIGF1dG9tYXRpYyBhdXRvIGNh
bGN1bGF0ZWQgYnkgdGhlIGRyaXZlci4KICAgU28gaXQgaXMgcmVhZC1vbmx5LgoyLiBJIGRvbid0
IGtub3cgd2h5ICJiX2FzcGVjdF9yYXRpb194IC8gYl9hc3BlY3RfcmF0aW9feSAvIGJtX2ludGVy
ZmFjZV9mbGFncyIKICAgYXJlIHJlYWQtb25seS4gUGVyaGFwcyB0aGVzZSBwYXJhbWV0ZXJzIGNh
biBiZSBvYnRhaW5lZCBkaXJlY3RseSBmcm9tIAogICB0aGUgYWN0dWFsIHN0cmVhbSwgc28gZHJp
dmVyIGRvZXNuJ3QgbmVlZCB0byB0YWtlIGNhcmUgb2YgdGhlc2UgcGFyYW1ldGVycy4KMy4gSWYg
YlZhcmlhYmxlU2l6ZSBpcyAxLCB0aGVuIGR3Qnl0ZXNQZXJMaW5lIG11c3QgYmUgc2V0dGVkIHRv
IHplcm8gKDApLgogICBJZiBiVmFyaWFibGVTaXplIGlzIDAsIHRoZW4gZHdCeXRlc1BlckxpbmUg
Y2FuIGJlIHNldHRlZCB0byBvdGhlciB2YWx1ZS4KICAgU28gaXQgaXMgd3JpdGFibGUuCgo+ID4g
LQkJKnNpemUgKz0gc2l6ZW9mKGZybS0+ZnJhbWUpOwo+ID4gKwkJKnNpemUgKz0gc2l6ZW9mKGZy
bS0+ZnJhbWUpIC0gNDsKPiAKPiBXaGVyZSBkaWQgIjQiIGNvbWUgZnJvbT8KPgoKVW5jb21wcmVz
c2VkIGZyYW1lIGRvZXNuJ3QgaGF2ZSAidTMyIGR3X2J5dGVzX3BlcmxpbmUiLgpGcmFtZWJhc2Vk
IGZyYW1lIGRvZXNuJ3QgaGF2ZSAidTMyIGR3X21heF92aWRlb19mcmFtZV9idWZmZXJfc2l6ZSIu
CklmIHdlIHVzZSBhIHVuaW9uIGxpa2UgUEFUQ0ggdjEsIHRoZXJlJ3Mgbm8gbmVlZCB0byBkbyB0
aGlzLgpNYXliZSB3ZSBjYW4gYWRkICIjZGVmaW5lIFVWQ0dfU1VCX0ZSQU1FX1BBWUxPQURfTEVO
R1RIIDI2IiwgYW5kIHVzZQoiVVZDR19TVUJfRlJBTUVfUEFZTE9BRF9MRU5HVEgiIHRvIHJlcGxh
Y2UgInNpemVvZihmcm0tPmZyYW1lKSAtIDQiCmZvciB0aGUgbmV3IFBBVENILgoKPiA+ICsJLyog
YlZhcmlhYmxlU2l6ZSBpcyBvbmx5IGZvciBmcmFtZWJhc2VkIGZvcm1hdC4gKi8KPiA+ICsJX191
OCAgYlZhcmlhYmxlU2l6ZTsKPiAKPiBUaGlzIGp1c3QgY2hhbmdlZCBhIHVzZXIgdmlzYWJsZSBz
dHJ1Y3R1cmUgc2l6ZS4gIFdoYXQgYnJva2Ugd2hlbiBkb2luZwo+IHRoaXM/ICBXaGF0IHRvb2wg
dXNlcyB0aGlzPwo+IAoKQXMgbG9uZyBhcyB1c2VycyB1c2UgIlVWQ19EVF9GT1JNQVRfVU5DT01Q
UkVTU0VEX1NJWkUiIGluc3RlYWQgb2YKInNpemVvZihzdHJ1Y3QgdXZjX2Zvcm1hdF91bmNvbXBy
ZXNzZWQpIiB0byBnZXQgdGhlIGxlbmd0aCwgdGhlcmUgaXMKbm8gcHJvYmxlbS4gU28gSSBoYXZl
IHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uczoKICAgIC0JCQkqc2l6ZSArPSBzaXplb2YodS0+
ZGVzYyk7CiAgICArCQkJKnNpemUgKz0gdS0+ZGVzYy5iTGVuZ3RoOwoKQ3VycmVudGx5IHRoaXMg
Y2hhbmdlIGRvZXMgbm90IGJyZWFrIHRoZSBrZXJuZWwsIGFuZCB1dmMgc3RyZWFtIEFQUApiYXNl
ZCBvbiBVVkMgZ2FkZ2V0IGRvZXNuJ3QgbmVlZCB0byB1c2UgInN0cnVjdCB1dmNfZm9ybWF0X3Vu
Y29tcHJlc3NlZCIuCgpUaGVyZSBtYXkgYmUgc29tZSB0b29scyB3aGljaCB1c2UgaXQsIHRoZXkg
Y2FuIHVzZSAKIlVWQ19EVF9GT1JNQVRfVU5DT01QUkVTU0VEX1NJWkUiIHRvIGNvdmVyIHRoZSBt
b2RpZmljYXRpb24uCkluIGFkZGl0aW9uLCB3ZSBkb24ndCBuZWVkICJjb3B5IGFsbCB1bmNvbXBy
ZXNzZWQgY29kZSwgcmVuYW1lCnVuY29tcHJlc3NlZCBhcyBmcmFtZWJhc2VkLCBhbmQgbWFrZSBh
IGxpdHRsZSBjaGFuZ2UiIHRvIGFjY2VzcyBmcmFtZWJhc2VkCnN0cmVhbSBzdXBwb3J0LgoKVGhh
bmtzLApKaW5nIExlbmcK
