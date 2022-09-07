Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E25AF90A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 02:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIGAls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 20:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiIGAlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 20:41:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A458B868A2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 17:41:44 -0700 (PDT)
Received: from chenhuacai$loongson.cn ( [112.20.112.163] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 7 Sep 2022 08:41:39
 +0800 (GMT+08:00)
X-Originating-IP: [112.20.112.163]
Date:   Wed, 7 Sep 2022 08:41:39 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>
To:     "kernel test robot" <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Jianmin Lv" <lvjianmin@loongson.cn>
Subject: Re: irq-loongarch-cpu.c:undefined reference to `eiointc_acpi_init'
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20220411(feba7c69)
 Copyright (c) 2002-2022 www.mailtech.cn .loongson.cn
In-Reply-To: <202209070736.fHnylLIQ-lkp@intel.com>
References: <202209070736.fHnylLIQ-lkp@intel.com>
Content-Transfer-Encoding: base64
X-CM-CTRLDATA: puah9GZvb3Rlcl90eHQ9MjIxNzo2MTI=
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2bbd9483.639f.18315653cd0.Coremail.chenhuacai@loongson.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAf8BxP+DD6BdjjDQTAA--.4106W
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/1tbiAQACBmMXOFsMEwAAsN
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSB0aGluayB0aGlzIGNhbiBiZSBmaXhlZCBhZnRlciB0aGlzIHBhdGNoIGJlIG1lcmdlZDoKaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDgwODA4NTMxOS4zMzUwMTExLTEtY2hlbmh1
YWNhaUBsb29uZ3Nvbi5jbi8KCj4gLS0tLS3ljp/lp4vpgq7ku7YtLS0tLQo+IOWPkeS7tuS6ujog
Imtlcm5lbCB0ZXN0IHJvYm90IiA8bGtwQGludGVsLmNvbT4KPiDlj5HpgIHml7bpl7Q6MjAyMi0w
OS0wNyAwNzo1MDo0NCAo5pif5pyf5LiJKQo+IOaUtuS7tuS6ujogIkh1YWNhaSBDaGVuIiA8Y2hl
bmh1YWNhaUBsb29uZ3Nvbi5jbj4KPiDmioTpgIE6IGtidWlsZC1hbGxAbGlzdHMuMDEub3JnLCBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLCAiTWFyYyBaeW5naWVyIiA8bWF6QGtlcm5lbC5v
cmc+LCAiSmlhbm1pbiBMdiIgPGx2amlhbm1pbkBsb29uZ3Nvbi5jbj4KPiDkuLvpopg6IGlycS1s
b29uZ2FyY2gtY3B1LmM6dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgZWlvaW50Y19hY3BpX2luaXQn
Cj4gCj4gSGkgSHVhY2FpLAo+IAo+IEZZSSwgdGhlIGVycm9yL3dhcm5pbmcgc3RpbGwgcmVtYWlu
cy4KPiAKPiB0cmVlOiAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdCBtYXN0ZXIKPiBoZWFkOiAgIGQyZWM3OTlkMWMxYmU4
NDdkNmE3MDcwNGZlNTg2YWM0ZDE0MjY1YzgKPiBjb21taXQ6IGIyZDNlMzM1NGUyYTBkMGU5MTIz
MDg2MThlYTMzZDAzMzdmNDA1YzMgaXJxY2hpcDogQWRkIExvb25nQXJjaCBDUFUgaW50ZXJydXB0
IGNvbnRyb2xsZXIgc3VwcG9ydAo+IGRhdGU6ICAgNyB3ZWVrcyBhZ28KPiBjb25maWc6IGxvb25n
YXJjaC1yYW5kY29uZmlnLXIwMTEtMjAyMjA5MDYKPiBjb21waWxlcjogbG9vbmdhcmNoNjQtbGlu
dXgtZ2NjIChHQ0MpIDEyLjEuMAo+IHJlcHJvZHVjZSAodGhpcyBpcyBhIFc9MSBidWlsZCk6Cj4g
ICAgICAgICB3Z2V0IGh0dHBzOi8vcmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbS9pbnRlbC9sa3At
dGVzdHMvbWFzdGVyL3NiaW4vbWFrZS5jcm9zcyAtTyB+L2Jpbi9tYWtlLmNyb3NzCj4gICAgICAg
ICBjaG1vZCAreCB+L2Jpbi9tYWtlLmNyb3NzCj4gICAgICAgICAjIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPWIyZDNlMzM1NGUyYTBkMGU5MTIzMDg2MThlYTMzZDAzMzdmNDA1YzMKPiAgICAgICAgIGdp
dCByZW1vdGUgYWRkIGxpbnVzIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdAo+ICAgICAgICAgZ2l0IGZldGNoIC0tbm8tdGFn
cyBsaW51cyBtYXN0ZXIKPiAgICAgICAgIGdpdCBjaGVja291dCBiMmQzZTMzNTRlMmEwZDBlOTEy
MzA4NjE4ZWEzM2QwMzM3ZjQwNWMzCj4gICAgICAgICAjIHNhdmUgdGhlIGNvbmZpZyBmaWxlCj4g
ICAgICAgICBta2RpciBidWlsZF9kaXIgJiYgY3AgY29uZmlnIGJ1aWxkX2Rpci8uY29uZmlnCj4g
ICAgICAgICBDT01QSUxFUl9JTlNUQUxMX1BBVEg9JEhPTUUvMGRheSBDT01QSUxFUj1nY2MtMTIu
MS4wIG1ha2UuY3Jvc3MgVz0xIE89YnVpbGRfZGlyIEFSQ0g9bG9vbmdhcmNoIFNIRUxMPS9iaW4v
YmFzaAo+IAo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcg
d2hlcmUgYXBwbGljYWJsZQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4KPiAKPiBBbGwgZXJyb3JzIChuZXcgb25lcyBwcmVmaXhlZCBieSA+Pik6Cj4gCj4g
ICAgbG9vbmdhcmNoNjQtbGludXgtbGQ6IGRyaXZlcnMvaXJxY2hpcC9pcnEtbG9vbmdhcmNoLWNw
dS5vOiBpbiBmdW5jdGlvbiBgZWlvaW50Y19wYXJzZV9tYWR0JzoKPiA+PiBpcnEtbG9vbmdhcmNo
LWNwdS5jOiguaW5pdC50ZXh0KzB4MTApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBlaW9pbnRj
X2FjcGlfaW5pdCcKPiAgICBsb29uZ2FyY2g2NC1saW51eC1sZDogZHJpdmVycy9pcnFjaGlwL2ly
cS1sb29uZ3Nvbi1wY2gtcGljLm86IGluIGZ1bmN0aW9uIGBwY2hfbHBjX3BhcnNlX21hZHQnOgo+
ICAgIGlycS1sb29uZ3Nvbi1wY2gtcGljLmM6KC5pbml0LnRleHQrMHgxNCk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8gYHBjaF9scGNfYWNwaV9pbml0Jwo+IAo+IC0tIAo+IDAtREFZIENJIEtlcm5l
bCBUZXN0IFNlcnZpY2UKPiBodHRwczovLzAxLm9yZy9sa3AKDQoNCuacrOmCruS7tuWPiuWFtumZ
hOS7tuWQq+aciem+meiKr+S4reenkeeahOWVhuS4muenmOWvhuS/oeaBr++8jOS7hemZkOS6juWP
kemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7
u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWF
qOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuaIluaVo+WPke+8ieacrOmCruS7tuWPiuWF
tumZhOS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuacrOmCruS7tu+8jOivt+aCqOer
i+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tuOAgiAN
ClRoaXMgZW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZv
cm1hdGlvbiBmcm9tIExvb25nc29uIFRlY2hub2xvZ3kgLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4g
QW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChp
bmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJl
LCByZXByb2R1Y3Rpb24gb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRo
ZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhp
cyBlbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVt
YWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQuIA==
