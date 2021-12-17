Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8A478890
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhLQKN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:57 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:36042 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229608AbhLQKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:13:56 -0500
X-UUID: d08a15f70d6f4d6d90bb9ed87a1e258c-20211217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uFcK4gvGxKhr+1Gxp1HLf3uXW5dWkImnP/fCOnQUidM=;
        b=a6b7SagtCpyHPAYiqxy7yd41FRCUT8R4IQAtZ6a5GtfWGBmFBFpOPcDEhsav3Y48TcY/QlhkkgBWbw0dfa1HUyzussE9hSmm1DSca8b1Xxjp/UEMvdS1tsx+jz9GhjgCltewuA2ldNd8dMex+nL6CQhUEcn6la3/SClr0HFOVxI=;
X-UUID: d08a15f70d6f4d6d90bb9ed87a1e258c-20211217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 594895960; Fri, 17 Dec 2021 18:13:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Dec 2021 18:13:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 18:13:50 +0800
Message-ID: <a23b0cbb5f1b0d2b2724ddb0e032f2caeedc775f.camel@mediatek.com>
Subject: Re: [PATCH v2] usb: hub: Add delay for SuperSpeed hub resume to let
 links transit to U0
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        <gregkh@linuxfoundation.org>
CC:     <stern@rowland.harvard.edu>, <mathias.nyman@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chris Chiu <chris.chiu@canonical.com>,
        "Bixuan Cui" <cuibixuan@huawei.com>,
        Rajat Jain <rajatja@google.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 17 Dec 2021 18:13:51 +0800
In-Reply-To: <20211215120108.336597-1-kai.heng.feng@canonical.com>
References: <20211215120108.336597-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTEyLTE1IGF0IDIwOjAxICswODAwLCBLYWktSGVuZyBGZW5nIHdyb3RlOg0K
PiBXaGVuIGEgbmV3IFVTQiBkZXZpY2UgZ2V0cyBwbHVnZ2VkIHRvIG5lc3RlZCBodWJzLCB0aGUg
YWZmZWN0ZWQgaHViLA0KPiB3aGljaCBjb25uZWN0cyB0byB1c2IgMi0xLjQtcG9ydDIsIGRvZXNu
J3QgcmVwb3J0IHRoZXJlJ3MgYW55IGNoYW5nZSwNCj4gaGVuY2UgdGhlIG5lc3RlZCBodWJzIGdv
IGJhY2sgdG8gcnVudGltZSBzdXNwZW5kIGxpa2Ugbm90aGluZw0KPiBoYXBwZW5lZDoNCj4gWyAg
MjgxLjAzMjk1MV0gdXNiIHVzYjI6IHVzYiB3YWtldXAtcmVzdW1lDQo+IFsgIDI4MS4wMzI5NTld
IHVzYiB1c2IyOiB1c2IgYXV0by1yZXN1bWUNCj4gWyAgMjgxLjAzMjk3NF0gaHViIDItMDoxLjA6
IGh1Yl9yZXN1bWUNCj4gWyAgMjgxLjAzMzAxMV0gdXNiIHVzYjItcG9ydDE6IHN0YXR1cyAwMjYz
IGNoYW5nZSAwMDAwDQo+IFsgIDI4MS4wMzMwNzddIGh1YiAyLTA6MS4wOiBzdGF0ZSA3IHBvcnRz
IDQgY2hnIDAwMDAgZXZ0IDAwMDANCj4gWyAgMjgxLjA0OTc5N10gdXNiIDItMTogdXNiIHdha2V1
cC1yZXN1bWUNCj4gWyAgMjgxLjA2OTgwMF0gdXNiIDItMTogV2FpdGVkIDBtcyBmb3IgQ09OTkVD
VA0KPiBbICAyODEuMDY5ODEwXSB1c2IgMi0xOiBmaW5pc2ggcmVzdW1lDQo+IFsgIDI4MS4wNzAw
MjZdIGh1YiAyLTE6MS4wOiBodWJfcmVzdW1lDQo+IFsgIDI4MS4wNzAyNTBdIHVzYiAyLTEtcG9y
dDQ6IHN0YXR1cyAwMjAzIGNoYW5nZSAwMDAwDQo+IFsgIDI4MS4wNzAyNzJdIHVzYiB1c2IyLXBv
cnQxOiByZXN1bWUsIHN0YXR1cyAwDQo+IFsgIDI4MS4wNzAyODJdIGh1YiAyLTE6MS4wOiBzdGF0
ZSA3IHBvcnRzIDQgY2hnIDAwMTAgZXZ0IDAwMDANCj4gWyAgMjgxLjA4OTgxM10gdXNiIDItMS40
OiB1c2Igd2FrZXVwLXJlc3VtZQ0KPiBbICAyODEuMTA5NzkyXSB1c2IgMi0xLjQ6IFdhaXRlZCAw
bXMgZm9yIENPTk5FQ1QNCj4gWyAgMjgxLjEwOTgwMV0gdXNiIDItMS40OiBmaW5pc2ggcmVzdW1l
DQo+IFsgIDI4MS4xMDk5OTFdIGh1YiAyLTEuNDoxLjA6IGh1Yl9yZXN1bWUNCj4gWyAgMjgxLjEx
MDE0N10gdXNiIDItMS40LXBvcnQyOiBzdGF0dXMgMDI2MyBjaGFuZ2UgMDAwMA0KPiBbICAyODEu
MTEwMjM0XSB1c2IgMi0xLXBvcnQ0OiByZXN1bWUsIHN0YXR1cyAwDQo+IFsgIDI4MS4xMTAyMzld
IHVzYiAyLTEtcG9ydDQ6IHN0YXR1cyAwMjAzLCBjaGFuZ2UgMDAwMCwgMTAuMCBHYi9zDQo+IFsg
IDI4MS4xMTAyNjZdIGh1YiAyLTEuNDoxLjA6IHN0YXRlIDcgcG9ydHMgNCBjaGcgMDAwMCBldnQg
MDAwMA0KPiBbICAyODEuMTEwNDI2XSBodWIgMi0xLjQ6MS4wOiBodWJfc3VzcGVuZA0KPiBbICAy
ODEuMTEwNTY1XSB1c2IgMi0xLjQ6IHVzYiBhdXRvLXN1c3BlbmQsIHdha2V1cCAxDQo+IFsgIDI4
MS4xMzA5OThdIGh1YiAyLTE6MS4wOiBodWJfc3VzcGVuZA0KPiBbICAyODEuMTM3Nzg4XSB1c2Ig
Mi0xOiB1c2IgYXV0by1zdXNwZW5kLCB3YWtldXAgMQ0KPiBbICAyODEuMTQyOTM1XSBodWIgMi0w
OjEuMDogc3RhdGUgNyBwb3J0cyA0IGNoZyAwMDAwIGV2dCAwMDAwDQo+IFsgIDI4MS4xNzc4Mjhd
IHVzYiAyLTE6IHVzYiB3YWtldXAtcmVzdW1lDQo+IFsgIDI4MS4xOTc4MzldIHVzYiAyLTE6IFdh
aXRlZCAwbXMgZm9yIENPTk5FQ1QNCj4gWyAgMjgxLjE5Nzg1MF0gdXNiIDItMTogZmluaXNoIHJl
c3VtZQ0KPiBbICAyODEuMTk3OTg0XSBodWIgMi0xOjEuMDogaHViX3Jlc3VtZQ0KPiBbICAyODEu
MTk4MjAzXSB1c2IgMi0xLXBvcnQ0OiBzdGF0dXMgMDIwMyBjaGFuZ2UgMDAwMA0KPiBbICAyODEu
MTk4MjI4XSB1c2IgdXNiMi1wb3J0MTogcmVzdW1lLCBzdGF0dXMgMA0KPiBbICAyODEuMTk4MjM3
XSBodWIgMi0xOjEuMDogc3RhdGUgNyBwb3J0cyA0IGNoZyAwMDEwIGV2dCAwMDAwDQo+IFsgIDI4
MS4yMTc4MzVdIHVzYiAyLTEuNDogdXNiIHdha2V1cC1yZXN1bWUNCj4gWyAgMjgxLjIzNzgzNF0g
dXNiIDItMS40OiBXYWl0ZWQgMG1zIGZvciBDT05ORUNUDQo+IFsgIDI4MS4yMzc4NDVdIHVzYiAy
LTEuNDogZmluaXNoIHJlc3VtZQ0KPiBbICAyODEuMjM3OTkwXSBodWIgMi0xLjQ6MS4wOiBodWJf
cmVzdW1lDQo+IFsgIDI4MS4yMzgwNjddIHVzYiAyLTEuNC1wb3J0Mjogc3RhdHVzIDAyNjMgY2hh
bmdlIDAwMDANCj4gWyAgMjgxLjIzODE0OF0gdXNiIDItMS1wb3J0NDogcmVzdW1lLCBzdGF0dXMg
MA0KPiBbICAyODEuMjM4MTUyXSB1c2IgMi0xLXBvcnQ0OiBzdGF0dXMgMDIwMywgY2hhbmdlIDAw
MDAsIDEwLjAgR2Ivcw0KPiBbICAyODEuMjM4MTY2XSBodWIgMi0xLjQ6MS4wOiBzdGF0ZSA3IHBv
cnRzIDQgY2hnIDAwMDAgZXZ0IDAwMDANCj4gWyAgMjgxLjIzODM4NV0gaHViIDItMS40OjEuMDog
aHViX3N1c3BlbmQNCj4gWyAgMjgxLjIzODUyM10gdXNiIDItMS40OiB1c2IgYXV0by1zdXNwZW5k
LCB3YWtldXAgMQ0KPiBbICAyODEuMjU4MDc2XSBodWIgMi0xOjEuMDogaHViX3N1c3BlbmQNCj4g
WyAgMjgxLjI2NTc0NF0gdXNiIDItMTogdXNiIGF1dG8tc3VzcGVuZCwgd2FrZXVwIDENCj4gWyAg
MjgxLjI4NTk3Nl0gaHViIDItMDoxLjA6IGh1Yl9zdXNwZW5kDQo+IFsgIDI4MS4yODU5ODhdIHVz
YiB1c2IyOiBidXMgYXV0by1zdXNwZW5kLCB3YWtldXAgMQ0KPiANCj4gVVNCIDMuMiBzcGVjLCA5
LjIuNS40ICJDaGFuZ2luZyBGdW5jdGlvbiBTdXNwZW5kIFN0YXRlIiBzYXlzIHRoYXQgIklmDQo+
IHRoZSBsaW5rIGlzIGluIGEgbm9uLVUwIHN0YXRlLCB0aGVuIHRoZSBkZXZpY2UgbXVzdCB0cmFu
c2l0aW9uIHRoZQ0KPiBsaW5rDQo+IHRvIFUwIHByaW9yIHRvIHNlbmRpbmcgdGhlIHJlbW90ZSB3
YWtlIG1lc3NhZ2UiLCBidXQgdGhlIGh1YiBvbmx5DQo+IHRyYW5zaXRzIHRoZSBsaW5rIHRvIFUw
IGFmdGVyIHNpZ25hbGluZyByZW1vdGUgd2FrZXVwLg0KPiANCj4gU28gYmUgbW9yZSBmb3JnaXZp
bmcgYW5kIHVzZSBhIDIwbXMgZGVsYXkgdG8gbGV0IHRoZSBsaW5rIHRyYW5zaXQgdG8NCj4gVTAN
Cj4gZm9yIHJlbW90ZSB3YWtldXAuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEFsYW4gU3Rlcm4gPHN0
ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+DQo+IFNpZ25lZC1vZmYtYnk6IEthaS1IZW5nIEZlbmcg
PGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gLS0tDQo+IHYyOg0KPiAgLSBBZGQgYSBz
bWFsbCBkZWxheSBpbnN0ZWFkIG9mIHdha2luZyB1cCBhbGwgaHVicy4NCj4gDQo+ICBkcml2ZXJz
L3VzYi9jb3JlL2h1Yi5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUv
aHViLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jDQo+IGluZGV4IDAwMDcwYThhNjUwNzkuLjU3
NmZkZjJjOWYzYzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMNCj4gKysr
IGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPiBAQCAtMTExMCw3ICsxMTEwLDEwIEBAIHN0YXRp
YyB2b2lkIGh1Yl9hY3RpdmF0ZShzdHJ1Y3QgdXNiX2h1YiAqaHViLA0KPiBlbnVtIGh1Yl9hY3Rp
dmF0aW9uX3R5cGUgdHlwZSkNCj4gIAkJfSBlbHNlIHsNCj4gIAkJCWh1Yl9wb3dlcl9vbihodWIs
IHRydWUpOw0KPiAgCQl9DQo+IC0JfQ0KPiArCS8qIEdpdmUgc29tZSB0aW1lIG9uIHJlbW90ZSB3
YWtldXAgdG8gbGV0IGxpbmtzIHRvIHRyYW5zaXQgdG8NCj4gVTAgKi8NCj4gKwl9IGVsc2UgaWYg
KGh1Yl9pc19zdXBlcnNwZWVkKGh1Yi0+aGRldikpDQo+ICsJCW1zbGVlcCgyMCk7DQphZGQge30/
DQoNCj4gKw0KPiAgIGluaXQyOg0KPiAgDQo+ICAJLyoNCg==

