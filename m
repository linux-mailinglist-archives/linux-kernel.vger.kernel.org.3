Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAEC54933CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 04:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351411AbiASDwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 22:52:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49802 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241235AbiASDws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 22:52:48 -0500
X-UUID: 977906052b8a4a76ac52b43372b3701a-20220119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:Subject; bh=rdjTSjD8++N4gFj+A35/zqJPc6D2tnr72tmO70rLMqc=;
        b=ZcAu+KBbkzi0tlLGw/i/qzP25RqL6lToxfXhNBorSIMJ37ZB/PON1rsCjareqPjkuCfF681C5Rf580a0BTyStSlCWUiDXcLPJSezJ4kpz65o5k4lf0RYmVmFbWjS1x0AsWZh+XNLIkQYOHI70+M1uLYuHcuqq8zPESKscIend4U=;
X-UUID: 977906052b8a4a76ac52b43372b3701a-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 39631038; Wed, 19 Jan 2022 11:52:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 11:52:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 11:52:43 +0800
Subject: Re: [PATCH] usb: gadget: at91_udc: fix incorrect print type
To:     Miles Chen <miles.chen@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Sneddon <dan.sneddon@microchip.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220119020849.25732-1-miles.chen@mediatek.com>
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Message-ID: <eef429fa-d9d5-e0ea-8d19-45563fae27dc@mediatek.com>
Date:   Wed, 19 Jan 2022 11:52:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220119020849.25732-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8xOS8yMiAxMDowOCBBTSwgTWlsZXMgQ2hlbiB3cm90ZToNCj4gRml4IGEgYnVpbGQgZXJy
b3Igb2JzZXJ2ZWQgd2l0aCBBUkNIPWFybSBERUZDT05GSUc9YWxsbW9kY29uZmlnIGJ1aWxkLg0K
PiANCj4gZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdDkxX3VkYy5oOjE3NDo0MjogZXJyb3I6IGZv
cm1hdCAnJWQnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnaW50JywgYnV0IGFyZ3VtZW50IDMg
aGFzIHR5cGUgJ3N0cnVjdCBncGlvX2Rlc2MgKicgWy1XZXJyb3I9Zm9ybWF0PV0NCj4gDQo+IEZp
eGVzOiA0YTU1NWYyYjhkMzEgKCJ1c2I6IGdhZGdldDogYXQ5MV91ZGM6IENvbnZlcnQgdG8gR1BJ
TyBkZXNjcmlwdG9ycyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pbGVzIENoZW4gPG1pbGVzLmNoZW5A
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0OTFfdWRj
LmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdDkxX3VkYy5j
IGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdDkxX3VkYy5jDQo+IGluZGV4IGRkMDgxOWRmMDk2
ZS4uOTA0MGEwNTYxNDY2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0
OTFfdWRjLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdDkxX3VkYy5jDQo+IEBA
IC0xODk1LDcgKzE4OTUsNyBAQCBzdGF0aWMgaW50IGF0OTF1ZGNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gICAJCQkJCWF0OTFfdmJ1c19pcnEsIDAsIGRyaXZlcl9uYW1l
LCB1ZGMpOw0KPiAgIAkJCWlmIChyZXR2YWwpIHsNCj4gICAJCQkJREJHKCJyZXF1ZXN0IHZidXMg
aXJxICVkIGZhaWxlZFxuIiwNCj4gLQkJCQkgICAgdWRjLT5ib2FyZC52YnVzX3Bpbik7DQo+ICsJ
CQkJICAgIGRlc2NfdG9fZ3Bpbyh1ZGMtPmJvYXJkLnZidXNfcGluKSk7DQo+ICAgCQkJCWdvdG8g
ZXJyX3VucHJlcGFyZV9pY2xrOw0KPiAgIAkJCX0NCj4gICAJCX0NCj4gDQoNClJldmlld2VkLWJ5
OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MhDQpNYWNw
YXVsIExpbg==

