Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93A44939B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 12:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354246AbiASLkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 06:40:01 -0500
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net ([206.189.21.223]:58002
        "HELO zg8tmja2lje4os4yms4ymjma.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1354216AbiASLkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 06:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=ko2uO+xiqlDXVopVE7QY0gYCjDmy8gGdxHDP
        QLGRqzk=; b=nCVVD+idgr/7HkEjIFTSdLMwXN2V5yJ5I3Y9CZ4myQ3KZU1sCrYQ
        Dci5x6FYePemsjRKrp9xGn4VQ+qHM8NhNiEuZyQuT2IOilTJKlXLkObPuHcryE4Z
        fWQp4PsTkxUTB2HPvnssdHTIfLwlAfJsw4judEqCiVIna+2p5IP3qUc=
Received: by ajax-webmail-front01 (Coremail) ; Wed, 19 Jan 2022 19:36:46
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Wed, 19 Jan 2022 19:36:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "lucas stach" <l.stach@pengutronix.de>
Cc:     linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drm/etnaviv: Add missing pm_runtime_put
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <bb71f83d4897ce818348522d9594b091478073ff.camel@pengutronix.de>
References: <1642515391-19329-1-git-send-email-lyz_cs@pku.edu.cn>
 <bb71f83d4897ce818348522d9594b091478073ff.camel@pengutronix.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <480fc77e.24a14.17e721fffbe.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 5oFpogD3n7rP9+dhjHt9AA--.20150W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwAcso
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiTHVjYXMgU3RhY2giIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPgo+IOWPkemAgeaXtumXtDogMjAyMi0wMS0xOSAxODo1MToyMCAo
5pif5pyf5LiJKQo+IOaUtuS7tuS6ujogIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5lZHUuY24+
LCBsaW51eCtldG5hdml2QGFybWxpbnV4Lm9yZy51aywgY2hyaXN0aWFuLmdtZWluZXJAZ21haWwu
Y29tLCBhaXJsaWVkQGxpbnV4LmllLCBkYW5pZWxAZmZ3bGwuY2gsIGV0bmF2aXZAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4g5oqE6YCBOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnLCBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4g5Li76aKYOiBSZTogW1BBVENIXSBkcm0vZXRu
YXZpdjogQWRkIG1pc3NpbmcgcG1fcnVudGltZV9wdXQKPiAKPiBBbSBEaWVuc3RhZywgZGVtIDE4
LjAxLjIwMjIgdW0gMDY6MTYgLTA4MDAgc2NocmllYiBZb25nemhpIExpdToKPiA+IHBtX3J1bnRp
bWVfZ2V0X3N5bmMoKSBpbmNyZW1lbnRzIHRoZSBydW50aW1lIFBNIHVzYWdlIGNvdW50ZXIgZXZl
bgo+ID4gd2hlbiBpdCByZXR1cm5zIGFuIGVycm9yIGNvZGUsIHRodXMgYSBtYXRjaGluZyBkZWNy
ZW1lbnQgaXMgbmVlZGVkCj4gPiBvbiB0aGUgZXJyb3IgaGFuZGxpbmcgcGF0aCB0byBrZWVwIHRo
ZSBjb3VudGVyIGJhbGFuY2VkLgo+ID4gCj4gSW5zdGVhZCBvZiBhZGRpbmcgbW9yZSBlcnJvciBo
YW5kbGluZyBjb2RlIGhlcmUsIEkgd291bGQgcHJlZmVyIHRvCj4gY29udmVydCB0aGlzIHRvIHBt
X3J1bnRpbWVfcmVzdW1lX2FuZF9nZXQgdG8gYXZvaWQgdGhpcyBpc3N1ZS4KPiAKPiBSZWdhcmRz
LAo+IEx1Y2FzCj4gCgpJIHdpbGwgcmVzZW5kIG15IG1vZGlmaWVkIHBhdGNoLiBUaGFua3MgZm9y
IHlvdXIgcmVwbHkuCgo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3poaSBMaXUgPGx5el9jc0Bwa3Uu
ZWR1LmNuPgo+ID4gLS0tCj4gPiAgZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUu
YyB8IDMgKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQo+ID4gCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9ncHUuYyBiL2RyaXZl
cnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ3B1LmMKPiA+IGluZGV4IDI0MmE1ZmQuLjVlODFh
OTggMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5j
Cj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vZXRuYXZpdi9ldG5hdml2X2dwdS5jCj4gPiBAQCAt
MTcxNCw2ICsxNzE0LDkgQEAgc3RhdGljIGludCBldG5hdml2X2dwdV9iaW5kKHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldmljZSAqbWFzdGVyLAo+ID4gIAlyZXR1cm4gMDsKPiA+ICAKPiA+
ICBvdXRfc2NoZWQ6Cj4gPiArI2lmZGVmIENPTkZJR19QTQo+ID4gKwlwbV9ydW50aW1lX3B1dF9h
dXRvc3VzcGVuZChncHUtPmRldik7Cj4gPiArI2VuZGlmCj4gPiAgCWV0bmF2aXZfc2NoZWRfZmlu
aShncHUpOwo+ID4gIAo+ID4gIG91dF93b3JrcXVldWU6Cj4gCg==
