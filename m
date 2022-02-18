Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A79E4BB7B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiBRLJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 06:09:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiBRLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:09:08 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9D6902AED93;
        Fri, 18 Feb 2022 03:08:48 -0800 (PST)
Received: by ajax-webmail-mail-app3 (Coremail) ; Fri, 18 Feb 2022 19:08:01
 +0800 (GMT+08:00)
X-Originating-IP: [180.169.129.130]
Date:   Fri, 18 Feb 2022 19:08:01 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Jing Leng" <3090101217@zju.edu.cn>
To:     "kernel test robot" <lkp@intel.com>
Cc:     laurent.pinchart@ideasonboard.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        mchehab+huawei@kernel.org, rdunlap@infradead.org, bilbao@vt.edu,
        pawell@cadence.com, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        "Jing Leng" <jleng@ambarella.com>
Subject: Re: Re: [PATCH] usb: gadget: uvc: add framebased stream support
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn zju.edu.cn
In-Reply-To: <202202170211.van9U4Ha-lkp@intel.com>
References: <20220216081651.9089-1-3090101217@zju.edu.cn>
 <202202170211.van9U4Ha-lkp@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f182e7e.aba73.17f0c847394.Coremail.3090101217@zju.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: cC_KCgDnX_MRfg9izEJ5DQ--.8248W
X-CM-SenderInfo: qtqziiyqrsilo62m3hxhgxhubq/1tbiAwMFBVNG3FklugADsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZyBLSCwKCj4gV2h5IG5vdCB1c2UgYSB1bmlvbiBoZXJlIGFzIHRoaXMgaXMgY29taW5n
IGZyb20gdGhlIGhhcmR3YXJlLCByaWdodD8KPgoKSSB1c2VkIHVuaW9uIGluIFBBVENIIHYxLCBJ
IGNvbXBpbGVkIGl0IHRvIGFybTY0IGJpbmFyeSB3aXRoIEdDQyAxMS4yLjEsIAp0aGUgYmluYXJ5
IHdvcmtzIHByb3Blcmx5LgpCdXQgImtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPiIg
cmVwb3J0ZWQgYSB3YXJuaW5nczoKID4+IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNf
Y29uZmlnZnMuYzoxMDkxOjM6IHdhcm5pbmc6IAogZmllbGQgIHdpdGhpbiAnc3RydWN0IHV2Y2df
ZnJhbWU6Oih1bm5hbWVkIGF0IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfY29uZmln
ZnMuYzoxMDY4OjIpJyAKIGlzIGxlc3MgYWxpZ25lZCB0aGFuICd1bmlvbiB1dmNnX2ZyYW1lOjoo
YW5vbnltb3VzIGF0IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfY29uZmlnZnMuYzox
MDkxOjMpJyAKIGFuZCBpcyB1c3VhbGx5IGR1ZSB0byAnc3RydWN0IHV2Y2dfZnJhbWU6Oih1bm5h
bWVkIGF0IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91dmNfY29uZmlnZnMuYzoxMDY4OjIp
JyAKIGJlaW5nIHBhY2tlZCwgd2hpY2ggY2FuIGxlYWQgdG8gdW5hbGlnbmVkIGFjY2Vzc2VzIFst
V3VuYWxpZ25lZC1hY2Nlc3NdCiAgICAgICAgICAgICAgICAgICB1bmlvbiB7CiAgICAgICAgICAg
ICAgICAgICBeCiAgIDEgd2FybmluZyBnZW5lcmF0ZWQuClNvIEkgdXNlIGFub3RoZXIgd2F5IHRv
IGhhbmRsZSB0aGUgZnJhbWUgc3RydWN0dXJlLgoKPiBXaHkgaXMgdGhpcyB3cml0YWJsZSwgYnV0
IHRoZSBvdGhlciB2YXJpYWJsZXMgYXJlIG5vdD8KPiAKCjEuIGJGb3JtYXRJbmRleCBpcyBhdXRv
bWF0aWMgYXV0byBjYWxjdWxhdGVkIGJ5IHRoZSBkcml2ZXIuCiAgIFNvIGl0IGlzIHJlYWQtb25s
eS4KMi4gSSBkb24ndCBrbm93IHdoeSAiYl9hc3BlY3RfcmF0aW9feCAvIGJfYXNwZWN0X3JhdGlv
X3kgLyBibV9pbnRlcmZhY2VfZmxhZ3MiCiAgIGFyZSByZWFkLW9ubHksIFBlcmhhcHMgdGhlc2Ug
cGFyYW1ldGVycyBjYW4gYmUgb2J0YWluZWQgZGlyZWN0bHkgZnJvbSBhY3R1YWwgc3RyZWFtLgog
ICBzbyBkcml2ZXIgZG9lcyBub3QgbmVlZCB0byBjYXJlIGFib3V0IHRoZXNlIHBhcmFtZXRlcnMu
CjMuIElmIGJWYXJpYWJsZVNpemUgaXMgMSwgdGhlbiBkd0J5dGVzUGVyTGluZSBtdXN0IGJlIHNl
dCB0byB6ZXJvICgwKS4KICAgSWYgYlZhcmlhYmxlU2l6ZSBpcyAwLCB0aGVuIGR3Qnl0ZXNQZXJM
aW5lIGNhbiBiZSBzZXR0ZWQgdG8gb3RoZXIgdmFsdWUuCiAgIFNvIGl0IGlzIHdyaXRhYmxlLgoK
PiA+IC0JCSpzaXplICs9IHNpemVvZihmcm0tPmZyYW1lKTsKPiA+ICsJCSpzaXplICs9IHNpemVv
Zihmcm0tPmZyYW1lKSAtIDQ7Cj4gCj4gV2hlcmUgZGlkICI0IiBjb21lIGZyb20/Cj4KClVuY29t
cHJlc3NlZCBmcmFtZSBkb2Vzbid0IGhhdmUgInUzMiBkd19ieXRlc19wZXJsaW5lIi4KRnJhbWVi
YXNlZCBmcmFtZSBkb2Vzbid0IGhhdmUgInUzMiBkd19tYXhfdmlkZW9fZnJhbWVfYnVmZmVyX3Np
emUiLgpJZiB3ZSB1c2UgdW5pb24sIHRoZXJlJ3Mgbm8gbmVlZCB0byBkbyB0aGlzLgpNYXliZSB3
ZSBjYW4gYWRkICIjZGVmaW5lIFVWQ0dfU1VCX0ZSQU1FX1BBWUxPQURfTEVOR1RIIDI2IiwgYW5k
IHVzZQoiVVZDR19TVUJfRlJBTUVfUEFZTE9BRF9MRU5HVEgiIHRvIHJlcGxhY2UgInNpemVvZihm
cm0tPmZyYW1lKSAtIDQiLgoKPiA+ICsJLyogYlZhcmlhYmxlU2l6ZSBpcyBvbmx5IGZvciBmcmFt
ZWJhc2VkIGZvcm1hdC4gKi8KPiA+ICsJX191OCAgYlZhcmlhYmxlU2l6ZTsKPiAKPiBUaGlzIGp1
c3QgY2hhbmdlZCBhIHVzZXIgdmlzYWJsZSBzdHJ1Y3R1cmUgc2l6ZS4gIFdoYXQgYnJva2Ugd2hl
biBkb2luZwo+IHRoaXM/ICBXaGF0IHRvb2wgdXNlcyB0aGlzPwo+IAoKQXMgbG9uZyBhcyB1c2Vy
cyB1c2UgIlVWQ19EVF9GT1JNQVRfVU5DT01QUkVTU0VEX1NJWkUiIGluc3RlYWQgb2YKInNpemVv
ZihzdHJ1Y3QgdXZjX2Zvcm1hdF91bmNvbXByZXNzZWQpIiB0byBnZXQgdGhlIGxlbmd0aCwgdGhl
cmUgaXMKbm8gcHJvYmxlbS4gU28gSSBoYXZlIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uczoK
ICAgIC0JCQkqc2l6ZSArPSBzaXplb2YodS0+ZGVzYyk7CiAgICArCQkJKnNpemUgKz0gdS0+ZGVz
Yy5iTGVuZ3RoOwoKQ3VycmVudGx5IHRoaXMgY2hhbmdlIGRvZXMgbm90IGJyZWFrIHRoZSBrZXJu
ZWwsIGFuZCB1dmMgc3RyZWFtIEFQUApiYXNlZCBvbiBVVkMgZ2FkZ2V0IGRvZXNuJ3QgbmVlZCB0
byB1c2UgInN0cnVjdCB1dmNfZm9ybWF0X3VuY29tcHJlc3NlZCIuCgpUaGVyZSBtYXkgYmUgc29t
ZSB0b29scyB0aGF0IHVzZSBpdCwgVGhleSBjYW4gdXNlICJVVkNfRFRfRk9STUFUX1VOQ09NUFJF
U1NFRF9TSVpFIgp0byBjb3ZlciB0aGUgbW9kaWZpY2F0aW9uLgoKV2UgZG9uJ3QgbmVlZCAiY29w
eSBhbGwgdW5jb21wcmVzc2VkIGNvZGUsIHJlbmFtZQp1bmNvbXByZXNzZWQgYXMgZnJhbWViYXNl
ZCwgbWFrZSBhIGxpdHRsZSBjaGFuZ2UiIHRvIGFjY2VzcyBmcmFtZWJhc2VkCnN0cmVhbSBzdXBw
b3J0LgoKVGhhbmtzLApKaW5nIExlbmc=
