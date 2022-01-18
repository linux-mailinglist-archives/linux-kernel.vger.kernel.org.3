Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180F2492436
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiARLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:03:14 -0500
Received: from azure-sdnproxy.icoremail.net ([52.175.55.52]:52535 "HELO
        azure-sdnproxy-2.icoremail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S231758AbiARLDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=bFkUcZmM+EbGih7bRXgct6iBhh0wCfmhyFvc
        7WGjPRg=; b=NGUBxz4j2ZYGl31QLojAY5YDuRzhoyEMMqAOVAQmATm8YD+dLhgO
        lsjHoz5HQnTKHlC7YhTI8pc6bQcvczdV0H6zB3Cy26OIES9c7tnVA0ZL9Xsx6HhB
        1M8Rcb31oujhQwYy6p5KwTvi1lD0edY9Bdn7omCLe0UxYBhiqdmbS4k=
Received: by ajax-webmail-front01 (Coremail) ; Tue, 18 Jan 2022 18:57:03
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Tue, 18 Jan 2022 18:57:03 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "rafael j. wysocki" <rafael@kernel.org>
Cc:     "greg kroah-hartman" <gregkh@linuxfoundation.org>,
        "linux kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] driver core: Add missing pm_runtime_put_noidle
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <CAJZ5v0heMSa82qSVrrjrv2ioz5y-18rCKThjbPBACJ6xuXQQQg@mail.gmail.com>
References: <1642417623-5393-1-git-send-email-lyz_cs@pku.edu.cn>
 <CAJZ5v0heMSa82qSVrrjrv2ioz5y-18rCKThjbPBACJ6xuXQQQg@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3861fca1.2105f.17e6cd545c0.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: 5oFpogBHTzv_nOZhoKJzAA--.10967W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwAAs0
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLeWOn+Wni+mCruS7ti0tLS0tCj4g5Y+R5Lu25Lq6OiAiUmFmYWVsIEouIFd5c29ja2ki
IDxyYWZhZWxAa2VybmVsLm9yZz4KPiDlj5HpgIHml7bpl7Q6IDIwMjItMDEtMTcgMjI6MDE6NTQg
KOaYn+acn+S4gCkKPiDmlLbku7bkuro6ICJZb25nemhpIExpdSIgPGx5el9jc0Bwa3UuZWR1LmNu
Pgo+IOaKhOmAgTogIkdyZWcgS3JvYWgtSGFydG1hbiIgPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPiwgIlJhZmFlbCBKLiBXeXNvY2tpIiA8cmFmYWVsQGtlcm5lbC5vcmc+LCAiTGludXggS2Vy
bmVsIE1haWxpbmcgTGlzdCIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Cj4g5Li76aKY
OiBSZTogW1BBVENIXSBkcml2ZXIgY29yZTogQWRkIG1pc3NpbmcgcG1fcnVudGltZV9wdXRfbm9p
ZGxlCj4gCj4gT24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMTI6MDggUE0gWW9uZ3poaSBMaXUgPGx5
el9jc0Bwa3UuZWR1LmNuPiB3cm90ZToKPiA+Cj4gPiBwbV9ydW50aW1lX2dldF9ub3Jlc3VtZSgp
IGluIGRldmljZV9zaHV0ZG93biBpbmNyZW1lbnRzIHRoZQo+ID4gcnVudGltZSBQTSB1c2FnZSBj
b3VudGVyLAo+IAo+IFRoaXMgaXMgb24gcHVycG9zZSwgdG8gcHJldmVudCBkZXZpY2VzIGZyb20g
YmVpbmcgcnVudGltZS1zdXNwZW5kZWQKPiBhZnRlciB0aGVpciBzaHV0ZG93biBjYWxsYmFja3Mg
aGF2ZSBydW4uCj4gCj4gPiB0aHVzIGEgbWF0Y2hpbmcgZGVjcmVtZW50IGlzIG5lZWRlZAo+IAo+
IE5vLCBpdCBpcyBub3QsIEFGQUlDUy4KPiAKPiA+IHRvIGtlZXAgdGhlIGNvdW50ZXIgYmFsYW5j
ZWQuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3poaSBMaXUgPGx5el9jc0Bwa3UuZWR1LmNu
Pgo+ID4gLS0tCj4gPiAgZHJpdmVycy9iYXNlL2NvcmUuYyB8IDIgKysKPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9j
b3JlLmMgYi9kcml2ZXJzL2Jhc2UvY29yZS5jCj4gPiBpbmRleCBmZDAzNGQ3Li4yOTk1MGJkIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL2NvcmUuYwo+ID4gKysrIGIvZHJpdmVycy9iYXNl
L2NvcmUuYwo+ID4gQEAgLTQ1MjMsNiArNDUyMyw4IEBAIHZvaWQgZGV2aWNlX3NodXRkb3duKHZv
aWQpCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPmRyaXZlci0+c2h1dGRvd24oZGV2
KTsKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPgo+ID4gKyAgICAgICAgICAgICAgIHBtX3J1bnRp
bWVfcHV0X25vaWRsZShkZXYpOwo+ID4gKwo+ID4gICAgICAgICAgICAgICAgIGRldmljZV91bmxv
Y2soZGV2KTsKPiA+ICAgICAgICAgICAgICAgICBpZiAocGFyZW50KQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgZGV2aWNlX3VubG9jayhwYXJlbnQpOwo+ID4gLS0KPiA+IDIuNy40Cj4gPgpZ
ZXMsIHRoYW5rcyBmb3IgeW91ciByZXBseS4K
